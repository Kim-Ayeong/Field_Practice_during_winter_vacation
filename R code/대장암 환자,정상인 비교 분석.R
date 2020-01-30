rm(list=ls())

getwd(); dir()
filename <- "SSUni_ACRN_20170704_corrected_random_select_validation_dataset_57ea_Case4_190104.csv"
rawdata <- read.csv(filename)
head(rawdata)
dim(rawdata)
class(rawdata)
str(rawdata)

data <- cbind(rawdata, 
              prediction=substr(rawdata$prediction_actual,1,1),
              actual=substr(rawdata$prediction_actual,3,3))
data$sex <- factor(data$sex)
data$abd_obe <- factor(data$abd_obe)
data$obesity <- factor(data$obesity)
data$glu_100 <- factor(data$glu_100)
data$tg_150 <- factor(data$tg_150)
data$hdl_abnl <- factor(data$hdl_abnl)
data$crp <- factor(data$crp)
data$hba1c_65 <- factor(data$hba1c_65)
data$ob_yn <- factor(data$ob_yn)
data$meta_yn <- factor(data$meta_yn)
data$mets_yn <- factor(data$mets_yn)
data$meta_n <- factor(data$meta_n)
data$obe_meta <- factor(data$obe_meta)
data$alc_yn <- factor(data$alc_yn)
data$alc_freq <- factor(data$alc_freq)
data$smoke <- factor(data$smoke)
data$dm <- factor(data$dm)
data$htn <- factor(data$htn)
data$bp_13580 <- factor(data$bp_13580)
data$crc_fhx <- factor(data$crc_fhx)
data$exercise <- factor(data$exercise)
data$analge <- factor(data$analge)
str(data)

table(data$prediction_actual)
groupdata <- split(data, data$prediction_actual)
TP <- groupdata$'1_1' #환자를 환자라 판단
TN <- groupdata$'0_0' #정상을 정상이라 판단
FN <- groupdata$'0_1' #환자를 정상이라 판단
FP <- groupdata$'1_0' #정상을 환자라 판단
rm(groupdata)
nrow(TP); nrow(TN); nrow(FP); nrow(FN)
summary(TP); summary(TN); summary(FP); summary(FN)

#범주형 단변수 분석
#table(data$sex, data$actual)
tmp <- table(data$sex, data$actual); chisq.test(tmp)
tmp <- table(data$obesity, data$actual); chisq.test(tmp)
tmp <- table(data$abd_obe, data$actual); chisq.test(tmp)
tmp <- table(data$glu_100, data$actual); chisq.test(tmp)
tmp <- table(data$tg_150, data$actual); chisq.test(tmp)
tmp <- table(data$hdl_abnl, data$actual); chisq.test(tmp)
tmp <- table(data$hba1c_65, data$actual); chisq.test(tmp)
tmp <- table(data$crp, data$actual); chisq.test(tmp)
tmp <- table(data$ob_yn, data$actual); chisq.test(tmp)
tmp <- table(data$meta_yn, data$actual); chisq.test(tmp)
tmp <- table(data$mets_yn, data$actual); chisq.test(tmp)
tmp <- table(data$meta_n, data$actual); chisq.test(tmp)
tmp <- table(data$obe_meta, data$actual); chisq.test(tmp)
tmp <- table(data$alc_yn, data$actual); chisq.test(tmp)
tmp <- table(data$alc_freq, data$actual); chisq.test(tmp)
tmp <- table(data$smoke, data$actual); chisq.test(tmp)
tmp <- table(data$dm, data$actual); chisq.test(tmp)
tmp <- table(data$htn, data$actual); chisq.test(tmp)
tmp <- table(data$bp_13580, data$actual); chisq.test(tmp)
tmp <- table(data$crc_fhx, data$actual); chisq.test(tmp)
tmp <- table(data$exercise, data$actual); chisq.test(tmp)
tmp <- table(data$analge, data$actual); chisq.test(tmp)

