#!/usr/bin/env perl

use utf8;
use 5.014;
use warnings;
use open qw/:encoding(UTF-8) :std/;

use Net::Ping;
use Test::More;

BEGIN {
    use_ok( 'No::OrgNr', qw/domain2orgnr/ );
}

is( domain2orgnr('google.com'),         undef, 'Testing non-Norwegian domain name' );
is( domain2orgnr('abc'),                undef, 'Testing invalid domain name' );
is( domain2orgnr(undef),                undef, 'Testing undefined domain name' );
is( domain2orgnr(''),                   undef, 'Testing empty domain name' );
is( domain2orgnr(' '),                  undef, 'Testing domain name equal to a space' );
is( domain2orgnr('uuunknowndomain.no'), undef, 'Testing unuused domain name' );
is( domain2orgnr('aaaa.bbbb.cccc.no'),  undef, 'Testing non-existent domain name' );

if ( Net::Ping->new->ping('whois.norid.no') ) {
    my $domain = 'uio.no';
    is( domain2orgnr($domain), '971035854', "Testing orgnr for $domain" );
    $domain = 'google.no';
    is( domain2orgnr($domain), '988588261', "Testing orgnr for $domain" );
}

done_testing;
