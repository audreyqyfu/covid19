# read in count data
counts <- read.delim ("counts.txt", header=TRUE, row.names=1)
counts.hubei <- read.delim ("counts_Hubei.txt", header=TRUE, row.names=1)
counts.wuhan <- read.delim ("counts_Wuhan_corrected.txt", header=TRUE, row.names=1)

# extract data for Hubei Province but no Wuhan
counts.hubei.nowuhan <- counts.hubei[(which(counts.hubei$Day==20)):nrow(counts.hubei), c(2:5, 14)] - counts.wuhan[(which(counts.wuhan$Day==20)):nrow(counts.wuhan), c(2:5,7)]

# extract data for mainland China outside Hubei
counts.nohubei <- counts[(which(counts$Day==20)):nrow(counts), c(2:5,10)] - counts.hubei[(which(counts.hubei$Day==20)):nrow(counts.hubei), c(2:5,14)]

####################################
# death rate
####################################
death.rate.wuhan <- counts.wuhan$Deaths[(which(counts.wuhan$Day==20)):nrow(counts.wuhan)] / counts.wuhan$Cases[(which(counts.wuhan$Day==20)):nrow(counts.wuhan)]

death.rate.hubei.nowuhan <- counts.hubei.nowuhan$Deaths / counts.hubei.nowuhan$Cases

death.rate.nohubei <- counts.nohubei$Deaths / counts.nohubei$Cases

summary (death.rate.wuhan)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#0.02326 0.03795 0.04153 0.04581 0.05453 0.09026
summary (death.rate.hubei.nowuhan)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#0.00000 0.01351 0.01419 0.01416 0.01794 0.02369
summary (death.rate.nohubei)
#    Min.  1st Qu.   Median     Mean  3rd Qu.     Max.
#0.000000 0.001870 0.002960 0.002936 0.003884 0.005984

ndays <- length (death.rate.wuhan)
par (mar=c(6.8, 5, 3.5, 1))
# Plot_death_rates_vs_time.pdf
plot (1:ndays, death.rate.wuhan*100, type="b", ylim=c(-0.5, 10), pch=16, cex=1.6, xlab="", ylab="Death rate in confirmed cases (%)", cex.axis=1.6, cex.lab=1.6, xaxt="n", yaxt="n")
title ("Death Rate of COVID-19 Outbreak in Mainland China", cex.main=2)
axis (side=1, at=1:ndays, labels=FALSE, cex.axis=1.6)
axis (side=2, at=c(0, 0.5, 1:10), labels=c(0, 0.5, 1:10), cex.axis=1.6, las=1)
text (1:ndays, par("usr")[3]-1.1, labels=rownames (counts.nohubei), srt=65, cex=1.6, pos=1, offset=-0.50, xpd=TRUE)
for (i in 0:10) {
    abline (a=i, b=0, lty=1, col="#cac0c0")
}
abline (a=9.6, b=0, lty=2, col="#cc66ff", lwd=2.5)
abline (a=0.13, b=0, lty=2, col="#cf9500", lwd=2.5)
abline (a=1, b=0, lty=4, col="#00cc99", lwd=2.5)
abline (a=0.5, b=0, lty=4, col="#00cc99", lwd=2.5)
abline (a=4, b=0, lty=4, col="#00cc99", lwd=2.5)
points (1:ndays, death.rate.wuhan*100, type="b", pch=16, cex=1.6, col="black")
points (1:ndays, death.rate.hubei.nowuhan*100, type="b", pch=16, cex=1.6, col="red")
points (1:ndays, death.rate.nohubei*100, type="b", pch=16, cex=1.6, col="blue")
legend (ndays-9, 8.5, bty="n", legend=c("Wuhan", "Hubei Province excluding Wuhan", "mainland China excluding Hubei"), pch=16, cex=1.6, lty=1, col=c("black", "red", "blue"))
text (ndays-6, 9.3, labels="2002-03 SARS (9.6%)", col=c("#cc66ff"), cex=1.6)
text (ndays-6, -0.4, labels="2016-17 influenza in US (0.13%)", col=c("#cf9500"), cex=1.6)
text (10, 3.5, labels="WHO-Imperial estimate: 1% (95% CI: 0.5-4%)", col=c("#00cc99"), cex=1.6)

