Content-Type: multipart/mixed; boundary="===============6519354265901030916=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 3/7] mptcp: remove multi
 addresses in PM
Date: Mon, 01 Feb 2021 15:11:12 +0800
Message-ID: <3a9a9afec779338214b950c0bbba9c470ea4cbdc.1612163150.git.geliangtang@gmail.com>
In-Reply-To: 1946715e6eef7184d52d26c70856296760710e65.1612163150.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7546

--===============6519354265901030916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changed the member rm_id of struct mptcp_pm_data as an array
of the removing address ids, and renamed it to rm_ids. Used memset to
initialize pm.rm_ids, and memcpy to copy it.

In mptcp_pm_nl_rm_addr_received, iterated each address id from pm.rm_ids,
then shut down and closed each address id's subsocket.

In mptcp_pm_remove_anno_addr, put the single address id into an ids
array, and passed it to mptcp_pm_remove_addr.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c         | 10 ++++++----
 net/mptcp/pm_netlink.c | 41 ++++++++++++++++++++++++-----------------
 net/mptcp/protocol.h   |  4 ++--
 3 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5ff59a84de2b..f4d7f3afd1e5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -39,18 +39,18 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 	return 0;
 }
 =

-int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id)
+int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_ids[])
 {
 	u8 rm_addr =3D READ_ONCE(msk->pm.addr_signal);
 =

-	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
+	pr_debug("msk=3D%p, local_ids_nr=3D%d", msk, mptcp_get_rm_ids_nr(local_id=
s));
 =

 	if (rm_addr) {
 		pr_warn("addr_signal error, rm_addr=3D%d", rm_addr);
 		return -EINVAL;
 	}
 =

-	msk->pm.rm_id =3D local_id;
+	memcpy(msk->pm.rm_ids, local_ids, MPTCP_RM_IDS_MAX);
 	rm_addr |=3D BIT(MPTCP_RM_ADDR_SIGNAL);
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
 	return 0;
@@ -217,6 +217,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, =
u8 rm_ids[])
 =

 	spin_lock_bh(&pm->lock);
 	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
+	memcpy(pm->rm_ids, rm_ids, MPTCP_RM_IDS_MAX);
 	spin_unlock_bh(&pm->lock);
 }
 =

@@ -272,6 +273,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, un=
signed int remaining,
 	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
 		goto out_unlock;
 =

+	memcpy(rm_ids, msk->pm.rm_ids, MPTCP_RM_IDS_MAX);
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	ret =3D true;
 =

@@ -291,7 +293,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.add_addr_accepted =3D 0;
 	msk->pm.local_addr_used =3D 0;
 	msk->pm.subflows =3D 0;
-	msk->pm.rm_id =3D 0;
+	memset(msk->pm.rm_ids, 0, MPTCP_RM_IDS_MAX);
 	WRITE_ONCE(msk->pm.work_pending, false);
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	WRITE_ONCE(msk->pm.accept_addr, false);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f2a6e77c1dec..228cf5dfddd7 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -574,36 +574,42 @@ static void mptcp_pm_nl_rm_addr_received(struct mptcp=
_sock *msk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk =3D (struct sock *)msk;
+	u8 i, nr;
 =

-	pr_debug("address rm_id %d", msk->pm.rm_id);
+	nr =3D mptcp_get_rm_ids_nr(msk->pm.rm_ids);
+
+	pr_debug("address rm_ids_nr %d", nr);
 =

 	msk_owned_by_me(msk);
 =

-	if (!msk->pm.rm_id)
+	if (!nr)
 		return;
 =

 	if (list_empty(&msk->conn_list))
 		return;
 =

-	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
-		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
-		int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
+	for (i =3D 0; i < MPTCP_RM_IDS_MAX && msk->pm.rm_ids[i]; i++) {
+		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+			int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
 =

-		if (msk->pm.rm_id !=3D subflow->remote_id)
-			continue;
+			if (msk->pm.rm_ids[i] !=3D subflow->remote_id)
+				continue;
 =

-		spin_unlock_bh(&msk->pm.lock);
-		mptcp_subflow_shutdown(sk, ssk, how);
-		mptcp_close_ssk(sk, ssk, subflow);
-		spin_lock_bh(&msk->pm.lock);
+			pr_debug(" -> address rm_ids[%d]=3D%u", i, msk->pm.rm_ids[i]);
+			spin_unlock_bh(&msk->pm.lock);
+			mptcp_subflow_shutdown(sk, ssk, how);
+			mptcp_close_ssk(sk, ssk, subflow);
+			spin_lock_bh(&msk->pm.lock);
 =

-		msk->pm.add_addr_accepted--;
-		msk->pm.subflows--;
-		WRITE_ONCE(msk->pm.accept_addr, true);
+			msk->pm.add_addr_accepted--;
+			msk->pm.subflows--;
+			WRITE_ONCE(msk->pm.accept_addr, true);
 =

-		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMADDR);
+			__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMADDR);
 =

-		break;
+			break;
+		}
 	}
 }
 =

@@ -1070,12 +1076,13 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_=
sock *msk,
 				      struct mptcp_addr_info *addr,
 				      bool force)
 {
+	u8 ids[MPTCP_RM_IDS_MAX] =3D { addr->id, 0, 0, 0, 0, 0, 0, 0 };
 	bool ret;
 =

 	ret =3D remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
-		mptcp_pm_remove_addr(msk, addr->id);
+		mptcp_pm_remove_addr(msk, ids);
 		spin_unlock_bh(&msk->pm.lock);
 	}
 	return ret;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3930a92beeb4..5adf85e3fd15 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -205,7 +205,7 @@ struct mptcp_pm_data {
 	u8		local_addr_used;
 	u8		subflows;
 	u8		status;
-	u8		rm_id;
+	u8		rm_ids[MPTCP_RM_IDS_MAX];
 };
 =

 struct mptcp_data_frag {
@@ -674,7 +674,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo, bool port);
-int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id);
+int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_ids[]);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id);
 =

 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
-- =

2.29.2

--===============6519354265901030916==--
