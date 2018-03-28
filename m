Content-Type: multipart/mixed; boundary="===============8985069303518489461=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 04/16] mptcp: Handle MPTCP TCP options
Date: Wed, 28 Mar 2018 16:18:28 -0700
Message-ID: <20180328231840.12410-5-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20180328231840.12410-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 448

--===============8985069303518489461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)intel.com>

Signed-off-by: Peter Krystad <peter.krystad(a)intel.com>
---
 include/linux/tcp.h   |  14 ++++
 include/net/mptcp.h   |  49 ++++++++++++++
 include/net/tcp.h     |   2 +
 net/ipv4/tcp_input.c  |  15 +++++
 net/ipv4/tcp_output.c |  72 ++++++++++++++++++++
 net/mptcp/Makefile    |   2 +-
 net/mptcp/options.c   | 177 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 7 files changed, 330 insertions(+), 1 deletion(-)
 create mode 100644 net/mptcp/options.c

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 8f4c54986f97..af175306d78c 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -104,6 +104,16 @@ struct tcp_options_received {
 	u8	num_sacks;	/* Number of SACK blocks		*/
 	u16	user_mss;	/* mss requested by user in ioctl	*/
 	u16	mss_clamp;	/* Maximal mss, negotiated at connection setup */
+	struct {
+	u8      mp_capable : 1,
+		mp_join : 1,
+		dss : 1,
+		version : 4;
+	u8      flags;
+	u64     sndr_key;
+	u64     rcvr_key;
+	} mptcp;
+
 };
 =

 static inline void tcp_clear_options(struct tcp_options_received *rx_opt)
@@ -113,6 +123,7 @@ static inline void tcp_clear_options(struct tcp_options=
_received *rx_opt)
 #if IS_ENABLED(CONFIG_SMC)
 	rx_opt->smc_ok =3D 0;
 #endif
+	rx_opt->mptcp.mp_capable =3D rx_opt->mptcp.mp_join =3D rx_opt->mptcp.dss =
=3D 0;
 }
 =

 /* This is the max number of SACKS that we'll generate and process. It's s=
afe
@@ -137,6 +148,7 @@ struct tcp_request_sock {
 						  * FastOpen it's the seq#
 						  * after data-in-SYN.
 						  */
+	bool				is_mptcp;
 };
 =

 static inline struct tcp_request_sock *tcp_rsk(const struct request_sock *=
req)
@@ -384,6 +396,8 @@ struct tcp_sock {
 	 */
 	struct request_sock *fastopen_rsk;
 	u32	*saved_syn;
+
+	bool	is_mptcp;
 };
 =

 enum tsq_enum {
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d66dbff5aa73..01f4f56f8886 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -16,6 +16,23 @@
 #ifndef __NET_MPTCP_H
 #define __NET_MPTCP_H
 =

+/* MPTCP option subtypes */
+
+#define MPTCPOPT_MP_CAPABLE	0
+#define MPTCPOPT_MP_JOIN	1
+#define MPTCPOPT_DSS		2
+#define MPTCPOPT_ADD_ADDR	3
+#define MPTCPOPT_REMOVE_ADDR	4
+#define MPTCPOPT_MP_PRIO	5
+#define MPTCPOPT_MP_FAIL	6
+#define MPTCPOPT_MP_FASTCLOSE	7
+
+/* MPTCP handshake flags */
+
+#define MPTCP_CAP_CHECKSUM_REQD	(1 << 7)
+#define MPTCP_CAP_EXTENSIBILITY	(1 << 6)
+#define MPTCP_CAP_HMAC_SHA1	(1 << 0)
+
 /* MPTCP connection sock */
 struct mptcp_sock {
 	/* inet_connection_sock must be the first member */
@@ -28,4 +45,36 @@ static inline struct mptcp_sock *mptcp_sk(const struct s=
ock *sk)
 	return (struct mptcp_sock *)sk;
 }
 =

+#ifdef CONFIG_MPTCP
+
+void mptcp_parse_option(const unsigned char *ptr, int opsize,
+			struct tcp_options_received *opt_rx);
+unsigned int mptcp_syn_options(struct sock *sk, u64 *local_key);
+unsigned int mptcp_synack_options(struct request_sock *req,
+				  u64 *local_key, u64 *remote_key);
+
+void mptcp_get_options(const struct sk_buff *skb,
+		       struct tcp_options_received *options);
+
+#else
+
+static inline void mptcp_parse_option(const unsigned char *ptr, int opsize,
+				      struct tcp_options_received *opt_rx)
+{
+}
+
+static inline unsigned int mptcp_syn_options(struct sock *sk, u64 *local_k=
ey)
+{
+	return 0;
+}
+static inline unsigned int mptcp_synack_options(struct request_sock *sk,
+						u64 *local_key,
+						u64 *remote_key)
+{
+	return 0;
+}
+
+
+
+#endif /* CONFIG_MPTCP */
 #endif /* __NET_MPTCP_H */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index c474f5478f76..58f33b024411 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -214,6 +214,8 @@ void tcp_time_wait(struct sock *sk, int state, int time=
o);
 #define TCPOLEN_MD5SIG_ALIGNED		20
 #define TCPOLEN_MSS_ALIGNED		4
 #define TCPOLEN_EXP_SMC_BASE_ALIGNED	8
