Content-Type: multipart/mixed; boundary="===============4689914080706259817=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 3/4] mptcp: add mptcp reset option support
Date: Thu, 24 Sep 2020 16:35:04 +0200
Message-ID: <20200924143505.27641-4-fw@strlen.de>
In-Reply-To: 20200924143505.27641-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6027

--===============4689914080706259817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Reset option data taht is received will be stored in the mptcp skb
extension structure so it can be consumed by e.g. path management.

When a subflow gets closed, the desired error code is stored in the
subflow context structure.

When the close happens before a suitable tcp socket has been created
(for example, when HMAC fails validation), its possible to attach
the mptcp skb extension and store the reset reason code there.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 include/net/mptcp.h  |  6 ++++--
 include/net/tcp.h    |  3 +++
 net/ipv4/tcp_ipv4.c  | 21 ++++++++++++++++++++-
 net/ipv6/tcp_ipv6.c  | 19 +++++++++++++++++++
 net/mptcp/options.c  | 37 +++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c | 12 +++++++++---
 net/mptcp/protocol.h | 18 ++++++++++++++++++
 net/mptcp/subflow.c  | 27 ++++++++++++++++++++++++---
 8 files changed, 134 insertions(+), 9 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 5f5062580e0e..2fc556946ef6 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -30,8 +30,8 @@ struct mptcp_ext {
 			ack64:1,
 			mpc_map:1,
 			frozen:1,
-			__unused:1;
-	/* one byte hole */
+			reset_transient:1;
+	u8		reset_reason:4;
 };
 =

 struct mptcp_out_options {
@@ -50,6 +50,8 @@ struct mptcp_out_options {
 	u8 rm_id;
 	u8 join_id;
 	u8 backup;
+	u8 reset_reason:4;
+	u8 reset_transient:1;
 	u32 nonce;
 	u64 thmac;
 	u32 token;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index ea8c134802e8..a981b5d60112 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -193,6 +193,8 @@ void tcp_time_wait(struct sock *sk, int state, int time=
o);
 #define TCPOPT_FASTOPEN_MAGIC	0xF989
 #define TCPOPT_SMC_MAGIC	0xE2D4C3D9
 =

+/* MPTCP suboptions used in TCP */
+#define MPTCPOPT_TCPRST		8
 /*
  *     TCP option lengths
  */
@@ -216,6 +218,7 @@ void tcp_time_wait(struct sock *sk, int state, int time=
o);
 #define TCPOLEN_MD5SIG_ALIGNED		20
 #define TCPOLEN_MSS_ALIGNED		4
 #define TCPOLEN_EXP_SMC_BASE_ALIGNED	8
+#define TCPOLEN_MPTCP_TCPRST		4
 =

 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index ace48b2790ff..b4bc04586d73 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -660,9 +660,11 @@ static void tcp_v4_send_reset(const struct sock *sk, s=
truct sk_buff *skb)
 	const struct tcphdr *th =3D tcp_hdr(skb);
 	struct {
 		struct tcphdr th;
+		__be32 opt[(TCPOLEN_MPTCP_TCPRST >> 2)
 #ifdef CONFIG_TCP_MD5SIG
-		__be32 opt[(TCPOLEN_MD5SIG_ALIGNED >> 2)];
+			   + (TCPOLEN_MD5SIG_ALIGNED >> 2)
 #endif
+			];
 	} rep;
 	struct ip_reply_arg arg;
 #ifdef CONFIG_TCP_MD5SIG
@@ -770,6 +772,23 @@ static void tcp_v4_send_reset(const struct sock *sk, s=
truct sk_buff *skb)
 				     ip_hdr(skb)->daddr, &rep.th);
 	}
 #endif
