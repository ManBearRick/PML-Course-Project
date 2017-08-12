library(caret)
library(rattle)
library(gridExtra)

fileURLtrain <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
fileURLtest <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
download.file(fileURLtrain, destfile = "./train.csv")
download.file(fileURLtest, destfile = "./test.csv")
rm(fileURLtest, fileURLtrain)

train <- read.csv("train.csv")
test <- read.csv("test.csv")

trainaccel <- grepl("^accel", names(train))
traintotal <- grepl("^total", names(train))
roll <- grepl("^roll", names(train))
pitch <- grepl("^pitch", names(train))
yaw <- grepl("^yaw", names(train))
magnet <- grepl("^magnet", names(train))
gyro <- grepl("^gyro", names(train))
acceldata <- train[ , trainaccel]
rolldata <- train[ , roll]
pitchdata <- train[ , pitch]
yawdata <- train[ , yaw]
magnetdata <- train[ , magnet]
gyrodata <- train[ , gyro]
totaldata <- train[ , traintotal]
trainClasse <- cbind(acceldata, rolldata, pitchdata, 
                     yawdata, magnetdata, gyrodata, 
                     totaldata, train[ , 160])
colnames(trainClasse)[53]<- 'Classe'

rm(acceldata, rolldata, pitchdata, yawdata, magnetdata, gyrodata, 
   totaldata)

testaccel <- grepl("^accel", names(test))
testtotal <- grepl("^total", names(test))
troll <- grepl("^roll", names(test))
tpitch <- grepl("^pitch", names(test))
tyaw <- grepl("^yaw", names(test))
tmagnet <- grepl("^magnet", names(test))
tgyro <- grepl("^gyro", names(test))
tacceldata <- test[ , testaccel]
trolldata <- test[ , troll]
tpitchdata <- test[ , tpitch]
tyawdata <- test[ , tyaw]
tmagnetdata <- test[ , tmagnet]
tgyrodata <- test[ , tgyro]
ttotaldata <- test[ , testtotal]
testClasse <- cbind(tacceldata, trolldata, tpitchdata,
                    tyawdata, tmagnetdata, tgyrodata,
                    ttotaldata, test[ , 160])
colnames(testClasse)[53]<- 'problem.id'

rm(tacceldata, trolldata, tpitchdata,
   tyawdata, tmagnetdata, tgyrodata,
   ttotaldata)

set.seed(123)

inTrain <- createDataPartition(trainClasse$Classe,
                               p = 0.7,
                               list = FALSE)

