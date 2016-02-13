#!/usr/bin/perl

use utf8;
use 5.014;
use warnings;

use Module::Build;

my $builder = Module::Build->new(
    add_to_cleanup      => [ 'No::OrgNr-*' ],
    module_name         => 'No::OrgNr',
    license             => 'perl',
    dist_author         => 'Geir Myklebust <geirmy@cpan.org>',
    dist_version_from   => 'lib/No/OrgNr.pm',
    configure_requires  => {
        'Module::Build' => 0
    },
    requires            => {
        'perl'              => 5.014,
        'Net::Whois::Norid' => 0
    },
    meta_merge => {
        resources => {
            bugtracker => 'https://github.com/geirmyk/No-OrgNr/issues',
            homepage   => 'https://metacpan.org/pod/No::OrgNr',
            repository => 'https://github.com/geirmyk/No-OrgNr'
        }
    }
);

$builder->create_build_script();
