#!/usr/bin/env perl

use utf8;
use 5.014;
use warnings;
use open qw/:encoding(UTF-8) :std/;
use Test::More;

BEGIN {
    use_ok('No::OrgNr');
}

ok( !defined &domain2orgnr,  'Verifying that function domain2orgnr is not imported by default' );
ok( !defined &orgnr_ok,      'Verifying that function orgnr_ok is not imported by default' );
ok( !defined &orgnr2domains, 'Verifying that function orgnr2domains is not imported by default' );

No::OrgNr->import(':all');
ok( defined &domain2orgnr,  'Verifying that function domain2orgnr is imported' );
ok( defined &orgnr_ok,      'Verifying that function orgnr_ok is imported' );
ok( defined &orgnr2domains, 'Verifying that function orgnr2domains is imported' );

done_testing;
