#!/usr/bin/env perl

use strict;
use warnings;
use 5.010;
use Device::SerialPort;
use Time::HiRes 'sleep';

our $VERSION = '0.0';

my $port = Device::SerialPort->new("/dev/ttyUSB0", 0);

$port->baudrate(19200);
$port->parity("none");
$port->databits(8);
$port->stopbits(1);
$port->handshake("none");

for my $i (0 .. 255) {
	my @bytes = (
		1,
		1,
		$i,
		0x01 ^ 0x01 ^ $i
	);
	for my $byte (@bytes) {
		$port->write(chr($byte));
	}
	#my $cnt = $port->write( join('',  map { chr($_) } @bytes ) );
#	my ($cnt, $saw) = $port->read(255);
	my $cnt = 0; my $saw = 0;
	printf("%8b " x @bytes . "%d %s\n", @bytes, $cnt, unpack('H*', $saw));
	sleep(1);
}

#for my $i (0 .. 255) {
#for my $j (1 .. 255) {
#for my $k (0 .. 255) {
#for my $l (0 .. 255) {
#	my $cnt = $port->write(chr($i) . chr($j) . chr($k) . chr($l));
#	printf("%8b %8b %8b %8b %d\n",
#		$i, $j, $k, $l,
#		$cnt
#	);
#	sleep(0.0001);
#}
#}
#}
#}


__END__

=head1 NAME

=head1 SYNOPSIS

=head1 VERSION

=head1 DESCRIPTION

=head1 OPTIONS

=over

=back

=head1 EXIT STATUS

=head1 CONFIGURATION

None.

=head1 DEPENDENCIES

=over

=back

=head1 BUGS AND LIMITATIONS

=head1 AUTHOR

Copyright (C) 2012 by Daniel Friesel E<lt>derf@finalrewind.orgE<gt>

=head1 LICENSE

  0. You just DO WHAT THE FUCK YOU WANT TO.
