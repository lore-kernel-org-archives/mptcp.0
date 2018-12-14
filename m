Content-Type: multipart/mixed; boundary="===============2087648871434649050=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v5 12/17] mptcp: Add MPTCP to skb extensions
Date: Fri, 14 Dec 2018 14:27:10 -0800
Message-ID: <20181214222715.23766-13-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20181214222715.23766-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 913

--===============2087648871434649050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add enum value for MPTCP and update config dependencies

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/linux/skbuff.h |  3 +++
 include/net/mptcp.h    | 17 +++++++++++++++++
 net/core/skbuff.c      |  7 +++++++
 net/mptcp/Kconfig      |  1 +
 4 files changed, 28 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b7195402c642..6574f089c8e7 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3907,6 +3907,9 @@ enum skb_ext_id {
 #endif
 #ifdef CONFIG_XFRM
 	SKB_EXT_SEC_PATH,
+#endif
+#if IS_ENABLED(CONFIG_MPTCP)
+	SKB_EXT_MPTCP,
 #endif
 	SKB_EXT_NUM, /* must be last */
 };
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 16052d0b0f3b..cd041f409841 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -51,6 +51,23 @@ static inline struct mptcp_sock *mptcp_sk(const struct s=
ock *sk)
 	return (struct mptcp_sock *)sk;
 }
 =

+/* MPTCP sk_buff private control buffer */
+struct mptcp_skb_cb {
+	refcount_t	refcnt;
+	u64		data_ack;
+	u64		data_seq;
+	u32		subflow_seq;
+	u16		dll;
+	__sum16		checksum;
+	u8		use_map:1,
+			dsn64:1,
+			use_checksum:1,
+			data_fin:1,
+			use_ack:1,
+			ack64:1,
+			__unused:2;
+};
+
 /* MPTCP subflow sock structure */
 struct subflow_sock {
 	/* tcp_sock must be the first member */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 97c574919d26..615eede6fd07 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -70,6 +70,7 @@
 #include <net/checksum.h>
 #include <net/ip6_checksum.h>
 #include <net/xfrm.h>
+#include <net/mptcp.h>
 =

 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -5561,6 +5562,9 @@ static const u8 skb_ext_type_len[] =3D {
 #ifdef CONFIG_XFRM
 	[SKB_EXT_SEC_PATH] =3D SKB_EXT_CHUNKSIZEOF(struct sec_path),
 #endif
+#if IS_ENABLED(CONFIG_MPTCP)
+	[SKB_EXT_MPTCP] =3D sizeof(struct mptcp_skb_cb),
+#endif
 };
 =

 static void *skb_ext_get_ptr(struct skb_ext *ext, enum skb_ext_id id)
@@ -5607,6 +5611,9 @@ static __always_inline unsigned int skb_ext_total_len=
gth(void)
 #endif
 #ifdef CONFIG_XFRM
 		skb_ext_type_len[SKB_EXT_SEC_PATH] +
+#endif
+#if IS_ENABLED(CONFIG_MPTCP)
+		skb_ext_type_len[SKB_EXT_MPTCP] +
 #endif
 		0;
 }
diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index 8e48190e5fed..59f204a31c25 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -2,6 +2,7 @@
 config MPTCP
 	bool "Multipath TCP"
 	depends on INET
+	select SKB_EXTENSIONS
 	---help---
 	  Multipath TCP (MPTCP) connections send and receive data over multiple
 	  subflows in order to utilize multiple network paths. Each subflow
-- =

2.20.0


--===============2087648871434649050==--
