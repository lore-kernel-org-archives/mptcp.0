Content-Type: multipart/mixed; boundary="===============0068815235678886378=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 1/2] mptcp: place is_mptcp checks under
 ifdef guards
Date: Thu, 11 Apr 2019 13:43:24 +0200
Message-ID: <20190411114325.29375-2-fw@strlen.de>
In-Reply-To: 20190411114325.29375-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1063

--===============0068815235678886378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After this patch, a CONFIG_MPTCP=3Dn build is the same as a build with all
mptcp patches reverted.
I moved the struct members around a bit so they cover holes in the
original structs.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 include/linux/tcp.h   | 7 +++++--
 include/net/mptcp.h   | 8 ++++++++
 net/ipv4/tcp_input.c  | 6 ++++--
 net/ipv4/tcp_output.c | 2 +-
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 71522b08ad5e..2f4178f3d127 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -155,7 +155,9 @@ struct tcp_request_sock {
 	const struct tcp_request_sock_ops *af_specific;
 	u64				snt_synack; /* first SYNACK sent time */
 	bool				tfo_listener;
+#if IS_ENABLED(CONFIG_MPTCP)
 	bool				is_mptcp;
+#endif
 	u32				txhash;
 	u32				rcv_isn;
 	u32				snt_isn;
@@ -413,6 +415,9 @@ struct tcp_sock {
 	u32	mtu_info; /* We received an ICMP_FRAG_NEEDED / ICMPV6_PKT_TOOBIG
 			   * while socket was owned by user.
 			   */
+#if IS_ENABLED(CONFIG_MPTCP)
+	bool	is_mptcp;
+#endif
 =

 #ifdef CONFIG_TCP_MD5SIG
 /* TCP AF-Specific parts; only used by MD5 Signature support so far */
@@ -429,8 +434,6 @@ struct tcp_sock {
 	 */
 	struct request_sock *fastopen_rsk;
 	u32	*saved_syn;
-
-	bool	is_mptcp;
 };
 =

 enum tsq_enum {
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 0c0839d9ab38..1050bfa71f61 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -208,6 +208,10 @@ void mptcp_write_option_header(__be32 *ptr, struct sk_=
buff *skb,
 			       struct tcp_sock *tp,
 			       struct mptcp_out_options *opts);
 =

+static inline bool sk_is_mptcp(const struct sock *sk)
+{
+	return tcp_sk(sk)->is_mptcp;
+}
 #else
 =

 static inline void mptcp_parse_option(const unsigned char *ptr, int opsize,
@@ -248,5 +252,9 @@ static inline bool mptcp_skb_ext_exist(const struct sk_=
buff *skb)
 	return false;
 }
 =

+static inline bool sk_is_mptcp(const struct sock *sk)
+{
+	return false;
+}
 #endif /* CONFIG_MPTCP */
 #endif /* __NET_MPTCP_H */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index a3a77b6e50ae..99b5427cadbe 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5643,7 +5643,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_b=
uff *skb)
 	tcp_urg(sk, skb, th);
 =

 	/* Prepare MPTCP sequence data */
-	if (tcp_sk(sk)->is_mptcp)
+	if (sk_is_mptcp(sk))
 		mptcp_attach_dss(sk, skb, &tp->rx_opt);
 =

 	/* step 7: process the segment text */
@@ -5861,7 +5861,7 @@ static int tcp_rcv_synsent_state_process(struct sock =
*sk, struct sk_buff *skb,
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
 		tcp_initialize_rcv_mss(sk);
 =

-		if (tp->is_mptcp)
+		if (sk_is_mptcp(sk))
 			mptcp_rcv_synsent(sk);
 =

 		/* Remember, tcp_poll() does not lock socket!
@@ -6442,7 +6442,9 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 =

 	tcp_rsk(req)->af_specific =3D af_ops;
 	tcp_rsk(req)->ts_off =3D 0;
+#if IS_ENABLED(CONFIG_MPTCP)
 	tcp_rsk(req)->is_mptcp =3D 0;
+#endif
 =

 	tcp_clear_options(&tmp_opt);
 	tmp_opt.mss_clamp =3D af_ops->mss_clamp;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 6d846c785e0b..0d8f2b7e481d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3769,7 +3769,7 @@ void __tcp_send_ack(struct sock *sk, u32 rcv_nxt)
 	skb_set_tcp_pure_ack(buff);
 =

 	/* Send it off, this clears delayed acks for us. */
-	if (tcp_sk(sk)->is_mptcp)
+	if (sk_is_mptcp(sk))
 		pr_debug("mptcp sk=3D%p", sk);
 =

 	__tcp_transmit_skb(sk, buff, 0, (__force gfp_t)0, rcv_nxt);
-- =

2.21.0


--===============0068815235678886378==--
