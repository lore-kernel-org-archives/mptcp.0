Content-Type: multipart/mixed; boundary="===============8351922168136337698=="
MIME-Version: 1.0
From: Colin King <colin.king at canonical.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH][next] mptcp: fix a dereference of pointer before msk
 is null checked.
Date: Mon, 09 Nov 2020 12:52:15 +0000
Message-ID: <20201109125215.2080172-1-colin.king@canonical.com>
X-Status: 
X-Keywords:                  
X-UID: 6596

--===============8351922168136337698==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Colin Ian King <colin.king(a)canonical.com>

Currently the assignment of pointer net from the sock_net(sk) call
is potentially dereferencing a null pointer sk. sk points to the
same location as pointer msk and msk is being null checked after
the sock_net call.  Fix this by calling sock_net after the null
check on pointer msk.

Addresses-Coverity: ("Dereference before null check")
Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
---
 net/mptcp/pm_netlink.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ed60538df7b2..e76879ea5a30 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -206,13 +206,15 @@ static void mptcp_pm_add_timer(struct timer_list *tim=
er)
 	struct mptcp_pm_add_entry *entry =3D from_timer(entry, timer, add_timer);
 	struct mptcp_sock *msk =3D entry->sock;
 	struct sock *sk =3D (struct sock *)msk;
-	struct net *net =3D sock_net(sk);
+	struct net *net;
 =

 	pr_debug("msk=3D%p", msk);
 =

 	if (!msk)
 		return;
 =

+	net =3D sock_net(sk);
+
 	if (inet_sk_state_load(sk) =3D=3D TCP_CLOSE)
 		return;
 =

-- =

2.28.0

--===============8351922168136337698==--
