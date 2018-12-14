use v5.20;
use strict;
use warnings;
use List::Util qw/min max sum/;

my $line;
my %tracks = ();
my %carts = ();
sub char_to_direction {
  my $char = shift;
  return $char eq '>' ? 0 : $char eq '^' ? 1 : $char eq '<' ? 2 : 3;
}

sub add_cart {
  my ($x, $y, $char) = @_;
  $carts{$x . ' ' . $y} = {
    direction => char_to_direction($char),
    # -1 = right, 0 = str, 1 = left
    # we'll just do a manual shitty modulo because it's easier to add this to direction then :)
    next_turn => 1,
  };
}
sub move {
  my ($x, $y, $dir) = @_;
  $x++ if $dir == 0;
  $y-- if $dir == 1;
  $x-- if $dir == 2;
  $y++ if $dir == 3;
  return ($x, $y);
}

# takes a direction and "bounces" it off a track piece
# 0 = right, 1 = up, 2 = left, etc, like angles on a circle
sub bounce {
  my ($direction, $track) = @_;
  return $direction if $track =~ /[|-]/;
  # it's a corner. Parity = the lowest compatible direction % 2
  my $parity = $track eq '/';
  my $direction_is_lowest = $direction % 2 == $parity;
  return (($direction_is_lowest ? -1 : 1) + $direction) % 4;
}
sub move_carts {
  say "TURN!";
  for my $cart_key (keys %carts) {
    my ($x, $y) = $cart_key =~ /\d+/g;
    my $cart = $carts{$cart_key};
    my $track = $tracks{$cart_key};

    # TODO: refactor bounce so that it takes a cart as a param
    if ($track eq '+') {
      $cart->{direction} += $cart->{next_turn}--;
      $cart->{direction} %= 4;
      $cart->{next_turn} = 1 if $cart->{next_turn} == -2;
    } else {
      $cart->{direction} = bounce($cart->{direction}, $track);
    }
    ($x, $y) = move($x, $y, $cart->{direction});

    my $new_key = $x . ' ' . $y;
    say "Cart at $new_key just moved $cart->{direction}";
    if (exists $carts{$new_key}) {
      say "CRASH! at $new_key";
      return 0;
    }

    $carts{$new_key} = $carts{$cart_key};
    delete $carts{$cart_key};
  }
  return 1;
}
sub add_track {
  my ($x, $y, $char) = @_;
  $tracks{$x . ' ' . $y} = $char;
}
my $y = 0;
while (chomp(my $line = <>)) {
  my $x = 0;
  for my $char (split //, $line) {
    if ($char eq '<' or $char eq '>' or $char eq '^' or $char eq 'v') {
      add_cart $x, $y, $char;
    }
    $char = '|' if $char eq '^' or $char eq 'v';
    $char = '-' if $char eq '<' or $char eq '>';
    add_track $x, $y, $char;
    $x++;
  }
  $y++;
}

my $crash_free = 1;
while ($crash_free) {
  $crash_free = move_carts;
}