+	/* Can't co-exist with TCPMD5, hence check rep.opt[0] */
+	if (sk && sk_fullsock(sk) && sk_is_mptcp(sk) && rep.opt[0] =3D=3D 0) {
+		const struct mptcp_ext *ext =3D mptcp_get_ext(skb);
+		u8 flags =3D 0, reason =3D 0;
+
+		if (ext) {
+			flags =3D ext->reset_transient;
+			reason =3D ext->reset_reason;
+		}
+
+		rep.opt[0] =3D mptcp_option(MPTCPOPT_TCPRST, TCPOLEN_MPTCP_TCPRST,
+					  flags, reason);
+
+		arg.iov[0].iov_len +=3D TCPOLEN_MPTCP_TCPRST;
+		rep.th.doff =3D arg.iov[0].iov_len / 4;
+	}
+
 	arg.csum =3D csum_tcpudp_nofold(ip_hdr(skb)->daddr,
 				      ip_hdr(skb)->saddr, /* XXX */
 				      arg.iov[0].iov_len, IPPROTO_TCP, 0);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 8db59f4e5f13..e8c2b68ec4f9 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -868,6 +868,7 @@ static void tcp_v6_send_response(const struct sock *sk,=
 struct sk_buff *skb, u32
 	struct net *net =3D sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
 	struct sock *ctl_sk =3D net->ipv6.tcp_sk;
 	unsigned int tot_len =3D sizeof(struct tcphdr);
+	bool mptcp_reset =3D false;
 	struct dst_entry *dst;
 	__be32 *topt;
 	__u32 mark =3D 0;
@@ -879,6 +880,11 @@ static void tcp_v6_send_response(const struct sock *sk=
, struct sk_buff *skb, u32
 		tot_len +=3D TCPOLEN_MD5SIG_ALIGNED;
 #endif
 =

+	if (rst && sk && sk_fullsock(sk) && sk_is_mptcp(sk) && !key) {
+		tot_len +=3D TCPOLEN_MPTCP_TCPRST;
+		mptcp_reset =3D true;
+	}
+
 	buff =3D alloc_skb(MAX_HEADER + sizeof(struct ipv6hdr) + tot_len,
 			 GFP_ATOMIC);
 	if (!buff)
@@ -909,6 +915,19 @@ static void tcp_v6_send_response(const struct sock *sk=
, struct sk_buff *skb, u32
 		*topt++ =3D htonl(tsecr);
 	}
 =

+	if (mptcp_reset) {
+		const struct mptcp_ext *ext =3D mptcp_get_ext(skb);
+		u8 flags =3D 0, reason =3D 0;
+
+		if (ext) {
+			flags =3D ext->reset_transient;
+			reason =3D ext->reset_reason;
+		}
+
+		*topt++ =3D mptcp_option(MPTCPOPT_TCPRST, TCPOLEN_MPTCP_TCPRST,
+				       flags, reason);
+	}
+
 #ifdef CONFIG_TCP_MD5SIG
 	if (key) {
 		*topt++ =3D htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 411fd4a41796..1eb395dfaa50 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -280,7 +280,17 @@ static void mptcp_parse_option(const struct sk_buff *s=
kb,
 		mp_opt->rm_id =3D *ptr++;
 		pr_debug("RM_ADDR: id=3D%d", mp_opt->rm_id);
 		break;
+	case MPTCPOPT_TCPRST:
+		if (opsize !=3D TCPOLEN_MPTCP_TCPRST)
+			break;
 =

+		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST))
+			break;
+		mp_opt->reset =3D 1;
+		flags =3D *ptr++;
+		mp_opt->reset_transient =3D flags & MPTCP_TCPRST_TRANSIENT;
+		mp_opt->reset_reason =3D *ptr;
+		break;
 	default:
 		break;
 	}
@@ -299,6 +309,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 	mp_opt->add_addr =3D 0;
 	mp_opt->rm_addr =3D 0;
 	mp_opt->dss =3D 0;
+	mp_opt->reset =3D 0;
 =

 	length =3D (th->doff * 4) - sizeof(struct tcphdr);
 	ptr =3D (const unsigned char *)(th + 1);
@@ -477,6 +488,22 @@ static void mptcp_write_data_fin(struct mptcp_subflow_=
context *subflow,
 	}
 }
 =

