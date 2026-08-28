Received: from mta0.migadu.com (out-240.mta0.migadu.com [91.218.175.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04CC41C6A
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 06:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787897237; cv=none; b=TJGpf0hr1riTBNSZCkgk+slEartevEFC+NycGSKGU92sPizaIcMjzWmz9DxoL3hPN5i4H4ZkKK6PcAzsmwBF/vUD1MSd5p4r9pUKYz03H2toUZ1bhs8xG617IfvKJCEufixKxaFKo3KYDh8WjfwCu75EhTI3RwOpjWfHTroG1pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787897237; c=relaxed/simple;
	bh=KBipn1jX/F5Mx7TvxEZBRHkO1ZlAHE/l/aU0TfSIu10=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4QcMvyIQA/Z8XIM90qHsRCuKXibI3XuhWiLKaI1+sUTvW1CLBjirAtNOHjDQKLMXDy/DV+JoCBWPSzqFjvnRyZomZhYGtkqgaM0R9v+hnkzSQNhxNR6j4b+qlAlxcsGQNgr8+iroPIjeXw3EHl0+AWkgGJ+zrNm8RI7s4GNdoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uxn1WCiV; arc=none smtp.client-ip=91.218.175.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Uxn1WCiV"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=KBipn1jX/F5Mx7TvxEZBRHkO1ZlAHE/l/aU0TfSIu10=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787897233; v=1; x=1788502033;
 b=Uxn1WCiVAmGO2KBipN5Ct0JF4dFT40pQ2rhuCazQyCbYc3jxNmZiuB59Ew7pyp2pLePXGIgh
 MbCNYlHtWuSTl206ChlG49Uq5Kj7ZchDAapMZeToXNyVavrc7qzmhHG2ojeenyNPB9/q0MJDB0s
 /6R6Fwbssbg2ljwvlogiclz4=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 4de6b1805e2a5c0e;
	Fri, 28 Aug 2026 06:07:13 +0000
X-Mizu-Trace-ID: 4de6b1805e2a5c0e
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v5 6/6] Squash to previous one
Date: Fri, 28 Aug 2026 14:06:43 +0800
Message-ID: <20260828060643.14397-7-gang.yan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828060643.14397-1-gang.yan@linux.dev>
References: <20260828060643.14397-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

Fix the issue sashiko mentioned in [1]. This patch applies the usual
RCU discipline to the pointer: mark it __rcu, read it via
rcu_dereference() inside RCU read sections, assign it via
rcu_assign_pointer(), wait for a grace period before dropping the
reference on the ops being replaced, and do the final release from
mptcp_destroy() -- after the last msk reference -- instead of
mptcp_destroy_common(), which is also reached on mptcp_disconnect().

Also, we need to hold the pm.lock before modify the pm.ops, and using
the status of lock to tell rcu it's safe.

Note that rcu_assign_pointer() before pm_ops->init(msk) does not
publish a partially initialised object: pm_ops->init() prepares the
per-socket state, the ops themselves are registered immutable, and
the msk is not reachable by readers until its token is registered.

Note also that the swap path does not call old->release() and that
init() runs again when the ops is unchanged: the per-socket PM
resources are already freed by mptcp_pm_destroy() before the reset
swaps the ops, and mptcp_pm_kernel_init() only re-sets flags from
the current sysctl, it does not allocate.

Keep it as a separate patch to ease the review, but to be squashed into
the previous one, which is itself a squash-to for "mptcp: pm: init and
release mptcp_pm_ops".

[1] https://sashiko.dev/#/patchset/20260819125629.49823-1-gang.yan@linux.dev?part=5

Assisted-by: Claude:GLM5.2
Co-developed-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/pm.c       | 60 +++++++++++++++++++++++++++++++++-----------
 net/mptcp/protocol.c |  4 +++
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  |  9 ++++++-
 4 files changed, 60 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 64244a1a01bc..769b084ed9cd 100644
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
@@ -1158,23 +1166,41 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 static void mptcp_pm_ops_init(struct mptcp_sock *msk,
 			      struct mptcp_pm_ops *pm_ops)
 {
-	if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
-		pr_warn_once("pm %s fails, fallback to default pm", pm_ops->name);
-		pm_ops = &mptcp_pm_kernel;
+	struct mptcp_pm_ops *old;
+	bool need_sync = false;
+
+	spin_lock_bh(&msk->pm.lock);
+	old = rcu_dereference_protected(msk->pm.ops,
+					lockdep_is_held(&msk->pm.lock));
+	if (old == pm_ops) {
+		need_sync = false;
+	} else {
+		rcu_assign_pointer(msk->pm.ops, pm_ops);
+		need_sync = !!old;
 	}
+	spin_unlock_bh(&msk->pm.lock);
 
-	msk->pm.ops = pm_ops;
-	if (msk->pm.ops->init)
-		msk->pm.ops->init(msk);
+	if (need_sync)
+		synchronize_rcu();
+	if (old)
+		bpf_module_put(old, old->owner);
+
+	if (pm_ops->init)
+		pm_ops->init(msk);
 
 	pr_debug("pm %s initialized\n", pm_ops->name);
 }
 
-static void mptcp_pm_ops_release(struct mptcp_sock *msk)
+void mptcp_pm_ops_release(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_ops *pm_ops = msk->pm.ops;
+	struct mptcp_pm_ops *pm_ops;
+
+	spin_lock_bh(&msk->pm.lock);
+	pm_ops = rcu_dereference_protected(msk->pm.ops,
+					   lockdep_is_held(&msk->pm.lock));
+	rcu_assign_pointer(msk->pm.ops, NULL);
+	spin_unlock_bh(&msk->pm.lock);
 
-	msk->pm.ops = NULL;
 	if (pm_ops->release)
 		pm_ops->release(msk);
 
@@ -1195,8 +1221,6 @@ void mptcp_pm_destroy(struct mptcp_sock *msk)
 	 * can be reused (mptcp_disconnect()) and re-selected to a different PM
 	 */
 	mptcp_userspace_pm_free_local_addr_list(msk);
-
-	mptcp_pm_ops_release(msk);
 }
 
 void mptcp_pm_data_reset(struct mptcp_sock *msk)
@@ -1204,6 +1228,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	const struct net *net = sock_net((struct sock *)msk);
 	u8 pm_type = mptcp_get_pm_type(net);
 	struct mptcp_pm_data *pm = &msk->pm;
+	struct mptcp_pm_ops *pm_ops;
 
 	memset(&pm->reset, 0, sizeof(pm->reset));
 	pm->rm_list_tx.nr = 0;
@@ -1211,8 +1236,15 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	WRITE_ONCE(pm->pm_type, pm_type);
 
 	rcu_read_lock();
-	mptcp_pm_ops_init(msk, mptcp_get_path_manager(net));
+	pm_ops = mptcp_get_path_manager(net);
+	if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
+		pr_warn_once("pm %s fails, fallback to default pm",
+			     pm_ops ? pm_ops->name : NULL);
+		pm_ops = &mptcp_pm_kernel;
+	}
 	rcu_read_unlock();
