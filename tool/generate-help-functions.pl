#!/usr/bin/perl
# vim:et:sts=4:sws=4:sw=4
use strict;
use warnings;
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

my $options = $spec->options;
@$options = ();

for my $cmd (sort keys %$cmds) {
    my $cmd_spec = $cmds->{ $cmd };
    my $help = $spec->usage(
        commands => [$cmd],
    );
    $help = <<"EOM";
help:$cmd() \{
  cat <<...
$help
...
\}
EOM
    push @helps, $help;
}
my $helps = join "\n", @helps;

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
EOM
$body .= <<'EOM';

[[ $0 != "$BASH_SOURCE" ]] || main "$@"

# vim: set ft=sh lisp:
EOM

print $body;
