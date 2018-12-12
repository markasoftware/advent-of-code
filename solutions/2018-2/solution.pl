# use v5.12;
#
# my $ta = 0;
# my $tb = 0;
#
# while(chomp(my $line = <>)) {
#   my %perchar = ();
#   for (split(//, $line)) {
#     $perchar{$_}++;
#   }
#   for (values %perchar) {
#     if ($_ == 2) {
#       $ta++;
#       last;
#     }
#   }
#   for (values %perchar) {
#     if ($_ == 3) {
#       $tb++;
#       last;
#     }
#   }
# }
#
# say $ta * $tb;

use v5.12;

my @lines = ();
while(chomp(my $line = <>)) {
  push @lines, $line;
}
for my $line (@lines) {
  my @split_line = split //, $line;
  for my $other_line (@lines) {
    my @common = ();
    my $mistakes = 0;
    my @split_other_line = split //, $other_line;
    for (my $i = 0; $i < scalar(@split_other_line); ++$i) {
      unless ($split_line[$i] eq $split_other_line[$i]) {
        $mistakes++;
      } else {
        push @common, $split_line[$i];
      }
    }
    if ($mistakes == 1) {
      say @common;
      exit;
    }
  }
}
