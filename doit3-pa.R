#! /usr/bin/env Rscript
#! /usr/bin/env shebang-R

#options(echo=T)

args <- commandArgs(TRUE)
if ( length(args) != 1 ) {
  print("Usage: SCRIPT_NAME DIR")
  q(save='no',status=1)
}

dir <-args[1]

data <- read.delim(paste(dir,"gene_presence_absence.Rtab",sep="/"), row.names=1); # with row names
data <- t(data)
##dists <- dist(data, method = "euclidean");
dists <- dist(data, method = "binary");
##write.table(as.matrix(dists), file="results.tsv", sep="\t", quote = FALSE, col.names=TRUE, row.names=TRUE);

write.table(100*(1-as.matrix(dists)), 
            sep="\t", quote = FALSE, 
            file=paste(dir,"results.tsv",sep="/"), 
            col.names=TRUE, row.names=TRUE);

hc <- hclust(dists, method = "ward.D2");


plot(as.dendrogram(hc), horiz=TRUE);

library("ape");
write.tree(as.phylo(hc),file=paste(dir,"results.fig",sep="/"))

q(save='no',status=0)