+
+	mptcp_pm_ops_init(msk, pm_ops);
 }
 
 void mptcp_pm_data_init(struct mptcp_sock *msk)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6bd7d522281c..fa28b2737583 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3751,6 +3751,9 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 		inet_sk(nsk)->pinet6 = mptcp_inet6_sk(nsk);
 #endif
 
+	msk = mptcp_sk(nsk);
+	RCU_INIT_POINTER(msk->pm.ops, NULL);
+
 	__mptcp_init_sock(nsk);
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -3820,6 +3823,7 @@ static void mptcp_destroy(struct sock *sk)
 	/* allow the following to close even the initial subflow */
 	msk->free_first = 1;
 	mptcp_destroy_common(msk);
+	mptcp_pm_ops_release(msk);
 	sk_sockets_allocated_dec(sk);
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index af0c36155c4c..be65d231aa8f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -222,7 +222,7 @@ struct mptcp_pm_data {
 	struct mptcp_addr_info remote;
 	struct list_head anno_list;
 	struct list_head userspace_pm_local_addr_list;
-	struct mptcp_pm_ops *ops;
+	struct mptcp_pm_ops __rcu *ops;	/* RCU: read via mptcp_pm_rcu_deref() */
 
 	spinlock_t	lock;		/*protects the whole PM data */
 
@@ -1101,6 +1101,7 @@ void __init mptcp_pm_init(void);
 void mptcp_pm_data_init(struct mptcp_sock *msk);
 void mptcp_pm_data_reset(struct mptcp_sock *msk);
 void mptcp_pm_destroy(struct mptcp_sock *msk);
+void mptcp_pm_ops_release(struct mptcp_sock *msk);
 int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 			struct mptcp_addr_info *addr);
 int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2d7ccb01d234..6cb0ab1fbb0f 100644
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
@@ -634,12 +637,16 @@ static int subflow_chk_local_id(struct sock *sk)
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

