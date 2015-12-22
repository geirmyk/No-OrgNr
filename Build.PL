#!/usr/bin/perl

use utf8;
use 5.014;
use warnings;

use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'No::OrgNr',
    license             => 'perl',
    dist_author         => 'Geir Myklebust <geirmy@cpan.org>',
    dist_version_from   => 'lib/No/OrgNr.pm',
    configure_requires => {
        'Module::Build' => 0
    },
    requires => {
        'perl'              => 5.014,
        'Net::Whois::Norid' => 0
    },
    add_to_cleanup      => [ 'No::OrgNr-*' ],
);

$builder->create_build_script();
