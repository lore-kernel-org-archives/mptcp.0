Content-Type: multipart/mixed; boundary="===============8599186842906550742=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH net 2/2] mptcp: cleanup for
 mptcp_pm_alloc_anno_list
Date: Mon, 09 Nov 2020 21:59:22 +0800
Message-ID: <0f17d2f60c188554d093e820c45caf20fe53aab0.1604930005.git.geliangtang@gmail.com>
In-Reply-To: ccf004469e02fb5bd7ec822414b9a98b0015f4a3.1604930005.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6599

--===============8599186842906550742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added NULL pointer check for mptcp_pm_alloc_anno_list, and
avoided similar static checker warnings in mptcp_pm_add_timer.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter(a)oracle.com>
---
 net/mptcp/pm_netlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 03f2c28f11f5..dfc1bed4a55f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -266,7 +266,9 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock =
*msk,
 {
 	struct mptcp_pm_add_entry *add_entry =3D NULL;
 	struct sock *sk =3D (struct sock *)msk;
-	struct net *net =3D sock_net(sk);
+
+	if (!msk)
+		return false;
 =

 	if (lookup_anno_list_by_saddr(msk, &entry->addr))
 		return false;
@@ -283,7 +285,7 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock =
*msk,
 =

 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 	sk_reset_timer(sk, &add_entry->add_timer,
-		       jiffies + mptcp_get_add_addr_timeout(net));
+		       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
 =

 	return true;
 }
-- =

2.26.2

--===============8599186842906550742==--