+#define TCPOLEN_MPTCP_MPC_SYN		12
+#define TCPOLEN_MPTCP_MPC_SYNACK	20
 =

 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 451ef3012636..61462ea52aed 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -78,6 +78,7 @@
 #include <linux/errqueue.h>
 #include <trace/events/tcp.h>
 #include <linux/static_key.h>
+#include <net/mptcp.h>
 =

 int sysctl_tcp_max_orphans __read_mostly =3D NR_FILE;
 =

@@ -3785,6 +3786,10 @@ void tcp_parse_options(const struct net *net,
 				 */
 				break;
 #endif
+                        case TCPOPT_MPTCP:
+				mptcp_parse_option(ptr, opsize, opt_rx);
+				break;
+
 			case TCPOPT_FASTOPEN:
 				tcp_parse_fastopen_option(
 					opsize - TCPOLEN_FASTOPEN_BASE,
@@ -5670,6 +5675,15 @@ static int tcp_rcv_synsent_state_process(struct sock=
 *sk, struct sk_buff *skb,
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
 		tcp_initialize_rcv_mss(sk);
 =

+		// @@ could use a callout here
+		if (tp->is_mptcp) {
+			struct subflow_sock *subflow =3D subflow_sk(sk);
+			if (subflow->request_mptcp && tp->rx_opt.mptcp.mp_capable) {
+				subflow->mp_capable =3D 1;
+				subflow->remote_key =3D tp->rx_opt.mptcp.sndr_key;
+			}
+		}
+
 		/* Remember, tcp_poll() does not lock socket!
 		 * Change state from SYN-SENT only after copied_seq
 		 * is initialized. */
@@ -6245,6 +6259,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 =

 	tcp_rsk(req)->af_specific =3D af_ops;
 	tcp_rsk(req)->ts_off =3D 0;
+	tcp_rsk(req)->is_mptcp =3D 0;
 =

 	tcp_clear_options(&tmp_opt);
 	tmp_opt.mss_clamp =3D af_ops->mss_clamp;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 383cac0ff0ec..2c28e8d60a4a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -37,6 +37,7 @@
 #define pr_fmt(fmt) "TCP: " fmt
 =

 #include <net/tcp.h>
+#include <net/mptcp.h>
 =

 #include <linux/compiler.h>
 #include <linux/gfp.h>
@@ -404,6 +405,8 @@ static inline bool tcp_urg_mode(const struct tcp_sock *=
tp)
 #define OPTION_WSCALE		(1 << 3)
 #define OPTION_FAST_OPEN_COOKIE	(1 << 8)
 #define OPTION_SMC		(1 << 9)
+#define OPTION_MPTCP		(1 << 10)
+#define OPTION_MPTCP_ACK	(1 << 11)
 =

 static void smc_options_write(__be32 *ptr, u16 *options)
 {
@@ -429,6 +432,8 @@ struct tcp_out_options {
 	__u8 *hash_location;	/* temporary pointer, overloaded */
 	__u32 tsval, tsecr;	/* need to include OPTION_TS */
 	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
+	u64 sndr_key;
+	u64 rcvr_key;
 };
 =

 /* Write previously computed TCP options to the packet.
@@ -539,6 +544,29 @@ static void tcp_options_write(__be32 *ptr, struct tcp_=
sock *tp,
 	}
 =

 	smc_options_write(ptr, &options);
+
+	if (OPTION_MPTCP & options) {
+		u8 *p =3D (u8 *)ptr;
+		*p++ =3D 0x1e; // TCP option: Multipath TCP
+		*p++ =3D 12;   // length
+		*p++ =3D 0;    // subtype=3DMP_CAPABLE | version=3D0
+		*p++ =3D 0x1;  // flags=3DHMAC-SHA1
+		memcpy(p, &opts->sndr_key, 8);
+		pr_debug("tcp_options_write: opts->sndr_key=3D%llu", opts->sndr_key);
+	}
+
+	if (OPTION_MPTCP_ACK & options) {
+		u8 *p =3D (u8 *)ptr;
+		*p++ =3D 0x1e; // TCP option: Multipath TCP
+		*p++ =3D 20;   // length
+		*p++ =3D 0;    // subtype=3DMP_CAPABLE | version=3D0
+		*p++ =3D 0x1;  // flags=3DHMAC-SHA1
+		memcpy(p, &opts->sndr_key, 8);
+		pr_debug("tcp_options_write: opts->sndr_key=3D%llu", opts->sndr_key);
+		p +=3D 8;
+		memcpy(p, &opts->rcvr_key, 8);
+		pr_debug("tcp_options_write: opts->rcvr_key=3D%llu", opts->rcvr_key);
+	}
 }
 =

 static void smc_set_option(const struct tcp_sock *tp,
@@ -641,6 +669,15 @@ static unsigned int tcp_syn_options(struct sock *sk, s=
truct sk_buff *skb,
 =

 	smc_set_option(tp, opts, &remaining);
 =

+	if (tp->is_mptcp) {
+		u64 local_key;
+		if (mptcp_syn_options(sk, &local_key)) {
+			opts->options |=3D OPTION_MPTCP;
+			opts->sndr_key =3D local_key;
+			remaining -=3D TCPOLEN_MPTCP_MPC_SYN;
+		}
+	}
+
 	return MAX_TCP_OPTION_SPACE - remaining;
 }
 =

@@ -701,6 +738,18 @@ static unsigned int tcp_synack_options(const struct so=
ck *sk,
 			remaining -=3D need;
 		}
 	}
+	if (tcp_rsk(req)->is_mptcp) {
+		u64 local_key;
+		u64 remote_key;
+		if (mptcp_synack_options(req, &local_key, &remote_key)) {
+			if (remaining >=3D TCPOLEN_MPTCP_MPC_SYNACK) {
+				opts->options |=3D OPTION_MPTCP_ACK;
+				opts->sndr_key =3D local_key;
+				opts->rcvr_key =3D remote_key;
+				remaining -=3D TCPOLEN_MPTCP_MPC_SYNACK;
+			}
+		}
+	}
 =

 	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
 =

@@ -748,6 +797,29 @@ static unsigned int tcp_established_options(struct soc=
k *sk, struct sk_buff *skb
 			opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
 	}
 =

+	if (tp->is_mptcp) {
+		struct subflow_sock *subflow =3D subflow_sk(sk);
+		pr_debug("tcp_established_options: subflow=3D%p", subflow);
+		if (subflow->mp_capable) {
+			const unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
+			pr_debug("tcp_established_options: remaining=3D%d", remaining);
+			if (!subflow->fourth_ack) {
+				pr_debug("tcp_established_options: OPTION_MPTCP_ACK");
+				if (remaining >=3D 20) {
+					opts->options |=3D OPTION_MPTCP_ACK;
+					opts->sndr_key =3D subflow->local_key;
+					opts->rcvr_key =3D subflow->remote_key;
+					size +=3D 20;
+				}
+				subflow->fourth_ack =3D 1;
+				// @@ also this is where first DSS goes in?
+			}
+			else {
+				pr_debug("tcp_established_options: OPTION_MPTCP_DSS");
+				// @@ send DSS based on remaining
+			}
+		}
+	}
 	return size;
 }
 =

diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 5624e7d51d48..2bd18e3b9fda 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_MPTCP) +=3D mptcp.o
 =

-mptcp-y :=3D protocol.o
+mptcp-y :=3D protocol.o options.o
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
new file mode 100644
index 000000000000..a44283d6a0d7
--- /dev/null
+++ b/net/mptcp/options.c
@@ -0,0 +1,177 @@
+/*
+ * Multipath TCP
+ *
+ * Copyright (c) 2017, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/tcp.h>
+#include <net/tcp.h>
+#include <net/mptcp.h>
+
+void mptcp_parse_option(const unsigned char *ptr, int opsize,
+			struct tcp_options_received *opt_rx)
+{
+	u8 subtype;
+	u64 *p;
+
+	opsize -=3D 2;
+	subtype =3D *ptr++;
+
+	/* MPTCPOPT_MP_CAPABLE
+	 * 0: 4MSB=3Dsubtype, 4LSB=3Dversion
+	 * 1: Handshake flags
+	 * 2-9: Sender key
+	 * 10-17: Receiver key (optional)
+	 */
+	switch (subtype & 0xF0) {
+	case 0x00:
+		pr_debug("MP_CAPABLE");
+		pr_debug("flags=3D%02x", *ptr);
+		opt_rx->mptcp.mp_capable =3D 1;
+		opt_rx->mptcp.version =3D subtype & 0x0F;
+		opt_rx->mptcp.flags =3D *ptr++;
+		p =3D (u64 *)ptr;
+		pr_debug("sndr_key=3D%llu", *p);
+		opt_rx->mptcp.sndr_key =3D *p++;
+		if (opsize > 10) {
+			pr_debug("rcvr_key=3D%llu", *p);
+			opt_rx->mptcp.rcvr_key =3D *p++;
+		}
+		break;
+
+	/* MPTCPOPT_MP_JOIN
+	 *
+	 * Initial SYN
+	 * 0: 4MSB=3Dsubtype, 000, 1LSB=3DBackup
+	 * 1: Address ID
+	 * 2-5: Receiver token
+	 * 6-9: Sender random number
+	 *
+	 * SYN/ACK response
+	 * 0: 4MSB=3Dsubtype, 000, 1LSB=3DBackup
+	 * 1: Address ID
+	 * 2-9: Sender truncated HMAC
+	 * 10-13: Sender random number
+	 *
+	 * Third ACK
+	 * 0: 4MSB=3Dsubtype, 0000
+	 * 1: 0 (Reserved)
+	 * 2-21: Sender HMAC
+	 */
+
+	/* MPTCPOPT_DSS
+	 * 0: 4MSB=3Dsubtype, 0000
+	 * 1: 3MSB=3D0, F=3DData FIN, m=3DDSN length, M=3Dhas DSN/SSN/DLL/checksu=
m,
+	 *    a=3DDACK length, A=3Dhas DACK
+	 * 0, 4, or 8 bytes of DACK (depending on A/a)
+	 * 0, 4, or 8 bytes of DSN (depending on M/m)
+	 * 0 or 4 bytes of SSN (depending on M)
+	 * 0 or 2 bytes of DLL (depending on M)
+	 * 0 or 2 bytes of checksum (depending on M)
+	 */
+	case 0x20:
+		pr_debug("DSS");
+		opt_rx->mptcp.dss =3D 1;
+		break;
+
+	/* MPTCPOPT_ADD_ADDR
+	 * 0: 4MSB=3Dsubtype, 4LSB=3DIP version (4 or 6)
+	 * 1: Address ID
+	 * 4 or 16 bytes of address (depending on ip version)
+	 * 0 or 2 bytes of port (depending on length)
+	 */
+
+	/* MPTCPOPT_REMOVE_ADDR
+	 * 0: 4MSB=3Dsubtype, 0000
+	 * 1: Address ID
+	 * Additional bytes: More address IDs (depending on length)
+	 */
+
+	/* MPTCPOPT_MP_PRIO
+	 * 0: 4MSB=3Dsubtype, 000, 1LSB=3DBackup
+	 * 1: Address ID (optional, current addr implied if not present)
+	 */
+
+	/* MPTCPOPT_MP_FAIL
+	 * 0: 4MSB=3Dsubtype, 0000
+	 * 1: 0 (Reserved)
+	 * 2-9: DSN
+	 */
+
+	/* MPTCPOPT_MP_FASTCLOSE
+	 * 0: 4MSB=3Dsubtype, 0000
+	 * 1: 0 (Reserved)
+	 * 2-9: Receiver key
+	 */
+	default:
+		break;
+	}
+}
+
+void mptcp_get_options(const struct sk_buff *skb,
+		       struct tcp_options_received *opt_rx)
+{
+	const unsigned char *ptr;
+	const struct tcphdr *th =3D tcp_hdr(skb);
+	int length =3D (th->doff * 4) - sizeof(struct tcphdr);
+
+	ptr =3D (const unsigned char *)(th + 1);
+
+	while (length > 0) {
+		int opcode =3D *ptr++;
+		int opsize;
+
+		switch (opcode) {
+		case TCPOPT_EOL:
+			return;
+		case TCPOPT_NOP:	/* Ref: RFC 793 section 3.1 */
+			length--;
+			continue;
+		default:
+			opsize =3D *ptr++;
+			if (opsize < 2) /* "silly options" */
+				return;
+			if (opsize > length)
+				return;	/* don't parse partial options */
+			if (opcode =3D=3D TCPOPT_MPTCP)
+				mptcp_parse_option(ptr, opsize, opt_rx);
+			ptr +=3D opsize - 2;
+			length -=3D opsize;
+		}
+	}
+}
+
+unsigned int mptcp_syn_options(struct sock *sk, u64 *local_key)
+{
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+
+	if (subflow->request_mptcp) {
+		pr_debug("local_key=3D%llu", subflow->local_key);
+		*local_key =3D subflow->local_key;
+	}
+	return subflow->request_mptcp;
+}
+
+unsigned int mptcp_synack_options(struct request_sock *req, u64 *local_key,
+				  u64 *remote_key)
+{
+	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+
+	if (subflow_req->mp_capable) {
+		*local_key =3D subflow_req->local_key;
+		*remote_key =3D subflow_req->remote_key;
+		pr_debug("local_key=3D%llu", *local_key);
+		pr_debug("remote_key=3D%llu", *remote_key);
+	}
+	return subflow_req->mp_capable;
+}
-- =

2.16.3


--===============8985069303518489461==--
