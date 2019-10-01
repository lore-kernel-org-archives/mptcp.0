Content-Type: multipart/mixed; boundary="===============5078795146406516922=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] RFCv2 for netdev: what's missing?
Date: Tue, 01 Oct 2019 16:37:45 +0200
Message-ID: <0af3b2f0-48cc-ccba-7d50-dd98e2009257@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1949

--===============5078795146406516922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

At the last meeting, we said it would be good to send a new RFCv2 to
netdev before the next meeting while windows are closed. I guess today
would be good, no?

What do we still need to do?
- the cover letter: Mat is it still OK to do it on your side?
- any other patches to apply before this?

Here are the pending patches:
- mptcp: Interim Path Manager: Waiting for accept (last review)
- mptcp_poll should not block on each subflow: Waiting for review
- mptcp: allow dumping subflow context to userspace: can be applied
- selftests: prepare for mptcp ipv6 support: Waiting for accept (last
review)
- mptcp: Remove all traces of checksum support: do we want it?
- mptcp: add MIB counter infrastructure: Waiting for accept (last review)
- mptcp: allow MPTCP sockets by default: can be applied
- mptcp: prefix mptcp_ to exposed pm_ routines.

For the moment, I am blocked with "mptcp: Remove all traces of checksum
support" but I can drop this rebase to work on other patches if others
are required for the RFCv2.

What's your point of view on this?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5078795146406516922==--
