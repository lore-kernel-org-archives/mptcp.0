Content-Type: multipart/mixed; boundary="===============8837022991019979686=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 1/4] mptcp: add and use subflow_write_space
Date: Wed, 23 Oct 2019 16:23:52 +0200
Message-ID: <20191023142355.31599-2-fw@strlen.de>
In-Reply-To: 20191023142355.31599-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2286

--===============8837022991019979686==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will be used to unblock tasks waiting for POLLOUT event
once mptcp_poll is altered to not wait for each subflow anymore.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/subflow.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 991198466c13..1f27a96d0439 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -610,6 +610,16 @@ static void subflow_data_ready(struct sock *sk)
 	}
 }
 =

+static void subflow_write_space(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct sock *parent =3D subflow->conn;
+
+	sk_stream_write_space(sk);
+	if (parent)
+		sk_stream_write_space(parent);
+}
+
 int mptcp_subflow_connect(struct sock *sk, struct sockaddr *local,
 			  struct sockaddr *remote, u8 remote_id)
 {
@@ -739,6 +749,7 @@ static int subflow_ulp_init(struct sock *sk)
 	icsk->icsk_af_ops =3D &subflow_specific;
 	ctx->tcp_sk_data_ready =3D sk->sk_data_ready;
 	sk->sk_data_ready =3D subflow_data_ready;
+	sk->sk_write_space =3D subflow_write_space;
 out:
 	return err;
 }
-- =

2.21.0

--===============8837022991019979686==--
