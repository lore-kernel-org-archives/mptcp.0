Content-Type: multipart/mixed; boundary="===============8121856354249436223=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 11/16] mptcp: enable use_port when invoke
 addresses_equal
Date: Thu, 28 Jan 2021 17:11:10 -0800
Message-ID: <20210129011115.133953-12-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210129011115.133953-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7520

--===============8121856354249436223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

When dealing with the addresses list local_addr_list or anno_list, we
should enable the function addresses_equal's parameter use_port. And
enable it in address_zero too.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/pm_netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d6e23e079fb0..5b045023fe15 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -91,7 +91,7 @@ static bool address_zero(const struct mptcp_addr_info *ad=
dr)
 	memset(&zero, 0, sizeof(zero));
 	zero.family =3D addr->family;
 =

-	return addresses_equal(addr, &zero, false);
+	return addresses_equal(addr, &zero, true);
 }
 =

 static void local_address(const struct sock_common *skc,
@@ -131,7 +131,7 @@ static bool lookup_subflow_by_saddr(const struct list_h=
ead *list,
 		skc =3D (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 =

 		local_address(skc, &cur);
-		if (addresses_equal(&cur, saddr, false))
+		if (addresses_equal(&cur, saddr, saddr->port))
 			return true;
 	}
 =

@@ -247,7 +247,7 @@ lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 	struct mptcp_pm_add_entry *entry;
 =

 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (addresses_equal(&entry->addr, addr, false))
+		if (addresses_equal(&entry->addr, addr, true))
 			return entry;
 	}
 =

@@ -773,7 +773,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, st=
ruct sock_common *skc)
 =

 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (addresses_equal(&entry->addr, &skc_local, false)) {
+		if (addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
 			ret =3D entry->addr.id;
 			break;
 		}
-- =

2.30.0

--===============8121856354249436223==--
