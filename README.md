# Pipeline de Descontaminação e Classificação Taxonômica com Kraken2 e Bracken

Este pipeline automatiza o processamento de dados metagenômicos, incluindo etapas de descontaminação, filtragem, classificação taxonômica e estimativa de abundância.

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

## 🛠️ Requisitos

- Máquina com as seguintes especificações:
  - Processador: Intel i5-12400F
  - GPU: NVIDIA GTX 1650 (4 GB)
  - Memória RAM: 32 GB (3200 MHz)
  - Armazenamento: 2 SSDs de 1 TB cada
- [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
- [Kraken2](https://ccb.jhu.edu/software/kraken2/)
- [Bracken](https://ccb.jhu.edu/software/bracken/)
- Bash (Linux ou WSL)
- Espaço em disco: **>250 GB** recomendado para construção e uso do banco de dados

## 📦 Tamanho do banco de dados

O banco de dados Kraken2 personalizado, construído com sequências dos domínios *Bacteria* e *Fungi*, ocupa aproximadamente **250 GB** após a compilação. Esse volume reflete a abrangência taxonômica e a complexidade genômica dos grupos selecionados. Recomenda-se o uso de discos SSD e espaço em disco superior a 300 GB para garantir desempenho e evitar falhas durante o processamento.

## 🚀 Como executar

Clone o repositório e execute o script principal:

```bash
git clone https://github.com/luanferreirabio-oss/descontaminacao-Bracken.git
cd descontaminacao-Bracken
bash pipeline.sh

