rm(list=ls())

setwd("C:/Users/user/Desktop/현장실습생 김아영/심혈관") #작업경로 설정
filename <- "심혈관 데이터.csv"
rawdata <- read.csv(filename)

#EDA
str(rawdata)
summary(rawdata)

#변수 속성 변환
rawdata$Sex <- factor(rawdata$Sex)
rawdata$Weight <- as.numeric(rawdata$Weight)
rawdata$BSA <- as.numeric(rawdata$BSA)
rawdata$BMI <- as.numeric(rawdata$BMI)
rawdata$OfficeBP <- factor(rawdata$OfficeBP)
rawdata$Smoking <- factor(rawdata$Smoking)
rawdata$Family_Hx <- factor(rawdata$Family_Hx)
rawdata$EKG <- factor(rawdata$EKG)
rawdata$CXR <- factor(rawdata$CXR)
rawdata$CrCl <- as.numeric(rawdata$CrCl)
rawdata$TroponinT <- as.numeric(rawdata$TroponinT)
rawdata$NT_proBNP <- as.numeric(rawdata$NT_proBNP)
rawdata$EF <- as.numeric(rawdata$EF)
rawdata$RWMA <- factor(rawdata$RWMA)
rawdata$DX <- factor(rawdata$DX)

sd(rawdata$Age, na.rm = T)

groupdata <- split(rawdata, rawdata$DX)
o <- groupdata$'0' #정상
x <- groupdata$'1' #환자
rm(groupdata)
nrow(o); nrow(x) #확인

#그룹별 EDA
summary(o)
sd(o$Age, na.rm = T) #표준편차
summary(x)
sd(x$Age, na.rm = T)

#연속형 분석

#1. 정규성 가정
shapiro.test(rawdata$diastolic_BP) #표본 수 3-5000일 때 사용
#p > 0.05면 정규성 만족
#But, 데이터가 너무 클 경우, 정규분포와 가까워도 p-value가 낮게 나올 가능성 있음, 그래픽으로 재확인
par(mfrow = c(1, 2))
hist(rawdata$diastolic_BP, freq=FALSE, breaks = 0) #히스토그램
qqnorm(rawdata$Age); qqline(rawdata$Age, col=2) #qqplot, 직선과 비슷할수록 정규분포
#정규성이 가정안되면 Mann-Whitney U test, 되면 t.test

#2. 등분산성 가정
var.test(o$E_E, x$E_E)
#p > 0.05면 두 집단의 분산 같음
#등분산성이 가정안되면 Welchs t.test, 되면 Independent t.test 

#Independent t.test
t.test(o$Protein, x$Protein, var.equal=TRUE)

#Welchs t.test
t.test(o$Tcholestreol, o$Tcholestreol)

#Mann-Whitney U test
wilcox.test(o$E_E, x$E_E)

#범주형 분석
mat <- cbind(table(o$DX), table(x$DX)); mat
chisq.test(mat) #카이제곱 검정 시행

#ROC 커브
library(pROC)
library(MASS)
plot.roc(smooth(roc(rawdata$DX, rawdata$E_E)),
         print.auc=TRUE,
         max.auc.polygon=TRUE, 
         auc.polygon=TRUE, 
         auc.polygon.col="light salmon1") 


