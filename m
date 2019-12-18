Content-Type: multipart/mixed; boundary="===============6064006156199237570=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Squash-to: "mptcp: recvmsg() can drain data from
 multiple subflows"
Date: Wed, 18 Dec 2019 11:40:59 +0100
Message-ID: <2288bed04910bdc36943211ceba127b1bd653e3b.1576665629.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3134

--===============6064006156199237570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix reverse X-mas tree variable declaration.

I guess we don't want to mess that right now ;)

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c33639b38ff2..13f3a202662a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -110,8 +110,8 @@ static bool mptcp_ext_cache_refill(struct mptcp_sock *m=
sk)
 =

 static struct sock *mptcp_subflow_recv_lookup(const struct mptcp_sock *msk)
 {
-	struct sock *sk =3D (struct sock *)msk;
 	struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D (struct sock *)msk;
 =

 	sock_owned_by_me(sk);
 =

-- =

2.21.0

--===============6064006156199237570==--
