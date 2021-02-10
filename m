Content-Type: multipart/mixed; boundary="===============1629225384947179029=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v7 mptcp-next 07/11] mptcp: remove multi
 addresses and subflows in PM
Date: Wed, 10 Feb 2021 10:23:40 +0800
Message-ID: <940639199fdf057bd45cf29c816f8c8c04a3ee88.1612922705.git.geliangtang@gmail.com>
In-Reply-To: ac4e8b7ea73b35a09fbd9e7d80935d1dc27f223b.1612922705.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7737

--===============1629225384947179029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch implemented the function to remove a list of addresses and
subflows, named mptcp_nl_remove_addrs_list, which had a input parameter
rm_list as the removing addresses list.

In mptcp_nl_remove_addrs_list, traverse all the existing msk sockets to
invoke mptcp_pm_remove_addrs_and_subflows to remove a list of addresses
for each msk socket.

In mptcp_pm_remove_addrs_and_subflows, traverse all the addresses in the
removing addresses list, to find whether this address is in the conn_list
or anno_list. If it is, put the address ID into the removing address list
or the removing subflow list, and pass the two lists to
mptcp_pm_remove_addr and mptcp_pm_remove_subflow.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d5e69a99405b..21dd5eb36e9a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1199,6 +1199,54 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb=
, struct genl_info *info)
 	return ret;
 }
 =

+static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
+					       struct list_head *rm_list)
+{
+	struct mptcp_rm_list alist =3D { .nr =3D 0 }, slist =3D { .nr =3D 0 };
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, rm_list, list) {
+		if (lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) &&
+		    alist.nr < MPTCP_RM_IDS_MAX &&
+		    slist.nr < MPTCP_RM_IDS_MAX) {
+			alist.ids[alist.nr++] =3D entry->addr.id;
+			slist.ids[slist.nr++] =3D entry->addr.id;
+		} else if (remove_anno_list_by_saddr(msk, &entry->addr) &&
+			 alist.nr < MPTCP_RM_IDS_MAX) {
+			alist.ids[alist.nr++] =3D entry->addr.id;
+		}
+	}
+
+	if (alist.nr) {
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_remove_addr(msk, alist);
+		spin_unlock_bh(&msk->pm.lock);
+	}
+	if (slist.nr)
+		mptcp_pm_remove_subflow(msk, slist);
+}
+
+static void mptcp_nl_remove_addrs_list(struct net *net,
+				       struct list_head *rm_list)
+{
+	long s_slot =3D 0, s_num =3D 0;
+	struct mptcp_sock *msk;
+
+	if (list_empty(rm_list))
+		return;
+
+	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL) {
+		struct sock *sk =3D (struct sock *)msk;
+
+		lock_sock(sk);
+		mptcp_pm_remove_addrs_and_subflows(msk, rm_list);
+		release_sock(sk);
+
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

--===============1629225384947179029==--
