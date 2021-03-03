Content-Type: multipart/mixed; boundary="===============6356659267081742427=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 1/4] mptcp: remove all subflows
 involving id 0 address
Date: Wed, 03 Mar 2021 15:48:58 +0800
Message-ID: <751c42fd164f37ff6f7af4f009285c7c7a920470.1614757087.git.geliangtang@gmail.com>
In-Reply-To: cover.1614757087.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7986

--===============6356659267081742427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There's only one subflow involving the non-zero id address, but there
may be multi subflows involving the id 0 address.

Here's an example:

 local_id=3D0, remote_id=3D0
 local_id=3D1, remote_id=3D0
 local_id=3D0, remote_id=3D1

If the removing address id is 0, all the subflows involving the id 0
address need to be removed.

In mptcp_pm_nl_rm_addr_received/mptcp_pm_nl_rm_subflow_received, the
"break" prevents the iteration to the next subflow, so this patch
dropped them.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 328fdcc35bfd..1cad39edde31 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -629,8 +629,6 @@ static void mptcp_pm_nl_rm_addr_received(struct mptcp_s=
ock *msk)
 			WRITE_ONCE(msk->pm.accept_addr, true);
 =

 			__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMADDR);
-
-			break;
 		}
 	}
 }
@@ -702,8 +700,6 @@ void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock =
*msk, struct mptcp_rm_lis
 			msk->pm.subflows--;
 =

 			__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
-
-			break;
 		}
 	}
 }
-- =

2.29.2

--===============6356659267081742427==--
