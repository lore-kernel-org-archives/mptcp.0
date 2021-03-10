Content-Type: multipart/mixed; boundary="===============6160303793191065140=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][RFC PATCH 2/2] mptcp: add MP_FAIL support
Date: Wed, 10 Mar 2021 20:39:34 +0800
Message-ID: <dfa64550c8ae54a3d831998f048f7b6b74db8d16.1615378283.git.geliangtang@gmail.com>
In-Reply-To: cc7e44b081dc7b02f9b7b9d14175acad361ea18e.1615378283.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8090

--===============6160303793191065140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add handling for sending and receiving MP_FAIL suboption.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/52

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/options.c  | 61 +++++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h |  5 ++++
 net/mptcp/subflow.c  |  4 +++
 4 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index de88f38e60b1..6635689ce03f 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -64,6 +64,7 @@ struct mptcp_out_options {
 	u32 nonce;
 	u64 thmac;
 	u32 token;
+	u64 fail_seq;
 	u8 hmac[20];
 	struct mptcp_ext ext_copy;
 #endif
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 9df26291cf9a..1b5aaab80ba0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -318,6 +318,17 @@ static void mptcp_parse_option(const struct sk_buff *s=
kb,
 		flags =3D *ptr++;
 		mp_opt->reset_transient =3D flags & MPTCP_RST_TRANSIENT;
 		mp_opt->reset_reason =3D *ptr;
+		pr_debug("RST: reset_reason=3D%u", mp_opt->reset_reason);
+		break;
+
+	case MPTCPOPT_MP_FAIL:
+		if (opsize !=3D TCPOLEN_MPTCP_FAIL)
+			break;
+
+		ptr +=3D 2;
+		mp_opt->mp_fail =3D 1;
+		mp_opt->fail_seq =3D get_unaligned_be64(ptr);
+		pr_debug("MP_FAIL: data_seq=3D%llu", mp_opt->fail_seq);
 		break;
 =

 	default:
@@ -344,6 +355,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 	mp_opt->mp_prio =3D 0;
 	mp_opt->reset =3D 0;
 	mp_opt->csum =3D 0;
+	mp_opt->mp_fail =3D 0;
 =

 	length =3D (th->doff * 4) - sizeof(struct tcphdr);
 	ptr =3D (const unsigned char *)(th + 1);
@@ -787,6 +799,28 @@ static noinline void mptcp_established_options_rst(str=
uct sock *sk, struct sk_bu
 	opts->reset_reason =3D subflow->reset_reason;
 }
 =

+static bool mptcp_established_options_mp_fail(struct sock *sk,
+					      unsigned int *size,
+					      unsigned int remaining,
+					      struct mptcp_out_options *opts)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+
+	if (!subflow->send_mp_fail)
+		return false;
+
+	if (remaining < TCPOLEN_MPTCP_FAIL)
+		return false;
+
+	*size =3D TCPOLEN_MPTCP_FAIL;
+	opts->suboptions |=3D OPTION_MPTCP_FAIL;
+	opts->fail_seq =3D subflow->map_seq;
+
+	pr_debug("MP_FAIL fail_seq=3D%llu", opts->fail_seq);
+
+	return true;
+}
+
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
 			       struct mptcp_out_options *opts)
@@ -803,7 +837,13 @@ bool mptcp_established_options(struct sock *sk, struct=
 sk_buff *skb,
 		return false;
 =

 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
-		mptcp_established_options_rst(sk, skb, size, remaining, opts);
+		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
+			*size +=3D opt_size;
+			remaining -=3D opt_size;
+		}
+		mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts);
+		*size +=3D opt_size;
+		remaining -=3D opt_size;
 		return true;
 	}
 =

@@ -1120,6 +1160,11 @@ void mptcp_incoming_options(struct sock *sk, struct =
sk_buff *skb)
 		mp_opt.mp_prio =3D 0;
 	}
 =

+	if (mp_opt.mp_fail) {
+		/* TODO */
+		mp_opt.mp_fail =3D 0;
+	}
+
 	if (mp_opt.reset) {
 		subflow->reset_seen =3D 1;
 		subflow->reset_reason =3D mp_opt.reset_reason;
@@ -1329,6 +1374,20 @@ void mptcp_write_options(__be32 *ptr, const struct t=
cp_sock *tp,
 				      opts->backup, TCPOPT_NOP);
 	}
 =

+	if (OPTION_MPTCP_FAIL & opts->suboptions) {
+		const struct sock *ssk =3D (const struct sock *)tp;
+		struct mptcp_subflow_context *subflow;
+
+		subflow =3D mptcp_subflow_ctx(ssk);
+		subflow->send_mp_fail =3D 0;
+
+		*ptr++ =3D mptcp_option(MPTCPOPT_MP_FAIL,
+				      TCPOLEN_MPTCP_FAIL,
+				      0, 0);
+		put_unaligned_be64(opts->fail_seq, ptr);
+		ptr +=3D 2;
+	}
+
 	if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
 		*ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
 				      TCPOLEN_MPTCP_MPJ_SYN,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 24b4e1f6d23f..ab8f92c49029 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -27,6 +27,7 @@
 #define OPTION_MPTCP_FASTCLOSE	BIT(9)
 #define OPTION_MPTCP_PRIO	BIT(10)
 #define OPTION_MPTCP_RST	BIT(11)
+#define OPTION_MPTCP_FAIL	BIT(12)
 =

 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
@@ -68,6 +69,7 @@
 #define TCPOLEN_MPTCP_PRIO_ALIGN	4
 #define TCPOLEN_MPTCP_FASTCLOSE		12
 #define TCPOLEN_MPTCP_RST		4
+#define TCPOLEN_MPTCP_FAIL		12
 =

 /* MPTCP MP_JOIN flags */
 #define MPTCPOPT_BACKUP		BIT(0)
@@ -135,6 +137,7 @@ struct mptcp_options_received {
 		add_addr : 1,
 		rm_addr : 1,
 		mp_prio : 1,
+		mp_fail : 1,
 		family : 4,
 		echo : 1,
 		backup : 1;
@@ -162,6 +165,7 @@ struct mptcp_options_received {
 	u16	port;
 	u8	reset_reason:4;
 	u8	reset_transient:1;
+	u64	fail_seq;
 };
 =

 static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
@@ -428,6 +432,7 @@ struct mptcp_subflow_context {
 		mpc_map : 1,
 		backup : 1,
 		send_mp_prio : 1,
+		send_mp_fail : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1;	    /* ctx can be free at ulp release time */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b597811a2f8d..059c1a0ef25b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -823,12 +823,16 @@ static bool validate_dss_csum(struct sock *ssk, struc=
t sk_buff *skb)
 =

 		if (csum_fold(csum)) {
 			pr_err("%s DSS checksum error csum=3D%u!", __func__, csum_fold(csum));
+			subflow->send_mp_fail =3D 1;
+			subflow->reset_reason =3D MPTCP_RST_EMIDDLEBOX;
+			tcp_send_active_reset(ssk, GFP_ATOMIC);
 			return true; //false;
 		}
 		pr_debug("%s DSS checksum done", __func__);
 	}
 =

 out:
+	subflow->send_mp_fail =3D 0;
 	return true;
 }
 =

-- =

2.29.2

--===============6160303793191065140==--
