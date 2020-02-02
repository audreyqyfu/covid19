# read in count data
counts <- read.delim ("counts.txt", header=TRUE, row.names=1)
counts.hubei <- read.delim ("counts_Hubei.txt", header=TRUE, row.names=1)
counts.wuhan <- read.delim ("counts_Wuhan_corrected.txt", header=TRUE, row.names=1)

# extract data for Hubei Province but no Wuhan
counts.hubei.nowuhan <- counts.hubei[(nrow(counts.hubei)-11):nrow(counts.hubei), 2:5] - counts.wuhan[(nrow(counts.wuhan)-11):nrow(counts.wuhan), 2:5]

# extract data for mainland China outside Hubei
counts.nohubei <- counts[(nrow(counts)-11):nrow(counts), 2:5] - counts.hubei[(nrow(counts.hubei)-11):nrow(counts.hubei), 2:5]

####################################
# death rate
####################################
death.rate.wuhan <- counts.wuhan$Deaths[(nrow(counts.wuhan)-11):nrow(counts.wuhan)] / counts.wuhan$Cases[(nrow(counts.wuhan)-11):nrow(counts.wuhan)]

death.rate.hubei.nowuhan <- counts.hubei.nowuhan$Deaths / counts.hubei.nowuhan$Cases

death.rate.nohubei <- counts.nohubei$Deaths / counts.nohubei$Cases

summary (death.rate.wuhan)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#0.02326 0.04485 0.05582 0.05409 0.06180 0.09026
summary (death.rate.hubei.nowuhan)
#    Min.  1st Qu.   Median     Mean  3rd Qu.     Max.
#0.000000 0.004777 0.013769 0.010659 0.014888 0.018519
summary (death.rate.nohubei)
#    Min.  1st Qu.   Median     Mean  3rd Qu.     Max.
#0.000000 0.001617 0.002726 0.002313 0.003388 0.004334

par (mar=c(4.5, 5, 3.5, 1))
# Plot_death_rates_vs_time.pdf
plot (20:31, death.rate.wuhan*100, type="b", xlim=c(20, 31), ylim=c(-0.5, 10), pch=16, cex=1.6, xlab="Day of January 2020", ylab="Death rate in confirmed cases (%)", cex.axis=1.6, cex.lab=1.6, xaxt="n")
title ("Death Rate", cex.main=2)
axis (side=1, at=20:31, cex.axis=1.6)
points (20:31, death.rate.hubei.nowuhan*100, type="b", pch=16, cex=1.6, col="red")
points (20:31, death.rate.nohubei*100, type="b", pch=16, cex=1.6, col="blue")
legend (26.9, 8.5, bty="n", legend=c("Wuhan", "Hubei Province excluding Wuhan", "mainland China excluding Hubei"), pch=16, cex=1.6, lty=1, col=c("black", "red", "blue"))
abline (a=9.6, b=0, lty=2, col="#cc66ff", lwd=2.5)
abline (a=0.13, b=0, lty=2, col="#cf9500", lwd=2.5)
text (30.5, 9.3, labels="2002-03 SARS", col=c("#cc66ff"), cex=1.6)
text (30, -0.4, labels="2016-17 influenza in US", col=c("#cf9500"), cex=1.6)

####################################
# rate of severe cases
####################################
severity.rate.hubei <- counts.hubei$Severe[(nrow(counts.hubei)-8):nrow(counts.hubei)] / counts.hubei$Cases[(nrow(counts.hubei)-8):nrow(counts.hubei)]

severity.rate.nohubei <- counts.nohubei$Severe[(nrow(counts.nohubei)-8):nrow(counts.nohubei)] / counts.nohubei$Cases[(nrow(counts.nohubei)-8):nrow(counts.nohubei)]

summary (severity.rate.nohubei)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
# 0.1080  0.1222  0.1405  0.1440  0.1588  0.2113
summary (severity.rate.hubei)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
# 0.1226  0.1884  0.2154  0.2076  0.2350  0.2542

