#!/usr/bin/perl

use utf8;
use 5.016;
use warnings;
use Test::More tests => 18;

BEGIN {
    use_ok('No::OrgNr', qw/orgnr_ok/);
}

ok( !orgnr_ok('abc'), 'Checking invalid orgnr (1)' );
ok( !orgnr_ok(''), 'Checking invalid orgnr (2)' );
ok( !orgnr_ok(' '), 'Checking invalid orgnr (3)' );
ok( !orgnr_ok(undef), 'Checking invalid orgnr (4)' );
ok( !orgnr_ok('010 000 000'), 'Checking invalid orgnr (4)' );
ok( !orgnr_ok('110 000 000'), 'Checking invalid orgnr (5)' );
ok( !orgnr_ok('210 000 000'), 'Checking invalid orgnr (6)' );
ok( !orgnr_ok('310 000 000'), 'Checking invalid orgnr (7)' );
ok( !orgnr_ok('410 000 000'), 'Checking invalid orgnr (8)' );
ok( !orgnr_ok('510 000 000'), 'Checking invalid orgnr (9)' );
ok( !orgnr_ok('610 000 000'), 'Checking invalid orgnr (10)' );
ok( !orgnr_ok('710 000 000'), 'Checking invalid orgnr (11)' );

my $orgnr = '988588261';
ok( orgnr_ok($orgnr), 'Checking valid orgnr (1)' );
ok( orgnr_ok("  988 588 261  "), 'Checking valid orgnr (2)' );
ok( orgnr_ok("988 588 261"), 'Checking valid orgnr (3)' );

# Using a Bengali digit (U+09EA), which looks like the digit 8, to verify that this character is
# indeed matched by /\D/a (see the module code). See also 'man perlre'.
my $non_ascii_digit = "\x{9EA}";
my $test_nr = '98' . $non_ascii_digit . '588261';
ok( !orgnr_ok($test_nr), 'Checking valid orgnr with non-ASCII digit' );

my $test = orgnr_ok($orgnr);
is( $test, '988 588 261', 'Checking format of returned orgnr' );
