
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Extract search strings from more referrers.",
  "AUTHOR" => "Olaf Alders <olaf\@wundercounter.com>",
  "BUILD_REQUIRES" => {
    "Config::General" => 0,
    "Data::Dump" => 0,
    "Data::Dumper" => 0,
    "English" => 0,
    "File::Spec" => 0,
    "Module::Build" => "0.3601",
    "Test::More" => 0,
    "Test::Perl::Critic" => 0,
    "Test::Pod" => 0,
    "Test::Pod::Coverage" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30",
    "Module::Build" => "0.3601"
  },
  "DISTNAME" => "URI-ParseSearchString-More",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "URI::ParseSearchString::More",
  "PREREQ_PM" => {
    "CGI" => 0,
    "List::Compare" => 0,
    "Params::Validate" => 0,
    "URI::Heuristic" => 0,
    "URI::ParseSearchString" => 0,
    "WWW::Mechanize::Cached" => 0,
    "base" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.15",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



