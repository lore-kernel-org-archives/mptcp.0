Content-Type: multipart/mixed; boundary="===============4844877288900802401=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v5 1/4] mptcp: support MPJoin with IPv4
 mapped in v6 sk
Date: Wed, 13 Jan 2021 18:54:50 +0100
Message-ID: <20210113175453.1945886-2-matthieu.baerts@tessares.net>
In-Reply-To: 20210113175453.1945886-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7343

--===============4844877288900802401==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With an IPv4 mapped in v6 socket, we were trying to call inet6_bind()
with an IPv4 address resulting in a -EINVAL error because the given
addr_len -- size of the address structure -- was too short.

We now make sure to use address structures for the same family as the
MPTCP socket for both the bind() and the connect(). It means we convert
v4 addresses to v4 mapped in v6 or the opposite if needed.

Fixes: ec3edaa7ca6c ("mptcp: Add handling of outgoing MP_JOIN requests")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/122
Co-developed-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/subflow.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 278cbe3e539e..8dc4d9f86773 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1074,21 +1074,31 @@ void mptcpv6_handle_mapped(struct sock *sk, bool ma=
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
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+		else if (ipv6_addr_v4mapped(&info->addr6))
+			in_addr->sin_addr.s_addr =3D info->addr6.s6_addr32[3];
+#endif
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
@@ -1132,11 +1142,11 @@ int __mptcp_subflow_connect(struct sock *sk, const =
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
@@ -1152,7 +1162,7 @@ int __mptcp_subflow_connect(struct sock *sk, const st=
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

--===============4844877288900802401==--
