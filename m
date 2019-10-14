Content-Type: multipart/mixed; boundary="===============2738415732229607548=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2] selftests: fixes and improvements
Date: Tue, 15 Oct 2019 01:04:05 +0200
Message-ID: <20191014230411.1630-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 2115

--===============2738415732229607548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

First a couple of resends, rebased on top of current export
branch.  All commits may be squashed at your discretion.

The last two are new and were not included before.

The commits build on one-another so its possible to take
the resends and defer or drop the last ones.

1. increase tc delay variation to cover more scenarios.
3. check accept/getpeername provide expected sockaddr info.
3. add ipv6 support (disabled via ipv6=3Dfalse in script)
4. randomly disable any combination of gro/tso/gso.
5. allow to run multiple instances of mptcp_connect.sh in parallel.
6. Fix a possible deadlock in the test program where both ends block in
   write(mptcp_sk, ..).

Comments welcome.

These patches are currently queued in
https://git.breakpoint.cc/cgit/fw/mptcp-next.git/log/?h=3Dsendmsg_refactor_=
12

and can be fetched via

git://git.breakpoint.cc/fw/mptcp-next.git sendmsg_refactor_12

Beware, it contains further changes -- you will need to toss the
extra baggage.

--===============2738415732229607548==--
