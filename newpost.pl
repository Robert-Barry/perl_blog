#!/usr/bin/perl

use CGI;

my $cgi = CGI->new;

my $error = $cgi->param('error');
my $error_message = '';

if ($error) {
	$error_message = '<p id="error">ERROR: You must include a blog title and content!</p>';
}

print $cgi->header('text/html');
my $html = <<ENDHTML;
<html>
	<head>
		<title>New Post</title>
	</head>
	
	<body>
		<h1>New Post</h1>
		<form name="new_post" id="new_post" action="new_post_check.pl" method="post">
			<p>title <input type="text" name="blog_title" id=""blog_title"></p>
			<p>post<br><textarea name="blog_post" id="blog_post"></textarea></p>
			$error_message
			<input type="submit" name="post_submit" id="post_submit">
		</form>
	</body>
</html>
ENDHTML
print $html;