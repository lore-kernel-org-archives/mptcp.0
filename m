Content-Type: multipart/mixed; boundary="===============2878505584718199731=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 09/20] mptcp: Rename tw_lock to mpcb_list_lock
Date: Fri, 14 Sep 2018 10:25:13 -0700
Message-ID: <20180914172524.67961-12-cpaasch@apple.com>
In-Reply-To: 20180914172524.67961-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 729

--===============2878505584718199731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The lock is going to cover more than just the tw-list.
Namely, the subflow-list stored in the mpcb.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit 411ffb5c2b2a42d578f11b800c97f23db1cb77ee)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/net/mptcp.h    |  4 +++-
 net/mptcp/mptcp_ctrl.c | 14 +++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 3e6626fdfbd5..c96da5e30d51 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -258,6 +258,9 @@ struct mptcp_cb {
 	/* list of sockets that need a call to release_cb */
 	struct hlist_head callback_list;
 =

+	/* Lock used for protecting the different rcu-lists of mptcp_cb */
+	spinlock_t mpcb_list_lock;
+
 	/* High-order bits of 64-bit sequence numbers */
 	u32 snd_high_order[2];
 	u32 rcv_high_order[2];
@@ -289,7 +292,6 @@ struct mptcp_cb {
 	u64	infinite_rcv_seq;
 =

 	/***** Start of fields, used for connection closure */
-	spinlock_t	 tw_lock;
 	unsigned char	 mptw_state;
 	u8		 dfin_path_index;
 =

diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index 8db7c5bea1b4..ce098de43145 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -673,14 +673,14 @@ void mptcp_sock_destruct(struct sock *sk)
 		 * update to the rcv_nxt of the time-wait-sock and remove
 		 * its reference to the mpcb.
 		 */
-		spin_lock_bh(&mpcb->tw_lock);
+		spin_lock_bh(&mpcb->mpcb_list_lock);
 		list_for_each_entry_rcu(mptw, &mpcb->tw_list, list) {
 			list_del_rcu(&mptw->list);
 			mptw->in_list =3D 0;
 			mptcp_mpcb_put(mpcb);
 			rcu_assign_pointer(mptw->mpcb, NULL);
 		}
-		spin_unlock_bh(&mpcb->tw_lock);
+		spin_unlock_bh(&mpcb->mpcb_list_lock);
 =

 		mptcp_debug("%s destroying meta-sk token %#x\n", __func__,
 			    tcp_sk(sk)->mpcb->mptcp_loc_token);
@@ -1301,9 +1301,9 @@ static int mptcp_alloc_mpcb(struct sock *meta_sk, __u=
64 remote_key,
 =

 	/* Init time-wait stuff */
 	INIT_LIST_HEAD(&mpcb->tw_list);
-	spin_lock_init(&mpcb->tw_lock);
 =

 	INIT_HLIST_HEAD(&mpcb->callback_list);
+	spin_lock_init(&mpcb->mpcb_list_lock);
 =

 	mptcp_mpcb_inherit_sockopts(meta_sk, master_sk);
 =

@@ -2276,10 +2276,10 @@ int mptcp_init_tw_sock(struct sock *sk, struct tcp_=
timewait_sock *tw)
 		mptw->rcv_nxt++;
 	rcu_assign_pointer(mptw->mpcb, mpcb);
 =

-	spin_lock_bh(&mpcb->tw_lock);
+	spin_lock_bh(&mpcb->mpcb_list_lock);
 	list_add_rcu(&mptw->list, &tp->mpcb->tw_list);
 	mptw->in_list =3D 1;
-	spin_unlock_bh(&mpcb->tw_lock);
+	spin_unlock_bh(&mpcb->mpcb_list_lock);
 =

 	return 0;
 }
@@ -2295,12 +2295,12 @@ void mptcp_twsk_destructor(struct tcp_timewait_sock=
 *tw)
 	 * from the list and drop the ref properly.
 	 */
 	if (mpcb && refcount_inc_not_zero(&mpcb->mpcb_refcnt)) {
-		spin_lock_bh(&mpcb->tw_lock);
+		spin_lock_bh(&mpcb->mpcb_list_lock);
 		if (tw->mptcp_tw->in_list) {
 			list_del_rcu(&tw->mptcp_tw->list);
 			tw->mptcp_tw->in_list =3D 0;
 		}
-		spin_unlock_bh(&mpcb->tw_lock);
+		spin_unlock_bh(&mpcb->mpcb_list_lock);
 =

 		/* Twice, because we increased it above */
 		mptcp_mpcb_put(mpcb);
-- =

2.16.2


--===============2878505584718199731==--
