Content-Type: multipart/mixed; boundary="===============0351098860432631714=="
MIME-Version: 1.0
From: Stephen Brennan <stephen at brennan.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Userspace Path Manager Draft
Date: Thu, 22 Mar 2018 13:41:09 -0700
Message-ID: <20180322204109.GA29903@pride>
X-Status: 
X-Keywords:                  
X-UID: 401

--===============0351098860432631714==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I did not sit in on the meeting since I am feeling sick, so I haven't had a
chance to see whether this is actually a useful contribution. However, over
the past week I've been tinkering with the userspace Generic Netlink
libraries, getting a prototype of what a userspace path manager framework
could look like.

My current idea is built so that it could support multiple path managers,
implemented as shared libraries, which are dynamically loaded at runtime.
There would need to be some policy or logic to decide which connections are
assigned to which path manager; I haven't fleshed out what that looks like.

Without an exact API reference, I simply based the API on what Ossama
proposed last week. To test, I created a dummy kernel path manager which
sends empty Netlink messages. It seems to work so far.

I don't know if those working on the Netlink API have been developing
userspace tooling in parallel, but if not, maybe this will be useful. You
can find it here:

https://github.com/brenns10/pathmand

Hope this is useful!

Stephen


--===============0351098860432631714==--
