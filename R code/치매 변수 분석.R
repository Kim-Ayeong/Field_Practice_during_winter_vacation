rm(list=ls())

setwd("C:/Users/user/Desktop/현장실습생 김아영/치매") #작업경로 설정
filename <- "치매 데이터.csv"
rawdata <- read.csv(filename)

#EDA
str(rawdata)
summary(rawdata)

#변수 속성 변환
rawdata$Sex <- factor(rawdata$Sex)
rawdata$Education <- factor(rawdata$Education)
rawdata$Reading <- factor(rawdata$Reading)
rawdata$Writing <- factor(rawdata$Writing)
rawdata$Job <- factor(rawdata$Job)
rawdata$Marriage <- factor(rawdata$Marriage)
rawdata$Cohabittant <- factor(rawdata$Cohabittant)
rawdata$CIRS_total_BL <- factor(rawdata$CIRS_total_BL)
rawdata$CDR_BL <- factor(rawdata$CDR_BL)
rawdata$wlrt0 <- factor(rawdata$wlrt0)
rawdata$wlrct0 <- factor(rawdata$wlrct0)
rawdata$crt0 <- factor(rawdata$crt0)
rawdata$cpt0 <- factor(rawdata$cpt0)
rawdata$bnt0 <- factor(rawdata$bnt0)
rawdata$dsf0 <- factor(rawdata$dsf0)
rawdata$dsb0 <- factor(rawdata$dsb0)
rawdata$fab0 <- factor(rawdata$fab0)
rawdata$cloxi0 <- factor(rawdata$cloxi0)
rawdata$cloxii0 <- factor(rawdata$cloxii0)
rawdata$APOE.E4 <- factor(rawdata$APOE.E4)
rawdata$Vit.B12 <- as.numeric(rawdata$Vit.B12)
rawdata$Folate <- as.numeric(rawdata$Folate)
rawdata$PDW <- as.numeric(rawdata$PDW)
rawdata$VDRL <- factor(rawdata$VDRL)
rawdata$TSH <- as.numeric(rawdata$TSH)
rawdata$DX <- factor(rawdata$DX)

groupdata <- split(rawdata, rawdata$DX)
o <- rbind(groupdata$'0', groupdata$'1') #정상
x <- groupdata$'2' #치매
rm(groupdata)
nrow(o); nrow(x) #확인

#그룹별 EDA
summary(o)
sd(o$Age, na.rm = T) #표준편차
summary(x)
sd(x$Age, na.rm = T)

#연속형 분석

#1. 정규성 가정
ks.test(rawdata$Age, "pnorm") #표본 수 5000 이상일 때 사용
#p > 0.05면 정규성 만족
#But, 데이터가 너무 클 경우, 정규분포와 가까워도 p-value가 낮게 나올 가능성 있음, 그래픽으로 재확인
par(mfrow = c(1, 2))
hist(rawdata$Free.T4, freq=FALSE, breaks = 100)
qqnorm(rawdata$Free.T4); qqline(rawdata$Free.T4, col=2) #직선과 비슷할수록 정규분포
#정규성이 가정안되면 Mann-Whitney U test, 되면 t.test

#2. 등분산성 가정
var.test(o$Free.T4, x$Free.T4)
#p > 0.05면 두 집단의 분산 같음
#등분산성이 가정안되면 Welchs t.test, 되면 Independent t.test 

#Independent t.test
t.test(o$Hematocrit, x$Hematocrit, var.equal=TRUE)

#Welchs t.test
t.test(o$MCHC, x$MCHC)

#Mann-Whitney U test
wilcox.test(o$Free.T4, x$Free.T4)

#범주형 분석
mat <- cbind(table(o$cloxii0), table(x$cloxii0)); mat
chisq.test(mat) #카이제곱 검정 시행

#ROC 커브
#종속변수 범주이름 재정리(0 vs 2)
data <- rawdata[!is.na(rawdata$DX), ]
data <- cbind(data, DX2 = rep(0, 7843))
data[which(data$DX=='2'), ]$DX2 = '2'
data$DX2 <- factor(data$DX2)
summary(data)

library(pROC)
library(MASS)
plot.roc(smooth(roc(data$DX2, data$Free.T4)),
         print.auc=TRUE,
         max.auc.polygon=TRUE, 
         auc.polygon=TRUE, 
         auc.polygon.col="light salmon1") 





