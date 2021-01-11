Content-Type: multipart/mixed; boundary="===============5564727108446302011=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 1/2] mptcp: implement deferred action
 infrastructure
Date: Mon, 11 Jan 2021 23:43:25 +0100
Message-ID: <06d7dd5b5a2a5da7507bcd54d61f6b06a2ee919c.1610404441.git.pabeni@redhat.com>
In-Reply-To: cover.1610404441.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7313

--===============5564727108446302011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On MPTCP-level ack reception, the packet scheduler
may select a subflow other then the current one.

Prior to this commit we rely on the workqueue to trigger
action on such subflow.

This changeset introduce an infrastructure that allows
any MPTCP subflow to schedule actions (MPTCP xmit) on
others subflows without resorting to (multiple) process
reschedule.

A dummy NAPI instance is used instead. When MPTCP needs to
trigger action an a different subflow, it enqueues the target
subflow on the NAPI backlog and schedule such instance as needed.

The dummy NAPI poll method walk the sockets backlog and try
to acquire the (BH) socket lock on each of them. If the socket
is owned by the user space, the action will be completed by
the sock release cb, otherwise push is started.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
help with the commit prose to make this change
more upstream-palatable more then welcome! ;)
---
 net/mptcp/protocol.c | 86 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h | 52 +++++++++++++++++++++++++++
 net/mptcp/subflow.c  |  2 ++
 3 files changed, 140 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0791421a971f..3d5ac817b2fb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2959,6 +2959,30 @@ static void mptcp_release_cb(struct sock *sk)
 	}
 }
 =

+static void mptcp_subflow_process_deferred(struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	struct sock *sk =3D subflow->conn;
+
+	mptcp_data_lock(sk);
+	if (!sock_owned_by_user(sk))
+		__mptcp_subflow_push_pending(sk, ssk);
+	else
+		set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags);
+	mptcp_data_unlock(sk);
+	mptcp_subflow_deferred_done(subflow);
+}
+
+static void tcp_release_cb_override(struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+
+	if (mptcp_subflow_has_deferred_action(subflow))
+		mptcp_subflow_process_deferred(ssk);
+
+	tcp_release_cb(ssk);
+}
+
 static int mptcp_hash(struct sock *sk)
 {
 	/* should never be called,
@@ -3111,6 +3135,8 @@ static struct proto mptcp_prot =3D {
 	.no_autobind	=3D true,
 };
 =

+static struct proto tcp_prot_override;
+
 static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int add=
r_len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
@@ -3265,6 +3291,7 @@ static int mptcp_stream_accept(struct socket *sock, s=
truct socket *newsock,
 		mptcp_copy_inaddrs(newsk, msk->first);
 		mptcp_rcv_space_init(msk, msk->first);
 		mptcp_propagate_sndbuf(newsk, msk->first);
+		mptcp_subflow_ops_override(msk->first);
 =

 		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
 		 * This is needed so NOSPACE flag can be set from tcp stack.
@@ -3375,13 +3402,58 @@ static struct inet_protosw mptcp_protosw =3D {
 #define MPTCP_USE_SLAB		1
 #endif
 =

+DEFINE_PER_CPU(struct mptcp_deferred_action, mptcp_deferred_actions);
+
+static int mptcp_napi_poll(struct napi_struct *napi, int budget)
+{
+	struct mptcp_deferred_action *deferred;
+	struct mptcp_subflow_context *subflow;
+	int work_done =3D 0;
+
+	deferred =3D container_of(napi, struct mptcp_deferred_action, napi);
+	while ((subflow =3D mptcp_subflow_deferred_next(deferred)) !=3D NULL) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+		bh_lock_sock_nested(ssk);
+		if (!sock_owned_by_user(ssk))
+			mptcp_subflow_process_deferred(ssk);
+
+		/* if the sock is locked the deferred status will be cleared
+		 * by tcp_release_cb_override
+		 */
+		bh_unlock_sock(ssk);
+
+		if (++work_done =3D=3D budget)
+			return budget;
+	}
+
+	/* always provide a 0 'work_done' argument, so that napi_complete_done
+	 * will not try accessing the NULL napi->dev ptr
+	 */
+	napi_complete_done(napi, 0);
+	return work_done;
+}
+
 void __init mptcp_proto_init(void)
 {
+	int cpu;
+
 	mptcp_prot.h.hashinfo =3D tcp_prot.h.hashinfo;
 =

 	if (percpu_counter_init(&mptcp_sockets_allocated, 0, GFP_KERNEL))
 		panic("Failed to allocate MPTCP pcpu counter\n");
 =

+	for_each_possible_cpu(cpu) {
+		struct mptcp_deferred_action *deferred =3D per_cpu_ptr(&mptcp_deferred_a=
ctions, cpu);
+
+		INIT_LIST_HEAD(&deferred->head);
+		netif_tx_napi_add(init_net.loopback_dev, &deferred->napi, mptcp_napi_pol=
l,
+				  NAPI_POLL_WEIGHT);
+		napi_enable(&deferred->napi);
+	}
+
+	tcp_prot_override =3D tcp_prot;
+	tcp_prot_override.release_cb =3D tcp_release_cb_override;
 	mptcp_subflow_init();
 	mptcp_pm_init();
 	mptcp_token_init();
@@ -3420,6 +3492,7 @@ static const struct proto_ops mptcp_v6_stream_ops =3D=
 {
 #endif
 };
 =

+static struct proto tcpv6_prot_override;
 static struct proto mptcp_v6_prot;
 =

 static void mptcp_v6_destroy(struct sock *sk)
@@ -3446,6 +3519,9 @@ int __init mptcp_proto_v6_init(void)
 	mptcp_v6_prot.destroy =3D mptcp_v6_destroy;
 	mptcp_v6_prot.obj_size =3D sizeof(struct mptcp6_sock);
 =

+	tcpv6_prot_override =3D tcpv6_prot;
+	tcpv6_prot_override.release_cb =3D tcp_release_cb_override;
+
 	err =3D proto_register(&mptcp_v6_prot, MPTCP_USE_SLAB);
 	if (err)
 		return err;
@@ -3457,3 +3533,13 @@ int __init mptcp_proto_v6_init(void)
 	return err;
 }
 #endif
