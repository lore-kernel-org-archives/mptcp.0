Content-Type: multipart/mixed; boundary="===============5966452136432695368=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 1/2] mptcp: convert IPv4 address
 to IPv4-mapped
Date: Wed, 16 Dec 2020 15:14:24 +0800
Message-ID: <5df4ef900cea6618e5df0756474ecd5bbae3c9f8.1608102360.git.geliangtang@gmail.com>
In-Reply-To: cover.1608102360.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7182

--===============5966452136432695368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, PM doesn't create subflow with IPv4-mapped IPv6 socket. This
patch converts the IPv4 address to IPv4-mapped IPv6 address to fix it.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index cc4ca013a06b..987e83cdee11 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -133,6 +133,19 @@ static bool lookup_subflow_by_saddr(const struct list_=
head *list,
 	return false;
 }
 =

+static void mptcp_pm_addr_convert_v4mapped(struct mptcp_sock *msk,
+					   struct mptcp_addr_info *addr)
+{
+	struct mptcp_addr_info local;
+
+	local_address((struct sock_common *)msk, &local);
+	if (ipv6_addr_v4mapped(&local.addr6) &&
+	    addr->family =3D=3D AF_INET) {
+		ipv6_addr_set_v4mapped(addr->addr.s_addr, &addr->addr6);
+		addr->family =3D AF_INET6;
+	}
+}
+
 static struct mptcp_pm_addr_entry *
 select_local_address(const struct pm_nl_pernet *pernet,
 		     struct mptcp_sock *msk)
@@ -145,6 +158,8 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		if (!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 			continue;
 =

+		mptcp_pm_addr_convert_v4mapped(msk, &entry->addr);
+
 		/* avoid any address already in use by subflows and
 		 * pending join
 		 */
@@ -159,9 +174,11 @@ select_local_address(const struct pm_nl_pernet *pernet,
 }
 =

 static struct mptcp_pm_addr_entry *
-select_signal_address(struct pm_nl_pernet *pernet, unsigned int pos)
+select_signal_address(struct pm_nl_pernet *pernet,
+		      struct mptcp_sock *msk)
 {
 	struct mptcp_pm_addr_entry *entry, *ret =3D NULL;
+	unsigned int pos =3D msk->pm.add_addr_signaled;
 	int i =3D 0;
 =

 	rcu_read_lock();
@@ -173,6 +190,9 @@ select_signal_address(struct pm_nl_pernet *pernet, unsi=
gned int pos)
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
 		if (!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 			continue;
+
+		mptcp_pm_addr_convert_v4mapped(msk, &entry->addr);
+
 		if (i++ =3D=3D pos) {
 			ret =3D entry;
 			break;
@@ -346,8 +366,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 =

 	/* check first for announce */
 	if (msk->pm.add_addr_signaled < msk->pm.add_addr_signal_max) {
-		local =3D select_signal_address(pernet,
-					      msk->pm.add_addr_signaled);
+		local =3D select_signal_address(pernet, msk);
 =

 		if (local) {
 			if (mptcp_pm_alloc_anno_list(msk, local)) {
-- =

2.29.2

--===============5966452136432695368==--
