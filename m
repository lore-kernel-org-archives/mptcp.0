Content-Type: multipart/mixed; boundary="===============1087536426702689878=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 2/2] mptcp: Use correct address family when
 creating subflows
Date: Tue, 29 Oct 2019 09:55:57 -0700
Message-ID: <20191029165557.7029-3-peter.krystad@linux.intel.com>
In-Reply-To: 20191029165557.7029-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2346

--===============1087536426702689878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Ensure that the address family of the remote address
matches the local address when binding additional subflow
sockets.

Also, only send ADD_ADDR for addresses in the same family
as the initial listening MPTCP socket.

squashto: Implement basic path manager

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/basic.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/basic.c b/net/mptcp/basic.c
index d2fd0560c136..67a93aff500e 100644
--- a/net/mptcp/basic.c
+++ b/net/mptcp/basic.c
@@ -189,11 +189,15 @@ static void announce_addr_worker(struct work_struct *=
work)
 =

 	pernet =3D net_generic(sock_net((struct sock *)msk), basic_pernet_id);
 =

-	if (pernet->has_announce_v4)
+	/* Only announce addresses in the same family as listening socket.
+	 * When the listening socket can accept connections from both
+	 * families this restriction may be removed.
+	 */
+	if (pernet->has_announce_v4 && msk->family =3D=3D AF_INET)
 		mptcp_pm_announce_addr(pm->token, 1,
 				       &pernet->announce_v4_addr);
 #if IS_ENABLED(CONFIG_IPV6)
-	if (pernet->has_announce_v6)
+	else if (pernet->has_announce_v6 && msk->family =3D=3D AF_INET6)
 		mptcp_pm_announce_addr6(pm->token, 1,
 					&pernet->announce_v6_addr);
 #endif
@@ -209,19 +213,23 @@ static void create_subflow_worker(struct work_struct =
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
+	if (pm->remote_family =3D=3D AF_INET) {
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
+	else if (pm->remote_family =3D=3D AF_INET6) {
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

--===============1087536426702689878==--
