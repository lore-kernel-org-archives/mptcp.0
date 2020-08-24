Content-Type: multipart/mixed; boundary="===============2784639275299670784=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v8 mptcp-next 2/8] mptcp: fix
 mptcp_pm_nl_rm_addr_received logic issue
Date: Mon, 24 Aug 2020 19:36:15 +0800
Message-ID: <a7939301666d05ca0dcc47b7ab0262f6311aa933.1598267961.git.geliangtang@gmail.com>
In-Reply-To: cover.1598267961.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5607

--===============2784639275299670784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We want to use mptcp_pm_nl_rm_addr_received to deal with both removing
an address and removing a subflow. But it not work. Here is the problem:

Suppose there are three subflows,

    1 local_id=3D0 remote_id=3D0
    2 local_id=3D0 remote_id=3D1
    3 local_id=3D1 remote_id=3D0.

Here we want to remove the local subflow, the No.3 subflow, so we passed
msk->pm.rm_id=3D1 to mptcp_pm_nl_rm_addr_received.

According to this logic,

               if (msk->pm.rm_id !=3D subflow->remote_id &&
                   msk->pm.rm_id !=3D subflow->local_id)

We removed the wrong subflow, the No.2 subflow.

So we need to deal with removing an address and removing a subflow
separately. We check subflow->remote_id in mptcp_pm_nl_rm_addr_received to
remove an address and check subflow->local_id in
mptcp_pm_nl_rm_subflow_received to remove a subflow.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 43 +++++++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.h   |  1 +
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0b1718921cc6..b3771a188a4c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -271,23 +271,56 @@ void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *=
msk)
 	if (list_empty(&msk->conn_list))
 		return;
 =

-	msk->pm.add_addr_accepted--;
-	msk->pm.subflows--;
-	WRITE_ONCE(msk->pm.accept_addr, true);
+	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+		int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
+		long timeout =3D 0;
+
+		if (msk->pm.rm_id !=3D subflow->remote_id)
+			continue;
+
+		spin_unlock_bh(&msk->pm.lock);
+		mptcp_subflow_shutdown(sk, ssk, how);
+		__mptcp_close_ssk(sk, ssk, subflow, timeout);
+		spin_lock_bh(&msk->pm.lock);
+
+		msk->pm.add_addr_accepted--;
+		msk->pm.subflows--;
+		WRITE_ONCE(msk->pm.accept_addr, true);
+
+		break;
+	}
+}
+
+void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow, *tmp;
+	struct sock *sk =3D (struct sock *)msk;
+
+	pr_debug("rm_id %d", msk->pm.rm_id);
+
+	if (!msk->pm.rm_id)
+		return;
+
+	if (list_empty(&msk->conn_list))
+		return;
 =

 	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 		int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
 		long timeout =3D 0;
 =

-		if (msk->pm.rm_id !=3D subflow->remote_id &&
-		    msk->pm.rm_id !=3D subflow->local_id)
+		if (msk->pm.rm_id !=3D subflow->local_id)
 			continue;
 =

 		spin_unlock_bh(&msk->pm.lock);
 		mptcp_subflow_shutdown(sk, ssk, how);
 		__mptcp_close_ssk(sk, ssk, subflow, timeout);
 		spin_lock_bh(&msk->pm.lock);
+
+		msk->pm.local_addr_used--;
+		msk->pm.subflows--;
+
 		break;
 	}
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4b8a5308aeed..2849e1c8769b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -476,6 +476,7 @@ void mptcp_pm_nl_fully_established(struct mptcp_sock *m=
sk);
 void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk);
 void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk);
+void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *s=
kc);
 =

 static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
-- =

2.17.1

--===============2784639275299670784==--