+static noinline void mptcp_established_options_rst(struct sock *sk, struct=
 sk_buff *skb,
+						   unsigned int *size,
+						   unsigned int remaining,
+						   struct mptcp_out_options *opts)
+{
+	const struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+
+	if (remaining < TCPOLEN_MPTCP_TCPRST)
+		return;
+
+	*size =3D TCPOLEN_MPTCP_TCPRST;
+	opts->suboptions |=3D OPTION_MPTCP_TCPRST;
+	opts->reset_transient =3D subflow->reset_transient;
+	opts->reset_reason =3D subflow->reset_reason;
+}
+
 static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff =
*skb,
 					  unsigned int *size,
 					  unsigned int remaining,
@@ -535,6 +562,10 @@ static bool mptcp_established_options_dss(struct sock =
*sk, struct sk_buff *skb,
 	dss_size +=3D ack_size;
 =

 	*size =3D ALIGN(dss_size, 4);
+
+	if (unlikely(skb && (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)))
+		mptcp_established_options_rst(sk, skb, size, remaining, opts);
+
 	return true;
 }
 =

@@ -1065,6 +1096,12 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_o=
ut_options *opts)
 		ptr +=3D 5;
 	}
 =

+	if (OPTION_MPTCP_TCPRST & opts->suboptions)
+		*ptr++ =3D mptcp_option(MPTCPOPT_TCPRST,
+				      TCPOLEN_MPTCP_TCPRST,
+				      opts->reset_transient,
+				      opts->reset_reason);
+
 	if (opts->ext_copy.use_ack || opts->ext_copy.use_map) {
 		struct mptcp_ext *mpext =3D &opts->ext_copy;
 		u8 len =3D TCPOLEN_MPTCP_DSS_BASE;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6677461efc85..c4f510f4c556 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2402,14 +2402,18 @@ bool mptcp_finish_join(struct sock *sk)
 	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow);
 =

 	/* mptcp socket already closing? */
-	if (!mptcp_is_fully_established(parent))
+	if (!mptcp_is_fully_established(parent)) {
+		subflow->reset_reason =3D MPTCP_TCPRST_EMPTCP;
 		return false;
+	}
 =

 	if (!msk->pm.server_side)
 		return true;
 =

-	if (!mptcp_pm_allow_new_subflow(msk))
+	if (!mptcp_pm_allow_new_subflow(msk)) {
+		subflow->reset_reason =3D MPTCP_TCPRST_EPROHIBIT;
 		return false;
+	}
 =

 	/* active connections are already on conn_list, and we can't acquire
 	 * msk lock here.
@@ -2421,8 +2425,10 @@ bool mptcp_finish_join(struct sock *sk)
 	if (ret && !WARN_ON_ONCE(!list_empty(&subflow->node)))
 		list_add_tail(&subflow->node, &msk->join_list);
 	spin_unlock_bh(&msk->join_list_lock);
-	if (!ret)
+	if (!ret) {
+		subflow->reset_reason =3D MPTCP_TCPRST_EPROHIBIT;
 		return false;
+	}
 =

 	/* attach to msk socket only after we are sure he will deal with us
 	 * at close time
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e8c873c66182..8ed09af586f0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -23,6 +23,7 @@
 #define OPTION_MPTCP_ADD_ADDR	BIT(6)
 #define OPTION_MPTCP_ADD_ADDR6	BIT(7)
 #define OPTION_MPTCP_RM_ADDR	BIT(8)
+#define OPTION_MPTCP_TCPRST	BIT(9)
 =

 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
@@ -84,6 +85,18 @@
 #define MPTCP_ADDR_IPVERSION_4	4
 #define MPTCP_ADDR_IPVERSION_6	6
 =

+/* MPTCP TCPRST flags */
+#define MPTCP_TCPRST_TRANSIENT	BIT(0)
+
+/* MPTCP TCPRST reason codes */
+#define MPTCP_TCPRST_EUNSPEC	0
+#define MPTCP_TCPRST_EMPTCP	1
+#define MPTCP_TCPRST_ERESOURCE	2
+#define MPTCP_TCPRST_EPROHIBIT	3
+#define MPTCP_TCPRST_EWQ2BIG	4
+#define MPTCP_TCPRST_EBADPERF	5
+#define MPTCP_TCPRST_EMIDDLEBOX	6
+
 /* MPTCP socket flags */
 #define MPTCP_DATA_READY	0
 #define MPTCP_SEND_SPACE	1
