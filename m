Content-Type: multipart/mixed; boundary="===============0338510221088386791=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 2/9] mptcp: use rm_ids_tx array
 in mptcp_pm_data
Date: Fri, 05 Feb 2021 22:24:26 +0800
Message-ID: <7d72dee8595a08b314a5e97300b2d839058c3596.1612534634.git.geliangtang@gmail.com>
In-Reply-To: da8cdc04a9ca5353e5f9455e4d6c91defa7c59de.1612534634.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7639

--===============0338510221088386791==
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
 net/mptcp/pm_netlink.c |  6 +++++-
 net/mptcp/protocol.h   |  3 ++-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d71e8ff7c2fd..85ca63cbc256 100644
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
@@ -286,7 +286,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, un=
signed int remaining,
 	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
 		goto out_unlock;
 =

-	rm_ids[0] =3D msk->pm.rm_id;
+	memcpy(rm_ids, msk->pm.rm_ids_tx, MPTCP_RM_IDS_MAX);
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	ret =3D true;
 =

@@ -306,7 +306,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.add_addr_accepted =3D 0;
 	msk->pm.local_addr_used =3D 0;
 	msk->pm.subflows =3D 0;
-	msk->pm.rm_id =3D 0;
+	memset(msk->pm.rm_ids_tx, MAX_ADDR_ID, MPTCP_RM_IDS_MAX);
 	WRITE_ONCE(msk->pm.work_pending, false);
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	WRITE_ONCE(msk->pm.accept_addr, false);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 073e8ad1cbd0..f26453b3cb01 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1079,12 +1079,16 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_=
sock *msk,
 				      struct mptcp_addr_info *addr,
 				      bool force)
 {
+	u8 ids[MPTCP_RM_IDS_MAX];
 	bool ret;
 =

+	memset(ids, MAX_ADDR_ID, MPTCP_RM_IDS_MAX);
+	ids[0] =3D addr->id;
+
 	ret =3D remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
-		mptcp_pm_remove_addr(msk, addr->id);
+		mptcp_pm_remove_addr(msk, ids);
 		spin_unlock_bh(&msk->pm.lock);
 	}
 	return ret;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index aa2716b50214..be00ca68457e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -207,6 +207,7 @@ struct mptcp_pm_data {
 	u8		local_addr_used;
 	u8		subflows;
 	u8		status;
+	u8		rm_ids_tx[MPTCP_RM_IDS_MAX];
 	u8		rm_id;
 };
 =

@@ -686,7 +687,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
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

--===============0338510221088386791==--
