Content-Type: multipart/mixed; boundary="===============0256739058924258266=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/5] mptcp: Update path manager interface for IPv6
Date: Tue, 15 Oct 2019 16:06:09 -0700
Message-ID: <20191015230613.16981-2-peter.krystad@linux.intel.com>
In-Reply-To: 20191015230613.16981-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2159

--===============0256739058924258266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Add path manager interface

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/pm.c       | 35 +++++++++++++++++++++++++++--------
 net/mptcp/protocol.h | 11 +++++++----
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f20377c869ad..bc46a0ddd396 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -10,8 +10,7 @@
 =

 /* path manager command handlers */
 =

-int mptcp_pm_announce_addr(u32 token, u8 local_id, sa_family_t family,
-			   struct in_addr *addr)
+int mptcp_pm_announce_addr(u32 token, u8 local_id, struct in_addr *addr)
 {
 	struct mptcp_sock *msk =3D mptcp_token_get_sock(token);
 	int err =3D 0;
@@ -36,6 +35,13 @@ int mptcp_pm_announce_addr(u32 token, u8 local_id, sa_fa=
mily_t family,
 	return err;
 }
 =

+#if IS_ENABLED(CONFIG_IPV6)
+int mptcp_pm_announce_addr6(u32 token, u8 local_id, struct in6_addr *addr)
+{
+	return -ENOTSUPP;
+}
+#endif
+
 int mptcp_pm_remove_addr(u32 token, u8 local_id)
 {
 	struct mptcp_sock *msk =3D mptcp_token_get_sock(token);
@@ -50,8 +56,7 @@ int mptcp_pm_remove_addr(u32 token, u8 local_id)
 	return 0;
 }
 =

-int mptcp_pm_create_subflow(u32 token, u8 remote_id, sa_family_t family,
-			    struct in_addr *addr)
+int mptcp_pm_create_subflow(u32 token, u8 remote_id, struct in_addr *addr)
 {
 	struct mptcp_sock *msk =3D mptcp_token_get_sock(token);
 	struct sockaddr_in remote;
@@ -87,6 +92,13 @@ int mptcp_pm_create_subflow(u32 token, u8 remote_id, sa_=
family_t family,
 	return err;
 }
 =

+#if IS_ENABLED(CONFIG_IPV6)
+int mptcp_pm_create_subflow6(u32 token, u8 remote_id, struct in6_addr *add=
r)
+{
+	return -ENOTSUPP;
+}
+#endif
+
 int mptcp_pm_remove_subflow(u32 token, u8 remote_id)
 {
 	return -ENOTSUPP;
@@ -160,16 +172,23 @@ int mptcp_pm_addr_signal(struct mptcp_sock *msk, u8 *=
id,
 			 struct sockaddr_storage *saddr)
 {
 	struct sockaddr_in *addr =3D (struct sockaddr_in *)saddr;
+	struct sockaddr_in6 *addr6 =3D (struct sockaddr_in6 *)saddr;
 =

 	if (!msk->pm.local_valid)
 		return -1;
 =

-	if (msk->pm.local_family !=3D AF_INET)
+	if (msk->pm.local_family =3D=3D AF_INET) {
+		addr->sin_family =3D msk->pm.local_family;
+		addr->sin_addr =3D msk->pm.local_addr;
+#if IS_ENABLED(CONFIG_IPV6)
+	} else if (msk->pm.local_family =3D=3D AF_INET6) {
+		addr6->sin6_family =3D msk->pm.local_family;
+		addr6->sin6_addr =3D msk->pm.local_addr6;
+#endif
+	} else {
 		return -1;
-
+	}
 	*id =3D msk->pm.local_id;
-	addr->sin_family =3D msk->pm.local_family;
-	addr->sin_addr.s_addr =3D msk->pm.local_addr.s_addr;
 =

 	return 0;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d81d6bf18a65..2bfcb65c7c0a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -297,10 +297,13 @@ void mptcp_pm_add_addr(struct mptcp_sock *msk, const =
struct in_addr *addr,
 		       u8 id);
 void mptcp_pm_add_addr6(struct mptcp_sock *msk, const struct in6_addr *add=
r,
 			u8 id);
-int mptcp_pm_announce_addr(u32 token, u8 local_id, sa_family_t family,
-			   struct in_addr *addr);
-int mptcp_pm_create_subflow(u32 token, u8 remote_id, sa_family_t family,
-			    struct in_addr *addr);
+
+int mptcp_pm_announce_addr(u32 token, u8 local_id, struct in_addr *addr);
+int mptcp_pm_create_subflow(u32 token, u8 remote_id, struct in_addr *addr);
+#if IS_ENABLED(CONFIG_IPV6)
+int mptcp_pm_announce_addr6(u32 token, u8 local_id, struct in6_addr *addr);
+int mptcp_pm_create_subflow6(u32 token, u8 remote_id, struct in6_addr *add=
r);
+#endif
 int mptcp_pm_remove_addr(u32 token, u8 local_id);
 int mptcp_pm_remove_subflow(u32 token, u8 remote_id);
 =

-- =

2.17.2

--===============0256739058924258266==--
