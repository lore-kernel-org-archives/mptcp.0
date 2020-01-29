Content-Type: multipart/mixed; boundary="===============7688533545999679103=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] Revert "MAINTAINERS: mptcp@ mailing list is
 moderated"
Date: Wed, 29 Jan 2020 09:41:37 -0800
Message-ID: <20200129174137.22948-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3552

--===============7688533545999679103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This reverts commit 74759e1693311a8d1441de836c4080c192374238.

mptcp(a)lists.01.org accepts messages from non-subscribers. There was an
invisible and unexpected server-wide rule limiting the number of
recipients for subscribers and non-subscribers alike, and that has now
been turned off for this list.

Cc: Randy Dunlap <rdunlap(a)infradead.org>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 58e4eb554d0e..d51ce1a0a817 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11641,7 +11641,7 @@ NETWORKING [MPTCP]
 M:	Mat Martineau <mathew.j.martineau(a)linux.intel.com>
 M:	Matthieu Baerts <matthieu.baerts(a)tessares.net>
 L:	netdev(a)vger.kernel.org
-L:	mptcp(a)lists.01.org (moderated for non-subscribers)
+L:	mptcp(a)lists.01.org
 W:	https://github.com/multipath-tcp/mptcp_net-next/wiki
 B:	https://github.com/multipath-tcp/mptcp_net-next/issues
 S:	Maintained
-- =

2.25.0

--===============7688533545999679103==--
