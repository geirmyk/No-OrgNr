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

is( 0, num_domains('abc'), 'Testing invalid orgnr' );
is( 0, num_domains(undef), 'Testing undefined orgnr' );
is( 0, num_domains(''),    'Testing empty orgnr' );
is( 0, num_domains(' '),   'Testing orgnr equal to a space' );

if ( Net::Ping->new->ping('whois.norid.no') ) {
    my $orgnr = '971 035 854';
    cmp_ok( num_domains($orgnr), 'gt', '10', "Testing number of domains owned by $orgnr)" );
    $orgnr = '988 588 261';
    cmp_ok( num_domains($orgnr), 'gt', '10', "Testing number of domains owned by $orgnr" );
}

done_testing;
