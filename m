Content-Type: multipart/mixed; boundary="===============2216497296690225266=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 1/3] mptcp: add and use subflow_write_space
Date: Tue, 01 Oct 2019 13:57:41 +0200
Message-ID: <20191001115743.2807-2-fw@strlen.de>
In-Reply-To: 20191001115743.2807-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1972

--===============2216497296690225266==
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
index 7a94049587cc..fdec4f6208b7 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -320,6 +320,16 @@ static void subflow_data_ready(struct sock *sk)
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
+		parent->sk_write_space(parent);
+}
+
 int mptcp_subflow_connect(struct sock *sk, struct sockaddr_in *local,
 			  struct sockaddr_in *remote, u8 remote_id)
 {
@@ -438,6 +448,7 @@ static int subflow_ulp_init(struct sock *sk)
 	ctx->tcp_sk_data_ready =3D sk->sk_data_ready;
 	ctx->use_checksum =3D 0;
 	sk->sk_data_ready =3D subflow_data_ready;
+	sk->sk_write_space =3D subflow_write_space;
 out:
 	return err;
 }
-- =

2.21.0

--===============2216497296690225266==--
