Received: from mta0.migadu.com (out-92.mta0.migadu.com [91.218.175.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E1221FC6
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786929904; cv=none; b=RWWipq+vlBy2Fr6g9X2bgmcQs7zjk15IRgEsfKODfNpLD8dpX9f1HCs/PYUWVbB5L169wh82COSqyNwMmdDsPwi002yP07IspzIjLV464nnhUosSrERbo8ZtZTKQkjXtxDXb1DF6mMGE5KtJFVGnvSA9sHzn8iAUqfdrKsozR14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786929904; c=relaxed/simple;
	bh=nMbEZ/NdpJ1iRw121fYzieyuNWpAmqS5DysJWsouQF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bexeCkOmr0G+LH+hi3PqRp48Sik6EfNG3UJnxPnzVX62NMq7zoKIDrwiXqwBK0kSupXGEuEkj4R3qAemDnECTzf1DTBk0A7oprX/4UI88VvXdA5G78uA5+Eax2m/6LrntClJ3ZAv/YR76Yqiwb7zQvm8W4+hqObzcpKncg54Hl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=umyi/Rej; arc=none smtp.client-ip=91.218.175.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="umyi/Rej"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=nMbEZ/NdpJ1iRw121fYzieyuNWpAmqS5DysJWsouQF0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786929900; v=1; x=1787534700;
 b=umyi/RejIyagnr/ViBdY7pxM5kzVUjTyPWxTpKB3D1hQfh7O5aEGUD1FvNYmekIVg3qDKWUE
 +TxrnjOJZiz3VNuz9ZLWXqWOs+6sFtArmtXi4vAd/JVwTLap6lJnIw8h4FPs1LI8laqpNdiRFJY
 jVuqEnvtuXN6cewycD+KH21U=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id b2f1d8ce94126654;
	Mon, 17 Aug 2026 01:24:59 +0000
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH mptcp-next 2/3] mptcp: pm: change path_manager sysctl atomically
Date: Mon, 17 Aug 2026 09:24:51 +0800
Message-ID: <20260817012452.7519-3-gang.yan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817012452.7519-1-gang.yan@linux.dev>
References: <20260817012452.7519-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

The per-netns path manager name is stored as an inline char[] buffer and
updated via strscpy() from the sysctl handler; a concurrent reader can
observe a half-written name (and KCSAN flags the race), which READ_ONCE()
cannot fix for a multi-byte string.

Following the tcp_congestion_control() model (and the scheduler change in
the previous patch), store a pointer to the immutable struct mptcp_pm_ops
instead of the name string:
  - mptcp_set_path_manager() looks the ops up, takes a module reference,
    and atomically swaps the pernet pointer with xchg(), releasing the
    previous reference;
  - mptcp_get_path_manager() copies the ops name out under rcu_read_lock();
  - the pm_type field derived from the name is now written
    with WRITE_ONCE() to pair with its READ_ONCE() readers;
  - the default reference is taken in mptcp_pernet_set_defaults() and
    released in mptcp_net_exit().

Assisted-by: Claude:GLM5.2
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/626
Co-developed-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/ctrl.c     | 50 +++++++++++++++++++++++++++++++-------------
 net/mptcp/pm.c       |  3 ++-
 net/mptcp/protocol.h |  3 +--
 3 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 85e9d3e996db..fa28aecfb856 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -40,7 +40,7 @@ struct mptcp_pernet {
 	u8 pm_type;
 	u8 add_addr_v6_port_drop_ts;
 	struct mptcp_sched_ops __rcu *scheduler;
-	char path_manager[MPTCP_PM_NAME_MAX];
+	struct mptcp_pm_ops __rcu *path_manager;
 };
 
 static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
@@ -85,9 +85,14 @@ int mptcp_get_pm_type(const struct net *net)
 	return mptcp_get_pernet(net)->pm_type;
 }
 
-const char *mptcp_get_path_manager(const struct net *net)
+void mptcp_get_path_manager(const struct net *net, char *name)
 {
-	return mptcp_get_pernet(net)->path_manager;
+	struct mptcp_pm_ops *pm_ops;
+
+	rcu_read_lock();
+	pm_ops = rcu_dereference(mptcp_get_pernet(net)->path_manager);
+	strscpy(name, pm_ops ? pm_ops->name : "kernel", MPTCP_PM_NAME_MAX);
+	rcu_read_unlock();
 }
 
 void mptcp_get_scheduler(const struct net *net, char *name)
@@ -121,7 +126,9 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	if (bpf_try_module_get(&mptcp_sched_default, mptcp_sched_default.owner))
 		RCU_INIT_POINTER(pernet->scheduler, &mptcp_sched_default);
 
