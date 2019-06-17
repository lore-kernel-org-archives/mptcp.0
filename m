Content-Type: multipart/mixed; boundary="===============7980626945820484558=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v3 2/3] mptcp: Add ADD_ADDR handling
Date: Sun, 16 Jun 2019 21:38:13 -0700
Message-ID: <20190617043814.3470-3-peter.krystad@linux.intel.com>
In-Reply-To: 20190617043814.3470-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1410

--===============7980626945820484558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add handling for sending and receiving the ADD_ADDR, ADD_ADDR6,
and RM_ADDR suboptions.

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/linux/tcp.h  | 11 +++++
 include/net/mptcp.h  | 16 ++++++--
 net/mptcp/options.c  | 98 +++++++++++++++++++++++++++++++++++++++-----
 net/mptcp/pm.c       | 11 ++++-
 net/mptcp/protocol.h | 16 ++++++++
 5 files changed, 138 insertions(+), 14 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 81cfa7834111..b1d2ff2af0c2 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -122,6 +122,16 @@ struct tcp_options_received {
 			use_ack:1,
 			ack64:1,
 			__unused:2;
+		u8	add_addr : 1,
+			rm_addr : 1,
+			family : 4;
+		u8	addr_id;
+		union {
+			struct	in_addr	addr;
+#if IS_ENABLED(CONFIG_IPV6)
+			struct	in6_addr addr6;
+#endif
+		};
 	} mptcp;
 #endif
 };
@@ -135,6 +145,7 @@ static inline void tcp_clear_options(struct tcp_options=
_received *rx_opt)
 #endif
 #if IS_ENABLED(CONFIG_MPTCP)
 	rx_opt->mptcp.mp_capable =3D rx_opt->mptcp.mp_join =3D 0;
+	rx_opt->mptcp.add_addr =3D rx_opt->mptcp.rm_addr =3D 0;
 	rx_opt->mptcp.dss =3D 0;
 #endif
 }
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index e0bd45e49db1..9597cb36d2ae 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -25,15 +25,25 @@ struct mptcp_ext {
 };
 =

 /* MPTCP option subtypes */
-#define OPTION_MPTCP_MPC_SYN	BIT(0)
-#define OPTION_MPTCP_MPC_SYNACK	BIT(1)
-#define OPTION_MPTCP_MPC_ACK	BIT(2)
+#define OPTION_MPTCP_MPC_SYN		BIT(0)
+#define OPTION_MPTCP_MPC_SYNACK		BIT(1)
+#define OPTION_MPTCP_MPC_ACK		BIT(2)
+#define OPTION_MPTCP_ADD_ADDR		BIT(6)
+#define OPTION_MPTCP_ADD_ADDR6		BIT(7)
+#define OPTION_MPTCP_RM_ADDR		BIT(8)
 =

 struct mptcp_out_options {
 #if IS_ENABLED(CONFIG_MPTCP)
 	u16 suboptions;
 	u64 sndr_key;
 	u64 rcvr_key;
+	union {
+		struct in_addr addr;
+#if IS_ENABLED(CONFIG_IPV6)
+		struct in6_addr addr6;
+#endif
+	};
+	u8 addr_id;
 	struct mptcp_ext ext_copy;
 #endif
 };
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d285a33cd480..3abfa02bbb9c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -161,12 +161,51 @@ void mptcp_parse_option(const unsigned char *ptr, int=
 opsize,
 	 * 4 or 16 bytes of address (depending on ip version)
 	 * 0 or 2 bytes of port (depending on length)
 	 */
+	case MPTCPOPT_ADD_ADDR:
+		if (opsize !=3D TCPOLEN_MPTCP_ADD_ADDR &&
+		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR6)
+			break;
+		mp_opt->family =3D *ptr++ & MPTCP_ADDR_FAMILY_MASK;
+		if (mp_opt->family !=3D MPTCP_ADDR_IPVERSION_4 &&
+		    mp_opt->family !=3D MPTCP_ADDR_IPVERSION_6)
+			break;
+
+		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4 &&
+		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR)
+			break;
+#if IS_ENABLED(CONFIG_IPV6)
+		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6 &&
+		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR6)
+			break;
+#endif
+		mp_opt->addr_id =3D *ptr++;
+		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
+			mp_opt->add_addr =3D 1;
+			mp_opt->addr.s_addr =3D get_unaligned_be32(ptr);
+			pr_debug("ADD_ADDR: addr=3D%x, id=3D%d",
+				 mp_opt->addr.s_addr, mp_opt->addr_id);
+#if IS_ENABLED(CONFIG_IPV6)
+		} else {
+			mp_opt->add_addr =3D 1;
+			memcpy(mp_opt->addr6.s6_addr, (u8 *) ptr, 16);
+			pr_debug("ADD_ADDR: addr6=3D, id=3D%d", mp_opt->addr_id);
+#endif
+		}
+		break;
 =

