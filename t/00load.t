#!/usr/bin/env perl

use utf8;
use 5.014;
use warnings;
use open qw/:encoding(UTF-8) :std/;
use English qw/-no_match_vars/;
use Test::More;

BEGIN {
    use_ok('No::OrgNr');
}

diag("Testing No::OrgNr $No::OrgNr::VERSION, Perl $PERL_VERSION");
is( $No::OrgNr::VERSION, 'v0.8.4', 'Testing version number' );

ok( !defined &domain2orgnr, 'Verifying that function domain2orgnr is not imported by default' );

No::OrgNr->import('domain2orgnr');
ok( defined &domain2orgnr, 'Verifying that function domain2orgnr is imported' );

ok( !defined &orgnr_ok, 'Verifying that function orgnr_ok is not imported by default' );

No::OrgNr->import('orgnr_ok');
ok( defined &orgnr_ok, 'Verifying that function orgnr_ok is imported' );

ok( !defined &orgnr2domains, 'Verifying that function orgnr2domains is not imported by default' );

No::OrgNr->import('orgnr2domains');
ok( defined &orgnr2domains, 'Verifying that function orgnr2domains is imported' );

done_testing;
