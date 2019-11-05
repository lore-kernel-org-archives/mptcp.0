Content-Type: multipart/mixed; boundary="===============0124558600601828658=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/5] mptcp: Switch to CONFIG_MPTCP_IPV6
Date: Tue, 05 Nov 2019 11:05:55 -0800
Message-ID: <20191105190557.6405-3-peter.krystad@linux.intel.com>
In-Reply-To: 20191105190557.6405-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2403

--===============0124558600601828658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Add Path Manager Interface

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c  | 2 +-
 net/mptcp/pm.c       | 8 ++++----
 net/mptcp/protocol.h | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1b08e1193991..5b6df7aead1d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -599,7 +599,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 	if (msk && mp_opt->add_addr) {
 		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4)
 			mptcp_pm_add_addr(msk, &mp_opt->addr, mp_opt->addr_id);
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 		else if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6)
 			mptcp_pm_add_addr6(msk, &mp_opt->addr6,
 					   mp_opt->addr_id);
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d45406bc3f6c..7e493d81afef 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -35,7 +35,7 @@ int mptcp_pm_announce_addr(u32 token, u8 local_id, struct=
 in_addr *addr)
 	return err;
 }
 =

-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 int mptcp_pm_announce_addr6(u32 token, u8 local_id, struct in6_addr *addr)
 {
 	struct mptcp_sock *msk =3D mptcp_token_get_sock(token);
@@ -113,7 +113,7 @@ int mptcp_pm_create_subflow(u32 token, u8 remote_id, st=
ruct in_addr *addr)
 	return err;
 }
 =

-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 int mptcp_pm_create_subflow6(u32 token, u8 remote_id, struct in6_addr *add=
r)
 {
 	struct mptcp_sock *msk =3D mptcp_token_get_sock(token);
@@ -224,7 +224,7 @@ void mptcp_pm_add_addr6(struct mptcp_sock *msk, const s=
truct in6_addr *addr,
 int mptcp_pm_addr_signal(struct mptcp_sock *msk, u8 *id,
 			 struct sockaddr_storage *saddr)
 {
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	struct sockaddr_in6 *addr6 =3D (struct sockaddr_in6 *)saddr;
 #endif
 	struct sockaddr_in *addr =3D (struct sockaddr_in *)saddr;
@@ -235,7 +235,7 @@ int mptcp_pm_addr_signal(struct mptcp_sock *msk, u8 *id,
 	if (msk->pm.local_family =3D=3D AF_INET) {
 		addr->sin_family =3D msk->pm.local_family;
 		addr->sin_addr =3D msk->pm.local_addr;
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	} else if (msk->pm.local_family =3D=3D AF_INET6) {
 		addr6->sin6_family =3D msk->pm.local_family;
 		addr6->sin6_addr =3D msk->pm.local_addr6;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8fe5f9383d38..717579006051 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -89,7 +89,7 @@ struct mptcp_pm_data {
 	sa_family_t local_family;
 	union {
 		struct in_addr local_addr;
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 		struct in6_addr local_addr6;
 #endif
 	};
@@ -98,7 +98,7 @@ struct mptcp_pm_data {
 	sa_family_t remote_family;
 	union {
 		struct in_addr remote_addr;
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 		struct in6_addr remote_addr6;
 #endif
 	};
@@ -323,7 +323,7 @@ void mptcp_pm_add_addr6(struct mptcp_sock *msk, const s=
truct in6_addr *addr,
 =

 int mptcp_pm_announce_addr(u32 token, u8 local_id, struct in_addr *addr);
 int mptcp_pm_create_subflow(u32 token, u8 remote_id, struct in_addr *addr);
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 int mptcp_pm_announce_addr6(u32 token, u8 local_id, struct in6_addr *addr);
 int mptcp_pm_create_subflow6(u32 token, u8 remote_id, struct in6_addr *add=
r);
 #endif
-- =

2.17.2

--===============0124558600601828658==--
