Content-Type: multipart/mixed; boundary="===============2502680895012560558=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v9 mptcp-next 1/9] mptcp: create the listening
 socket for new port
Date: Tue, 05 Jan 2021 13:33:22 +0800
Message-ID: <e794c8c333d42607c740ed1a094528d7975dd755.1609820648.git.geliangtang@gmail.com>
In-Reply-To: cover.1609820648.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7257

--===============2502680895012560558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch created a listening socket when an address with a port-number
is added by PM netlink. Then binded the new port to the socket, and
listened for the connection.

When the address is removed or the addresses are flushed by PM netlink,
release the listening socket.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 96 +++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.c   |  2 +-
 net/mptcp/protocol.h   |  4 ++
 net/mptcp/subflow.c    |  6 +--
 4 files changed, 102 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7dd0dba770fe..d42c659c586a 100644
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
@@ -673,6 +674,53 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm=
_nl_pernet *pernet,
 	return ret;
 }
 =

+static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
+					    struct mptcp_pm_addr_entry *entry)
+{
+	struct sockaddr_storage addr;
+	struct mptcp_sock *msk;
+	struct socket *ssock;
+	int backlog =3D 1024;
+	int err;
+
+	err =3D sock_create_kern(sock_net(sk), entry->addr.family,
+			       SOCK_STREAM, IPPROTO_MPTCP, &entry->lsk);
+	if (err)
+		return err;
+
+	msk =3D mptcp_sk(entry->lsk->sk);
+	if (!msk) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	ssock =3D __mptcp_nmpc_socket(msk);
+	if (!ssock) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
+	err =3D kernel_bind(ssock, (struct sockaddr *)&addr,
+			  sizeof(struct sockaddr_in));
+	if (err) {
+		pr_warn("kernel_bind error, err=3D%d", err);
+		goto out;
+	}
+
+	err =3D kernel_listen(ssock, backlog);
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
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *s=
kc)
 {
 	struct mptcp_pm_addr_entry *entry;
@@ -717,6 +765,8 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, st=
ruct sock_common *skc)
 	entry->addr.ifindex =3D 0;
 	entry->addr.flags =3D 0;
 	entry->addr.id =3D 0;
+	entry->addr.port =3D 0;
+	entry->lsk =3D NULL;
 	ret =3D mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0)
 		kfree(entry);
@@ -886,9 +936,19 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, =
struct genl_info *info)
 	}
 =

 	*entry =3D addr;
+	if (entry->addr.port) {
+		ret =3D mptcp_pm_nl_create_listen_socket(skb->sk, entry);
+		if (ret) {
+			GENL_SET_ERR_MSG(info, "create listen socket error");
+			kfree(entry);
+			return ret;
+		}
+	}
 	ret =3D mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0) {
 		GENL_SET_ERR_MSG(info, "too many addresses or duplicate one");
+		if (entry->lsk)
+			sock_release(entry->lsk);
 		kfree(entry);
 		return ret;
 	}
@@ -972,6 +1032,38 @@ static int mptcp_nl_remove_subflow_and_signal_addr(st=
ruct net *net,
 	return 0;
 }
 =

+struct addr_entry_release_work {
+	struct rcu_work	rwork;
+	struct mptcp_pm_addr_entry *entry;
+};
+
+static void mptcp_pm_release_addr_entry(struct work_struct *work)
+{
+	struct addr_entry_release_work *w;
+	struct mptcp_pm_addr_entry *entry;
+
+	w =3D container_of(to_rcu_work(work), struct addr_entry_release_work, rwo=
rk);
+	entry =3D w->entry;
+	if (entry) {
+		if (entry->lsk)
+			sock_release(entry->lsk);
+		kfree(entry);
+	}
+	kfree(w);
+}
+
+static void mptcp_pm_free_addr_entry(struct mptcp_pm_addr_entry *entry)
+{
+	struct addr_entry_release_work *w;
+
+	w =3D kmalloc(sizeof(*w), GFP_ATOMIC);
+	if (w) {
+		INIT_RCU_WORK((struct rcu_work *)w, mptcp_pm_release_addr_entry);
+		w->entry =3D entry;
+		queue_rcu_work(system_wq, (struct rcu_work *)w);
+	}
+}
+
 static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *in=
fo)
 {
 	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
@@ -1001,7 +1093,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb,=
 struct genl_info *info)
 	spin_unlock_bh(&pernet->lock);
 =

 	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), &entry->addr);
-	kfree_rcu(entry, rcu);
+	mptcp_pm_free_addr_entry(entry);
 =

 	return ret;
 }
@@ -1015,7 +1107,7 @@ static void __flush_addrs(struct net *net, struct lis=
t_head *list)
 				 struct mptcp_pm_addr_entry, list);
 		mptcp_nl_remove_subflow_and_signal_addr(net, &cur->addr);
 		list_del_rcu(&cur->list);
-		kfree_rcu(cur, rcu);
+		mptcp_pm_free_addr_entry(cur);
 	}
 }
 =

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 49384c453950..b15ce0fd996a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -49,7 +49,7 @@ static void __mptcp_check_send_data_fin(struct sock *sk);
  * completed yet or has failed, return the subflow socket.
  * Otherwise return NULL.
  */
-static struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk)
+struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk)
 {
 	if (!msk->subflow || READ_ONCE(msk->can_ack))
 		return NULL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f6ed8dc0a073..7b4ba6597416 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -469,11 +469,15 @@ void mptcp_subflow_shutdown(struct sock *sk, struct s=
ock *ssk, int how);
 void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		       struct mptcp_subflow_context *subflow);
 void mptcp_subflow_reset(struct sock *ssk);
+struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
 =

 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info =
*loc,
 			    const struct mptcp_addr_info *remote);
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
+void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
+			 struct sockaddr_storage *addr,
+			 unsigned short family);
 =

 static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
 					      struct mptcp_subflow_context *ctx)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8dc4d9f86773..21d569054e01 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1073,9 +1073,9 @@ void mptcpv6_handle_mapped(struct sock *sk, bool mapp=
ed)
 }
 #endif
 =

-static void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
-				struct sockaddr_storage *addr,
-				unsigned short family)
+void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
+			 struct sockaddr_storage *addr,
+			 unsigned short family)
 {
 	memset(addr, 0, sizeof(*addr));
 	addr->ss_family =3D family;
-- =

2.29.2

--===============2502680895012560558==--
