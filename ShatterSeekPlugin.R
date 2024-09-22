library(ShatterSeek)
data(DO17373)

dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")


input <- function(inputfile) {
        pfix <<- prefix()
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1];
}

run <- function() {}

output <- function(outputfile) {
pdf(outputfile)
SV_DO17373 <- readRDS(paste(pfix, parameters["SV", 2], sep="/"))
SCNA_DO17373 <- readRDS(paste(pfix, parameters["SCNA", 2], sep="/"))
SV_data <- SVs(chrom1=as.character(SV_DO17373$chrom1),
pos1=as.numeric(SV_DO17373$start1),
chrom2=as.character(SV_DO17373$chrom2),
pos2=as.numeric(SV_DO17373$end2),
SVtype=as.character(SV_DO17373$svclass),
strand1=as.character(SV_DO17373$strand1),
strand2=as.character(SV_DO17373$strand2))
CN_data <- CNVsegs(chrom=as.character(SCNA_DO17373$chromosome),
start=SCNA_DO17373$start,
end=SCNA_DO17373$end,
total_cn=SCNA_DO17373$total_cn)
chromothripsis <- shatterseek(SV.sample=SV_data, seg.sample=CN_data)
plots_chr3 = plot_chromothripsis(ShatterSeek_output = chromothripsis,chr = "3", sample_name="DO17373")
}
