Content-Type: multipart/mixed; boundary="===============0435323910321912528=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 5/5] mptcp: add remove subflow
 support
Date: Thu, 30 Jul 2020 19:06:03 +0800
Message-ID: <ed14dde1c2b56f772f7f4ecda9d30b5411fa6563.1596106606.git.geliangtang@gmail.com>
In-Reply-To: cover.1596106606.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5397

--===============0435323910321912528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new function mptcp_nl_remove_subflow to handle the
'MPTCP_PM_ADDR_FLAG_SUBFLOW' flag case. Do the local subflow removing
in this function.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b9f0622e4082..e1fcd0ff0624 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -304,7 +304,8 @@ void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *ms=
k)
 		int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
 		long timeout =3D 0;
 =

-		if (msk->pm.rm_id =3D=3D subflow->remote_id) {
+		if (msk->pm.rm_id =3D=3D subflow->remote_id ||
+		    msk->pm.rm_id =3D=3D subflow->local_id) {
 			spin_unlock_bh(&msk->pm.lock);
 			mptcp_subflow_shutdown(sk, ssk, how);
 			__mptcp_close_ssk(sk, ssk, subflow, timeout);
@@ -593,6 +594,29 @@ static void mptcp_nl_remove_addr(struct sk_buff *skb, =
struct mptcp_addr_info *ad
 	}
 }
 =

+static void mptcp_nl_remove_subflow(struct sk_buff *skb, struct mptcp_addr=
_info *addr)
+{
+	struct mptcp_sock *msk;
+	long s_slot =3D 0, s_num =3D 0;
+	struct net *net =3D sock_net(skb->sk);
+
+	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL) {
+		struct mptcp_subflow_context *subflow, *tmp;
+		struct sock *sk =3D (struct sock *)msk;
+
+		pr_debug("msk=3D%p\n", msk);
+		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+			struct mptcp_addr_info local;
+
+			local_address((struct sock_common *)ssk, &local);
+			if (addresses_equal(&local, addr, false))
+				mptcp_pm_rm_addr_received(msk, addr->id);
+		}
+		sock_put(sk);
+	}
+}
+
 static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *in=
fo)
 {
 	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
@@ -615,8 +639,10 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, =
struct genl_info *info)
 		pernet->add_addr_signal_max--;
 		mptcp_nl_remove_addr(skb, &entry->addr);
 	}
-	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
+	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
 		pernet->local_addr_max--;
+		mptcp_nl_remove_subflow(skb, &entry->addr);
+	}
 =

 	pernet->addrs--;
 	list_del_rcu(&entry->list);
-- =

2.17.1

--===============0435323910321912528==--
