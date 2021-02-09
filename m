Content-Type: multipart/mixed; boundary="===============4651013874944393485=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v6 mptcp-next 2/9] mptcp: add rm_list_tx in
 mptcp_pm_data
Date: Tue, 09 Feb 2021 23:03:43 +0800
Message-ID: <82c33c92a1de9a6554e361acb174373664e28b5a.1612882689.git.geliangtang@gmail.com>
In-Reply-To: 8b501ce9d791d7769a16512754be878768865096.1612882689.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7716

--===============4651013874944393485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new member rm_list_tx for struct mptcp_pm_data as the
removing address list on the outgoing direction. Initialize its nr field
to zero in mptcp_pm_data_init.

In mptcp_pm_remove_anno_addr, put the single address id into an removing
list, and passed it to mptcp_pm_remove_addr.

In mptcp_pm_remove_addr, save the input rm_list to rm_list_tx in struct
mptcp_pm_data.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c         | 11 +++++------
 net/mptcp/pm_netlink.c |  5 ++++-
 net/mptcp/protocol.h   |  3 ++-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ede27edd8335..adf1ef1ed839 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -39,18 +39,18 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 	return 0;
 }
 =

-int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id)
+int mptcp_pm_remove_addr(struct mptcp_sock *msk, struct mptcp_rm_list rm_l=
ist)
 {
 	u8 rm_addr =3D READ_ONCE(msk->pm.addr_signal);
 =

-	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
+	pr_debug("msk=3D%p, rm_list_nr=3D%d", msk, rm_list.nr);
 =

 	if (rm_addr) {
 		pr_warn("addr_signal error, rm_addr=3D%d", rm_addr);
 		return -EINVAL;
 	}
 =

-	msk->pm.rm_id =3D local_id;
+	msk->pm.rm_list_tx =3D rm_list;
 	rm_addr |=3D BIT(MPTCP_RM_ADDR_SIGNAL);
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
 	return 0;
@@ -289,8 +289,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, un=
signed int remaining,
 	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
 		goto out_unlock;
 =

-	rm_list->ids[0] =3D msk->pm.rm_id;
-	rm_list->nr =3D 1;
+	*rm_list =3D msk->pm.rm_list_tx;
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	ret =3D true;
 =

@@ -310,7 +309,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.add_addr_accepted =3D 0;
 	msk->pm.local_addr_used =3D 0;
 	msk->pm.subflows =3D 0;
-	msk->pm.rm_id =3D 0;
+	msk->pm.rm_list_tx.nr =3D 0;
 	WRITE_ONCE(msk->pm.work_pending, false);
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	WRITE_ONCE(msk->pm.accept_addr, false);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 97adae0c3b0e..b9a7858baaec 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1071,12 +1071,15 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_=
sock *msk,
 				      struct mptcp_addr_info *addr,
 				      bool force)
 {
+	struct mptcp_rm_list list =3D { .nr =3D 0 };
 	bool ret;
 =

+	list.ids[list.nr++] =3D addr->id;
+
 	ret =3D remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
-		mptcp_pm_remove_addr(msk, addr->id);
+		mptcp_pm_remove_addr(msk, list);
 		spin_unlock_bh(&msk->pm.lock);
 	}
 	return ret;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bc67132858ca..f3b4ad0b9f14 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -206,6 +206,7 @@ struct mptcp_pm_data {
 	u8		local_addr_used;
 	u8		subflows;
 	u8		status;
+	struct mptcp_rm_list rm_list_tx;
 	u8		rm_id;
 };
 =

@@ -663,7 +664,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo, bool port);
-int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id);
+int mptcp_pm_remove_addr(struct mptcp_sock *msk, struct mptcp_rm_list rm_l=
ist);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id);
 =

 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
-- =

2.29.2

--===============4651013874944393485==--
