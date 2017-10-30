## Locate required software
mauve_path=$(locate progressiveMauve)
strip_path=$(locate stripSubsetLCBs)
xmfa2fasta_path=$(locate xmfa2fasta.pl)
hierBAPS_path=$(locate hierBAPS.sh)
fastagrep_path=$(locate fastagrep.sh)
BIB_prepare_index_path=$(locate BIB_prepare_index.py)
BIB_analyse_reads_path=$(locate BIB_analyse_reads.py)

## Step 1
echo "Performing sequence alignment for assemblies"
$mauve_path --output=data/full_alignment.xmfa data/saur_assemblies.fasta

## Step 2
echo "Extracting LCBs"
$strip_path data/full_alignment.xmfa data/full_alignment.xmfa.bbcols data/core_alignment.xmfa 500 4

## Step 3
echo "Converting from xmfa to fasta"
$xmfa2fasta_path --file data/core_alignment.xmfa > data/core_alignment.fasta

## Step 4
echo "Clustering reference sequences"
$hierBAPS_path exData data/core_alignment.fasta fasta
$hierBAPS_path hierBAPS data/seqs.mat 1 10 data/results

## Step 5
echo "Selecting representative sequences"
$fastagrep_path ">1 " data/core_alignment.fasta > data/ref_seqs.fasta
$fastagrep_path ">3 " data/core_alignment.fasta >> data/ref_seqs.fasta

## Step 6
echo "Removing gaps from the reference"
sed 's/-//g' data/ref_seqs.fasta > data/ref_seqs_gapless.fasta

## Step 7
echo "Building alignment index"
python $BIB_prepare_index_path data/ref_seqs_gapless.fasta reference_alignment_index

## Step 7.5
echo "Downloading reads"
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR016/SRR016122/SRR016122.fastq.gz

## Step 8
echo "Aligning reads and estimating relative abundances"
python $BIB_analyse_reads_path SRR016122.fastq.gz data/ref_seqs_gapless.fasta reference_alignment_index SRR016122_abundances
