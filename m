Content-Type: multipart/mixed; boundary="===============1214375051407057918=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH] Squash-to: "mptcp: implement
 mptcp_pm_remove_subflow v9"
Date: Tue, 08 Sep 2020 14:32:31 +0800
Message-ID: <5624c8ee7e6db4c20fa7f0593d2e6cc9be36ca32.1599546158.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5757

--===============1214375051407057918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit message should be rewritten enterily:
'''
This patch implemented the local subflow removing function,
mptcp_pm_remove_subflow, it simply called mptcp_pm_nl_rm_subflow_received
under the PM spin lock.

We use mptcp_pm_remove_subflow to remove a local subflow, so change it's
argument from remote_id to local_id.

We check subflow->local_id in mptcp_pm_nl_rm_subflow_received to remove
a subflow.
'''

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 33 +++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h   |  1 +
 2 files changed, 34 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0dae12862931..c7a7e70ba1cd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -339,6 +339,39 @@ void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *m=
sk)
 	}
 }
 =

+void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id)
+{
+	struct mptcp_subflow_context *subflow, *tmp;
+	struct sock *sk =3D (struct sock *)msk;
+
+	pr_debug("subflow rm_id %d", rm_id);
+
+	if (!rm_id)
+		return;
+
+	if (list_empty(&msk->conn_list))
+		return;
+
+	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+		int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
+		long timeout =3D 0;
+
+		if (rm_id !=3D subflow->local_id)
+			continue;
+
+		spin_unlock_bh(&msk->pm.lock);
+		mptcp_subflow_shutdown(sk, ssk, how);
+		__mptcp_close_ssk(sk, ssk, subflow, timeout);
+		spin_lock_bh(&msk->pm.lock);
+
+		msk->pm.local_addr_used--;
+		msk->pm.subflows--;
+
+		break;
+	}
+}
+
 static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 {
 	return (entry->addr.flags &
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 91a68d7e672a..df6cc94df1f7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -479,6 +479,7 @@ void mptcp_pm_nl_fully_established(struct mptcp_sock *m=
sk);
 void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk);
 void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk);
+void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *s=
kc);
 =

 static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
-- =

2.17.1

--===============1214375051407057918==--
