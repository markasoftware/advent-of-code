BEGIN {
#   RS
#   FS
}
{
  split($3, dims, ",")
  x_start=dims[1]
  y_start=int(dims[2])
  split($4, dims, "x")
  width=dims[1]
  height=dims[2]
  cool=1
  for(i=x_start;i<x_start+width;i++) {
    for(k=y_start;k<y_start+height;k++) {
      if (a[i SUBSEP k]) {
        b[a[i SUBSEP k]] = "FAIL"
        cool=0
      }
      a[i SUBSEP k] = $1
    }
  }
  if (cool) {
    b[$1] = 1
  }
}
END {
  for (key in b) {
    if (b[key] != "FAIL") {
      print key
    }
  }
}
