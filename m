Content-Type: multipart/mixed; boundary="===============5771437106902445313=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/3] squash to: mptcp: Add ADD_ADDR handling
Date: Mon, 17 Jun 2019 16:11:41 +0200
Message-ID: <20190617141142.6782-3-matthieu.baerts@tessares.net>
In-Reply-To: 20190617141142.6782-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1417

--===============5771437106902445313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)linux.intel.com>

This is extracted from MP_JOIN handling WIP v3 by Peter.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 include/linux/tcp.h  |  9 +++++++--
 include/net/mptcp.h  |  6 ++++--
 net/mptcp/options.c  | 45 ++++++++++++++++++++++----------------------
 net/mptcp/pm.c       | 23 +++++++++++-----------
 net/mptcp/protocol.h |  7 +++++++
 5 files changed, 52 insertions(+), 38 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index bedd89e170a0..68ff73ce8ac2 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -132,8 +132,12 @@ struct tcp_options_received {
 			rm_addr : 1,
 			family : 4;
 		u8	addr_id;
-		struct	in_addr	addr;
-		struct	in6_addr addr6;
+		union {
+			struct	in_addr	addr;
+#if IS_ENABLED(CONFIG_IPV6)
+			struct	in6_addr addr6;
+#endif
+		};
 	} mptcp;
 #endif
 };
@@ -147,6 +151,7 @@ static inline void tcp_clear_options(struct tcp_options=
_received *rx_opt)
 #endif
 #if IS_ENABLED(CONFIG_MPTCP)
 	rx_opt->mptcp.mp_capable =3D rx_opt->mptcp.mp_join =3D 0;
+	rx_opt->mptcp.add_addr =3D rx_opt->mptcp.rm_addr =3D 0;
 	rx_opt->mptcp.dss =3D 0;
 #endif
 }
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index e6d72038c12c..68e674f453e4 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -40,10 +40,12 @@ struct mptcp_out_options {
 	u16 suboptions;
 	u64 sndr_key;
 	u64 rcvr_key;
-	struct in_addr addr;
+	union {
+		struct in_addr addr;
 #if IS_ENABLED(CONFIG_IPV6)
-	struct in6_addr addr6;
+		struct in6_addr addr6;
 #endif
+	};
 	u8 addr_id;
 	u8 join_id;
 	u8 backup;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4735c1825c3f..a73b7ad7388e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -193,21 +193,31 @@ void mptcp_parse_option(const unsigned char *ptr, int=
 opsize,
 		if (opsize !=3D TCPOLEN_MPTCP_ADD_ADDR &&
 		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR6)
 			break;
-
 		mp_opt->family =3D *ptr++ & MPTCP_ADDR_FAMILY_MASK;
 		if (mp_opt->family !=3D MPTCP_ADDR_IPVERSION_4 &&
 		    mp_opt->family !=3D MPTCP_ADDR_IPVERSION_6)
 			break;
 =

-		mp_opt->add_addr =3D 1;
+		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4 &&
+		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR)
+			break;
+#if IS_ENABLED(CONFIG_IPV6)
+		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6 &&
+		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR6)
+			break;
+#endif
 		mp_opt->addr_id =3D *ptr++;
-		if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR) {
+		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
+			mp_opt->add_addr =3D 1;
 			mp_opt->addr.s_addr =3D get_unaligned_be32(ptr);
 			pr_debug("ADD_ADDR: addr=3D%x, id=3D%d",
 				 mp_opt->addr.s_addr, mp_opt->addr_id);
+#if IS_ENABLED(CONFIG_IPV6)
 		} else {
+			mp_opt->add_addr =3D 1;
 			memcpy(mp_opt->addr6.s6_addr, (u8 *)ptr, 16);
 			pr_debug("ADD_ADDR: addr6=3D, id=3D%d", mp_opt->addr_id);
+#endif
 		}
 		break;
 =

@@ -517,10 +527,8 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out=
_options *opts)
 		else
 			len =3D TCPOLEN_MPTCP_MPC_ACK;
 =

