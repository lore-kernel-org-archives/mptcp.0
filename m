Content-Type: multipart/mixed; boundary="===============0964191140158085655=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 2/3] mptcp: Add ADD_ADDR handling
Date: Wed, 22 May 2019 14:38:24 -0700
Message-ID: <20190522213825.4057-3-peter.krystad@linux.intel.com>
In-Reply-To: 20190522213825.4057-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1225

--===============0964191140158085655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add handling for sending and receiving the ADD_ADDR, ADD_ADDR6,
and RM_ADDR suboptions.

Add enough of a path manager interface to allow sending of ADD_ADDR
when an incoming MPTCP connection is created. Capable of sending only
a single IPv4 ADD_ADDR option. The 'pm_data' element of the connection
sock will need to be expanded to handle multiple interfaces and IPv6.

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/net/mptcp.h   | 24 ++++++++++++++++++++---
 include/net/tcp.h     |  3 +++
 net/ipv4/tcp_output.c |  5 +++++
 net/mptcp/Makefile    |  2 +-
 net/mptcp/options.c   | 44 ++++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/pm.c        | 24 +++++++++++++++++++++++
 net/mptcp/protocol.c  |  5 +++++
 net/mptcp/protocol.h  | 20 +++++++++++++++++++-
 8 files changed, 121 insertions(+), 6 deletions(-)
 create mode 100644 net/mptcp/pm.c

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 0f66dab1c444..5bcd0f386d9d 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -34,15 +34,21 @@ struct mptcp_ext {
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
+	struct in6_addr addr6;
+	u8 address_id;
 	struct mptcp_ext ext_copy;
 #endif
 };
@@ -72,6 +78,9 @@ bool mptcp_synack_options(const struct request_sock *req,=
 unsigned int *size,
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
 			       struct mptcp_out_options *opts);
+bool mptcp_established_options_addr(struct sock *sk, struct sk_buff *skb,
+				    unsigned int *size, unsigned int remaining,
+				    struct mptcp_out_options *opts);
 =

 void mptcp_attach_dss(struct sock *sk, struct sk_buff *skb,
 		      struct tcp_options_received *opt_rx);
@@ -135,6 +144,15 @@ static inline bool mptcp_established_options(struct so=
ck *sk,
 	return false;
 }
 =

+static inline bool mptcp_established_options_addr(struct sock *sk,
+						  struct sk_buff *skb,
+						  unsigned int *size,
+						  unsigned int remaining,
+						  struct mptcp_out_options *opts)
+{
+	return false;
+}
+
 static inline void mptcp_attach_dss(struct sock *sk, struct sk_buff *skb,
 				    struct tcp_options_received *opt_rx)
 {
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 02df4f946c06..6219b568c0f9 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -225,6 +225,9 @@ void tcp_time_wait(struct sock *sk, int state, int time=
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
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 68a2311b56d4..a455af8a7b34 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -811,6 +811,11 @@ static unsigned int tcp_established_options(struct soc=
k *sk, struct sk_buff *skb
 			remaining -=3D opt_size;
 		}
 =

+		if (mptcp_established_options_addr(sk, skb, &opt_size,
+						   remaining, &opts->mptcp)) {
+			opts->options |=3D OPTION_MPTCP;
+			size +=3D opt_size;
+			remaining -=3D opt_size;
 		}
 	}
 =

diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 178ae81d8b66..7fe7aa64eda0 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_MPTCP) +=3D mptcp.o
 =

-mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o
+mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o pm.o
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 47d7507a2f2a..6437434a7bd7 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -153,7 +153,7 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
 	 * 0 or 2 bytes of port (depending on length)
 	 */
 =

