Content-Type: multipart/mixed; boundary="===============8154264384182027446=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 2/2] mptcp: subflows garbage collection
Date: Thu, 08 Oct 2020 22:34:59 +0200
Message-ID: <885dd6801461324b1a9753625150cf5e55f22852.1602189151.git.pabeni@redhat.com>
In-Reply-To: cover.1602189151.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6253

--===============8154264384182027446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The msk can close MP_JOIN subflows if the initial handshake
fails. Currently such subflows are kept alive in the
conn_list untill the msk itself is closed.

Beyond the wasted memory, we could end-up sending the
DATA_FIN and the DATA_FIN ack on such socket, even after a
reset.

Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machine")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 18 ++++++++++++++++++
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  6 ++++++
 3 files changed, 25 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 82b324ed3c4c..92e0152f831b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1701,6 +1701,20 @@ static void pm_work(struct mptcp_sock *msk)
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
@@ -1718,11 +1732,15 @@ static void mptcp_worker(struct work_struct *work)
 	mptcp_clean_una(sk);
 	mptcp_check_data_fin_ack(sk);
 	__mptcp_flush_join_list(msk);
+	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
+		__mptcp_close_subflow(msk);
+
 	__mptcp_move_skbs(msk);
 =

 	if (msk->pm.status)
 		pm_work(msk);
 =

+
 	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
 		mptcp_check_for_eof(msk);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index de5219fd3570..3462c00afd9e 100644
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
index d2eb5f2abe5a..0117b99b3a62 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -273,9 +273,15 @@ static bool subflow_thmac_valid(struct mptcp_subflow_c=
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

--===============8154264384182027446==--