+
+void mptcp_subflow_ops_override(struct sock *ssk)
+{
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (ssk->sk_prot =3D=3D &tcpv6_prot)
+		ssk->sk_prot =3D &tcpv6_prot_override;
+	else
+#endif
+		ssk->sk_prot =3D &tcp_prot_override;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index adc56bcbdf68..702f0e137d8a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -379,6 +379,13 @@ enum mptcp_data_avail {
 	MPTCP_SUBFLOW_OOO_DATA
 };
 =

+struct mptcp_deferred_action {
+	struct napi_struct napi;
+	struct list_head head;
+};
+
+DECLARE_PER_CPU(struct mptcp_deferred_action, mptcp_deferred_actions);
+
 /* MPTCP subflow context */
 struct mptcp_subflow_context {
 	struct	list_head node;/* conn_list of subflows */
@@ -416,6 +423,9 @@ struct mptcp_subflow_context {
 	u8	local_id;
 	u8	remote_id;
 =

+	long	deferred_status;
+	struct	list_head deferred_node;
+
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 	struct	sock *conn;	    /* parent mptcp_sock */
 	const	struct inet_connection_sock_af_ops *icsk_af_ops;
@@ -464,6 +474,48 @@ static inline void mptcp_add_pending_subflow(struct mp=
tcp_sock *msk,
 	spin_unlock_bh(&msk->join_list_lock);
 }
 =

+void mptcp_subflow_ops_override(struct sock *ssk);
+
+static inline void mptcp_subflow_defer(struct mptcp_subflow_context *subfl=
ow)
+{
+	struct mptcp_deferred_action *deferred;
+	bool schedule;
+
+	if (!test_and_set_bit(1, &subflow->deferred_status)) {
+		local_bh_disable();
+		deferred =3D this_cpu_ptr(&mptcp_deferred_actions);
+		schedule =3D list_empty(&deferred->head);
+		list_add_tail(&subflow->deferred_node, &deferred->head);
+		if (schedule)
+			napi_schedule(&deferred->napi);
+		local_bh_enable();
+	}
+}
+
+static inline struct mptcp_subflow_context *
+mptcp_subflow_deferred_next(struct mptcp_deferred_action *deferred)
+{
+	struct mptcp_subflow_context *ret;
+
+	if (list_empty(&deferred->head))
+		return NULL;
+
+	ret =3D list_first_entry(&deferred->head, struct mptcp_subflow_context, d=
eferred_node);
+	list_del_init(&ret->deferred_node);
+	return ret;
+}
+
+static inline bool mptcp_subflow_has_deferred_action(const struct mptcp_su=
bflow_context *subflow)
+{
+	return !test_bit(1, &subflow->deferred_status);
+}
+
+static inline void mptcp_subflow_deferred_done(struct mptcp_subflow_contex=
t *subflow)
+{
+	clear_bit(1, &subflow->deferred_status);
+	list_del_init(&subflow->deferred_node);
+}
+
 int mptcp_is_enabled(struct net *net);
 unsigned int mptcp_get_add_addr_timeout(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 31cc362a4638..1e22f0dca5e6 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1261,6 +1261,7 @@ int mptcp_subflow_create_socket(struct sock *sk, stru=
ct socket **new_sock)
 	*new_sock =3D sf;
 	sock_hold(sk);
 	subflow->conn =3D sk;
+	mptcp_subflow_ops_override(sf->sk);
 =

 	return 0;
 }
@@ -1277,6 +1278,7 @@ static struct mptcp_subflow_context *subflow_create_c=
tx(struct sock *sk,
 =

 	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
 	INIT_LIST_HEAD(&ctx->node);
+	INIT_LIST_HEAD(&ctx->deferred_node);
 =

 	pr_debug("subflow=3D%p", ctx);
 =

-- =

2.26.2

--===============5564727108446302011==--
