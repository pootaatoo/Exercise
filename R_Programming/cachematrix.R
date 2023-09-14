## This function create a list that set/get the value of a matrix,
## and set/get the inverse of the matrix

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y){
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setinv <- function(solve) m <<- solve
  getinv <- function() m
  list(set = set, get =  get,
       setinv = setinv, getinv = getinv)
}

## This function first checks to see if the inverse has already been
## calculated, if so, it gets the inverse from the cache and skips the
## computation. Otherwise, calculates the inverse and save it to cache

cacheSolve <- function(x, ...) {
  m <- x$getinv()
  if(!is.null(m)){
    message('getting inverse of the matrix')
    return(m)
  }
  data <- x$get()
  m <- solve(data, ...)
  x$setinv(m)
  m
}

## Check the function use a randomly generated matrix x
x <- matrix(runif(9), nrow = 3)
output <- makeCacheMatrix(x)
cacheSolve(output)

