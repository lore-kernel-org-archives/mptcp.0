Content-Type: multipart/mixed; boundary="===============6515310322994543565=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] MPTCP Linux upstreaming introduction
Date: Sun, 09 Apr 2017 13:18:34 -0400
Message-ID: <alpine.OSX.2.21.1704091318010.32374@mjmartin-mac01.local>
X-IMAPbase: 1616104606 8212
X-Status: 
X-Keywords:                    
X-UID: 1

--===============6515310322994543565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Welcome to the MPTCP upstreaming mailing list!

This list (mptcp(a)lists.01.org) is focused on integrating MPTCP (RFC 6824 =
/ =

RFC 6824bis) as part of the standard
Linux kernel. In speaking with the Linux networking / TCP maintainers, it =

is important that MPTCP does not
interfere with the performance or reliability of the TCP stack, or =

complicate the existing TCP code.

Given the Linux netdev maintainer's needs, we have the following =

high-level design goals in mind:

* Minimize changes to core TCP.

* Favor atomic operations and RCU synchronization over more expensive =

options like mutexes or spinlocks.

* Implement features in userspace where latency isn't important and data =

flow is not affected

* TCP operates as "normal TCP" by default. Individual sockets may opt-in, =

or systemwide configuration can be
used to broadly enable MPTCP.

The role of this list is to coordinate upstreaming efforts and share code =

prior to upstream submission on
netdev(a)lists.01.org . This list is separate from the mptcp-dev list =

associated with the multipath-tcp.org
kernel in order to avoid confusion between netdev-focused efforts and work =

related to multipath-tcp.org .
Anyone interested in MPTCP for the upstream kernel is welcome on =

mptcp(a)lists.01.org, we appreciate your
expertise and contributions!

You can manage your subscription or view list archives at =

https://lists.01.org/mailman/listinfo/mptcp

Best regards,

--
Mat Martineau
Intel OTC

--===============6515310322994543565==--
