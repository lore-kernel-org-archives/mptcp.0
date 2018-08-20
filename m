Content-Type: multipart/mixed; boundary="===============3366669108657635294=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] mptcp: correct refcnt for sk in tcp_v{4, 6}_rcv
Date: Mon, 20 Aug 2018 08:52:18 -0700
Message-ID: <20180820155219.16681-2-cpaasch@apple.com>
In-Reply-To: 20180820155219.16681-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 703

--===============3366669108657635294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Gregory Detal <gregory.detal(a)tessares.net>

When we receive an skb in tcp_vX_rcv if the sock is hold by user we copy
the sk inside the skb before putting the skb inside the backlog, the sk
will be used after from mptcp_backlog_rcv. If the sk refcnt is not done
properly the sk read from mptcp_backlog_rcv could point to another sk
because it may have been freed and reused in the mean time.

In mptcp_backlog_rcv, the call to skb_oprhan will call the destructor
that we set for the skb and decrement the sk refcnt. Note that we call
skb_oprhan after the increase of sk_refcnt. This ensures that we never
free the sk too quickly.

Adaptation of commit 952bd28cc5be (mptcp: correct refcnt for sk in
tcp_v{4,6}_rcv) for mptcp_trunk.

Fixes: Zero-day-bug
Signed-off-by: Gregory Detal <gregory.detal(a)tessares.net>
Signed-off-by: Benjamin Hesmans <benjamin.hesmans(a)tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
(cherry picked from commit 2e4ce385ada1bd7c3b91145dcd67b95968fe7c3a)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/net/mptcp.h    |  2 ++
 net/ipv4/tcp_ipv4.c    |  2 +-
 net/ipv6/tcp_ipv6.c    |  2 +-
 net/mptcp/mptcp_ctrl.c | 18 ++++++++++++++++--
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 2b5418d808bf..62266a6e0223 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -831,6 +831,7 @@ void mptcp_sub_close_wq(struct work_struct *work);
 void mptcp_sub_close(struct sock *sk, unsigned long delay);
 struct sock *mptcp_select_ack_sock(const struct sock *meta_sk);
 void mptcp_fallback_meta_sk(struct sock *meta_sk);
+void mptcp_prepare_for_backlog(struct sock *sk, struct sk_buff *skb);
 int mptcp_backlog_rcv(struct sock *meta_sk, struct sk_buff *skb);
 void mptcp_ack_handler(struct timer_list *t);
 bool mptcp_check_rtt(const struct tcp_sock *tp, int time);
@@ -1408,6 +1409,7 @@ static inline bool mptcp_fallback_infinite(const stru=
ct sock *sk, int flag)
 	return false;
 }
 static inline void mptcp_init_mp_opt(const struct mptcp_options_received *=
mopt) {}
+static inline void mptcp_prepare_for_backlog(struct sock *sk, struct sk_bu=
ff *skb) {}
 static inline bool mptcp_check_rtt(const struct tcp_sock *tp, int time)
 {
 	return false;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 12c577d170f3..e6b1e256eb12 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1906,7 +1906,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 =

 		bh_lock_sock_nested(meta_sk);
 		if (sock_owned_by_user(meta_sk))
-			skb->sk =3D sk;
+			mptcp_prepare_for_backlog(sk, skb);
 	} else {
 		meta_sk =3D sk;
 		bh_lock_sock_nested(sk);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 95614a2f6e25..b051b60e345a 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1650,7 +1650,7 @@ static int tcp_v6_rcv(struct sk_buff *skb)
 =

 		bh_lock_sock_nested(meta_sk);
 		if (sock_owned_by_user(meta_sk))
-			skb->sk =3D sk;
+			mptcp_prepare_for_backlog(sk, skb);
 	} else {
 		meta_sk =3D sk;
 		bh_lock_sock_nested(sk);
diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index f5d46c688279..1e7b38911083 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -984,6 +984,16 @@ static void mptcp_sub_inherit_sockopts(const struct so=
ck *meta_sk, struct sock *
 	inet_sk(sub_sk)->recverr =3D 0;
 }
 =

+void mptcp_prepare_for_backlog(struct sock *sk, struct sk_buff *skb)
+{
+	/* In case of success (in mptcp_backlog_rcv) and error (in kfree_skb) of
+	 * sk_add_backlog, we will decrement the sk refcount.
+	 */
+	sock_hold(sk);
+	skb->sk =3D sk;
+	skb->destructor =3D sock_efree;
+}
+
 int mptcp_backlog_rcv(struct sock *meta_sk, struct sk_buff *skb)
 {
 	/* skb-sk may be NULL if we receive a packet immediatly after the
@@ -992,13 +1002,17 @@ int mptcp_backlog_rcv(struct sock *meta_sk, struct s=
k_buff *skb)
 	struct sock *sk =3D skb->sk ? skb->sk : meta_sk;
 	int ret =3D 0;
 =

-	skb->sk =3D NULL;
-
 	if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt))) {
 		kfree_skb(skb);
 		return 0;
 	}
 =

+	/* Decrement sk refcnt when calling the skb destructor.
+	 * Refcnt is incremented and skb destructor is set in tcp_v{4,6}_rcv via
+	 * mptcp_prepare_for_backlog() here above.
+	 */
+	skb_orphan(skb);
+
 	if (sk->sk_family =3D=3D AF_INET)
 		ret =3D tcp_v4_do_rcv(sk, skb);
 #if IS_ENABLED(CONFIG_IPV6)
-- =

2.16.2


--===============3366669108657635294==--
