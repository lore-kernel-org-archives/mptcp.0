Content-Type: multipart/mixed; boundary="===============1398079905715350634=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 4/7] mptcp: introduce MPTCP retransmission timer
Date: Fri, 30 Aug 2019 17:03:59 +0200
Message-ID: <95a096bea0b4450955443b2fe32dd73a1bad0ecc.1567177394.git.pabeni@redhat.com>
In-Reply-To: cover.1567177393.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1775

--===============1398079905715350634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The timer will be used to schedule retransmission. It's
frequency is based on the current subflow RTO estimation and
is reset on every una_seq update

The timer is clearer for good by __mptcp_clear_xmit()

Also clean MPTCP rtx queue before each transmission

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
rfc v2 -> v1:
 - don't update anymore una_seq inside the timer
 - reset timer from mptcp_incoming_options() context
 - update and store the timer interval at each sendmsg()
   call
 - added new timer pending helper
 - plug refcnt leak in mptcp_retransmit_timer()
 - really use the mptcp release cb

rfc v1 -> rfc v2:
 - protect against wrap-around while cleaning-up dfrags in
   mptcp_update_msk_una()
---
 net/mptcp/options.c  |   3 +-
 net/mptcp/protocol.c | 100 +++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |   2 +
 3 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 854dc050c1da..ebb9d3dd7a6a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -541,7 +541,8 @@ static u64 expand_ack(u64 old_ack, u64 cur_ack, bool us=
e_64bit)
 =

 void update_una(struct mptcp_sock *msk, u64 old_una, u64 new_una)
 {
-	atomic64_cmpxchg(&msk->snd_una, old_una, new_una);
+	if (atomic64_cmpxchg(&msk->snd_una, old_una, new_una) =3D=3D old_una)
+		mptcp_reset_timer((struct sock *)msk);
 }
 =

 void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2f5125961333..2e294e043c0b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -17,6 +17,41 @@
 #include <net/mptcp.h>
 #include "protocol.h"
 =

+static void mptcp_set_timeout(const struct sock *sk, const struct sock *ss=
k)
+{
+	unsigned long tout =3D ssk && inet_csk(ssk)->icsk_pending ?
+			     inet_csk(ssk)->icsk_timeout - jiffies : 0;
+
+	if (tout <=3D 0)
+		tout =3D mptcp_sk(sk)->timer_ival;
+	mptcp_sk(sk)->timer_ival =3D  tout > 0 ? tout : TCP_RTO_MIN;
+}
+
+bool mptcp_timer_pending(struct sock *sk)
+{
+	return timer_pending(&inet_csk(sk)->icsk_retransmit_timer);
+}
+
+void mptcp_reset_timer(struct sock *sk)
+{
+	struct inet_connection_sock *icsk =3D inet_csk(sk);
+	unsigned long tout;
+
+	/* should never be called with mptcp level timer cleared */
+	tout =3D READ_ONCE(mptcp_sk(sk)->timer_ival);
+	if (WARN_ON_ONCE(!tout))
+		tout =3D TCP_RTO_MIN;
+	sk_reset_timer(sk, &icsk->icsk_retransmit_timer, jiffies + tout);
+}
+
+static void mptcp_stop_timer(struct sock *sk)
+{
+	struct inet_connection_sock *icsk =3D inet_csk(sk);
+
+	sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
+	mptcp_sk(sk)->timer_ival =3D 0;
+}
+
 static struct socket *__mptcp_fallback_get_ref(const struct mptcp_sock *ms=
k)
 {
 	sock_owned_by_me((const struct sock *)msk);
@@ -307,10 +342,16 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 =

 		copied +=3D ret;
 	}
+
+	mptcp_set_timeout(sk, ssk);
 	if (copied) {
 		ret =3D copied;
 		tcp_push(ssk, msg->msg_flags, mss_now, tcp_sk(ssk)->nonagle,
 			 size_goal);
+
+		/* start the timer, if it's not pending */
+		if (!mptcp_timer_pending(sk))
+			mptcp_reset_timer(sk);
 	}
 =

 	release_sock(ssk);
