Content-Type: multipart/mixed; boundary="===============4308571127335830311=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v7 06/11] mptcp: Add MPTCP to skb extensions
Date: Thu, 09 Jan 2020 07:59:19 -0800
Message-ID: <20200109155924.30122-7-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200109155924.30122-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3320

--===============4308571127335830311==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add enum value for MPTCP and update config dependencies

v5 -> v6:
 - fixed '__unused' field size

Co-developed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 MAINTAINERS            | 10 ++++++++++
 include/linux/skbuff.h |  3 +++
 include/net/mptcp.h    | 28 ++++++++++++++++++++++++++++
 net/core/skbuff.c      |  7 +++++++
 4 files changed, 48 insertions(+)
 create mode 100644 include/net/mptcp.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 66a2e5e07117..7fa1d9ae571b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11573,6 +11573,16 @@ F:	net/ipv6/calipso.c
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
index 64e5b1be9ff5..f5c27600b410 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4096,6 +4096,9 @@ enum skb_ext_id {
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
index 000000000000..326043c29c0a
--- /dev/null
+++ b/include/net/mptcp.h
@@ -0,0 +1,28 @@
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
+			__unused:3;
+	/* one byte hole */
+};
+
+#endif /* __NET_MPTCP_H */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 44b0894d8ae1..a4106da23c34 100644
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

--===============4308571127335830311==--
