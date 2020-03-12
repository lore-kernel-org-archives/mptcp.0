Content-Type: multipart/mixed; boundary="===============5001193301851109435=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: copy mptcp receive buffer setting to subflow
Date: Thu, 12 Mar 2020 16:45:07 +0100
Message-ID: <20200312154507.860-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 3936

--===============5001193301851109435==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For incoming/outgoing connections, initial window is chosen based om
the subflow receive buffer size.

In case mptcp socket has a fixed buffer size, we should copy it to the
subflow/tcp socket as well.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 I'll pass this to netdev@ unless there are objections.

 net/mptcp/protocol.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ddfd02ab6e31..a65cedcb905f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -89,6 +89,15 @@ static bool __mptcp_can_create_subflow(const struct mptc=
p_sock *msk)
 	return !msk->first;
 }
 =

+static void sync_rcvbuf(const struct sock *msk, struct sock *ssk)
+{
+	if (unlikely((msk->sk_userlocks & SOCK_RCVBUF_LOCK) &&
+	     ssk->sk_rcvbuf !=3D msk->sk_rcvbuf)) {
+		ssk->sk_userlocks |=3D SOCK_RCVBUF_LOCK;
+		WRITE_ONCE(ssk->sk_rcvbuf, msk->sk_rcvbuf);
+	}
+}
+
 static struct socket *__mptcp_socket_create(struct mptcp_sock *msk, int st=
ate)
 {
 	struct mptcp_subflow_context *subflow;
@@ -107,6 +116,7 @@ static struct socket *__mptcp_socket_create(struct mptc=
p_sock *msk, int state)
 	if (err)
 		return ERR_PTR(err);
 =

+	sync_rcvbuf(sk, ssock->sk);
 	msk->first =3D ssock->sk;
 	msk->subflow =3D ssock;
 	subflow =3D mptcp_subflow_ctx(ssock->sk);
-- =

2.24.1

--===============5001193301851109435==--
