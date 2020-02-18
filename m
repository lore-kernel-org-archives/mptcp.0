Content-Type: multipart/mixed; boundary="===============4459675700331294201=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 1/6] mptcp: add and use mptcp_data_ready helper
Date: Tue, 18 Feb 2020 13:21:05 +0100
Message-ID: <20200218122110.23817-2-fw@strlen.de>
In-Reply-To: 20200218122110.23817-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3693

--===============4459675700331294201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

allows us to schedule the work queue to drain the ssk receive
queue in a followup patch.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c |  8 ++++++++
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 14 ++++----------
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 47b3c4afdc87..84204129e1d3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -156,6 +156,14 @@ void mptcp_subflow_eof(struct sock *sk)
 		sock_hold(sk);
 }
 =

+void mptcp_data_ready(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	set_bit(MPTCP_DATA_READY, &msk->flags);
+	sk->sk_data_ready(sk);
+}
+
 static void mptcp_stop_timer(struct sock *sk)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3fbb33deb764..95b0ade75771 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -317,6 +317,7 @@ void mptcp_finish_connect(struct sock *sk);
 void mptcp_subflow_eof(struct sock *sk);
 bool mptcp_finish_join(struct sock *sk);
 void mptcp_data_acked(struct sock *sk);
+void mptcp_data_ready(struct sock *sk);
 =

 int mptcp_token_new_request(struct request_sock *req);
 void mptcp_token_destroy_request(u32 token);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 547d5ffef070..fbff5dc39575 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -723,11 +723,8 @@ static void subflow_data_ready(struct sock *sk)
 		return;
 	}
 =

-	if (mptcp_subflow_data_available(sk)) {
-		set_bit(MPTCP_DATA_READY, &mptcp_sk(parent)->flags);
-
-		parent->sk_data_ready(parent);
-	}
+	if (mptcp_subflow_data_available(sk))
+		mptcp_data_ready(parent);
 }
 =

 static void subflow_write_space(struct sock *sk)
@@ -916,11 +913,8 @@ static void subflow_state_change(struct sock *sk)
 	 * a fin packet carrying a DSS can be unnoticed if we don't trigger
 	 * the data available machinery here.
 	 */
-	if (parent && subflow->mp_capable && mptcp_subflow_data_available(sk)) {
-		set_bit(MPTCP_DATA_READY, &mptcp_sk(parent)->flags);
-
-		parent->sk_data_ready(parent);
-	}
+	if (parent && subflow->mp_capable && mptcp_subflow_data_available(sk))
+		mptcp_data_ready(parent);
 =

 	if (parent && !(parent->sk_shutdown & RCV_SHUTDOWN) &&
 	    !subflow->rx_eof && subflow_is_done(sk)) {
-- =

2.24.1

--===============4459675700331294201==--
