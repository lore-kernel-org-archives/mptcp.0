Content-Type: multipart/mixed; boundary="===============2121164045104656870=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 1/5] mptcp: Add ADD_ADDR handling
Date: Tue, 10 Mar 2020 15:33:28 -0700
Message-ID: <20200310223332.3845-2-peter.krystad@linux.intel.com>
In-Reply-To: 20200310223332.3845-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3906

--===============2121164045104656870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add handling for sending and receiving the ADD_ADDR, ADD_ADDR6,
and RM_ADDR suboptions.

squashto: Add ADD_ADDR handling

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/linux/tcp.h  |  12 +++++
 include/net/mptcp.h  |   7 +++
 net/mptcp/options.c  | 121 ++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  17 ++++++
 4 files changed, 149 insertions(+), 8 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 3dc964010fef..1e733f9fb4ab 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -96,6 +96,16 @@ struct mptcp_options_received {
 		ack64:1,
 		mpc_map:1,
 		__unused:2;
+	u8	add_addr : 1,
+		rm_addr : 1,
+		family : 4;
+	u8	addr_id;
+	union {
+		struct	in_addr	addr;
+#if IS_ENABLED(CONFIG_IPV6)
+		struct	in6_addr addr6;
+#endif
+	};
 };
 #endif
 =

@@ -131,6 +141,8 @@ static inline void tcp_clear_options(struct tcp_options=
_received *rx_opt)
 #if IS_ENABLED(CONFIG_MPTCP)
 	rx_opt->mptcp.mp_capable =3D 0;
 	rx_opt->mptcp.mp_join =3D 0;
+	rx_opt->mptcp.add_addr =3D 0;
+	rx_opt->mptcp.rm_addr =3D 0;
 	rx_opt->mptcp.dss =3D 0;
 #endif
 }
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index c971d25431ea..2d7e478f0380 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -33,6 +33,13 @@ struct mptcp_out_options {
 	u16 suboptions;
 	u64 sndr_key;
 	u64 rcvr_key;
+	union {
+		struct in_addr addr;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+		struct in6_addr addr6;
+#endif
+	};
+	u8 addr_id;
 	struct mptcp_ext ext_copy;
 #endif
 };
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b9a8305bd934..00aa3c8db85e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -178,6 +178,48 @@ void mptcp_parse_option(const struct sk_buff *skb, con=
st unsigned char *ptr,
 =

 		break;
 =

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
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6 &&
+		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR6)
+			break;
+#endif
+		mp_opt->addr_id =3D *ptr++;
+		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
+			mp_opt->add_addr =3D 1;
+			memcpy((u8 *)&mp_opt->addr.s_addr, (u8 *)ptr, 4);
+			pr_debug("ADD_ADDR: addr=3D%x, id=3D%d",
+				 mp_opt->addr.s_addr, mp_opt->addr_id);
+		}
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+		else {
+			mp_opt->add_addr =3D 1;
+			memcpy(mp_opt->addr6.s6_addr, (u8 *)ptr, 16);
+			pr_debug("ADD_ADDR: addr6=3D, id=3D%d", mp_opt->addr_id);
+		}
+#endif
+		break;
+
+	case MPTCPOPT_RM_ADDR:
+		if (opsize !=3D TCPOLEN_MPTCP_RM_ADDR)
+			break;
+
+		mp_opt->rm_addr =3D 1;
+		mp_opt->addr_id =3D *ptr++;
+		pr_debug("RM_ADDR: id=3D%d", mp_opt->addr_id);
+		break;
+
 	default:
 		break;
 	}
@@ -383,6 +425,44 @@ static bool mptcp_established_options_dss(struct sock =
*sk, struct sk_buff *skb,
 	return true;
 }
 =

+static bool mptcp_established_options_addr(struct sock *sk,
+					   unsigned int *size,
+					   unsigned int remaining,
+					   struct mptcp_out_options *opts)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
+	struct sockaddr_storage saddr;
+	u8 id;
+
+	if (!msk)
+		return false;
+
+	id =3D 0;
+	memset(&saddr, 0, sizeof(saddr));
+
+	if (saddr.ss_family =3D=3D AF_INET) {
+		if (remaining < TCPOLEN_MPTCP_ADD_ADDR)
+			return false;
+		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
+		opts->addr_id =3D id;
+		opts->addr =3D ((struct sockaddr_in *)&saddr)->sin_addr;
+		*size =3D TCPOLEN_MPTCP_ADD_ADDR;
+	}
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	else if (saddr.ss_family =3D=3D AF_INET6) {
+		if (remaining < TCPOLEN_MPTCP_ADD_ADDR6)
+			return false;
+		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR6;
+		opts->addr_id =3D id;
+		opts->addr6 =3D ((struct sockaddr_in6 *)&saddr)->sin6_addr;
+		*size =3D TCPOLEN_MPTCP_ADD_ADDR6;
+	}
+#endif
+
+	return true;
+}
+
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
 			       struct mptcp_out_options *opts)
