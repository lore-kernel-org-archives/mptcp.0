Received: from mta1.migadu.com (out-137.mta1.migadu.com [95.215.58.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467A1248F72
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 07:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787557003; cv=none; b=LErPQGwMegqbrCRdHm8xVxwTt1R5mSrv1uQyCJPChSpZdqCKH/IjYh7OG5egImV/Ckh5sZMemUR8Xljp66fviOZdz4K0QJOPdw8KvrV4mfZor4wa+CZxlYaf6hNXm3wbu7nWdGtJtqWSM4pl5CQ0yROM01AvhBqNKcfF173zUrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787557003; c=relaxed/simple;
	bh=rjOSMdC8vdi0Xvzbj+fUxFpWEut2EVHYsJsOg+RaQrQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVTurlVcBF+8UgvRWLQGQj0Fzn9nI5KXACSWy8pfkqqmsJKw6HWLQ5U7u3jrk67i5sgZA35Azptt/RSmzim0SPqafs+YnRexGSPAQYbRuqLV61U7smVk86HjLZP+QUNxtg0JdfeJlWZ2Q9wM4Z0i+FQ+Eu7UcSWW2iWIjA2RJqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aPaJfHXF; arc=none smtp.client-ip=95.215.58.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aPaJfHXF"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=rjOSMdC8vdi0Xvzbj+fUxFpWEut2EVHYsJsOg+RaQrQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787556999; v=1; x=1788161799;
 b=aPaJfHXF2u6WERnDgMls/fJ3BPOpZiNmfom+x1cfiPaWQWAjj0hq/Ja8w6nA6WsX6inZF61q
 nEqPvQYbKEWmwRD0pdjPz6kAY7T1mqQp2firAg0jA/iknGaHvhb0WjbhhGWuT/CJevxrOu9YRq9
 Ku4aI2JkNUQpyhFXGNIEAzXw=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 0ccf145ba05ba512;
	Mon, 24 Aug 2026 07:36:39 +0000
X-Mizu-Trace-ID: 0ccf145ba05ba512
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v4 6/6] Squash to previous one
Date: Mon, 24 Aug 2026 15:36:25 +0800
Message-ID: <20260824073625.57471-7-gang.yan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824073625.57471-1-gang.yan@linux.dev>
References: <20260824073625.57471-1-gang.yan@linux.dev>
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

Keep it as a separate patch to ease the review, but to be squashed into
the previous one, which is itself a squash-to for "mptcp: pm: init and
release mptcp_pm_ops".

[1] https://sashiko.dev/#/patchset/20260819125629.49823-1-gang.yan@linux.dev?part=5

Assisted-by: Claude:GLM5.2
Co-developed-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/pm.c       | 54 +++++++++++++++++++++++++++++++++++---------
 net/mptcp/protocol.c |  4 ++++
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  |  9 +++++++-
 4 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 64244a1a01bc..ae75e68bc662 100644
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
@@ -1158,23 +1166,46 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 static void mptcp_pm_ops_init(struct mptcp_sock *msk,
 			      struct mptcp_pm_ops *pm_ops)
 {
+	struct mptcp_pm_ops *old;
+	bool need_sync = false;
+
 	if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
 		pr_warn_once("pm %s fails, fallback to default pm", pm_ops->name);
 		pm_ops = &mptcp_pm_kernel;
 	}
 
-	msk->pm.ops = pm_ops;
-	if (msk->pm.ops->init)
-		msk->pm.ops->init(msk);
+	spin_lock_bh(&msk->pm.lock);
+	old = rcu_dereference_protected(msk->pm.ops,
+					lockdep_is_held(&msk->pm.lock));
+	if (old == pm_ops) {
+		need_sync = false;
+	} else {
+		rcu_assign_pointer(msk->pm.ops, pm_ops);
+		need_sync = !!old;
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
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
 
@@ -1195,8 +1226,6 @@ void mptcp_pm_destroy(struct mptcp_sock *msk)
 	 * can be reused (mptcp_disconnect()) and re-selected to a different PM
 	 */
 	mptcp_userspace_pm_free_local_addr_list(msk);
-
-	mptcp_pm_ops_release(msk);
 }
 
 void mptcp_pm_data_reset(struct mptcp_sock *msk)
@@ -1204,6 +1233,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	const struct net *net = sock_net((struct sock *)msk);
 	u8 pm_type = mptcp_get_pm_type(net);
 	struct mptcp_pm_data *pm = &msk->pm;
+	struct mptcp_pm_ops *pm_ops;
 
 	memset(&pm->reset, 0, sizeof(pm->reset));
 	pm->rm_list_tx.nr = 0;
@@ -1211,8 +1241,10 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	WRITE_ONCE(pm->pm_type, pm_type);
 
 	rcu_read_lock();
-	mptcp_pm_ops_init(msk, mptcp_get_path_manager(net));
+	pm_ops = mptcp_get_path_manager(net);
 	rcu_read_unlock();
+
+	mptcp_pm_ops_init(msk, pm_ops);
 }
 
 void mptcp_pm_data_init(struct mptcp_sock *msk)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4d7cb50ec61a..6a139f28c2ae 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3746,6 +3746,9 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 		inet_sk(nsk)->pinet6 = mptcp_inet6_sk(nsk);
 #endif
 
+	msk = mptcp_sk(nsk);
+	RCU_INIT_POINTER(msk->pm.ops, NULL);
+
 	__mptcp_init_sock(nsk);
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -3815,6 +3818,7 @@ static void mptcp_destroy(struct sock *sk)
 	/* allow the following to close even the initial subflow */
 	msk->free_first = 1;
 	mptcp_destroy_common(msk);
+	mptcp_pm_ops_release(msk);
 	sk_sockets_allocated_dec(sk);
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1deefb8d3fcc..534f83781265 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -221,7 +221,7 @@ struct mptcp_pm_data {
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
index af81ad5e699d..c4a1169fab07 100644
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

