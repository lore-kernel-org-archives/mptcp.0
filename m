Content-Type: multipart/mixed; boundary="===============2089463073570139425=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v6 mptcp-next 1/9] mptcp: create the listening
 socket for new port
Date: Wed, 25 Nov 2020 11:01:08 +0800
Message-ID: <74db8aa5673425f6c9cba9a1be138485b8eaa1c0.1606272852.git.geliangtang@gmail.com>
In-Reply-To: cover.1606272852.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6908

--===============2089463073570139425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch created a listening socket when a address with a port number
is added by PM netlink. Then binded the new port to the socket, and
listened for the connection.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 41 +++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h   |  2 ++
 net/mptcp/subflow.c    |  4 ++--
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2560c502356b..0d9a3c77fdf1 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -26,6 +26,7 @@ struct mptcp_pm_addr_entry {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
 	struct rcu_head		rcu;
+	struct socket		*lsk;
 };
 =

 struct mptcp_pm_add_entry {
@@ -732,6 +733,43 @@ static struct pm_nl_pernet *genl_info_pm_nl(struct gen=
l_info *info)
 	return net_generic(genl_info_net(info), pm_nl_pernet_id);
 }
 =

+static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
+					    struct mptcp_pm_addr_entry *entry)
+{
+	struct sockaddr_storage addr;
+	int backlog =3D 20;
+	int err;
+
+	err =3D sock_create_kern(sock_net(sk), entry->addr.family,
+			       SOCK_STREAM, IPPROTO_TCP,
+			       &entry->lsk);
+	if (err)
+		return err;
+
+	SOCK_INODE(entry->lsk)->i_uid =3D GLOBAL_ROOT_UID;
+	SOCK_INODE(entry->lsk)->i_gid =3D GLOBAL_ROOT_GID;
+
+	mptcp_info2sockaddr(&entry->addr, &addr);
+	err =3D kernel_bind(entry->lsk, (struct sockaddr *)&addr,
+			  sizeof(struct sockaddr_in));
+	if (err) {
+		pr_warn("kernel_bind error, err=3D%d", err);
+		goto out;
+	}
+
+	err =3D kernel_listen(entry->lsk, backlog);
+	if (err) {
+		pr_warn("kernel_listen error, err=3D%d", err);
+		goto out;
+	}
+
+	return 0;
+
+out:
+	sock_release(entry->lsk);
+	return err;
+}
+
 static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *in=
fo)
 {
 	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
@@ -757,6 +795,9 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, s=
truct genl_info *info)
 		return ret;
 	}
 =

+	if (entry->addr.port)
+		mptcp_pm_nl_create_listen_socket(skb->sk, entry);
+
 	return 0;
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f5db6e721fcf..f202e22058b5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -467,6 +467,8 @@ void mptcp_subflow_reset(struct sock *ssk);
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info =
*loc,
 			    const struct mptcp_addr_info *remote);
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
+void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
+			 struct sockaddr_storage *addr);
 =

 static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
 					      struct mptcp_subflow_context *ctx)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b6cd42649e5d..d4c136f1e754 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1031,8 +1031,8 @@ void mptcpv6_handle_mapped(struct sock *sk, bool mapp=
ed)
 }
 #endif
 =

-static void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
-				struct sockaddr_storage *addr)
+void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
+			 struct sockaddr_storage *addr)
 {
 	memset(addr, 0, sizeof(*addr));
 	addr->ss_family =3D info->family;
-- =

2.26.2

--===============2089463073570139425==--
