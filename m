Content-Type: multipart/mixed; boundary="===============0960949293699169133=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 5/7] mptcp: implement
 mptcp_nl_remove_addrs_and_subflows
Date: Mon, 01 Feb 2021 15:11:14 +0800
Message-ID: <648e271f1bb31eabc676c02c6be9e840e2bebca9.1612163150.git.geliangtang@gmail.com>
In-Reply-To: 2eddb38602dd1282e55242231795f1ebcbaa196f.1612163150.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7548

--===============0960949293699169133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch implemented the function to remove a list of addresses and
subflows, named mptcp_nl_remove_addrs_and_subflows, which had a input
parameter rm_ids as an ids array.

If the msk->conn_list is empty, only invoke mptcp_pm_remove_anno_addrs
to remove the announced addresses. If it's not empty, invoke
mptcp_pm_remove_anno_addrs_and_subflows to remove the announced
addresses and the subflows.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 89 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index dea5cf328ad4..b30e3dbf4287 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1198,6 +1198,95 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb=
, struct genl_info *info)
 	return ret;
 }
 =

+static void mptcp_pm_remove_anno_addrs(struct mptcp_sock *msk, u8 rm_ids[])
+{
+	u8 active_ids[MPTCP_RM_IDS_MAX] =3D { 0 }, i;
+	struct sock *sk =3D (struct sock *)msk;
+	struct net *net =3D sock_net(sk);
+	struct pm_nl_pernet *pernet;
+
+	pernet =3D net_generic(net, pm_nl_pernet_id);
+	spin_lock_bh(&pernet->lock);
+	for (i =3D 0; i < MPTCP_RM_IDS_MAX && rm_ids[i]; i++) {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry =3D __lookup_addr_by_id(pernet, rm_ids[i]);
+		if (entry && remove_anno_list_by_saddr(msk, &entry->addr))
+			active_ids[i] =3D rm_ids[i];
+	}
+	spin_unlock_bh(&pernet->lock);
+
+	if (!mptcp_get_rm_ids_nr(active_ids))
+		return;
+
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_remove_addr(msk, active_ids);
+	spin_unlock_bh(&msk->pm.lock);
+}
+
+static void mptcp_pm_remove_anno_addrs_and_subflows(struct mptcp_sock *msk=
, u8 local_ids[])
+{
+	u8 subflow_ids[MPTCP_RM_IDS_MAX] =3D { 0 };
+	u8 address_ids[MPTCP_RM_IDS_MAX] =3D { 0 };
+	struct sock *sk =3D (struct sock *)msk;
+	struct net *net =3D sock_net(sk);
+	struct pm_nl_pernet *pernet;
+	int i;
+
+	pernet =3D net_generic(net, pm_nl_pernet_id);
+	spin_lock_bh(&pernet->lock);
+	for (i =3D 0; i < MPTCP_RM_IDS_MAX && local_ids[i]; i++) {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry =3D __lookup_addr_by_id(pernet, local_ids[i]);
+		if (entry && lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
+			subflow_ids[i] =3D local_ids[i];
+		else if (entry && remove_anno_list_by_saddr(msk, &entry->addr))
+			address_ids[i] =3D local_ids[i];
+	}
+	spin_unlock_bh(&pernet->lock);
+
+	if (mptcp_get_rm_ids_nr(subflow_ids)) {
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_remove_addr(msk, subflow_ids);
+		spin_unlock_bh(&msk->pm.lock);
+		mptcp_pm_remove_subflow(msk, subflow_ids);
+	}
+	if (mptcp_get_rm_ids_nr(address_ids)) {
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_remove_addr(msk, address_ids);
+		spin_unlock_bh(&msk->pm.lock);
+	}
+}
+
+static void mptcp_nl_remove_addrs_and_subflows(struct net *net, u8 rm_ids[=
])
+{
+	long s_slot =3D 0, s_num =3D 0;
+	struct mptcp_sock *msk;
+
+	pr_debug("rm_ids_nr=3D%d", mptcp_get_rm_ids_nr(rm_ids));
+
+	if (!mptcp_get_rm_ids_nr(rm_ids))
+		return;
+
+	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL) {
+		struct sock *sk =3D (struct sock *)msk;
+
+		if (list_empty(&msk->conn_list)) {
+			mptcp_pm_remove_anno_addrs(msk, rm_ids);
+			goto next;
+		}
+
+		lock_sock(sk);
+		mptcp_pm_remove_anno_addrs_and_subflows(msk, rm_ids);
+		release_sock(sk);
+
+next:
+		sock_put(sk);
+		cond_resched();
+	}
+}
+
 static void __flush_addrs(struct net *net, struct list_head *list)
 {
 	while (!list_empty(list)) {
-- =

2.29.2

--===============0960949293699169133==--
