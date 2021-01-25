Content-Type: multipart/mixed; boundary="===============1747039249611134785=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 2/5] mptcp: pm nl: support IPv4 mapped in v6
 addresses
Date: Mon, 25 Jan 2021 10:59:01 -0800
Message-ID: <20210125185904.6997-3-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210125185904.6997-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7478

--===============1747039249611134785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Matthieu Baerts <matthieu.baerts(a)tessares.net>

On one side, we can allow the creation of subflows between v4 mapped in
v6 and v4 addresses. For that we look for v4mapped addresses between the
local address we want to select and the remote one.

On the other side, we also properly deal with received v4mapped
addresses, either announced ones or set via Netlink.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/122
Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Co-developed-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/pm_netlink.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9b1f6298bbdb..f0afff6ba015 100644
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
@@ -137,6 +142,7 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		     struct mptcp_sock *msk)
 {
 	struct mptcp_pm_addr_entry *entry, *ret =3D NULL;
+	struct sock *sk =3D (struct sock *)msk;
 =

 	rcu_read_lock();
 	__mptcp_flush_join_list(msk);
@@ -144,11 +150,20 @@ select_local_address(const struct pm_nl_pernet *perne=
t,
 		if (!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 			continue;
 =

+		if (entry->addr.family !=3D sk->sk_family) {
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+			if ((entry->addr.family =3D=3D AF_INET &&
+			     !ipv6_addr_v4mapped(&sk->sk_v6_daddr)) ||
+			    (sk->sk_family =3D=3D AF_INET &&
+			     !ipv6_addr_v4mapped(&entry->addr.addr6)))
+#endif
+				continue;
+		}
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
-- =

2.30.0

--===============1747039249611134785==--
