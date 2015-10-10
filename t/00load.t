#!/usr/bin/perl

use utf8;
use 5.016;
use warnings;
use Test::More tests => 4;

BEGIN {
    use_ok('No::OrgNr');
}

diag("Testing No::OrgNr $No::OrgNr::VERSION, Perl $^V");

is( $No::OrgNr::VERSION, 'v0.1.0', 'Checking version number' );

ok( !defined &orgnr_ok, 'Checking that function orgnr_ok is not imported by default' );

No::OrgNr->import(qw/orgnr_ok/);

ok( defined &orgnr_ok, 'Checking that function orgnr_ok is imported' );
