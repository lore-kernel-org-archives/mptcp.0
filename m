Content-Type: multipart/mixed; boundary="===============1854856973962545732=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] MPTCP architecture proposal - RFCv6 changes pushed
Date: Thu, 07 Feb 2019 16:54:33 -0800
Message-ID: <alpine.OSX.2.21.1902071646530.2127@mjmartin-mac01.sea.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 995

--===============1854856973962545732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello -

I've pushed the latest revision of the MPTCP kernel architecture proposal =

to these locations:

https://review.gerrithub.io/q/project:multipath-tcp%252Fmptcp_net-next+stat=
us:open

https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git/log/?h=
=3Dmptcp-proposal

If anyone would like for me to continue posting the patches directly to =

this mailing list, please let me know and I will do so.

I've implemented the recommendations from various review comments on =

gerrithub, cleaned up most of the checkpatch.pl issues, and fixed some of =

the problems Florian identified in his review. I have not yet fixed up all =

the reverse-xmas-tree declarations, or included Florian's changes from =

earlier today. I'll be getting to those next but wanted to publish this =

snapshot first.


Thanks,

--
Mat Martineau
Intel

--===============1854856973962545732==--
