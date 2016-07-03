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
    use_ok( 'No::OrgNr', qw/num_domains/ );
}

if ( Net::Ping->new('external')->ping('whois.norid.no') ) {
    my $orgnr = '971 035 854';
    cmp_ok( num_domains($orgnr), 'gt', '10', "Testing number of domains owned by $orgnr" );
    $orgnr = '988 588 261';
    cmp_ok( num_domains($orgnr), 'gt', '10', "Testing number of domains owned by $orgnr" );
    $orgnr = '994 039 113';
    is( 0, num_domains($orgnr), 'Orgnr does not own a domain name' );
}

is( 0, num_domains('google.com'),         'Testing non-Norwegian domain name' );
is( 0, num_domains(undef),                'Testing undefined domain name' );
is( 0, num_domains(''),                   'Testing empty domain name' );
is( 0, num_domains(' '),                  'Testing domain name equal to a space' );
is( 0, num_domains('uuunknowndomain.no'), 'Testing unuused domain name' );

done_testing;
