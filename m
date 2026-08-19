Received: from mta1.migadu.com (out-148.mta1.migadu.com [95.215.58.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092AA21767D
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144217; cv=none; b=FQrlrBF0nedYM5eEIW86XtBRDL9JZylXUXNJKBEZfqKQVLTd2JL9K9RDj73q7RQsGen63/P89zXRpsaeAZkGac3YgCJ0q4J+TatEqjsQ07evsyXNxEXNmUXg3vKrOWOpAuoA7I1JngYvY97INpA3UvEhkoi/W6JDdsevYSTCJQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144217; c=relaxed/simple;
	bh=6YFddDS4cFvpLVFAU88j4fEOAciCasvr3nl3gU4RJVM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMpKrmJydEMvZdK0h4XwTIAjWEBTe6qv2K2oW6iJvmf8/1OxkKxtTnh3fJaQ4mjHS6bXcYKAFl5YBEZEB/++jCpC6c7E5QXlwOpLRJ2wpu2vWDMk6ZIj4DF5+p1k7jyV8cFYQ8pRfWYmDtQOFth2W4slfDQJYtNNXU4oCqGAC64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LpokEZ+O; arc=none smtp.client-ip=95.215.58.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LpokEZ+O"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=6YFddDS4cFvpLVFAU88j4fEOAciCasvr3nl3gU4RJVM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787144212; v=1; x=1787749012;
 b=LpokEZ+OCGl9eHPf5domm/jNOEFd+X+vKLn5PHBdJin3XZ6e1PQD0cOF+KSIH3GkXKtZXJfc
 GLpSyNZd/WekeCdMS3bRewAXCRYZZSNm6E1eNlqTc0fTMGCNsWL21NHkPQVGpjWK5dAeBJoAgBt
 AKwoRgdGjPjDlxKv+QvAa78k=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (223.70.160.239)
	by smtp.migadu.com with ESMTPS id ea02641fcab58808;
	Wed, 19 Aug 2026 12:56:52 +0000
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v3 5/5] Squash to "mptcp: pm: init and release mptcp_pm_ops"
Date: Wed, 19 Aug 2026 20:56:29 +0800
Message-ID: <20260819125629.49823-6-gang.yan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819125629.49823-1-gang.yan@linux.dev>
References: <20260819125629.49823-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

This commit introduces the mptcp_pm_ops lifetime handling on sockets
(mptcp_pm_ops_init/release taking a module reference), and would then
be the first one whose per-net path managers can be unloaded while a
pernet still stores them.

mptcp_pm_ops_init() also takes the ops pointer directly instead of the
name, and mptcp_get_path_manager() returns the ops: the redundant
mptcp_pm_find() list walk from the name is avoided, as done for the
scheduler side earlier in this series.

Assisted-by: Claude:GLM5.2
Co-developed-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/ctrl.c     | 35 +++++++++++++++++++++++++----------
 net/mptcp/pm.c       | 12 ++++--------
 net/mptcp/protocol.h |  2 +-
 3 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 87491b961bf2..6379a9f481ac 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -93,12 +93,9 @@ static struct mptcp_pm_ops *mptcp_pernet_pm(struct mptcp_pernet *pernet)
 	return pm_ops ? pm_ops : &mptcp_pm_kernel;
 }
 
-void mptcp_get_path_manager(const struct net *net, char *name)
+struct mptcp_pm_ops *mptcp_get_path_manager(const struct net *net)
 {
-	rcu_read_lock();
-	strscpy(name, mptcp_pernet_pm(mptcp_get_pernet(net))->name,
-		MPTCP_PM_NAME_MAX);
-	rcu_read_unlock();
+	return mptcp_pernet_pm(mptcp_get_pernet(net));
 }
 
 static struct mptcp_sched_ops *mptcp_pernet_sched(struct mptcp_pernet *pernet)
@@ -135,7 +132,8 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	if (bpf_try_module_get(&mptcp_sched_default, mptcp_sched_default.owner))
 		RCU_INIT_POINTER(pernet->scheduler, &mptcp_sched_default);
 
-	RCU_INIT_POINTER(pernet->path_manager, &mptcp_pm_kernel);
+	if (bpf_try_module_get(&mptcp_pm_kernel, mptcp_pm_kernel.owner))
+		RCU_INIT_POINTER(pernet->path_manager, &mptcp_pm_kernel);
 
 	pernet->add_addr_v6_port_drop_ts = 1;
 }
