Content-Type: multipart/mixed; boundary="===============0380887286489148133=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 5/5] mptcp: Update basic path manager for IPv6
Date: Tue, 15 Oct 2019 16:06:13 -0700
Message-ID: <20191015230613.16981-6-peter.krystad@linux.intel.com>
In-Reply-To: 20191015230613.16981-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2160

--===============0380887286489148133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Implement basic path manager

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/basic.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/basic.c b/net/mptcp/basic.c
index 193d6a01f51a..5520aae3a6e7 100644
--- a/net/mptcp/basic.c
+++ b/net/mptcp/basic.c
@@ -31,6 +31,12 @@ static void create_subflow_worker(struct work_struct *wo=
rk);
 =

 static int parse_addr(struct basic_pernet *pernet, const char *addr)
 {
+	if (in4_pton(addr, -1, (u8 *)&pernet->announce_v4_addr.s_addr, '\0',
+		     NULL) > 0) {
+		pernet->has_announce_v4 =3D 1;
+		pernet->has_announce_v6 =3D 0;
+		return 0;
+	}
 #if IS_ENABLED(CONFIG_IPV6)
 	if (in6_pton(addr, -1, (u8 *)&pernet->announce_v6_addr.s6_addr, '\0',
 		     NULL) > 0) {
@@ -39,14 +45,6 @@ static int parse_addr(struct basic_pernet *pernet, const=
 char *addr)
 		return 0;
 	}
 #endif
-
-	if (in4_pton(addr, -1, (u8 *)&pernet->announce_v4_addr.s_addr, '\0',
-		     NULL) > 0) {
-		pernet->has_announce_v4 =3D 1;
-		pernet->has_announce_v6 =3D 0;
-		return 0;
-	}
-
 	pernet->has_announce_v4 =3D 0;
 	pernet->has_announce_v6 =3D 0;
 =

@@ -190,8 +188,13 @@ static void announce_addr_worker(struct work_struct *w=
ork)
 	pernet =3D net_generic(sock_net((struct sock *)msk), basic_pernet_id);
 =

 	if (pernet->has_announce_v4)
-		mptcp_pm_announce_addr(pm->token, 1, AF_INET,
+		mptcp_pm_announce_addr(pm->token, 1,
 				       &pernet->announce_v4_addr);
+#if IS_ENABLED(CONFIG_IPV6)
+	if (pernet->has_announce_v6)
+		mptcp_pm_announce_addr6(pm->token, 1,
+					&pernet->announce_v6_addr);
+#endif
 	sock_put((struct sock *)msk);
 }
 =

@@ -204,12 +207,21 @@ static void create_subflow_worker(struct work_struct =
*work)
 =

 	pernet =3D net_generic(sock_net((struct sock *)msk), basic_pernet_id);
 =

-	if (pernet->has_announce_v4) {
-		mptcp_pm_create_subflow(pm->token, pm->remote_id, AF_INET,
+	if (pernet->has_announce_v4)
+		mptcp_pm_create_subflow(pm->token, pm->remote_id,
 					&pernet->announce_v4_addr);
-	} else {
-		mptcp_pm_create_subflow(pm->token, pm->remote_id, 0, NULL);
-	}
+#if IS_ENABLED(CONFIG_IPV6)
+	else if (pernet->has_announce_v6)
+		mptcp_pm_create_subflow6(pm->token, pm->remote_id,
+					 &pernet->announce_v6_addr);
+#endif
+	else if (pm->local_family =3D=3D AF_INET)
+		mptcp_pm_create_subflow(pm->token, pm->remote_id, NULL);
+#if IS_ENABLED(CONFIG_IPV6)
+	else
+		mptcp_pm_create_subflow6(pm->token, pm->remote_id, NULL);
+#endif
+
 	sock_put((struct sock *)msk);
 }
 =

-- =

2.17.2

--===============0380887286489148133==--