@@ -100,6 +113,7 @@ struct mptcp_options_received {
 	u16	data_len;
 	u16	mp_capable : 1,
 		mp_join : 1,
+		reset : 1,
 		dss : 1,
 		add_addr : 1,
 		rm_addr : 1,
@@ -120,6 +134,8 @@ struct mptcp_options_received {
 		__unused:2;
 	u8	addr_id;
 	u8	rm_id;
+	u8	reset_reason:4;
+	u8	reset_transient:1;
 	union {
 		struct in_addr	addr;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -314,6 +330,8 @@ struct mptcp_subflow_context {
 	u8	hmac[MPTCPOPT_HMAC_LEN];
 	u8	local_id;
 	u8	remote_id;
+	u8	reset_transient:1;
+	u8	reset_reason:4;
 =

 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 	struct	sock *conn;	    /* parent mptcp_sock */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 07b07be3e307..f3a493324777 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -312,8 +312,10 @@ static void subflow_finish_connect(struct sock *sk, co=
nst struct sk_buff *skb)
 	} else if (subflow->request_join) {
 		u8 hmac[SHA256_DIGEST_SIZE];
 =

-		if (!mp_opt.mp_join)
+		if (!mp_opt.mp_join) {
+			subflow->reset_reason =3D MPTCP_TCPRST_EMPTCP;
 			goto do_reset;
+		}
 =

 		subflow->thmac =3D mp_opt.thmac;
 		subflow->remote_nonce =3D mp_opt.nonce;
@@ -322,6 +324,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 =

 		if (!subflow_thmac_valid(subflow)) {
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINACKMAC);
+			subflow->reset_reason =3D MPTCP_TCPRST_EMPTCP;
 			goto do_reset;
 		}
 =

@@ -343,6 +346,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 	return;
 =

 do_reset:
+	subflow->reset_transient =3D 0;
 	tcp_send_active_reset(sk, GFP_ATOMIC);
 	tcp_done(sk);
 }
@@ -493,6 +497,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 	struct mptcp_options_received mp_opt;
 	bool fallback, fallback_is_fatal;
 	struct sock *new_msk =3D NULL;
+	struct mptcp_ext *mpext;
 	struct sock *child;
 =

 	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listener->c=
onn);
@@ -553,8 +558,15 @@ static struct sock *subflow_syn_recv_sock(const struct=
 sock *sk,
 		 * to reset the context to non MPTCP status.
 		 */
 		if (!ctx || fallback) {
-			if (fallback_is_fatal)
+			if (fallback_is_fatal) {
+				mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
+				if (mpext) {
+					memset(mpext, 0, sizeof(*mpext));
+					mpext->reset_reason =3D MPTCP_TCPRST_EMPTCP;
+				}
+
 				goto dispose_child;
+			}
 =

 			subflow_drop_ctx(child);
 			goto out;
@@ -584,8 +596,15 @@ static struct sock *subflow_syn_recv_sock(const struct=
 sock *sk,
 			struct mptcp_sock *owner;
 =

 			owner =3D subflow_req->msk;
-			if (!owner)
+			if (!owner) {
+				mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
+				if (mpext) {
+					memset(mpext, 0, sizeof(*mpext));
+					mpext->reset_reason =3D MPTCP_TCPRST_EPROHIBIT;
+				}
+
 				goto dispose_child;
+			}
 =

 			/* move the msk reference ownership to the subflow */
 			subflow_req->msk =3D NULL;
@@ -911,6 +930,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	smp_wmb();
 	ssk->sk_error_report(ssk);
 	tcp_set_state(ssk, TCP_CLOSE);
+	subflow->reset_transient =3D 0;
+	subflow->reset_reason =3D MPTCP_TCPRST_EMPTCP;
 	tcp_send_active_reset(ssk, GFP_ATOMIC);
 	subflow->data_avail =3D 0;
 	return false;
-- =

2.26.2

--===============4689914080706259817==--
