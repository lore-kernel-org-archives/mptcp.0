Content-Type: multipart/mixed; boundary="===============5973576986082736851=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 net] mptcp: fix static checker warnings in
 mptcp_pm_add_timer
Date: Mon, 09 Nov 2020 18:44:09 +0800
Message-ID: <6bedbef3c2cb93ab9f3d15e78bd023043a83acbe.1604918403.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6593

--===============5973576986082736851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix the following Smatch complaint:

     net/mptcp/pm_netlink.c:213 mptcp_pm_add_timer()
     warn: variable dereferenced before check 'msk' (see line 208)

 net/mptcp/pm_netlink.c
    207          struct mptcp_sock *msk =3D entry->sock;
    208          struct sock *sk =3D (struct sock *)msk;
    209          struct net *net =3D sock_net(sk);
                                           ^^
 "msk" dereferenced here.

    210
    211          pr_debug("msk=3D%p", msk);
    212
    213          if (!msk)
                    ^^^^
 Too late.

    214                  return;
    215

Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
Reported-by: Dan Carpenter <dan.carpenter(a)oracle.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 v2:
 - fix mptcp_pm_alloc_anno_list too
---
 net/mptcp/pm_netlink.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6180a8b39a3f..59678e59ff46 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -206,7 +206,6 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_pm_add_entry *entry =3D from_timer(entry, timer, add_timer);
 	struct mptcp_sock *msk =3D entry->sock;
 	struct sock *sk =3D (struct sock *)msk;
-	struct net *net =3D sock_net(sk);
 =

 	pr_debug("msk=3D%p", msk);
 =

@@ -235,7 +234,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 =

 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
 		sk_reset_timer(sk, timer,
-			       jiffies + mptcp_get_add_addr_timeout(net));
+			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
 =

 	spin_unlock_bh(&msk->pm.lock);
 =

@@ -267,7 +266,6 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock =
*msk,
 {
 	struct mptcp_pm_add_entry *add_entry =3D NULL;
 	struct sock *sk =3D (struct sock *)msk;
-	struct net *net =3D sock_net(sk);
 =

 	if (lookup_anno_list_by_saddr(msk, &entry->addr))
 		return false;
@@ -284,7 +282,7 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock =
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

--===============5973576986082736851==--
