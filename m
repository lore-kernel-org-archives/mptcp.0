Content-Type: multipart/mixed; boundary="===============7381429334914790594=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 7/8] mptcp: Add IPv6 support for shutdown()
Date: Tue, 12 Nov 2019 22:45:17 -0800
Message-ID: <20191113064518.4823-8-peter.krystad@linux.intel.com>
In-Reply-To: 20191113064518.4823-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2491

--===============7381429334914790594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Add shutdown() socket operation

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bda16c399e23..a831e7fdb90f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1010,6 +1010,7 @@ int mptcpv6_init(void)
 	mptcp_v6_stream_ops.accept =3D mptcp_stream_accept;
 	mptcp_v6_stream_ops.getname =3D mptcp_v6_getname;
 	mptcp_v6_stream_ops.listen =3D mptcp_listen;
+	mptcp_v6_stream_ops.shutdown =3D mptcp_shutdown;
 =

 	err =3D inet6_register_protosw(&mptcp_v6_protosw);
 =

-- =

2.17.2

--===============7381429334914790594==--
