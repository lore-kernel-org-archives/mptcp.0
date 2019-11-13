Content-Type: multipart/mixed; boundary="===============2104601326566126324=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 8/8] mptcp: Add IPv6 support for new sysctl
 initialization
Date: Tue, 12 Nov 2019 22:45:18 -0800
Message-ID: <20191113064518.4823-9-peter.krystad@linux.intel.com>
In-Reply-To: 20191113064518.4823-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2495

--===============2104601326566126324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: new sysctl to control the activation per NS

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/ctrl.c     | 11 +++++++++++
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h |  3 +++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 6023c9f722ea..8e39585d37f3 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -117,3 +117,14 @@ void __init mptcp_init(void)
 	if (register_pernet_subsys(&mptcp_pernet_ops) < 0)
 		panic("Failed to register MPTCP pernet subsystem.\n");
 }
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+int __init mptcpv6_init(void)
+{
+	int err;
+
+	err =3D mptcp_proto_v6_init();
+
+	return err;
+}
+#endif
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a831e7fdb90f..564a6204649e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -999,7 +999,7 @@ static struct inet_protosw mptcp_v6_protosw =3D {
 	.flags		=3D INET_PROTOSW_ICSK,
 };
 =

-int mptcpv6_init(void)
+int mptcp_proto_v6_init(void)
 {
 	int err;
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2566858ea272..80e4cbfc389a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -232,6 +232,9 @@ extern const struct inet_connection_sock_af_ops ipv6_sp=
ecific;
 #endif
 =

 void mptcp_proto_init(void);
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+int mptcp_proto_v6_init(void);
+#endif
 =

 struct mptcp_read_arg {
 	struct msghdr *msg;
-- =

2.17.2

--===============2104601326566126324==--
