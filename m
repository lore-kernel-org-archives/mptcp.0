Content-Type: multipart/mixed; boundary="===============6275984548279289015=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 2/12] Squash-to: "mptcp: Add ADD_ADDR handling"
Date: Thu, 05 Mar 2020 15:46:39 +0100
Message-ID: <6bd4e7892b80f11b4c9e41b232c683a2d6f9ed7d.1583418572.git.pabeni@redhat.com>
In-Reply-To: cover.1583418571.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3875

--===============6275984548279289015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Need a new hook to limit the number of per msk subflows

Also add new fields to properly account the total
subflows number

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/pm.c       | 9 ++++++++-
 net/mptcp/protocol.h | 5 ++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e869cea22f66..f17db5517544 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -39,6 +39,12 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, int=
 server_side)
 	WRITE_ONCE(pm->server_side, server_side);
 }
 =

+bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
+{
+	pr_debug("msk=3D%p", msk);
+	return false;
+}
+
 void mptcp_pm_fully_established(struct mptcp_sock *msk)
 {
 	pr_debug("msk=3D%p", msk);
@@ -88,10 +94,11 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.add_addr_signaled =3D 0;
 	msk->pm.add_addr_accepted =3D 0;
 	msk->pm.local_addr_used =3D 0;
+	msk->pm.subflows =3D 0;
 	WRITE_ONCE(msk->pm.work_pending, false);
 	WRITE_ONCE(msk->pm.addr_signal, false);
-	WRITE_ONCE(msk->pm.fully_established, false);
 	WRITE_ONCE(msk->pm.accept_addr, false);
+	WRITE_ONCE(msk->pm.accept_subflow, false);
 	msk->pm.status =3D MPTCP_PM_IDLE;
 =

 	spin_lock_init(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 80af72fab808..b3a02735c796 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -105,15 +105,17 @@ struct mptcp_pm_data {
 =

 	bool		addr_signal;
 	bool		server_side;
-	bool		fully_established;
 	bool		work_pending;
 	bool		accept_addr;
+	bool		accept_subflow;
 	u8		add_addr_signaled;
 	u8		add_addr_accepted;
 	u8		local_addr_used;
+	u8		subflows;
 	u8		add_addr_signal_max;
 	u8		add_addr_accept_max;
 	u8		local_addr_max;
+	u8		subflows_max;
 	enum mptcp_pm_status status;
 =

 	struct		work_struct work;
@@ -286,6 +288,7 @@ void mptcp_pm_init(void);
 void mptcp_pm_data_init(struct mptcp_sock *msk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, int server_side);
 void mptcp_pm_fully_established(struct mptcp_sock *msk);
+bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
 void mptcp_pm_connection_closed(struct mptcp_sock *msk);
 void mptcp_pm_subflow_established(struct mptcp_sock *msk,
 				  struct mptcp_subflow_context *subflow);
-- =

2.21.1

--===============6275984548279289015==--