@@ -390,6 +470,8 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 	unsigned int opt_size =3D 0;
 	bool ret =3D false;
 =

+	opts->suboptions =3D 0;
+
 	if (mptcp_established_options_mp(sk, skb, &opt_size, remaining, opts))
 		ret =3D true;
 	else if (mptcp_established_options_dss(sk, skb, &opt_size, remaining,
@@ -404,6 +486,11 @@ bool mptcp_established_options(struct sock *sk, struct=
 sk_buff *skb,
 =

 	*size +=3D opt_size;
 	remaining -=3D opt_size;
+	if (mptcp_established_options_addr(sk, &opt_size, remaining, opts)) {
+		*size +=3D opt_size;
+		remaining -=3D opt_size;
+		ret =3D true;
+	}
 =

 	return ret;
 }
@@ -518,10 +605,9 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out=
_options *opts)
 		else
 			len =3D TCPOLEN_MPTCP_MPC_ACK;
 =

-		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) | (len << 16) |
-			       (MPTCPOPT_MP_CAPABLE << 12) |
-			       (MPTCP_SUPPORTED_VERSION << 8) |
-			       MPTCP_CAP_HMAC_SHA256);
+		*ptr++ =3D mptcp_option(MPTCPOPT_MP_CAPABLE, len,
+				      MPTCP_SUPPORTED_VERSION,
+				      MPTCP_CAP_HMAC_SHA256);
 =

 		if (!((OPTION_MPTCP_MPC_SYNACK | OPTION_MPTCP_MPC_ACK) &
 		    opts->suboptions))
@@ -543,6 +629,28 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out=
_options *opts)
 	}
 =

 mp_capable_done:
+	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
+		*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR, TCPOLEN_MPTCP_ADD_ADDR,
+				      MPTCP_ADDR_IPVERSION_4, opts->addr_id);
+		memcpy((u8 *)ptr, (u8 *)&opts->addr.s_addr, 4);
+		ptr +=3D 1;
+	}
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions) {
+		*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
+				      TCPOLEN_MPTCP_ADD_ADDR6,
+				      MPTCP_ADDR_IPVERSION_6, opts->addr_id);
+		memcpy((u8 *)ptr, opts->addr6.s6_addr, 16);
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
@@ -564,10 +672,7 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out=
_options *opts)
 				flags |=3D MPTCP_DSS_DATA_FIN;
 		}
 =

-		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) |
-			       (len  << 16) |
-			       (MPTCPOPT_DSS << 12) |
-			       (flags));
+		*ptr++ =3D mptcp_option(MPTCPOPT_DSS, len, 0, flags);
 =

 		if (mpext->use_ack) {
 			put_unaligned_be64(mpext->data_ack, ptr);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 313558fa8185..a524ac55a575 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -17,6 +17,9 @@
 #define OPTION_MPTCP_MPC_SYN	BIT(0)
 #define OPTION_MPTCP_MPC_SYNACK	BIT(1)
 #define OPTION_MPTCP_MPC_ACK	BIT(2)
+#define OPTION_MPTCP_ADD_ADDR	BIT(6)
+#define OPTION_MPTCP_ADD_ADDR6	BIT(7)
+#define OPTION_MPTCP_RM_ADDR	BIT(8)
 =

 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
@@ -39,6 +42,9 @@
 #define TCPOLEN_MPTCP_DSS_MAP32		10
 #define TCPOLEN_MPTCP_DSS_MAP64		14
 #define TCPOLEN_MPTCP_DSS_CHECKSUM	2
+#define TCPOLEN_MPTCP_ADD_ADDR		8
+#define TCPOLEN_MPTCP_ADD_ADDR6		20
+#define TCPOLEN_MPTCP_RM_ADDR		4
 =

 /* MPTCP MP_CAPABLE flags */
 #define MPTCP_VERSION_MASK	(0x0F)
@@ -55,10 +61,21 @@
 #define MPTCP_DSS_HAS_ACK	BIT(0)
 #define MPTCP_DSS_FLAG_MASK	(0x1F)
 =

+/* MPTCP ADD_ADDR flags */
+#define MPTCP_ADDR_FAMILY_MASK	(0x0F)
+#define MPTCP_ADDR_IPVERSION_4	4
+#define MPTCP_ADDR_IPVERSION_6	6
+
 /* MPTCP socket flags */
 #define MPTCP_DATA_READY	0
 #define MPTCP_SEND_SPACE	1
 =

+static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
+{
+	return htonl((TCPOPT_MPTCP << 24) | (len << 16) | (subopt << 12) |
+		     ((nib & 0xF) << 8) | field);
+}
+
 /* MPTCP connection sock */
 struct mptcp_sock {
 	/* inet_connection_sock must be the first member */
-- =

2.17.2

--===============2121164045104656870==--
