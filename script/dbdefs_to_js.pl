#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use DBDefs;
use Getopt::Long;
use JSON;
use Readonly;

my $client = '';
GetOptions(
    'client' => \$client,
);
my ($output_path) = @ARGV;

Readonly our @BOOLEAN_DEFS => qw(
    DB_READ_ONLY
    DB_STAGING_SERVER
    DEVELOPMENT_SERVER
    IS_BETA
);

Readonly our @HASH_DEFS => qw(
);

Readonly our @NUMBER_DEFS => qw(
    REPLICATION_TYPE
    STAT_TTL
);

Readonly our @STRING_DEFS => qw(
    BETA_REDIRECT_HOSTNAME
    CANONICAL_SERVER
    DB_STAGING_SERVER_DESCRIPTION
    GIT_BRANCH
    GIT_MSG
    GIT_SHA
    GOOGLE_ANALYTICS_CODE
    GOOGLE_CUSTOM_SEARCH
    MAPBOX_ACCESS_TOKEN
    MAPBOX_MAP_ID
    RENDERER_SOCKET
    SENTRY_DSN
    SENTRY_DSN_PUBLIC
    STATIC_RESOURCES_LOCATION
    WEB_SERVER
);

Readonly our @QW_DEFS => qw(
    MB_LANGUAGES
);

Readonly our %CLIENT_DEFS => (
    DEVELOPMENT_SERVER => 1,
    GIT_BRANCH => 1,
    GIT_SHA => 1,
    MAPBOX_ACCESS_TOKEN => 1,
    MAPBOX_MAP_ID => 1,
    MB_LANGUAGES => 1,
    SENTRY_DSN_PUBLIC => 1,
    STATIC_RESOURCES_LOCATION => 1,
);

sub get_value {
    my $def = shift;

    # Values can be overridden via the environment.
    $ENV{$def} // DBDefs->$def;
}

my $code = '';

for my $def (@BOOLEAN_DEFS) {
    next if $client && !$CLIENT_DEFS{$def};

    my $value = get_value($def);

    if (defined $value && $value eq '1') {
        $value = 'true';
    } else {
        $value = 'false';
    }

    $code .= "exports.$def = $value;\n";
}

my $json = JSON->new->allow_nonref->ascii->canonical;

for my $def (@HASH_DEFS, @NUMBER_DEFS, @STRING_DEFS) {
    next if $client && !$CLIENT_DEFS{$def};

    my $value = get_value($def);
    $value = $json->encode($value);
    $code .= "exports.$def = $value;\n";
}

for my $def (@QW_DEFS) {
    next if $client && !$CLIENT_DEFS{$def};

    my @words = get_value($def);
    my $value = $json->encode(join ' ', @words);
    $code .= "exports.$def = $value;\n";
}

my $js_path = "$FindBin::Bin/../root/static/scripts/common/DBDefs.js";
open(my $fh, '>', $js_path);
print $fh $code;
