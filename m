Content-Type: multipart/mixed; boundary="===============8524502545205298366=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 4/5] mptcp: Update path manager interface commands for
 IPv6
Date: Tue, 15 Oct 2019 16:06:12 -0700
Message-ID: <20191015230613.16981-5-peter.krystad@linux.intel.com>
In-Reply-To: 20191015230613.16981-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2161

--===============8524502545205298366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Implement path manager interface commands

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/pm.c | 75 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index bc46a0ddd396..b14308ad11a3 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -23,11 +23,11 @@ int mptcp_pm_announce_addr(u32 token, u8 local_id, stru=
ct in_addr *addr)
 		goto announce_put;
 	}
 =

-	pr_debug("msk=3D%p, local_id=3D%d, addr=3D%x", msk, local_id, addr->s_add=
r);
+	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
 	msk->pm.local_valid =3D 1;
 	msk->pm.local_id =3D local_id;
-	msk->pm.local_family =3D family;
-	msk->pm.local_addr.s_addr =3D addr->s_addr;
+	msk->pm.local_family =3D AF_INET;
+	msk->pm.local_addr =3D *addr;
 	msk->addr_signal =3D 1;
 =

 announce_put:
@@ -38,7 +38,27 @@ int mptcp_pm_announce_addr(u32 token, u8 local_id, struc=
t in_addr *addr)
 #if IS_ENABLED(CONFIG_IPV6)
 int mptcp_pm_announce_addr6(u32 token, u8 local_id, struct in6_addr *addr)
 {
-	return -ENOTSUPP;
+	struct mptcp_sock *msk =3D mptcp_token_get_sock(token);
+	int err =3D 0;
+
+	if (!msk)
+		return -EINVAL;
+
+	if (msk->pm.local_valid) {
+		err =3D -EBADR;
+		goto announce_put;
+	}
+
+	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
+	msk->pm.local_valid =3D 1;
+	msk->pm.local_id =3D local_id;
+	msk->pm.local_family =3D AF_INET6;
+	msk->pm.local_addr6 =3D *addr;
+	msk->addr_signal =3D 1;
+
+announce_put:
+	sock_put((struct sock *)msk);
+	return err;
 }
 #endif
 =

@@ -75,17 +95,18 @@ int mptcp_pm_create_subflow(u32 token, u8 remote_id, st=
ruct in_addr *addr)
 =

 	local.sin_family =3D AF_INET;
 	local.sin_port =3D 0;
-	if (family =3D=3D AF_INET)
-		local.sin_addr.s_addr =3D addr->s_addr;
+	if (!addr)
+		local.sin_addr =3D *addr;
 	else
 		local.sin_addr.s_addr =3D htonl(INADDR_ANY);
 =

 	remote.sin_family =3D msk->pm.remote_family;
 	remote.sin_port =3D htons(msk->dport);
-	remote.sin_addr.s_addr =3D msk->pm.remote_addr.s_addr;
+	remote.sin_addr =3D msk->pm.remote_addr;
 =

-	err =3D mptcp_subflow_connect((struct sock *)msk, &local, &remote,
-				    remote_id);
+	err =3D mptcp_subflow_connect((struct sock *)msk,
+				    (struct sockaddr *)&local,
+				    (struct sockaddr *)&remote, remote_id);
 =

 create_put:
 	sock_put((struct sock *)msk);
@@ -95,7 +116,39 @@ int mptcp_pm_create_subflow(u32 token, u8 remote_id, st=
ruct in_addr *addr)
 #if IS_ENABLED(CONFIG_IPV6)
 int mptcp_pm_create_subflow6(u32 token, u8 remote_id, struct in6_addr *add=
r)
 {
-	return -ENOTSUPP;
+	struct mptcp_sock *msk =3D mptcp_token_get_sock(token);
+	struct sockaddr_in6 remote;
+	struct sockaddr_in6 local;
+	int err;
+
+	if (!msk)
+		return -EINVAL;
+
+	pr_debug("msk=3D%p", msk);
+
+	if (!msk->pm.remote_valid || remote_id !=3D msk->pm.remote_id) {
+		err =3D -EBADR;
+		goto create_put;
+	}
+
+	local.sin6_family =3D AF_INET6;
+	local.sin6_port =3D 0;
+	if (!addr)
+		local.sin6_addr =3D *addr;
+	else
+		local.sin6_addr =3D in6addr_any;
+
+	remote.sin6_family =3D msk->pm.remote_family;
+	remote.sin6_port =3D htons(msk->dport);
+	remote.sin6_addr =3D msk->pm.remote_addr6;
+
+	err =3D mptcp_subflow_connect((struct sock *)msk,
+				    (struct sockaddr *)&local,
+				    (struct sockaddr *)&remote, remote_id);
+
+create_put:
+	sock_put((struct sock *)msk);
+	return err;
 }
 #endif
 =

@@ -151,7 +204,7 @@ void mptcp_pm_add_addr(struct mptcp_sock *msk, const st=
ruct in_addr *addr,
 =

 	pr_debug("msk=3D%p, addr=3D%x, remote_id=3D%d", msk, addr->s_addr, id);
 =

-	pm->remote_addr.s_addr =3D addr->s_addr;
+	pm->remote_addr =3D *addr;
 	pm->remote_id =3D id;
 	pm->remote_family =3D AF_INET;
 =

-- =

2.17.2

--===============8524502545205298366==--
