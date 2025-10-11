#!/bin/bash

# ============================
# CONFIGURAÇÃO INICIAL
# ============================

RAW_DIR="dados_brutos"
FILTERED_DIR="dados_filtrados"
LOG_DIR="projeto_metagenoma/resultados/logs"
INDEX_DIR="projeto_metagenoma/indices"

mkdir -p "$FILTERED_DIR" "$LOG_DIR"

# Detecta automaticamente todas as amostras com arquivos _R1.fastq.gz
SAMPLES=($(ls "$RAW_DIR" | grep "_R1.fastq.gz" | sed 's/_R1.fastq.gz//' | sort | uniq))

# Índices Bowtie2 para descontaminação
CONTAMINANTES=("human_index" "phix_index" "ribosomal_index" "cacao_index" "chloroplast_index")

# ============================
# ETAPA 1: FASTP (Filtragem de qualidade)
# ============================

for SAMPLE in "${SAMPLES[@]}"; do
  OUT_R1="$FILTERED_DIR/${SAMPLE}_step1_R1.fastq.gz"
  OUT_R2="$FILTERED_DIR/${SAMPLE}_step1_R2.fastq.gz"

  if [[ -f "$OUT_R1" && -f "$OUT_R2" ]]; then
    echo "✅ Fastp já foi executado para $SAMPLE. Pulando..."
  else
    echo "🔬 Rodando Fastp para $SAMPLE com 1 core..."
    fastp \
      -i "$RAW_DIR/${SAMPLE}_R1.fastq.gz" \
      -I "$RAW_DIR/${SAMPLE}_R2.fastq.gz" \
      -o "$OUT_R1" \
      -O "$OUT_R2" \
      --html "$LOG_DIR/${SAMPLE}_fastp.html" \
      --json "$LOG_DIR/${SAMPLE}_fastp.json" \
      --report_title "Fastp Report - $SAMPLE" \
      --thread 1
  fi
done

# ============================
# ETAPA 2: BOWTIE2 (Descontaminação)
# ============================

for SAMPLE in "${SAMPLES[@]}"; do
  FINAL_R1="$FILTERED_DIR/${SAMPLE}_step4_R1.fastq.gz"
  FINAL_R2="$FILTERED_DIR/${SAMPLE}_step4_R2.fastq.gz"

  if [[ -f "$FINAL_R1" && -f "$FINAL_R2" ]]; then
    echo "✅ Arquivos finais já existem para $SAMPLE. Pulando descontaminação..."
  else
    echo "🧹 Iniciando descontaminação para $SAMPLE..."

    INPUT_R1="$FILTERED_DIR/${SAMPLE}_step1_R1.fastq.gz"
    INPUT_R2="$FILTERED_DIR/${SAMPLE}_step1_R2.fastq.gz"

    for CONTAM in "${CONTAMINANTES[@]}"; do
      OUT_PREFIX="$FILTERED_DIR/${SAMPLE}_step_${CONTAM}"

      if [[ -f "${OUT_PREFIX}.1.fastq" && -f "${OUT_PREFIX}.2.fastq" ]]; then
        echo "✅ Etapa $CONTAM já feita para $SAMPLE. Pulando..."
        INPUT_R1="${OUT_PREFIX}.1.fastq"
        INPUT_R2="${OUT_PREFIX}.2.fastq"
      else
        echo "🚫 Removendo contaminante: $CONTAM para $SAMPLE..."
        bowtie2 \
          -x "$INDEX_DIR/$CONTAM" \
          -1 "$INPUT_R1" \
          -2 "$INPUT_R2" \
          --un-conc "$OUT_PREFIX.fastq" \
          -S /dev/null \
          --threads 1

        INPUT_R1="${OUT_PREFIX}.1.fastq"
        INPUT_R2="${OUT_PREFIX}.2.fastq"
      fi
    done

    echo "📦 Renomeando e comprimindo arquivos finais de $SAMPLE..."
    mv "$INPUT_R1" "$FILTERED_DIR/${SAMPLE}_step4_R1.fastq"
    mv "$INPUT_R2" "$FILTERED_DIR/${SAMPLE}_step4_R2.fastq"
    pigz "$FILTERED_DIR/${SAMPLE}_step4_R1.fastq"
    pigz "$FILTERED_DIR/${SAMPLE}_step4_R2.fastq"
  fi
done

# ============================
# ETAPA 3: MULTIQC (Relatório consolidado)
# ============================

echo "📊 Gerando relatório MultiQC..."

mkdir -p relatorios_fastp relatorios_multiqc

# Copia os relatórios Fastp se ainda não estiverem lá
find "$LOG_DIR" -type f -name "*fastp*.json" -exec cp -u {} relatorios_fastp/ \;

multiqc relatorios_fastp/ -o relatorios_multiqc/
