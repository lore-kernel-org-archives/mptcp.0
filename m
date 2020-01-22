Content-Type: multipart/mixed; boundary="===============2369887092053057887=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v3 04/19] mptcp: Handle MP_CAPABLE options
 for outgoing connections
Date: Tue, 21 Jan 2020 16:56:18 -0800
Message-ID: <20200122005633.21229-5-cpaasch@apple.com>
In-Reply-To: 20200122005633.21229-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 3477

--===============2369887092053057887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)linux.intel.com>

Add hooks to tcp_output.c to add MP_CAPABLE to an outgoing SYN request,
to capture the MP_CAPABLE in the received SYN-ACK, to add MP_CAPABLE to
the final ACK of the three-way handshake.

Use the .sk_rx_dst_set() handler in the subflow proto to capture when the
responding SYN-ACK is received and notify the MPTCP connection layer.

Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Co-developed-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/linux/tcp.h   |   3 +
 include/net/mptcp.h   |  57 +++++++++
 net/ipv4/tcp_input.c  |   6 +
 net/ipv4/tcp_output.c |  44 +++++++
 net/ipv6/tcp_ipv6.c   |   6 +
 net/mptcp/options.c   | 100 ++++++++++++++++
 net/mptcp/protocol.c  | 163 +++++++++++++++++++++----
 net/mptcp/protocol.h  |  40 ++++++-
 net/mptcp/subflow.c   | 268 +++++++++++++++++++++++++++++++++++++++++-
 9 files changed, 663 insertions(+), 24 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 877947475814..e9ee06d887fa 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -137,6 +137,9 @@ struct tcp_request_sock {
 	const struct tcp_request_sock_ops *af_specific;
 	u64				snt_synack; /* first SYNACK sent time */
 	bool				tfo_listener;
+#if IS_ENABLED(CONFIG_MPTCP)
+	bool				is_mptcp;
+#endif
 	u32				txhash;
 	u32				rcv_isn;
 	u32				snt_isn;
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 3daec2ceb3ff..eabc57c3fde4 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -39,8 +39,27 @@ struct mptcp_out_options {
 =

 void mptcp_init(void);
 =

+static inline bool sk_is_mptcp(const struct sock *sk)
+{
+	return tcp_sk(sk)->is_mptcp;
+}
+
+static inline bool rsk_is_mptcp(const struct request_sock *req)
+{
+	return tcp_rsk(req)->is_mptcp;
+}
+
 void mptcp_parse_option(const unsigned char *ptr, int opsize,
 			struct tcp_options_received *opt_rx);
+bool mptcp_syn_options(struct sock *sk, unsigned int *size,
+		       struct mptcp_out_options *opts);
+void mptcp_rcv_synsent(struct sock *sk);
+bool mptcp_synack_options(const struct request_sock *req, unsigned int *si=
ze,
+			  struct mptcp_out_options *opts);
+bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
+			       unsigned int *size, unsigned int remaining,
+			       struct mptcp_out_options *opts);
+
 void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts);
 =

 /* move the skb extension owership, with the assumption that 'to' is
@@ -89,11 +108,47 @@ static inline void mptcp_init(void)
 {
 }
 =

+static inline bool sk_is_mptcp(const struct sock *sk)
+{
+	return false;
+}
+
+static inline bool rsk_is_mptcp(const struct request_sock *req)
+{
+	return false;
+}
+
 static inline void mptcp_parse_option(const unsigned char *ptr, int opsize,
 				      struct tcp_options_received *opt_rx)
 {
 }
 =

+static inline bool mptcp_syn_options(struct sock *sk, unsigned int *size,
+				     struct mptcp_out_options *opts)
+{
+	return false;
+}
+
+static inline void mptcp_rcv_synsent(struct sock *sk)
+{
+}
+
+static inline bool mptcp_synack_options(const struct request_sock *req,
+					unsigned int *size,
+					struct mptcp_out_options *opts)
+{
+	return false;
+}
+
+static inline bool mptcp_established_options(struct sock *sk,
+					     struct sk_buff *skb,
+					     unsigned int *size,
+					     unsigned int remaining,
+					     struct mptcp_out_options *opts)
+{
+	return false;
+}
+
 static inline void mptcp_skb_ext_move(struct sk_buff *to,
 				      const struct sk_buff *from)
 {
@@ -107,6 +162,8 @@ static inline bool mptcp_skb_can_collapse(const struct =
sk_buff *to,
 =

 #endif /* CONFIG_MPTCP */
 =