#연속형 단변수 분석
#plot(data$actual, data$age)
tmp <- glm(actual ~ age, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ height, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ weight, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ bmi, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ wt_circ, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ wbc, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ rbc, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ hb, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ hct, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ rdw, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ plt, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ ca, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ glucose, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ prot, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ alb, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ glob, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ t_chol, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ ldh, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ tg, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ hdl, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ ldl, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ hba1c, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ hs_crp, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ cea, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ ft4, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ tsh, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ ft3, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ insulin, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ homa_ir, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ ferritin, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ ob_rt, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ sbp, family = binomial(link=logit), data); summary(tmp)
tmp <- glm(actual ~ dbp, family = binomial(link=logit), data); summary(tmp)

#예측 성공 집단, 실패 집단 > 의미 없음
success <- rbind(TP, TN)
failure <- rbind(FP, FN)
nrow(success); nrow(failure)
summary(success); summary(failure)
boxplot(success); boxplot(failure)
summary(success.data); summary(failure.data)
boxplot(success.data); boxplot(failure.data)

#암환자 집단, 정상 집단
cancer <- rbind(TP, FN)
normal <- rbind(TN, FP)
nrow(cancer); nrow(normal)
summary(cancer); summary(normal)
boxplot(cancer); boxplot(normal)
summary(cancer.data); summary(normal.data)
boxplot(cancer.data); boxplot(normal.data)

#Cancer / Normal 그룹 비교
#두 범주형 변수의 차이
#table(data$obesity, data$actual)
fisher.test(cancer$sex, normal$sex) #=chisq.test(cancer$abd_obe, normal$abd_obe)

#두 연속형 변수의 차이
#plot(data$actual, data$age)
t.test(cancer$age, normal$age)

#Cancer 내 Success / Failure 그룹 비교
#fisher.test, chisq.test는 길이가 달라 불가능
glmm <- glm(prediction ~ meta_n, family = binomial(link=logit), data=cancer); summary(glmm)
t.test(TP$wt_circ, FN$wt_circ)

#Normal 내 Success / Failure 그룹 비교
#fisher.test, chisq.test는 길이가 달라 불가능
glmm <- glm(prediction ~ meta_n, family = binomial(link=logit), data=normal); summary(glmm)
t.test(TN$wt_circ, FP$wt_circ)

#Success / Failure 그룹 비교
glmm <- glm(actual ~ meta_n, family = binomial(link=logit), data=success); summary(glmm)
glmm <- glm(actual ~ meta_n, family = binomial(link=logit), data=failure); summary(glmm)
t.test(success$dbp, failure$dbp)

#logistic regresion
#http://leoslife.com/archives/3931
#install.packages("caTools")
library(caTools)
ad.glm <- glm(actual ~ ., family = binomial, data = data)
#step 함수를 사용해 AIC를 최소화하는 모델 찾기
new.ad.glm<- step(ad.glm, direction = 'both')
summary(new.ad.glm)
#예측
ad.test$predicted.income <- predict(new.ad.glm, newdata = ad.test, type = 'response')
table(ad.test$income, ad.test$predicted.income > 0.5)  #기준이 되는 0.5는 분석자 주관에 따라 달라질 수 있음
#ROC curve
library(ROCR)
p <- predict(new.ad.glm, newdata = ad.test, type = 'response')
pr <- prediction(p, ad.test$income)
prf <- performance(pr, measure = 'tpr', x.measure = 'fpr')
plot(prf); abline(0,1)
performance(pr, 'auc')@y.values[[1]]

#Forward regression 방법
min.model=glm(actual~1,data=data)
fwd.model=step(min.model,direction="forward",
               scope=(actual~Population+Illiteracy+Income+Frost),trace=0)
summary(fwd.model)

#glmm <- glm(rv ~ TIME + pickup_longitude + PRCP, family=binomial(link=logit), data3, trace = F)
#summary(glmm)
#log <- predict(glmm, newdata = data.frame(TIME="8", pickup_longitude=-74.005 , PRCP=0.1))
#pi <- exp(log)
#traffic <- pi/(1+pi); traffic
