Content-Type: multipart/mixed; boundary="===============0280437601184498467=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Squash-to: "mptcp: refactor shutdown and close"
Date: Thu, 15 Oct 2020 15:26:15 +0200
Message-ID: <ec5396bf43b34115b9818099983a7f6bc25e7388.1602768332.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6314

--===============0280437601184498467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently we can miss the msk timeout event in several
circumstances (e.g. no outstanding data).

Let's use a separate timer to keep track of the timeout
after close().

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 59e11f31865a..0f3dae1dabc9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1658,6 +1658,13 @@ static void mptcp_retransmit_timer(struct timer_list=
 *t)
 	sock_put(sk);
 }
 =

+static void mptcp_timeout_timer(struct timer_list *t)
+{
+	struct sock *sk =3D from_timer(sk, t, sk_timer);
+
+	mptcp_schedule_work(sk);
+}
+
 /* Find an idle subflow.  Return NULL if there is unacked data at tcp
  * level.
  *
@@ -1786,7 +1793,7 @@ static bool mptcp_check_close_timeout(const struct so=
ck *sk)
 	s32 delta =3D tcp_jiffies32 - inet_csk(sk)->icsk_mtup.probe_timestamp;
 	struct mptcp_subflow_context *subflow;
 =

-	if (delta > TCP_TIMEWAIT_LEN)
+	if (delta >=3D TCP_TIMEWAIT_LEN)
 		return true;
 =

 	/* if all subflows are in closed status don't bother with additional
@@ -1921,7 +1928,7 @@ static int __mptcp_init_sock(struct sock *sk)
 =

 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
-
+	timer_setup(&sk->sk_timer, mptcp_timeout_timer, 0);
 	return 0;
 }
 =

@@ -2087,6 +2094,7 @@ static void __mptcp_destroy_sock(struct sock *sk, int=
 timeout)
 	list_splice_init(&msk->conn_list, &conn_list);
 =

 	__mptcp_clear_xmit(sk);
+	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status =3D 0;
 =

 	list_for_each_entry_safe(subflow, tmp, &conn_list, node) {
@@ -2145,6 +2153,8 @@ static void mptcp_close(struct sock *sk, long timeout)
 	if (sk->sk_state =3D=3D TCP_CLOSE) {
 		__mptcp_destroy_sock(sk, timeout);
 		do_cancel_work =3D true;
+	} else {
+		sk_reset_timer(sk, &sk->sk_timer, jiffies + TCP_TIMEWAIT_LEN);
 	}
 	release_sock(sk);
 	if (do_cancel_work)
-- =

2.26.2

--===============0280437601184498467==--
