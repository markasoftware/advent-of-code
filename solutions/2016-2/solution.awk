BEGIN {
#   FS
#   RS
  lastnum = 5
  noup[5]=1
  noup[9]=1
  noup[2]=1
  noup[4]=1
  noup[1]=1
  nodown[5]=1
  nodown[9]=1
  nodown[10]=1
  nodown[12]=1
  nodown[13]=1
  noleft[1]=1
  noleft[2]=1
  noleft[5]=1
  noleft[10]=1
  noleft[13]=1
  noright[1]=1
  noright[4]=1
  noright[9]=1
  noright[12]=1
  noright[13]=1
}
{
  split($0, chars, "")
  for(i=0; i < length(chars); i++) {
    if (chars[i] == "U") {
      lastnum = noup[lastnum] ? lastnum : lastnum < 5 || lastnum > 12 ? lastnum - 2 : lastnum - 4
    }
    if (chars[i] == "D") {
      lastnum = nodown[lastnum] ? lastnum : lastnum < 2 || lastnum > 9 ? lastnum + 2 : lastnum + 4
    }
    if (chars[i] == "L") {
      lastnum = noleft[lastnum] ? lastnum : lastnum - 1
    }
    if (chars[i] == "R") {
      lastnum = noright[lastnum] ? lastnum : lastnum + 1
    }
  }
  switch(lastnum) {
    case 10:
      lastnum="A"
      break

    case 11:
      lastnum="B"
      break
    case 12:
      lastnum="C"
      break
    case 13:
      lastnum="D"
      break
  }
  t = t lastnum
}
END{print t}
