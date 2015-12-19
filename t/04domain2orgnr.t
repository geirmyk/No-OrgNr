#!/usr/bin/perl

use utf8;
use 5.014;
use warnings;
use open qw/:encoding(UTF-8) :std/;

use Net::Ping;
use Test::More;

BEGIN {
    if ( !eval { require Net::Ping::External; Net::Ping::External->import('ping'); 1; } ) {
        plan skip_all => 'Net::Ping::External required for this test';
    }
}

BEGIN {
    use_ok( 'No::OrgNr', qw/domain2orgnr/ );
}

if ( Net::Ping->new('external')->ping('whois.norid.no') ) {
    # Checking known domain names
    is( '971035854', domain2orgnr('uio.no'),    'Validating domain name (1)' );
    is( '988588261', domain2orgnr('google.no'), 'Validating domain name (2)' );

    is( undef, domain2orgnr('google.com'), 'Checking non-Norwegian domain name' );
}

done_testing;
