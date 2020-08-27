Content-Type: multipart/mixed; boundary="===============7904629609293462109=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v6 mptcp-next 1/4] mptcp: drop re-check
 mechanism for PM's flags
Date: Thu, 27 Aug 2020 12:09:33 +0800
Message-ID: <fe75471f0595b9a0190e183a675ca679b5b7b336.1598501119.git.geliangtang@gmail.com>
In-Reply-To: cover.1598501119.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5638

--===============7904629609293462109==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All the PM's flags values have been used a check/re-check mechanism,
which first check the flags without the PM lock, then re-check it
under the PM spin lock.

But if there is no avoiding the spin lock, the mechanism does not
apply.

With the proposed changes, the spin lock is *always* acquired so the
check/re-check mechanism is making the code more complicated without
adding the no-spin-lock optimization.

So this patch drop this check/re-check mechanism, always check the
flags under the PM lock and only check them once.

Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c |  6 ++----
 net/mptcp/pm.c      | 26 +++++---------------------
 2 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a52a05effac9..1be3473cc1ad 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -581,8 +581,7 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk,
 	struct mptcp_addr_info saddr;
 	int len;
 =

-	if (!mptcp_pm_should_add_signal(msk) ||
-	    !(mptcp_pm_add_addr_signal(msk, remaining, &saddr)))
+	if (!mptcp_pm_add_addr_signal(msk, remaining, &saddr))
 		return false;
 =

 	len =3D mptcp_add_addr_len(saddr.family);
@@ -623,8 +622,7 @@ static bool mptcp_established_options_rm_addr(struct so=
ck *sk,
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 	u8 rm_id;
 =

-	if (!mptcp_pm_should_rm_signal(msk) ||
-	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_id)))
+	if (!mptcp_pm_rm_addr_signal(msk, remaining, &rm_id))
 		return false;
 =

 	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 558462d87eb3..e75682ee5865 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -51,14 +51,12 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 	pr_debug("msk=3D%p subflows=3D%d max=3D%d allow=3D%d", msk, pm->subflows,
 		 pm->subflows_max, READ_ONCE(pm->accept_subflow));
 =

-	/* try to avoid acquiring the lock below */
-	if (!READ_ONCE(pm->accept_subflow))
-		return false;
-
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
@@ -87,10 +85,6 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk)
 =

 	pr_debug("msk=3D%p", msk);
 =

-	/* try to avoid acquiring the lock below */
-	if (!READ_ONCE(pm->work_pending))
-		return;
-
 	spin_lock_bh(&pm->lock);
 =

 	if (READ_ONCE(pm->work_pending))
@@ -111,9 +105,6 @@ void mptcp_pm_subflow_established(struct mptcp_sock *ms=
k,
 =

 	pr_debug("msk=3D%p", msk);
 =

-	if (!READ_ONCE(pm->work_pending))
-		return;
-
 	spin_lock_bh(&pm->lock);
 =

 	if (READ_ONCE(pm->work_pending))
@@ -135,13 +126,8 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 	pr_debug("msk=3D%p remote_id=3D%d accept=3D%d", msk, addr->id,
 		 READ_ONCE(pm->accept_addr));
 =

-	/* avoid acquiring the lock if there is no room for fouther addresses */
-	if (!READ_ONCE(pm->accept_addr))
-		return;
-
 	spin_lock_bh(&pm->lock);
 =

-	/* be sure there is something to signal re-checking under PM lock */
 	if (READ_ONCE(pm->accept_addr) &&
 	    mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED))
 		pm->remote =3D *addr;
@@ -170,7 +156,6 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, u=
nsigned int remaining,
 =

 	spin_lock_bh(&msk->pm.lock);
 =

-	/* double check after the lock is acquired */
 	if (!mptcp_pm_should_add_signal(msk))
 		goto out_unlock;
 =

@@ -193,7 +178,6 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, un=
signed int remaining,
 =

 	spin_lock_bh(&msk->pm.lock);
 =

-	/* double check after the lock is acquired */
 	if (!mptcp_pm_should_rm_signal(msk))
 		goto out_unlock;
 =

-- =

2.17.1

--===============7904629609293462109==--
