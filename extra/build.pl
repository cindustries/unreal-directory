#!/usr/bin/env perl

use strict;
use warnings;
use Path::Tiny;
use FindBin;

my $readme = path($FindBin::Dir,'..')->child('README.md');

$readme->spew(<<__EOC__);

# Unreal Engine 4 Resource directory

Feel free to make pull requests for the files inside the sub directories of this repositories, do not make pull requests on this README.md

__EOC__

$readme->append((path($FindBin::Dir,'..')->child($_.'.md')->slurp)."\n\n\n\n") for qw(

  Tutorials
  Community
  Events
  Editor
  Tools
  Blueprint
  C++
  Controller
  Level
  HUD
  Building
  Models
  Materials
  Audio
  Effects
  Networking
  BehaviorTree
  Modding
  Publishing
  Monetization
  GameDevelopment
  Assets
  Games

);