+void mptcp_handle_ipv6_mapped(struct sock *sk, bool mapped);
+
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 int mptcpv6_init(void);
 #elif IS_ENABLED(CONFIG_IPV6)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 3458ee13e6f0..5165c8de47ee 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5978,6 +5978,9 @@ static int tcp_rcv_synsent_state_process(struct sock =
*sk, struct sk_buff *skb,
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
 		tcp_initialize_rcv_mss(sk);
 =

+		if (sk_is_mptcp(sk))
+			mptcp_rcv_synsent(sk);
+
 		/* Remember, tcp_poll() does not lock socket!
 		 * Change state from SYN-SENT only after copied_seq
 		 * is initialized. */
@@ -6600,6 +6603,9 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 =

 	tcp_rsk(req)->af_specific =3D af_ops;
 	tcp_rsk(req)->ts_off =3D 0;
+#if IS_ENABLED(CONFIG_MPTCP)
+	tcp_rsk(req)->is_mptcp =3D 0;
+#endif
 =

 	tcp_clear_options(&tmp_opt);
 	tmp_opt.mss_clamp =3D af_ops->mss_clamp;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b6cf87b02b01..c6797a388921 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -597,6 +597,22 @@ static void smc_set_option_cond(const struct tcp_sock =
*tp,
 #endif
 }
 =

+static void mptcp_set_option_cond(const struct request_sock *req,
+				  struct tcp_out_options *opts,
+				  unsigned int *remaining)
+{
+	if (rsk_is_mptcp(req)) {
+		unsigned int size;
+
+		if (mptcp_synack_options(req, &size, &opts->mptcp)) {
+			if (*remaining >=3D size) {
+				opts->options |=3D OPTION_MPTCP;
+				*remaining -=3D size;
+			}
+		}
+	}
+}
+
 /* Compute TCP options for SYN packets. This is not the final
  * network wire format yet.
  */
@@ -666,6 +682,15 @@ static unsigned int tcp_syn_options(struct sock *sk, s=
truct sk_buff *skb,
 =

 	smc_set_option(tp, opts, &remaining);
 =

+	if (sk_is_mptcp(sk)) {
+		unsigned int size;
+
+		if (mptcp_syn_options(sk, &size, &opts->mptcp)) {
+			opts->options |=3D OPTION_MPTCP;
+			remaining -=3D size;
+		}
+	}
+
 	return MAX_TCP_OPTION_SPACE - remaining;
 }
 =

@@ -727,6 +752,8 @@ static unsigned int tcp_synack_options(const struct soc=
k *sk,
 		}
 	}
 =

+	mptcp_set_option_cond(req, opts, &remaining);
+
 	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
 =

 	return MAX_TCP_OPTION_SPACE - remaining;
@@ -764,6 +791,23 @@ static unsigned int tcp_established_options(struct soc=
k *sk, struct sk_buff *skb
 		size +=3D TCPOLEN_TSTAMP_ALIGNED;
 	}
 =

