Content-Type: multipart/mixed; boundary="===============9076013828020967453=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v2 2/3] mptcp: Add ADD_ADDR handling
Date: Wed, 12 Jun 2019 16:21:26 -0700
Message-ID: <20190612232127.3647-3-peter.krystad@linux.intel.com>
In-Reply-To: 20190612232127.3647-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1352

--===============9076013828020967453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add handling for sending and receiving the ADD_ADDR, ADD_ADDR6,
and RM_ADDR suboptions.

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/linux/tcp.h  |  6 +++
 include/net/mptcp.h  | 14 +++++--
 include/net/tcp.h    |  3 ++
 net/mptcp/options.c  | 89 +++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/pm.c       | 12 +++++-
 net/mptcp/protocol.h |  5 +++
 6 files changed, 119 insertions(+), 10 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 5f3784989d85..393e9be41c8e 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -122,6 +122,12 @@ struct tcp_options_received {
 			use_ack:1,
 			ack64:1,
 			__unused:2;
+		u8	add_addr : 1,
+			rm_addr : 1,
+			family : 4;
+		u8	addr_id;
+		struct	in_addr	addr;
+		struct	in6_addr addr6;
 	} mptcp;
 #endif
 };
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index e0bd45e49db1..d1534f8f0f38 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -25,15 +25,23 @@ struct mptcp_ext {
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
+	struct in_addr addr;
+#if IS_ENABLED(CONFIG_IPV6)
+	struct in6_addr addr6;
+#endif
+	u8 addr_id;
 	struct mptcp_ext ext_copy;
 #endif
 };
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0e939724b22c..6de16196d4aa 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -221,6 +221,9 @@ void tcp_time_wait(struct sock *sk, int state, int time=
o);
 #define TCPOLEN_MPTCP_DSS_MAP32		10
 #define TCPOLEN_MPTCP_DSS_MAP64		14
 #define TCPOLEN_MPTCP_DSS_CHECKSUM	2
+#define TCPOLEN_MPTCP_ADD_ADDR		8
+#define TCPOLEN_MPTCP_ADD_ADDR6		20
+#define TCPOLEN_MPTCP_RM_ADDR		4
 =

 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d285a33cd480..469f384ff108 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -161,12 +161,41 @@ void mptcp_parse_option(const unsigned char *ptr, int=
 opsize,
 	 * 4 or 16 bytes of address (depending on ip version)
 	 * 0 or 2 bytes of port (depending on length)
 	 */
+	case MPTCPOPT_ADD_ADDR:
+		if (opsize !=3D TCPOLEN_MPTCP_ADD_ADDR &&
+		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR6)
+			break;
+
+		mp_opt->family =3D *ptr++ & MPTCP_ADDR_FAMILY_MASK;
+		if (mp_opt->family !=3D MPTCP_ADDR_IPVERSION_4 &&
+		    mp_opt->family !=3D MPTCP_ADDR_IPVERSION_6)
+			break;
 =

-	/* MPTCPOPT_REMOVE_ADDR
+		mp_opt->add_addr =3D 1;
+		mp_opt->addr_id =3D *ptr++;
+		if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR) {
+			mp_opt->addr.s_addr =3D get_unaligned_be32(ptr);
+			pr_debug("ADD_ADDR: addr=3D%x, id=3D%d",
+				 mp_opt->addr.s_addr, mp_opt->addr_id);
+		} else {
+			memcpy(mp_opt->addr6.s6_addr, (u8 *) ptr, 16);
+			pr_debug("ADD_ADDR: addr6=3D, id=3D%d", mp_opt->addr_id);
+		}
+		break;
+
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
@@ -337,27 +366,47 @@ static bool mptcp_established_options_dss(struct sock=
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
@@ -441,6 +490,34 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out=
_options *opts)
 		}
 	}
 =

+	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
+		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) |
+			       (TCPOLEN_MPTCP_ADD_ADDR << 16) |
+			       (MPTCPOPT_ADD_ADDR << 12) |
+			       (MPTCP_ADDR_IPVERSION_4 <<  8) |
+			       (opts->addr_id));
+		*ptr++ =3D htonl(opts->addr.s_addr);
+	}
+
+#if IS_ENABLED(CONFIG_MPTCP)
+	if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions) {
+		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) |
+			       (TCPOLEN_MPTCP_ADD_ADDR6 << 16) |
+			       (MPTCPOPT_ADD_ADDR << 12) |
+			       (MPTCP_ADDR_IPVERSION_6 <<  8) |
+			       (opts->addr_id));
+		memcpy((u8 *) ptr, opts->addr6.s6_addr, 16);
+		ptr +=3D 4;
+	}
+#endif
+
+	if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
+		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) |
+			       (TCPOLEN_MPTCP_RM_ADDR << 16) |
+			       (MPTCPOPT_RM_ADDR << 12) |
+			       (opts->addr_id));
+	}
+
 	if (opts->ext_copy.use_ack || opts->ext_copy.use_map) {
 		struct mptcp_ext *mpext =3D &opts->ext_copy;
 		u8 len =3D TCPOLEN_MPTCP_DSS_BASE;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 954360a3af2f..9458ced2c9f4 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -51,7 +51,17 @@ void pm_rm_addr(struct mptcp_sock *msk, u8 id)
 bool pm_addr_signal(struct mptcp_sock *msk, unsigned *size,
 		    unsigned int remaining, struct mptcp_out_options *opts)
 {
-	pr_debug("msk=3D%p", msk);
+	if (msk && msk->addr_signal) {
+		pr_debug("msk=3D%p", msk);
+		if (msk->pm.family =3D=3D AF_INET &&
+		    remaining >=3D TCPOLEN_MPTCP_ADD_ADDR) {
+			msk->addr_signal =3D 0;
+			opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
+			opts->addr_id =3D msk->pm.addr_id;
+			opts->addr.s_addr =3D msk->pm.addr.s_addr;
+			return true;
+		}
+	}
 =

 	return false;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d0c2c280c8c3..28a1a2c7568c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -22,6 +22,10 @@
 =

 #define MPTCPOPT_VERSION_MASK	0x0F
 =

+#define MPTCP_ADDR_FAMILY_MASK	0x0F
+#define MPTCP_ADDR_IPVERSION_4	4
+#define MPTCP_ADDR_IPVERSION_6	6
+
 /* MPTCP handshake flags */
 #define MPTCP_CAP_CHECKSUM_REQD	BIT(7)
 #define MPTCP_CAP_EXTENSIBILITY	BIT(6)
@@ -57,6 +61,7 @@ struct mptcp_sock {
 	struct list_head conn_list;
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct pm_data	pm;
+	u8		addr_signal;
 };
 =

 #define mptcp_for_each_subflow(__msk, __subflow)			\
-- =

2.17.2


--===============9076013828020967453==--
