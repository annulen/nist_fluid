#!/usr/bin/env perl

use PDL;
use PDL::IO::CSV ':all';
use PDL::NiceSlice;

use strict;
use warnings;

# my ($pdl1, $pdl2, $pdl3) = rcsv1D($csv_filename_or_filehandle, \@column_ids);
# my $pdl = rcsv2D($csv_filename_or_filehandle, \@column_ids);

my $isotherm = rcsv2D('isotherm.txt', [1, 6], {sep_char => "\t"});
my $sl = $isotherm(-1, :); # T=298K, p=40 bar, S=?
my $target_S = $sl->at(0, 1);
print "S=$target_S\n";

my $satT = rcols('satT.txt', [0, 1, 6], {INCLUDE => qr/\tvapor$/, COLSEP => "\t"});
my $idx = vsearch($target_S, $satT(:, 2), { mode => 'insert_leftmost' });
#print $satT($idx, :)->flat, "\n";
my ($T_sat, $p_sat, $S_sat) = $satT($idx, :)->list;
print "$T_sat $p_sat $S_sat\n";
my ($T_sat, $p_sat, $S_sat) = $satT($idx + 1, :)->list;
print "$T_sat $p_sat $S_sat\n";