@@ -224,15 +222,22 @@ static int proc_blackhole_detect_timeout(const struct ctl_table *table,
 
 static int mptcp_set_path_manager(struct mptcp_pernet *pernet, const char *name)
 {
-	struct mptcp_pm_ops *pm_ops;
+	struct mptcp_pm_ops *pm_ops, *prev;
 	int ret = 0;
 
 	rcu_read_lock();
 	pm_ops = mptcp_pm_find(name);
-	if (pm_ops)
-		xchg(&pernet->path_manager, pm_ops);
-	else
+	if (pm_ops) {
+		if (bpf_try_module_get(pm_ops, pm_ops->owner)) {
+			prev = xchg(&pernet->path_manager, pm_ops);
+			if (prev)
+				bpf_module_put(prev, prev->owner);
+		} else {
+			ret = -EBUSY;
+		}
+	} else {
 		ret = -ENOENT;
+	}
 	rcu_read_unlock();
 
 	return ret;
@@ -611,10 +616,15 @@ static int __net_init mptcp_net_init(struct net *net)
 	ret = mptcp_pernet_new_table(net, pernet);
 	if (ret) {
 		struct mptcp_sched_ops *sched;
+		struct mptcp_pm_ops *pm;
 
 		sched = rcu_dereference_protected(pernet->scheduler, true);
 		if (sched)
 			bpf_module_put(sched, sched->owner);
+
+		pm = rcu_dereference_protected(pernet->path_manager, true);
+		if (pm)
+			bpf_module_put(pm, pm->owner);
 	}
 
 	return ret;
@@ -625,12 +635,17 @@ static void __net_exit mptcp_net_exit(struct net *net)
 {
 	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
 	struct mptcp_sched_ops *sched;
+	struct mptcp_pm_ops *pm;
 
 	mptcp_pernet_del_table(pernet);
 
 	sched = rcu_dereference_protected(pernet->scheduler, true);
 	if (sched)
 		bpf_module_put(sched, sched->owner);
+
+	pm = rcu_dereference_protected(pernet->path_manager, true);
+	if (pm)
+		bpf_module_put(pm, pm->owner);
 }
 
 static struct pernet_operations mptcp_pernet_ops = {
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 09f99bcd827c..76158f0ac5a0 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1155,13 +1155,11 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 
-static void mptcp_pm_ops_init(struct mptcp_sock *msk, const char *pm_name)
+static void mptcp_pm_ops_init(struct mptcp_sock *msk,
+			      struct mptcp_pm_ops *pm_ops)
 {
-	struct mptcp_pm_ops *pm_ops;
-
-	pm_ops = mptcp_pm_find(pm_name);
 	if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
-		pr_warn_once("pm %s fails, fallback to default pm", pm_name);
+		pr_warn_once("pm %s fails, fallback to default pm", pm_ops->name);
 		pm_ops = &mptcp_pm_kernel;
 	}
 
@@ -1204,7 +1202,6 @@ void mptcp_pm_destroy(struct mptcp_sock *msk)
 void mptcp_pm_data_reset(struct mptcp_sock *msk)
 {
 	const struct net *net = sock_net((struct sock *)msk);
-	char pm_name[MPTCP_PM_NAME_MAX];
 	u8 pm_type = mptcp_get_pm_type(net);
 	struct mptcp_pm_data *pm = &msk->pm;
 
@@ -1213,9 +1210,8 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	pm->rm_list_rx.nr = 0;
 	WRITE_ONCE(pm->pm_type, pm_type);
 
-	mptcp_get_path_manager(net, pm_name);
 	rcu_read_lock();
-	mptcp_pm_ops_init(msk, pm_name);
+	mptcp_pm_ops_init(msk, mptcp_get_path_manager(net));
 	rcu_read_unlock();
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bbcf0ecd72d1..1deefb8d3fcc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -802,7 +802,7 @@ int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
 unsigned int mptcp_close_timeout(const struct sock *sk);
 int mptcp_get_pm_type(const struct net *net);
-void mptcp_get_path_manager(const struct net *net, char *name);
+struct mptcp_pm_ops *mptcp_get_path_manager(const struct net *net);
 struct mptcp_sched_ops *mptcp_get_scheduler(const struct net *net);
 unsigned int mptcp_add_addr_v6_port_drop_ts(const struct net *net);
 
-- 
2.43.0

