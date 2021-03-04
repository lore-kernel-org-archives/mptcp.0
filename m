Content-Type: multipart/mixed; boundary="===============7012881888732140977=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 7/9] mptcp: fix race in release_cb
Date: Thu, 04 Mar 2021 13:32:14 -0800
Message-ID: <20210304213216.205472-8-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210304213216.205472-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8036

--===============7012881888732140977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

If we receive a MPTCP_PUSH_PENDING even from a subflow when
mptcp_release_cb() is serving the previous one, the latter
will be delayed up to the next release_sock(msk).

Address the issue implementing a test/serve loop for such
event.

Additionally rename the push helper to __mptcp_push_pending()
to be more consistent with the existing code.

Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 67aaf7154dca..d2a2169e6d9e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1445,7 +1445,7 @@ static void mptcp_push_release(struct sock *sk, struc=
t sock *ssk,
 	release_sock(ssk);
 }
 =

-static void mptcp_push_pending(struct sock *sk, unsigned int flags)
+static void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct sock *prev_ssk =3D NULL, *ssk =3D NULL;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -1697,14 +1697,14 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
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
@@ -2959,13 +2959,14 @@ static void mptcp_release_cb(struct sock *sk)
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
@@ -2974,13 +2975,21 @@ static void mptcp_release_cb(struct sock *sk)
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

2.30.1

--===============7012881888732140977==--
