Content-Type: multipart/mixed; boundary="===============3850801529037639550=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 net-next] mptcp: fix static checker warnings
 in mptcp_pm_add_timer
Date: Tue, 10 Nov 2020 11:01:43 +0800
Message-ID: <078a2ef5bdc4e3b2c25ef852461692001f426495.1604976945.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6626

--===============3850801529037639550==
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
Reviewed-by: Dan Carpenter <dan.carpenter(a)oracle.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 v2:
 - drop "mptcp: cleanup for mptcp_pm_alloc_anno_list"
 - change tag to net-next.
This patch should be applied to net-next, not -net. Since commit "mptcp:
add a new sysctl add_addr_timeout" is not applied to -net yet.
---
 net/mptcp/pm_netlink.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ed60538df7b2..446ef8f07734 100644
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

@@ -234,7 +233,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
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

--===============3850801529037639550==--
