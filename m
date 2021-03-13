Content-Type: multipart/mixed; boundary="===============7319101221553443364=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 02/11] mptcp: add rm_list_tx in mptcp_pm_data
Date: Fri, 12 Mar 2021 17:16:12 -0800
Message-ID: <20210313011621.211661-3-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210313011621.211661-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8133

--===============7319101221553443364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch added a new member rm_list_tx for struct mptcp_pm_data as the
removing address list on the outgoing direction. Initialize its nr field
to zero in mptcp_pm_data_init.

In mptcp_pm_remove_anno_addr, put the single address id into an removing
list, and passed it to mptcp_pm_remove_addr.

In mptcp_pm_remove_addr, save the input rm_list to rm_list_tx in struct
mptcp_pm_data.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/pm.c         | 20 ++++++++++++--------
 net/mptcp/pm_netlink.c |  5 ++++-
 net/mptcp/protocol.h   |  3 ++-
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 0654c86cd5ff..9a91605885bb 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -39,18 +39,18 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 	return 0;
 }
 =

-int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id)
+int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_lis=
t *rm_list)
 {
 	u8 rm_addr =3D READ_ONCE(msk->pm.addr_signal);
 =

-	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
+	pr_debug("msk=3D%p, rm_list_nr=3D%d", msk, rm_list->nr);
 =

 	if (rm_addr) {
 		pr_warn("addr_signal error, rm_addr=3D%d", rm_addr);
 		return -EINVAL;
 	}
 =

-	msk->pm.rm_id =3D local_id;
+	msk->pm.rm_list_tx =3D *rm_list;
 	rm_addr |=3D BIT(MPTCP_RM_ADDR_SIGNAL);
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
 	return 0;
@@ -260,7 +260,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, u=
nsigned int remaining,
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remainin=
g,
 			     struct mptcp_rm_list *rm_list)
 {
-	int ret =3D false;
+	int ret =3D false, len;
 =

 	spin_lock_bh(&msk->pm.lock);
 =

@@ -268,11 +268,15 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, =
unsigned int remaining,
 	if (!mptcp_pm_should_rm_signal(msk))
 		goto out_unlock;
 =

-	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
+	len =3D mptcp_rm_addr_len(&msk->pm.rm_list_tx);
+	if (len < 0) {
+		WRITE_ONCE(msk->pm.addr_signal, 0);
+		goto out_unlock;
+	}
+	if (remaining < len)
 		goto out_unlock;
 =

-	rm_list->ids[0] =3D msk->pm.rm_id;
-	rm_list->nr =3D 1;
+	*rm_list =3D msk->pm.rm_list_tx;
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	ret =3D true;
 =

@@ -292,7 +296,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.add_addr_accepted =3D 0;
 	msk->pm.local_addr_used =3D 0;
 	msk->pm.subflows =3D 0;
-	msk->pm.rm_id =3D 0;
+	msk->pm.rm_list_tx.nr =3D 0;
 	WRITE_ONCE(msk->pm.work_pending, false);
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	WRITE_ONCE(msk->pm.accept_addr, false);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8e8e35fa4002..1eb9d0139267 100644
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
+		mptcp_pm_remove_addr(msk, &list);
 		spin_unlock_bh(&msk->pm.lock);
 	}
 	return ret;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c896bcf3e70f..ac15be7cf06b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -207,6 +207,7 @@ struct mptcp_pm_data {
 	u8		local_addr_used;
 	u8		subflows;
 	u8		status;
+	struct mptcp_rm_list rm_list_tx;
 	u8		rm_id;
 };
 =

@@ -661,7 +662,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo, bool port);
-int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id);
+int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_lis=
t *rm_list);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id);
 =

 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
-- =

2.30.2

--===============7319101221553443364==--
