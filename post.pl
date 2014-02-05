#!/usr/bin/perl

use strict;

use CGI;
use DBI;

# Use the DBI module to access the web site
my $drh = DBI->install_driver("mysql");
my $dsn = "DBI:mysql:database=####;host=####";
my $dbh = DBI->connect($dsn, '####', '####', { RaiseError => 1, AutoCommit => 0 });

my $cgi = CGI->new;
my $id = $cgi->param('postid');

my $post = $dbh->prepare("SELECT * FROM blog WHERE id=?");
$post->execute( $id );
my @data = $post->fetchrow_array();
$dbh->disconnect;

my ($id, $date, $title, $content) = @data;

print $cgi->header('text/html');
print "<h1>$title</h1>";
print "$date<br>";
print "<p>$content</p>";