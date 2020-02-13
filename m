Content-Type: multipart/mixed; boundary="===============6532961866352278028=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 3/5] mptcp: add and use mptcp_data_ready helper
Date: Thu, 13 Feb 2020 11:27:40 +0100
Message-ID: <20200213102742.18937-4-fw@strlen.de>
In-Reply-To: 20200213102742.18937-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3646

--===============6532961866352278028==
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
index f68ee86376f0..1ce5105e980a 100644
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
index 06a57bf6d5f0..760607e3e65f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -318,6 +318,7 @@ void mptcp_finish_connect(struct sock *sk);
 void mptcp_subflow_eof(struct sock *sk);
 bool mptcp_finish_join(struct sock *sk);
 void mptcp_data_acked(struct sock *sk);
+void mptcp_data_ready(struct sock *sk);
 =

 int mptcp_token_new_request(struct request_sock *req);
 void mptcp_token_destroy_request(u32 token);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 154fb2b42243..c448a622e4c2 100644
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
@@ -919,11 +916,8 @@ static void subflow_state_change(struct sock *sk)
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

--===============6532961866352278028==--
