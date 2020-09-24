Content-Type: multipart/mixed; boundary="===============3395813467611381983=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH net-next 03/16] mptcp: add the incoming RM_ADDR
 support
Date: Thu, 24 Sep 2020 08:29:49 +0800
Message-ID: <bf7aca2bee20de148728e30343734628aee6d779.1600853093.git.geliangtang@gmail.com>
In-Reply-To: cover.1600853093.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5999

--===============3395813467611381983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the RM_ADDR option parsing logic:

We parsed the incoming options to find if the rm_addr option is received,
and called mptcp_pm_rm_addr_received to schedule PM work to a new status,
named MPTCP_PM_RM_ADDR_RECEIVED.

PM work got this status, and called mptcp_pm_nl_rm_addr_received to handle
it.

In mptcp_pm_nl_rm_addr_received, we closed the subflow matching the rm_id,
and updated PM counter.

Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c    |  5 +++++
 net/mptcp/pm.c         | 12 ++++++++++++
 net/mptcp/pm_netlink.c | 34 ++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c   | 12 ++++++++----
 net/mptcp/protocol.h   |  7 +++++++
 5 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index bbc124876417..a52a05effac9 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -888,6 +888,11 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb,
 		mp_opt.add_addr =3D 0;
 	}
 =

+	if (mp_opt.rm_addr) {
+		mptcp_pm_rm_addr_received(msk, mp_opt.rm_id);
+		mp_opt.rm_addr =3D 0;
+	}
+
 	if (!mp_opt.dss)
 		return;
 =

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 81b07ae213b9..558462d87eb3 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -149,6 +149,18 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 	spin_unlock_bh(&pm->lock);
 }
 =

+void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id)
+{
+	struct mptcp_pm_data *pm =3D &msk->pm;
+
+	pr_debug("msk=3D%p remote_id=3D%d", msk, rm_id);
+
+	spin_lock_bh(&pm->lock);
+	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
+	pm->rm_id =3D rm_id;
+	spin_unlock_bh(&pm->lock);
+}
+
 /* path manager helpers */
 =

 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b4a9624d7bf2..4124bc581308 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -268,6 +268,40 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *=
msk)
 	spin_lock_bh(&msk->pm.lock);
 }
 =

+void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow, *tmp;
+	struct sock *sk =3D (struct sock *)msk;
+
+	pr_debug("address rm_id %d", msk->pm.rm_id);
+
+	if (!msk->pm.rm_id)
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
 static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 {
 	return (entry->addr.flags &
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 386cd4e60250..26b9233f247c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1652,9 +1652,9 @@ static struct sock *mptcp_subflow_get_retrans(const s=
truct mptcp_sock *msk)
  * so we need to use tcp_close() after detaching them from the mptcp
  * parent socket.
  */
-static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
-			      struct mptcp_subflow_context *subflow,
-			      long timeout)
+void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
+		       struct mptcp_subflow_context *subflow,
+		       long timeout)
 {
 	struct socket *sock =3D READ_ONCE(ssk->sk_socket);
 =

@@ -1685,6 +1685,10 @@ static void pm_work(struct mptcp_sock *msk)
 		pm->status &=3D ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
 		mptcp_pm_nl_add_addr_received(msk);
 	}
+	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
+		pm->status &=3D ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
+		mptcp_pm_nl_rm_addr_received(msk);
+	}
 	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
 		pm->status &=3D ~BIT(MPTCP_PM_ESTABLISHED);
 		mptcp_pm_nl_fully_established(msk);
@@ -1846,7 +1850,7 @@ static void mptcp_cancel_work(struct sock *sk)
 		sock_put(sk);
 }
 =

-static void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int =
how)
+void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 {
 	lock_sock(ssk);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8929b0c7660a..837e01057544 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -152,6 +152,7 @@ struct mptcp_addr_info {
 =

 enum mptcp_pm_status {
 	MPTCP_PM_ADD_ADDR_RECEIVED,
+	MPTCP_PM_RM_ADDR_RECEIVED,
 	MPTCP_PM_ESTABLISHED,
 	MPTCP_PM_SUBFLOW_ESTABLISHED,
 };
@@ -362,6 +363,10 @@ void mptcp_subflow_fully_established(struct mptcp_subf=
low_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
 void __init mptcp_subflow_init(void);
+void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how);
+void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
+		       struct mptcp_subflow_context *subflow,
+		       long timeout);
 =

 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info =
*loc,
@@ -434,6 +439,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *ms=
k,
 void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id);
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
+void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
 =

 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr);
@@ -468,6 +474,7 @@ void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
 void mptcp_pm_nl_fully_established(struct mptcp_sock *msk);
 void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk);
 void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk);
+void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *s=
kc);
 =

 static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
-- =

2.17.1

--===============3395813467611381983==--