+	/* MPTCP options have precedence over SACK for the limited TCP
+	 * option space because a MPTCP connection would be forced to
+	 * fall back to regular TCP if a required multipath option is
+	 * missing. SACK still gets a chance to use whatever space is
+	 * left.
+	 */
+	if (sk_is_mptcp(sk)) {
+		unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
+		unsigned int opt_size =3D 0;
+
+		if (mptcp_established_options(sk, skb, &opt_size, remaining,
+					      &opts->mptcp)) {
+			opts->options |=3D OPTION_MPTCP;
+			size +=3D opt_size;
+		}
+	}
+
 	eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
 		const unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 60068ffde1d9..33a578a3eb3a 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -238,6 +238,8 @@ static int tcp_v6_connect(struct sock *sk, struct socka=
ddr *uaddr,
 		sin.sin_addr.s_addr =3D usin->sin6_addr.s6_addr32[3];
 =

 		icsk->icsk_af_ops =3D &ipv6_mapped;
+		if (sk_is_mptcp(sk))
+			mptcp_handle_ipv6_mapped(sk, true);
 		sk->sk_backlog_rcv =3D tcp_v4_do_rcv;
 #ifdef CONFIG_TCP_MD5SIG
 		tp->af_specific =3D &tcp_sock_ipv6_mapped_specific;
@@ -248,6 +250,8 @@ static int tcp_v6_connect(struct sock *sk, struct socka=
ddr *uaddr,
 		if (err) {
 			icsk->icsk_ext_hdr_len =3D exthdrlen;
 			icsk->icsk_af_ops =3D &ipv6_specific;
+			if (sk_is_mptcp(sk))
+				mptcp_handle_ipv6_mapped(sk, false);
 			sk->sk_backlog_rcv =3D tcp_v6_do_rcv;
 #ifdef CONFIG_TCP_MD5SIG
 			tp->af_specific =3D &tcp_sock_ipv6_specific;
@@ -1203,6 +1207,8 @@ static struct sock *tcp_v6_syn_recv_sock(const struct=
 sock *sk, struct sk_buff *
 		newnp->saddr =3D newsk->sk_v6_rcv_saddr;
 =

 		inet_csk(newsk)->icsk_af_ops =3D &ipv6_mapped;
+		if (sk_is_mptcp(newsk))
+			mptcp_handle_ipv6_mapped(newsk, true);
 		newsk->sk_backlog_rcv =3D tcp_v4_do_rcv;
 #ifdef CONFIG_TCP_MD5SIG
 		newtp->af_specific =3D &tcp_sock_ipv6_mapped_specific;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b7a31c0e5283..52ff2301b68b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -72,14 +72,114 @@ void mptcp_parse_option(const unsigned char *ptr, int =
opsize,
 	}
 }
 =

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
+bool mptcp_syn_options(struct sock *sk, unsigned int *size,
+		       struct mptcp_out_options *opts)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+
+	if (subflow->request_mptcp) {
+		pr_debug("local_key=3D%llu", subflow->local_key);
+		opts->suboptions =3D OPTION_MPTCP_MPC_SYN;
+		opts->sndr_key =3D subflow->local_key;
+		*size =3D TCPOLEN_MPTCP_MPC_SYN;
+		return true;
+	}
+	return false;
+}
+
+void mptcp_rcv_synsent(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct tcp_sock *tp =3D tcp_sk(sk);
+
+	pr_debug("subflow=3D%p", subflow);
+	if (subflow->request_mptcp && tp->rx_opt.mptcp.mp_capable) {
+		subflow->mp_capable =3D 1;
+		subflow->remote_key =3D tp->rx_opt.mptcp.sndr_key;
+	} else {
+		tcp_sk(sk)->is_mptcp =3D 0;
+	}
+}
+
+bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
+			       unsigned int *size, unsigned int remaining,
+			       struct mptcp_out_options *opts)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+
+	if (subflow->mp_capable && !subflow->fourth_ack) {
+		opts->suboptions =3D OPTION_MPTCP_MPC_ACK;
+		opts->sndr_key =3D subflow->local_key;
+		opts->rcvr_key =3D subflow->remote_key;
+		*size =3D TCPOLEN_MPTCP_MPC_ACK;
+		subflow->fourth_ack =3D 1;
+		pr_debug("subflow=3D%p, local_key=3D%llu, remote_key=3D%llu",
+			 subflow, subflow->local_key, subflow->remote_key);
+		return true;
+	}
+	return false;
+}
+
+bool mptcp_synack_options(const struct request_sock *req, unsigned int *si=
ze,
+			  struct mptcp_out_options *opts)
+{
+	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
+
+	if (subflow_req->mp_capable) {
+		opts->suboptions =3D OPTION_MPTCP_MPC_SYNACK;
+		opts->sndr_key =3D subflow_req->local_key;
+		*size =3D TCPOLEN_MPTCP_MPC_SYNACK;
+		pr_debug("subflow_req=3D%p, local_key=3D%llu",
+			 subflow_req, subflow_req->local_key);
+		return true;
+	}
+	return false;
+}
+
 void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts)
 {
 	if ((OPTION_MPTCP_MPC_SYN |
+	     OPTION_MPTCP_MPC_SYNACK |
 	     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
 		u8 len;
 =

 		if (OPTION_MPTCP_MPC_SYN & opts->suboptions)
 			len =3D TCPOLEN_MPTCP_MPC_SYN;
+		else if (OPTION_MPTCP_MPC_SYNACK & opts->suboptions)
+			len =3D TCPOLEN_MPTCP_MPC_SYNACK;
 		else
 			len =3D TCPOLEN_MPTCP_MPC_ACK;
 =

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 294b03a0393a..bdd58da1e4f6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -25,12 +25,28 @@
  */
 static struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk)
 {
-	if (!msk->subflow)
+	if (!msk->subflow || mptcp_subflow_ctx(msk->subflow->sk)->fourth_ack)
 		return NULL;
 =

 	return msk->subflow;
 }
 =

+/* if msk has a single subflow, and the mp_capable handshake is failed,
+ * return it.
+ * Otherwise returns NULL
+ */
+static struct socket *__mptcp_tcp_fallback(const struct mptcp_sock *msk)
+{
+	struct socket *ssock =3D __mptcp_nmpc_socket(msk);
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	if (!ssock || sk_is_mptcp(ssock->sk))
+		return NULL;
+
+	return ssock;
+}
+
 static bool __mptcp_can_create_subflow(const struct mptcp_sock *msk)
 {
 	return ((struct sock *)msk)->sk_state =3D=3D TCP_CLOSE;
@@ -56,6 +72,7 @@ static struct socket *__mptcp_socket_create(struct mptcp_=
sock *msk, int state)
 =

 	msk->subflow =3D ssock;
 	subflow =3D mptcp_subflow_ctx(ssock->sk);
+	list_add(&subflow->node, &msk->conn_list);
 	subflow->request_mptcp =3D 1;
 =

 set_state:
@@ -64,66 +81,169 @@ static struct socket *__mptcp_socket_create(struct mpt=
cp_sock *msk, int state)
 	return ssock;
 }
 =

+static struct sock *mptcp_subflow_get(const struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		return mptcp_subflow_tcp_sock(subflow);
+	}
+
+	return NULL;
+}
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct socket *subflow =3D msk->subflow;
+	struct socket *ssock;
+	struct sock *ssk;
+	int ret;
 =

 	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL))
 		return -EOPNOTSUPP;
 =

