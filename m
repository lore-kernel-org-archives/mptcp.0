Content-Type: multipart/mixed; boundary="===============3900235096826529368=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Using do_tcp_sendpages() for MPTCP (?)
Date: Thu, 27 Sep 2018 13:48:48 -0700
Message-ID: <20180927204848.GU1948@MacBook-Pro-19.local>
X-Status: 
X-Keywords:                  
X-UID: 758

--===============3900235096826529368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I am trying to rework our handling of the skb-building in tcp_sendmsg
(avoiding custom function-pointers for select_size,...) to reduce our impact
on regular TCP.

So, I started looking into what it takes to use do_tcp_sendpages when
pushing from the MPTCP-level to the subflow-level.

A problem is that do_tcp_sendpages() only works on subflows that have
SG-support (see the check in tcp_sendpage_locked()).

So, that would be kind of problematic, no?

I'm also not 100% sure how that is handled for the in-kernel TLS :-/


Thanks,
Christoph


--===============3900235096826529368==--
