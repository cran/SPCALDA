\name{SPCALDA}
\alias{SPCALDA}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
A New Reduced-Rank Linear Discriminant Analysis Method
}
\description{
A new reduced-rank LDA method which works for high dimensional multi-class data. 
}
\usage{
SPCALDA(X,Y,rho=exp(c((-2):6)),K=min(20,min(dim(X))), folds = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{X}{
Input matrix, of dimension nobs x nvars; each row is an observation vector.
}
  \item{Y}{
Response variable for class label, of dimension nobs x 1.
}
  \item{rho}{
Tuning parameter.
}
  \item{K}{
The total number of principal components considered.
}
  \item{folds}{
Folds for cross-validation to select tuning parameter.
}
}
 
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use ob=lda(transfX,Y), tuneRotation=tuneRotation, ErrorCount=ErrorCount, minerror = minerror, rho = tunerho, K = tuneK 
   \item{ob}{lda rule with top PCs}
   \item{tuneRotation}{Tuned rotaion matrix}
   \item{minerror}{Minimal training error}
   \item{rho}{tuned value of the parameter rho}
   \item{K}{tuned dimension, i.e., number of PCs}
}
 
\author{
Yue S. Niu, Ning Hao and Bin Dong
}
 
\examples{
set.seed(2015)
n = 200;p = 500

X = matrix(rnorm(n*p),n,p)
mu=matrix(0,4,p)
mu[1,1:125]=0.4;mu[2,126:250]=0.4;mu[3,251:375]=0.4;mu[4,376:500]=0.4
Y = rep(1:4,50)

for (g in 1:4) {
        index = which(Y == g)
        n_g = length(index)
        X[index,] = X[index,] + matrix(mu[g,],n_g,p,byrow=TRUE)
}

xtr = X[1:100,]; ytr=Y[1:100] #traning set
xte = X[101:200,]; yte =Y[101:200] # test set
folds = list(1:20,21:40,41:60,61:80,81:100)

spcaldaResult = SPCALDA(X=xtr,Y=ytr,rho=exp(c((-2):6)),K=20, folds = folds)
yhat = predict(spcaldaResult$ob,xte\%*\%spcaldaResult$tuneRotation)$class
error = sum(yhat != yte) 
 
}
 
\keyword{function}