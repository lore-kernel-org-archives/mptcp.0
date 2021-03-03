Content-Type: multipart/mixed; boundary="===============6255665067923021612=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 1/5] mptcp: avoid passing rm_list
 as a struct
Date: Wed, 03 Mar 2021 21:13:16 +0800
Message-ID: <3e2dc12697da18322648e21f245c0072871c1acd.1614776769.git.geliangtang@gmail.com>
In-Reply-To: cover.1614776769.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7995

--===============6255665067923021612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changed the type of argument rm_list from "struct mptcp_rm_list
rm_list" to "const struct mptcp_rm_list *rm_list".

Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c    |  4 ++--
 net/mptcp/pm.c         | 23 ++++++++++++-----------
 net/mptcp/pm_netlink.c | 21 +++++++++++----------
 net/mptcp/protocol.h   | 16 +++++++++-------
 4 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f95643d820fe..9600b4f4caa5 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -698,7 +698,7 @@ static bool mptcp_established_options_rm_addr(struct so=
ck *sk,
 	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list)))
 		return false;
 =

-	len =3D mptcp_rm_addr_len(rm_list);
+	len =3D mptcp_rm_addr_len(&rm_list);
 	if (len < 0)
 		return false;
 	if (remaining < len)
@@ -1076,7 +1076,7 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 	}
 =

 	if (mp_opt.rm_addr) {
-		mptcp_pm_rm_addr_received(msk, mp_opt.rm_list);
+		mptcp_pm_rm_addr_received(msk, &mp_opt.rm_list);
 		mp_opt.rm_addr =3D 0;
 	}
 =

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 51534bed5dbe..966942d1013f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -39,26 +39,26 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 	return 0;
 }
 =

-int mptcp_pm_remove_addr(struct mptcp_sock *msk, struct mptcp_rm_list rm_l=
ist)
+int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_lis=
t *rm_list)
 {
 	u8 rm_addr =3D READ_ONCE(msk->pm.addr_signal);
 =

-	pr_debug("msk=3D%p, rm_list_nr=3D%d", msk, rm_list.nr);
+	pr_debug("msk=3D%p, rm_list_nr=3D%d", msk, rm_list->nr);
 =

 	if (rm_addr) {
 		pr_warn("addr_signal error, rm_addr=3D%d", rm_addr);
 		return -EINVAL;
 	}
 =

-	msk->pm.rm_list_tx =3D rm_list;
+	msk->pm.rm_list_tx =3D *rm_list;
 	rm_addr |=3D BIT(MPTCP_RM_ADDR_SIGNAL);
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
 	return 0;
 }
 =

-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, struct mptcp_rm_list r=
m_list)
+int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_=
list *rm_list)
 {
-	pr_debug("msk=3D%p, rm_list_nr=3D%d", msk, rm_list.nr);
+	pr_debug("msk=3D%p, rm_list_nr=3D%d", msk, rm_list->nr);
 =

 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_nl_rm_subflow_received(msk, rm_list);
@@ -219,19 +219,20 @@ void mptcp_pm_add_addr_send_ack(struct mptcp_sock *ms=
k)
 	mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
 }
 =

-void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, struct mptcp_rm_lis=
t rm_list)
+void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
+			       const struct mptcp_rm_list *rm_list)
 {
 	struct mptcp_pm_data *pm =3D &msk->pm;
 	u8 i;
 =

-	pr_debug("msk=3D%p remote_ids_nr=3D%d", msk, rm_list.nr);
+	pr_debug("msk=3D%p remote_ids_nr=3D%d", msk, rm_list->nr);
 =

-	for (i =3D 0; i < rm_list.nr; i++)
-		mptcp_event_addr_removed(msk, rm_list.ids[i]);
+	for (i =3D 0; i < rm_list->nr; i++)
+		mptcp_event_addr_removed(msk, rm_list->ids[i]);
 =

 	spin_lock_bh(&pm->lock);
 	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
-	pm->rm_list_rx =3D rm_list;
+	pm->rm_list_rx =3D *rm_list;
 	spin_unlock_bh(&pm->lock);
 }
 =

@@ -284,7 +285,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, un=
signed int remaining,
 	if (!mptcp_pm_should_rm_signal(msk))
 		goto out_unlock;
 =

