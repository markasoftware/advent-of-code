# Mark's AoC solutions and helper script

This is much messier than most AoC repos on GitHub. Many of the solutions are exactly as I wrote them when submitting, which sometimes means that they are missing essential pieces of code for Part 1 of each day's challenge. Most of my solutions are in Awk or Perl, although I am working through some previous years with Rust and might do a few in Haskell.

## Helper Script

The handy-dandy `helper.bash` automatically watches the AoC website for the challenge, downloads the input, and feeds it to your program. You must first get a dump of your browser's cookies to the `cookies` file in Netscape format while logged into AoC (there are some nice browser extensions for this). Then run `./helper.bash 2018 25` to poll the website for the input, then run a program in perl, awk, or rust using the directory structure before you.