-	return sock_sendmsg(subflow, msg);
+	lock_sock(sk);
+	ssock =3D __mptcp_tcp_fallback(msk);
+	if (ssock) {
+		pr_debug("fallback passthrough");
+		ret =3D sock_sendmsg(ssock, msg);
+		release_sock(sk);
+		return ret;
+	}
+
+	ssk =3D mptcp_subflow_get(msk);
+	if (!ssk) {
+		release_sock(sk);
+		return -ENOTCONN;
+	}
+
+	ret =3D sock_sendmsg(ssk->sk_socket, msg);
+
+	release_sock(sk);
+	return ret;
 }
 =

 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int nonblock, int flags, int *addr_len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct socket *subflow =3D msk->subflow;
+	struct socket *ssock;
+	struct sock *ssk;
+	int copied =3D 0;
 =

 	if (msg->msg_flags & ~(MSG_WAITALL | MSG_DONTWAIT))
 		return -EOPNOTSUPP;
 =

-	return sock_recvmsg(subflow, msg, flags);
+	lock_sock(sk);
+	ssock =3D __mptcp_tcp_fallback(msk);
+	if (ssock) {
+		pr_debug("fallback-read subflow=3D%p",
+			 mptcp_subflow_ctx(ssock->sk));
+		copied =3D sock_recvmsg(ssock, msg, flags);
+		release_sock(sk);
+		return copied;
+	}
+
+	ssk =3D mptcp_subflow_get(msk);
+	if (!ssk) {
+		release_sock(sk);
+		return -ENOTCONN;
+	}
+
+	copied =3D sock_recvmsg(ssk->sk_socket, msg, flags);
+
+	release_sock(sk);
+
+	return copied;
+}
+
+/* subflow sockets can be either outgoing (connect) or incoming
+ * (accept).
+ *
+ * Outgoing subflows use in-kernel sockets.
+ * Incoming subflows do not have their own 'struct socket' allocated,
+ * so we need to use tcp_close() after detaching them from the mptcp
+ * parent socket.
+ */
+static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
+			      struct mptcp_subflow_context *subflow,
+			      long timeout)
+{
+	struct socket *sock =3D READ_ONCE(ssk->sk_socket);
+
+	list_del(&subflow->node);
+
+	if (sock && sock !=3D sk->sk_socket) {
+		/* outgoing subflow */
+		sock_release(sock);
+	} else {
+		/* incoming subflow */
+		tcp_close(ssk, timeout);
+	}
 }
 =

 static int mptcp_init_sock(struct sock *sk)
 {
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	INIT_LIST_HEAD(&msk->conn_list);
+
 	return 0;
 }
 =

 static void mptcp_close(struct sock *sk, long timeout)
 {
+	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct socket *ssock;
 =

 	inet_sk_state_store(sk, TCP_CLOSE);
 =

-	ssock =3D __mptcp_nmpc_socket(msk);
-	if (ssock) {
-		pr_debug("subflow=3D%p", mptcp_subflow_ctx(ssock->sk));
-		sock_release(ssock);
+	lock_sock(sk);
+
+	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+		__mptcp_close_ssk(sk, ssk, subflow, timeout);
 	}
 =

-	sock_orphan(sk);
-	sock_put(sk);
+	release_sock(sk);
+	sk_common_release(sk);
 }
 =

