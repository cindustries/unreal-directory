#!/usr/bin/env perl

use strict;
use warnings;
use Path::Tiny;
use FindBin;

my $readme = path('README.md');

$readme->spew(<<__EOC__);

# Unreal Engine 4 Resource directory

Feel free to make pull requests for the files inside the sub directories of this repositories, do not make pull requests on this README.md

__EOC__

$readme->append(path($FindBin::Dir)->child($_.'.md')->slurp) for qw(

  Tutorials
  Editor
  Blueprint
  C++
  Controller
  Level
  Building
  Models
  Materials
  Publishing
  Assets
  Games

);
