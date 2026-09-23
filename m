Received: from mta0.migadu.com (out-136.mta0.migadu.com [91.218.175.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5BB47798A
	for <mptcp@lists.linux.dev>; Wed, 23 Sep 2026 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156990; cv=none; b=T1HPhuJVXjZqsLIW9XDEcYZF0pahiKSL0z19769Ip+xTvtBQjs/ng/NljST7js1OMt3QrfZmLODr7DTTwwFgXgrdxHwpWCMhGp7CVR3uFczPK5ZmL/rTRyPHSzKH4JUiVGKpr5ZvGHILj19WE43wwgBLK14UOxGU8qVL4MvPuSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156990; c=relaxed/simple;
	bh=i/wJE61RyabtROpRE7XVkfVZtpMuBwKcAkzgkxf+xbo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ucvx2xvMfS3a3kqSkjP/WunprZUVM4QUmMahAhFWCWTqJfUlvWlZkvVigXuOj9PA4jPfPDBwQ/B56ods6hU33CxIuHWsVkGw5X6pmadQwtJ9/PLPl09ePSZ2ymUC1bmOdqhk+GuRjqFE1aH7946mOZ+iwNiMmOwMt0gnsIs5k5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bIpc5m5m; arc=none smtp.client-ip=91.218.175.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bIpc5m5m"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=i/wJE61RyabtROpRE7XVkfVZtpMuBwKcAkzgkxf+xbo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790156986; v=1; x=1790761786;
 b=bIpc5m5m6t3TPhwlweatWaWqh28oXQuqzkinbv8xmrOLtS3ROXyLzALdWl5I8lt46PxU2UR3
 5Y6czqJNyxEP+yM2jpw5mQ+6eD0rgCKVFyKh57iWbiJQ1FOmPQj6aV8E4HJm9FdpDYW9WbS8ONI
 tsIyrgjBoVC8LUpUB4QGl5os=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id ad98ce0523c7bd28;
	Wed, 23 Sep 2026 09:49:46 +0000
X-Mizu-Trace-ID: ad98ce0523c7bd28
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v7 6/6] Squash to previous one
Date: Wed, 23 Sep 2026 17:49:19 +0800
Message-ID: <6a1cbdd1a0f4866ff6cda3b8679450172c203f5b.1790147728.git.yangang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790147728.git.yangang@kylinos.cn>
References: <cover.1790147728.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

Apply RCU discipline to msk->pm.ops: mark it __rcu, read it through
rcu_dereference() inside RCU read sections, publish it with
rcu_assign_pointer() under pm.lock, and wait for a grace period
before dropping the reference on the ops being retired -- both when
it is replaced on a reset and at the final release, moved from
mptcp_destroy_common() (also reached on mptcp_disconnect()) to
mptcp_destroy(), the final close path: mptcp_token_destroy() has
already removed the socket from the token hash by then, so no new
reader can find the msk anymore.

Note that rcu_assign_pointer() before pm_ops->init(msk) does not
publish a partially initialised object: the ops are registered
immutable, init() only prepares the per-socket state, and the msk is
not reachable by readers until its token is registered.

Note that for the in-tree path managers none of this changes
behaviour: neither defines release(), their init() only re-sets
flags, and the per-socket state is freed unconditionally by
mptcp_pm_destroy() on every disconnect.

Keep it as a separate patch to ease the review, but to be squashed
into the previous one, which is itself a squash-to for "mptcp: pm:
init and release mptcp_pm_ops".

[1] https://sashiko.dev/#/patchset/20260819125629.49823-1-gang.yan@linux.dev?part=5

Assisted-by: Claude:GLM5.2
Co-developed-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/pm.c       | 59 +++++++++++++++++++++++++++++++++-----------
 net/mptcp/protocol.c |  4 +++
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  |  9 ++++++-
 4 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 64244a1a01bc..66fb7c3d9c82 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -27,6 +27,14 @@ static LIST_HEAD(mptcp_pm_list);
 
 /* path manager helpers */
 
+static struct mptcp_pm_ops *mptcp_pm_rcu_deref(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_ops *pm_ops;
+
+	pm_ops = rcu_dereference(msk->pm.ops);
+	return pm_ops ? pm_ops : &mptcp_pm_kernel;
+}
+
 /* if sk is ipv4 or ipv6_only allows only same-family local and remote addresses,
  * otherwise allow any matching local/remote pair
  */
@@ -1049,7 +1057,7 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	skc_local.addr.id = 0;
 	skc_local.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 
-	return msk->pm.ops->get_local_id(msk, &skc_local);
+	return mptcp_pm_rcu_deref(msk)->get_local_id(msk, &skc_local);
 }
 
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
@@ -1058,7 +1066,7 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 
 	mptcp_local_address((struct sock_common *)skc, &skc_local);
 
-	return msk->pm.ops->get_priority(msk, &skc_local);
+	return mptcp_pm_rcu_deref(msk)->get_priority(msk, &skc_local);
 }
 
 static void
