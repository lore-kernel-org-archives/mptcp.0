Content-Type: multipart/mixed; boundary="===============3890481148223104394=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 2/2] mptcp: retransmit ADD_ADDR
 when timeout
Date: Thu, 17 Sep 2020 20:45:15 +0800
Message-ID: <10d3854a39bdaa07c3daf03cc49d194f13db7b8e.1600346411.git.geliangtang@gmail.com>
In-Reply-To: cover.1600346411.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5915

--===============3890481148223104394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch implemented the retransmition of ADD_ADDR when no ADD_ADDR echo
is received. It added a timer with the announced address. When timeout
occurs, ADD_ADDR will be retransmitted.

Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c    |   1 +
 net/mptcp/pm_netlink.c | 102 +++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.h   |   2 +
 3 files changed, 97 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 171039cbe9c4..14a290fae767 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -893,6 +893,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 			mptcp_pm_add_addr_received(msk, &addr);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 		} else {
+			mptcp_pm_del_add_timer(msk, &addr);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 		}
 		mp_opt.add_addr =3D 0;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 048800fa6072..000a76de6295 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -31,6 +31,9 @@ struct mptcp_pm_addr_entry {
 struct mptcp_pm_add_entry {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
+	struct timer_list	add_timer;
+	struct mptcp_sock	*sock;
+	u8			retrans_times;
 };
 =

 struct pm_nl_pernet {
@@ -46,6 +49,7 @@ struct pm_nl_pernet {
 };
 =

 #define MPTCP_PM_ADDR_MAX	8
+#define ADD_ADDR_RETRANS_MAX	3
 =

 static bool addresses_equal(const struct mptcp_addr_info *a,
 			    struct mptcp_addr_info *b, bool use_port)
@@ -196,6 +200,62 @@ static bool lookup_anno_list_by_saddr(struct mptcp_soc=
k *msk,
 	return false;
 }
 =

+static void mptcp_pm_add_timer(struct timer_list *timer)
+{
+	struct mptcp_pm_add_entry *entry =3D from_timer(entry, timer, add_timer);
+	struct mptcp_sock *msk =3D entry->sock;
+	struct sock *sk =3D (struct sock *)msk;
+
+	pr_debug("msk=3D%p\n", msk);
+
+	if (!msk)
+		return;
+
+	if (sk->sk_state =3D=3D TCP_CLOSE)
+		return;
+
+	spin_lock_bh(&msk->pm.lock);
+
+	if (entry->addr.id > 0) {
+		pr_debug("retransmit ADD_ADDR id=3D%d\n", entry->addr.id);
+		mptcp_pm_announce_addr(msk, &entry->addr, false);
+		entry->retrans_times++;
+	}
+
+	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX) {
+		if (!mod_timer(timer, jiffies + TCP_RTO_MAX))
+			sock_hold(sk);
+	}
+
+	spin_unlock_bh(&msk->pm.lock);
+
+	__sock_put(sk);
+}
+
+bool mptcp_pm_del_add_timer(struct mptcp_sock *msk,
+			    struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_add_entry *entry, *ret =3D NULL;
+
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.anno_list, list) {
+		if (addresses_equal(&entry->addr, addr, false)) {
+			entry->retrans_times =3D ADD_ADDR_RETRANS_MAX;
+			ret =3D entry;
+			break;
+		}
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
+	if (ret) {
+		if (del_timer_sync(&ret->add_timer))
+			__sock_put((struct sock *)msk);
+		return true;
+	}
+
+	return false;
+}
+
 static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 				     struct mptcp_pm_addr_entry *entry)
 {
@@ -210,21 +270,36 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_soc=
k *msk,
 =

 	list_add(&add_entry->list, &msk->pm.anno_list);
 =

+	add_entry->addr =3D entry->addr;
+	add_entry->sock =3D msk;
+	add_entry->retrans_times =3D 0;
+
+	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+	if (!mod_timer(&add_entry->add_timer, jiffies + TCP_RTO_MAX))
+		sock_hold((struct sock *)msk);
+
 	return true;
 }
 =

 void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_add_entry *entry, *tmp;
+	LIST_HEAD(free_list);
 =

 	pr_debug("msk=3D%p\n", msk);
 =

 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry_safe(entry, tmp, &msk->pm.anno_list, list) {
-		list_del(&entry->list);
-		kfree(entry);
+		entry->retrans_times =3D ADD_ADDR_RETRANS_MAX;
+		list_move(&entry->list, &free_list);
 	}
 	spin_unlock_bh(&msk->pm.lock);
+
+	list_for_each_entry_safe(entry, tmp, &free_list, list) {
+		if (del_timer_sync(&entry->add_timer))
+			__sock_put((struct sock *)msk);
+		kfree(entry);
+	}
 }
 =

 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
@@ -659,15 +734,25 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsi=
gned int id)
 static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				      struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry, *tmp;
+	struct mptcp_pm_add_entry *entry, *tmp, *ret =3D NULL;
 =

+	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry_safe(entry, tmp, &msk->pm.anno_list, list) {
 		if (addresses_equal(&entry->addr, addr, false)) {
+			entry->retrans_times =3D ADD_ADDR_RETRANS_MAX;
 			list_del(&entry->list);
-			kfree(entry);
-			return true;
+			ret =3D entry;
+			break;
 		}
 	}
+	spin_unlock_bh(&msk->pm.lock);
+
+	if (ret) {
+		if (del_timer_sync(&ret->add_timer))
+			__sock_put((struct sock *)msk);
+		kfree(ret);
+		return true;
+	}
 =

 	return false;
 }
@@ -678,11 +763,12 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_so=
ck *msk,
 {
 	bool ret;
 =

-	spin_lock_bh(&msk->pm.lock);
 	ret =3D remove_anno_list_by_saddr(msk, addr);
-	if (ret || force)
+	if (ret || force) {
+		spin_lock_bh(&msk->pm.lock);
 		mptcp_pm_remove_addr(msk, addr->id);
-	spin_unlock_bh(&msk->pm.lock);
+		spin_unlock_bh(&msk->pm.lock);
+	}
 	return ret;
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index db1e5de2fee7..5b21cb643dd3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -444,6 +444,8 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
+bool mptcp_pm_del_add_timer(struct mptcp_sock *msk,
+			    struct mptcp_addr_info *addr);
 =

 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
-- =

2.17.1

--===============3890481148223104394==--
