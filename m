Content-Type: multipart/mixed; boundary="===============8073462010287644284=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 6/9] mptcp: factor out __mptcp_retrans helper()
Date: Thu, 04 Mar 2021 13:32:13 -0800
Message-ID: <20210304213216.205472-7-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210304213216.205472-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8033

--===============8073462010287644284==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

Will simplify the following patch, no functional change
intended.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 93 ++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 43 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3dcb564b03ad..67aaf7154dca 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2261,59 +2261,23 @@ static void mptcp_check_fastclose(struct mptcp_sock=
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
-
-	lock_sock(sk);
-	state =3D sk->sk_state;
-	if (unlikely(state =3D=3D TCP_CLOSE))
-		goto unlock;
-
-	mptcp_check_data_fin_ack(sk);
-	__mptcp_flush_join_list(msk);
-
-	mptcp_check_fastclose(msk);
-
-	if (msk->pm.status)
-		mptcp_pm_nl_work(msk);
-
-	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
-		mptcp_check_for_eof(msk);
-
-	__mptcp_check_send_data_fin(sk);
-	mptcp_check_data_fin(sk);
-
-	/* There is no point in keeping around an orphaned sk timedout or
-	 * closed, but we need the msk around to reply to incoming DATA_FIN,
-	 * even if it is orphaned and in FIN_WAIT2 state
-	 */
-	if (sock_flag(sk, SOCK_DEAD) &&
-	    (mptcp_check_close_timeout(sk) || sk->sk_state =3D=3D TCP_CLOSE)) {
-		inet_sk_state_store(sk, TCP_CLOSE);
-		__mptcp_destroy_sock(sk);
-		goto unlock;
-	}
-
-	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
-		__mptcp_close_subflow(msk);
-
-	if (!test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
-		goto unlock;
+	struct sock *ssk;
+	int ret;
 =

 	__mptcp_clean_una(sk);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag)
-		goto unlock;
+		return;
 =

 	ssk =3D mptcp_subflow_get_retrans(msk);
 	if (!ssk)
-		goto reset_unlock;
+		goto reset_timer;
 =

 	lock_sock(ssk);
 =

@@ -2339,9 +2303,52 @@ static void mptcp_worker(struct work_struct *work)
 	mptcp_set_timeout(sk, ssk);
 	release_sock(ssk);
 =

-reset_unlock:
+reset_timer:
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
+}
+
+static void mptcp_worker(struct work_struct *work)
+{
+	struct mptcp_sock *msk =3D container_of(work, struct mptcp_sock, work);
+	struct sock *sk =3D &msk->sk.icsk_inet.sk;
+	int state;
+
+	lock_sock(sk);
+	state =3D sk->sk_state;
+	if (unlikely(state =3D=3D TCP_CLOSE))
+		goto unlock;
+
+	mptcp_check_data_fin_ack(sk);
+	__mptcp_flush_join_list(msk);
+
+	mptcp_check_fastclose(msk);
+
+	if (msk->pm.status)
+		mptcp_pm_nl_work(msk);
+
+	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
+		mptcp_check_for_eof(msk);
+
+	__mptcp_check_send_data_fin(sk);
+	mptcp_check_data_fin(sk);
+
+	/* There is no point in keeping around an orphaned sk timedout or
+	 * closed, but we need the msk around to reply to incoming DATA_FIN,
+	 * even if it is orphaned and in FIN_WAIT2 state
+	 */
+	if (sock_flag(sk, SOCK_DEAD) &&
+	    (mptcp_check_close_timeout(sk) || sk->sk_state =3D=3D TCP_CLOSE)) {
+		inet_sk_state_store(sk, TCP_CLOSE);
+		__mptcp_destroy_sock(sk);
+		goto unlock;
+	}
+
+	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
+		__mptcp_close_subflow(msk);
+
+	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
+		__mptcp_retrans(sk);
 =

 unlock:
 	release_sock(sk);
-- =

2.30.1

--===============8073462010287644284==--
