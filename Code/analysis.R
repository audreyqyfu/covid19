# read in count data
counts <- read.delim ("counts.txt", header=TRUE, row.names=1)
counts.hubei <- read.delim ("counts_Hubei.txt", header=TRUE, row.names=1)
counts.wuhan <- read.delim ("counts_Wuhan_corrected.txt", header=TRUE, row.names=1)

# extract data for Hubei Province but no Wuhan
counts.hubei.nowuhan <- counts.hubei[(which(counts.hubei$Day==20)):nrow(counts.hubei), 2:5] - counts.wuhan[(which(counts.wuhan$Day==20)):nrow(counts.wuhan), 2:5]

# extract data for mainland China outside Hubei
counts.nohubei <- counts[(which(counts$Day==20)):nrow(counts), 2:5] - counts.hubei[(which(counts.hubei$Day==20)):nrow(counts.hubei), 2:5]

####################################
# death rate
####################################
death.rate.wuhan <- counts.wuhan$Deaths[(which(counts.wuhan$Day==20)):nrow(counts.wuhan)] / counts.wuhan$Cases[(which(counts.wuhan$Day==20)):nrow(counts.wuhan)]

death.rate.hubei.nowuhan <- counts.hubei.nowuhan$Deaths / counts.hubei.nowuhan$Cases

death.rate.nohubei <- counts.nohubei$Deaths / counts.nohubei$Cases

summary (death.rate.wuhan)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#0.02326 0.04775 0.05451 0.05361 0.05999 0.09026
summary (death.rate.hubei.nowuhan)
#    Min.  1st Qu.   Median     Mean  3rd Qu.     Max.
#0.000000 0.009552 0.014099 0.011349 0.014342 0.018519
summary (death.rate.nohubei)
#    Min.  1st Qu.   Median     Mean  3rd Qu.     Max.
#0.000000 0.001708 0.002316 0.002204 0.003180 0.004334

ndays <- length (death.rate.wuhan)
par (mar=c(6.5, 5, 3.5, 1))
# Plot_death_rates_vs_time.pdf
plot (1:ndays, death.rate.wuhan*100, type="b", ylim=c(-0.5, 10), pch=16, cex=1.6, xlab="", ylab="Death rate in confirmed cases (%)", cex.axis=1.6, cex.lab=1.6, xaxt="n")
title ("Death Rate of Wuhan New Coronavirus Outbreak", cex.main=2)
axis (side=1, at=1:ndays, labels=FALSE, cex.axis=1.6)
text (1:ndays, par("usr")[3]-0.8, labels=rownames (counts.nohubei), srt=45, cex=1.6, pos=1, xpd=TRUE)
points (1:ndays, death.rate.hubei.nowuhan*100, type="b", pch=16, cex=1.6, col="red")
points (1:ndays, death.rate.nohubei*100, type="b", pch=16, cex=1.6, col="blue")
legend (9, 8.5, bty="n", legend=c("Wuhan", "Hubei Province excluding Wuhan", "mainland China excluding Hubei"), pch=16, cex=1.6, lty=1, col=c("black", "red", "blue"))
abline (a=9.6, b=0, lty=2, col="#cc66ff", lwd=2.5)
abline (a=0.13, b=0, lty=2, col="#cf9500", lwd=2.5)
text (13, 9.3, labels="2002-03 SARS", col=c("#cc66ff"), cex=1.6)
text (13, -0.4, labels="2016-17 influenza in US", col=c("#cf9500"), cex=1.6)

####################################
# rate of severe cases
####################################
# not including deaths
severity.rate.hubei <- counts.hubei$Severe[(which(counts.hubei$Day==23)):nrow(counts.hubei)] / counts.hubei$Cases[(which(counts.hubei$Day==23)):nrow(counts.hubei)]

severity.rate.nohubei <- counts.nohubei$Severe[-(1:3)] / counts.nohubei$Cases[-(1:3)]

summary (severity.rate.nohubei)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#0.09326 0.10684 0.12584 0.13259 0.14723 0.21127
summary (severity.rate.hubei)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
# 0.1226  0.1687  0.1961  0.1960  0.2203  0.2542

