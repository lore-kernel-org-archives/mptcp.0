Content-Type: multipart/mixed; boundary="===============1156686590679725109=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 2/2] mptcp: rename add_addr_signal
 and mptcp_add_addr_status
Date: Mon, 09 Nov 2020 23:39:35 +0800
Message-ID: <2a154d3ce605aac31539c0e1c5798bd8ff44b409.1604935892.git.geliangtang@gmail.com>
In-Reply-To: 439a9aaac091edd0f5438f28b24b4dba333e989c.1604935892.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6606

--===============1156686590679725109==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since the RM_ADDR signal had been reused with add_addr_signal, it's not
suitable to call it add_addr_signal or mptcp_add_addr_status. So this
patch renamed add_addr_signal to addr_signal, and renamed
mptcp_add_addr_status to mptcp_addr_signal_status.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c         | 14 +++++++-------
 net/mptcp/pm_netlink.c |  4 ++--
 net/mptcp/protocol.h   | 14 +++++++-------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9e38f6a00773..aa3697642b28 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -16,7 +16,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo, bool port)
 {
-	u8 add_addr =3D READ_ONCE(msk->pm.add_addr_signal);
+	u8 add_addr =3D READ_ONCE(msk->pm.addr_signal);
 =

 	pr_debug("msk=3D%p, local_id=3D%d", msk, addr->id);
 =

@@ -29,20 +29,20 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 		add_addr |=3D BIT(MPTCP_ADD_ADDR_IPV6);
 	if (port)
 		add_addr |=3D BIT(MPTCP_ADD_ADDR_PORT);
-	WRITE_ONCE(msk->pm.add_addr_signal, add_addr);
+	WRITE_ONCE(msk->pm.addr_signal, add_addr);
 	return 0;
 }
 =

 int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id)
 {
-	u8 rm_addr =3D READ_ONCE(msk->pm.add_addr_signal);
+	u8 rm_addr =3D READ_ONCE(msk->pm.addr_signal);
 =

 	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
 =

 	WARN_ON_ONCE(rm_addr);
 	msk->pm.rm_id =3D local_id;
 	rm_addr |=3D BIT(MPTCP_RM_ADDR_SIGNAL);
-	WRITE_ONCE(msk->pm.add_addr_signal, rm_addr);
+	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
 	return 0;
 }
 =

@@ -213,7 +213,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, u=
nsigned int remaining,
 		goto out_unlock;
 =

 	*saddr =3D msk->pm.local;
-	WRITE_ONCE(msk->pm.add_addr_signal, 0);
+	WRITE_ONCE(msk->pm.addr_signal, 0);
 	ret =3D true;
 =

 out_unlock:
@@ -236,7 +236,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, un=
signed int remaining,
 		goto out_unlock;
 =

 	*rm_id =3D msk->pm.rm_id;
-	WRITE_ONCE(msk->pm.add_addr_signal, 0);
+	WRITE_ONCE(msk->pm.addr_signal, 0);
 	ret =3D true;
 =

 out_unlock:
@@ -257,7 +257,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.subflows =3D 0;
 	msk->pm.rm_id =3D 0;
 	WRITE_ONCE(msk->pm.work_pending, false);
-	WRITE_ONCE(msk->pm.add_addr_signal, 0);
+	WRITE_ONCE(msk->pm.addr_signal, 0);
 	WRITE_ONCE(msk->pm.accept_addr, false);
 	WRITE_ONCE(msk->pm.accept_subflow, false);
 	msk->pm.status =3D 0;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 00996f410e1c..ac904fdb4b08 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -444,12 +444,12 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock =
*msk)
 		release_sock(ssk);
 		spin_lock_bh(&msk->pm.lock);
 =

-		add_addr =3D READ_ONCE(msk->pm.add_addr_signal);
+		add_addr =3D READ_ONCE(msk->pm.addr_signal);
 		if (mptcp_pm_should_add_signal_ipv6(msk))
 			add_addr &=3D ~BIT(MPTCP_ADD_ADDR_IPV6);
 		if (mptcp_pm_should_add_signal_port(msk))
 			add_addr &=3D ~BIT(MPTCP_ADD_ADDR_PORT);
-		WRITE_ONCE(msk->pm.add_addr_signal, add_addr);
+		WRITE_ONCE(msk->pm.addr_signal, add_addr);
 	}
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index de0466005c3e..57e568b911b7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -168,7 +168,7 @@ enum mptcp_pm_status {
 	MPTCP_PM_SUBFLOW_ESTABLISHED,
 };
 =

-enum mptcp_add_addr_status {
+enum mptcp_addr_signal_status {
 	MPTCP_ADD_ADDR_SIGNAL,
 	MPTCP_ADD_ADDR_ECHO,
 	MPTCP_ADD_ADDR_IPV6,
@@ -183,7 +183,7 @@ struct mptcp_pm_data {
 =

 	spinlock_t	lock;		/*protects the whole PM data */
 =

-	u8		add_addr_signal;
+	u8		addr_signal;
 	bool		server_side;
 	bool		work_pending;
 	bool		accept_addr;
@@ -529,27 +529,27 @@ int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u=
8 local_id);
 =

 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_SIGNAL);
+	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_SIGNAL);
 }
 =

 static inline bool mptcp_pm_should_add_signal_echo(struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_ECHO);
+	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_ECHO);
 }
 =

 static inline bool mptcp_pm_should_add_signal_ipv6(struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_IPV6);
+	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_IPV6);
 }
 =

 static inline bool mptcp_pm_should_add_signal_port(struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_PORT);
+	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_PORT);
 }
 =

 static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
+	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
 }
 =

 static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool =
port)
-- =

2.26.2

--===============1156686590679725109==--
