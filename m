Content-Type: multipart/mixed; boundary="===============4618383585715613354=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 2/3] mptcp: fix race in release_cb
Date: Tue, 09 Feb 2021 12:42:40 +0100
Message-ID: <45298408838519faf5eb1ca8e39593c3a5d4bac9.1612869198.git.pabeni@redhat.com>
In-Reply-To: cover.1612869198.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7703

--===============4618383585715613354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If we receive a MPTCP_PUSH_PENDING even from a subflow when
mptcp_release_cb() is serving the previous one, the latter
will be delayed up to the next release_sock(msk).

Address the issue implementing a test/serve loop for such
event.

Additionally rename the push helper to __mptcp_push_pending()
to be more consistent with the existing code.

Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7e5016903e11c..0393cef5a08d8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1442,7 +1442,7 @@ static void mptcp_push_release(struct sock *sk, struc=
t sock *ssk,
 	release_sock(ssk);
 }
 =

-static void mptcp_push_pending(struct sock *sk, unsigned int flags)
+static void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct sock *prev_ssk =3D NULL, *ssk =3D NULL;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -1694,14 +1694,14 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
 =

 wait_for_memory:
 		mptcp_set_nospace(sk);
-		mptcp_push_pending(sk, msg->msg_flags);
+		__mptcp_push_pending(sk, msg->msg_flags);
 		ret =3D sk_stream_wait_memory(sk, &timeo);
 		if (ret)
 			goto out;
 	}
 =

 	if (copied)
-		mptcp_push_pending(sk, msg->msg_flags);
+		__mptcp_push_pending(sk, msg->msg_flags);
 =

 out:
 	release_sock(sk);
@@ -2942,13 +2942,14 @@ static void mptcp_release_cb(struct sock *sk)
 {
 	unsigned long flags, nflags;
 =

-	/* push_pending may touch wmem_reserved, do it before the later
-	 * cleanup
-	 */
-	if (test_and_clear_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->flags))
-		__mptcp_clean_una(sk);
-	if (test_and_clear_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags)) {
-		/* mptcp_push_pending() acquires the subflow socket lock
+	for (;;) {
+		flags =3D 0;
+		if (test_and_clear_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags))
+			flags |=3D MPTCP_PUSH_PENDING;
+		if (!flags)
+			break;
+
+		/* the following actions acquire the subflow socket lock
 		 *
 		 * 1) can't be invoked in atomic scope
 		 * 2) must avoid ABBA deadlock with msk socket spinlock: the RX
@@ -2957,13 +2958,21 @@ static void mptcp_release_cb(struct sock *sk)
 		 */
 =

 		spin_unlock_bh(&sk->sk_lock.slock);
-		mptcp_push_pending(sk, 0);
+		if (flags & MPTCP_PUSH_PENDING)
+			__mptcp_push_pending(sk, 0);
+
+		cond_resched();
 		spin_lock_bh(&sk->sk_lock.slock);
 	}
+
+	if (test_and_clear_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->flags))
+		__mptcp_clean_una(sk);
 	if (test_and_clear_bit(MPTCP_ERROR_REPORT, &mptcp_sk(sk)->flags))
 		__mptcp_error_report(sk);
 =

-	/* clear any wmem reservation and errors */
+	/* push_pending may touch wmem_reserved, ensure we do the cleanup
+	 * later
+	 */
 	__mptcp_update_wmem(sk);
 	__mptcp_update_rmem(sk);
 =

-- =

2.26.2

--===============4618383585715613354==--
