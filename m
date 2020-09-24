Content-Type: multipart/mixed; boundary="===============5795023800540185692=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH net-next 07/16] mptcp: add accept_subflow
 re-check
Date: Thu, 24 Sep 2020 08:29:53 +0800
Message-ID: <98bcc56283c482c294bd6ae9ce1476821ddc6837.1600853093.git.geliangtang@gmail.com>
In-Reply-To: cover.1600853093.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6003

--===============5795023800540185692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The re-check of pm->accept_subflow with pm->lock held was missing, this
patch fixed it.

Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 39a76620d0a5..be4157279e15 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -48,7 +48,7 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, int =
server_side)
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm =3D &msk->pm;
-	int ret;
+	int ret =3D 0;
 =

 	pr_debug("msk=3D%p subflows=3D%d max=3D%d allow=3D%d", msk, pm->subflows,
 		 pm->subflows_max, READ_ONCE(pm->accept_subflow));
@@ -58,9 +58,11 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 		return false;
 =

 	spin_lock_bh(&pm->lock);
-	ret =3D pm->subflows < pm->subflows_max;
-	if (ret && ++pm->subflows =3D=3D pm->subflows_max)
-		WRITE_ONCE(pm->accept_subflow, false);
+	if (READ_ONCE(pm->accept_subflow)) {
+		ret =3D pm->subflows < pm->subflows_max;
+		if (ret && ++pm->subflows =3D=3D pm->subflows_max)
+			WRITE_ONCE(pm->accept_subflow, false);
+	}
 	spin_unlock_bh(&pm->lock);
 =

 	return ret;
-- =

2.17.1

--===============5795023800540185692==--
