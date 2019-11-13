Content-Type: multipart/mixed; boundary="===============6892117994846073777=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 6/8] mptcp: Add IPv6 support for key generation
Date: Tue, 12 Nov 2019 22:45:16 -0800
Message-ID: <20191113064518.4823-7-peter.krystad@linux.intel.com>
In-Reply-To: 20191113064518.4823-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2493

--===============6892117994846073777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Add key generation and token tree

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/subflow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 580cee2a5f84..a24888109ae5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -793,6 +793,7 @@ void mptcp_subflow_init(void)
 	subflow_v6_specific.conn_request =3D subflow_v6_conn_request;
 	subflow_v6_specific.syn_recv_sock =3D subflow_syn_recv_sock;
 	subflow_v6_specific.sk_rx_dst_set =3D subflow_finish_connect;
+	subflow_v6_specific.rebuild_header =3D subflow_rebuild_header;
 #endif
 =

 	if (tcp_register_ulp(&subflow_ulp_ops) !=3D 0)
-- =

2.17.2

--===============6892117994846073777==--
