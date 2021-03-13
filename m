Content-Type: multipart/mixed; boundary="===============6895038232494123145=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 07/11] mptcp: remove multi addresses and
 subflows in PM
Date: Fri, 12 Mar 2021 17:16:17 -0800
Message-ID: <20210313011621.211661-8-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210313011621.211661-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8138

--===============6895038232494123145==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

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
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/pm_netlink.c | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 769a05d836da..a5f6ab96a1b4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1200,6 +1200,54 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb=
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
+		mptcp_pm_remove_addr(msk, &alist);
+		spin_unlock_bh(&msk->pm.lock);
+	}
+	if (slist.nr)
+		mptcp_pm_remove_subflow(msk, &slist);
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

2.30.2

--===============6895038232494123145==--
