Content-Type: multipart/mixed; boundary="===============6696757847562973633=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] mptcp: enable use_port when invoke
 addresses_equal
Date: Mon, 30 Nov 2020 18:47:57 +0800
Message-ID: <3c45510c7fadc886e30e528501db5f861539c390.1606733035.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6986

--===============6696757847562973633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When dealing with the addresses list local_addr_list or anno_list, we
should enables the function addresses_equal's parameter use_port.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 The patch should be inserted into the "ADD_ADDR: ports support" patchset
after the 3rd patch "mptcp: add port number announced check".
---
 net/mptcp/pm_netlink.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 119d7abdc997..54c6b6359144 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -122,7 +122,7 @@ static bool lookup_subflow_by_saddr(const struct list_h=
ead *list,
 		skc =3D (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 =

 		local_address(skc, &cur);
-		if (addresses_equal(&cur, saddr, false))
+		if (addresses_equal(&cur, saddr, saddr->port))
 			return true;
 	}
 =

@@ -195,7 +195,7 @@ lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 	struct mptcp_pm_add_entry *entry;
 =

 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (addresses_equal(&entry->addr, addr, false))
+		if (addresses_equal(&entry->addr, addr, true))
 			return entry;
 	}
 =

@@ -604,7 +604,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, st=
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

2.26.2

--===============6696757847562973633==--
