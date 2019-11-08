Content-Type: multipart/mixed; boundary="===============1956734520289975391=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: Missing chunk from "Add IPv6 support"
Date: Fri, 08 Nov 2019 09:30:12 -0800
Message-ID: <20191108173012.13597-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2446

--===============1956734520289975391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This chunk appears to have been dropped from the IPv6 commit.

squashto: Add IPv6 support

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/protocol.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7bea6b62f66e..1a432abfb176 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1099,10 +1099,7 @@ static int mptcp_bind(struct socket *sock, struct so=
ckaddr *uaddr, int addr_len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 	struct socket *ssock;
-	int err =3D -ENOTSUPP;
-
-	if (uaddr->sa_family !=3D AF_INET) // @@ allow only IPv4 for now
-		return err;
+	int err;
 =

 	ssock =3D mptcp_socket_create_get(msk);
 	if (IS_ERR(ssock))
-- =

2.17.2

--===============1956734520289975391==--
