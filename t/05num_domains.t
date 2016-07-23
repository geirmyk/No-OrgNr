#!/usr/bin/env perl

use utf8;
use 5.014;
use warnings;
use open qw/:encoding(UTF-8) :std/;

use Net::Ping;
use Test::More;

BEGIN {
    if ( !eval { require Net::Ping; Net::Ping->import; 1; } ) {
        plan skip_all => 'Net::Ping required for this test';
    }
}

BEGIN {
    use_ok( 'No::OrgNr', qw/num_domains/ );
}

is( num_domains('abc'), 0, 'Testing invalid orgnr' );
is( num_domains(undef), 0, 'Testing undefined orgnr' );
is( num_domains(''),    0, 'Testing empty orgnr' );
is( num_domains(' '),   0, 'Testing orgnr equal to a space' );

# Testing orgnr which does not own a domain name
is( num_domains('994039113'), 0, 'Orgnr does not own a domain name' );

if ( Net::Ping->new->ping('whois.norid.no') ) {
    my $orgnr = '971035854';
    cmp_ok( num_domains($orgnr), 'gt', '10', "Testing number of domains owned by $orgnr)" );
    $orgnr = '988588261';
    cmp_ok( num_domains($orgnr), 'gt', '10', "Testing number of domains owned by $orgnr" );
}

done_testing;
