Content-Type: multipart/mixed; boundary="===============7633336100487618594=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/8] mptcp: Add IPv6 support for Associate MPTCP
 context
Date: Tue, 12 Nov 2019 22:45:12 -0800
Message-ID: <20191113064518.4823-3-peter.krystad@linux.intel.com>
In-Reply-To: 20191113064518.4823-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2490

--===============7633336100487618594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Associate MPTCP context with TCP socket

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/protocol.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index aa8444c2dd71..03f43f3a7a9a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -965,11 +965,13 @@ void mptcp_proto_init(void)
 }
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static struct proto_ops mptcp_v6_stream_ops;
+
 static struct inet_protosw mptcp_v6_protosw =3D {
 	.type		=3D SOCK_STREAM,
 	.protocol	=3D IPPROTO_MPTCP,
 	.prot		=3D &mptcp_prot,
-	.ops		=3D &inet6_stream_ops,
+	.ops		=3D &mptcp_v6_stream_ops,
 	.flags		=3D INET_PROTOSW_ICSK,
 };
 =

@@ -977,6 +979,10 @@ int mptcpv6_init(void)
 {
 	int err;
 =

+	mptcp_v6_stream_ops =3D inet6_stream_ops;
+	mptcp_v6_stream_ops.bind =3D mptcp_bind;
+	mptcp_v6_stream_ops.connect =3D mptcp_stream_connect;
+
 	err =3D inet6_register_protosw(&mptcp_v6_protosw);
 =

 	return err;
-- =

2.17.2

--===============7633336100487618594==--
