Content-Type: multipart/mixed; boundary="===============9214244337801455674=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v8 mptcp-next 1/8] mptcp: remove addr and
 subflow in PM netlink
Date: Mon, 24 Aug 2020 19:36:14 +0800
Message-ID: <07244be34e377ce229b93806c6cac4db9cfc8fda.1598267961.git.geliangtang@gmail.com>
In-Reply-To: cover.1598267961.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5606

--===============9214244337801455674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch implements the remove announced addr and subflow logic in PM
netlink.

When the PM netlink removes an address, we traverse all the existing msk
sockets to find the relevant sockets.

In the traversing, we check if this address is in conn_list. If it is,
we trigger the RM_ADDR signal to remove the remote subflow and remove the
local subflow which using this local address.

Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c         |  6 +++++-
 net/mptcp/pm_netlink.c | 39 +++++++++++++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 558462d87eb3..57227ab816fd 100644
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
index ad7232a1d9f1..0b1718921cc6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -552,6 +552,35 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsig=
ned int id)
 	return NULL;
 }
 =

+static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
+						   struct mptcp_addr_info *addr)
+{
+	struct mptcp_sock *msk;
+	long s_slot =3D 0, s_num =3D 0;
+
+	pr_debug("remove_id=3D%d\n", addr->id);
+
+	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL) {
+		struct sock *sk =3D (struct sock *)msk;
+
+		if (list_empty(&msk->conn_list))
+			goto next;
+
+		lock_sock(sk);
+		if (lookup_subflow_by_saddr(&msk->conn_list, addr)) {
+			mptcp_pm_remove_addr(msk, addr->id);
+			mptcp_pm_remove_subflow(msk, addr->id);
+		}
+		release_sock(sk);
+
+next:
+		sock_put(sk);
+		cond_resched();
+	}
+
+	return 0;
+}
+
 static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *in=
fo)
 {
 	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
@@ -567,8 +596,8 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, s=
truct genl_info *info)
 	entry =3D __lookup_addr_by_id(pernet, addr.addr.id);
 	if (!entry) {
 		GENL_SET_ERR_MSG(info, "address not found");
-		ret =3D -EINVAL;
-		goto out;
+		spin_unlock_bh(&pernet->lock);
+		return -EINVAL;
 	}
 	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)
 		pernet->add_addr_signal_max--;
@@ -577,9 +606,11 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, =
struct genl_info *info)
 =

 	pernet->addrs--;
 	list_del_rcu(&entry->list);
-	kfree_rcu(entry, rcu);
-out:
 	spin_unlock_bh(&pernet->lock);
+
+	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), &entry->addr);
+	kfree_rcu(entry, rcu);
+
 	return ret;
 }
 =

-- =

2.17.1

--===============9214244337801455674==--
