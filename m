Content-Type: multipart/mixed; boundary="===============3741535088179176564=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 9/9] don't flag parent socket as RCV_SHUTDOWN if one
 one subflow has closed
Date: Sat, 30 Nov 2019 23:49:00 +0100
Message-ID: <20191130224900.8694-10-fw@strlen.de>
In-Reply-To: 20191130224900.8694-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2722

--===============3741535088179176564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

instead schedule the mptcp worker and tell it to check eof state on all
subflows.  If all have closed, then also flag the mptcp socket as closed
and wake up userspace process blocking in poll().

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 41 +++++++++++++++++++++++++++++++++--------
 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  | 22 ++++++++++++++++------
 3 files changed, 51 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 36097008dd4a..c1734005e89e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -61,6 +61,15 @@ void mptcp_data_acked(struct sock *sk)
 		sock_hold(sk);
 }
 =

+void mptcp_subflow_eof(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	if (!test_and_set_bit(MPTCP_WORK_EOF, &msk->flags) &&
+	    schedule_work(&msk->rtx_work))
+		sock_hold(sk);
+}
+
 static void mptcp_stop_timer(struct sock *sk)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
@@ -95,22 +104,14 @@ static struct sock *mptcp_subflow_recv_lookup(const st=
ruct mptcp_sock *msk)
 {
 	struct sock *sk =3D (struct sock *)msk;
 	struct mptcp_subflow_context *subflow;
-	int receivers =3D 0;
 =

 	sock_owned_by_me(sk);
 =

 	mptcp_for_each_subflow(msk, subflow) {
 		if (subflow->data_avail)
 			return mptcp_subflow_tcp_sock(subflow);
-
-		receivers +=3D !subflow->rx_eof;
 	}
 =

-	/* hopefully temporary hack: propagate shutdown status from subflow
-	 * to msk, when all subflows agree on it
-	 */
-	if (!receivers && !(sk->sk_shutdown & RCV_SHUTDOWN))
-		sk->sk_shutdown |=3D RCV_SHUTDOWN;
 	return NULL;
 }
 =

@@ -789,6 +790,27 @@ static void __mptcp_close_ssk(struct sock *sk, struct =
sock *ssk,
 	}
 }
 =

+static void mptcp_check_for_eof(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D (struct sock *)msk;
+	int receivers =3D 0;
+
+	mptcp_for_each_subflow(msk, subflow)
+		receivers +=3D !subflow->rx_eof;
+
+	if (!receivers && !(sk->sk_shutdown & RCV_SHUTDOWN)) {
+		/* hopefully temporary hack: propagate shutdown status
+		 * to msk, when all subflows agree on it
+		 */
+		sk->sk_shutdown |=3D RCV_SHUTDOWN;
+
+		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
+		set_bit(MPTCP_DATA_READY, &msk->flags);
+		sk->sk_data_ready(sk);
+	}
+}
+
 static void mptcp_worker(struct work_struct *work)
 {
 	int orig_len, orig_offset, ret, mss_now =3D 0, size_goal =3D 0;
@@ -806,6 +828,9 @@ static void mptcp_worker(struct work_struct *work)
 	lock_sock(sk);
 	mptcp_clean_una(sk);
 =

+	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
+		mptcp_check_for_eof(msk);
+
 	if (!test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		goto unlock;
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 990da61fa51b..cf3b4ce483d9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -78,6 +78,7 @@
 #define MPTCP_DATA_READY	BIT(0)
 #define MPTCP_WORK_RTX		BIT(1)
 #define MPTCP_SEND_SPACE	BIT(2)
+#define MPTCP_WORK_EOF		BIT(3)
 =

 static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
 {
@@ -291,6 +292,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 		       struct tcp_options_received *opt_rx);
 =

 void mptcp_finish_connect(struct sock *sk);
+void mptcp_subflow_eof(struct sock *sk);
 bool mptcp_finish_join(struct sock *sk);
 void mptcp_data_acked(struct sock *sk);
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8c13e9a145d5..e63a95217b1f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -621,6 +621,11 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	return false;
 }
 =

+static bool subflow_is_done(const struct sock *sk)
+{
+	return sk->sk_shutdown & RCV_SHUTDOWN || sk->sk_state =3D=3D TCP_CLOSE;
+}
+
 bool mptcp_subflow_data_available(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
@@ -642,7 +647,7 @@ bool mptcp_subflow_data_available(struct sock *sk)
 		/* set EoF only there is no data available - we already spooled
 		 * all the pending skbs
 		 */
-		if (sk->sk_shutdown & RCV_SHUTDOWN || sk->sk_state =3D=3D TCP_CLOSE)
+		if (subflow_is_done(sk))
 			subflow->rx_eof =3D 1;
 		return false;
 	}
@@ -666,13 +671,15 @@ static void subflow_data_ready(struct sock *sk)
 		return;
 	}
 =

-	/* always propagate the EoF */
-	if (mptcp_subflow_data_available(sk) || subflow->rx_eof) {
+	if (mptcp_subflow_data_available(sk)) {
 		smp_mb__before_atomic();
 		set_bit(MPTCP_DATA_READY, &mptcp_sk(parent)->flags);
 		smp_mb__after_atomic();
 =

 		parent->sk_data_ready(parent);
+	} else if (subflow->rx_eof) {
+		/* tell parent to (re-)check eof on all subflows */
+		mptcp_subflow_eof(parent);
 	}
 }
 =

@@ -810,12 +817,15 @@ static void __subflow_state_change(struct sock *sk)
 static void subflow_state_change(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
-	struct sock *parent =3D subflow->conn;
+	struct sock *parent =3D READ_ONCE(subflow->conn);
 =

 	__subflow_state_change(sk);
 =

-	if (parent)
-		__subflow_state_change(parent);
+	if (parent && !(parent->sk_shutdown & RCV_SHUTDOWN) &&
+	    !subflow->rx_eof && subflow_is_done(sk)) {
+		subflow->rx_eof =3D 1;
+		mptcp_subflow_eof(parent);
+	}
 }
 =

 static int subflow_ulp_init(struct sock *sk)
-- =

2.23.0

--===============3741535088179176564==--