-static int mptcp_connect(struct sock *sk, struct sockaddr *saddr, int len)
+static int mptcp_get_port(struct sock *sk, unsigned short snum)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	int err;
+	struct socket *ssock;
 =

-	saddr->sa_family =3D AF_INET;
+	ssock =3D __mptcp_nmpc_socket(msk);
+	pr_debug("msk=3D%p, subflow=3D%p", msk, ssock);
+	if (WARN_ON_ONCE(!ssock))
+		return -EINVAL;
 =

-	pr_debug("msk=3D%p, subflow=3D%p", msk,
-		 mptcp_subflow_ctx(msk->subflow->sk));
+	return inet_csk_get_port(ssock->sk, snum);
+}
 =

-	err =3D kernel_connect(msk->subflow, saddr, len, 0);
+void mptcp_finish_connect(struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk;
+	struct sock *sk;
 =

-	sk->sk_state =3D TCP_ESTABLISHED;
+	subflow =3D mptcp_subflow_ctx(ssk);
 =

-	return err;
+	if (!subflow->mp_capable)
+		return;
+
+	sk =3D subflow->conn;
+	msk =3D mptcp_sk(sk);
+
+	/* the socket is not connected yet, no msk/subflow ops can access/race
+	 * accessing the field below
+	 */
+	WRITE_ONCE(msk->remote_key, subflow->remote_key);
+	WRITE_ONCE(msk->local_key, subflow->local_key);
 }
 =

 static struct proto mptcp_prot =3D {
@@ -132,13 +252,12 @@ static struct proto mptcp_prot =3D {
 	.init		=3D mptcp_init_sock,
 	.close		=3D mptcp_close,
 	.accept		=3D inet_csk_accept,
-	.connect	=3D mptcp_connect,
 	.shutdown	=3D tcp_shutdown,
 	.sendmsg	=3D mptcp_sendmsg,
 	.recvmsg	=3D mptcp_recvmsg,
 	.hash		=3D inet_hash,
 	.unhash		=3D inet_unhash,
-	.get_port	=3D inet_csk_get_port,
+	.get_port	=3D mptcp_get_port,
 	.obj_size	=3D sizeof(struct mptcp_sock),
 	.no_autobind	=3D true,
 };
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 543d4d5d8985..bd66e7415515 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -40,19 +40,47 @@
 struct mptcp_sock {
 	/* inet_connection_sock must be the first member */
 	struct inet_connection_sock sk;
+	u64		local_key;
+	u64		remote_key;
+	struct list_head conn_list;
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 };
 =

+#define mptcp_for_each_subflow(__msk, __subflow)			\
+	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
+
 static inline struct mptcp_sock *mptcp_sk(const struct sock *sk)
 {
 	return (struct mptcp_sock *)sk;
 }
 =

+struct mptcp_subflow_request_sock {
+	struct	tcp_request_sock sk;
+	u8	mp_capable : 1,
+		mp_join : 1,
+		backup : 1;
+	u64	local_key;
+	u64	remote_key;
+};
+
+static inline struct mptcp_subflow_request_sock *
+mptcp_subflow_rsk(const struct request_sock *rsk)
+{
+	return (struct mptcp_subflow_request_sock *)rsk;
+}
+
 /* MPTCP subflow context */
 struct mptcp_subflow_context {
-	u32	request_mptcp : 1;  /* send MP_CAPABLE */
+	struct	list_head node;/* conn_list of subflows */
+	u64	local_key;
+	u64	remote_key;
+	u32	request_mptcp : 1,  /* send MP_CAPABLE */
+		mp_capable : 1,	    /* remote is MPTCP capable */
+		fourth_ack : 1,	    /* send initial DSS */
+		conn_finished : 1;
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 	struct	sock *conn;	    /* parent mptcp_sock */
+	const	struct inet_connection_sock_af_ops *icsk_af_ops;
 	struct	rcu_head rcu;
 };
 =

@@ -74,4 +102,14 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_conte=
xt *subflow)
 void mptcp_subflow_init(void);
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
 =

