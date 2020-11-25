Content-Type: multipart/mixed; boundary="===============6552185830551595533=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v6 mptcp-next 2/9] mptcp: set the listening
 socket's subflow
Date: Wed, 25 Nov 2020 11:01:09 +0800
Message-ID: <a9094a27297f9782b7bf8063e9f41a0eb3a81871.1606272852.git.geliangtang@gmail.com>
In-Reply-To: 74db8aa5673425f6c9cba9a1be138485b8eaa1c0.1606272852.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6909

--===============6552185830551595533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch set the subflow context of the listening socket.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c |  5 +++++
 net/mptcp/protocol.h   |  1 +
 net/mptcp/subflow.c    | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0d9a3c77fdf1..39a91fcac403 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -330,6 +330,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(str=
uct mptcp_sock *msk)
 			if (mptcp_pm_alloc_anno_list(msk, local)) {
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false, local->addr.port);
+				if (local->addr.port) {
+					spin_unlock_bh(&msk->pm.lock);
+					mptcp_pm_set_listen_socket_subflow(sk, local->lsk);
+					spin_lock_bh(&msk->pm.lock);
+				}
 				mptcp_pm_nl_add_addr_send_ack(msk);
 			}
 		} else {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f202e22058b5..38001b7b0bf6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -469,6 +469,7 @@ int __mptcp_subflow_connect(struct sock *sk, const stru=
ct mptcp_addr_info *loc,
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
 void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 			 struct sockaddr_storage *addr);
+int mptcp_pm_set_listen_socket_subflow(struct sock *sk, struct socket *sf);
 =

 static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
 					      struct mptcp_subflow_context *ctx)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d4c136f1e754..6053a88c176f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1208,6 +1208,43 @@ int mptcp_subflow_create_socket(struct sock *sk, str=
uct socket **new_sock)
 	return 0;
 }
 =

+int mptcp_pm_set_listen_socket_subflow(struct sock *sk, struct socket *sf)
+{
+	struct mptcp_subflow_context *subflow;
+	struct net *net =3D sock_net(sk);
+	int err;
+
+	if (!sf)
+		return -EINVAL;
+
+	lock_sock(sf->sk);
+
+	mptcp_attach_cgroup(sk, sf->sk);
+
+	sf->sk->sk_net_refcnt =3D 1;
+	get_net(net);
+#ifdef CONFIG_PROC_FS
+	this_cpu_add(*net->core.sock_inuse, 1);
+#endif
+	err =3D tcp_set_ulp(sf->sk, "mptcp");
+	release_sock(sf->sk);
+
+	if (err) {
+		sock_release(sf);
+		return err;
+	}
+
+	subflow =3D mptcp_subflow_ctx(sf->sk);
+	pr_debug("subflow=3D%p", subflow);
+
+	sock_hold(sk);
+
+	subflow->conn =3D sk;
+	subflow->request_mptcp =3D 1;
+
+	return 0;
+}
+
 static struct mptcp_subflow_context *subflow_create_ctx(struct sock *sk,
 							gfp_t priority)
 {
-- =

2.26.2

--===============6552185830551595533==--
