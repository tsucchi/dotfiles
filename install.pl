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
my @dotfiles = grep { $_ =~ /\A\./xms }
               grep { $_ !~ /\A\.\.?\z/xms }
               grep { $_ !~ /\A.gitignore\z/xms } readdir($dir);
closedir($dir);


for my $dotfile ( @dotfiles ) {
    my $newfile = File::Spec->catfile($home, $dotfile);
    my $dotfile_full = File::Spec->catfile($work_dir, $dotfile);
    next if ( -d $dotfile );
    unlink $newfile if ( -l $newfile || -e $newfile );
    symlink $dotfile_full, $newfile or die $!;
}
