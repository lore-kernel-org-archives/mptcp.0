Content-Type: multipart/mixed; boundary="===============1902296699195277882=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 2/9] mptcp: use rm_ids_tx array
 in mptcp_pm_data
Date: Tue, 02 Feb 2021 15:20:53 +0800
Message-ID: <0905122212bc3da3b02b5d59f62ccf23daa5c241.1612250255.git.geliangtang@gmail.com>
In-Reply-To: ea457c78b21229f81006a14ff6156b7cc0360a27.1612250255.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7581

--===============1902296699195277882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new member rm_ids_tx for struct mptcp_pm_data as an
array of the removing address ids on the outgoing direction. Used memset
to initialize it, and memcpy to copy it.

In mptcp_pm_remove_anno_addr, put the single address id into an ids array,
and passed it to mptcp_pm_remove_addr.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c         | 10 +++++-----
 net/mptcp/pm_netlink.c |  3 ++-
 net/mptcp/protocol.h   |  3 ++-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 59e0fee52afa..7207d1dc87ad 100644
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
+	memcpy(msk->pm.rm_ids_tx, local_ids, MPTCP_RM_IDS_MAX);
 	rm_addr |=3D BIT(MPTCP_RM_ADDR_SIGNAL);
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
 	return 0;
@@ -271,7 +271,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, un=
signed int remaining,
 	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
 		goto out_unlock;
 =

-	rm_ids[0] =3D msk->pm.rm_id;
+	memcpy(rm_ids, msk->pm.rm_ids_tx, MPTCP_RM_IDS_MAX);
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	ret =3D true;
 =

@@ -291,7 +291,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.add_addr_accepted =3D 0;
 	msk->pm.local_addr_used =3D 0;
 	msk->pm.subflows =3D 0;
-	msk->pm.rm_id =3D 0;
+	memset(msk->pm.rm_ids_tx, 0, MPTCP_RM_IDS_MAX);
 	WRITE_ONCE(msk->pm.work_pending, false);
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	WRITE_ONCE(msk->pm.accept_addr, false);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f2a6e77c1dec..12a6ee14fe31 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1070,12 +1070,13 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_=
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
index 0c00e529f127..ae225ef202db 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -205,6 +205,7 @@ struct mptcp_pm_data {
 	u8		local_addr_used;
 	u8		subflows;
 	u8		status;
+	u8		rm_ids_tx[MPTCP_RM_IDS_MAX];
 	u8		rm_id;
 };
 =

@@ -674,7 +675,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
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

--===============1902296699195277882==--
