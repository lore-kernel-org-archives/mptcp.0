Content-Type: multipart/mixed; boundary="===============8012923236290913194=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 1/2] mptcp: drop rm_addr_signal
 flag
Date: Fri, 20 Nov 2020 10:49:31 +0800
Message-ID: <c5b430251a25d1be23f13bf378fd5a5e647c2ae0.1605840230.git.geliangtang@gmail.com>
In-Reply-To: cover.1605840230.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6858

--===============8012923236290913194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch reused add_addr_signal for the RM_ADDR announcing signal, by
defining a new ADD_ADDR status named MPTCP_RM_ADDR_SIGNAL. Then the flag
rm_addr_signal in PM could be dropped.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c       | 22 +++++++++++++++++-----
 net/mptcp/protocol.h |  4 ++--
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e63e14f4cf2a..ad9f79991fdf 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -18,7 +18,12 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 {
 	u8 add_addr =3D READ_ONCE(msk->pm.add_addr_signal);
 =

-	pr_debug("msk=3D%p, local_id=3D%d", msk, addr->id);
+	pr_debug("msk=3D%p, local_id=3D%d, add_addr=3D%d", msk, addr->id, add_add=
r);
+
+	if (add_addr) {
+		pr_warn("addr_signal error.");
+		return -EINVAL;
+	}
 =

 	msk->pm.local =3D *addr;
 	add_addr |=3D BIT(MPTCP_ADD_ADDR_SIGNAL);
@@ -34,10 +39,18 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 =

 int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id)
 {
-	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
+	u8 rm_addr =3D READ_ONCE(msk->pm.add_addr_signal);
+
+	pr_debug("msk=3D%p, local_id=3D%d, rm_addr=3D%d", msk, local_id, rm_addr);
+
+	if (rm_addr) {
+		pr_warn("addr_signal error.");
+		return -EINVAL;
+	}
 =

 	msk->pm.rm_id =3D local_id;
-	WRITE_ONCE(msk->pm.rm_addr_signal, true);
+	rm_addr |=3D BIT(MPTCP_RM_ADDR_SIGNAL);
+	WRITE_ONCE(msk->pm.add_addr_signal, rm_addr);
 	return 0;
 }
 =

@@ -231,7 +244,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, un=
signed int remaining,
 		goto out_unlock;
 =

 	*rm_id =3D msk->pm.rm_id;
-	WRITE_ONCE(msk->pm.rm_addr_signal, false);
+	WRITE_ONCE(msk->pm.add_addr_signal, 0);
 	ret =3D true;
 =

 out_unlock:
@@ -253,7 +266,6 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.rm_id =3D 0;
 	WRITE_ONCE(msk->pm.work_pending, false);
 	WRITE_ONCE(msk->pm.add_addr_signal, 0);
-	WRITE_ONCE(msk->pm.rm_addr_signal, false);
 	WRITE_ONCE(msk->pm.accept_addr, false);
 	WRITE_ONCE(msk->pm.accept_subflow, false);
 	msk->pm.status =3D 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d926deae8610..05c853e337a0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -172,6 +172,7 @@ enum mptcp_add_addr_status {
 	MPTCP_ADD_ADDR_ECHO,
 	MPTCP_ADD_ADDR_IPV6,
 	MPTCP_ADD_ADDR_PORT,
+	MPTCP_RM_ADDR_SIGNAL,
 };
 =

 struct mptcp_pm_data {
@@ -182,7 +183,6 @@ struct mptcp_pm_data {
 	spinlock_t	lock;		/*protects the whole PM data */
 =

 	u8		add_addr_signal;
-	bool		rm_addr_signal;
 	bool		server_side;
 	bool		work_pending;
 	bool		accept_addr;
@@ -564,7 +564,7 @@ static inline bool mptcp_pm_should_add_signal_port(stru=
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

2.26.2

--===============8012923236290913194==--
