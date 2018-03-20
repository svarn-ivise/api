library(plumber)

n <- 100
start <- .1
end <- .5
x <- seq(from=.0, to=.5, by=(end-start)/n)
y <- 100 + -log10(x)*20 #+ rnorm(length(x),sd=.75)
price_model <- lm(data=data.frame(x, y)[-1,], 
            formula=y ~ poly(x, 2, raw=TRUE))

#' Return msg
#' @get /dynamic
function(date,seats,searches){
  
  searches <- as.numeric(searches)#300 #sample(500:1500,1)
  
  if(searches > 1000||!is.numeric(searches)){
    return("Invalid Search Input")
  }
  
  date <- as.Date(date)
  seats <- as.numeric(seats)
  
  days <- as.numeric(date - Sys.Date())
  cr <- 1/days*(seats/searches)
  x <- list(x=as.numeric(cr))
  price <- as.numeric(predict(price_model, x))
  
  return(list(cr=cr,price=price))
  #return(paste0("To attain a conversion ratio of ",cr,", Price should be equal to $",price))
}


#' Return randomPrice
#' @get /random
function(load, upper, lower, base, size){
  
  load <- as.numeric(load) #.5 #rep(seq(from=.01,to=1,by=.01),4)
  size <- as.numeric(size)
  basePrice <- 103.50 + (load * 20) - 10
  upperBound <- as.numeric(upper)
  lowerBound <- as.numeric(lower)
  
  multiplier <- -(lowerBound) + runif(size, min=0, max=1)*(upperBound + lowerBound)
  df <- data.frame(price = basePrice * (1 + multiplier), load = load)
  
  return(list(price = df$price, load = df$load))
}