@@ -690,6 +731,35 @@ static int mptcp_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 	return copied;
 }
 =

+static void mptcp_retransmit_handler(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	if (atomic64_read(&msk->snd_una) =3D=3D msk->write_seq)
+		mptcp_stop_timer(sk);
+	else
+		mptcp_reset_timer(sk);
+}
+
+static void mptcp_retransmit_timer(struct timer_list *t)
+{
+	struct inet_connection_sock *icsk =3D from_timer(icsk, t,
+						       icsk_retransmit_timer);
+	struct sock *sk =3D &icsk->icsk_inet.sk;
+
+	bh_lock_sock(sk);
+	if (!sock_owned_by_user(sk)) {
+		mptcp_retransmit_handler(sk);
+	} else {
+		/* delegate our work to tcp_release_cb() */
+		if (!test_and_set_bit(TCP_WRITE_TIMER_DEFERRED,
+				      &sk->sk_tsq_flags))
+			sock_hold(sk);
+	}
+	bh_unlock_sock(sk);
+	sock_put(sk);
+}
+
 static int __mptcp_init_sock(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -699,6 +769,9 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
 =

+	/* re-use the csk retrans timer for MPTCP-level retrans */
+	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
+
 	return 0;
 }
 =

@@ -720,6 +793,8 @@ static void __mptcp_clear_xmit(struct sock *sk)
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_data_frag *dtmp, *dfrag;
 =

+	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
+
 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list)
 		dfrag_clear(dfrag);
 }
@@ -898,6 +973,30 @@ static int mptcp_getsockopt(struct sock *sk, int level=
, int optname,
 	return 0;
 }
 =

+#define MPTCP_DEFERRED_ALL TCPF_WRITE_TIMER_DEFERRED
+
+/* this is very alike tcp_release_cb() but we must handle differently a
+ * different set of events
+ */
+static void mptcp_release_cb(struct sock *sk)
+{
+	unsigned long flags, nflags;
+
+	do {
+		flags =3D sk->sk_tsq_flags;
+		if (!(flags & MPTCP_DEFERRED_ALL))
+			return;
+		nflags =3D flags & ~MPTCP_DEFERRED_ALL;
+	} while (cmpxchg(&sk->sk_tsq_flags, flags, nflags) !=3D flags);
+
+	sock_release_ownership(sk);
+
+	if (flags & TCPF_WRITE_TIMER_DEFERRED) {
+		mptcp_retransmit_handler(sk);
+		__sock_put(sk);
+	}
+}
+
 static int mptcp_get_port(struct sock *sk, unsigned short snum)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -998,6 +1097,7 @@ static struct proto mptcp_prot =3D {
 	.destroy	=3D mptcp_destroy,
 	.sendmsg	=3D mptcp_sendmsg,
 	.recvmsg	=3D mptcp_recvmsg,
+	.release_cb	=3D mptcp_release_cb,
 	.hash		=3D inet_hash,
 	.unhash		=3D inet_unhash,
 	.get_port	=3D mptcp_get_port,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2d19d534ff9f..a14fdc161813 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -129,6 +129,7 @@ struct mptcp_sock {
 	u64		write_seq;
 	u64		ack_seq;
 	atomic64_t	snd_una;
+	unsigned long	timer_ival;
 	u32		token;
 	unsigned long	flags;
 	u16		dport;
@@ -249,6 +250,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 =

 void mptcp_finish_connect(struct sock *sk, int mp_capable);
 void mptcp_finish_join(struct sock *sk);
+void mptcp_reset_timer(struct sock *sk);
 =

 void token_init(void);
 void token_new_request(struct request_sock *req, const struct sk_buff *skb=
);
-- =

2.21.0


--===============1398079905715350634==--
