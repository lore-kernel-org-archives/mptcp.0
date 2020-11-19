Content-Type: multipart/mixed; boundary="===============6406071576994939734=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 01/10] mptcp: drop WORKER_RUNNING status bit
Date: Thu, 19 Nov 2020 11:45:54 -0800
Message-ID: <20201119194603.103158-2-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201119194603.103158-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6839

--===============6406071576994939734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

Only mptcp_close() can actually cancel the workqueue,
no need to add and use this flag.

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 8 +-------
 net/mptcp/protocol.h | 1 -
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8df013daea88..749c00fffff5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1861,7 +1861,6 @@ static void mptcp_worker(struct work_struct *work)
 	int state, ret;
 =

 	lock_sock(sk);
-	set_bit(MPTCP_WORKER_RUNNING, &msk->flags);
 	state =3D sk->sk_state;
 	if (unlikely(state =3D=3D TCP_CLOSE))
 		goto unlock;
@@ -1939,7 +1938,6 @@ static void mptcp_worker(struct work_struct *work)
 		mptcp_reset_timer(sk);
 =

 unlock:
-	clear_bit(MPTCP_WORKER_RUNNING, &msk->flags);
 	release_sock(sk);
 	sock_put(sk);
 }
@@ -2010,11 +2008,7 @@ static void mptcp_cancel_work(struct sock *sk)
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
index b4c8dbe9236b..10fffc5de9e4 100644
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

2.29.2

--===============6406071576994939734==--
