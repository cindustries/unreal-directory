#!/usr/bin/env perl

use strict;
use warnings;
use Path::Tiny;
use FindBin;

my $i = 0;
my %prio = map { $_ => ++$i } qw(
  Tutorials
  Engine
  Games
  Building
  Building/General
);

my %excludes = map { $_ => 1 } qw();

my %directories;

for my $dir (path($FindBin::Dir)->children) {
  next unless $dir->is_dir;
  next if $dir->basename =~ /^\./;
  my $key = $dir->basename;
  my %files;
  for my $file ($dir->children) {
    next unless $file->is_file;
    my $filename = $file->basename;
    next unless $filename =~ /\.md$/;
    $filename =~ s/\.md$//;
    $files{$filename} = $file->slurp;
  }
  $directories{$key} = { %files };
}

my %sorting;

my $j = 1000;
for my $dir (keys %directories) {
  $sorting{$dir} = $prio{$dir} || $j++;
  for my $file (keys %{$directories{$dir}}) {
    $sorting{$dir.'/'.$file} = $prio{$dir.'/'.$file} || $j++;
  }
}

my $content = <<__EOC__;

# Unreal Engine 4 Resource directory

Feel free to make pull requests for the files inside the sub directories of this repositories, do not make pull requests on this README.md

__EOC__

for my $dir (sort { $sorting{$a} <=> $sorting{$b} } keys %directories) {
  my $dirtext = $dir;
  $dirtext =~ s/_/ /g;
  $content .= "\n# ".$dirtext."\n\n";
  for my $file (sort { $sorting{$dir.'/'.$a} <=> $sorting{$dir.'/'.$b} } keys %{$directories{$dir}}) {
    my $filetext = $file;
    $filetext =~ s/_/ /g;
    $content .= "\n## ".$filetext."\n\n";
    $content .= $directories{$dir}->{$file};
    $content .= "\n\n";
  }
}

path('README.md')->spew($content);
