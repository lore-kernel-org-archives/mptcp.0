Content-Type: multipart/mixed; boundary="===============3816212146981854801=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v9 mptcp-next 3/8] mptcp: implement
 mptcp_pm_remove_subflow
Date: Wed, 02 Sep 2020 17:38:25 +0800
Message-ID: <9743b1a0daaf542b3f0d346a310d2b5290b49212.1599038897.git.geliangtang@gmail.com>
In-Reply-To: cover.1599038897.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5688

--===============3816212146981854801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch implemented the local subflow removing function,
mptcp_pm_remove_subflow, it simply called mptcp_pm_nl_rm_subflow_received
under the PM spin lock.

We use mptcp_pm_remove_subflow to remove a local subflow, so change it's
argument from remote_id to local_id.

Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c       | 9 +++++++--
 net/mptcp/protocol.h | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 511996bf4838..9328f0b175a7 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -33,9 +33,14 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 loca=
l_id)
 	return 0;
 }
 =

-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 remote_id)
+int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id)
 {
-	return -ENOTSUPP;
+	pr_debug("%s msk=3D%p, local_id=3D%d", __func__, msk, local_id);
+
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_nl_rm_subflow_received(msk, local_id);
+	spin_unlock_bh(&msk->pm.lock);
+	return 0;
 }
 =

 /* path manager event handlers */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 703fb1f1d0ce..bad751e2c8f3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -446,7 +446,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id);
-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 remote_id);
+int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id);
 =

 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
-- =

2.17.1

--===============3816212146981854801==--