-	len =3D mptcp_rm_addr_len(msk->pm.rm_list_tx);
+	len =3D mptcp_rm_addr_len(&msk->pm.rm_list_tx);
 	if (len < 0) {
 		WRITE_ONCE(msk->pm.addr_signal, 0);
 		goto out_unlock;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 328fdcc35bfd..fa1dd6b8ec2f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -668,31 +668,32 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 =

-void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, struct mptcp_=
rm_list rm_list)
+void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
+				     const struct mptcp_rm_list *rm_list)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk =3D (struct sock *)msk;
 	u8 i;
 =

-	pr_debug("subflow rm_list_nr %d", rm_list.nr);
+	pr_debug("subflow rm_list_nr %d", rm_list->nr);
 =

 	msk_owned_by_me(msk);
 =

-	if (!rm_list.nr)
+	if (!rm_list->nr)
 		return;
 =

 	if (list_empty(&msk->conn_list))
 		return;
 =

-	for (i =3D 0; i < rm_list.nr; i++) {
+	for (i =3D 0; i < rm_list->nr; i++) {
 		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 			int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
 =

-			if (rm_list.ids[i] !=3D subflow->local_id)
+			if (rm_list->ids[i] !=3D subflow->local_id)
 				continue;
 =

-			pr_debug(" -> subflow rm_list_ids[%d]=3D%u", i, rm_list.ids[i]);
+			pr_debug(" -> subflow rm_list_ids[%d]=3D%u", i, rm_list->ids[i]);
 			spin_unlock_bh(&msk->pm.lock);
 			mptcp_subflow_shutdown(sk, ssk, how);
 			mptcp_close_ssk(sk, ssk, subflow);
@@ -1110,7 +1111,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_so=
ck *msk,
 	ret =3D remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
-		mptcp_pm_remove_addr(msk, list);
+		mptcp_pm_remove_addr(msk, &list);
 		spin_unlock_bh(&msk->pm.lock);
 	}
 	return ret;
@@ -1140,7 +1141,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(st=
ruct net *net,
 		remove_subflow =3D lookup_subflow_by_saddr(&msk->conn_list, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow);
 		if (remove_subflow)
-			mptcp_pm_remove_subflow(msk, list);
+			mptcp_pm_remove_subflow(msk, &list);
 		release_sock(sk);
 =

 next:
@@ -1242,11 +1243,11 @@ static void mptcp_pm_remove_addrs_and_subflows(stru=
ct mptcp_sock *msk,
 =

 	if (alist.nr) {
 		spin_lock_bh(&msk->pm.lock);
-		mptcp_pm_remove_addr(msk, alist);
+		mptcp_pm_remove_addr(msk, &alist);
 		spin_unlock_bh(&msk->pm.lock);
 	}
 	if (slist.nr)
-		mptcp_pm_remove_subflow(msk, slist);
+		mptcp_pm_remove_subflow(msk, &slist);
 }
 =

 static void mptcp_nl_remove_addrs_list(struct net *net,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4bf8536b7406..d9b403c4b338 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -661,7 +661,8 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
-void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, struct mptcp_rm_lis=
t rm_list);
+void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
+			       const struct mptcp_rm_list *rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *addr,
@@ -678,8 +679,8 @@ mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
-int mptcp_pm_remove_addr(struct mptcp_sock *msk, struct mptcp_rm_list rm_l=
ist);
-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, struct mptcp_rm_list r=
m_list);
+int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_lis=
t *rm_list);
+int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_=
list *rm_list);
 =

 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
@@ -725,12 +726,12 @@ static inline unsigned int mptcp_add_addr_len(int fam=
ily, bool echo, bool port)
 	return len;
 }
 =

-static inline int mptcp_rm_addr_len(struct mptcp_rm_list rm_list)
+static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
 {
-	if (rm_list.nr =3D=3D 0 || rm_list.nr >=3D MPTCP_RM_IDS_MAX)
+	if (rm_list->nr =3D=3D 0 || rm_list->nr >=3D MPTCP_RM_IDS_MAX)
 		return -EINVAL;
 =

-	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list.nr - 1, 4) + 1;
+	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
 }
 =

 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
@@ -742,7 +743,8 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struc=
t sock_common *skc);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, struct mptcp_=
rm_list rm_list);
+void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
+				     const struct mptcp_rm_list *rm_list);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *s=
kc);
 unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
-- =

2.29.2

--===============6255665067923021612==--
