#MASS is a library which contains the GINV function that calculates the inverse of matrices
#The makeCacheMatrix takes a matrix as an argument, calculates the inverse of it and stores it in m 

library(MASS)

makeCacheMatrix <- function(x = matrix()) {
        
        m <- NULL
        set <- function(y) {
                x <<- y
                m <<- NULL
        }
        get <- function() x 
        setinverse <- function(ginv) m <<- ginv
        getinverse <- function() m
        list(set = set, get = get,
             setinverse = setinverse,
             getinverse = getinverse)
}


#cacheSolve gets the function "getinverse" that is stored as a list in makeCachematrix and finds the value of the
#inverse of the matrix if its there, if it isnt it calculates the inverse from "get" which is just the value of the
#matrix given at the beggining

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        m <- x$getinverse()
        if(!is.null(m)) {
                message("getting cached data")
                return(m)
        }
        data <- x$get()
        m <- ginv(data, ...)
        x$setinverse(m)
        m
}
