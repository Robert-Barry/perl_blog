#!/usr/bin/perl

use CGI;
use DBI;

# Use the DBI module to access the web site
my $drh = DBI->install_driver("mysql");
my $dsn = "DBI:mysql:database=####;host=####";
my $dbh = DBI->connect($dsn, '####', '######', { RaiseError => 1, AutoCommit => 0 });

my $cgi = CGI->new;
print $cgi->header('text/html');

my $page = <<ENDHTML;
<html>
	<head>
		<title>Perl Blog</title>
		<link href="blog.css" rel="stylesheet">
	</head>
	
	<body>
ENDHTML

print $page;

my $id = $cgi->param('postid');

my $posts = $dbh->prepare("SELECT * FROM blog ORDER BY ? DESC LIMIT 10");
$posts->execute( $date );
while (my @data = $posts->fetchrow_array()) {
	my ($id, $date, $title, $content) = @data;

	print "<h1>$title</h1>\n";
	print "$date<br>\n";
	print "<p>$content</p>\n";
}
$dbh->disconnect;

print "</body></html>";

