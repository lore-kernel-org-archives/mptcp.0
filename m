Content-Type: multipart/mixed; boundary="===============5554000301929764355=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 06/11] mptcp: Add MPTCP to skb extensions
Date: Mon, 16 Dec 2019 16:24:50 -0800
Message-ID: <20191217002455.24849-7-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191217002455.24849-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3102

--===============5554000301929764355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add enum value for MPTCP and update config dependencies

Co-developed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 MAINTAINERS            | 10 ++++++++++
 include/linux/skbuff.h |  3 +++
 include/net/mptcp.h    | 27 +++++++++++++++++++++++++++
 net/core/skbuff.c      |  7 +++++++
 4 files changed, 47 insertions(+)
 create mode 100644 include/net/mptcp.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a28c77ee6b0d..132eb3f9fbb7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11568,6 +11568,16 @@ F:	net/ipv6/calipso.c
 F:	net/netfilter/xt_CONNSECMARK.c
 F:	net/netfilter/xt_SECMARK.c
 =

+NETWORKING [MPTCP]
+M:	Mat Martineau <mathew.j.martineau(a)linux.intel.com>
+M:	Matthieu Baerts <matthieu.baerts(a)tessares.net>
+L:	netdev(a)vger.kernel.org
+L:	mptcp(a)lists.01.org
+W:	https://github.com/multipath-tcp/mptcp_net-next/wiki
+B:	https://github.com/multipath-tcp/mptcp_net-next/issues
+S:	Maintained
+F:	include/net/mptcp.h
+
 NETWORKING [TCP]
 M:	Eric Dumazet <edumazet(a)google.com>
 L:	netdev(a)vger.kernel.org
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index e9133bcf0544..1a261c3ee074 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4091,6 +4091,9 @@ enum skb_ext_id {
 #endif
 #if IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
 	TC_SKB_EXT,
+#endif
+#if IS_ENABLED(CONFIG_MPTCP)
+	SKB_EXT_MPTCP,
 #endif
 	SKB_EXT_NUM, /* must be last */
 };
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
new file mode 100644
index 000000000000..f9f668ac4339
--- /dev/null
+++ b/include/net/mptcp.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Multipath TCP
+ *
+ * Copyright (c) 2017 - 2019, Intel Corporation.
+ */
+
+#ifndef __NET_MPTCP_H
+#define __NET_MPTCP_H
+
+#include <linux/types.h>
+
+/* MPTCP sk_buff extension data */
+struct mptcp_ext {
+	u64		data_ack;
+	u64		data_seq;
+	u32		subflow_seq;
+	u16		data_len;
+	u8		use_map:1,
+			dsn64:1,
+			data_fin:1,
+			use_ack:1,
+			ack64:1,
+			__unused:2;
+};
+
+#endif /* __NET_MPTCP_H */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 973a71f4bc89..fa67036dd928 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -68,6 +68,7 @@
 #include <net/ip6_checksum.h>
 #include <net/xfrm.h>
 #include <net/mpls.h>
+#include <net/mptcp.h>
 =

 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -4109,6 +4110,9 @@ static const u8 skb_ext_type_len[] =3D {
 #if IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
 	[TC_SKB_EXT] =3D SKB_EXT_CHUNKSIZEOF(struct tc_skb_ext),
 #endif
+#if IS_ENABLED(CONFIG_MPTCP)
+	[SKB_EXT_MPTCP] =3D SKB_EXT_CHUNKSIZEOF(struct mptcp_ext),
+#endif
 };
 =

 static __always_inline unsigned int skb_ext_total_length(void)
@@ -4122,6 +4126,9 @@ static __always_inline unsigned int skb_ext_total_len=
gth(void)
 #endif
 #if IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
 		skb_ext_type_len[TC_SKB_EXT] +
+#endif
+#if IS_ENABLED(CONFIG_MPTCP)
+		skb_ext_type_len[SKB_EXT_MPTCP] +
 #endif
 		0;
 }
-- =

2.24.1

--===============5554000301929764355==--
