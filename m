Content-Type: multipart/mixed; boundary="===============0637463650611534415=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 2/4] subflow: wake parent mptcp socket on subflow
 state change
Date: Wed, 23 Oct 2019 16:23:53 +0200
Message-ID: <20191023142355.31599-3-fw@strlen.de>
In-Reply-To: 20191023142355.31599-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2287

--===============0637463650611534415==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We need to wakeup readers blocking for POLLIN, as no
more data will arrive they will never be awoken otherwise.

This is needed at least until proper MPTCP-Level fin/reset
signalling gets added.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/subflow.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1f27a96d0439..7bae7c35ea6b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -722,6 +722,28 @@ static struct mptcp_subflow_context *subflow_create_ct=
x(struct sock *sk,
 	return ctx;
 }
 =

+static void __subflow_state_change(struct sock *sk)
+{
+	struct socket_wq *wq;
+
+	rcu_read_lock();
+	wq =3D rcu_dereference(sk->sk_wq);
+	if (skwq_has_sleeper(wq))
+		wake_up_interruptible_all(&wq->wait);
+	rcu_read_unlock();
+}
+
+static void subflow_state_change(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct sock *parent =3D subflow->conn;
+
+	__subflow_state_change(sk);
+
+	if (parent)
+		__subflow_state_change(parent);
+}
+
 static int subflow_ulp_init(struct sock *sk)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
@@ -750,6 +772,7 @@ static int subflow_ulp_init(struct sock *sk)
 	ctx->tcp_sk_data_ready =3D sk->sk_data_ready;
 	sk->sk_data_ready =3D subflow_data_ready;
 	sk->sk_write_space =3D subflow_write_space;
+	sk->sk_state_change =3D subflow_state_change;
 out:
 	return err;
 }
-- =

2.21.0

--===============0637463650611534415==--