ndays.severe <- length (severity.rate.hubei)
# Plot_severity_rates_vs_time.pdf
plot (1:ndays.severe, severity.rate.hubei*100, type="b", ylim=c(0, 30), pch=16, cex=1.6, xlab="", ylab="Rate of severe cases (no deaths) in confirmed cases (%)", cex.axis=1.6, cex.lab=1.6, col="red", xaxt="n")
title ("Rate of Severe Cases in Wuhan New Coronavirus Outbreak", cex.main=2)
axis (side=1, at=1:ndays, labels=FALSE, cex.axis=1.6)
text (1:ndays.severe, par("usr")[3]-2, labels=rownames (counts.nohubei)[-(1:3)], srt=45, cex=1.6, pos=1, xpd=TRUE)
points (1:ndays.severe, severity.rate.nohubei*100, type="b", pch=16, cex=1.6, col="blue")
legend (8, 6, bty="n", legend=c("Hubei Province", "mainland China excluding Hubei"), pch=16, cex=1.6, lty=1, col=c("red", "blue"))


severity.rate2.hubei <- (counts.hubei$Severe[(nrow(counts.hubei)-8):nrow(counts.hubei)] + counts.hubei$Deaths[(nrow(counts.hubei)-8):nrow(counts.hubei)]) / counts.hubei$Cases[(nrow(counts.hubei)-8):nrow(counts.hubei)]

severity.rate2.nohubei <- (counts.nohubei$Severe[(nrow(counts.nohubei)-8):nrow(counts.nohubei)] + counts.nohubei$Deaths[(nrow(counts.nohubei)-8):nrow(counts.nohubei)]) / counts.nohubei$Cases[(nrow(counts.nohubei)-8):nrow(counts.nohubei)]

# Plot_severity_rates2_vs_time.pdf
plot (23:31, severity.rate2.hubei*100, type="b", xlim=c(23, 31), ylim=c(0, 30), pch=16, cex=1.6, xlab="Day of January 2020", ylab="Rate of severe cases (no deaths) in confirmed cases (%)", cex.axis=1.6, cex.lab=1.6, col="red", xaxt="n")
title ("Rate of Severe Cases", cex.main=2)
axis (side=1, at=23:31, cex.axis=1.6)
points (23:31, severity.rate2.nohubei*100, type="b", pch=16, cex=1.6, col="blue")
legend (28, 6, bty="n", legend=c("Hubei Province", "mainland China excluding Hubei"), pch=16, cex=1.6, lty=1, col=c("red", "blue"))

# deaths among severe cases
severity.rate3.hubei <- counts.hubei$Deaths[(which(counts.hubei$Day==23)):nrow(counts.hubei)] / (counts.hubei$Severe[(which(counts.hubei$Day==23)):nrow(counts.hubei)] + counts.hubei$Deaths[(which(counts.hubei$Day==23)):nrow(counts.hubei)])

severity.rate3.nohubei <- counts.nohubei$Deaths[-(1:3)] / (counts.nohubei$Severe[-(1:3)] + counts.nohubei$Deaths[-(1:3)])

summary (severity.rate3.hubei)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
# 0.1221  0.1529  0.1599  0.1708  0.1777  0.2873
summary (severity.rate3.nohubei)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#0.01677 0.01922 0.02027 0.02015 0.02052 0.02439

ndays.severe.death <- length (severity.rate3.hubei)
# Plot_death_rates_in_severe_cases_vs_time.pdf
plot (1:ndays.severe.death, severity.rate3.hubei*100, type="b", ylim=c(0, 35), pch=16, cex=1.6, xlab="", ylab="Death rate among severe and death cases (%)", cex.axis=1.6, cex.lab=1.6, col="red", xaxt="n")
title ("Death Rate Among Severe and Death Cases", cex.main=2)
axis (side=1, at=1:ndays, labels=FALSE, cex.axis=1.6)
text (1:ndays.severe.death, par("usr")[3]-2.5, labels=rownames (counts.nohubei)[-(1:3)], srt=45, cex=1.6, pos=1, xpd=TRUE)
points (1:ndays.severe.death, severity.rate3.nohubei*100, type="b", pch=16, cex=1.6, col="blue")
legend (8, 8, bty="n", legend=c("Hubei Province", "mainland China excluding Hubei"), pch=16, cex=1.6, lty=1, col=c("red", "blue"))
