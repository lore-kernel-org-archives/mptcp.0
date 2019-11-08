Content-Type: multipart/mixed; boundary="===============7283460991072725549=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 5/6] mptcp: add ack work queue
Date: Fri, 08 Nov 2019 23:09:52 +0100
Message-ID: <20191108220953.30904-6-fw@strlen.de>
In-Reply-To: 20191108220953.30904-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2454

--===============7283460991072725549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is needed in the (unlikely) case that userspace is blocked in
mptcp_sendmsg because wmem is exhausted.

In that case, only the rtx work queue will clean the rtx backlog, but it
could take several milliseconds until it runs next, so add a dedicated
work queue that will run as soon as possible.

We can avoid scheduling the work if the mptcp socket is writeable, next
send/recv call will also clean acked dfrags.

An alternative approach is to add a new mptcp flag and re-use the
existing retrans worker, let me know if this is the preferred solution.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/options.c  |  2 +-
 net/mptcp/protocol.c | 35 +++++++++++++++++++++++++++++++----
 net/mptcp/protocol.h |  3 ++-
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b488bf07ada5..81d7c3c026c8 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -590,7 +590,7 @@ static void update_una(struct mptcp_sock *msk,
 		old_snd_una =3D atomic64_cmpxchg(&msk->snd_una, snd_una,
 					       new_snd_una);
 		if (old_snd_una =3D=3D snd_una) {
-			mptcp_reset_timer((struct sock *)msk);
+			mptcp_data_acked((struct sock *)msk);
 			break;
 		}
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b93050056195..5c6948085ef4 100644
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
+	    schedule_work(&mptcp_sk(sk)->ack_work))
+		sock_hold(sk);
+}
+
 static void mptcp_stop_timer(struct sock *sk)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
@@ -647,6 +656,21 @@ static void mptcp_retransmit_timer(struct timer_list *=
t)
 	sock_put(sk);
 }
 =

+static void mptcp_ack_work(struct work_struct *work)
+{
+	struct mptcp_sock *msk;
+	struct sock *sk;
+
+	msk =3D container_of(work, struct mptcp_sock, ack_work);
+	sk =3D &msk->sk.icsk_inet.sk;
+
+	lock_sock(sk);
+	mptcp_clean_una(sk);
+	release_sock(sk);
+
+	sock_put(sk);
+}
+
 static void mptcp_retransmit(struct work_struct *work)
 {
 	int orig_len, orig_offset, ret, mss_now =3D 0, size_goal =3D 0;
@@ -716,6 +740,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->rtx_queue);
 =

 	INIT_WORK(&msk->rtx_work, mptcp_retransmit);
+	INIT_WORK(&msk->ack_work, mptcp_ack_work);
 =

 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
@@ -755,12 +780,14 @@ static void __mptcp_clear_xmit(struct sock *sk)
 		dfrag_clear(sk, dfrag);
 }
 =

-static void mptcp_cancel_rtx_work(struct sock *sk)
+static void mptcp_cancel_work(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

 	if (cancel_work_sync(&msk->rtx_work))
 		sock_put(sk);
+	if (cancel_work_sync(&msk->ack_work))
+		sock_put(sk);
 }
 =

 static void mptcp_close(struct sock *sk, long timeout)
@@ -792,7 +819,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 	__mptcp_clear_xmit(sk);
 	release_sock(sk);
 =

-	mptcp_cancel_rtx_work(sk);
+	mptcp_cancel_work(sk);
 =

 	sk_common_release(sk);
 }
@@ -802,7 +829,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	lock_sock(sk);
 	__mptcp_clear_xmit(sk);
 	release_sock(sk);
-	mptcp_cancel_rtx_work(sk);
+	mptcp_cancel_work(sk);
 	return tcp_disconnect(sk, flags);
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bc7e8fa54afa..aeda56466219 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -134,6 +134,7 @@ struct mptcp_sock {
 	unsigned long	flags;
 	u16		dport;
 	struct work_struct rtx_work;
+	struct work_struct ack_work;
 	struct list_head conn_list;
 	struct list_head rtx_queue;
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
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

--===============7283460991072725549==--
