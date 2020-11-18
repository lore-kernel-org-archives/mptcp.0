Content-Type: multipart/mixed; boundary="===============1673366442221185228=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] mptcp: drop CANCEL_WORK status bit
Date: Wed, 18 Nov 2020 17:47:26 +0100
Message-ID: <71b1537ee313ad6a9338b676d09b727e03b49d4c.1605717967.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6780

--===============1673366442221185228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only mptcp_close() can actually cancel the workqueue,
no need to add and use this flag.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
Note: this one should land on the bottom of export branch, =

just on top of net-next branch
---
 net/mptcp/protocol.c | 8 +-------
 net/mptcp/protocol.h | 1 -
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3908a6445321..7fccccb9d9a5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1878,7 +1878,6 @@ static void mptcp_worker(struct work_struct *work)
 	int state, ret;
 =

 	lock_sock(sk);
-	set_bit(MPTCP_WORKER_RUNNING, &msk->flags);
 	state =3D sk->sk_state;
 	if (unlikely(state =3D=3D TCP_CLOSE))
 		goto unlock;
@@ -1955,7 +1954,6 @@ static void mptcp_worker(struct work_struct *work)
 		mptcp_reset_timer(sk);
 =

 unlock:
-	clear_bit(MPTCP_WORKER_RUNNING, &msk->flags);
 	release_sock(sk);
 	sock_put(sk);
 }
@@ -2031,11 +2029,7 @@ static void mptcp_cancel_work(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-	/* if called by the work itself, do not try to cancel the work, or
-	 * we will hang.
-	 */
-	if (!test_bit(MPTCP_WORKER_RUNNING, &msk->flags) &&
-	    cancel_work_sync(&msk->work))
+	if (cancel_work_sync(&msk->work))
 		__sock_put(sk);
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 07542f7b349a..82d5626323b1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -91,7 +91,6 @@
 #define MPTCP_WORK_EOF		3
 #define MPTCP_FALLBACK_DONE	4
 #define MPTCP_WORK_CLOSE_SUBFLOW 5
-#define MPTCP_WORKER_RUNNING	6
 =

 static inline bool before64(__u64 seq1, __u64 seq2)
 {
-- =

2.26.2

--===============1673366442221185228==--
