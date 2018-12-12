use v5.20;
use warnings;

use List::Util qw/max/;

my $elfs = 471;
my $marbles = 720260;

# my $elfs = 10;
# my $marbles = 25;

my $cur_elf = 0;
my @elf_scores = (0) x $elfs;

my @marble_circle = (0, 1);

my $current = 0;
sub mod_it {
  $current = $current % @marble_circle;
  $cur_elf = $cur_elf % $elfs;
}
for (2..$marbles) {
  if ($_ % 23 == 0) {
    $elf_scores[$cur_elf] += $_;
    $current -= 7;
    mod_it();
    $elf_scores[$cur_elf] += $marble_circle[$current];
    splice(@marble_circle, $current, 1);
  } else {
    $current++;
    mod_it();
    splice(@marble_circle, ++$current, 0, $_);
    mod_it();
  }
  $cur_elf++;
  mod_it();
#   say join ' ', @marble_circle;
#   say $current;
}

print max @elf_scores;
