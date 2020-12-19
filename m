Content-Type: multipart/mixed; boundary="===============9068383884753865406=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v4 2/3] mptcp: pm nl: support IPv4 mapped
 in v6 addresses
Date: Sat, 19 Dec 2020 14:06:59 +0100
Message-ID: <20201219130700.1053584-3-matthieu.baerts@tessares.net>
In-Reply-To: 20201219130700.1053584-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7228

--===============9068383884753865406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On one side, we can allow the creation of subflows between v4 mapped in
v6 and v4 addresses. For that we look for v4mapped addresses between the
local address we want to select and the remote one.

On the other side, we also properly deal with received v4mapped
addresses, either announced ones or set via Netlink.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/122
Co-developed-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/pm_netlink.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9b1f6298bbdb..6ef00b3799d4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -60,15 +60,20 @@ static bool addresses_equal(const struct mptcp_addr_inf=
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
+	} else if (a->family =3D=3D AF_INET) {
+		if (ipv6_addr_v4mapped(&b->addr6))
+			addr_equals =3D a->addr.s_addr =3D=3D b->addr6.s6_addr32[3];
+	} else if (b->family =3D=3D AF_INET) {
+		if (ipv6_addr_v4mapped(&a->addr6))
+			addr_equals =3D a->addr6.s6_addr32[3] =3D=3D b->addr.s_addr;
 #endif
+	}
 =

 	if (!addr_equals)
 		return false;
@@ -133,8 +138,8 @@ static bool lookup_subflow_by_saddr(const struct list_h=
ead *list,
 }
 =

 static struct mptcp_pm_addr_entry *
-select_local_address(const struct pm_nl_pernet *pernet,
-		     struct mptcp_sock *msk)
+select_local_address(const struct pm_nl_pernet *pernet, struct mptcp_sock =
*msk,
+		     struct mptcp_addr_info *remote)
 {
 	struct mptcp_pm_addr_entry *entry, *ret =3D NULL;
 =

@@ -144,11 +149,19 @@ select_local_address(const struct pm_nl_pernet *perne=
t,
 		if (!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 			continue;
 =

+		if (entry->addr.family !=3D remote->family)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+			if ((entry->addr.family =3D=3D AF_INET &&
+			     !ipv6_addr_v4mapped(&remote->addr6)) ||
+			    (remote->family =3D=3D AF_INET &&
+			     !ipv6_addr_v4mapped(&entry->addr.addr6)))
+#endif
+				continue;
+
 		/* avoid any address already in use by subflows and
 		 * pending join
 		 */
-		if (entry->addr.family =3D=3D ((struct sock *)msk)->sk_family &&
-		    !lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) {
+		if (!lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) {
 			ret =3D entry;
 			break;
 		}
@@ -346,7 +359,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 	    msk->pm.subflows < msk->pm.subflows_max) {
 		remote_address((struct sock_common *)sk, &remote);
 =

-		local =3D select_local_address(pernet, msk);
+		local =3D select_local_address(pernet, msk, &remote);
 		if (local) {
 			msk->pm.local_addr_used++;
 			msk->pm.subflows++;
-- =

2.29.2

--===============9068383884753865406==--
