Content-Type: multipart/mixed; boundary="===============7097434630992883155=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v6 mptcp-next 1/5] mptcp: remove all subflows
 involving id 0 address
Date: Thu, 04 Mar 2021 17:33:32 +0800
Message-ID: <04bd4e4280974266f9942474df19b48bc2d6bd8b.1614849685.git.geliangtang@gmail.com>
In-Reply-To: cover.1614849685.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8017

--===============7097434630992883155==
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
index fa1dd6b8ec2f..12e75ad29dc4 100644
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
@@ -703,8 +701,6 @@ void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock =
*msk,
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

--===============7097434630992883155==--
