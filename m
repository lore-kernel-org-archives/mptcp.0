Content-Type: multipart/mixed; boundary="===============2217780105383341094=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 7/7] mptcp: defer work schedule until
 mptcp lock is released
Date: Tue, 25 Feb 2020 18:16:59 +0100
Message-ID: <20200225171659.4807-8-fw@strlen.de>
In-Reply-To: 20200225171659.4807-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3799

--===============2217780105383341094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

Don't schedule the work queue right away, instead defer this
to the lock release callback.

This has the advantage that it will give recv path a chance to
complete -- this might have moved all pending packets from the
subflow to the mptcp receive queue, which allows to avoid the
schedule_work().

Co-developed-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 70f20c8eddbd..044295707bbf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -238,9 +238,16 @@ void mptcp_data_ready(struct sock *sk, struct sock *ss=
k)
 	if (atomic_read(&sk->sk_rmem_alloc) > READ_ONCE(sk->sk_rcvbuf))
 		goto wake;
 =

-	if (schedule_work(&msk->work))
-		sock_hold((struct sock *)msk);
+	/* mptcp socket is owned, release_cb should retry */
+	if (!test_and_set_bit(TCP_DELACK_TIMER_DEFERRED,
+			      &sk->sk_tsq_flags)) {
+		sock_hold(sk);
 =

+		/* need to try again, its possible release_cb() has already
+		 * been called after the test_and_set_bit() above.
+		 */
+		move_skbs_to_msk(msk, ssk);
+	}
 wake:
 	sk->sk_data_ready(sk);
 }
@@ -941,6 +948,32 @@ static int mptcp_getsockopt(struct sock *sk, int level=
, int optname,
 	return -EOPNOTSUPP;
 }
 =

+#define MPTCP_DEFERRED_ALL TCPF_DELACK_TIMER_DEFERRED
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
+	if (flags & TCPF_DELACK_TIMER_DEFERRED) {
+		struct mptcp_sock *msk =3D mptcp_sk(sk);
+		struct sock *ssk;
+
+		ssk =3D mptcp_subflow_recv_lookup(msk);
+		if (!ssk || !schedule_work(&msk->work))
+			__sock_put(sk);
+	}
+}
+
 static int mptcp_get_port(struct sock *sk, unsigned short snum)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -1016,6 +1049,7 @@ static struct proto mptcp_prot =3D {
 	.destroy	=3D mptcp_destroy,
 	.sendmsg	=3D mptcp_sendmsg,
 	.recvmsg	=3D mptcp_recvmsg,
+	.release_cb	=3D mptcp_release_cb,
 	.hash		=3D inet_hash,
 	.unhash		=3D inet_unhash,
 	.get_port	=3D mptcp_get_port,
-- =

2.24.1

--===============2217780105383341094==--