####################################
# confirmed cases
####################################
ndays <- length (death.rate.wuhan)
par (mar=c(6.8, 5, 3.5, 1))
# Plot_death_rates_vs_time.pdf
plot (1:ndays, log10(counts.wuhan$Cases[(which(counts.wuhan$Day==20)):nrow(counts.wuhan)]), ylim=c(1, 5), type="b", pch=16, cex=1.6, xlab="", ylab="Confirmed cases", cex.axis=1.6, cex.lab=1.6, xaxt="n", yaxt="n")
title ("Confirmed COVID-19 Cases in Mainland China", cex.main=2)
axis (side=1, at=1:ndays, labels=FALSE, cex.axis=1.6)
axis (side=2, at=1:5, labels=c(10, 100, '1K', '10K', '100K'), cex.axis=1.6, las=1)
text (1:ndays, par("usr")[3], labels=rownames (counts.nohubei), srt=65, cex=1.6, pos=1, offset=3, xpd=TRUE)
for (i in 1:5) {
    abline (a=i, b=0, lty=1, col="#cac0c0")
}
points (1:ndays, log10(counts.wuhan$Cases[(which(counts.wuhan$Day==20)):nrow(counts.wuhan)]), type="b", pch=16, cex=1.6, col="black")
points (1:ndays, log10(counts.hubei.nowuhan$Cases), type="b", pch=16, cex=1.6, col="red")
points (1:ndays, log10(counts.nohubei$Cases), type="b", pch=16, cex=1.6, col="blue")
legend (ndays-9, 3, bty="n", legend=c("Wuhan", "Hubei Province excluding Wuhan", "mainland China excluding Hubei"), pch=16, cex=1.6, lty=1, col=c("black", "red", "blue"))

####################################
# deaths
####################################
par (mar=c(6.8, 6, 3.5, 1))
plot (1:ndays, counts.wuhan$Deaths[(which(counts.wuhan$Day==20)):nrow(counts.wuhan)], type="b", pch=16, cex=1.6, ylim=c(0,1600), xlab="", ylab="", cex.axis=1.6, cex.lab=1.6, xaxt="n", yaxt="n")
title ("COVID-19 Deaths in Mainland China", cex.main=2)
axis (side=1, at=1:ndays, labels=FALSE, cex.axis=1.6)
axis (side=2, at=(0:8)*200, labels=(0:8)*200, cex.axis=1.6, las=1)
text (1:ndays, par("usr")[3], labels=rownames (counts.nohubei), srt=65, cex=1.6, pos=1, offset=3, xpd=TRUE)
for (i in 0:8) {
    abline (a=i*200, b=0, lty=1, col="#cac0c0")
}
points (1:ndays, counts.hubei.nowuhan$Deaths, type="b", pch=16, cex=1.6, col="red")
points (1:ndays, counts.nohubei$Deaths, type="b", pch=16, cex=1.6, col="blue")
legend (1, 1300, bty="n", legend=c("Wuhan", "Hubei Province excluding Wuhan", "mainland China excluding Hubei"), pch=16, cex=1.6, lty=1, col=c("black", "red", "blue"))

####################################
# rate of severe cases
####################################
# not including deaths
severity.rate.hubei <- counts.hubei$Severe[(which(counts.hubei$Day==23)):nrow(counts.hubei)] / counts.hubei$Cases[(which(counts.hubei$Day==23)):nrow(counts.hubei)]

severity.rate.nohubei <- counts.nohubei$Severe[-(1:3)] / counts.nohubei$Cases[-(1:3)]

severity.rate.nohubei.cc <- counts.nohubei$Severe / counts.nohubei$CurrentlyConfirmed
severity.rate.hubei.nowuhan.cc <- counts.hubei.nowuhan$Severe / counts.hubei.nowuhan$CurrentlyConfirmed
severity.rate.hubei.cc <- counts.hubei$Severe / counts.hubei$CurrentlyConfirmed
severity.rate.wuhan.cc <- counts.wuhan$Severe / counts.wuhan$CurrentlyConfirmed

summary (severity.rate.nohubei)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#0.07150 0.09061 0.09385 0.10950 0.12404 0.21127
summary (severity.rate.hubei)
#  Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#0.1226  0.1687  0.1862  0.1892  0.2100  0.2542

