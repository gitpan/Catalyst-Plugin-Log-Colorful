use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Catalyst::Plugin::Log::Colorful',
    AUTHOR              => 'Tomohiro Teranishi <tomohiro.teranishi@gmail.com>',
    VERSION_FROM        => 'lib/Catalyst/Plugin/Log/Colorful.pm',
    ABSTRACT_FROM       => 'lib/Catalyst/Plugin/Log/Colorful.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More'        => 0,
        'Catalyst'          => 0,
        'Catalyst::Log'     => 0,
        'Term::ANSIColor'   => 0,
        'Data::Dumper'      => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Catalyst-Plugin-Log-Colorful-*' },
);
