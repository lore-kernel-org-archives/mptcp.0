Content-Type: multipart/mixed; boundary="===============7656890050170558325=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 5/6] Squash-to: "mptcp: Implement path manager
 interface commands"
Date: Tue, 11 Feb 2020 19:12:12 +0100
Message-ID: <8b9330153ed2fb1cfd96333a47d27a956bd82306.1581444137.git.pabeni@redhat.com>
In-Reply-To: cover.1581444137.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3616

--===============7656890050170558325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement stubs for PM events delegating the action to the work
queue. This allows acquiring whatever lock is needed to perform
the actual implementation.

Try to avoid scheduling the worker if no action is needed/possible.
I relies on the accounting info included into the PM struct and
on great deal of double-checked locking [anti-]pattern.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/pm.c | 213 +++++++++++++++++++++++++------------------------
 1 file changed, 107 insertions(+), 106 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 52c89e5a7d4f..5323945216f2 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -15,117 +15,17 @@ static struct workqueue_struct *pm_wq;
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr)
 {
-	struct mptcp_sock *msk =3D mptcp_token_get_sock(token);
-	int err =3D 0;
+	pr_debug("msk=3D%p, local_id=3D%d", msk, addr->id);
 =

-	if (!msk)
-		return -EINVAL;
-
-	if (msk->pm.local_valid) {
-		err =3D -EBADR;
-		goto announce_put;
-	}
-
-	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
-	msk->pm.local_valid =3D 1;
-	msk->pm.local_id =3D local_id;
-	msk->pm.local_family =3D AF_INET;
-	msk->pm.local_addr =3D *addr;
-	msk->addr_signal =3D 1;
-
-announce_put:
-	sock_put((struct sock *)msk);
-	return err;
-}
-
-int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id)
-{
-	struct mptcp_sock *msk =3D mptcp_token_get_sock(token);
-
-	if (!msk)
-		return -EINVAL;
-
-	pr_debug("msk=3D%p", msk);
-	msk->pm.local_valid =3D 0;
-
-	sock_put((struct sock *)msk);
+	msk->pm.local =3D *addr;
+	WRITE_ONCE(msk->pm.addr_signal, true);
 	return 0;
 }
 =

-int mptcp_pm_create_subflow(u32 token, u8 remote_id, struct in6_addr *addr)
-{
-	struct mptcp_sock *msk =3D mptcp_token_get_sock(token);
-	struct sockaddr_in6 remote;
-	struct sockaddr_in6 local;
-	struct sock *sk;
-	int err;
-
-	pr_debug("msk=3D%p", msk);
-
-	sk =3D (struct sock *)msk;
-	if (!msk->pm.remote_valid || remote_id !=3D msk->pm.remote_id) {
-		err =3D -EBADR;
-		goto create_put;
-	}
-
-	local.sin_family =3D AF_INET;
-	local.sin_port =3D 0;
-	if (addr)
-		local.sin_addr =3D *addr;
-	else
-		local.sin_addr.s_addr =3D htonl(INADDR_ANY);
-
-	remote.sin_family =3D msk->pm.remote_family;
-	remote.sin_port =3D inet_sk(sk)->inet_dport;
-	remote.sin_addr =3D msk->pm.remote_addr;
-
-	err =3D mptcp_subflow_connect(sk, (struct sockaddr *)&local,
-				    (struct sockaddr *)&remote, remote_id);
-
-create_put:
-	sock_put(sk);
-	return err;
-}
-
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-int mptcp_pm_create_subflow6(u32 token, u8 remote_id, struct in6_addr *add=
r)
+int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id)
 {
-	struct mptcp_sock *msk =3D mptcp_token_get_sock(token);
-	struct sockaddr_in6 remote;
-	struct sockaddr_in6 local;
-	struct sock *sk;
-	int err;
-
-	if (!msk)
-		return -EINVAL;
-
-	pr_debug("msk=3D%p", msk);
-	sk =3D (struct sock *)msk;
-
-	if (!msk->pm.remote_valid || remote_id !=3D msk->pm.remote_id) {
-		err =3D -EBADR;
-		goto create_put;
-	}
-
-	local.sin6_family =3D AF_INET6;
-	local.sin6_port =3D 0;
-	if (addr)
-		local.sin6_addr =3D *addr;
-	else
-		local.sin6_addr =3D in6addr_any;
-
-	remote.sin6_family =3D msk->pm.remote_family;
-	remote.sin6_port =3D inet_sk(sk)->inet_dport;
-	remote.sin6_addr =3D msk->pm.remote_addr6;
-
-	err =3D mptcp_subflow_connect(sk, (struct sockaddr *)&local,
-				    (struct sockaddr *)&remote, remote_id);
-
-create_put:
-	sock_put(sk);
-	return err;
+	return -ENOTSUPP;
 }
