#!/usr/bin/perl

use strict;
use warnings;
use LWP::Simple;

print "Welcome to Switch-to-Linux Assistant!\n";

print "Which Linux distro would you like to install?\n";
print "1. Ubuntu\n2. Fedora\n3. Debian\n";
print "Enter number: ";
my $choice = <STDIN>;
chomp $choice;

my %iso_urls = (
    1 => "https://releases.ubuntu.com/24.04/ubuntu-24.04-desktop-amd64.iso",
    2 => "https://download.fedoraproject.org/pub/fedora/linux/releases/40/Workstation/x86_64/iso/Fedora-Workstation-Live-x86_64-40-1.14.iso",
    3 => "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.5.0-amd64-netinst.iso"
);

my $iso_url = $iso_urls{$choice} or die "Invalid choice\n";
print "Downloading ISO from $iso_url\n";
my $file = "linux.iso";
getstore($iso_url, $file) == 200 or die "Download failed\n";
print "Downloaded ISO as $file\n";

print "\nTo backup important files, you can use our C utility:\n";
print "Compile it with: gcc backup_files.c -o backup_files\n";
print "Then run: backup_files <source> <destination>\n";

print "\nNext, please use Rufus (https://rufus.ie) to write $file to your USB drive.\n";
print "Backup your data before proceeding!\n";
