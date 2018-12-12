#!/usr/bin/env perl

use v5.12;
use strict;
use warnings;

my $first;
my $last;
my $total = 0;
while (chomp(my $line = <>)) {
  $total += $line if $line == $last;
  $first = $line unless $first;
  $last = $line;
}
say $first
say $last
$total += $first if $first == $last;
say $total;