@@ -1158,23 +1166,39 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 static void mptcp_pm_ops_init(struct mptcp_sock *msk,
 			      struct mptcp_pm_ops *pm_ops)
 {
-	if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
-		pr_warn_once("pm %s fails, fallback to default pm", pm_ops->name);
-		pm_ops = &mptcp_pm_kernel;
+	struct mptcp_pm_ops *old;
+
+	spin_lock_bh(&msk->pm.lock);
+	old = rcu_dereference_protected(msk->pm.ops,
+					lockdep_is_held(&msk->pm.lock));
+	if (old != pm_ops)
+		rcu_assign_pointer(msk->pm.ops, pm_ops);
+	spin_unlock_bh(&msk->pm.lock);
+
+	if (old) {
+		synchronize_rcu();
+		if (old->release)
+			old->release(msk);
+		bpf_module_put(old, old->owner);
 	}
 
-	msk->pm.ops = pm_ops;
-	if (msk->pm.ops->init)
-		msk->pm.ops->init(msk);
+	if (pm_ops->init)
+		pm_ops->init(msk);
 
 	pr_debug("pm %s initialized\n", pm_ops->name);
 }
 
-static void mptcp_pm_ops_release(struct mptcp_sock *msk)
+void mptcp_pm_ops_release(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_ops *pm_ops = msk->pm.ops;
+	struct mptcp_pm_ops *pm_ops;
 
-	msk->pm.ops = NULL;
+	spin_lock_bh(&msk->pm.lock);
+	pm_ops = rcu_dereference_protected(msk->pm.ops,
+					   lockdep_is_held(&msk->pm.lock));
+	rcu_assign_pointer(msk->pm.ops, NULL);
+	spin_unlock_bh(&msk->pm.lock);
+
+	synchronize_rcu();
 	if (pm_ops->release)
 		pm_ops->release(msk);
 
@@ -1195,8 +1219,6 @@ void mptcp_pm_destroy(struct mptcp_sock *msk)
 	 * can be reused (mptcp_disconnect()) and re-selected to a different PM
 	 */
 	mptcp_userspace_pm_free_local_addr_list(msk);
-
-	mptcp_pm_ops_release(msk);
 }
 
 void mptcp_pm_data_reset(struct mptcp_sock *msk)
@@ -1204,6 +1226,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	const struct net *net = sock_net((struct sock *)msk);
 	u8 pm_type = mptcp_get_pm_type(net);
 	struct mptcp_pm_data *pm = &msk->pm;
+	struct mptcp_pm_ops *pm_ops;
 
 	memset(&pm->reset, 0, sizeof(pm->reset));
 	pm->rm_list_tx.nr = 0;
@@ -1211,8 +1234,16 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	WRITE_ONCE(pm->pm_type, pm_type);
 
 	rcu_read_lock();
-	mptcp_pm_ops_init(msk, mptcp_get_path_manager(net));
+	pm_ops = mptcp_get_path_manager(net);
+	if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
+		pr_warn_once("pm %s fails, fallback to default pm",
+			     pm_ops ? pm_ops->name : NULL);
+		pm_ops = &mptcp_pm_kernel;
+		bpf_try_module_get(pm_ops, pm_ops->owner);
+	}
 	rcu_read_unlock();
+
+	mptcp_pm_ops_init(msk, pm_ops);
 }
 
 void mptcp_pm_data_init(struct mptcp_sock *msk)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index eb066f2152f7..48c0434ab0d3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3759,6 +3759,9 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 		inet_sk(nsk)->pinet6 = mptcp_inet6_sk(nsk);
 #endif
 
+	msk = mptcp_sk(nsk);
+	RCU_INIT_POINTER(msk->pm.ops, NULL);
+
 	__mptcp_init_sock(nsk);
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -3828,6 +3831,7 @@ static void mptcp_destroy(struct sock *sk)
 	/* allow the following to close even the initial subflow */
 	msk->free_first = 1;
 	mptcp_destroy_common(msk);
+	mptcp_pm_ops_release(msk);
 	sk_sockets_allocated_dec(sk);
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 33c9893921b6..309e2251f2f3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -236,7 +236,7 @@ struct mptcp_pm_data {
 	struct mptcp_addr_info remote;
 	struct list_head anno_list;
 	struct list_head userspace_pm_local_addr_list;
-	struct mptcp_pm_ops *ops;
+	struct mptcp_pm_ops __rcu *ops;	/* RCU: read via mptcp_pm_rcu_deref() */
 
 	spinlock_t	lock;		/*protects the whole PM data */
 
@@ -1116,6 +1116,7 @@ void __init mptcp_pm_init(void);
 void mptcp_pm_data_init(struct mptcp_sock *msk);
 void mptcp_pm_data_reset(struct mptcp_sock *msk);
 void mptcp_pm_destroy(struct mptcp_sock *msk);
+void mptcp_pm_ops_release(struct mptcp_sock *msk);
 int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 			struct mptcp_addr_info *addr);
 int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 14aa82647c3d..4953cfa329e8 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -94,14 +94,17 @@ static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
 		return NULL;
 	}
 
+	rcu_read_lock();
 	local_id = mptcp_pm_get_local_id(msk, (struct sock_common *)req);
 	if (local_id < 0) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPJOINNOIDFOUND);
+		rcu_read_unlock();
 		sock_put((struct sock *)msk);
 		return NULL;
 	}
 	subflow_req->local_id = local_id;
 	subflow_req->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)req);
+	rcu_read_unlock();
 
 	return msk;
 }
@@ -638,12 +641,16 @@ static int subflow_chk_local_id(struct sock *sk)
 	if (likely(subflow->local_id >= 0))
 		return 0;
 
+	rcu_read_lock();
 	err = mptcp_pm_get_local_id(msk, (struct sock_common *)sk);
-	if (err < 0)
+	if (err < 0) {
+		rcu_read_unlock();
 		return err;
+	}
 
 	subflow_set_local_id(subflow, err);
 	subflow->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)sk);
+	rcu_read_unlock();
 
 	return 0;
 }
-- 
2.43.0

