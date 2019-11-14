Content-Type: multipart/mixed; boundary="===============8119749076674544967=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 05/14] mptcp: add and use mptcp RTX flag
Date: Thu, 14 Nov 2019 18:32:16 +0100
Message-ID: <20191114173225.21199-6-fw@strlen.de>
In-Reply-To: 20191114173225.21199-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2533

--===============8119749076674544967==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is needed in the (unlikely) case that userspace is blocked in
mptcp_sendmsg because wmem is exhausted.

In that case, only the rtx work queue will clean the rtx backlog, but it
could take several milliseconds until it runs next.  So, allow it to get
scheduled as soon as possible so wmem can be reclaimed if the mptcp
socket sndbuf is exhausted.

Because such quick-schedule should not cause retransmits, add a flag
that indicates when the work queue has been scheduled on behalf of the
retransmit timer.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/options.c  |  2 +-
 net/mptcp/protocol.c | 26 ++++++++++++++++++++------
 net/mptcp/protocol.h |  3 ++-
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 9a18a3670cdf..035ac67541a0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -583,7 +583,7 @@ static void update_una(struct mptcp_sock *msk,
 		old_snd_una =3D atomic64_cmpxchg(&msk->snd_una, snd_una,
 					       new_snd_una);
 		if (old_snd_una =3D=3D snd_una) {
-			mptcp_reset_timer((struct sock *)msk);
+			mptcp_data_acked((struct sock *)msk);
 			break;
 		}
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a09ea93896c7..2144e80b8704 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -40,7 +40,7 @@ static bool mptcp_timer_pending(struct sock *sk)
 	return timer_pending(&inet_csk(sk)->icsk_retransmit_timer);
 }
 =

-void mptcp_reset_timer(struct sock *sk)
+static void mptcp_reset_timer(struct sock *sk)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
 	unsigned long tout;
@@ -52,6 +52,15 @@ void mptcp_reset_timer(struct sock *sk)
 	sk_reset_timer(sk, &icsk->icsk_retransmit_timer, jiffies + tout);
 }
 =

+void mptcp_data_acked(struct sock *sk)
+{
+	mptcp_reset_timer(sk);
+
+	if (!sk_stream_is_writeable(sk) &&
+	    schedule_work(&mptcp_sk(sk)->rtx_work))
+		sock_hold(sk);
+}
+
 static void mptcp_stop_timer(struct sock *sk)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
@@ -623,6 +632,7 @@ static void mptcp_retransmit_handler(struct sock *sk)
 	if (atomic64_read(&msk->snd_una) =3D=3D msk->write_seq) {
 		mptcp_stop_timer(sk);
 	} else {
+		set_bit(MPTCP_WORK_RTX, &msk->flags);
 		if (schedule_work(&msk->rtx_work))
 			sock_hold(sk);
 	}
@@ -647,7 +657,7 @@ static void mptcp_retransmit_timer(struct timer_list *t)
 	sock_put(sk);
 }
 =

-static void mptcp_retransmit(struct work_struct *work)
+static void mptcp_worker(struct work_struct *work)
 {
 	int orig_len, orig_offset, ret, mss_now =3D 0, size_goal =3D 0;
 	struct mptcp_data_frag *dfrag;
@@ -663,6 +673,10 @@ static void mptcp_retransmit(struct work_struct *work)
 =

 	lock_sock(sk);
 	mptcp_clean_una(sk);
+
+	if (!test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
+		goto unlock;
+
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag)
 		goto unlock;
@@ -715,7 +729,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
 =

-	INIT_WORK(&msk->rtx_work, mptcp_retransmit);
+	INIT_WORK(&msk->rtx_work, mptcp_worker);
 =

 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
@@ -755,7 +769,7 @@ static void __mptcp_clear_xmit(struct sock *sk)
 		dfrag_clear(sk, dfrag);
 }
 =

-static void mptcp_cancel_rtx_work(struct sock *sk)
+static void mptcp_cancel_work(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

@@ -792,7 +806,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 	__mptcp_clear_xmit(sk);
 	release_sock(sk);
 =

-	mptcp_cancel_rtx_work(sk);
+	mptcp_cancel_work(sk);
 =

 	sk_common_release(sk);
 }
@@ -802,7 +816,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	lock_sock(sk);
 	__mptcp_clear_xmit(sk);
 	release_sock(sk);
-	mptcp_cancel_rtx_work(sk);
+	mptcp_cancel_work(sk);
 	return tcp_disconnect(sk, flags);
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 63ff8bd8a098..6e23da8c5024 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -76,6 +76,7 @@
 =

 /* MPTCP socket flags */
 #define MPTCP_DATA_READY	BIT(0)
+#define MPTCP_WORK_RTX		BIT(1)
 =

 static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
 {
@@ -290,7 +291,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 =

 void mptcp_finish_connect(struct sock *sk, int mp_capable);
 void mptcp_finish_join(struct sock *sk);
-void mptcp_reset_timer(struct sock *sk);
+void mptcp_data_acked(struct sock *sk);
 =

 int mptcp_token_new_request(struct request_sock *req);
 void mptcp_token_destroy_request(u32 token);
-- =

2.23.0

--===============8119749076674544967==--
