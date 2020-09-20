Content-Type: multipart/mixed; boundary="===============8600588090580071709=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 2/2] Squash-to: "mptcp: implement
 mptcp_pm_remove_subflow" Part 2
Date: Sun, 20 Sep 2020 22:12:10 +0800
Message-ID: <cc8276c2db393b0d0df38a86cc97008ef664ff4b.1600610895.git.geliangtang@gmail.com>
In-Reply-To: 9187bb959f009488d716d545361cea6a68dd79d1.1600610895.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5948

--===============8600588090580071709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Just fix pr_debug log.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6ca88422e774..7e81f53d1e5d 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -35,7 +35,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local=
_id)
 =

 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id)
 {
-	pr_debug("%s msk=3D%p, local_id=3D%d", __func__, msk, local_id);
+	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
 =

 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_nl_rm_subflow_received(msk, local_id);
-- =

2.26.2

--===============8600588090580071709==--
