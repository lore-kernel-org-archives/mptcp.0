Content-Type: multipart/mixed; boundary="===============6527790240149094805=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 1/3] mptcp: factor out __mptcp_retrans
 helper()
Date: Tue, 09 Feb 2021 12:42:39 +0100
Message-ID: <551a0e52642f203d2c264a62a4526c25eddd234c.1612869198.git.pabeni@redhat.com>
In-Reply-To: cover.1612869198.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7702

--===============6527790240149094805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Will simplify the following patch, no functional change
intended.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 93 ++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 43 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b5d290c8d998f..7e5016903e11c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2232,14 +2232,58 @@ static void mptcp_check_fastclose(struct mptcp_sock=
 *msk)
 	mptcp_close_wake_up(sk);
 }
 =

-static void mptcp_worker(struct work_struct *work)
+static void __mptcp_retrans(struct sock *sk)
 {
-	struct mptcp_sock *msk =3D container_of(work, struct mptcp_sock, work);
-	struct sock *ssk, *sk =3D &msk->sk.icsk_inet.sk;
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_sendmsg_info info =3D {};
 	struct mptcp_data_frag *dfrag;
 	size_t copied =3D 0;
-	int state, ret;
+	struct sock *ssk;
+	int ret;
+
+	__mptcp_clean_una(sk);
+	dfrag =3D mptcp_rtx_head(sk);
+	if (!dfrag)
+		return;
+
+	ssk =3D mptcp_subflow_get_retrans(msk);
+	if (!ssk)
+		goto reset_timer;
+
+	lock_sock(ssk);
+
+	/* limit retransmission to the bytes already sent on some subflows */
+	info.sent =3D 0;
+	info.limit =3D dfrag->already_sent;
+	while (info.sent < dfrag->already_sent) {
+		if (!mptcp_alloc_tx_skb(sk, ssk))
+			break;
+
+		ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+		if (ret <=3D 0)
+			break;
+
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
+		copied +=3D ret;
+		info.sent +=3D ret;
+	}
+	if (copied)
+		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
+			 info.size_goal);
+
+	mptcp_set_timeout(sk, ssk);
+	release_sock(ssk);
+
+reset_timer:
+	if (!mptcp_timer_pending(sk))
+		mptcp_reset_timer(sk);
+}
+
+static void mptcp_worker(struct work_struct *work)
+{
+	struct mptcp_sock *msk =3D container_of(work, struct mptcp_sock, work);
+	struct sock *sk =3D &msk->sk.icsk_inet.sk;
+	int state;
 =

 	lock_sock(sk);
 	state =3D sk->sk_state;
@@ -2275,45 +2319,8 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
 		__mptcp_close_subflow(msk);
 =

-	if (!test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
-		goto unlock;
-
-	__mptcp_clean_una(sk);
-	dfrag =3D mptcp_rtx_head(sk);
-	if (!dfrag)
-		goto unlock;
-
-	ssk =3D mptcp_subflow_get_retrans(msk);
-	if (!ssk)
-		goto reset_unlock;
-
-	lock_sock(ssk);
-
-	/* limit retransmission to the bytes already sent on some subflows */
-	info.sent =3D 0;
-	info.limit =3D dfrag->already_sent;
-	while (info.sent < dfrag->already_sent) {
-		if (!mptcp_alloc_tx_skb(sk, ssk))
-			break;
-
-		ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-		if (ret <=3D 0)
-			break;
-
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
-		copied +=3D ret;
-		info.sent +=3D ret;
-	}
-	if (copied)
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
-
-	mptcp_set_timeout(sk, ssk);
-	release_sock(ssk);
-
-reset_unlock:
-	if (!mptcp_timer_pending(sk))
-		mptcp_reset_timer(sk);
+	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
+		__mptcp_retrans(sk);
 =

 unlock:
 	release_sock(sk);
-- =

2.26.2

--===============6527790240149094805==--
