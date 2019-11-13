Content-Type: multipart/mixed; boundary="===============9153556675781046702=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 4/8] mptcp: Add IPv6 support for mptcp_poll
Date: Tue, 12 Nov 2019 22:45:14 -0800
Message-ID: <20191113064518.4823-5-peter.krystad@linux.intel.com>
In-Reply-To: 20191113064518.4823-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2496

--===============9153556675781046702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: add mptcp_poll

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 03f43f3a7a9a..6bc064713500 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -982,6 +982,7 @@ int mptcpv6_init(void)
 	mptcp_v6_stream_ops =3D inet6_stream_ops;
 	mptcp_v6_stream_ops.bind =3D mptcp_bind;
 	mptcp_v6_stream_ops.connect =3D mptcp_stream_connect;
+	mptcp_v6_stream_ops.poll =3D mptcp_poll;
 =

 	err =3D inet6_register_protosw(&mptcp_v6_protosw);
 =

-- =

2.17.2

--===============9153556675781046702==--
