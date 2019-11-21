Content-Type: multipart/mixed; boundary="===============6491131314443682006=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/3] mptcp/ipv6: mptcp_v6_prot needs costom destroy.
Date: Thu, 21 Nov 2019 16:41:52 +0100
Message-ID: <6e2d1e5019b5e81d0de33a91d458929600e37a8a.1574350681.git.pabeni@redhat.com>
In-Reply-To: cover.1574350681.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2653

--===============6491131314443682006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise we can leak memory on close, if user space
does some setsockopt before connectiong/accepting.

Note: the squash tag points to the commit currently
introducing mptcp_destroy, but we likely want to move
such function in another one - it's currently added as empty

Squash-to: "mptcp: Add key generation and token tree"
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3ae136f9e35c..9b384da910ce 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -974,6 +974,12 @@ void mptcp_proto_init(void)
 static struct proto_ops mptcp_v6_stream_ops;
 static struct proto mptcp_v6_prot;
 =

+static void mptcp_v6_destroy(struct sock *sk)
+{
+	mptcp_destroy(sk);
+	inet6_destroy_sock(sk);
+}
+
 static struct inet_protosw mptcp_v6_protosw =3D {
 	.type		=3D SOCK_STREAM,
 	.protocol	=3D IPPROTO_MPTCP,
@@ -989,6 +995,7 @@ int mptcp_proto_v6_init(void)
 	mptcp_v6_prot =3D mptcp_prot;
 	strcpy(mptcp_v6_prot.name, "MPTCPv6");
 	mptcp_v6_prot.slab =3D NULL;
+	mptcp_v6_prot.destroy =3D mptcp_v6_destroy;
 	mptcp_v6_prot.obj_size =3D sizeof(struct mptcp_sock) +
 				 sizeof(struct ipv6_pinfo);
 =

-- =

2.21.0

--===============6491131314443682006==--
