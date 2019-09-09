Content-Type: multipart/mixed; boundary="===============2522778412417384802=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 2/6] mptcp: add and use subflow_write_space
Date: Mon, 09 Sep 2019 17:53:14 +0200
Message-ID: <20190909155317.31119-3-fw@strlen.de>
In-Reply-To: 20190909155317.31119-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1801

--===============2522778412417384802==
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
index 468f9b2aeb30..5635e4c73e15 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -318,6 +318,16 @@ static void subflow_data_ready(struct sock *sk)
 	}
 }
 =

+static void subflow_write_space(struct sock *sk)
+{
+	struct subflow_context *subflow =3D subflow_ctx(sk);
+	struct sock *parent =3D subflow->conn;
+
+	sk_stream_write_space(sk);
+	if (parent)
+		parent->sk_write_space(parent);
+}
+
 int subflow_connect(struct sock *sk, struct sockaddr_in *local,
 		    struct sockaddr_in *remote, u8 remote_id)
 {
@@ -436,6 +446,7 @@ static int subflow_ulp_init(struct sock *sk)
 	ctx->tcp_sk_data_ready =3D sk->sk_data_ready;
 	ctx->use_checksum =3D 0;
 	sk->sk_data_ready =3D subflow_data_ready;
+	sk->sk_write_space =3D subflow_write_space;
 out:
 	return err;
 }
-- =

2.21.0


--===============2522778412417384802==--
