Content-Type: multipart/mixed; boundary="===============0502178414404688171=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/3] mptcp: use ipv6-specific proto struct
Date: Thu, 21 Nov 2019 13:25:17 +0100
Message-ID: <1b28dd4ca92f685c8782b2a9239a76074b041542.1574338647.git.pabeni@redhat.com>
In-Reply-To: cover.1574338647.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2642

--===============0502178414404688171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Because it needs a different (greater) obj_size.

Squash-to: "mptcp: Add MPTCP socket stubs"
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 40da2fae65ac..128822e54672 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -689,7 +689,7 @@ static struct proto mptcp_prot =3D {
 	.unhash		=3D inet_unhash,
 	.get_port	=3D mptcp_get_port,
 	.obj_size	=3D sizeof(struct mptcp_sock),
-	.no_autobind	=3D 1,
+	.no_autobind	=3D true,
 };
 =

 static struct socket *mptcp_socket_create_get(struct mptcp_sock *msk)
@@ -972,11 +972,12 @@ void mptcp_proto_init(void)
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 static struct proto_ops mptcp_v6_stream_ops;
+static struct proto mptcp_v6_prot;
 =

 static struct inet_protosw mptcp_v6_protosw =3D {
 	.type		=3D SOCK_STREAM,
 	.protocol	=3D IPPROTO_MPTCP,
-	.prot		=3D &mptcp_prot,
+	.prot		=3D &mptcp_v6_prot,
 	.ops		=3D &mptcp_v6_stream_ops,
 	.flags		=3D INET_PROTOSW_ICSK,
 };
@@ -985,6 +986,11 @@ int mptcp_proto_v6_init(void)
 {
 	int err;
 =

+	mptcp_v6_prot =3D mptcp_prot;
+	strcpy(mptcp_v6_prot.name, "TCPv6");
+	mptcp_v6_prot.obj_size =3D sizeof(struct mptcp_sock) +
+				 sizeof(struct ipv6_pinfo);
+
 	mptcp_v6_stream_ops =3D inet6_stream_ops;
 	mptcp_v6_stream_ops.bind =3D mptcp_bind;
 	mptcp_v6_stream_ops.connect =3D mptcp_stream_connect;
-- =

2.21.0

--===============0502178414404688171==--