+extern const struct inet_connection_sock_af_ops ipv4_specific;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+extern const struct inet_connection_sock_af_ops ipv6_specific;
+#endif
+
+void mptcp_get_options(const struct sk_buff *skb,
+		       struct tcp_options_received *opt_rx);
+
+void mptcp_finish_connect(struct sock *sk);
+
 #endif /* __MPTCP_PROTOCOL_H */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bf8139353653..df3192305967 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -12,9 +12,188 @@
 #include <net/inet_hashtables.h>
 #include <net/protocol.h>
 #include <net/tcp.h>
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+#include <net/ip6_route.h>
+#endif
 #include <net/mptcp.h>
 #include "protocol.h"
 =

+static void subflow_init_req(struct request_sock *req,
+			     const struct sock *sk_listener,
+			     struct sk_buff *skb)
+{
+	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk_listener);
+	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
+	struct tcp_options_received rx_opt;
+
+	pr_debug("subflow_req=3D%p, listener=3D%p", subflow_req, listener);
+
+	memset(&rx_opt.mptcp, 0, sizeof(rx_opt.mptcp));
+	mptcp_get_options(skb, &rx_opt);
+
+	subflow_req->mp_capable =3D 0;
+
+#ifdef CONFIG_TCP_MD5SIG
+	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
+	 * TCP option space.
+	 */
+	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info))
+		return;
+#endif
+
+	if (rx_opt.mptcp.mp_capable && listener->request_mptcp) {
+		subflow_req->mp_capable =3D 1;
+		subflow_req->remote_key =3D rx_opt.mptcp.sndr_key;
+	}
+}
+
+static void subflow_v4_init_req(struct request_sock *req,
+				const struct sock *sk_listener,
+				struct sk_buff *skb)
+{
+	tcp_rsk(req)->is_mptcp =3D 1;
+
+	tcp_request_sock_ipv4_ops.init_req(req, sk_listener, skb);
+
+	subflow_init_req(req, sk_listener, skb);
+}
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static void subflow_v6_init_req(struct request_sock *req,
+				const struct sock *sk_listener,
+				struct sk_buff *skb)
+{
+	tcp_rsk(req)->is_mptcp =3D 1;
+
+	tcp_request_sock_ipv6_ops.init_req(req, sk_listener, skb);
+
+	subflow_init_req(req, sk_listener, skb);
+}
+#endif
+
+static void subflow_finish_connect(struct sock *sk, const struct sk_buff *=
skb)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+
+	subflow->icsk_af_ops->sk_rx_dst_set(sk, skb);
+
+	if (subflow->conn && !subflow->conn_finished) {
+		pr_debug("subflow=3D%p, remote_key=3D%llu", mptcp_subflow_ctx(sk),
+			 subflow->remote_key);
+		mptcp_finish_connect(sk);
+		subflow->conn_finished =3D 1;
+	}
+}
+
+static struct request_sock_ops subflow_request_sock_ops;
+static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops;
+
+static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+
+	pr_debug("subflow=3D%p", subflow);
+
+	/* Never answer to SYNs sent to broadcast or multicast */
+	if (skb_rtable(skb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
+		goto drop;
+
+	return tcp_conn_request(&subflow_request_sock_ops,
+				&subflow_request_sock_ipv4_ops,
+				sk, skb);
+drop:
+	tcp_listendrop(sk);
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops;
+static struct inet_connection_sock_af_ops subflow_v6_specific;
+static struct inet_connection_sock_af_ops subflow_v6m_specific;
+
+static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+
+	pr_debug("subflow=3D%p", subflow);
+
+	if (skb->protocol =3D=3D htons(ETH_P_IP))
+		return subflow_v4_conn_request(sk, skb);
+
+	if (!ipv6_unicast_destination(skb))
+		goto drop;
+
+	return tcp_conn_request(&subflow_request_sock_ops,
+				&subflow_request_sock_ipv6_ops, sk, skb);
+
+drop:
+	tcp_listendrop(sk);
+	return 0; /* don't send reset */
+}
+#endif
+
+static struct sock *subflow_syn_recv_sock(const struct sock *sk,
+					  struct sk_buff *skb,
+					  struct request_sock *req,
+					  struct dst_entry *dst,
+					  struct request_sock *req_unhash,
+					  bool *own_req)
+{
+	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk);
+	struct sock *child;
+
+	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listener->c=
onn);
+
+	/* if the sk is MP_CAPABLE, we already received the client key */
+
+	child =3D listener->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
+						     req_unhash, own_req);
+
+	if (child && *own_req) {
+		if (!mptcp_subflow_ctx(child)) {
+			pr_debug("Closing child socket");
+			inet_sk_set_state(child, TCP_CLOSE);
+			sock_set_flag(child, SOCK_DEAD);
+			inet_csk_destroy_sock(child);
+			child =3D NULL;
+		}
+	}
+
+	return child;
+}
+
+static struct inet_connection_sock_af_ops subflow_specific;
+
+static struct inet_connection_sock_af_ops *
+subflow_default_af_ops(struct sock *sk)
+{
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (sk->sk_family =3D=3D AF_INET6)
+		return &subflow_v6_specific;
+#endif
+	return &subflow_specific;
+}
+
+void mptcp_handle_ipv6_mapped(struct sock *sk, bool mapped)
+{
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct inet_connection_sock *icsk =3D inet_csk(sk);
+	struct inet_connection_sock_af_ops *target;
+
+	target =3D mapped ? &subflow_v6m_specific : subflow_default_af_ops(sk);
+
+	pr_debug("subflow=3D%p family=3D%d ops=3D%p target=3D%p mapped=3D%d",
+	         subflow, sk->sk_family, icsk->icsk_af_ops, target, mapped);
+
+	if (likely(icsk->icsk_af_ops =3D=3D target))
+		return;
+
+	subflow->icsk_af_ops =3D icsk->icsk_af_ops;
+	icsk->icsk_af_ops =3D target;
+#endif
+}
+
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 {
 	struct mptcp_subflow_context *subflow;
@@ -22,7 +201,8 @@ int mptcp_subflow_create_socket(struct sock *sk, struct =
socket **new_sock)
 	struct socket *sf;
 	int err;
 =

-	err =3D sock_create_kern(net, PF_INET, SOCK_STREAM, IPPROTO_TCP, &sf);
+	err =3D sock_create_kern(net, sk->sk_family, SOCK_STREAM, IPPROTO_TCP,
+			       &sf);
 	if (err)
 		return err;
 =

@@ -60,6 +240,7 @@ static struct mptcp_subflow_context *subflow_create_ctx(=
struct sock *sk,
 		return NULL;
 =

 	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
+	INIT_LIST_HEAD(&ctx->node);
 =

 	pr_debug("subflow=3D%p", ctx);
 =

@@ -70,6 +251,7 @@ static struct mptcp_subflow_context *subflow_create_ctx(=
struct sock *sk,
 =

 static int subflow_ulp_init(struct sock *sk)
 {
+	struct inet_connection_sock *icsk =3D inet_csk(sk);
 	struct mptcp_subflow_context *ctx;
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	int err =3D 0;
@@ -91,6 +273,8 @@ static int subflow_ulp_init(struct sock *sk)
 	pr_debug("subflow=3D%p, family=3D%d", ctx, sk->sk_family);
 =

 	tp->is_mptcp =3D 1;
+	ctx->icsk_af_ops =3D icsk->icsk_af_ops;
+	icsk->icsk_af_ops =3D subflow_default_af_ops(sk);
 out:
 	return err;
 }
@@ -105,15 +289,97 @@ static void subflow_ulp_release(struct sock *sk)
 	kfree_rcu(ctx, rcu);
 }
 =

+static void subflow_ulp_fallback(struct sock *sk)
+{
+	struct inet_connection_sock *icsk =3D inet_csk(sk);
+
+	icsk->icsk_ulp_ops =3D NULL;
+	rcu_assign_pointer(icsk->icsk_ulp_data, NULL);
+	tcp_sk(sk)->is_mptcp =3D 0;
+}
+
+static void subflow_ulp_clone(const struct request_sock *req,
+			      struct sock *newsk,
+			      const gfp_t priority)
+{
+	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
+	struct mptcp_subflow_context *old_ctx =3D mptcp_subflow_ctx(newsk);
+	struct mptcp_subflow_context *new_ctx;
+
+	if (!subflow_req->mp_capable) {
+		subflow_ulp_fallback(newsk);
+		return;
+	}
+
+	new_ctx =3D subflow_create_ctx(newsk, priority);
+	if (new_ctx =3D=3D NULL) {
+		subflow_ulp_fallback(newsk);
+		return;
+	}
+
+	new_ctx->conn_finished =3D 1;
+	new_ctx->icsk_af_ops =3D old_ctx->icsk_af_ops;
+	new_ctx->mp_capable =3D 1;
+	new_ctx->fourth_ack =3D 1;
+	new_ctx->remote_key =3D subflow_req->remote_key;
+	new_ctx->local_key =3D subflow_req->local_key;
+}
+
 static struct tcp_ulp_ops subflow_ulp_ops __read_mostly =3D {
 	.name		=3D "mptcp",
 	.owner		=3D THIS_MODULE,
 	.init		=3D subflow_ulp_init,
 	.release	=3D subflow_ulp_release,
+	.clone		=3D subflow_ulp_clone,
 };
 =

+static int subflow_ops_init(struct request_sock_ops *subflow_ops)
+{
+	subflow_ops->obj_size =3D sizeof(struct mptcp_subflow_request_sock);
+	subflow_ops->slab_name =3D "request_sock_subflow";
+
+	subflow_ops->slab =3D kmem_cache_create(subflow_ops->slab_name,
+					      subflow_ops->obj_size, 0,
+					      SLAB_ACCOUNT |
+					      SLAB_TYPESAFE_BY_RCU,
+					      NULL);
+	if (!subflow_ops->slab)
+		return -ENOMEM;
+
+	return 0;
+}
+
 void mptcp_subflow_init(void)
 {
+	subflow_request_sock_ops =3D tcp_request_sock_ops;
+	if (subflow_ops_init(&subflow_request_sock_ops) !=3D 0)
+		panic("MPTCP: failed to init subflow request sock ops\n");
+
+	subflow_request_sock_ipv4_ops =3D tcp_request_sock_ipv4_ops;
+	subflow_request_sock_ipv4_ops.init_req =3D subflow_v4_init_req;
+
+	subflow_specific =3D ipv4_specific;
+	subflow_specific.conn_request =3D subflow_v4_conn_request;
+	subflow_specific.syn_recv_sock =3D subflow_syn_recv_sock;
+	subflow_specific.sk_rx_dst_set =3D subflow_finish_connect;
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	subflow_request_sock_ipv6_ops =3D tcp_request_sock_ipv6_ops;
+	subflow_request_sock_ipv6_ops.init_req =3D subflow_v6_init_req;
+
+	subflow_v6_specific =3D ipv6_specific;
+	subflow_v6_specific.conn_request =3D subflow_v6_conn_request;
+	subflow_v6_specific.syn_recv_sock =3D subflow_syn_recv_sock;
+	subflow_v6_specific.sk_rx_dst_set =3D subflow_finish_connect;
+
+	subflow_v6m_specific =3D subflow_v6_specific;
+	subflow_v6m_specific.queue_xmit =3D ipv4_specific.queue_xmit;
+	subflow_v6m_specific.send_check =3D ipv4_specific.send_check;
+	subflow_v6m_specific.net_header_len =3D ipv4_specific.net_header_len;
+	subflow_v6m_specific.mtu_reduced =3D ipv4_specific.mtu_reduced;
+	subflow_v6m_specific.net_frag_header_len =3D 0;
+#endif
+
 	if (tcp_register_ulp(&subflow_ulp_ops) !=3D 0)
 		panic("MPTCP: failed to register subflows to ULP\n");
 }
-- =

2.23.0

--===============2369887092053057887==--
