Content-Type: multipart/mixed; boundary="===============0511701988944093035=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] mptcp: retransmit ADD_ADDR when
 timeout
Date: Wed, 09 Sep 2020 19:53:43 +0800
Message-ID: <d1a8db14df26e17744c94809cc353dbdc7953896.1599652267.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5767

--===============0511701988944093035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch implemented the retransmition of ADD_ADDR when no ADD_ADDR echo
is received. It added a timer with the announced address. When timeout
occurs, ADD_ADDR will be retransmitted.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c    |  1 +
 net/mptcp/pm_netlink.c | 71 +++++++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.h   |  1 +
 3 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 171039cbe9c4..8445d292776b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -893,6 +893,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 			mptcp_pm_add_addr_received(msk, &addr);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 		} else {
+			mptcp_pm_del_add_addr_timer(msk, &addr);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 		}
 		mp_opt.add_addr =3D 0;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6bd5fe9ec086..d2303a3e356d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -28,6 +28,14 @@ struct mptcp_pm_addr_entry {
 	struct rcu_head		rcu;
 };
 =

+struct mptcp_pm_add_addr_entry {
+	struct list_head	list;
+	struct mptcp_addr_info	addr;
+	struct timer_list	add_addr_timer;
+	struct mptcp_sock	*sock;
+	u8			add_addr_retrans_times;
+};
+
 struct pm_nl_pernet {
 	/* protects pernet updates */
 	spinlock_t		lock;
@@ -41,6 +49,7 @@ struct pm_nl_pernet {
 };
 =

 #define MPTCP_PM_ADDR_MAX	8
+#define ADD_ADDR_RETRANS_MAX	3
 =

 static bool addresses_equal(const struct mptcp_addr_info *a,
 			    struct mptcp_addr_info *b, bool use_port)
@@ -178,10 +187,50 @@ static void check_work_pending(struct mptcp_sock *msk)
 		WRITE_ONCE(msk->pm.work_pending, false);
 }
 =

+static void mptcp_pm_add_addr_timer(struct timer_list *timer)
+{
+	struct mptcp_pm_add_addr_entry *entry =3D from_timer(entry, timer, add_ad=
dr_timer);
+	struct mptcp_sock *msk =3D entry->sock;
+	struct sock *sk =3D (struct sock *)msk;
+
+	pr_debug("msk=3D%p\n", msk);
+
+	if (!msk)
+		return;
+
+	bh_lock_sock(sk);
+	spin_lock_bh(&msk->pm.lock);
+
+	__sock_put(sk);
+
+	if (entry->addr.id > 0) {
+		mptcp_pm_announce_addr(msk, &entry->addr, false);
+		entry->add_addr_retrans_times++;
+	}
+
+	if (entry->add_addr_retrans_times < ADD_ADDR_RETRANS_MAX)
+		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX);
+
+	spin_unlock_bh(&msk->pm.lock);
+	bh_unlock_sock(sk);
+}
+
+void mptcp_pm_del_add_addr_timer(struct mptcp_sock *msk, struct mptcp_addr=
_info *addr)
+{
+	struct mptcp_pm_add_addr_entry *entry;
+
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.anno_list, list) {
+		if (addresses_equal(&entry->addr, addr, false))
+			sk_stop_timer((struct sock *)msk, &entry->add_addr_timer);
+	}
+	spin_unlock_bh(&msk->pm.lock);
+}
+
 static bool lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 				      struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_pm_add_addr_entry *entry;
 =

 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
 		if (addresses_equal(&entry->addr, addr, false))
@@ -194,27 +243,35 @@ static bool lookup_anno_list_by_saddr(struct mptcp_so=
ck *msk,
 static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 				     struct mptcp_pm_addr_entry *entry)
 {
-	struct mptcp_pm_addr_entry *clone =3D NULL;
+	struct mptcp_pm_add_addr_entry *add_entry =3D NULL;
 =

 	if (lookup_anno_list_by_saddr(msk, &entry->addr))
 		return false;
 =

-	clone =3D kmemdup(entry, sizeof(*entry), GFP_ATOMIC);
-	if (!clone)
+	add_entry =3D kmalloc(sizeof(*add_entry), GFP_ATOMIC);
+	if (!add_entry)
 		return false;
 =

-	list_add(&clone->list, &msk->pm.anno_list);
+	list_add(&add_entry->list, &msk->pm.anno_list);
+
+	add_entry->addr =3D entry->addr;
+	add_entry->sock =3D msk;
+	add_entry->add_addr_retrans_times =3D 0;
+
+	timer_setup(&add_entry->add_addr_timer, mptcp_pm_add_addr_timer, 0);
+	sk_reset_timer((struct sock *)msk, &add_entry->add_addr_timer, jiffies + =
TCP_RTO_MAX);
 =

 	return true;
 }
 =

 void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct mptcp_pm_add_addr_entry *entry, *tmp;
 =

 	pr_debug("msk=3D%p\n", msk);
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry_safe(entry, tmp, &msk->pm.anno_list, list) {
+		sk_stop_timer((struct sock *)msk, &entry->add_addr_timer);
 		list_del(&entry->list);
 		kfree(entry);
 	}
@@ -653,7 +710,7 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsign=
ed int id)
 static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				      struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct mptcp_pm_add_addr_entry *entry, *tmp;
 =

 	list_for_each_entry_safe(entry, tmp, &msk->pm.anno_list, list) {
 		if (addresses_equal(&entry->addr, addr, false)) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index df6cc94df1f7..12ca49d34bf3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -443,6 +443,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
+void mptcp_pm_del_add_addr_timer(struct mptcp_sock *msk, struct mptcp_addr=
_info *addr);
 =

 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
-- =

2.24.1

--===============0511701988944093035==--
