Content-Type: multipart/mixed; boundary="===============0937176040707625038=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 1/8] mptcp: add and use mptcp_data_ready
 helper
Date: Tue, 25 Feb 2020 13:05:19 +0100
Message-ID: <20200225120526.2866-2-fw@strlen.de>
In-Reply-To: 20200225120526.2866-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3771

--===============0937176040707625038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

allows us to schedule the work queue to drain the ssk receive queue in
a followup patch.

This is needed to avoid sending all-to-pessimistic mptcp-level
acknowledgements.  At this time, the ack_seq is what was last read by
userspace instead of the highest in-sequence number queued for reading.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c |  8 ++++++++
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 14 ++++----------
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e9aa6807b5be..1d55563e9aca 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -111,6 +111,14 @@ static struct sock *mptcp_subflow_get(const struct mpt=
cp_sock *msk)
 	return NULL;
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
 static bool mptcp_ext_cache_refill(struct mptcp_sock *msk)
 {
 	if (!msk->cached_ext)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9f8663b30456..67895a7c1e5b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -201,6 +201,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 		       struct tcp_options_received *opt_rx);
 =

 void mptcp_finish_connect(struct sock *sk);
+void mptcp_data_ready(struct sock *sk);
 =

 int mptcp_token_new_request(struct request_sock *req);
 void mptcp_token_destroy_request(u32 token);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 65122edf60aa..3dad662840aa 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -554,11 +554,8 @@ static void subflow_data_ready(struct sock *sk)
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
@@ -690,11 +687,8 @@ static void subflow_state_change(struct sock *sk)
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

--===============0937176040707625038==--
