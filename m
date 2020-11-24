Content-Type: multipart/mixed; boundary="===============8555720297025906844=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] mptcp: be careful on MPTCP-level ack.
Date: Tue, 24 Nov 2020 12:20:11 +0100
Message-ID: <722e1a13493897c7cc194035e9b394e0dbeeb1af.1606213920.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6898

--===============8555720297025906844==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We can enter the main mptcp_recvmsg() loop even when
no subflows are connected. As note by Eric, that would
result in a divide by zero oops on ack generation.

Address the issue by checking the subflow status before
sending the ack.

Additionally protect mptcp_recvmsg() against invocation
with weird socket states.

Reported-and-suggested-by: Eric Dumazet <eric.dumazet(a)gmail.com>
Fixes: ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 67 ++++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4b7794835fea..b50164efb741 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -419,31 +419,57 @@ static bool mptcp_subflow_active(struct mptcp_subflow=
_context *subflow)
 	return ((1 << ssk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
 }
 =

-static void mptcp_send_ack(struct mptcp_sock *msk, bool force)
+static inline bool tcp_can_send_ack(const struct sock *ssk)
+{
+	return !((1 << inet_sk_state_load(ssk)) &
+	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE));
+}
+
+static void mptcp_send_ack(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct sock *pick =3D NULL;
 =

 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

-		if (force) {
-			lock_sock(ssk);
+		lock_sock(ssk);
+		if (tcp_can_send_ack(ssk))
 			tcp_send_ack(ssk);
-			release_sock(ssk);
-			continue;
-		}
-
-		/* if the hintes ssk is still active, use it */
-		pick =3D ssk;
-		if (ssk =3D=3D msk->ack_hint)
-			break;
+		release_sock(ssk);
 	}
-	if (!force && pick) {
-		lock_sock(pick);
-		tcp_cleanup_rbuf(pick, 1);
-		release_sock(pick);
+}
+
+static bool mptcp_subflow_cleanup_rbuf(struct sock *ssk)
+{
+	int ret;
+
+	lock_sock(ssk);
+	ret =3D tcp_can_send_ack(ssk);
+	if (ret)
+		tcp_cleanup_rbuf(ssk, 1);
+	release_sock(ssk);
+	return ret;
+}
+
+static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	/* if the hinted ssk is still active, try to use it */
+	if (likely(msk->ack_hint)) {
+		mptcp_for_each_subflow(msk, subflow) {
+			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+			if (msk->ack_hint =3D=3D ssk &&
+			    mptcp_subflow_cleanup_rbuf(ssk))
+				return;
+		}
 	}
+
+	/* otherwise pick the first active subflow */
+	mptcp_for_each_subflow(msk, subflow)
+		if (mptcp_subflow_cleanup_rbuf(mptcp_subflow_tcp_sock(subflow)))
+			return;
 }
 =

 static bool mptcp_check_data_fin(struct sock *sk)
@@ -494,7 +520,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
 =

 		ret =3D true;
 		mptcp_set_timeout(sk, NULL);
-		mptcp_send_ack(msk, true);
+		mptcp_send_ack(msk);
 		mptcp_close_wake_up(sk);
 	}
 	return ret;
@@ -1579,6 +1605,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
 		return -EOPNOTSUPP;
 =

 	lock_sock(sk);
+	if (unlikely(sk->sk_state =3D=3D TCP_LISTEN)) {
+		copied =3D -ENOTCONN;
+		goto out_err;
+	}
+
 	timeo =3D sock_rcvtimeo(sk, nonblock);
 =

 	len =3D min_t(size_t, len, INT_MAX);
@@ -1604,7 +1635,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 		/* be sure to advertise window change */
 		old_space =3D READ_ONCE(msk->old_wspace);
 		if ((tcp_space(sk) - old_space) >=3D old_space)
-			mptcp_send_ack(msk, false);
+			mptcp_cleanup_rbuf(msk);
 =

 		/* only the master socket status is relevant here. The exit
 		 * conditions mirror closely tcp_recvmsg()
-- =

2.26.2

--===============8555720297025906844==--
