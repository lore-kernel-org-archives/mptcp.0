Content-Type: multipart/mixed; boundary="===============5212624310563816527=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Status and what's next
Date: Sat, 24 Mar 2018 12:47:46 -0700
Message-ID: <alpine.OSX.2.21.1803241236490.21805@siradov-mobl.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 406

--===============5212624310563816527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello everyone -

In our recent web conference call, we thought it would be helpful to =

summarize what is coming up for MPTCP upstreaming. To start, I'd like to =

review work that's already been done and is underway.

Previous work:

* Mat developed an extensible TCP option framework patch, and Christoph =

refactored upstream TCP-MD5 and SMC functionality to use it. The idea was =

to integrate some extensions in to TCP that had utility for existing =

functionality, but would also help integrate MPTCP. This RFC patch set was =

turned down by Dave Miller, but did give us useful guidance.

* Mat published a proposal for optionally extending sk_buff shared info to =

carry MPTCP metadata.


Ongoing work:

* Christoph keeps the multipath-tcp.org kernel merged with recent kernel =

releases as part of his maintainership role for the multipath-tcp.org =

project, and is refactoring parts of the MPTCP implementation to take =

advantage of newer kernel or TCP features and to align with upstreaming =

goals.

* Rao has published an RFC patch set based on the multipath-tcp.org MPTCP =

implementation and the current upstream kernel, with modifications to make =

the TCP implementation extensible in a way that's useful for MPTCP. It is =

currently under review by community members.

* Matthieu has sent a generic netlink patch set to mptcp-dev.

* Ossama shared a generic netlink path management API proposal. The Intel =

group developed this before we knew Matthieu would be sharing an =

implementation.

* Stephan shared a userspace path manager draft implementation at =

https://github.com/brenns10/pathmand

* Peter and Mat are preparing a patch set showing an MPTCP architecture =

with a separate socket type for the MPTCP connection and using in-kernel =

TCP sockets for subflows. The extended sk_buff structure patch is part of =

this.

* Ossama has made significant progress on a userspace path manager =

implementation with the goal to open source it

That gives us quite a bit to discuss and review on the list in the near =

term. The bigger and longer-term challenge is to take these pieces and =

develop a strategy and patches for upstream submissions.


There are a few things the MPTCP upstreaming community members on this =

list seem aligned on:

* MPTCP belongs in the upstream kernel

* The multipath-tcp.org implementation is not upstream-ready as-is

* Implementing 100% from scratch is not the preferred strategy


How do we get to upstreamable patch sets from here? I think if we can =

agree on what an upstreamable MPTCP architecture looks we can evaluate =

patch sets accordingly. I've proposed these design characteristics before, =

but the mailing list has expanded significantly since then:

* MPTCP is used when requested by the application, either through an =

IPPROTO_MPTCP parameter to socket() or by using the new ULP (Upper Layer =

Protocol) capability.

* Move away from meta-sockets, treating each subflow more like a regular =

TCP connection. The overall MPTCP connection is coordinated by an upper =

layer socket that is distinct from tcp_sock.

* Move functionality to userspace where possible, like tracking ADD_ADDRs =

received, initiating new subflows, or accepting new subflows.

* Avoid adding locks to coordinate access to data that's shared between =

subflows. Utilize capabilities like compare-and-swap (cmpxchg), atomics, =

and RCU to deal with shared data efficiently.

Are these the right place to start? Anyone want to expand the list?


Thanks,

--
Mat Martineau
Intel OTC

--===============5212624310563816527==--
