#!/usr/bin/env perl

use utf8;
use 5.014;
use warnings;
use Test::More;

BEGIN {
    use_ok('No::OrgNr');
}

ok( !defined &domain2orgnr,  'Checking that function domain2orgnr is not imported by default' );
ok( !defined &orgnr_ok,      'Checking that function orgnr_ok is not imported by default' );
ok( !defined &orgnr2domains, 'Checking that function orgnr2domains is not imported by default' );

No::OrgNr->import(':all');
ok( defined &domain2orgnr,  'Checking that function domain2orgnr is imported' );
ok( defined &orgnr_ok,      'Checking that function orgnr_ok is imported' );
ok( defined &orgnr2domains, 'Checking that function orgnr2domains is imported' );

done_testing;
