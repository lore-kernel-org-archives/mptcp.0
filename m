Content-Type: multipart/mixed; boundary="===============2947439904204607662=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH net 1/2] mptcp: fix subflow's local_id issues
Date: Mon, 07 Sep 2020 18:29:53 +0800
Message-ID: <f24ee917e4043d2befe2a0f96cd57aa74d2a4b26.1599474422.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5747

--===============2947439904204607662==
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

Reviewed-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2c208d2e65cd..dc2c57860d2d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -66,6 +66,19 @@ static bool addresses_equal(const struct mptcp_addr_info=
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
@@ -323,10 +336,13 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, =
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

--===============2947439904204607662==--
