#!/usr/bin/perl

use utf8;
use 5.014;
use warnings;
use Test::More;

BEGIN {
    if ( !eval { require Net::Ping; Net::Ping->import; 1; } ) {
        plan skip_all => 'Net::Ping required for this test';
    }
    elsif ( !eval { require Net::Ping::External; Net::Ping::External->import; 1; } ) {
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
}

is( undef, domain2orgnr('google.com'), 'Checking non-Norwegian domain name' );
is( undef, domain2orgnr(undef),        'Checking undefined domain name' );
is( undef, domain2orgnr(''),           'Checking empty domain name' );

done_testing;
