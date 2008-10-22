#!/usr/bin/perl

use strict;
use Data::Dumper;

my %products;
my %cart;

print "Enter products (name, quantity, price), empty line to continue...\n";
while(<STDIN>) {
	chomp;
	last if /^$/;
	if(/^(\w+)\s+(\d+)\s+(\d*\.?\d{0,2})$/) {
		my $name = $1;
		my $quantity = $2;
		my $price = $3;
		$products{$name}{$quantity} = $price;
	}
}

print "Enter your order, empty line to continue\n";
while(<STDIN>) {
	chomp;
	last if /^$/;
	if(exists $products{$_}) {
		$cart{$_}++;
	}
}

my $total = 0;
foreach my $product (sort keys %cart) {
	my $quantity = $cart{$product};
	my $price = 0;
	while($quantity > 0) {
		foreach my $discount (reverse sort keys %{$products{$product}}) {
			my $mod = $quantity % $discount;
			my $div = sprintf("%d", $quantity / $discount);
			if($mod >= 0) {
				$price = $price + ($div * $products{$product}{$discount});
				$quantity = $quantity - ($div * $discount);
			} else {
				$price = $price + $products{$product}{$discount};
				$quantity = $quantity - $discount;
			}
		}
	}

	printf("%s %2d \$%.2f\n", $product, $cart{$product}, $price);
	$total += $price;
}
printf("TOTAL \$%.2f\n", $total);

