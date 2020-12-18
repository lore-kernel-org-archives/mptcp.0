Content-Type: multipart/mixed; boundary="===============7018487164663264483=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 1/2] mptcp: convert IPv4 address
 with IPv4-mapped address
Date: Fri, 18 Dec 2020 19:17:34 +0800
Message-ID: <37a81f89faa38ee33531bc7b795e4fc19377fd85.1608289899.git.geliangtang@gmail.com>
In-Reply-To: cover.1608289899.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7214

--===============7018487164663264483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, PM doesn't create subflow with IPv4-mapped IPv6 socket. This
patch added IPv4-mapped Ipv6 address support, by converting the IPv4
address with IPv4-mapped IPv6 address.

Co-developed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 21 ++++++++++++---------
 net/mptcp/subflow.c    | 22 +++++++++++++++-------
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9b1f6298bbdb..9c688023f494 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -60,15 +60,19 @@ static bool addresses_equal(const struct mptcp_addr_inf=
o *a,
 {
 	bool addr_equals =3D false;
 =

-	if (a->family !=3D b->family)
-		return false;
-
-	if (a->family =3D=3D AF_INET)
-		addr_equals =3D a->addr.s_addr =3D=3D b->addr.s_addr;
+	if (a->family =3D=3D b->family) {
+		if (a->family =3D=3D AF_INET)
+			addr_equals =3D a->addr.s_addr =3D=3D b->addr.s_addr;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	else
-		addr_equals =3D !ipv6_addr_cmp(&a->addr6, &b->addr6);
+		else
+			addr_equals =3D !ipv6_addr_cmp(&a->addr6, &b->addr6);
+	} else {
+		if (a->family =3D=3D AF_INET && ipv6_addr_v4mapped(&b->addr6))
+			addr_equals =3D a->addr.s_addr =3D=3D b->addr6.s6_addr32[3];
+		if (b->family =3D=3D AF_INET && ipv6_addr_v4mapped(&a->addr6))
+			addr_equals =3D a->addr6.s6_addr32[3] =3D=3D b->addr.s_addr;
 #endif
+	}
 =

 	if (!addr_equals)
 		return false;
@@ -147,8 +151,7 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		/* avoid any address already in use by subflows and
 		 * pending join
 		 */
-		if (entry->addr.family =3D=3D ((struct sock *)msk)->sk_family &&
-		    !lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) {
+		if (!lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) {
 			ret =3D entry;
 			break;
 		}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 278cbe3e539e..8586d95310e2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1074,21 +1074,29 @@ void mptcpv6_handle_mapped(struct sock *sk, bool ma=
pped)
 #endif
 =

 static void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
-				struct sockaddr_storage *addr)
+				struct sockaddr_storage *addr,
+				unsigned short family)
 {
 	memset(addr, 0, sizeof(*addr));
-	addr->ss_family =3D info->family;
+	addr->ss_family =3D family;
 	if (addr->ss_family =3D=3D AF_INET) {
 		struct sockaddr_in *in_addr =3D (struct sockaddr_in *)addr;
 =

-		in_addr->sin_addr =3D info->addr;
+		if (info->family =3D=3D AF_INET)
+			in_addr->sin_addr =3D info->addr;
+		else
+			in_addr->sin_addr.s_addr =3D info->addr6.s6_addr32[3];
 		in_addr->sin_port =3D info->port;
 	}
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	else if (addr->ss_family =3D=3D AF_INET6) {
 		struct sockaddr_in6 *in6_addr =3D (struct sockaddr_in6 *)addr;
 =

-		in6_addr->sin6_addr =3D info->addr6;
+		if (info->family =3D=3D AF_INET)
+			ipv6_addr_set_v4mapped(info->addr.s_addr,
+					       &in6_addr->sin6_addr);
+		else
+			in6_addr->sin6_addr =3D info->addr6;
 		in6_addr->sin6_port =3D info->port;
 	}
 #endif
@@ -1132,11 +1140,11 @@ int __mptcp_subflow_connect(struct sock *sk, const =
struct mptcp_addr_info *loc,
 	subflow->remote_key =3D msk->remote_key;
 	subflow->local_key =3D msk->local_key;
 	subflow->token =3D msk->token;
-	mptcp_info2sockaddr(loc, &addr);
+	mptcp_info2sockaddr(loc, &addr, ssk->sk_family);
 =

 	addrlen =3D sizeof(struct sockaddr_in);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	if (loc->family =3D=3D AF_INET6)
+	if (addr.ss_family =3D=3D AF_INET6)
 		addrlen =3D sizeof(struct sockaddr_in6);
 #endif
 	ssk->sk_bound_dev_if =3D loc->ifindex;
@@ -1152,7 +1160,7 @@ int __mptcp_subflow_connect(struct sock *sk, const st=
ruct mptcp_addr_info *loc,
 	subflow->remote_id =3D remote_id;
 	subflow->request_join =3D 1;
 	subflow->request_bkup =3D !!(loc->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
-	mptcp_info2sockaddr(remote, &addr);
+	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
 =

 	mptcp_add_pending_subflow(msk, subflow);
 	err =3D kernel_connect(sf, (struct sockaddr *)&addr, addrlen, O_NONBLOCK);
-- =

2.29.2

--===============7018487164663264483==--
