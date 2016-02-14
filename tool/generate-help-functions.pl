#!/usr/bin/perl
# vim:et:sts=4:sws=4:sw=4
use strict;
use warnings;
use 5.010;
use Data::Dumper;
use FindBin '$Bin';

use App::Spec;
my $spec = App::Spec->read("$Bin/did-spec.yaml");

my $cmds = $spec->subcommands;
delete $cmds->{_complete};

my $help_all = $spec->usage(
    commands => [],
);

my $description = $spec->description;
$help_all =~ s/(?=^Usage)/$description\n\n/m;

my @helps;
my @getopt;

my $options = $spec->options;
@$options = ();

for my $cmd (sort keys %$cmds) {
    my $cmd_spec = $cmds->{ $cmd };
    my $name = $spec->name;

    my $help = $spec->usage(
        commands => [$cmd],
    );
    my $rev_parse = $help;

    $help = <<"EOM";
help:$cmd() \{
  cat <<...
$help
...
\}
EOM
    $rev_parse =~ s/\A.*^Usage:/ /ms;
    if ($rev_parse =~ s/(?<=Options:\n)(.*)/--\n/s) {
        my $options = $1;
        my @options = split "\n", $options;
        for my $line (@options) {
            my ($names) = $line =~ s/^((?: ?--?\w+)+)//;
            $names = $1;
            my @names = split ' ', $names;
            s/^--?// for @names;
            $line = join(",", reverse @names) . $line;
        }
        $rev_parse .= join "\n", @options;
    }
    $rev_parse = <<"EOM";
getopt:$cmd() \{
    GETOPT_SPEC="\\
$rev_parse
"
\}
EOM
    push @helps, $help;
    push @getopt, $rev_parse;
}
my $helps = join "\n", @helps;
my $getopt = join "\n", @getopt;

my $body = <<'EOM';
#!/usr/bin/env bash

source "$(dirname $BASH_SOURCE)/../lib/use.bash"

main() {
  if [[ $# -eq 0 ]]; then
    overview
  else
    command="$1"; shift
    [[ $command =~ ^[a-zA-Z]+$ ]] ||
      die "Invalid help topic: '$command'"
    [[ $# -eq 0 ]] ||
      die "Unknown arguments: '$@'"
    can help:$command ||
      die "No help for command: '$command'"
    "help:$command"
  fi
}
EOM

$body .= <<"EOM";

overview() \{
  cat <<...
$help_all
...
\}

$helps

$getopt
EOM
$body .= <<'EOM';

[[ $0 != "$BASH_SOURCE" ]] || main "$@"

# vim: set ft=sh lisp:
EOM

print $body;
