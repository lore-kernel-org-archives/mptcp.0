Content-Type: multipart/mixed; boundary="===============1262459027194775250=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH] Squash-to: "mptcp: remove addr and subflow in
 PM netlink v9"
Date: Mon, 07 Sep 2020 14:48:48 +0800
Message-ID: <ad4ee3dabbf15a02ee73388e79ef0d037acd9eaf.1599461190.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5739

--===============1262459027194775250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit message should be rewritten enterily:
'''
This patch implements the remove announced addr and subflow logic in PM
netlink.

When the PM netlink removes an address, we traverse all the existing msk
sockets to find the relevant sockets.

If this removing address is a signaled address, we deal it like this:

We add a new list named anno_list in mptcp_pm_data, to record all the
announced addrs. In the traversing, we check if it has been recorded. If it
has been, we trigger the RM_ADDR signal to remove the remote subflow. Then
we check if this address is in conn_list. If it is, we remove the local
subflow which using this local address.

If this removing address is a subflow address, we deal it like this:

In the traversing, we check if this address is in conn_list. If it is, we
trigger the RM_ADDR signal to remove the remote subflow and remove the local
subflow which using this local address.
'''

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c         |   1 +
 net/mptcp/pm_netlink.c | 106 +++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.c   |   2 +
 net/mptcp/protocol.h   |   2 +
 4 files changed, 102 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 511996bf4838..f450bf0d49aa 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -235,6 +235,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.status =3D 0;
 =

 	spin_lock_init(&msk->pm.lock);
+	INIT_LIST_HEAD(&msk->pm.anno_list);
 =

 	mptcp_pm_nl_data_init(msk);
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 16709939f767..f0981f332081 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -167,6 +167,50 @@ static void check_work_pending(struct mptcp_sock *msk)
 		WRITE_ONCE(msk->pm.work_pending, false);
 }
 =

+static bool lookup_anno_list_by_saddr(struct mptcp_sock *msk,
+				      struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.anno_list, list) {
+		if (addresses_equal(&entry->addr, addr, false))
+			return true;
+	}
+
+	return false;
+}
+
+static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
+				     struct mptcp_pm_addr_entry *entry)
+{
+	struct mptcp_pm_addr_entry *clone =3D NULL;
+
+	if (lookup_anno_list_by_saddr(msk, &entry->addr))
+		return false;
+
+	clone =3D kmemdup(entry, sizeof(*entry), GFP_ATOMIC);
+	if (!clone)
+		return false;
+
+	list_add(&clone->list, &msk->pm.anno_list);
+
+	return true;
+}
+
+void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_addr_entry *entry, *tmp;
+
+	pr_debug("msk=3D%p\n", msk);
+
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry_safe(entry, tmp, &msk->pm.anno_list, list) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+	spin_unlock_bh(&msk->pm.lock);
+}
+
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct sock *sk =3D (struct sock *)msk;
@@ -187,8 +231,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(str=
uct mptcp_sock *msk)
 					      msk->pm.add_addr_signaled);
 =

 		if (local) {
-			msk->pm.add_addr_signaled++;
-			mptcp_pm_announce_addr(msk, &local->addr, false);
+			if (mptcp_pm_alloc_anno_list(msk, local)) {
+				msk->pm.add_addr_signaled++;
+				mptcp_pm_announce_addr(msk, &local->addr, false);
+			}
 		} else {
 			/* pick failed, avoid fourther attempts later */
 			msk->pm.local_addr_used =3D msk->pm.add_addr_signal_max;
@@ -554,6 +600,22 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsig=
ned int id)
 	return NULL;
 }
 =

+static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
+				      struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_addr_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &msk->pm.anno_list, list) {
+		if (addresses_equal(&entry->addr, addr, false)) {
+			list_del(&entry->list);
+			kfree(entry);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 						   struct mptcp_addr_info *addr)
 {
@@ -565,15 +627,41 @@ static int mptcp_nl_remove_subflow_and_signal_addr(st=
ruct net *net,
 	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL) {
 		struct sock *sk =3D (struct sock *)msk;
 =

-		if (list_empty(&msk->conn_list))
-			goto next;
+		if (addr->flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
+			bool ret =3D false;
+
+			/* check first for announced addr */
+			if (list_empty(&msk->pm.anno_list))
+				goto remove_subflow;
+
+			spin_lock_bh(&msk->pm.lock);
+			ret =3D remove_anno_list_by_saddr(msk, addr);
+			spin_unlock_bh(&msk->pm.lock);
+			if (ret)
+				mptcp_pm_remove_addr(msk, addr->id);
+
+			/* check if should remove a subflow */
+remove_subflow:
+			if (list_empty(&msk->conn_list))
+				goto next;
+
+			lock_sock(sk);
+			if (lookup_subflow_by_saddr(&msk->conn_list, addr))
+				mptcp_pm_remove_subflow(msk, addr->id);
+			release_sock(sk);
+		}
+
+		if (addr->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
+			if (list_empty(&msk->conn_list))
+				goto next;
 =

-		lock_sock(sk);
-		if (lookup_subflow_by_saddr(&msk->conn_list, addr)) {
-			mptcp_pm_remove_addr(msk, addr->id);
-			mptcp_pm_remove_subflow(msk, addr->id);
+			lock_sock(sk);
+			if (lookup_subflow_by_saddr(&msk->conn_list, addr)) {
+				mptcp_pm_remove_addr(msk, addr->id);
+				mptcp_pm_remove_subflow(msk, addr->id);
+			}
+			release_sock(sk);
 		}
-		release_sock(sk);
 =

 next:
 		sock_put(sk);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index eb833ecbba9e..e68e94738661 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1979,6 +1979,8 @@ static void mptcp_close(struct sock *sk, long timeout)
 		__mptcp_close_ssk(sk, ssk, subflow, timeout);
 	}
 =

+	mptcp_pm_free_anno_list(msk);
+
 	mptcp_cancel_work(sk);
 =

 	__skb_queue_purge(&sk->sk_receive_queue);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ba253a6947b0..d1b1416797f8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -160,6 +160,7 @@ enum mptcp_pm_status {
 struct mptcp_pm_data {
 	struct mptcp_addr_info local;
 	struct mptcp_addr_info remote;
+	struct list_head anno_list;
 =

 	spinlock_t	lock;		/*protects the whole PM data */
 =

@@ -441,6 +442,7 @@ void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8=
 id);
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
+void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 =

 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
-- =

2.17.1

--===============1262459027194775250==--
