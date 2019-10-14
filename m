Content-Type: multipart/mixed; boundary="===============8796975280608250379=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 2/6] subflow: wake parent mptcp socket on subflow
 state change
Date: Tue, 15 Oct 2019 01:19:15 +0200
Message-ID: <20191014231919.2454-3-fw@strlen.de>
In-Reply-To: 20191014231919.2454-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2124

--===============8796975280608250379==
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
index 2920fe01b264..2db2857a1ec6 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -438,6 +438,28 @@ static struct mptcp_subflow_context *subflow_create_ct=
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
@@ -466,6 +488,7 @@ static int subflow_ulp_init(struct sock *sk)
 	ctx->tcp_sk_data_ready =3D sk->sk_data_ready;
 	sk->sk_data_ready =3D subflow_data_ready;
 	sk->sk_write_space =3D subflow_write_space;
+	sk->sk_state_change =3D subflow_state_change;
 out:
 	return err;
 }
-- =

2.21.0

--===============8796975280608250379==--
