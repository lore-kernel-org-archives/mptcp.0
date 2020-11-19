Content-Type: multipart/mixed; boundary="===============8958292099145426144=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 03/10] mptcp: bind and listen for
 the new port
Date: Thu, 19 Nov 2020 18:19:43 +0800
Message-ID: <a9e55d526caf6feb5cc22892a42eee70caa9ec21.1605780306.git.geliangtang@gmail.com>
In-Reply-To: f16560fc78e2f308ac191511eb2d1b5478ef9f9a.1605780306.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6814

--===============8958292099145426144==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch called mptcp_pm_get_listen_socket to get the pernet listening
socket, and binded the new port to the socket, then listened for the
connection.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c |  3 +++
 net/mptcp/protocol.h   |  1 +
 net/mptcp/subflow.c    | 44 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 19d557df4684..1f9583e92d72 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -381,6 +381,9 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 			if (mptcp_pm_alloc_anno_list(msk, local)) {
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false, local->addr.port);
+				spin_unlock_bh(&msk->pm.lock);
+				mptcp_bind_and_listen_new_port(msk, local->addr.port);
+				spin_lock_bh(&msk->pm.lock);
 				mptcp_pm_nl_add_addr_send_ack(msk);
 			}
 		} else {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e713a6d00c77..d6ea2a6a7237 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -446,6 +446,7 @@ int __mptcp_subflow_connect(struct sock *sk, const stru=
ct mptcp_addr_info *loc,
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
 void subflow_drop_ctx(struct sock *ssk);
 int mptcp_create_listen_socket(struct sock *sk, struct socket **new_sock);
+void mptcp_bind_and_listen_new_port(struct mptcp_sock *msk, __be16 port);
 =

 static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
 					      struct mptcp_subflow_context *ctx)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 53e3b82b1ade..4a01b394ecf6 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1135,6 +1135,50 @@ int __mptcp_subflow_connect(struct sock *sk, const s=
truct mptcp_addr_info *loc,
 	return err;
 }
 =

+void mptcp_bind_and_listen_new_port(struct mptcp_sock *msk, __be16 port)
+{
+	struct sock *sk =3D (struct sock *)msk;
+	struct mptcp_addr_info local;
+	struct sockaddr_storage addr;
+	struct socket *listener;
+	int backlog =3D 20;
+	int addrlen;
+	int err;
+
+	if (!port)
+		return;
+
+	if (!mptcp_is_fully_established(sk))
+		return;
+
+	listener =3D mptcp_pm_get_listen_socket(msk);
+	if (!listener)
+		return;
+
+	memset(&local, 0, sizeof(local));
+	local.family =3D ((struct sock_common *)sk)->skc_family;
+	local.port =3D port;
+	mptcp_info2sockaddr(&local, &addr);
+	addrlen =3D sizeof(struct sockaddr_in);
+	err =3D kernel_bind(listener, (struct sockaddr *)&addr, addrlen);
+	if (err) {
+		pr_err("kernel bind error, err=3D%d", err);
+		goto err;
+	}
+
+	err =3D listener->ops->listen(listener, backlog);
+	if (err) {
+		pr_err("listen error, err=3D%d", err);
+		goto err;
+	}
+
+	pr_debug("bind_and_listen_new_port done");
+	return;
+
+err:
+	mptcp_pm_free_listen_socket(msk);
+}
+
 static void mptcp_attach_cgroup(struct sock *parent, struct sock *child)
 {
 #ifdef CONFIG_SOCK_CGROUP_DATA
-- =

2.26.2

--===============8958292099145426144==--
