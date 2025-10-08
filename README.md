# 🧬 Pipeline de Descontaminação e Classificação Taxonômica com Kraken2 e Bracken

Este pipeline automatiza o processamento de dados metagenômicos, incluindo etapas de descontaminação, filtragem, classificação taxonômica e estimativa de abundância. Ele pode ser executado via script Bash (`pipeline.sh`) ou utilizando Snakemake (`Snakefile`) para maior modularidade e controle.

---

## 📋 Etapas do pipeline

1. **Descontaminação com Bowtie2**:
   - Remoção de sequências PhiX (*NC_001422.1*)
   - Remoção de contaminantes humanos (*GRCh38*)
   - Remoção de vegetais específicos (ex: *Theobroma cacao*)
   - Filtragem contra rRNAs (16S, 18S, 23S, 28S via banco SILVA)
   - Filtragem contra genomas de cloroplasto (GenBank)

2. **Classificação taxonômica com Kraken2**:
   - Construção de banco de dados com *Bacteria* e *Fungi*
   - Classificação das sequências limpas

3. **Estimativa de abundância com Bracken**:
   - Redistribuição de reads para refinamento taxonômico

---

## ⚙️ Configuração via YAML

O arquivo `config.yaml` define os parâmetros do pipeline, como caminhos de entrada, nomes de bancos, níveis taxonômicos e opções de execução. Isso permite flexibilidade sem a necessidade de editar diretamente os scripts.

---

## 🧪 Execução com Snakemake

Para rodar o pipeline com Snakemake:

```bash
snakemake --cores 8 --configfile config.yaml
