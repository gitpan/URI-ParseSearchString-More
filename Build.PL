
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Config::General" => 0,
    "Module::Build" => "0.3601",
    "Test::More" => 0
  },
  "configure_requires" => {
    "ExtUtils::MakeMaker" => "6.30",
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Extract search strings from more referrers.",
  "dist_author" => [
    "Olaf Alders <olaf\@wundercounter.com>"
  ],
  "dist_name" => "URI-ParseSearchString-More",
  "dist_version" => "0.16",
  "license" => "perl",
  "module_name" => "URI::ParseSearchString::More",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "CGI" => 0,
    "List::Compare" => 0,
    "Params::Validate" => 0,
    "Test::WWW::Mechanize" => "1.44",
    "URI::Heuristic" => 0,
    "URI::ParseSearchString" => 0,
    "WWW::Mechanize::Cached" => 0,
    "base" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
