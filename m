Content-Type: multipart/mixed; boundary="===============7111680156723127230=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 net 1/2] mptcp: fix subflow's local_id issues
Date: Tue, 08 Sep 2020 10:49:38 +0800
Message-ID: <110eaa273bf313fb1a2a668a446956d27aba05a8.1599532593.git.geliangtang@gmail.com>
In-Reply-To: cover.1599532593.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5754

--===============7111680156723127230==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In mptcp_pm_nl_get_local_id, skc_local is the same as msk_local, so it
always return 0. Thus every subflow's local_id is 0. It's incorrect.

This patch fixed this issue.

Also, we need to ignore the zero address here, like 0.0.0.0 in IPv4. When
we use the zero address as a local address, it means that we can use any
one of the local addresses. The zero address is not a new address, we don't
need to add it to PM, so this patch added a new function address_zero to
check whether an address is the zero address, if it is, we ignore this
address.

Fixes: 01cacb00b35cb ("mptcp: add netlink-based PM")
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2c208d2e65cd..3e70d848033d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -66,6 +66,16 @@ static bool addresses_equal(const struct mptcp_addr_info=
 *a,
 	return a->port =3D=3D b->port;
 }
 =

+static bool address_zero(const struct mptcp_addr_info *addr)
+{
+	struct mptcp_addr_info zero;
+
+	memset(&zero, 0, sizeof(zero));
+	zero.family =3D addr->family;
+
+	return addresses_equal(addr, &zero, false);
+}
+
 static void local_address(const struct sock_common *skc,
 			  struct mptcp_addr_info *addr)
 {
@@ -323,10 +333,13 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, =
struct sock_common *skc)
 	 * addr
 	 */
 	local_address((struct sock_common *)msk, &msk_local);
-	local_address((struct sock_common *)msk, &skc_local);
+	local_address((struct sock_common *)skc, &skc_local);
 	if (addresses_equal(&msk_local, &skc_local, false))
 		return 0;
 =

+	if (address_zero(&skc_local))
+		return 0;
+
 	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
 =

 	rcu_read_lock();
-- =

2.17.1

--===============7111680156723127230==--
