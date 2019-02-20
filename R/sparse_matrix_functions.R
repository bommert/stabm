colMaxsSparse = function(m) {
  maxs = numeric(m@Dim[2])
  l = unlist(lapply(split(m@x, m@j), max))
  pos = as.numeric(names(l)) + 1
  maxs[pos] = l
  return(maxs)
}

meansWithoutZeros = function(x, dim.of.interest, len) {
  res = numeric(len)
  l = split(x, dim.of.interest)
  l = unlist(lapply(l, mean))
  pos = as.numeric(names(l)) + 1
  res[pos] = l
  return(res)
}

colMeansWithoutZeros = function(m) {
  return(meansWithoutZeros(m@x, m@j, m@Dim[2]))
}

rowMeansWithoutZeros = function(m) {
  return(meansWithoutZeros(m@x, m@i, m@Dim[1]))
}