-	/* MPTCPOPT_REMOVE_ADDR
+	/* MPTCPOPT_RM_ADDR
 	 * 0: 4MSB=3Dsubtype, 0000
 	 * 1: Address ID
 	 * Additional bytes: More address IDs (depending on length)
@@ -261,6 +261,22 @@ bool mptcp_established_options(struct sock *sk, struct=
 sk_buff *skb,
 	return false;
 }
 =

+bool mptcp_established_options_addr(struct sock *sk, struct sk_buff *skb,
+				    unsigned int *size, unsigned int remaining,
+				    struct mptcp_out_options *opts)
+{
+	struct subflow_context *subflow =3D subflow_ctx(sk);
+	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
+
+	pr_debug("subflow=3D%p", subflow);
+	pr_debug("fourth_ack=3D%d", subflow->fourth_ack);
+	if (subflow->mp_capable && subflow->fourth_ack && msk &&
+	    msk->addr_signal) {
+		return pm_addr_signal(msk, size, remaining, opts, skb);
+	}
+	return false;
+}
+
 bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 				   unsigned int *size, unsigned int remaining,
 				   struct mptcp_out_options *opts)
@@ -413,6 +429,32 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out=
_options *opts)
 		}
 	}
 =

+	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
+		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) |
+			       (TCPOLEN_MPTCP_ADD_ADDR << 16) |
+			       (MPTCPOPT_ADD_ADDR << 12) |
+			       (MPTCP_IPVERSION_4 <<  8) |
+			       (opts->address_id));
+		*ptr++ =3D opts->addr.s_addr;
+	}
+
+	if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions) {
+		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) |
+			       (TCPOLEN_MPTCP_ADD_ADDR6 << 16) |
+			       (MPTCPOPT_ADD_ADDR << 12) |
+			       (MPTCP_IPVERSION_4 <<  8) |
+			       (opts->address_id));
+		memcpy((u8 *) ptr, opts->addr6.s6_addr, 16);
+		ptr +=3D 4;
+	}
+
+	if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
+		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) |
+			       (TCPOLEN_MPTCP_RM_ADDR << 16) |
+			       (MPTCPOPT_RM_ADDR << 12) |
+			       (opts->address_id));
+	}
+
 	if (opts->ext_copy.use_ack || opts->ext_copy.use_map) {
 		struct mptcp_ext *mpext =3D &opts->ext_copy;
 		u8 len =3D TCPOLEN_MPTCP_DSS_BASE;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
new file mode 100644
index 000000000000..87dd7001eb87
--- /dev/null
+++ b/net/mptcp/pm.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Multipath TCP
+ *
+ * Copyright (c) 2019, Intel Corporation.
+ */
+#include <linux/kernel.h>
+#include <net/tcp.h>
+#include <net/mptcp.h>
+#include "protocol.h"
+
+void pm_new_session(struct mptcp_sock *msk)
+{
+	pr_debug("msk=3D%p", msk);
+}
+
+bool pm_addr_signal(struct mptcp_sock *msk, unsigned *size,
+		    unsigned int remaining, struct mptcp_out_options *opts,
+		    struct sk_buff *skb)
+{
+	pr_debug("msk=3D%p", msk);
+
+	return false;
+}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 06312efc0b90..0d9796a040da 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -640,6 +640,9 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		mptcp_init_sock(new_mptcp_sock);
 =

 		msk =3D mptcp_sk(new_mptcp_sock);
+
+		pm_new_session(msk);
+
 		msk->remote_key =3D subflow->remote_key;
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
@@ -763,6 +766,8 @@ void mptcp_finish_connect(struct sock *sk, int mp_capab=
le)
 		subflow->map_seq =3D ack_seq;
 		subflow->map_subflow_seq =3D 1;
 		subflow->rel_write_seq =3D 1;
+
+		pm_new_session(msk);
 	}
 	inet_sk_state_store(sk, TCP_ESTABLISHED);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0c31d30c670c..32d9faf4a311 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -15,18 +15,29 @@
 #define MPTCPOPT_MP_JOIN	1
 #define MPTCPOPT_DSS		2
 #define MPTCPOPT_ADD_ADDR	3
-#define MPTCPOPT_REMOVE_ADDR	4
+#define MPTCPOPT_RM_ADDR	4
 #define MPTCPOPT_MP_PRIO	5
 #define MPTCPOPT_MP_FAIL	6
 #define MPTCPOPT_MP_FASTCLOSE	7
 =

 #define MPTCPOPT_VERSION_MASK	0x0F
 =

+#define MPTCP_IPVERSION_4	4
+#define MPTCP_IPVERSION_6	6
+
 /* MPTCP handshake flags */
 #define MPTCP_CAP_CHECKSUM_REQD	(1 << 7)
 #define MPTCP_CAP_EXTENSIBILITY	(1 << 6)
 #define MPTCP_CAP_HMAC_SHA1	(1 << 0)
 =

+struct pm_data {
+	u8 address_id;
+	union {
+		struct in_addr addr;
+		struct in6_addr addr6;
+	};
+};
+
 /* MPTCP connection sock */
 struct mptcp_sock {
 	/* inet_connection_sock must be the first member */
@@ -39,6 +50,8 @@ struct mptcp_sock {
 	spinlock_t	conn_list_lock;
 	struct list_head conn_list;
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
+	u8 addr_signal;
+	struct pm_data	pm;
 };
 =

 #define mptcp_for_each_subflow(__msk, __subflow)			\
@@ -139,6 +152,11 @@ void crypto_key_sha1(u64 key, u32 *token, u64 *idsn);
 void crypto_hmac_sha1(u64 key1, u64 key2, u32 *hash_out,
 		     int arg_num, ...);
 =

+void pm_new_session(struct mptcp_sock *msk);
+bool pm_addr_signal(struct mptcp_sock *msk, unsigned *size,
+		    unsigned int remaining, struct mptcp_out_options *opts,
+		    struct sk_buff *skb);
+
 static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
 {
 	return (struct mptcp_ext *)skb_ext_find(skb, SKB_EXT_MPTCP);
-- =

2.17.2


--===============0964191140158085655==--
