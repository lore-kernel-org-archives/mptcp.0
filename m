Content-Type: multipart/mixed; boundary="===============5819050807679374545=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v8 mptcp-next 4/8] mptcp: fix every subflow's
 local_id is zero
Date: Mon, 24 Aug 2020 19:36:17 +0800
Message-ID: <590246ec608c7822ed0a74a78e16443d65183d23.1598267961.git.geliangtang@gmail.com>
In-Reply-To: cover.1598267961.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5609

--===============5819050807679374545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

skc_local is the same as msk_local, so mptcp_pm_nl_get_local_id always
return 0. Thus every subflow's local_id is 0.

This patch fixed this issue.

Also, we need to ignore the zero address here, like 0.0.0.0 in IPv4, when
we use the zero address as a local address, we means that we can use
any one of the local addresses. The zero address is not a new address,
we don't need to add it to PM, so this patch added a new function
address_zero to check whether an address is the zero address, if it is,
we ignore this address.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b3771a188a4c..cd37d94a30fe 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -64,6 +64,19 @@ static bool addresses_equal(const struct mptcp_addr_info=
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
+	if (addresses_equal(addr, &zero, false))
+		return true;
+
+	return false;
+}
+
 static void local_address(const struct sock_common *skc,
 			  struct mptcp_addr_info *addr)
 {
@@ -387,10 +400,13 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, =
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

--===============5819050807679374545==--