-	strscpy(pernet->path_manager, "kernel", sizeof(pernet->path_manager));
+	if (bpf_try_module_get(&mptcp_pm_kernel, mptcp_pm_kernel.owner))
+		RCU_INIT_POINTER(pernet->path_manager, &mptcp_pm_kernel);
+
 	pernet->add_addr_v6_port_drop_ts = 1;
 }
 
@@ -209,17 +216,24 @@ static int proc_blackhole_detect_timeout(const struct ctl_table *table,
 	return ret;
 }
 
-static int mptcp_set_path_manager(char *path_manager, const char *name)
+static int mptcp_set_path_manager(struct mptcp_pernet *pernet, const char *name)
 {
-	struct mptcp_pm_ops *pm_ops;
+	struct mptcp_pm_ops *pm_ops, *prev;
 	int ret = 0;
 
 	rcu_read_lock();
 	pm_ops = mptcp_pm_find(name);
-	if (pm_ops)
-		strscpy(path_manager, name, MPTCP_PM_NAME_MAX);
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
@@ -231,7 +245,7 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
 	struct mptcp_pernet *pernet = container_of(ctl->data,
 						   struct mptcp_pernet,
 						   path_manager);
-	char (*path_manager)[MPTCP_PM_NAME_MAX] = ctl->data;
+	struct mptcp_pm_ops *pm_ops;
 	char pm_name[MPTCP_PM_NAME_MAX];
 	const struct ctl_table tbl = {
 		.data = pm_name,
@@ -239,11 +253,14 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
 	};
 	int ret;
 
-	strscpy(pm_name, *path_manager, MPTCP_PM_NAME_MAX);
+	rcu_read_lock();
+	pm_ops = rcu_dereference(pernet->path_manager);
+	strscpy(pm_name, pm_ops ? pm_ops->name : "kernel", MPTCP_PM_NAME_MAX);
+	rcu_read_unlock();
 
 	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
 	if (write && ret == 0) {
-		ret = mptcp_set_path_manager(*path_manager, pm_name);
+		ret = mptcp_set_path_manager(pernet, pm_name);
 		if (ret == 0) {
 			u8 pm_type = __MPTCP_PM_TYPE_NR;
 
@@ -251,7 +268,7 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
 				pm_type = MPTCP_PM_TYPE_KERNEL;
 			else if (strncmp(pm_name, "userspace", MPTCP_PM_NAME_MAX) == 0)
 				pm_type = MPTCP_PM_TYPE_USERSPACE;
-			pernet->pm_type = pm_type;
+			WRITE_ONCE(pernet->pm_type, pm_type);
 		}
 	}
 
@@ -275,7 +292,7 @@ static int proc_pm_type(const struct ctl_table *ctl, int write,
 			pm_name = "kernel";
 		else if (pm_type == MPTCP_PM_TYPE_USERSPACE)
 			pm_name = "userspace";
-		mptcp_set_path_manager(pernet->path_manager, pm_name);
+		mptcp_set_path_manager(pernet, pm_name);
 	}
 
 	return ret;
@@ -595,12 +612,17 @@ static void __net_exit mptcp_net_exit(struct net *net)
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
index ba7c6f80a183..09f99bcd827c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1204,7 +1204,7 @@ void mptcp_pm_destroy(struct mptcp_sock *msk)
 void mptcp_pm_data_reset(struct mptcp_sock *msk)
 {
 	const struct net *net = sock_net((struct sock *)msk);
-	const char *pm_name = mptcp_get_path_manager(net);
+	char pm_name[MPTCP_PM_NAME_MAX];
 	u8 pm_type = mptcp_get_pm_type(net);
 	struct mptcp_pm_data *pm = &msk->pm;
 
@@ -1213,6 +1213,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	pm->rm_list_rx.nr = 0;
 	WRITE_ONCE(pm->pm_type, pm_type);
 
+	mptcp_get_path_manager(net, pm_name);
 	rcu_read_lock();
 	mptcp_pm_ops_init(msk, pm_name);
 	rcu_read_unlock();
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index af79b3450ab7..99f447f2808f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -802,7 +802,7 @@ int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
 unsigned int mptcp_close_timeout(const struct sock *sk);
 int mptcp_get_pm_type(const struct net *net);
-const char *mptcp_get_path_manager(const struct net *net);
+void mptcp_get_path_manager(const struct net *net, char *name);
 void mptcp_get_scheduler(const struct net *net, char *name);
 unsigned int mptcp_add_addr_v6_port_drop_ts(const struct net *net);
 
@@ -1153,7 +1153,6 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 
-/* the default path manager, used in mptcp_pm_unregister */
 extern struct mptcp_pm_ops mptcp_pm_kernel;
 extern struct mptcp_sched_ops mptcp_sched_default;
 
-- 
2.43.0