-#endif
 =

 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 remote_id)
 {
@@ -143,11 +43,47 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, i=
nt server_side)
 	WRITE_ONCE(pm->server_side, server_side);
 }
 =

+static bool mptcp_pm_work_pending(const struct mptcp_pm_data *pm)
+{
+	return (READ_ONCE(pm->local_addr_used) <
+		READ_ONCE(pm->local_addr_max)) ||
+	       (READ_ONCE(pm->add_addr_signaled) <
+		READ_ONCE(pm->add_addr_signal_max));
+}
+
+static bool mptcp_pm_schedule_work(struct mptcp_sock *msk,
+				   enum mptcp_pm_status new_status)
+{
+	if (msk->pm.status !=3D MPTCP_PM_IDLE)
+		return false;
+
+	if (queue_work(pm_wq, &msk->pm.work)) {
+		msk->pm.status =3D new_status;
+		sock_hold((struct sock *)msk);
+		return true;
+	}
+	return false;
+}
+
 void mptcp_pm_fully_established(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm =3D &msk->pm;
 =

 	pr_debug("msk=3D%p", msk);
+
+	/* try to avoid acquiring the lock below */
+	if (READ_ONCE(pm->fully_established) || !mptcp_pm_work_pending(pm))
+		return;
+
+	spin_lock_bh(&pm->lock);
+	if (READ_ONCE(pm->fully_established))
+		goto out_unlock;
+
+	if (mptcp_pm_schedule_work(msk, MPTCP_PM_ESTABLISHED))
+		WRITE_ONCE(pm->fully_established, true);
+
+out_unlock:
+	spin_unlock_bh(&pm->lock);
 }
 =

 void mptcp_pm_connection_closed(struct mptcp_sock *msk)
@@ -158,7 +94,19 @@ void mptcp_pm_connection_closed(struct mptcp_sock *msk)
 void mptcp_pm_subflow_established(struct mptcp_sock *msk,
 				  struct mptcp_subflow_context *subflow)
 {
+	struct mptcp_pm_data *pm =3D &msk->pm;
+
 	pr_debug("msk=3D%p", msk);
+
+	if (!mptcp_pm_work_pending(pm))
+		return;
+
+	spin_lock_bh(&pm->lock);
+
+	if (mptcp_pm_work_pending(pm))
+		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
+
+	spin_unlock_bh(&pm->lock);
 }
 =

 void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id)
@@ -170,8 +118,30 @@ void mptcp_pm_add_addr(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_data *pm =3D &msk->pm;
+	unsigned max, cur;
 =

 	pr_debug("msk=3D%p, remote_id=3D%d", msk, addr->id);
+
+	/* avoid acquiring the lock if there is no room for fouther addresses */
+	if (READ_ONCE(pm->add_addr_accepted) >=3D
+	    READ_ONCE(pm->add_addr_accept_max))
+		return;
+
+	spin_lock_bh(&pm->lock);
+
+	/* be sure there is something to signal re-checking under PM lock */
+	max =3D READ_ONCE(pm->add_addr_accept_max);
+	cur =3D READ_ONCE(pm->add_addr_accepted);
+	if (cur >=3D max)
+		goto unlock;
+
+	if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR)) {
+		WRITE_ONCE(pm->add_addr_accepted, cur + 1);
+		pm->remote =3D *addr;
+	}
+
+unlock:
+	spin_unlock_bh(&pm->lock);
 }
 =

 /* path manager helpers */
@@ -179,7 +149,27 @@ void mptcp_pm_add_addr(struct mptcp_sock *msk,
 int mptcp_pm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			 struct mptcp_addr_info *saddr)
 {
-	return 0;
+	struct mptcp_addr_info addr;
+	int ret =3D -EINVAL;
+
+	spin_lock_bh(&msk->pm.lock);
+
+	/* double check after the lock is acquired */
+	if (!mptcp_pm_should_signal(msk))
+		goto out_unlock;
+
+	/* load real data */
+	memset(&addr, 0, sizeof(addr));
+
+	if (remaining < mptcp_add_addr_len(saddr->family))
+		goto out_unlock;
+
+	WRITE_ONCE(msk->pm.addr_signal, false);
+	ret =3D 0;
+
+out_unlock:
+	spin_unlock_bh(&msk->pm.lock);
+	return ret;
 }
 =

 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
@@ -189,6 +179,17 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, stru=
ct sock_common *skc)
 =

 static void pm_worker(struct work_struct *work)
 {
+	struct mptcp_pm_data *pm =3D container_of(work, struct mptcp_pm_data,
+						work);
+	struct mptcp_sock *msk =3D container_of(pm, struct mptcp_sock, pm);
+	struct sock *sk =3D (struct sock *)msk;
+
+	switch (pm->status) {
+	default:
+		break;
+	}
+
+	sock_put(sk);
 }
 =

 void mptcp_pm_data_init(struct mptcp_sock *msk)
-- =

2.21.1

--===============7656890050170558325==--
