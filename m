Content-Type: multipart/mixed; boundary="===============7042279298658794024=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v6 mptcp-next 3/5] mptcp: remove id 0 address
Date: Thu, 04 Mar 2021 17:33:34 +0800
Message-ID: <fc3f30d0aaf04464e764a2802e457b50fef0fb98.1614849685.git.geliangtang@gmail.com>
In-Reply-To: 0ecdb12a8f1ae31c1619b91deee561697e538872.1614849685.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8019

--===============7042279298658794024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new function mptcp_nl_remove_id_zero_address to
remove the id 0 address.

In this function, traverse all the existing msk sockets to find the
msk matched the input IP address. Then fill the removing list with
id 0, and pass it to mptcp_pm_remove_addr and mptcp_pm_remove_subflow.

Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2bd61d55186b..c73b7cfc7ae9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1164,6 +1164,39 @@ static void mptcp_pm_free_addr_entry(struct mptcp_pm=
_addr_entry *entry)
 	}
 }
 =

+static int mptcp_nl_remove_id_zero_address(struct net *net,
+					   struct mptcp_addr_info *addr)
+{
+	struct mptcp_sock *msk;
+	long s_slot =3D 0, s_num =3D 0;
+	struct mptcp_rm_list list =3D { .nr =3D 0 };
+
+	list.ids[list.nr++] =3D 0;
+
+	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL) {
+		struct sock *sk =3D (struct sock *)msk;
+		struct mptcp_addr_info msk_local;
+
+		if (list_empty(&msk->conn_list))
+			goto next;
+
+		local_address((struct sock_common *)msk, &msk_local);
+		if (!addresses_equal(&msk_local, addr, addr->port))
+			goto next;
+
+		lock_sock(sk);
+		mptcp_pm_remove_addr(msk, &list);
+		mptcp_pm_remove_subflow(msk, &list);
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
@@ -1176,6 +1209,14 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb=
, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 =

+	/* the zero id address is special: the first address used by the msk
+	 * always gets such an id, so different subflows can have different zero
+	 * id addresses. Additionally zero id is not accounted for in id_bitmap.
+	 * Let's use an 'mptcp_rm_list' instead of the common remove code.
+	 */
+	if (addr.addr.id =3D=3D 0)
+		return mptcp_nl_remove_id_zero_address(sock_net(skb->sk), &addr.addr);
+
 	spin_lock_bh(&pernet->lock);
 	entry =3D __lookup_addr_by_id(pernet, addr.addr.id);
 	if (!entry) {
-- =

2.29.2

--===============7042279298658794024==--
