Content-Type: multipart/mixed; boundary="===============0042676543570005980=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 2/5] mptcp: use a single sub_option field in
 mptcp_incoming_option
Date: Fri, 24 Apr 2020 19:14:09 +0200
Message-ID: <0f0d58c4ceb3712f3e4d305e96bd2345cb369b95.1587738345.git.pabeni@redhat.com>
In-Reply-To: cover.1587738345.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4240

--===============0042676543570005980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

So that we can clear all the flags with a single assignment.
No functional change intended, this will just make next patch
more readable.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/linux/tcp.h  | 19 ++++++-------------
 net/mptcp/options.c  |  2 +-
 net/mptcp/protocol.h | 20 ++++++++++----------
 3 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index f24b25e50b30..b2b34db4f424 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -86,14 +86,11 @@ struct mptcp_options_received {
 	u64	data_seq;
 	u32	subflow_seq;
 	u16	data_len;
-	u16	mp_capable : 1,
-		mp_join : 1,
-		dss : 1,
-		add_addr : 1,
-		rm_addr : 1,
-		family : 4,
+	u8	sub_options;
+	u8	family: 4,
 		echo : 1,
-		backup : 1;
+		backup : 1,
+		__unused : 2;
 	u32	token;
 	u32	nonce;
 	u64	thmac;
@@ -105,7 +102,7 @@ struct mptcp_options_received {
 		use_ack:1,
 		ack64:1,
 		mpc_map:1,
-		__unused:2;
+		__unused2:2;
 	u8	addr_id;
 	u8	rm_id;
 	union {
@@ -144,11 +141,7 @@ struct tcp_options_received {
 static inline void mptcp_init_options(struct tcp_options_received *rx_opt)
 {
 #if IS_ENABLED(CONFIG_MPTCP)
-	rx_opt->mptcp.mp_capable =3D 0;
-	rx_opt->mptcp.mp_join =3D 0;
-	rx_opt->mptcp.add_addr =3D 0;
-	rx_opt->mptcp.rm_addr =3D 0;
-	rx_opt->mptcp.dss =3D 0;
+	rx_opt->mptcp.sub_options =3D 0;
 #endif
 }
 =

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index e8a7c141836e..27e2ef63edcb 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -843,7 +843,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 #endif
 		if (!mp_opt->echo)
 			mptcp_pm_add_addr_received(msk, &addr);
-		mp_opt->add_addr =3D 0;
+		mp_opt->sub_options &=3D ~BIT(MPTCPOPT_ADD_ADDR);
 	}
 =

 	if (!mptcp_option_dss(opt_rx))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 451315c0dfe3..b61373933972 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -100,61 +100,61 @@ static inline __be32 mptcp_option(u8 subopt, u8 len, =
u8 nib, u8 field)
 static inline void
 mptcp_option_set_mp_capable(struct tcp_options_received *opt_rx)
 {
-	opt_rx->mptcp.mp_capable =3D 1;
+	opt_rx->mptcp.sub_options |=3D BIT(MPTCPOPT_MP_CAPABLE);
 }
 =

 static inline void
 mptcp_option_set_mp_join(struct tcp_options_received *opt_rx)
 {
-	opt_rx->mptcp.mp_join =3D1;
+	opt_rx->mptcp.sub_options |=3D BIT(MPTCPOPT_MP_JOIN);
 }
 =

 static inline void
 mptcp_option_set_dss(struct tcp_options_received *opt_rx)
 {
-	opt_rx->mptcp.dss =3D 1;
+	opt_rx->mptcp.sub_options |=3D BIT(MPTCPOPT_DSS);
 }
 =

 static inline void
 mptcp_option_set_add_addr(struct tcp_options_received *opt_rx)
 {
-	opt_rx->mptcp.add_addr =3D 1;
+	opt_rx->mptcp.sub_options |=3D BIT(MPTCPOPT_ADD_ADDR);
 }
 =

 static inline void
 mptcp_option_set_rm_addr(struct tcp_options_received *opt_rx)
 {
-	opt_rx->mptcp.rm_addr =3D 1;
+	opt_rx->mptcp.sub_options |=3D BIT(MPTCPOPT_RM_ADDR);
 }
 =

 static inline bool
 mptcp_option_mp_capable(const struct tcp_options_received *opt_rx)
 {
-	return opt_rx->mptcp.mp_capable;
+	return !!(opt_rx->mptcp.sub_options & BIT(MPTCPOPT_MP_CAPABLE));
 }
 =

 static inline bool
 mptcp_option_mp_join(const struct tcp_options_received *opt_rx)
 {
-	return opt_rx->mptcp.mp_join;
+	return !!(opt_rx->mptcp.sub_options & BIT(MPTCPOPT_MP_JOIN));
 }
 =

 static inline bool
 mptcp_option_dss(const struct tcp_options_received *opt_rx)
 {
-	return opt_rx->mptcp.dss;
+	return !!(opt_rx->mptcp.sub_options & BIT(MPTCPOPT_DSS));
 }
 =

 static inline bool
 mptcp_option_add_addr(const struct tcp_options_received *opt_rx)
 {
-	return opt_rx->mptcp.add_addr;
+	return !!(opt_rx->mptcp.sub_options & BIT(MPTCPOPT_ADD_ADDR));
 }
 =

 static inline bool
 mptcp_option_rm_add(const struct tcp_options_received *opt_rx)
 {
-	return opt_rx->mptcp.rm_addr;
+	return !!(opt_rx->mptcp.sub_options & BIT(MPTCPOPT_RM_ADDR));
 }
 =

 #define MPTCP_PM_MAX_ADDR	4
-- =

2.21.1

--===============0042676543570005980==--
