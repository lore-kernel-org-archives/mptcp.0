Content-Type: multipart/mixed; boundary="===============7244291058786518589=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 1/2] Squash-to: "mptcp: remove
 addr and subflow in PM netlink"
Date: Tue, 15 Sep 2020 15:36:35 +0800
Message-ID: <689b9e1e5a8a89b54c3a17454394b55c458c8739.1600154343.git.geliangtang@gmail.com>
In-Reply-To: cover.1600154343.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5868

--===============7244291058786518589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit message should be rewritten entirely:
'''
This patch implements the remove announced addr and subflow logic in PM
netlink.

When the PM netlink removes an address, we traverse all the existing msk
sockets to find the relevant sockets.

We add a new list named anno_list in mptcp_pm_data, to record all the
announced addrs. In the traversing, we check if it has been recorded.
If it has been, we trigger the RM_ADDR signal.

We also check if this address is in conn_list. If it is, we remove the
subflow which using this local address.
'''

Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c         |  1 +
 net/mptcp/pm_netlink.c | 94 ++++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.c   |  1 +
 net/mptcp/protocol.h   |  2 +
 net/mptcp/subflow.c    |  1 +
 5 files changed, 91 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9328f0b175a7..6ca88422e774 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -240,6 +240,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.status =3D 0;
 =

 	spin_lock_init(&msk->pm.lock);
+	INIT_LIST_HEAD(&msk->pm.anno_list);
 =

 	mptcp_pm_nl_data_init(msk);
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c3ac466c6686..4ec909f86e5a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -178,6 +178,50 @@ static void check_work_pending(struct mptcp_sock *msk)
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
 	struct mptcp_addr_info remote =3D { 0 };
@@ -198,8 +242,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(str=
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
@@ -605,6 +651,36 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsig=
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
+static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
+				      struct mptcp_addr_info *addr,
+				      bool force)
+{
+	bool ret;
+
+	spin_lock_bh(&msk->pm.lock);
+	ret =3D remove_anno_list_by_saddr(msk, addr);
+	if (ret || force)
+		mptcp_pm_remove_addr(msk, addr->id);
+	spin_unlock_bh(&msk->pm.lock);
+	return ret;
+}
+
 static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 						   struct mptcp_addr_info *addr)
 {
@@ -615,18 +691,20 @@ static int mptcp_nl_remove_subflow_and_signal_addr(st=
ruct net *net,
 =

 	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL) {
 		struct sock *sk =3D (struct sock *)msk;
+		bool remove_subflow;
 =

-		if (list_empty(&msk->conn_list))
-			goto next;
+		if (list_empty(&msk->conn_list)) {
+			mptcp_pm_remove_anno_addr(msk, addr, false);
+			continue;
+		}
 =

 		lock_sock(sk);
-		if (lookup_subflow_by_saddr(&msk->conn_list, addr)) {
-			mptcp_pm_remove_addr(msk, addr->id);
+		remove_subflow =3D lookup_subflow_by_saddr(&msk->conn_list, addr);
+		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow);
+		if (remove_subflow)
 			mptcp_pm_remove_subflow(msk, addr->id);
-		}
 		release_sock(sk);
 =

-next:
 		sock_put(sk);
 		cond_resched();
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index eb833ecbba9e..5b8aa02856b6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2160,6 +2160,7 @@ static void mptcp_destroy(struct sock *sk)
 	if (msk->cached_ext)
 		__skb_ext_put(msk->cached_ext);
 =

+	mptcp_pm_free_anno_list(msk);
 	sk_sockets_allocated_dec(sk);
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bad751e2c8f3..df6cc94df1f7 100644
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
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 58f318b38168..339f90e22269 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -437,6 +437,7 @@ static void mptcp_sock_destruct(struct sock *sk)
 =

 	skb_rbtree_purge(&mptcp_sk(sk)->out_of_order_queue);
 	mptcp_token_destroy(mptcp_sk(sk));
+	mptcp_pm_free_anno_list(mptcp_sk(sk));
 	inet_sock_destruct(sk);
 }
 =

-- =

2.17.1

--===============7244291058786518589==--
