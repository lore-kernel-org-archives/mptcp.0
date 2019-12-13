Content-Type: multipart/mixed; boundary="===============4009671979344758957=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH]
 Squash-to-mptcp-Create-SUBFLOW-socket-for-incoming-connections
Date: Fri, 13 Dec 2019 01:18:04 +0100
Message-ID: <500c372287d2af8bbbe0dc811e5566b07ce2160e.1576196206.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2909

--===============4009671979344758957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Need to explicitly clear msk->subflow on passive connection, or
it will inherit the listener msk value, which is uncorrect

This fixes hang-up pre-v1 patches.

Still investigating why the v1 code did non hang without this.
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 87d66842f7fa..11c6b1678169 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -280,6 +280,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		msk =3D mptcp_sk(new_mptcp_sock);
 		msk->remote_key =3D subflow->remote_key;
 		msk->local_key =3D subflow->local_key;
+		msk->subflow =3D NULL;
 =

 		newsk =3D new_mptcp_sock;
 		mptcp_copy_inaddrs(newsk, ssk);
-- =

2.21.0

--===============4009671979344758957==--
