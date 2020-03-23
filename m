Content-Type: multipart/mixed; boundary="===============7899928019728696945=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp:netlink: fix compilation warning
Date: Mon, 23 Mar 2020 20:46:44 +0100
Message-ID: <20200323194644.1021740-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4049

--===============7899928019728696945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

  net/mptcp/pm_netlink.c: In function =E2=80=98mptcp_pm_nl_add_addr_receive=
d=E2=80=99:
  net/mptcp/pm_netlink.c:238:23: warning: variable =E2=80=98pernet=E2=80=99=
 set but not used [-Wunused-but-set-variable]
    238 |  struct pm_nl_pernet *pernet;
        |                       ^~~~~~

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: add netlink-based PM"

 net/mptcp/pm_netlink.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4bab1b32f932..743c3c58f826 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -235,9 +235,6 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *m=
sk)
 	struct sock *sk =3D (struct sock *)msk;
 	struct mptcp_addr_info remote;
 	struct mptcp_addr_info local;
-	struct pm_nl_pernet *pernet;
-
-	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
 =

 	pr_debug("accepted %d:%d remote family %d",
 		 msk->pm.add_addr_accepted, msk->pm.add_addr_accept_max,
-- =

2.25.1

--===============7899928019728696945==--
