Content-Type: multipart/mixed; boundary="===============5337512797256791520=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] Squash to "mptcp: remove id 0
 address"
Date: Mon, 15 Mar 2021 19:44:33 +0800
Message-ID: <c91a096b410d3e05d1b8d8057e7dbc4555fee3b9.1615808638.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 8157

--===============5337512797256791520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hold the msk lock when invoking mptcp_pm_remove_addr.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 037817b83f4c..b7acab673cc7 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1185,7 +1185,9 @@ static int mptcp_nl_remove_id_zero_address(struct net=
 *net,
 			goto next;
 =

 		lock_sock(sk);
+		spin_lock_bh(&msk->pm.lock);
 		mptcp_pm_remove_addr(msk, &list);
+		spin_unlock_bh(&msk->pm.lock);
 		mptcp_pm_remove_subflow(msk, &list);
 		release_sock(sk);
 =

-- =

2.30.2

--===============5337512797256791520==--
