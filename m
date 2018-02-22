Content-Type: multipart/mixed; boundary="===============9153166697510970147=="
MIME-Version: 1.0
From: rao.shoaib at oracle.com
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 6/9] Make TCP options processing abstract
Date: Thu, 22 Feb 2018 15:49:58 -0800
Message-ID: <1519343401-19027-7-git-send-email-rao.shoaib@oracle.com>
In-Reply-To: 1519343401-19027-1-git-send-email-rao.shoaib@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 305

--===============9153166697510970147==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Rao Shoaib <rao.shoaib(a)oracle.com>

Signed-off-by: Rao Shoaib <rao.shoaib(a)oracle.com>
---
 include/net/tcp.h     | 12 ++++++++++
 net/ipv4/tcp.c        |  3 +++
 net/ipv4/tcp_output.c | 66 +++++++++++++++++++++++++++++++++--------------=
----
 3 files changed, 58 insertions(+), 23 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index bd6b082..f5d748a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -571,6 +571,18 @@ int select_size(const struct sock *sk, bool sg, bool f=
irst_skb, bool zc);
 bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 		    int push_one, gfp_t gfp);
 void tcp_cwnd_validate(struct sock *sk, bool is_cwnd_limited);
+unsigned int tcp_synack_options_size(const struct sock *sk,
+				     struct request_sock *req,
+				     unsigned int mss, struct sk_buff *skb,
+				     struct tcp_out_options *opts,
+				     const struct tcp_md5sig_key *md5,
+				     struct tcp_fastopen_cookie *foc);
+int tcp_options_size(struct sock *sk, struct sk_buff *skb,
+		     struct tcp_out_options *opts,
+		     struct tcp_md5sig_key **md5);
+void tcp_options_write(__be32 **ptr, struct tcp_sock *tp,
+		       struct tcp_out_options *opts,
+		       struct sk_buff *skb);
 void tcp_connect_init(struct sock *sk);
 int tcp_send_mss(struct sock *sk, int *size_goal, int flags);
 int tcp_mtu_probe(struct sock *sk);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index ab82e7c..136be43 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -435,6 +435,9 @@ static const struct tcp_operational_ops __tcp_default_o=
