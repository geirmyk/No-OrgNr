#!/usr/bin/perl

use utf8;
use 5.016;
use warnings;

use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'No::OrgNr',
    license             => 'perl',
    dist_author         => 'Geir Myklebust <geirmy@gmail.com>',
    dist_version_from   => 'lib/No/OrgNr.pm',
    configure_requires => {
        'Module::Build' => 0
    },
    requires => {
        'perl'          => 5.016,
    },
    add_to_cleanup      => [ 'No::OrgNr-*' ],
);

$builder->create_build_script();
