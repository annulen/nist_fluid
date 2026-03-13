#!/usr/bin/env perl

use PDL;
use PDL::IO::CSV ':all';

use strict;
use warnings;

# my ($pdl1, $pdl2, $pdl3) = rcsv1D($csv_filename_or_filehandle, \@column_ids);
# my $pdl = rcsv2D($csv_filename_or_filehandle, \@column_ids);

my $isotherm = rcsv2D('isotherm.txt', [1, 6], {sep_char => "\t"});
my $sl = $isotherm->slice('-1,:'); # T=298K, p=40 bar, S=?
print $sl;
#my ($p, $S) = $isotherm->slice('-1, :');
my $S = $sl->index2d(0, 1);
print "S=$S\n";


my $sat_p = rcsv2D('satp.txt', [0, 1, 6], {sep_char => "\t"});
print $sat_p;

