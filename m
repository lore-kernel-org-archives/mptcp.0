Content-Type: multipart/mixed; boundary="===============6188427006383971840=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 3/8] mptcp: add removing multi addrs
 support in PM
Date: Fri, 29 Jan 2021 18:26:47 +0800
Message-ID: <349ecc242d794e1c9bdfc65f958caeab33af238c.1611914854.git.geliangtang@gmail.com>
In-Reply-To: 24bcce4d373eea4ca0a1071e92132fd6103ed2c6.1611914854.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7526

--===============6188427006383971840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changed the type of rm_id in struct mptcp_pm_data from u8 to
u64, and renamed it to rm_ids. Every place where pm.rm_id was used had
been modified too.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c         | 12 ++++++------
 net/mptcp/pm_netlink.c |  6 +++---
 net/mptcp/protocol.h   |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 1c10011e5abf..117ba05f60c0 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -39,18 +39,18 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 	return 0;
 }
 =

-int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id)
+int mptcp_pm_remove_addr(struct mptcp_sock *msk, u64 local_ids)
 {
 	u8 rm_addr =3D READ_ONCE(msk->pm.addr_signal);
 =

-	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
+	pr_debug("msk=3D%p, local_ids=3D%llu", msk, local_ids);
 =

 	if (rm_addr) {
 		pr_warn("addr_signal error, rm_addr=3D%d", rm_addr);
 		return -EINVAL;
 	}
 =

-	msk->pm.rm_id =3D local_id;
+	msk->pm.rm_ids =3D local_ids;
 	rm_addr |=3D BIT(MPTCP_RM_ADDR_SIGNAL);
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
 	return 0;
@@ -215,7 +215,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, =
u64 rm_ids)
 =

 	spin_lock_bh(&pm->lock);
 	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
-	pm->rm_id =3D rm_ids;
+	pm->rm_ids =3D rm_ids;
 	spin_unlock_bh(&pm->lock);
 }
 =

@@ -271,7 +271,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, un=
signed int remaining,
 	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
 		goto out_unlock;
 =

-	*rm_ids =3D msk->pm.rm_id;
+	*rm_ids =3D msk->pm.rm_ids;
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	ret =3D true;
 =

@@ -291,7 +291,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.add_addr_accepted =3D 0;
 	msk->pm.local_addr_used =3D 0;
 	msk->pm.subflows =3D 0;
-	msk->pm.rm_id =3D 0;
+	msk->pm.rm_ids =3D 0;
 	WRITE_ONCE(msk->pm.work_pending, false);
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	WRITE_ONCE(msk->pm.accept_addr, false);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f2a6e77c1dec..aa0c471b82c4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -575,11 +575,11 @@ static void mptcp_pm_nl_rm_addr_received(struct mptcp=
_sock *msk)
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk =3D (struct sock *)msk;
 =

-	pr_debug("address rm_id %d", msk->pm.rm_id);
+	pr_debug("address rm_ids %llu", msk->pm.rm_ids);
 =

 	msk_owned_by_me(msk);
 =

-	if (!msk->pm.rm_id)
+	if (!msk->pm.rm_ids)
 		return;
 =

 	if (list_empty(&msk->conn_list))
@@ -589,7 +589,7 @@ static void mptcp_pm_nl_rm_addr_received(struct mptcp_s=
ock *msk)
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 		int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
 =

-		if (msk->pm.rm_id !=3D subflow->remote_id)
+		if (msk->pm.rm_ids !=3D subflow->remote_id)
 			continue;
 =

 		spin_unlock_bh(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index dd6899ab1f19..c5a3950a25e3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -204,7 +204,7 @@ struct mptcp_pm_data {
 	u8		local_addr_used;
 	u8		subflows;
 	u8		status;
-	u8		rm_id;
+	u64		rm_ids;
 };
 =

 struct mptcp_data_frag {
@@ -668,7 +668,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo, bool port);
-int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id);
+int mptcp_pm_remove_addr(struct mptcp_sock *msk, u64 local_ids);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id);
 =

 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
-- =

2.29.2

--===============6188427006383971840==--
