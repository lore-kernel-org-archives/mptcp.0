Content-Type: multipart/mixed; boundary="===============6607819360389935434=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH net-next 09/16] mptcp: implement
 mptcp_pm_remove_subflow
Date: Thu, 24 Sep 2020 08:29:55 +0800
Message-ID: <5018fd495529e058ea866e8d8edbe0bb98ec733a.1600853093.git.geliangtang@gmail.com>
In-Reply-To: cover.1600853093.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6005

--===============6607819360389935434==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch implemented the local subflow removing function,
mptcp_pm_remove_subflow, it simply called mptcp_pm_nl_rm_subflow_received
under the PM spin lock.

We use mptcp_pm_remove_subflow to remove a local subflow, so change it's
argument from remote_id to local_id.

We check subflow->local_id in mptcp_pm_nl_rm_subflow_received to remove
a subflow.

Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c         |  9 +++++++--
 net/mptcp/pm_netlink.c | 33 +++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h   |  3 ++-
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f450bf0d49aa..7e81f53d1e5d 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -33,9 +33,14 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 loca=
l_id)
 	return 0;
 }
 =

-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 remote_id)
+int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id)
 {
-	return -ENOTSUPP;
+	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
+
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_nl_rm_subflow_received(msk, local_id);
+	spin_unlock_bh(&msk->pm.lock);
+	return 0;
 }
 =

 /* path manager event handlers */
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 97f9280f83fb..9064c8098521 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -350,6 +350,39 @@ void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *m=
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
index d1b1416797f8..df6cc94df1f7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -448,7 +448,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id);
-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 remote_id);
+int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id);
 =

 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
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

--===============6607819360389935434==--
