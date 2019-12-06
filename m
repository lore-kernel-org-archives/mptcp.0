Content-Type: multipart/mixed; boundary="===============6683801497850148447=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Cover letters for part1/part2 netdev patchsets
Date: Thu, 05 Dec 2019 16:41:59 -0800
Message-ID: <alpine.OSX.2.21.1912051635040.57359@pminglan-mobl.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2807

--===============6683801497850148447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello everyone -

As we discussed earlier today, here are draft cover letters for patch set =

parts 1 & 2. Feedback appreciated!


------
Part 1

Subject: [PATCH net-next 0/0] Multipath TCP part 1: Prerequisites

The MPTCP upstreaming community has been collaborating on an
upstreamable MPTCP implementation. David requested that we split this
work in to multiple, smaller patch sets to build up MPTCP
infrastructure. The scope of this first patch set is limited to
prerequisite TCP core changes so we can get focused feedback in these
areas.

In this patch set we introduce some MPTCP definitions, additional ULP
and skb extension features, TCP option space checking, and a few
exported symbols.

<git tree references at github>

Thank you for your review. You can find us at mptcp(a)lists.01.org and
https://is.gd/mptcp_upstream


------
Part 2

Subject: [PATCH net-next 0/0] Multipath TCP part 2: Single subflow

These patches depend on the "Multipath TCP part 1: Prerequisites" patch
set sent earlier.

This set adds MPTCP connection establishment, writing & reading MPTCP
options on data packets, a sysctl to allow MPTCP per-namespace, and self
tests. This is sufficient to establish and maintain a connection with a
MPTCP peer, but will not yet allow or initiate establishment of
additional MPTCP subflows.

<git tree references at github>

Thank you for your review. You can find us at mptcp(a)lists.01.org and
https://is.gd/mptcp_upstream


--
Mat Martineau
Intel
--===============6683801497850148447==--
