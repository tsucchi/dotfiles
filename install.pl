#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;
use File::Spec;
use Cwd;
use File::Copy;

#
# ~/dotfiles 以下にドットファイルを置いた前提で、それをホームディレクトリにインストールします
my $home =  $ENV{HOME};
my $work_dir = File::Spec->catdir($home, 'dotfiles');
die "current directory is not $work_dir" if ( getcwd() ne $work_dir );

my $my_program = basename($0);
opendir(my $dir, '.');
my @dotfiles = grep { $_ ne $my_program} grep { $_ !~ /\A\.\.?\z/xms } readdir($dir);
closedir($dir);


for my $dotfile ( @dotfiles ) {
    my $newfile = File::Spec->catfile($home, $dotfile);
    unlink $newfile if ( -e $newfile );
    copy $dotfile, $newfile or die $!;
}
