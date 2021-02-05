Content-Type: multipart/mixed; boundary="===============5636426884694797584=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 7/9] mptcp: remove multi
 addresses and subflows in PM
Date: Fri, 05 Feb 2021 22:24:31 +0800
Message-ID: <2e1e50023c1ca80e9737681fad83623f0be05a6f.1612534634.git.geliangtang@gmail.com>
In-Reply-To: 4150034f6f320da03b19c30b91798ad3fc3bb6ba.1612534634.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7644

--===============5636426884694797584==
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
or anno_list. If it is, put the address ID into the removing address ids
array, and pass the array to mptcp_pm_remove_addr or
mptcp_pm_remove_subflow.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b4d6f7b56a65..392aa4dc0834 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1213,6 +1213,58 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb=
, struct genl_info *info)
 	return ret;
 }
 =

+static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
+					       struct list_head *rm_list)
+{
+	struct mptcp_pm_addr_entry *entry;
+	u8 subflow_ids[MPTCP_RM_IDS_MAX];
+	u8 address_ids[MPTCP_RM_IDS_MAX];
+	int i =3D 0, j =3D 0;
+
+	memset(subflow_ids, MAX_ADDR_ID, MPTCP_RM_IDS_MAX);
+	memset(address_ids, MAX_ADDR_ID, MPTCP_RM_IDS_MAX);
+
+	list_for_each_entry(entry, rm_list, list) {
+		if (lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) && i < MPTCP_=
RM_IDS_MAX)
+			subflow_ids[i++] =3D entry->addr.id;
+		else if (remove_anno_list_by_saddr(msk, &entry->addr) && j < MPTCP_RM_ID=
S_MAX)
+			address_ids[j++] =3D entry->addr.id;
+	}
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

--===============5636426884694797584==--
