Content-Type: multipart/mixed; boundary="===============6008385374544644172=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next] Squash to "mptcp: remove id 0
 address"
Date: Tue, 16 Mar 2021 13:18:10 +0800
Message-ID: <be80ad2d5230a0e414a263c871172a4c5b3eaf50.1615871767.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 8161

--===============6008385374544644172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hold msk->pm.lock when invoking mptcp_pm_remove_addr.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
v2:
 - use mptcp_pm_nl_rm_subflow_received instead of
   mptcp_pm_remove_subflow.
---
 net/mptcp/pm_netlink.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c73b7cfc7ae9..f9606934104d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1185,8 +1185,10 @@ static int mptcp_nl_remove_id_zero_address(struct ne=
t *net,
 			goto next;
 =

 		lock_sock(sk);
+		spin_lock_bh(&msk->pm.lock);
 		mptcp_pm_remove_addr(msk, &list);
-		mptcp_pm_remove_subflow(msk, &list);
+		mptcp_pm_nl_rm_subflow_received(msk, &list);
+		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 =

 next:
-- =

2.30.2

--===============6008385374544644172==--