ndays.severe <- length (severity.rate.hubei)
ndays.back <- 6
# Plot_severity_rates_vs_time.pdf
plot (1:ndays.severe, severity.rate.hubei*100, type="b", ylim=c(0, 30), pch=16, cex=1.6, xlab="", ylab="Rate of severe cases (no deaths) in confirmed cases (%)", cex.axis=1.6, cex.lab=1.6, col="#d68d20", xaxt="n")
title ("Rate of Severe Cases in COVID-19 Outbreak in Mainland China", cex.main=2)
axis (side=1, at=1:ndays, labels=FALSE, cex.axis=1.6)
text (1:ndays.severe, par("usr")[3]-2.5, labels=rownames (counts.nohubei)[-(1:3)], srt=65, cex=1.6, pos=1, xpd=TRUE)
for (i in 0:6) {
    abline (a=i*5, b=0, lty=1, col="#cac0c0")
}
points (1:ndays.severe, severity.rate.nohubei*100, type="b", pch=16, cex=1.6, col="blue")
points ((ndays.severe-ndays.back):ndays.severe, severity.rate.hubei.cc[(length (severity.rate.hubei.cc)-ndays.back):length (severity.rate.hubei.cc)]*100, type="b", pch=15, cex=1.6, col="#d68d20")
points ((ndays.severe-ndays.back):ndays.severe, severity.rate.nohubei.cc[(length (severity.rate.nohubei.cc)-ndays.back):length (severity.rate.nohubei.cc)]*100, type="b", pch=15, cex=1.6, col="blue")
points ((ndays.severe-ndays.back):ndays.severe, severity.rate.hubei.nowuhan.cc[(length (severity.rate.hubei.nowuhan.cc)-ndays.back):length (severity.rate.hubei.nowuhan.cc)]*100, type="b", pch=15, cex=1.6, col="red")
points ((ndays.severe-ndays.back):ndays.severe, severity.rate.wuhan.cc[(length (severity.rate.wuhan.cc)-ndays.back):length (severity.rate.wuhan.cc)]*100, type="b", pch=15, cex=1.6, col="black")
legend (6, 7, bty="n", legend=c("among cumulatively confirmed", "Hubei", "mainland China excluding Hubei"), pch=16, cex=1.6, lty=1, col=c("white", "#d68d20", "blue"))
legend (15, 7, bty="n", legend=c("among currently confirmed", "Wuhan", "Hubei excluding Wuhan", "Hubei including Wuhan", "mainland China excluding Hubei"), pch=15, cex=1.6, lty=1, col=c("white", "black", "red", "#d68d20", "blue"))


severity.rate2.hubei <- (counts.hubei$Severe[(nrow(counts.hubei)-8):nrow(counts.hubei)] + counts.hubei$Deaths[(nrow(counts.hubei)-8):nrow(counts.hubei)]) / counts.hubei$Cases[(nrow(counts.hubei)-8):nrow(counts.hubei)]

severity.rate2.nohubei <- (counts.nohubei$Severe[(nrow(counts.nohubei)-8):nrow(counts.nohubei)] + counts.nohubei$Deaths[(nrow(counts.nohubei)-8):nrow(counts.nohubei)]) / counts.nohubei$Cases[(nrow(counts.nohubei)-8):nrow(counts.nohubei)]

# Plot_severity_rates2_vs_time.pdf
plot (23:31, severity.rate2.hubei*100, type="b", xlim=c(23, 31), ylim=c(0, 30), pch=16, cex=1.6, xlab="Day of January 2020", ylab="Rate of severe cases (no deaths) in confirmed cases (%)", cex.axis=1.6, cex.lab=1.6, col="red", xaxt="n")
title ("Rate of Severe Cases", cex.main=2)
axis (side=1, at=23:31, cex.axis=1.6)
points (23:31, severity.rate2.nohubei*100, type="b", pch=16, cex=1.6, col="blue")
legend (28, 6, bty="n", legend=c("Hubei Province", "mainland China excluding Hubei"), pch=16, cex=1.6, lty=1, col=c("red", "blue"))