# Plot_severity_rates_vs_time.pdf
plot (23:31, severity.rate.hubei*100, type="b", xlim=c(23, 31), ylim=c(0, 30), pch=16, cex=1.6, xlab="Day of January 2020", ylab="Rate of severe cases (no deaths) in confirmed cases (%)", cex.axis=1.6, cex.lab=1.6, col="red", xaxt="n")
title ("Rate of Severe Cases", cex.main=2)
axis (side=1, at=23:31, cex.axis=1.6)
points (23:31, severity.rate.nohubei*100, type="b", pch=16, cex=1.6, col="blue")
legend (28, 6, bty="n", legend=c("Hubei Province", "mainland China excluding Hubei"), pch=16, cex=1.6, lty=1, col=c("red", "blue"))


severity.rate2.hubei <- (counts.hubei$Severe[(nrow(counts.hubei)-8):nrow(counts.hubei)] + counts.hubei$Deaths[(nrow(counts.hubei)-8):nrow(counts.hubei)]) / counts.hubei$Cases[(nrow(counts.hubei)-8):nrow(counts.hubei)]

severity.rate2.nohubei <- (counts.nohubei$Severe[(nrow(counts.nohubei)-8):nrow(counts.nohubei)] + counts.nohubei$Deaths[(nrow(counts.nohubei)-8):nrow(counts.nohubei)]) / counts.nohubei$Cases[(nrow(counts.nohubei)-8):nrow(counts.nohubei)]

# Plot_severity_rates2_vs_time.pdf
plot (23:31, severity.rate2.hubei*100, type="b", xlim=c(23, 31), ylim=c(0, 30), pch=16, cex=1.6, xlab="Day of January 2020", ylab="Rate of severe cases (no deaths) in confirmed cases (%)", cex.axis=1.6, cex.lab=1.6, col="red", xaxt="n")
title ("Rate of Severe Cases", cex.main=2)
axis (side=1, at=23:31, cex.axis=1.6)
points (23:31, severity.rate2.nohubei*100, type="b", pch=16, cex=1.6, col="blue")
legend (28, 6, bty="n", legend=c("Hubei Province", "mainland China excluding Hubei"), pch=16, cex=1.6, lty=1, col=c("red", "blue"))

# deaths among severe cases
severity.rate3.hubei <- counts.hubei$Deaths[(nrow(counts.hubei)-8):nrow(counts.hubei)] / (counts.hubei$Severe[(nrow(counts.hubei)-8):nrow(counts.hubei)] + counts.hubei$Deaths[(nrow(counts.hubei)-8):nrow(counts.hubei)])

severity.rate3.nohubei <- counts.nohubei$Deaths[(nrow(counts.nohubei)-8):nrow(counts.nohubei)] / (counts.nohubei$Severe[(nrow(counts.nohubei)-8):nrow(counts.nohubei)] + counts.nohubei$Deaths[(nrow(counts.nohubei)-8):nrow(counts.nohubei)])

summary (severity.rate3.hubei)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
# 0.1221  0.1409  0.1572  0.1732  0.1990  0.2873
summary (severity.rate3.nohubei)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#0.01957 0.02017 0.02041 0.02099 0.02055 0.02439

# Plot_death_rates_in_severe_cases_vs_time.pdf
plot (23:31, severity.rate3.hubei*100, type="b", xlim=c(23, 31), ylim=c(0, 35), pch=16, cex=1.6, xlab="Day of January 2020", ylab="Death rate among severe and death cases (%)", cex.axis=1.6, cex.lab=1.6, col="red", xaxt="n")
title ("Death Rate Among Severe and Death Cases", cex.main=2)
axis (side=1, at=23:31, cex.axis=1.6)
points (23:31, severity.rate3.nohubei*100, type="b", pch=16, cex=1.6, col="blue")
legend (28, 6, bty="n", legend=c("Hubei Province", "mainland China excluding Hubei"), pch=16, cex=1.6, lty=1, col=c("red", "blue"))

