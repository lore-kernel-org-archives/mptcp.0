Content-Type: multipart/mixed; boundary="===============5464693588478089543=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 3/3] mptcp: clean-up the rtx path.
Date: Tue, 09 Feb 2021 12:42:41 +0100
Message-ID: <0d386ad2007d7b0a151fe4a07dbf7f72ee39f85d.1612869198.git.pabeni@redhat.com>
In-Reply-To: cover.1612869198.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7704

--===============5464693588478089543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After the previous patch we can easily avoid invoking
the workqueue to perform the retransmission, if the
msk socket lock is held at rtx timer expiration.

This also simplifies the relevant code.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 42 +++++++++++-------------------------------
 net/mptcp/protocol.h |  1 +
 2 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0393cef5a08d8..646f91e1c792e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2038,28 +2038,21 @@ static int mptcp_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
 	return copied;
 }
 =

-static void mptcp_retransmit_handler(struct sock *sk)
-{
-	struct mptcp_sock *msk =3D mptcp_sk(sk);
-
-	set_bit(MPTCP_WORK_RTX, &msk->flags);
-	mptcp_schedule_work(sk);
-}
-
 static void mptcp_retransmit_timer(struct timer_list *t)
 {
 	struct inet_connection_sock *icsk =3D from_timer(icsk, t,
 						       icsk_retransmit_timer);
 	struct sock *sk =3D &icsk->icsk_inet.sk;
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

 	bh_lock_sock(sk);
 	if (!sock_owned_by_user(sk)) {
-		mptcp_retransmit_handler(sk);
+		/* we need a process context to retransmit */
+		if (!test_and_set_bit(MPTCP_WORK_RTX, &msk->flags))
+			mptcp_schedule_work(sk);
 	} else {
 		/* delegate our work to tcp_release_cb() */
-		if (!test_and_set_bit(TCP_WRITE_TIMER_DEFERRED,
-				      &sk->sk_tsq_flags))
-			sock_hold(sk);
+		set_bit(MPTCP_RETRANSMIT, &msk->flags);
 	}
 	bh_unlock_sock(sk);
 	sock_put(sk);
@@ -2935,17 +2928,16 @@ void __mptcp_check_push(struct sock *sk, struct soc=
k *ssk)
 	}
 }
 =

-#define MPTCP_DEFERRED_ALL (TCPF_WRITE_TIMER_DEFERRED)
-
 /* processes deferred events and flush wmem */
 static void mptcp_release_cb(struct sock *sk)
 {
-	unsigned long flags, nflags;
-
 	for (;;) {
-		flags =3D 0;
+		unsigned long flags =3D 0;
+
 		if (test_and_clear_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags))
 			flags |=3D MPTCP_PUSH_PENDING;
+		if (test_and_clear_bit(MPTCP_RETRANSMIT, &mptcp_sk(sk)->flags))
+			flags |=3D MPTCP_RETRANSMIT;
 		if (!flags)
 			break;
 =

@@ -2960,6 +2952,8 @@ static void mptcp_release_cb(struct sock *sk)
 		spin_unlock_bh(&sk->sk_lock.slock);
 		if (flags & MPTCP_PUSH_PENDING)
 			__mptcp_push_pending(sk, 0);
+		if (flags & MPTCP_RETRANSMIT)
+			__mptcp_retrans(sk);
 =

 		cond_resched();
 		spin_lock_bh(&sk->sk_lock.slock);
@@ -2975,20 +2969,6 @@ static void mptcp_release_cb(struct sock *sk)
 	 */
 	__mptcp_update_wmem(sk);
 	__mptcp_update_rmem(sk);
-
-	do {
-		flags =3D sk->sk_tsq_flags;
-		if (!(flags & MPTCP_DEFERRED_ALL))
-			return;
-		nflags =3D flags & ~MPTCP_DEFERRED_ALL;
-	} while (cmpxchg(&sk->sk_tsq_flags, flags, nflags) !=3D flags);
-
-	sock_release_ownership(sk);
-
-	if (flags & TCPF_WRITE_TIMER_DEFERRED) {
-		mptcp_retransmit_handler(sk);
-		__sock_put(sk);
-	}
 }
 =

 void mptcp_subflow_process_delegated(struct sock *ssk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 91827d9497669..9fc34f3479b75 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -103,6 +103,7 @@
 #define MPTCP_PUSH_PENDING	6
 #define MPTCP_CLEAN_UNA		7
 #define MPTCP_ERROR_REPORT	8
+#define MPTCP_RETRANSMIT	9
 =

 static inline bool before64(__u64 seq1, __u64 seq2)
 {
-- =

2.26.2

--===============5464693588478089543==--
