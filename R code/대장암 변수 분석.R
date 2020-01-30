rm(list=ls())

setwd("C:/Users/user/Desktop/현장실습생 김아영/대장암") #작업경로 설정
filename <- "대장암 데이터.csv"
rawdata <- read.csv(filename)

#EDA
str(rawdata)
summary(rawdata)

#변수 속성 변환
rawdata$sex <- factor(rawdata$sex)
rawdata$obesity <- factor(rawdata$obesity)
rawdata$abd_obe <- factor(rawdata$abd_obe)
rawdata$glu_100 <- factor(rawdata$glu_100)
rawdata$tg_150 <- factor(rawdata$tg_150)
rawdata$hdl_abnl <- factor(rawdata$hdl_abnl)
rawdata$hba1c_65 <- factor(rawdata$hba1c_65)
rawdata$crp <- factor(rawdata$crp)
rawdata$ob_yn <- factor(rawdata$ob_yn)
rawdata$meta_yn <- factor(rawdata$meta_yn)
rawdata$mets_yn <- factor(rawdata$mets_yn)
rawdata$meta_n <- factor(rawdata$meta_n)
rawdata$obe_meta <- factor(rawdata$obe_meta)
rawdata$alc_yn <- factor(rawdata$alc_yn)
rawdata$alc_freq <- factor(rawdata$alc_freq)
rawdata$smoke <- factor(rawdata$smoke)
rawdata$dm <- factor(rawdata$dm)
rawdata$htn <- factor(rawdata$htn)
rawdata$bp_13580 <- factor(rawdata$bp_13580)
rawdata$crc_fhx <- factor(rawdata$crc_fhx)
rawdata$exercise <- factor(rawdata$exercise)
rawdata$analge <- factor(rawdata$analge)
rawdata$acrn_yn <- factor(rawdata$acrn_yn)

groupdata <- split(rawdata, rawdata$acrn_yn)
o <- groupdata$'0' #정상
x <- groupdata$'1' #환자
rm(groupdata)
nrow(o); nrow(x) #확인

#그룹별 EDA
summary(o)
sd(o$age, na.rm=T) #표준편차
summary(x)
sd(x$age, na.rm=T)

#연속형 분석

#1. 정규성 가정
ks.test(rawdata$age, "pnorm") #표본 수 5000 이상
shapiro.test(x$age) #표본 수 3-5000일 때 사용
#p > 0.05면 정규성 만족
#But, 데이터가 너무 클 경우, 정규분포와 가까워도 p-value가 낮게 나올 가능성 있음 
#그래픽으로 재확인
par(mfrow = c(1, 2))
hist(rawdata$age, freq=FALSE, breaks = 50) #히스토그램
qqnorm(rawdata$age); qqline(rawdata$age, col=2) #qqplot, 직선과 비슷할수록 정규분포
#정규성이 가정되면 Welchs t.test, 안되면 Mann-Whitney U test

#2. 등분산성 가정
var.test(o$age, x$age)
#p > 0.05면 두 집단의 분산 같음
#등분산성이 가정되면 Independent t.test, 안되면 Welchs t.test

#Independent t.test 시행(표본의 크기가 달라도 상관없음)
t.test(o$height, x$height, var.equal=TRUE)

#Welchs t.test(var.equal=TRUE를 입력하지 않으면 자동으로 Welchs t.test로 변환)
t.test(o$age, x$hs_crp)

#Mann-Whitney U test 시행
wilcox.test(o$age, x$analge)

#범주형 분석
mat <- cbind(table(o$analge), table(x$analge)); mat
chisq.test(mat) #카이제곱 검정 시행

#ROC 커브
library(pROC)
library(MASS)
plot.roc(smooth(roc(rawdata$acrn_yn, rawdata$ca_hx)),
         print.auc=TRUE,
         max.auc.polygon=TRUE, 
         auc.polygon=TRUE, 
         auc.polygon.col="light salmon1") 
