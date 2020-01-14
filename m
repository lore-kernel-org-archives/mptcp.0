Content-Type: multipart/mixed; boundary="===============8258690448995174640=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 9th of January 2020
Date: Tue, 14 Jan 2020 15:12:21 -0800
Message-ID: <alpine.OSX.2.21.2001141504220.22998@ndoyal-mobl1.amr.corp.intel.com>
In-Reply-To: a1ec0492-40c0-97bf-f4c2-860db5199c1f@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3355

--===============8258690448995174640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 9 Jan 2020, Matthieu Baerts wrote:

> Netdev 0x14:
>    - Submission deadline 15-Jan-2020. =

> https://netdevconf.info/0x14/submit-proposal.html
>    - Conference 17-20 March
>    - Recycled talks not accepted
>    - Ideas?:
>        - Practical MPTCP - interoperability and effects of v1 protocol =

> choice, userspace API (converting apps, socket option limitations/details=
), =

> current upstream feature set
>        - Selftest & MPTCP
>        - mptcpd (part of userspace API?)
>    - Mat and Peter are not "far", they might go
>    - harder for people in Europe

To follow up on a possible netdev conf talk, Ossama and I are thinking of =

the following proposal. Feedback welcome! The submission deadline is =

coming up tomorrow.

"""
Title TBD (MPTCP Upstream for users, admins, and distros ?)

Multipath TCP patches are now being merged for inclusion in the Linux =

kernel, v5.6 and later. A community effort has been ongoing to develop an =

upstream-friendly kernel patch set, with out-of-tree patches available =

that implement MPTCP capability according to RFC 8684 (MPTCP =

v1).=C2=A0Complementing this set of kernel patches is a user-space referenc=
e =

implementation for the MPTCP generic netlink API called the Multipath TCP =

Daemon, i.e. "mptcpd". The Multipath TCP Daemon provides an extensible =

framework for MPTCP path management.

There are several practical considerations for network developers, system =

administrators, and distribution maintainers who want to use or enable =

MPTCP for their applications or systems:

* Coordination with userspace for operating system, platform, and =

application integration, as well as potentially enabling support for =

user-space path management by configuring the kernel appropriately, and =

installing a MPTCP path management daemon such as mptcpd

* Compatibility between upstream Linux MPTCP (v1 protocol) and other =

implementations

* Opting in to MPTCP with the socket API

* Phased feature introduction for code review and what that means for =

server and client devices over time

We will cover these kernel considerations, report on upstream merge =

progress to date, and introduce the Multipath TCP Daemon to the Linux =

networking community.
"""


--
Mat Martineau
Intel

--===============8258690448995174640==--
