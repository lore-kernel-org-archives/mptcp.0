Content-Type: multipart/mixed; boundary="===============4526330344526673048=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/3] MAINTAINERS: Add MPTCP maintainer
Date: Thu, 05 Dec 2019 15:05:59 -0800
Message-ID: <20191205230601.21396-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2802

--===============4526330344526673048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When we discussed maintainership in an earlier meeting
(https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/thread/HCII2622G=
WZCOMQCBOMQBJKZI247YIH5/)
there was a loose consensus that it would be best to have multiple
maintainers. I nominate Matthieu Baerts <matthieu.baerts(a)tessares.net>
as a co-maintainer, what do you think?

squashto: mptcp: Add MPTCP to skb extensions
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8608724835dd..0576b17abd44 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11538,6 +11538,12 @@ F:	net/ipv6/calipso.c
 F:	net/netfilter/xt_CONNSECMARK.c
 F:	net/netfilter/xt_SECMARK.c
 =

+NETWORKING [MPTCP]
+M:	Mat Martineau <mathew.j.martineau(a)linux.intel.com>
+L:	netdev(a)vger.kernel.org
+S:	Maintained
+F:	include/net/mptcp.h
+
 NETWORKING [TCP]
 M:	Eric Dumazet <edumazet(a)google.com>
 L:	netdev(a)vger.kernel.org
-- =

2.24.0

--===============4526330344526673048==--
