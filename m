Content-Type: multipart/mixed; boundary="===============5099837256606271819=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 8/8] mptcp: defer work schedule until mptcp
 lock is released
Date: Tue, 25 Feb 2020 13:05:26 +0100
Message-ID: <20200225120526.2866-9-fw@strlen.de>
In-Reply-To: 20200225120526.2866-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3778

--===============5099837256606271819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Don't schedule the work queue right away, instead defer this
to the lock release callback.

This has the advantage that it will give recv path a chance to
complete -- this might have moved all pending packets from the
subflow to the mptcp receive queue, which allows to avoid another
schedule_work().

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index de6bd9d28116..f7c0d205b047 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -240,8 +240,15 @@ void mptcp_data_ready(struct sock *sk, struct sock *ss=
k)
 		return;
 =

 	/* mptcp socket is busy, schedule worker */
-	if (schedule_work(&msk->work))
-		sock_hold((struct sock *)msk);
+	if (!test_and_set_bit(TCP_DELACK_TIMER_DEFERRED,
+			      &sk->sk_tsq_flags)) {
+		sock_hold(sk);
+
+		/* need to try again, its possible release_cb() has already
+		 * been called after the test_and_set_bit() above.
+		 */
+		move_skbs_to_msk(msk, ssk);
+	}
 }
 =

 static bool mptcp_ext_cache_refill(struct mptcp_sock *msk)
@@ -957,6 +964,15 @@ static void mptcp_release_cb(struct sock *sk)
 	} while (cmpxchg(&sk->sk_tsq_flags, flags, nflags) !=3D flags);
 =

 	sock_release_ownership(sk);
+
+	if (flags & TCPF_DELACK_TIMER_DEFERRED) {
+		struct mptcp_sock *msk =3D mptcp_sk(sk);
+		struct sock *ssk;
+
+		ssk =3D mptcp_subflow_recv_lookup(msk);
+		if (!ssk || !schedule_work(&msk->work))
+			__sock_put(sk);
+	}
 }
 =

 static int mptcp_get_port(struct sock *sk, unsigned short snum)
-- =

2.24.1

--===============5099837256606271819==--
