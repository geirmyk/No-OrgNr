#!/usr/bin/perl

use utf8;
use 5.016;
use warnings;
use Test::More tests => 2;

BEGIN {
    use_ok('No::OrgNr');
}

can_ok( 'No::OrgNr', 'orgnr_ok' );
