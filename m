Content-Type: multipart/mixed; boundary="===============5642014985716105755=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 5/5] mptcp: Switch to CONFIG_MPTCP_IPV6
Date: Tue, 05 Nov 2019 11:05:57 -0800
Message-ID: <20191105190557.6405-5-peter.krystad@linux.intel.com>
In-Reply-To: 20191105190557.6405-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2405

--===============5642014985716105755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Implement Basic Path Manager

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/basic.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/basic.c b/net/mptcp/basic.c
index 67a93aff500e..86e0d8862c19 100644
--- a/net/mptcp/basic.c
+++ b/net/mptcp/basic.c
@@ -17,7 +17,7 @@ struct basic_pernet {
 =

 	union {
 		struct in_addr announce_v4_addr;
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 		struct in6_addr announce_v6_addr;
 #endif
 	};
@@ -37,7 +37,7 @@ static int parse_addr(struct basic_pernet *pernet, const =
char *addr)
 		pernet->has_announce_v6 =3D 0;
 		return 0;
 	}
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (in6_pton(addr, -1, (u8 *)&pernet->announce_v6_addr.s6_addr, '\0',
 		     NULL) > 0) {
 		pernet->has_announce_v4 =3D 0;
@@ -73,7 +73,7 @@ static int proc_parse_addr(struct ctl_table *ctl, int wri=
te,
 				 &pernet->announce_v4_addr);
 			tbl.data =3D tmp;
 		}
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 		else if (pernet->has_announce_v6) {
 			snprintf(tmp, INET6_ADDRSTRLEN, "%pI6c",
 				 &pernet->announce_v6_addr);
@@ -196,7 +196,7 @@ static void announce_addr_worker(struct work_struct *wo=
rk)
 	if (pernet->has_announce_v4 && msk->family =3D=3D AF_INET)
 		mptcp_pm_announce_addr(pm->token, 1,
 				       &pernet->announce_v4_addr);
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	else if (pernet->has_announce_v6 && msk->family =3D=3D AF_INET6)
 		mptcp_pm_announce_addr6(pm->token, 1,
 					&pernet->announce_v6_addr);
@@ -221,7 +221,7 @@ static void create_subflow_worker(struct work_struct *w=
ork)
 			mptcp_pm_create_subflow(pm->token, pm->remote_id,
 						NULL);
 	}
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	else if (pm->remote_family =3D=3D AF_INET6) {
 		if (pernet->has_announce_v6)
 			mptcp_pm_create_subflow6(pm->token, pm->remote_id,
-- =

2.17.2

--===============5642014985716105755==--
