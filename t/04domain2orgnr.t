#!/usr/bin/env perl

use utf8;
use 5.014;
use warnings;
use open qw/:encoding(UTF-8) :std/;
use Net::Ping;
use Test::More;

BEGIN {
    if ( !eval { require Net::Ping::External; Net::Ping::External->import; 1; } ) {
        plan skip_all => 'Net::Ping::External required for this test';
    }
}

BEGIN {
    use_ok( 'No::OrgNr', qw/domain2orgnr/ );
}

if ( Net::Ping->new('external')->ping('whois.norid.no') ) {
    my $dname = 'uio.no';
    is( '971035854', domain2orgnr($dname), "Testing domain name $dname" );
    $dname = 'google.no';
    is( '988588261', domain2orgnr($dname), "Testing domain name $dname" );
}

is( undef, domain2orgnr('google.com'),         'Testing non-Norwegian domain name' );
is( undef, domain2orgnr(undef),                'Testing undefined domain name' );
is( undef, domain2orgnr(''),                   'Testing empty domain name' );
is( undef, domain2orgnr(' '),                  'Testing domain name equal to a space' );
is( undef, domain2orgnr('uuunknowndomain.no'), 'Testing unuused domain name' );

done_testing;
