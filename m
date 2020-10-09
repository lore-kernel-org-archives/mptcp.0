Content-Type: multipart/mixed; boundary="===============9064749028236032761=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 2/2] mptcp: subflows garbage collection
Date: Fri, 09 Oct 2020 19:00:01 +0200
Message-ID: <bb9a445351f06c85ae2dd2e84c9b3b8f262def98.1602262630.git.pabeni@redhat.com>
In-Reply-To: cover.1602262630.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6274

--===============9064749028236032761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The msk can close MP_JOIN subflows if the initial handshake
fails. Currently such subflows are kept alive in the
conn_list until the msk itself is closed.

Beyond the wasted memory, we could end-up sending the
DATA_FIN and the DATA_FIN ack on such socket, even after a
reset.

Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machine")
Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 17 +++++++++++++++++
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  6 ++++++
 3 files changed, 24 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5d747c6a610e..b295eb6e9580 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1383,6 +1383,20 @@ static void pm_work(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 =

+static void __mptcp_close_subflow(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow, *tmp;
+
+	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+		if (inet_sk_state_load(ssk) !=3D TCP_CLOSE)
+			continue;
+
+		__mptcp_close_ssk((struct sock *)msk, ssk, subflow, 0);
+	}
+}
+
 static void mptcp_worker(struct work_struct *work)
 {
 	struct mptcp_sock *msk =3D container_of(work, struct mptcp_sock, work);
@@ -1400,6 +1414,9 @@ static void mptcp_worker(struct work_struct *work)
 	mptcp_clean_una(sk);
 	mptcp_check_data_fin_ack(sk);
 	__mptcp_flush_join_list(msk);
+	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
+		__mptcp_close_subflow(msk);
+
 	__mptcp_move_skbs(msk);
 =

 	if (msk->pm.status)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0a6e5b3f6ae8..0c4b8cc64dbc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -90,6 +90,7 @@
 #define MPTCP_WORK_RTX		2
 #define MPTCP_WORK_EOF		3
 #define MPTCP_FALLBACK_DONE	4
+#define MPTCP_WORK_CLOSE_SUBFLOW 5
 =

 struct mptcp_options_received {
 	u64	sndr_key;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b1b8028730bf..80f67cb56631 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -272,9 +272,15 @@ static bool subflow_thmac_valid(struct mptcp_subflow_c=
ontext *subflow)
 =

 void mptcp_subflow_reset(struct sock *ssk)
 {
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	struct sock *sk =3D subflow->conn;
+
 	tcp_set_state(ssk, TCP_CLOSE);
 	tcp_send_active_reset(ssk, GFP_ATOMIC);
 	tcp_done(ssk);
+	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags) &&
+	    schedule_work(&mptcp_sk(sk)->work))
+		sock_hold(sk);
 }
 =

 static void subflow_finish_connect(struct sock *sk, const struct sk_buff *=
skb)
-- =

2.26.2

--===============9064749028236032761==--
