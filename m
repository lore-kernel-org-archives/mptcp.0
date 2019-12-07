Content-Type: multipart/mixed; boundary="===============7818575407405185892=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 1/4] MAINTAINERS: Add MPTCP maintainers
Date: Fri, 06 Dec 2019 16:12:41 -0800
Message-ID: <20191207001244.20339-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2840

--===============7818575407405185892==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Possible other lines include:

L:	mptcp(a)lists.01.org

The issue with including this ML is that it currently rejects messages
from non-subscribers. I can reconfigure the ML, the tradeoff is in
forwarding spam to subscribers.

Q:	https://patchwork.ozlabs.org/project/mptcp/list/

It might be confusing for patches to end up in two patchworks (netdev
and mptcp).

T:	git git://github.com/multipath-tcp/mptcp_net-next.git

I've seen two main models for net subsystem management:

netdev-based (TCP, TLS): Patches are sent to netdev, approved by
subsystem maintainers, and approved and applied by David Miller.

subtree (netfilter, BPF, bluetooth, wireless): Messages are sent to
netdev (netfilter/BPF) or a separate ML (bluetooth, wireless) and are
approved and merged to separate git repositories by subsystem
maintainers. Those maintainers then send pull requests for batches of
commits to netdev for David Miller to merge directly in git.

The scope of MPTCP seems more like the other netdev-based projects, so
for changes going directly upstream I've proposed MAINTAINERS entries
that match that development model. If we opt to use our own git repo to
merge upstream changes and then send pull requests, then we would
include the "T:" entry for our github repo.

squashto: mptcp: Add MPTCP to skb extensions
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8608724835dd..97a922599b78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11538,6 +11538,15 @@ F:	net/ipv6/calipso.c
 F:	net/netfilter/xt_CONNSECMARK.c
 F:	net/netfilter/xt_SECMARK.c
 =

+NETWORKING [MPTCP]
+M:	Mat Martineau <mathew.j.martineau(a)linux.intel.com>
+M:	Matthieu Baerts <matthieu.baerts(a)tessares.net>
+L:	netdev(a)vger.kernel.org
+W:	https://github.com/multipath-tcp/mptcp_net-next/wiki
+B:	https://github.com/multipath-tcp/mptcp_net-next/issues
+S:	Maintained
+F:	include/net/mptcp.h
+
 NETWORKING [TCP]
 M:	Eric Dumazet <edumazet(a)google.com>
 L:	netdev(a)vger.kernel.org
-- =

2.24.0

--===============7818575407405185892==--
