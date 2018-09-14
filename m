Content-Type: multipart/mixed; boundary="===============0094701663646927037=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 20/20] mptcp: Use spin_lock_bh where appropriate for
 mpcb_list_lock
Date: Fri, 14 Sep 2018 10:25:24 -0700
Message-ID: <20180914172524.67961-23-cpaasch@apple.com>
In-Reply-To: 20180914172524.67961-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 744

--===============0094701663646927037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp_add_sock/mptcp_del_sock can both be called from user- and
bh-context. Thus, we need to do a spin_lock_bh().

Fixes: 7a662b690069 ("mptcp: Make subflow-list an RCU-list")
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit c45c9521f503d8dcaac3f3ac5bc4628d83079891)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/mptcp_ctrl.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index ced1191d50d1..626ccedd0878 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -1399,11 +1399,9 @@ int mptcp_add_sock(struct sock *meta_sk, struct sock=
 *sk, u8 loc_id, u8 rem_id,
 	sock_hold(meta_sk);
 	refcount_inc(&mpcb->mpcb_refcnt);
 =

-	local_bh_disable();
-	spin_lock(&mpcb->mpcb_list_lock);
+	spin_lock_bh(&mpcb->mpcb_list_lock);
 	hlist_add_head_rcu(&tp->mptcp->node, &mpcb->conn_list);
-	spin_unlock(&mpcb->mpcb_list_lock);
-	local_bh_enable();
+	spin_unlock_bh(&mpcb->mpcb_list_lock);
 =

 	tp->mptcp->attached =3D 1;
 =

@@ -1463,9 +1461,9 @@ void mptcp_del_sock(struct sock *sk)
 		    __func__, mpcb->mptcp_loc_token, tp->mptcp->path_index,
 		    sk->sk_state, is_meta_sk(sk));
 =

-	spin_lock(&mpcb->mpcb_list_lock);
+	spin_lock_bh(&mpcb->mpcb_list_lock);
 	hlist_del_init_rcu(&tp->mptcp->node);
-	spin_unlock(&mpcb->mpcb_list_lock);
+	spin_unlock_bh(&mpcb->mpcb_list_lock);
 =

 	tp->mptcp->attached =3D 0;
 	mpcb->path_index_bits &=3D ~(1 << tp->mptcp->path_index);
-- =

2.16.2


--===============0094701663646927037==--
