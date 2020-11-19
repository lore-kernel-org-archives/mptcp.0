Content-Type: multipart/mixed; boundary="===============3056543715323879351=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 02/10] mptcp: add the pernet
 listening socket operations
Date: Thu, 19 Nov 2020 18:19:42 +0800
Message-ID: <f16560fc78e2f308ac191511eb2d1b5478ef9f9a.1605780306.git.geliangtang@gmail.com>
In-Reply-To: 50a92cac666f3359db3c5808690789527a385202.1605780306.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6813

--===============3056543715323879351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added three new pernet listening socket operations:

mptcp_pm_alloc_listen_socket, mptcp_pm_free_listen_socket and
mptcp_pm_get_listen_socket to alloc, free and get the pernet
listening socket.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 54 ++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c   |  5 ++++
 net/mptcp/protocol.h   |  5 ++++
 net/mptcp/subflow.c    |  2 +-
 4 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2560c502356b..19d557df4684 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -45,6 +45,8 @@ struct pm_nl_pernet {
 	unsigned int		add_addr_accept_max;
 	unsigned int		local_addr_max;
 	unsigned int		subflows_max;
+	struct socket		*listen_socket;
+	bool			sock_created;
 	unsigned int		next_id;
 };
 =

@@ -306,6 +308,56 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	}
 }
 =

+int mptcp_pm_alloc_listen_socket(struct mptcp_sock *msk)
+{
+	struct sock *sk =3D (struct sock *)msk;
+	struct pm_nl_pernet *pernet;
+	bool need_create =3D false;
+
+	pernet =3D net_generic(sock_net(sk), pm_nl_pernet_id);
+
+	spin_lock_bh(&pernet->lock);
+	if (!pernet->sock_created) {
+		pernet->sock_created =3D true;
+		need_create =3D true;
+	}
+	spin_unlock_bh(&pernet->lock);
+
+	if (!need_create)
+		return 0;
+
+	return mptcp_create_listen_socket(sk, &pernet->listen_socket);
+}
+
+void mptcp_pm_free_listen_socket(struct mptcp_sock *msk)
+{
+	struct sock *sk =3D (struct sock *)msk;
+	struct pm_nl_pernet *pernet;
+
+	pernet =3D net_generic(sock_net(sk), pm_nl_pernet_id);
+
+	if (!pernet || !pernet->listen_socket || !pernet->listen_socket->sk)
+		return;
+
+	subflow_drop_ctx(pernet->listen_socket->sk);
+	sock_release(pernet->listen_socket);
+	pernet->listen_socket =3D NULL;
+	pernet->sock_created =3D false;
+}
+
+struct socket *mptcp_pm_get_listen_socket(struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet;
+	struct sock *sk =3D (struct sock *)msk;
+
+	pernet =3D net_generic(sock_net(sk), pm_nl_pernet_id);
+
+	if (!pernet)
+		return NULL;
+
+	return pernet->listen_socket;
+}
+
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct mptcp_addr_info remote =3D { 0 };
@@ -885,6 +937,8 @@ static void __reset_counters(struct pm_nl_pernet *perne=
t)
 	pernet->add_addr_accept_max =3D 0;
 	pernet->local_addr_max =3D 0;
 	pernet->addrs =3D 0;
+	pernet->listen_socket =3D NULL;
+	pernet->sock_created =3D false;
 }
 =

 static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb, struct genl_info =
*info)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7a0364860feb..1a9e895e953e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2006,6 +2006,10 @@ static int mptcp_init_sock(struct sock *sk)
 	if (ret)
 		return ret;
 =

+	ret =3D mptcp_pm_alloc_listen_socket(mptcp_sk(sk));
+	if (ret)
+		return ret;
+
 	sk_sockets_allocated_inc(sk);
 	sk->sk_rcvbuf =3D sock_net(sk)->ipv4.sysctl_tcp_rmem[1];
 	sk->sk_sndbuf =3D sock_net(sk)->ipv4.sysctl_tcp_wmem[1];
@@ -2389,6 +2393,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
 {
 	skb_rbtree_purge(&msk->out_of_order_queue);
 	mptcp_token_destroy(msk);
+	mptcp_pm_free_listen_socket(msk);
 	mptcp_pm_free_anno_list(msk);
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7e40773f6b3d..e713a6d00c77 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -444,6 +444,7 @@ void mptcp_subflow_reset(struct sock *ssk);
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info =
*loc,
 			    const struct mptcp_addr_info *remote);
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
+void subflow_drop_ctx(struct sock *ssk);
 int mptcp_create_listen_socket(struct sock *sk, struct socket **new_sock);
 =

 static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
@@ -534,6 +535,10 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id);
 =

+int mptcp_pm_alloc_listen_socket(struct mptcp_sock *msk);
+void mptcp_pm_free_listen_socket(struct mptcp_sock *msk);
+struct socket *mptcp_pm_get_listen_socket(struct mptcp_sock *msk);
+
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_SIGNAL);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 86eaf4b76147..53e3b82b1ade 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -468,7 +468,7 @@ static void subflow_ulp_fallback(struct sock *sk,
 	tcp_sk(sk)->is_mptcp =3D 0;
 }
 =

-static void subflow_drop_ctx(struct sock *ssk)
+void subflow_drop_ctx(struct sock *ssk)
 {
 	struct mptcp_subflow_context *ctx =3D mptcp_subflow_ctx(ssk);
 =

-- =

2.26.2

--===============3056543715323879351==--