p_ops =3D {
 	.trim_head			=3D tcp_trim_head,
 	.urg				=3D tcp_urg,
 	.can_send			=3D tcp_can_send,
+	.synack_options_size		=3D tcp_synack_options_size,
+	.options_size			=3D tcp_options_size,
+	.options_write			=3D tcp_options_write,
 	.connect_init			=3D tcp_connect_init,
 	.send_mss			=3D tcp_send_mss,
 	.mtu_probe			=3D tcp_mtu_probe,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f296f1f7..2fa5c05 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -430,10 +430,12 @@ static void smc_options_write(__be32 *ptr, u16 *optio=
ns)
  * At least SACK_PERM as the first option is known to lead to a disaster
  * (but it may well be that other scenarios fail similarly).
  */
-static void tcp_options_write(__be32 *ptr, struct tcp_sock *tp,
-			      struct tcp_out_options *opts)
+void tcp_options_write(__be32 **ptr_ptr, struct tcp_sock *tp,
+		       struct tcp_out_options *opts,
+		       struct sk_buff *skb)
 {
 	u16 options =3D opts->options;	/* mungable copy */
+	__be32 *ptr =3D *ptr_ptr;
 =

 	if (unlikely(OPTION_MD5 & options)) {
 		*ptr++ =3D htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
@@ -525,6 +527,8 @@ static void tcp_options_write(__be32 *ptr, struct tcp_s=
ock *tp,
 	}
 =

 	smc_options_write(ptr, &options);
+
+	*ptr_ptr =3D ptr;
 }
 =

 static void smc_set_option(const struct tcp_sock *tp,
@@ -563,9 +567,9 @@ static void smc_set_option_cond(const struct tcp_sock *=
tp,
 /* Compute TCP options for SYN packets. This is not the final
  * network wire format yet.
  */
-static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
-				struct tcp_out_options *opts,
-				struct tcp_md5sig_key **md5)
+unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
+			     struct tcp_out_options *opts,
+			     struct tcp_md5sig_key **md5)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	unsigned int remaining =3D MAX_TCP_OPTION_SPACE;
@@ -631,12 +635,12 @@ static unsigned int tcp_syn_options(struct sock *sk, =
struct sk_buff *skb,
 }
 =

 /* Set up TCP options for SYN-ACKs. */
-static unsigned int tcp_synack_options(const struct sock *sk,
-				       struct request_sock *req,
-				       unsigned int mss, struct sk_buff *skb,
-				       struct tcp_out_options *opts,
-				       const struct tcp_md5sig_key *md5,
-				       struct tcp_fastopen_cookie *foc)
+unsigned int tcp_synack_options_size(const struct sock *sk,
+				     struct request_sock *req,
+				     unsigned int mss, struct sk_buff *skb,
+				     struct tcp_out_options *opts,
+				     const struct tcp_md5sig_key *md5,
+				     struct tcp_fastopen_cookie *foc)
 {
 	struct inet_request_sock *ireq =3D inet_rsk(req);
 	unsigned int remaining =3D MAX_TCP_OPTION_SPACE;
@@ -737,6 +741,16 @@ static unsigned int tcp_established_options(struct soc=
k *sk, struct sk_buff *skb
 	return size;
 }
 =

+int tcp_options_size(struct sock *sk, struct sk_buff *skb,
+		     struct tcp_out_options *opts,
+		     struct tcp_md5sig_key **md5)
+{
+	if (unlikely(skb && (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)))
+		return (tcp_syn_options(sk, skb, opts, md5));
+	else
+		return (tcp_established_options(sk, skb, opts, md5));
+}
+
 =

 /* TCP SMALL QUEUES (TSQ)
  *
@@ -1030,6 +1044,8 @@ static int tcp_transmit_skb(struct sock *sk, struct s=
k_buff *skb, int clone_it,
 	struct tcp_md5sig_key *md5;
 	struct tcphdr *th;
 	int err;
+	__be32	*ptr;
+	__be32	*orig_ptr;
 =

 	BUG_ON(!skb || !tcp_skb_pcount(skb));
 	tp =3D tcp_sk(sk);
@@ -1055,12 +1071,9 @@ static int tcp_transmit_skb(struct sock *sk, struct =
sk_buff *skb, int clone_it,
 	tcb =3D TCP_SKB_CB(skb);
 	memset(&opts, 0, sizeof(opts));
 =

-	if (unlikely(tcb->tcp_flags & TCPHDR_SYN))
-		tcp_options_size =3D tcp_syn_options(sk, skb, &opts, &md5);
-	else
-		tcp_options_size =3D tcp_established_options(sk, skb, &opts,
-							   &md5);
+	tcp_options_size =3D tp->op_ops->options_size(sk, skb, &opts, &md5);
 	tcp_header_size =3D tcp_options_size + sizeof(struct tcphdr);
+	WARN_ON(tcp_options_size > MAX_TCP_OPTION_SPACE);
 =

 	/* if no packet is in qdisc/device queue, then allow XPS to select
 	 * another queue. We can be called from tcp_tsq_handler()
@@ -1112,7 +1125,10 @@ static int tcp_transmit_skb(struct sock *sk, struct =
sk_buff *skb, int clone_it,
 		}
 	}
 =

-	tcp_options_write((__be32 *)(th + 1), tp, &opts);
+	ptr =3D (__be32 *)(th + 1);
+	orig_ptr =3D ptr;
+	tp->op_ops->options_write(&ptr, tp, &opts, skb);
+	WARN_ON((ptr - orig_ptr) * 4 !=3D tcp_options_size);
 	skb_shinfo(skb)->gso_type =3D sk->sk_gso_type;
 	if (likely(!(tcb->tcp_flags & TCPHDR_SYN))) {
 		th->window      =3D htons(tcp_select_window(sk));
@@ -1582,8 +1598,9 @@ unsigned int tcp_current_mss(struct sock *sk)
 			mss_now =3D tcp_sync_mss(sk, mtu);
 	}
 =

-	header_len =3D tcp_established_options(sk, NULL, &opts, &md5) +
-		     sizeof(struct tcphdr);
+	header_len =3D tp->op_ops->options_size(sk, NULL, &opts, &md5) +
+					      sizeof(struct tcphdr);
+
 	/* The mss_cache is sized based on tp->tcp_header_len, which assumes
 	 * some common options. If this is an odd packet (because we have SACK
 	 * blocks etc) then our calculated header_len will be different, and
@@ -3164,13 +3181,14 @@ struct sk_buff *tcp_make_synack(const struct sock *=
sk, struct dst_entry *dst,
 				enum tcp_synack_type synack_type)
 {
 	struct inet_request_sock *ireq =3D inet_rsk(req);
-	const struct tcp_sock *tp =3D tcp_sk(sk);
+	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct tcp_md5sig_key *md5 =3D NULL;
 	struct tcp_out_options opts;
 	struct sk_buff *skb;
 	int tcp_header_size;
 	struct tcphdr *th;
 	int mss;
+	__be32 *ptr;
 =

 	skb =3D alloc_skb(MAX_TCP_HEADER, GFP_ATOMIC);
 	if (unlikely(!skb)) {
@@ -3214,8 +3232,9 @@ struct sk_buff *tcp_make_synack(const struct sock *sk=
, struct dst_entry *dst,
 	md5 =3D tcp_rsk(req)->af_specific->req_md5_lookup(sk, req_to_sk(req));
 #endif
 	skb_set_hash(skb, tcp_rsk(req)->txhash, PKT_HASH_TYPE_L4);
-	tcp_header_size =3D tcp_synack_options(sk, req, mss, skb, &opts, md5,
-					     foc) + sizeof(*th);
+	tcp_header_size =3D tp->op_ops->synack_options_size(sk, req, mss, skb,
+							  &opts, md5, foc);
+	tcp_header_size +=3D sizeof(*th);
 =

 	skb_push(skb, tcp_header_size);
 	skb_reset_transport_header(skb);
@@ -3235,7 +3254,8 @@ struct sk_buff *tcp_make_synack(const struct sock *sk=
, struct dst_entry *dst,
 =

 	/* RFC1323: The window in SYN & SYN/ACK segments is never scaled. */
 	th->window =3D htons(min(req->rsk_rcv_wnd, 65535U));
-	tcp_options_write((__be32 *)(th + 1), NULL, &opts);
+	ptr =3D (__be32 *)(th + 1);
+	tp->op_ops->options_write(&ptr, tp, &opts, skb);
 	th->doff =3D (tcp_header_size >> 2);
 	__TCP_INC_STATS(sock_net(sk), TCP_MIB_OUTSEGS);
 =

-- =

2.7.4


--===============9153166697510970147==--
