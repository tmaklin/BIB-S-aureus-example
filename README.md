# BIB *Staphylococcus aureus* tutorial

Example of using BIB to identify *Staphylococcus aureus* strains.

## External software required to run the tutorial
1. [progressiveMauve and stripSubsetLCBs](http://darlinglab.org/mauve/download.html).
2. [hierBAPS](http://www.helsinki.fi/bsg/software/BAPS/)
3. [bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
4. [BitSeq](https://bitseq.github.io/)
5. [BIB](https://github.com/PROBIC/BIB)

## Tutorial

Steps 1.-6. can take up to an hour to run. The end result ```ref_seqs_gapless.fasta``` file is provided if you wish to skip the steps.

The example read file ```SRR016122.fastq.gz``` can be downloaded from the [European Nucleotide Archive](https://www.ebi.ac.uk/ena/data/view/SRR016122).

1. Obtain the full alignment of the assemblies.
> progressiveMauve --output=full_alignment.xmfa saur_assemblies.fasta
2. Extract LCBs shared by all genomes. The first number "500" is the
   minimum length of the LCB; the second number "4" indicates the
   minimum number of genomes that share an LCB.
> stripSubsetLCBs full_alignment.xmfa full_alignment.xmfa.bbcols core_alignment.xmfa 500 4
3. Concatenate all the LCBs.
> perl xmfa2fasta.pl --file core_alignment.xmfa > core_alignment.fasta
4. Run hierBAPS to obtain a clustering with "1" level and a maximum of "10" clusters. The clustering is stored in the ```results.partition.txt``` file. Sequences ">1" and ">2" belong to cluster 1; sequences ">3" and ">4" to cluster 2.
> hierBAPS.sh exData core_alignment.fasta fasta
> hierBAPS.sh hierBAPS seqs.mat 1 10 results
5. Select sequences ">1" and ">3" to represent the clusters using ```fastagrep.sh``` from the BitSeq package.
> fastagrep.sh ">1 " core_alignment.fasta > ref_seqs.fasta
> fastagrep.sh ">3 " core_alignment.fasta >> ref_seqs.fasta
6. Remove gaps from the reference sequences.
> sed 's/-//g' ref_seqs.fasta > ref_seqs_gapless.fasta
7. Build the alignment index.
> python BIB_prepare_index.py ref_seqs_gapless.fasta reference_alignment_index
8. Perform the read alignment and abundance estimation.
> python BIB_analyse_reads.py SRR016122.fastq.gz ref_seqs_gapless.fasta reference_alignment_index SRR016122_abundances
