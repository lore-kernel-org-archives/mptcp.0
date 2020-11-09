Content-Type: multipart/mixed; boundary="===============4213817057609692336=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 1/2] mptcp: drop rm_addr_signal flag
Date: Mon, 09 Nov 2020 23:39:34 +0800
Message-ID: <439a9aaac091edd0f5438f28b24b4dba333e989c.1604935892.git.geliangtang@gmail.com>
In-Reply-To: cover.1604935892.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6605

--===============4213817057609692336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch reused add_addr_signal for the RM_ADDR announce signal, by
defining a new add_addr status named MPTCP_RM_ADDR_SIGNAL. Then the flag
rm_addr_signal in PM could be dropped.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c       | 10 +++++++---
 net/mptcp/protocol.h |  4 ++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e63e14f4cf2a..9e38f6a00773 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -20,6 +20,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 =

 	pr_debug("msk=3D%p, local_id=3D%d", msk, addr->id);
 =

+	WARN_ON_ONCE(add_addr);
 	msk->pm.local =3D *addr;
 	add_addr |=3D BIT(MPTCP_ADD_ADDR_SIGNAL);
 	if (echo)
@@ -34,10 +35,14 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 =

 int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id)
 {
+	u8 rm_addr =3D READ_ONCE(msk->pm.add_addr_signal);
+
 	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
 =

+	WARN_ON_ONCE(rm_addr);
 	msk->pm.rm_id =3D local_id;
-	WRITE_ONCE(msk->pm.rm_addr_signal, true);
+	rm_addr |=3D BIT(MPTCP_RM_ADDR_SIGNAL);
+	WRITE_ONCE(msk->pm.add_addr_signal, rm_addr);
 	return 0;
 }
 =

@@ -231,7 +236,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, un=
signed int remaining,
 		goto out_unlock;
 =

 	*rm_id =3D msk->pm.rm_id;
-	WRITE_ONCE(msk->pm.rm_addr_signal, false);
+	WRITE_ONCE(msk->pm.add_addr_signal, 0);
 	ret =3D true;
 =

 out_unlock:
@@ -253,7 +258,6 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.rm_id =3D 0;
 	WRITE_ONCE(msk->pm.work_pending, false);
 	WRITE_ONCE(msk->pm.add_addr_signal, 0);
-	WRITE_ONCE(msk->pm.rm_addr_signal, false);
 	WRITE_ONCE(msk->pm.accept_addr, false);
 	WRITE_ONCE(msk->pm.accept_subflow, false);
 	msk->pm.status =3D 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e575823c3077..de0466005c3e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -173,6 +173,7 @@ enum mptcp_add_addr_status {
 	MPTCP_ADD_ADDR_ECHO,
 	MPTCP_ADD_ADDR_IPV6,
 	MPTCP_ADD_ADDR_PORT,
+	MPTCP_RM_ADDR_SIGNAL,
 };
 =

 struct mptcp_pm_data {
@@ -183,7 +184,6 @@ struct mptcp_pm_data {
 	spinlock_t	lock;		/*protects the whole PM data */
 =

 	u8		add_addr_signal;
-	bool		rm_addr_signal;
 	bool		server_side;
 	bool		work_pending;
 	bool		accept_addr;
@@ -549,7 +549,7 @@ static inline bool mptcp_pm_should_add_signal_port(stru=
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

--===============4213817057609692336==--
