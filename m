Content-Type: multipart/mixed; boundary="===============7291968747665963058=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 4/4] mptcp: trigger the RM_ADDR
 signal
Date: Wed, 22 Jul 2020 16:42:31 +0800
Message-ID: <c794e8ba159e98f1a22d279a05cc913a7b5f803b.1595407078.git.geliangtang@gmail.com>
In-Reply-To: cover.1595407078.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5173

--===============7291968747665963058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Trigger the RM_ADDR signal when the PM netlink removes an address.

Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c         |  6 +++++-
 net/mptcp/pm_netlink.c | 32 +++++++++++++++++++++++++++++++-
 net/mptcp/protocol.c   |  1 +
 net/mptcp/protocol.h   |  1 +
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 84fad1fec28b..4194fd2591c5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -24,7 +24,11 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 =

 int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id)
 {
-	return -ENOTSUPP;
+	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
+
+	msk->pm.rm_id =3D local_id;
+	WRITE_ONCE(msk->pm.rm_addr_signal, true);
+	return 0;
 }
 =

 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 remote_id)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2ee7227f5f2b..646398f16ce8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -23,6 +23,7 @@ static int pm_nl_pernet_id;
 =

 struct mptcp_pm_addr_entry {
 	struct list_head	list;
+	struct list_head	alist;
 	unsigned int		flags;
 	int			ifindex;
 	struct mptcp_addr_info	addr;
@@ -169,6 +170,13 @@ static void check_work_pending(struct mptcp_sock *msk)
 		WRITE_ONCE(msk->pm.work_pending, false);
 }
 =

+static int mptcp_pm_add_announce_list(struct mptcp_sock *msk,
+				      struct mptcp_pm_addr_entry *entry)
+{
+	list_add(&entry->alist, &msk->anno_list);
+	return 0;
+}
+
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct sock *sk =3D (struct sock *)msk;
@@ -191,6 +199,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 		if (local) {
 			msk->pm.add_addr_signaled++;
 			mptcp_pm_announce_addr(msk, &local->addr);
+			mptcp_pm_add_announce_list(msk, local);
 		} else {
 			/* pick failed, avoid fourther attempts later */
 			msk->pm.local_addr_used =3D msk->pm.add_addr_signal_max;
@@ -537,6 +546,25 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsig=
ned int id)
 	return NULL;
 }
 =

+static void mptcp_nl_remove_addr(struct sk_buff *skb, struct mptcp_addr_in=
fo *addr)
+{
+	struct mptcp_sock *msk;
+	long s_slot =3D 0, s_num =3D 0;
+	struct net *net =3D sock_net(skb->sk);
+
+	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL) {
+		struct mptcp_pm_addr_entry *entry, *tmp;
+
+		pr_debug("msk=3D%p\n", msk);
+		list_for_each_entry_safe(entry, tmp, &msk->anno_list, alist) {
+			if (addresses_equal(&entry->addr, addr, false)) {
+				mptcp_pm_remove_addr(msk, addr->id);
+				list_del(&entry->alist);
+			}
+		}
+	}
+}
+
 static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *in=
fo)
 {
 	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
@@ -555,8 +583,10 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, =
struct genl_info *info)
 		ret =3D -EINVAL;
 		goto out;
 	}
-	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)
+	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
 		pernet->add_addr_signal_max--;
+		mptcp_nl_remove_addr(skb, &entry->addr);
+	}
 	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
 		pernet->local_addr_max--;
 =

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fcd16e815aa5..277c5893b4aa 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1325,6 +1325,7 @@ static int __mptcp_init_sock(struct sock *sk)
 =

 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->join_list);
+	INIT_LIST_HEAD(&msk->anno_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
 	__set_bit(MPTCP_SEND_SPACE, &msk->flags);
 	INIT_WORK(&msk->work, mptcp_worker);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fb09b6fb854e..821ac3de0779 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -206,6 +206,7 @@ struct mptcp_sock {
 	struct list_head conn_list;
 	struct list_head rtx_queue;
 	struct list_head join_list;
+	struct list_head anno_list;
 	struct skb_ext	*cached_ext;	/* for the next sendmsg */
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct sock	*first;
-- =

2.17.1

--===============7291968747665963058==--
