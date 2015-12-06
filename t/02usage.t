#!/usr/bin/perl

use utf8;
use 5.014;
use warnings;
use Test::More tests => 4;

BEGIN {
    use_ok('No::OrgNr');
}

can_ok( 'No::OrgNr', 'domain2orgnr' );
can_ok( 'No::OrgNr', 'orgnr_ok' );
can_ok( 'No::OrgNr', 'orgnr2domains' );