####################################
# severe cases
####################################
plot (1:ndays.severe, log10(counts.hubei$Severe[(which(counts.hubei$Day==23)):nrow(counts.hubei)]), type="b", pch=16, cex=1.6, ylim=c(1,5), xlab="", ylab="", cex.axis=1.6, cex.lab=1.6, col="#d68d20", xaxt="n", yaxt="n")
title ("Number of Severe Cases (Excluding Deaths) in COVID-19 Outbreak in Mainland China", cex.main=2)
axis (side=1, at=1:ndays, labels=FALSE, cex.axis=1.6)
axis (side=2, at=1:5, labels=c(10, 100, '1K', '10K', '100K'), cex.axis=1.6, las=1)
text (1:ndays.severe, par("usr")[3], labels=rownames (counts.nohubei)[-(1:3)], srt=65, cex=1.6, pos=1, offset=3, xpd=TRUE)
for (i in 1:5) {
    abline (a=i, b=0, lty=1, col="#cac0c0")
}
points (1:ndays.severe, log10(counts.nohubei$Severe[-(1:3)]), type="b", pch=16, cex=1.6, col="blue")
legend (ndays.severe-9, 2, bty="n", legend=c("Hubei", "mainland China excluding Hubei"), pch=16, cex=1.6, lty=1, col=c("#d68d20", "blue"))

####################################
# death rate among severe cases
####################################
# deaths among severe cases from previous day
severity.rate3.hubei <- diff (counts.hubei$Deaths[(which(counts.hubei$Day==23)):nrow(counts.hubei)]) / counts.hubei$Severe[(which(counts.hubei$Day==23)):(nrow(counts.hubei)-1)]

severity.rate3.nohubei <- diff (counts.nohubei$Deaths[(which(rownames (counts.nohubei)=='20200123')):nrow(counts.nohubei)]) / counts.nohubei$Severe[(which(rownames (counts.nohubei)=='20200123')):(nrow(counts.nohubei)-1)]

ndays.severe.death <- length (severity.rate3.hubei)
# Plot_death_rates_among_severe_cases_vs_time_20200216.pdf
plot (1:ndays.severe.death, severity.rate3.hubei*100, type="b", pch=16, cex=1.6, xlab="", ylab="Rate of deaths in severe cases (%)", cex.axis=1.6, cex.lab=1.6, ylim=c(0,20), col="#d68d20", xaxt="n")
title ("Death Rate Among Severe Cases in COVID-19 Outbreak in Mainland China", cex.main=2)
axis (side=1, at=1:ndays.severe.death, labels=FALSE, cex.axis=1.6)
text (1:ndays.severe.death, par("usr")[3], labels=rownames (counts.nohubei)[(which(rownames (counts.nohubei)=='20200123')):(nrow(counts.nohubei)-1)], srt=65, cex=1.6, pos=1, offset=3, xpd=TRUE)
for (i in 0:20) {
    abline (a=i, b=0, lty=1, col="#cac0c0")
}
points (1:ndays.severe.death, severity.rate3.nohubei*100, type="b", pch=16, cex=1.6, col="blue")


# old way of calculating the death rate
# among severe cases
#
# deaths among severe cases
severity.rate3.hubei <- counts.hubei$Deaths[(which(counts.hubei$Day==23)):nrow(counts.hubei)] / (counts.hubei$Severe[(which(counts.hubei$Day==23)):nrow(counts.hubei)] + counts.hubei$Deaths[(which(counts.hubei$Day==23)):nrow(counts.hubei)])

severity.rate3.nohubei <- counts.nohubei$Deaths[-(1:3)] / (counts.nohubei$Severe[-(1:3)] + counts.nohubei$Deaths[-(1:3)])

summary (severity.rate3.hubei)
#  Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#0.1186  0.1334  0.1569  0.1585  0.1616  0.2873
summary (severity.rate3.nohubei)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#0.01549 0.01886 0.02041 0.02265 0.02362 0.04074

ndays.severe.death <- length (severity.rate3.hubei)
# Plot_death_rates_in_severe_cases_vs_time.pdf
plot (1:ndays.severe.death, severity.rate3.hubei*100, type="b", ylim=c(0, 35), pch=16, cex=1.6, xlab="", ylab="Death rate among severe and death cases (%)", cex.axis=1.6, cex.lab=1.6, col="red", xaxt="n")
title ("Death Rate Among Severe and Death Cases", cex.main=2)
axis (side=1, at=1:ndays, labels=FALSE, cex.axis=1.6)
text (1:ndays.severe.death, par("usr")[3]-2.5, labels=rownames (counts.nohubei)[-(1:3)], srt=45, cex=1.6, pos=1, xpd=TRUE)
points (1:ndays.severe.death, severity.rate3.nohubei*100, type="b", pch=16, cex=1.6, col="blue")
legend (8, 8, bty="n", legend=c("Hubei Province", "mainland China excluding Hubei"), pch=16, cex=1.6, lty=1, col=c("red", "blue"))
