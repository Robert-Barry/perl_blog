#!/usr/bin/perl

use CGI;
use DBI;


# Use the DBI module to access the web site
my $drh = DBI->install_driver("mysql");
my $dsn = "DBI:mysql:database=####;host=####";
my $dbh = DBI->connect($dsn, '####', '####', { RaiseError => 1, AutoCommit => 0 });

my $cgi = CGI->new;
my $blog_title = $cgi->param('blog_title');
my $blog_post = $cgi->param('blog_post');

if ($blog_title and $blog_post) {
	# SQL to add art and title to the database
	my $query = $dbh->prepare("INSERT INTO blog (title, post) VALUES(?, ?)");
	$query->execute( $blog_title, $blog_post );
	if ($query->err) {
		$error  = "ERROR: The item was not added.";
		print $error;
	}
	my $id = $query = $dbh->prepare("SELECT id FROM blog WHERE title=?");
	$id->execute( $blog_title );
	my @data = $id->fetchrow_array();
	$dbh->disconnect;
	print $cgi->redirect('http://www.robertbarry.net/perl_blog/post.pl?postid=' . $data[0]);
} else {
	$dbh->disconnect;
	print $cgi->redirect('http://www.robertbarry.net/perl_blog/newpost.pl?error=1');
}

