use v5.20;
use strict;
use warnings;
use List::Util qw/sum min max/;

my @recipies = (3, 7);
my @elfs = (0, 1);

my $after_n_recipies = 51589;
my $find_me = 554401;
my $out_n = 10;

my $i = 0;
while (1) {
  say $i if $i % 1000000 == 0;
  my $new_sum = 0;
  $new_sum += $recipies[$_] for @elfs;
  push @recipies, split(//, $new_sum);
  # move
  for (0..@elfs-1) {
    $elfs[$_] += 1 + $recipies[$elfs[$_]];
    $elfs[$_] %= @recipies;
  }
  $i++;

  if (join('', @recipies[-8..-1]) =~ /$find_me/) {
    say "DONE!";
    say index(join('', @recipies), $find_me);
#     say join('', splice(@recipies, $after_n_recipies, $out_n));
    last;
  }
}
