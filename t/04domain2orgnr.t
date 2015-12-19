#!/usr/bin/perl

use utf8;
use 5.014;
use warnings;
use open qw/:encoding(UTF-8) :std/;

use Test::More tests => 27;

BEGIN {
    use_ok( 'No::OrgNr', qw/orgnr_ok orgnr2domains domain2orgnr/ );
}

# Checking known domain names
is( '971035854', domain2orgnr('uio.no'),    'Validating domain name (3)' );
is( '988588261', domain2orgnr('google.no'), 'Validating domain name (4)' );

is( undef, domain2orgnr('google.com'), 'Checking non-Norwegian domain name' );

# Checking invalid domain names
ok( !orgnr_ok('abc'),         'Checking invalid orgnr (1)' );
ok( !orgnr_ok(''),            'Checking invalid orgnr (2)' );
ok( !orgnr_ok(' '),           'Checking invalid orgnr (3)' );
ok( !orgnr_ok(undef),         'Checking invalid orgnr (4)' );
ok( !orgnr_ok('010 000 000'), 'Checking invalid orgnr (5)' );
ok( !orgnr_ok('110 000 000'), 'Checking invalid orgnr (6)' );
ok( !orgnr_ok('210 000 000'), 'Checking invalid orgnr (7)' );
ok( !orgnr_ok('310 000 000'), 'Checking invalid orgnr (8)' );
ok( !orgnr_ok('410 000 000'), 'Checking invalid orgnr (9)' );
ok( !orgnr_ok('510 000 000'), 'Checking invalid orgnr (10)' );
ok( !orgnr_ok('610 000 000'), 'Checking invalid orgnr (11)' );
ok( !orgnr_ok('710 000 000'), 'Checking invalid orgnr (12)' );

# Checking valid domain names
my $orgnr       = '988588261';
my $valid_orgnr = '988 588 261';
is( orgnr_ok($orgnr),               $valid_orgnr, 'Checking format of returned orgnr' );
is( orgnr_ok("  988 588 261  "),    $valid_orgnr, 'Checking valid orgnr (1)' );
is( orgnr_ok("988 588 261"),        $valid_orgnr, 'Checking valid orgnr (2)' );
is( orgnr_ok(" 9 8 8 5 8 8 2 6 1"), $valid_orgnr, 'Checking valid orgnr (3)' );

# Verifying that a Bengali digit (U+09EA), which looks like the digit 8, is not allowed
my $non_ascii_digit = "\x{9EA}";
my $test_nr         = '98' . $non_ascii_digit . '588261';
ok( !orgnr_ok($test_nr), 'Checking valid orgnr with non-ASCII digit' );

# Checking known organization numbers
my @domains = orgnr2domains('971035854');
my ($d) = grep { $_ eq 'uio.no' } @domains;
is( $d, 'uio.no', 'Validating domain name (1)' );

@domains = orgnr2domains('988588261');
($d) = grep { $_ eq 'google.no' } @domains;
is( $d, 'google.no', 'Validating domain name (2)' );

# Checking invalid organization numbers
is( (), orgnr2domains('abc'), 'Validating domain name (3)' );
is( (), orgnr2domains(''),    'Validating domain name (4)' );
is( (), orgnr2domains(' '),   'Validating domain name (5)' );
is( (), orgnr2domains(undef), 'Validating domain name (6)' );
