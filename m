Content-Type: multipart/mixed; boundary="===============4172413369987231830=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH net] mptcp: fix static checker warnings in
 mptcp_pm_add_timer
Date: Mon, 09 Nov 2020 18:13:12 +0800
Message-ID: <81e64bc4a6891edcff237ef76f7c10ebb2873957.1604916744.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6591

--===============4172413369987231830==
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

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Reported-by: Dan Carpenter <dan.carpenter(a)oracle.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6180a8b39a3f..03f2c28f11f5 100644
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

-- =

2.26.2

--===============4172413369987231830==--
