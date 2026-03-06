#!/usr/bin/env perl

use LWP::UserAgent ();
use HTTP::CookieJar::LWP ();

use strict;
use warnings;

my $jar = HTTP::CookieJar::LWP->new;
my $ua = LWP::UserAgent->new(
    agent => 'curl/7.68.0',
    keep_alive => 1,
    cookie_jar => $jar,
    ssl_opts => { verify_hostname => 1 }
);

# Debug
$ua->default_header('Accept-Encoding' => scalar HTTP::Message::decodable());
$ua->add_handler("request_send",  sub { shift->dump; return });
$ua->add_handler("response_done", sub { shift->dump; return });


#my $response = $ua->get("http://192.168.0.160/pmda_mpmda");
my $response = $ua->get("https://webbook.nist.gov");

if ($response->is_success) {
    print $response->decoded_content;
} else {
    die $response->status_line;
}