-		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) | (len << 16) |
-			       (MPTCPOPT_MP_CAPABLE << 12) |
-			       ((MPTCP_VERSION_MASK & 0) << 8) |
-			       MPTCP_CAP_HMAC_SHA1);
+		*ptr++ =3D mptcp_option(MPTCPOPT_MP_CAPABLE, len, 0,
+				      MPTCP_CAP_HMAC_SHA1);
 		put_unaligned_be64(opts->sndr_key, ptr);
 		ptr +=3D 2;
 		if ((OPTION_MPTCP_MPC_SYNACK |
@@ -531,31 +539,24 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_ou=
t_options *opts)
 	}
 =

 	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
-		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) |
-			       (TCPOLEN_MPTCP_ADD_ADDR << 16) |
-			       (MPTCPOPT_ADD_ADDR << 12) |
-			       (MPTCP_ADDR_IPVERSION_4 <<  8) |
-			       (opts->addr_id));
+		*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR, TCPOLEN_MPTCP_ADD_ADDR,
+				      MPTCP_ADDR_IPVERSION_4, opts->addr_id);
 		*ptr++ =3D htonl(opts->addr.s_addr);
 	}
 =

-#if IS_ENABLED(CONFIG_MPTCP)
+#if IS_ENABLED(CONFIG_IPV6)
 	if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions) {
-		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) |
-			       (TCPOLEN_MPTCP_ADD_ADDR6 << 16) |
-			       (MPTCPOPT_ADD_ADDR << 12) |
-			       (MPTCP_ADDR_IPVERSION_6 <<  8) |
-			       (opts->addr_id));
+		*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
+				      TCPOLEN_MPTCP_ADD_ADDR6,
+				      MPTCP_ADDR_IPVERSION_6, opts->addr_id);
 		memcpy((u8 *)ptr, opts->addr6.s6_addr, 16);
 		ptr +=3D 4;
 	}
 #endif
 =

 	if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
-		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) |
-			       (TCPOLEN_MPTCP_RM_ADDR << 16) |
-			       (MPTCPOPT_RM_ADDR << 12) |
-			       (opts->addr_id));
+		*ptr++ =3D mptcp_option(MPTCPOPT_RM_ADDR, TCPOLEN_MPTCP_RM_ADDR,
+				      0, opts->addr_id);
 	}
 =

 	if (OPTION_MPTCP_MPJ_SYNACK & opts->suboptions) {
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 61461b4ea796..9e9c681a4544 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -51,17 +51,16 @@ void pm_rm_addr(struct mptcp_sock *msk, u8 id)
 bool pm_addr_signal(struct mptcp_sock *msk, unsigned int *size,
 		    unsigned int remaining, struct mptcp_out_options *opts)
 {
-	if (msk && msk->addr_signal) {
-		pr_debug("msk=3D%p", msk);
-		if (msk->pm.family =3D=3D AF_INET &&
-		    remaining >=3D TCPOLEN_MPTCP_ADD_ADDR) {
-			msk->addr_signal =3D 0;
-			opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
-			opts->addr_id =3D msk->pm.addr_id;
-			opts->addr.s_addr =3D msk->pm.addr.s_addr;
-			return true;
-		}
-	}
+	if (!msk || !msk->addr_signal)
+		return false;
 =

-	return false;
+	if (msk->pm.family =3D=3D AF_INET && remaining < TCPOLEN_MPTCP_ADD_ADDR)
+		return false;
+
+	pr_debug("msk=3D%p", msk);
+	opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
+	opts->addr_id =3D msk->pm.addr_id;
+	opts->addr.s_addr =3D msk->pm.addr.s_addr;
+
+	return true;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1358f3231fca..61e9f15de9d6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -8,6 +8,7 @@
 #define __MPTCP_PROTOCOL_H
 =

 #include <linux/spinlock.h>
+#include <net/tcp.h>
 =

 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
@@ -59,6 +60,12 @@
 #define MPTCP_ADDR_IPVERSION_4	4
 #define MPTCP_ADDR_IPVERSION_6	6
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
-- =

2.20.1


--===============5771437106902445313==--
