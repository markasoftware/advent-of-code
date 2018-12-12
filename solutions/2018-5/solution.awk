BEGIN {
#   FS
#   RS
#   FPAT
  last=""
}
{
  if (last != "") {
    if (last == toupper($0) && tolower($0) == $0 || last == tolower($0) && toupper($0) == $0) {
      last = ""
    } else {
      print last
      last=$0
    }
  } else {
    last = $0
  }
}
END {
  print last
}
