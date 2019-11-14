Content-Type: multipart/mixed; boundary="===============8511109324350323672=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 1/1] mptcp: Optimize struct mptcp_received_options.
Date: Wed, 13 Nov 2019 22:01:54 -0800
Message-ID: <20191114060154.3451-2-peter.krystad@linux.intel.com>
In-Reply-To: 20191114060154.3451-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2524

--===============8511109324350323672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Re-organize struct mptcp_received_options to be more efficient
with space, reducing size impact to struct tcp_sock.

Remove unneeded flags fields, make version a bit field. Use unions
to reflect that available option space is limited to 28 bytes, not
all options may be received at once. Options that may be received
at the same time are MP_CAPABLE and DSS ack-only or DSS ack-only and
IPv4 ADD_ADDR.

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/linux/tcp.h  |  97 ++++++++++++++++++++++++----------------
 net/mptcp/options.c  | 102 ++++++++++++++++++++++++-------------------
 net/mptcp/pm.c       |   2 +-
 net/mptcp/protocol.h |   2 +-
 4 files changed, 118 insertions(+), 85 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 41730d9bcb32..88245483ce11 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -78,6 +78,62 @@ struct tcp_sack_block {
 #define TCP_SACK_SEEN     (1 << 0)   /*1 =3D peer is SACK capable, */
 #define TCP_DSACK_SEEN    (1 << 2)   /*1 =3D DSACK was received from peer*/
 =

+#if IS_ENABLED(CONFIG_MPTCP)
+struct mptcp_options_received {
+	union {
+		struct {
+			u32	data_ack32;
+			u32	data_seq32;
+			union {
+				struct {
+					u64	sndr_key;
+					u64	rcvr_key;
+				};
+				struct {
+					struct in_addr	addr;
+					u8	addr_id;
+				};
+			};
+		};
+		struct {
+			u64	data_ack;
+			u64	data_seq;
+		};
+		union {
+			struct {
+				u64	thmac;
+				u32	token;
+				u32	nonce;
+				u8	join_id;
+			};
+			u8	hmac[20];
+		};
+#if IS_ENABLED(CONFIG_IPV6)
+		struct in6_addr	addr6;
+#endif
+	};
+	u32	subflow_seq;
+	union {
+		u16	data_len;
+		u8	addr6_id;
+	};
+	u8	mp_capable : 1,
+		mp_join : 1,
+		dss : 1,
+		add_addr : 1,
+		add_addr6 : 1,
+		rm_addr : 1,
+		backup : 1,
+		version : 1;
+	u8	use_map : 1,
+		dsn64 : 1,
+		use_ack : 1,
+		ack64 : 1,
+		data_fin : 1,
+		__unused : 3;
+};
+#endif
+
 struct tcp_options_received {
 /*	PAWS/RTTM data	*/
 	int	ts_recent_stamp;/* Time we stored ts_recent (for aging) */
@@ -96,42 +152,7 @@ struct tcp_options_received {
 	u16	user_mss;	/* mss requested by user in ioctl	*/
 	u16	mss_clamp;	/* Maximal mss, negotiated at connection setup */
 #if IS_ENABLED(CONFIG_MPTCP)
-	struct mptcp_options_received {
-		u64     sndr_key;
-		u64     rcvr_key;
-		u64	data_ack;
-		u64	data_seq;
-		u32	subflow_seq;
-		u16	data_len;
-		u8      mp_capable : 1,
-			mp_join : 1,
-			dss : 1,
-			backup : 1,
-			version : 4;
-		u8      flags;
-		u8      join_id;
-		u32     token;
-		u32     nonce;
-		u64     thmac;
-		u8      hmac[20];
-		u8	dss_flags;
-		u8	use_map:1,
-			dsn64:1,
-			data_fin:1,
-			use_ack:1,
-			ack64:1,
-			__unused:3;
-		u8	add_addr : 1,
-			rm_addr : 1,
-			family : 4;
-		u8	addr_id;
-		union {
-			struct	in_addr	addr;
-#if IS_ENABLED(CONFIG_IPV6)
-			struct	in6_addr addr6;
-#endif
-		};
-	} mptcp;
+	struct mptcp_options_received mptcp;
 #endif
 };
 =

@@ -144,8 +165,8 @@ static inline void tcp_clear_options(struct tcp_options=
_received *rx_opt)
 #endif
 #if IS_ENABLED(CONFIG_MPTCP)
 	rx_opt->mptcp.mp_capable =3D rx_opt->mptcp.mp_join =3D 0;
-	rx_opt->mptcp.add_addr =3D rx_opt->mptcp.rm_addr =3D 0;
-	rx_opt->mptcp.dss =3D 0;
+	rx_opt->mptcp.add_addr =3D rx_opt->mptcp.add_addr6 =3D 0;
+	rx_opt->mptcp.rm_addr =3D rx_opt->mptcp.dss =3D 0;
 #endif
 }
 =

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 80dbe7662cea..fee674fbaaba 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -15,6 +15,8 @@ void mptcp_parse_option(const unsigned char *ptr, int ops=
ize,
 	struct mptcp_options_received *mp_opt =3D &opt_rx->mptcp;
 	u8 subtype =3D *ptr >> 4;
 	int expected_opsize;
+	u8 flags;
+	u8 family;
 =

 	switch (subtype) {
 	/* MPTCPOPT_MP_CAPABLE
@@ -28,13 +30,17 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
 		    opsize !=3D TCPOLEN_MPTCP_MPC_SYNACK)
 			break;
 =

-		mp_opt->version =3D *ptr++ & MPTCP_VERSION_MASK;
+		if ((*ptr & MPTCP_VERSION_MASK) =3D=3D 0)
+			mp_opt->version =3D 0;
+		else if ((*ptr & MPTCP_VERSION_MASK) =3D=3D 1)
+			mp_opt->version =3D 1;
+		ptr++;
 		if (mp_opt->version !=3D 0)
 			break;
 =

-		mp_opt->flags =3D *ptr++;
-		if (!((mp_opt->flags & MPTCP_CAP_FLAG_MASK) =3D=3D MPTCP_CAP_HMAC_SHA1) =
||
-		    (mp_opt->flags & MPTCP_CAP_EXTENSIBILITY))
+		flags =3D *ptr++;
+		if (!((flags & MPTCP_CAP_FLAG_MASK) =3D=3D MPTCP_CAP_HMAC_SHA1) ||
+		    (flags & MPTCP_CAP_EXTENSIBILITY))
 			break;
 =

 		/* RFC 6824, Section 3.1:
@@ -50,7 +56,7 @@ void mptcp_parse_option(const unsigned char *ptr, int ops=
ize,
 		 *
 		 * We don't implement DSS checksum - fall back to TCP.
 		 */
-		if (mp_opt->flags & MPTCP_CAP_CHECKSUM_REQD)
+		if (flags & MPTCP_CAP_CHECKSUM_REQD)
 			break;
 =

 		mp_opt->mp_capable =3D 1;
@@ -60,12 +66,10 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
 		if (opsize =3D=3D TCPOLEN_MPTCP_MPC_SYNACK) {
 			mp_opt->rcvr_key =3D get_unaligned_be64(ptr);
 			ptr +=3D 8;
-			pr_debug("MP_CAPABLE flags=3D%x, sndr=3D%llu, rcvr=3D%llu",
-				 mp_opt->flags, mp_opt->sndr_key,
-				 mp_opt->rcvr_key);
+			pr_debug("MP_CAPABLE sndr=3D%llu, rcvr=3D%llu",
+				 mp_opt->sndr_key, mp_opt->rcvr_key);
 		} else {
-			pr_debug("MP_CAPABLE flags=3D%x, sndr=3D%llu",
-				 mp_opt->flags, mp_opt->sndr_key);
+			pr_debug("MP_CAPABLE sndr=3D%llu", mp_opt->sndr_key);
 		}
 		break;
 =

@@ -132,12 +136,12 @@ void mptcp_parse_option(const unsigned char *ptr, int=
 opsize,
 		pr_debug("DSS");
 		ptr++;
 =

-		mp_opt->dss_flags =3D (*ptr++) & MPTCP_DSS_FLAG_MASK;
-		mp_opt->data_fin =3D (mp_opt->dss_flags & MPTCP_DSS_DATA_FIN) !=3D 0;
-		mp_opt->dsn64 =3D (mp_opt->dss_flags & MPTCP_DSS_DSN64) !=3D 0;
-		mp_opt->use_map =3D (mp_opt->dss_flags & MPTCP_DSS_HAS_MAP) !=3D 0;
-		mp_opt->ack64 =3D (mp_opt->dss_flags & MPTCP_DSS_ACK64) !=3D 0;
-		mp_opt->use_ack =3D (mp_opt->dss_flags & MPTCP_DSS_HAS_ACK);
+		flags =3D (*ptr++) & MPTCP_DSS_FLAG_MASK;
+		mp_opt->data_fin =3D (flags & MPTCP_DSS_DATA_FIN) !=3D 0;
+		mp_opt->dsn64 =3D (flags & MPTCP_DSS_DSN64) !=3D 0;
+		mp_opt->use_map =3D (flags & MPTCP_DSS_HAS_MAP) !=3D 0;
+		mp_opt->ack64 =3D (flags & MPTCP_DSS_ACK64) !=3D 0;
+		mp_opt->use_ack =3D (flags & MPTCP_DSS_HAS_ACK);
 =

 		pr_debug("data_fin=3D%d dsn64=3D%d use_map=3D%d ack64=3D%d use_ack=3D%d",
 			 mp_opt->data_fin, mp_opt->dsn64,
@@ -175,21 +179,23 @@ void mptcp_parse_option(const unsigned char *ptr, int=
 opsize,
 			if (mp_opt->ack64) {
 				mp_opt->data_ack =3D get_unaligned_be64(ptr);
 				ptr +=3D 8;
+				pr_debug("data_ack=3D%llu", mp_opt->data_ack);
 			} else {
-				mp_opt->data_ack =3D get_unaligned_be32(ptr);
+				mp_opt->data_ack32 =3D get_unaligned_be32(ptr);
 				ptr +=3D 4;
+				pr_debug("data_ack=3D%u", mp_opt->data_ack32);
 			}
-
-			pr_debug("data_ack=3D%llu", mp_opt->data_ack);
 		}
 =

 		if (mp_opt->use_map) {
 			if (mp_opt->dsn64) {
 				mp_opt->data_seq =3D get_unaligned_be64(ptr);
 				ptr +=3D 8;
+				pr_debug("data_seq=3D%llu", mp_opt->data_seq);
 			} else {
-				mp_opt->data_seq =3D get_unaligned_be32(ptr);
+				mp_opt->data_seq32 =3D get_unaligned_be32(ptr);
 				ptr +=3D 4;
+				pr_debug("data_seq=3D%u", mp_opt->data_seq32);
 			}
 =

 			mp_opt->subflow_seq =3D get_unaligned_be32(ptr);
@@ -198,9 +204,8 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
 			mp_opt->data_len =3D get_unaligned_be16(ptr);
 			ptr +=3D 2;
 =

-			pr_debug("data_seq=3D%llu subflow_seq=3D%u data_len=3D%u",
-				 mp_opt->data_seq, mp_opt->subflow_seq,
-				 mp_opt->data_len);
+			pr_debug("subflow_seq=3D%u data_len=3D%u",
+				 mp_opt->subflow_seq, mp_opt->data_len);
 		}
 =

 		break;
@@ -215,31 +220,32 @@ void mptcp_parse_option(const unsigned char *ptr, int=
 opsize,
 		if (opsize !=3D TCPOLEN_MPTCP_ADD_ADDR &&
 		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR6)
 			break;
-		mp_opt->family =3D *ptr++ & MPTCP_ADDR_FAMILY_MASK;
-		if (mp_opt->family !=3D MPTCP_ADDR_IPVERSION_4 &&
-		    mp_opt->family !=3D MPTCP_ADDR_IPVERSION_6)
+		family =3D *ptr++ & MPTCP_ADDR_FAMILY_MASK;
+		if (family !=3D MPTCP_ADDR_IPVERSION_4 &&
+		    family !=3D MPTCP_ADDR_IPVERSION_6)
 			break;
 =

-		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4 &&
+		if (family =3D=3D MPTCP_ADDR_IPVERSION_4 &&
 		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR)
 			break;
 #if IS_ENABLED(CONFIG_IPV6)
-		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6 &&
+		if (family =3D=3D MPTCP_ADDR_IPVERSION_6 &&
 		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR6)
 			break;
 #endif
-		mp_opt->addr_id =3D *ptr++;
-		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
+		if (family =3D=3D MPTCP_ADDR_IPVERSION_4) {
 			mp_opt->add_addr =3D 1;
+			mp_opt->addr_id =3D *ptr++;
 			memcpy((u8 *)&mp_opt->addr.s_addr, (u8 *)ptr, 4);
 			pr_debug("ADD_ADDR: addr=3D%x, id=3D%d",
 				 mp_opt->addr.s_addr, mp_opt->addr_id);
 		}
 #if IS_ENABLED(CONFIG_IPV6)
 		else {
-			mp_opt->add_addr =3D 1;
+			mp_opt->add_addr6 =3D 1;
+			mp_opt->addr6_id =3D *ptr++;
 			memcpy(mp_opt->addr6.s6_addr, (u8 *)ptr, 16);
-			pr_debug("ADD_ADDR: addr6=3D, id=3D%d", mp_opt->addr_id);
+			pr_debug("ADD_ADDR: addr6=3D, id=3D%d", mp_opt->addr6_id);
 		}
 #endif
 		break;
@@ -547,15 +553,12 @@ bool mptcp_synack_options(const struct request_sock *=
req, unsigned int *size,
 	return false;
 }
 =

-static u64 expand_ack(u64 old_ack, u64 cur_ack, bool use_64bit)
+static u64 expand_ack(u64 old_ack, u64 cur_ack32)
 {
-	u32 old_ack32, cur_ack32;
-
-	if (use_64bit)
-		return cur_ack;
+	u64 cur_ack;
+	u32 old_ack32;
 =

 	old_ack32 =3D (u32)old_ack;
-	cur_ack32 =3D (u32)cur_ack;
 	cur_ack =3D (old_ack & GENMASK_ULL(63, 32)) + cur_ack32;
 	if (unlikely(before(cur_ack32, old_ack32)))
 		return cur_ack + (1LL << 32);
@@ -572,7 +575,10 @@ static void update_una(struct mptcp_sock *msk,
 	 * wrongly expanding to a future ack sequence number, which is way
 	 * more dangerous than missing an ack
 	 */
-	new_snd_una =3D expand_ack(old_snd_una, mp_opt->data_ack, mp_opt->ack64);
+	if (mp_opt->ack64)
+		new_snd_una =3D mp_opt->data_ack;
+	else
+		new_snd_una =3D expand_ack(old_snd_una, mp_opt->data_ack32);
 =

 	/* ACK for data not even sent yet? Ignore. */
 	if (after64(new_snd_una, write_seq))
@@ -602,15 +608,18 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb,
 =

 	mp_opt =3D &opt_rx->mptcp;
 =

-	if (msk && mp_opt->add_addr) {
-		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4)
+	if (msk) {
+		if (mp_opt->add_addr =3D=3D 1) {
 			mptcp_pm_add_addr(msk, &mp_opt->addr, mp_opt->addr_id);
+			mp_opt->add_addr =3D 0;
+		}
 #if IS_ENABLED(CONFIG_IPV6)
-		else if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6)
+		else if (mp_opt->add_addr6 =3D=3D 1) {
 			mptcp_pm_add_addr6(msk, &mp_opt->addr6,
-					   mp_opt->addr_id);
+					   mp_opt->addr6_id);
+			mp_opt->add_addr6 =3D 0;
+		}
 #endif
-		mp_opt->add_addr =3D 0;
 	}
 =

 	if (!mp_opt->dss)
@@ -629,7 +638,10 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb,
 	memset(mpext, 0, sizeof(*mpext));
 =

 	if (mp_opt->use_map) {
-		mpext->data_seq =3D mp_opt->data_seq;
+		if (mp_opt->dsn64)
+			mpext->data_seq =3D mp_opt->data_seq;
+		else
+			mpext->data_seq =3D mp_opt->data_seq32;
 		mpext->subflow_seq =3D mp_opt->subflow_seq;
 		mpext->data_len =3D mp_opt->data_len;
 		mpext->use_map =3D 1;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d45406bc3f6c..6800f64e4cce 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -259,7 +259,7 @@ int mptcp_pm_get_local_id(struct request_sock *req, str=
uct sock *sk,
 =

 	/* @@ check if address actually matches... */
 =

-	pr_debug("msk=3D%p, addr_id=3D%d", msk, msk->pm.local_id);
+	pr_debug("msk=3D%p, local_id=3D%d", msk, msk->pm.local_id);
 	subflow_req->local_id =3D msk->pm.local_id;
 =

 	return 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 83b06382e56a..a4916632b09d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -208,7 +208,7 @@ struct mptcp_subflow_context {
 	u32	request_mptcp : 1,  /* send MP_CAPABLE */
 		request_join : 1,   /* send MP_JOIN */
 		request_bkup : 1,
-		request_version : 4,
+		request_version : 1,
 		mp_capable : 1,	    /* remote is MPTCP capable */
 		mp_join : 1,	    /* remote is JOINing */
 		fourth_ack : 1,	    /* send initial DSS */
-- =

2.17.2

--===============8511109324350323672==--
