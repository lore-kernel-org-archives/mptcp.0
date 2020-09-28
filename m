Content-Type: multipart/mixed; boundary="===============7146611552950504540=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 2/9] mptcp: introduce mptcp_schedule_work
Date: Mon, 28 Sep 2020 17:04:54 +0200
Message-ID: <042b1db85817a551e4eded66b1ef7a898602f666.1601304622.git.pabeni@redhat.com>
In-Reply-To: cover.1601304622.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6076

--===============7146611552950504540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

remove some of code duplications an allow preventing
rescheduling on close.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/pm.c       |  4 +---
 net/mptcp/protocol.c | 33 +++++++++++++++++++--------------
 net/mptcp/protocol.h |  1 +
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 7e81f53d1e5d..fa4d8391b385 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -89,9 +89,7 @@ static bool mptcp_pm_schedule_work(struct mptcp_sock *msk,
 		return false;
 =

 	msk->pm.status |=3D BIT(new_status);
-	if (schedule_work(&msk->work))
-		sock_hold((struct sock *)msk);
-	return true;
+	return mptcp_schedule_work((struct sock *)msk);
 }
 =

 void mptcp_pm_fully_established(struct mptcp_sock *msk)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6677461efc85..efa8589a1c7d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -601,9 +601,8 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, st=
ruct sock *ssk)
 		 * this is not a good place to change state. Let the workqueue
 		 * do it.
 		 */
-		if (mptcp_pending_data_fin(sk, NULL) &&
-		    schedule_work(&msk->work))
-			sock_hold(sk);
+		if (mptcp_pending_data_fin(sk, NULL))
+			mptcp_schedule_work(sk);
 	}
 =

 	spin_unlock_bh(&sk->sk_lock.slock);
@@ -680,23 +679,29 @@ static void mptcp_reset_timer(struct sock *sk)
 	sk_reset_timer(sk, &icsk->icsk_retransmit_timer, jiffies + tout);
 }
 =

+bool mptcp_schedule_work(struct sock *sk)
+{
+	if (inet_sk_state_load(sk) !=3D TCP_CLOSE &&
+	   schedule_work(&mptcp_sk(sk)->work)) {
+		sock_hold(sk);
+		return true;
+	}
+	return false;
+}
+
 void mptcp_data_acked(struct sock *sk)
 {
 	mptcp_reset_timer(sk);
 =

 	if ((!test_bit(MPTCP_SEND_SPACE, &mptcp_sk(sk)->flags) ||
-	     (inet_sk_state_load(sk) !=3D TCP_ESTABLISHED)) &&
-	    schedule_work(&mptcp_sk(sk)->work))
-		sock_hold(sk);
+	     (inet_sk_state_load(sk) !=3D TCP_ESTABLISHED)))
+		mptcp_schedule_work(sk);
 }
 =

 void mptcp_subflow_eof(struct sock *sk)
 {
-	struct mptcp_sock *msk =3D mptcp_sk(sk);
-
-	if (!test_and_set_bit(MPTCP_WORK_EOF, &msk->flags) &&
-	    schedule_work(&msk->work))
-		sock_hold(sk);
+	if (!test_and_set_bit(MPTCP_WORK_EOF, &mptcp_sk(sk)->flags))
+		mptcp_schedule_work(sk);
 }
 =

 static void mptcp_check_for_eof(struct mptcp_sock *msk)
@@ -1610,8 +1615,7 @@ static void mptcp_retransmit_handler(struct sock *sk)
 		mptcp_stop_timer(sk);
 	} else {
 		set_bit(MPTCP_WORK_RTX, &msk->flags);
-		if (schedule_work(&msk->work))
-			sock_hold(sk);
+		mptcp_schedule_work(sk);
 	}
 }
 =

@@ -2312,7 +2316,8 @@ static void mptcp_release_cb(struct sock *sk)
 		struct sock *ssk;
 =

 		ssk =3D mptcp_subflow_recv_lookup(msk);
-		if (!ssk || !schedule_work(&msk->work))
+		if (!ssk || sk->sk_state =3D=3D TCP_CLOSE ||
+		    !schedule_work(&msk->work))
 			__sock_put(sk);
 	}
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7cfe52aeb2b8..d16b5fcaa9a8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -405,6 +405,7 @@ static inline bool mptcp_is_fully_established(struct so=
ck *sk)
 void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk);
 void mptcp_data_ready(struct sock *sk, struct sock *ssk);
 bool mptcp_finish_join(struct sock *sk);
+bool mptcp_schedule_work(struct sock *sk);
 void mptcp_data_acked(struct sock *sk);
 void mptcp_subflow_eof(struct sock *sk);
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq);
-- =

2.26.2

--===============7146611552950504540==--
