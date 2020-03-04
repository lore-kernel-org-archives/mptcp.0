Content-Type: multipart/mixed; boundary="===============8161216984185303895=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 5/0005] Squash-to: "mptcp: Implement path manager
 interface commands"
Date: Wed, 04 Mar 2020 16:02:04 +0100
Message-ID: <a2cab6d6030fb61e655ae4b387370c3de8565874.1583334095.git.pabeni@redhat.com>
In-Reply-To: cover.1583334095.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3856

--===============8161216984185303895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adapt the mptcp_pm_fully_established() hook to the new call
site. Additionally avoid useless work if we don't need to
announce any address /create any subflows

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/pm.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 174fde4071e0..a3fe2371d41b 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -45,9 +45,23 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, int=
 server_side)
 =

 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 {
-	pr_debug("msk=3D%p", msk);
+	struct mptcp_pm_data *pm =3D &msk->pm;
+	int ret;
 =

-	return false;
+	pr_debug("msk=3D%p subflows=3D%d max=3D%d allow=3D%d", msk, pm->subflows,
+		 pm->subflows_max, READ_ONCE(pm->accept_subflow));
+
+	/* try to avoid acquiring the lock below */
+	if (!READ_ONCE(pm->accept_subflow))
+		return false;
+
+	spin_lock_bh(&pm->lock);
+	ret =3D pm->subflows < pm->subflows_max;
+	if (ret && ++pm->subflows =3D=3D pm->subflows_max)
+		WRITE_ONCE(pm->accept_subflow, false);
+	spin_unlock_bh(&pm->lock);
+
+	return ret;
 }
 =

 static bool mptcp_pm_schedule_work(struct mptcp_sock *msk,
@@ -71,13 +85,13 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk)
 	pr_debug("msk=3D%p", msk);
 =

 	/* try to avoid acquiring the lock below */
-	if (READ_ONCE(pm->fully_established))
+	if (!READ_ONCE(pm->work_pending))
 		return;
 =

 	spin_lock_bh(&pm->lock);
-	if (!READ_ONCE(pm->fully_established) &&
-	    mptcp_pm_schedule_work(msk, MPTCP_PM_ESTABLISHED))
-		WRITE_ONCE(pm->fully_established, true);
+
+	if (READ_ONCE(pm->work_pending))
+		mptcp_pm_schedule_work(msk, MPTCP_PM_ESTABLISHED);
 =

 	spin_unlock_bh(&pm->lock);
 }
-- =

2.21.1

--===============8161216984185303895==--
