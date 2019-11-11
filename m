Content-Type: multipart/mixed; boundary="===============4838053656549156835=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/4] mptcp: drop most of mptcp_init_sock() impl
Date: Mon, 11 Nov 2019 12:28:58 +0100
Message-ID: <823b8a78b336ac52165a91c53d92064db248d825.1573471403.git.pabeni@redhat.com>
In-Reply-To: cover.1573471403.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2459

--===============4838053656549156835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Will be dropped anyway by laters patches and apparently
introduces a mem leak (currently plugged by
"mptcp: new sysctl to control the activation per NS")

Squash-to: "mptcp: Add MPTCP socket stubs"
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a4efa06e43d2..40290bfd0717 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -39,18 +39,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr =
*msg, size_t len,
 =

 static int mptcp_init_sock(struct sock *sk)
 {
-	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct net *net =3D sock_net(sk);
-	struct socket *sf;
-	int err;
-
-	err =3D sock_create_kern(net, PF_INET, SOCK_STREAM, IPPROTO_TCP, &sf);
-	if (!err) {
-		pr_debug("subflow=3D%p", sf->sk);
-		msk->subflow =3D sf;
-	}
-
-	return err;
+	return 0;
 }
 =

 static void mptcp_close(struct sock *sk, long timeout)
-- =

2.21.0

--===============4838053656549156835==--