-	/* MPTCPOPT_REMOVE_ADDR
+	/* MPTCPOPT_RM_ADDR
 	 * 0: 4MSB=3Dsubtype, 0000
 	 * 1: Address ID
 	 * Additional bytes: More address IDs (depending on length)
 	 */
+	case MPTCPOPT_RM_ADDR:
+		if (opsize !=3D TCPOLEN_MPTCP_RM_ADDR)
+			break;
+
+		mp_opt->rm_addr =3D 1;
+		mp_opt->addr_id =3D *ptr++;
+		pr_debug("RM_ADDR: id=3D%d", mp_opt->addr_id);
+		break;
 =

 	/* MPTCPOPT_MP_PRIO
 	 * 0: 4MSB=3Dsubtype, 000, 1LSB=3DBackup
@@ -337,27 +376,47 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
 	return true;
 }
 =

+static bool mptcp_established_options_addr(struct sock *sk,
+					   unsigned int *size,
+					   unsigned int remaining,
+					   struct mptcp_out_options *opts)
+{
+	struct subflow_context *subflow =3D subflow_ctx(sk);
+	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
+
+	if (subflow->fourth_ack) {
+		return pm_addr_signal(msk, size, remaining, opts);
+	}
+	return false;
+}
+
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
 			       struct mptcp_out_options *opts)
 {
 	unsigned int opt_size =3D 0;
+	bool ret =3D false;
 =

 	if (!subflow_ctx(sk)->mp_capable)
 		return false;
 =

+	opts->suboptions =3D 0;
 	if (mptcp_established_options_mp(sk, &opt_size, remaining, opts)) {
 		*size +=3D opt_size;
 		remaining -=3D opt_size;
-		return true;
+		ret =3D true;
 	} else if (mptcp_established_options_dss(sk, skb, &opt_size, remaining,
-					       opts)) {
+						 opts)) {
 		*size +=3D opt_size;
 		remaining -=3D opt_size;
-		return true;
+		ret =3D true;
 	}
-
-	return false;
+	if (mptcp_established_options_addr(sk, &opt_size, remaining, opts)) {
+		*size +=3D opt_size;
+		remaining -=3D opt_size;
+		ret =3D true;
+	}
+	return ret;
 }
 =

 bool mptcp_synack_options(const struct request_sock *req, unsigned int *si=
ze,
@@ -428,10 +487,8 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out=
_options *opts)
 		else
 			len =3D TCPOLEN_MPTCP_MPC_ACK;
 =

-		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) | (len << 16) |
-			       (MPTCPOPT_MP_CAPABLE << 12) |
-			       ((MPTCPOPT_VERSION_MASK & 0) << 8) |
-			       MPTCP_CAP_HMAC_SHA1);
+		*ptr++ =3D mptcp_option(MPTCPOPT_MP_CAPABLE, len, 0,
+				      MPTCP_CAP_HMAC_SHA1);
 		put_unaligned_be64(opts->sndr_key, ptr);
 		ptr +=3D 2;
 		if ((OPTION_MPTCP_MPC_SYNACK |
@@ -441,6 +498,27 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out=
_options *opts)
 		}
 	}
 =

+	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
+		*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR, TCPOLEN_MPTCP_ADD_ADDR,
+				      MPTCP_ADDR_IPVERSION_4, opts->addr_id);
+		*ptr++ =3D htonl(opts->addr.s_addr);
+	}
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions) {
+		*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
+				      TCPOLEN_MPTCP_ADD_ADDR6,
+				      MPTCP_ADDR_IPVERSION_6, opts->addr_id);
+		memcpy((u8 *) ptr, opts->addr6.s6_addr, 16);
+		ptr +=3D 4;
+	}
+#endif
+
+	if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
+		*ptr++ =3D mptcp_option(MPTCPOPT_RM_ADDR, TCPOLEN_MPTCP_RM_ADDR,
+				      0, opts->addr_id);
+	}
+
 	if (opts->ext_copy.use_ack || opts->ext_copy.use_map) {
 		struct mptcp_ext *mpext =3D &opts->ext_copy;
 		u8 len =3D TCPOLEN_MPTCP_DSS_BASE;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 954360a3af2f..85a3f9e44ed4 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -51,7 +51,16 @@ void pm_rm_addr(struct mptcp_sock *msk, u8 id)
 bool pm_addr_signal(struct mptcp_sock *msk, unsigned *size,
 		    unsigned int remaining, struct mptcp_out_options *opts)
 {
+	if (!msk || !msk->addr_signal)
+		return false;
+
+	if (msk->pm.family =3D=3D AF_INET && remaining < TCPOLEN_MPTCP_ADD_ADDR)
+		return false;
+
 	pr_debug("msk=3D%p", msk);
+	opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
+	opts->addr_id =3D msk->pm.addr_id;
+	opts->addr.s_addr =3D msk->pm.addr.s_addr;
 =

-	return false;
+	return true;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b6e16739b89e..b912bf23c480 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -9,6 +9,7 @@
 #define __MPTCP_PROTOCOL_H
 =

 #include <linux/spinlock.h>
+#include <net/tcp.h>
 =

 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
@@ -20,8 +21,16 @@
 #define MPTCPOPT_MP_FAIL	6
 #define MPTCPOPT_MP_FASTCLOSE	7
 =

+#define TCPOLEN_MPTCP_ADD_ADDR		8
+#define TCPOLEN_MPTCP_ADD_ADDR6		20
+#define TCPOLEN_MPTCP_RM_ADDR		4
+
 #define MPTCPOPT_VERSION_MASK	0x0F
 =

+#define MPTCP_ADDR_FAMILY_MASK	0x0F
+#define MPTCP_ADDR_IPVERSION_4	4
+#define MPTCP_ADDR_IPVERSION_6	6
+
 /* MPTCP handshake flags */
 #define MPTCP_CAP_CHECKSUM_REQD	BIT(7)
 #define MPTCP_CAP_EXTENSIBILITY	BIT(6)
@@ -36,6 +45,12 @@
 #define MPTCP_DSS_HAS_ACK	BIT(0)
 #define MPTCP_DSS_FLAG_MASK	(0x1F)
 =

+static inline u32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
+{
+	return htonl((TCPOPT_MPTCP << 24) | (len << 16) | (subopt << 12) |
+		     ((nib & 0xF) << 8) | field);
+}
+
 struct pm_data {
 	u8 addr_id;
 	sa_family_t family;
@@ -59,6 +74,7 @@ struct mptcp_sock {
 	struct list_head conn_list;
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct pm_data	pm;
+	u8		addr_signal;
 };
 =

 #define mptcp_for_each_subflow(__msk, __subflow)			\
-- =

2.17.2


--===============7980626945820484558==--
