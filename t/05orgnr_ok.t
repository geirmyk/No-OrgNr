#!/usr/bin/perl

use utf8;
use 5.014;
use warnings;
use Test::More;

BEGIN {
    use_ok( 'No::OrgNr', qw/orgnr_ok/ );
}

# Testing invalid org numbers
ok( !orgnr_ok('abc'),         'Testing invalid orgnr (1)' );
ok( !orgnr_ok(''),            'Testing invalid orgnr (2)' );
ok( !orgnr_ok(' '),           'Testing invalid orgnr (3)' );
ok( !orgnr_ok(undef),         'Testing invalid orgnr (4)' );
ok( !orgnr_ok('010 000 000'), 'Testing invalid orgnr (5)' );
ok( !orgnr_ok('110 000 000'), 'Testing invalid orgnr (6)' );
ok( !orgnr_ok('210 000 000'), 'Testing invalid orgnr (7)' );
ok( !orgnr_ok('310 000 000'), 'Testing invalid orgnr (8)' );
ok( !orgnr_ok('410 000 000'), 'Testing invalid orgnr (9)' );
ok( !orgnr_ok('510 000 000'), 'Testing invalid orgnr (10)' );
ok( !orgnr_ok('610 000 000'), 'Testing invalid orgnr (11)' );
ok( !orgnr_ok('710 000 000'), 'Testing invalid orgnr (12)' );
ok( !orgnr_ok('987 770 970'), 'Testing invalid orgnr (13)' );    # Control digit = 10
ok( !orgnr_ok('988 588 269'), 'Testing invalid orgnr (14)' );    # Invalid control digit

# Testing valid org numbers
my $orgnr       = '988588261';
my $valid_orgnr = '988 588 261';
is( orgnr_ok($orgnr),               $valid_orgnr, 'Testing format of returned orgnr' );
is( orgnr_ok("  988 588 261  "),    $valid_orgnr, 'Testing valid orgnr (1)' );
is( orgnr_ok("988 588 261"),        $valid_orgnr, 'Testing valid orgnr (2)' );
is( orgnr_ok(" 9 8 8 5 8 8 2 6 1"), $valid_orgnr, 'Testing valid orgnr (3)' );

# Testing orgnr ending in a zero
$orgnr       = '999281370';
$valid_orgnr = '999 281 370';
is( orgnr_ok($orgnr), $valid_orgnr, 'Testing valid orgnr (4)' );

# Verifying that a Bengali digit (U+09EA), which looks like the digit 8, is not allowed
my $non_ascii_digit = "\x{9EA}";
my $test_nr         = '98' . $non_ascii_digit . '588261';
ok( !orgnr_ok($test_nr), 'Testing valid orgnr with non-ASCII digit (1)' );

# Testing another Unicode digit 8 which is not ASCII
$non_ascii_digit = "\x{1D7EA}";
$test_nr         = '98' . $non_ascii_digit . '588261';
ok( !orgnr_ok($test_nr), 'Testing valid orgnr with non-ASCII digit (2)' );

done_testing;
