#!/usr/bin/env perl

use utf8;
use 5.014;
use warnings;
use open qw/:encoding(UTF-8) :std/;

use Net::Ping;
use Test::More;

BEGIN {
    use_ok( 'No::OrgNr', qw/num_domains/ );
}

is( num_domains('abc'), 0, 'Testing invalid organization number' );
is( num_domains(undef), 0, 'Testing undefined organization number' );
is( num_domains(''),    0, 'Testing empty organization number' );
is( num_domains(' '),   0, 'Testing organization number equal to a space' );

if ( Net::Ping->new->ping('whois.norid.no') ) {

    # Testing known organization numbers
    my $orgnr = '971035854';
    cmp_ok( num_domains($orgnr), '>=', '10', "Testing number of domains owned by $orgnr" );
    $orgnr = '988588261';
    cmp_ok( num_domains($orgnr), '>=', '10', "Testing number of domains owned by $orgnr" );

    # Testing organization number which does not own a domain name
    is( num_domains('994039113'), 0, 'Organization number does not own a domain name' );
}

done_testing;
