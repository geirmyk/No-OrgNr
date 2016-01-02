#!/usr/bin/perl

use utf8;
use 5.014;
use warnings;
use Test::More tests => 8;

BEGIN {
    use_ok('No::OrgNr');
}

diag("Testing No::OrgNr $No::OrgNr::VERSION, Perl $^V");
is( $No::OrgNr::VERSION, 'v0.6.1', 'Checking version number' );

ok( !defined &domain2orgnr, 'Checking that function domain2orgnr is not imported by default' );
No::OrgNr->import('domain2orgnr');
ok( defined &domain2orgnr, 'Checking that function domain2orgnr is imported' );

ok( !defined &orgnr_ok, 'Checking that function orgnr_ok is not imported by default' );
No::OrgNr->import('orgnr_ok');
ok( defined &orgnr_ok, 'Checking that function orgnr_ok is imported' );

ok( !defined &orgnr2domains, 'Checking that function orgnr2domains is not imported by default' );
No::OrgNr->import('orgnr2domains');
ok( defined &orgnr2domains, 'Checking that function orgnr2domains is imported' );
