Content-Type: multipart/mixed; boundary="===============4250967952712765892=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 09/11] mptcp: drop rm_addr_signal flag
Date: Wed, 09 Dec 2020 15:51:26 -0800
Message-ID: <20201209235128.175473-10-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201209235128.175473-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7114

--===============4250967952712765892==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch reused add_addr_signal for the RM_ADDR announcing signal, by
defining a new ADD_ADDR status named MPTCP_RM_ADDR_SIGNAL. Then the flag
rm_addr_signal in PM could be dropped.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/pm.c       | 18 +++++++++++++++---
 net/mptcp/protocol.h |  4 ++--
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ac590274b048..b5a0b8d231c6 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -20,6 +20,11 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 =

 	pr_debug("msk=3D%p, local_id=3D%d", msk, addr->id);
 =

+	if (add_addr) {
+		pr_warn("addr_signal error, add_addr=3D%d", add_addr);
+		return -EINVAL;
+	}
+
 	msk->pm.local =3D *addr;
 	add_addr |=3D BIT(MPTCP_ADD_ADDR_SIGNAL);
 	if (echo)
@@ -34,10 +39,18 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 =

 int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id)
 {
+	u8 rm_addr =3D READ_ONCE(msk->pm.add_addr_signal);
+
 	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
 =

+	if (rm_addr) {
+		pr_warn("addr_signal error, rm_addr=3D%d", rm_addr);
+		return -EINVAL;
+	}
+
 	msk->pm.rm_id =3D local_id;
-	WRITE_ONCE(msk->pm.rm_addr_signal, true);
+	rm_addr |=3D BIT(MPTCP_RM_ADDR_SIGNAL);
+	WRITE_ONCE(msk->pm.add_addr_signal, rm_addr);
 	return 0;
 }
 =

@@ -237,7 +250,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, un=
signed int remaining,
 		goto out_unlock;
 =

 	*rm_id =3D msk->pm.rm_id;
-	WRITE_ONCE(msk->pm.rm_addr_signal, false);
+	WRITE_ONCE(msk->pm.add_addr_signal, 0);
 	ret =3D true;
 =

 out_unlock:
@@ -259,7 +272,6 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.rm_id =3D 0;
 	WRITE_ONCE(msk->pm.work_pending, false);
 	WRITE_ONCE(msk->pm.add_addr_signal, 0);
-	WRITE_ONCE(msk->pm.rm_addr_signal, false);
 	WRITE_ONCE(msk->pm.accept_addr, false);
 	WRITE_ONCE(msk->pm.accept_subflow, false);
 	msk->pm.status =3D 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cda84b892182..4dbb75b8ee33 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -174,6 +174,7 @@ enum mptcp_add_addr_status {
 	MPTCP_ADD_ADDR_ECHO,
 	MPTCP_ADD_ADDR_IPV6,
 	MPTCP_ADD_ADDR_PORT,
+	MPTCP_RM_ADDR_SIGNAL,
 };
 =

 struct mptcp_pm_data {
@@ -184,7 +185,6 @@ struct mptcp_pm_data {
 	spinlock_t	lock;		/*protects the whole PM data */
 =

 	u8		add_addr_signal;
-	bool		rm_addr_signal;
 	bool		server_side;
 	bool		work_pending;
 	bool		accept_addr;
@@ -579,7 +579,7 @@ static inline bool mptcp_pm_should_add_signal_port(stru=
ct mptcp_sock *msk)
 =

 static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.rm_addr_signal);
+	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
 }
 =

 static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool =
port)
-- =

2.29.2

--===============4250967952712765892==--
