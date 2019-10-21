Content-Type: multipart/mixed; boundary="===============0386656008375485310=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/3] mptcp: Use correct address family when creating
 subflows
Date: Mon, 21 Oct 2019 16:41:52 -0700
Message-ID: <20191021234152.3091-4-peter.krystad@linux.intel.com>
In-Reply-To: 20191021234152.3091-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2246

--===============0386656008375485310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the address family used when the initial MPTCP socket
was created when making additional subflow sockets.

squashto: Implement basic path manager

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/basic.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/basic.c b/net/mptcp/basic.c
index d2fd0560c136..2557cb63fd61 100644
--- a/net/mptcp/basic.c
+++ b/net/mptcp/basic.c
@@ -209,19 +209,23 @@ static void create_subflow_worker(struct work_struct =
*work)
 =

 	pernet =3D net_generic(sock_net((struct sock *)msk), basic_pernet_id);
 =

-	if (pernet->has_announce_v4)
-		mptcp_pm_create_subflow(pm->token, pm->remote_id,
-					&pernet->announce_v4_addr);
-#if IS_ENABLED(CONFIG_IPV6)
-	else if (pernet->has_announce_v6)
-		mptcp_pm_create_subflow6(pm->token, pm->remote_id,
-					 &pernet->announce_v6_addr);
-#endif
-	else if (pm->local_family =3D=3D AF_INET)
-		mptcp_pm_create_subflow(pm->token, pm->remote_id, NULL);
+	if (msk->family =3D=3D AF_INET) {
+		if (pernet->has_announce_v4)
+			mptcp_pm_create_subflow(pm->token, pm->remote_id,
+						&pernet->announce_v4_addr);
+		else
+			mptcp_pm_create_subflow(pm->token, pm->remote_id,
+						NULL);
+	}
 #if IS_ENABLED(CONFIG_IPV6)
-	else
-		mptcp_pm_create_subflow6(pm->token, pm->remote_id, NULL);
+	else if (msk->family =3D=3D AF_INET6) {
+		if (pernet->has_announce_v6)
+			mptcp_pm_create_subflow6(pm->token, pm->remote_id,
+						 &pernet->announce_v6_addr);
+		else
+			mptcp_pm_create_subflow6(pm->token, pm->remote_id,
+						 NULL);
+	}
 #endif
 =

 	sock_put((struct sock *)msk);
-- =

2.17.2

--===============0386656008375485310==--
