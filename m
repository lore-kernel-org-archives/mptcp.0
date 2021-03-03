Content-Type: multipart/mixed; boundary="===============3297260269223349620=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 3/4] mptcp: remove id zero address
Date: Wed, 03 Mar 2021 15:49:00 +0800
Message-ID: <2f7b60511c7ebe1d7001d5be2dbf897194cc8e77.1614757087.git.geliangtang@gmail.com>
In-Reply-To: 06d4bf11abca96d8b060d8ffec7923c54ece2654.1614757087.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7988

--===============3297260269223349620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new function mptcp_nl_remove_id_zero_address to
remove the id 0 address.

In this function, fill the remove list with the id 0, and pass it to
mptcp_pm_remove_addr and mptcp_pm_remove_subflow.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 419b643bd6fe..eeef36663679 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1171,6 +1171,33 @@ static void mptcp_pm_free_addr_entry(struct mptcp_pm=
_addr_entry *entry)
 	}
 }
 =

+static int mptcp_nl_remove_id_zero_address(struct net *net)
+{
+	struct mptcp_sock *msk;
+	long s_slot =3D 0, s_num =3D 0;
+	struct mptcp_rm_list list =3D { .nr =3D 0 };
+
+	list.ids[list.nr++] =3D 0;
+
+	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL) {
+		struct sock *sk =3D (struct sock *)msk;
+
+		if (list_empty(&msk->conn_list))
+			goto next;
+
+		lock_sock(sk);
+		mptcp_pm_remove_addr(msk, list);
+		mptcp_pm_remove_subflow(msk, list);
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
@@ -1183,6 +1210,9 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb,=
 struct genl_info *info)
 	if (ret < 0)
 		return ret;
 =

+	if (!addr.addr.id)
+		return mptcp_nl_remove_id_zero_address(sock_net(skb->sk));
+
 	spin_lock_bh(&pernet->lock);
 	entry =3D __lookup_addr_by_id(pernet, addr.addr.id);
 	if (!entry) {
-- =

2.29.2

--===============3297260269223349620==--
