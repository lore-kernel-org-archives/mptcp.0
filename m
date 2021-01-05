Content-Type: multipart/mixed; boundary="===============5123234292334131189=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v9 mptcp-next 5/9] mptcp: enable use_port when
 invoke addresses_equal
Date: Tue, 05 Jan 2021 13:33:26 +0800
Message-ID: <7d34ed954f24da0f96d43c26d5e036d56c1e8e37.1609820648.git.geliangtang@gmail.com>
In-Reply-To: 6362757e12a4dbd320abefe4a111afb1e0f869b0.1609820648.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7261

--===============5123234292334131189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When dealing with the addresses list local_addr_list or anno_list, we
should enable the function addresses_equal's parameter use_port. And
enable it in address_zero too.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 93d24f9cc881..c763ee466bf9 100644
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

@@ -245,7 +245,7 @@ lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 	struct mptcp_pm_add_entry *entry;
 =

 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (addresses_equal(&entry->addr, addr, false))
+		if (addresses_equal(&entry->addr, addr, true))
 			return entry;
 	}
 =

@@ -768,7 +768,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, st=
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

2.29.2

--===============5123234292334131189==--
