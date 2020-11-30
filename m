Content-Type: multipart/mixed; boundary="===============7712819818552110514=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] Squash to "[MPTCP][PATCH v7
 mptcp-next 3/7] mptcp: add port number announced check"
Date: Mon, 30 Nov 2020 16:50:33 +0800
Message-ID: <762b36e0733643c56cc777aad288ad969b0bcf20.1606726150.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6985

--===============7712819818552110514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Drop source_address helper.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4f1b7f44c03b..119d7abdc997 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -88,8 +88,8 @@ static bool address_zero(const struct mptcp_addr_info *ad=
dr)
 static void local_address(const struct sock_common *skc,
 			  struct mptcp_addr_info *addr)
 {
-	addr->port =3D 0;
 	addr->family =3D skc->skc_family;
+	addr->port =3D htons(skc->skc_num);
 	if (addr->family =3D=3D AF_INET)
 		addr->addr.s_addr =3D skc->skc_rcv_saddr;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -111,19 +111,6 @@ static void remote_address(const struct sock_common *s=
kc,
 #endif
 }
 =

-static void source_address(struct sock_common *skc,
-			   struct mptcp_addr_info *addr)
-{
-	addr->family =3D skc->skc_family;
-	addr->port =3D htons(skc->skc_num);
-	if (addr->family =3D=3D AF_INET)
-		addr->addr.s_addr =3D skc->skc_rcv_saddr;
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	else if (addr->family =3D=3D AF_INET6)
-		addr->addr6 =3D skc->skc_v6_rcv_saddr;
-#endif
-}
-
 static bool lookup_subflow_by_saddr(const struct list_head *list,
 				    struct mptcp_addr_info *saddr)
 {
@@ -221,7 +208,7 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk=
, const struct sock *sk)
 	struct mptcp_addr_info saddr;
 	bool ret =3D false;
 =

-	source_address((struct sock_common *)sk, &saddr);
+	local_address((struct sock_common *)sk, &saddr);
 =

 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-- =

2.26.2

--===============7712819818552110514==--
