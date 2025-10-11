# 🧬 Pipeline Metagenômico Manual

Este repositório contém um pipeline completo para pré-processamento de dados metagenômicos, executado manualmente em ambiente local com recursos limitados (baixa RAM). O objetivo foi filtrar, descontaminar e preparar amostras para análise taxonômica e montagem genômica.

---

## 📁 Estrutura do projeto

dados_brutos/ # Arquivos originais (.fastq.gz) 
dados_filtrados/ # Arquivos filtrados e descontaminados 
projeto_metagenoma/ ├── indices/ # Índices Bowtie2 para descontaminação └── resultados/logs/ # Relatórios Fastp (.json, .html) 
relatorios_fastp/ # Relatórios consolidados para MultiQC 
relatorios_multiqc/ # Relatório final MultiQC 
pipeline_manual.sh # Script principal do pipeline


---


---

## ⚙️ Ferramentas utilizadas

- [Fastp](https://github.com/OpenGene/fastp) — filtragem de qualidade
- [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml) — alinhamento e descontaminação
- [Pigz](https://zlib.net/pigz/) — compressão paralela
- [MultiQC](https://multiqc.info/) — relatório consolidado

---

## 🧠 Etapas do pipeline

1. **Filtragem com Fastp**  
   - Remoção de reads com baixa qualidade, N, tamanho curto  
   - Geração de relatórios `.html` e `.json`

2. **Descontaminação com Bowtie2**  
   - Remoção sequencial contra: humano, PhiX, rRNA, cacau, cloroplasto  
   - Apenas reads não alinhados são mantidos

3. **Compressão com Pigz**  
   - Arquivos finais `.fastq` são comprimidos para `.fastq.gz`

4. **Relatório MultiQC**  
   - Consolidação dos relatórios Fastp em um único arquivo interativo

---

🧬 Amostras utilizadas

As amostras foram obtidas de solos de várzea sob cultivo de cacau e estão disponíveis publicamente no NCBI:

    BioProject: PRJNA1224407
    
    Amostras: P1, P2, P3, P4, P5

Tipo de dados: Shotgun - Sequenciamento metagenômico pareado (paired-end)

## 🚀 Como executar

1. Instale as ferramentas necessárias (Fastp, Bowtie2, Pigz, MultiQC)
2. Organize os arquivos conforme a estrutura acima
3. Execute o script principal:

```bash
bash pipeline_manual.sh


```bash
bash pipeline_manual.sh
