# debian-sopcast

Automated installation of sopcast-player for Debian

## How to install sopcast-player and related tools in Debian

1. clone this repository
2. install GNU make if you don't have it onboard already (`apt-get install make`)
3. run `make`

This will install sopcast-player and sp-sc-auth in /usr/local/bin


## Why this Makefile?

After upgrading my system to Debian Jessie I found myself with neither sopcast-player nor the sp-sc-auth tool needed to watch sopcast streams. I found [this post on the Problem Solved blog](http://ronlut.blogspot.no/2014/06/installing-sopcast-on-debian-jessie-64.html) that was rather interesting and I thought I wanted to automate it, so that I didn't need to refer to that page any more and, in addition, I had a reproducible setup. And there we go.

## References:

* http://ronlut.blogspot.no/2014/06/installing-sopcast-on-debian-jessie-64.html
* http://sopcast.com
