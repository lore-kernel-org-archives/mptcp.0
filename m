Received: from mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1B745FFB4
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514539; cv=none; b=Jv+q8qlBklTWjNCruvNiuGnNHsuPt76KTRTKdcrQybK1QL+Gn7xmcLs8ZeR6V/cYEiu4nuzoIdgxFa+JBF4KW2uCXmgHxjv/qyfU7THxoijpK2y1RaIJmAVeH8Di7mxYo+F9auml7yMPkGVtylQlmDC0NeRSYDwj61Xsxl60dC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514539; c=relaxed/simple;
	bh=rJZA++h0H6N8rFhPhJBJQ/h8b4tU7/zbmd43tpJ4tuI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPGXvrEw6Z0AGa3HBKGCnIsKvC/U9GALl1JBzRp/9LiHttsMji9vS/bly5i7VfV75vBdsQdHTHL13lNmIAosRh4UyxMB87Nj2l0dMfLatJ5nRZ3APyDyPyw0TQqqKRctjdx511JPHJqBlQfvxGICsDcBdD1UoBmIvLg5h4I+RtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=woxa2vNm; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="woxa2vNm"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=rJZA++h0H6N8rFhPhJBJQ/h8b4tU7/zbmd43tpJ4tuI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788514535; v=1; x=1789119335;
 b=woxa2vNmuHE8bClboG3p1lxPjeWJmUoVASocfiaC5FGtZRNHtqtgwRwKMpbpdlAXlowGkfPL
 1AJlzase9wkpf49Si+O8I94H0zOLpAcF3T1KmbVllTwa1AGVOyMPzssBkqFQ7ySuKunbHqirmb4
 ISfwwWyFUtwK9oK7YAZpm+f0=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 526b0eadc573db47;
	Fri, 04 Sep 2026 09:35:35 +0000
X-Mizu-Trace-ID: 526b0eadc573db47
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v6 2/6] mptcp: pm: change path_manager sysctl atomically
Date: Fri,  4 Sep 2026 17:35:27 +0800
Message-ID: <20260904093531.20023-3-gang.yan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904093531.20023-1-gang.yan@linux.dev>
References: <20260904093531.20023-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

The per-netns path manager name is stored as an inline char[] buffer and
updated via strscpy() from the sysctl handler. A concurrent reader can
observe a half-written name (KCSAN), which READ_ONCE() cannot fix for a
multi-byte string.

Following the tcp_congestion_control() model (and the scheduler change
in the previous patch), store a pointer to the immutable
struct mptcp_pm_ops instead of the name string.

No module reference is taken on the path manager ops for now, as they
can only be registered from built-in code on one side, and on the other
side the reference counting will be introduced by the last patch of
this series, together with the BPF path manager support.

Assisted-by: Claude:GLM5.2
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/626
Co-developed-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/ctrl.c     | 33 +++++++++++++++++++++++----------
 net/mptcp/pm.c       |  3 ++-
 net/mptcp/protocol.h |  3 +--
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 7d0f3421bd04..76ff2a41ba38 100644
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
@@ -85,9 +85,20 @@ int mptcp_get_pm_type(const struct net *net)
 	return mptcp_get_pernet(net)->pm_type;
 }
 
-const char *mptcp_get_path_manager(const struct net *net)
+static struct mptcp_pm_ops *mptcp_pernet_pm(struct mptcp_pernet *pernet)
 {
-	return mptcp_get_pernet(net)->path_manager;
+	struct mptcp_pm_ops *pm_ops;
+
+	pm_ops = rcu_dereference(pernet->path_manager);
+	return pm_ops ? pm_ops : &mptcp_pm_kernel;
+}
+
+void mptcp_get_path_manager(const struct net *net, char *name)
+{
+	rcu_read_lock();
+	strscpy(name, mptcp_pernet_pm(mptcp_get_pernet(net))->name,
+		MPTCP_PM_NAME_MAX);
+	rcu_read_unlock();
 }
 
 static struct mptcp_sched_ops *mptcp_pernet_sched(struct mptcp_pernet *pernet)
@@ -124,7 +135,8 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	if (bpf_try_module_get(&mptcp_sched_default, mptcp_sched_default.owner))
 		RCU_INIT_POINTER(pernet->scheduler, &mptcp_sched_default);
 
-	strscpy(pernet->path_manager, "kernel", sizeof(pernet->path_manager));
+	RCU_INIT_POINTER(pernet->path_manager, &mptcp_pm_kernel);
+
 	pernet->add_addr_v6_port_drop_ts = 1;
 }
 
@@ -210,7 +222,7 @@ static int proc_blackhole_detect_timeout(const struct ctl_table *table,
 	return ret;
 }
 
-static int mptcp_set_path_manager(char *path_manager, const char *name)
+static int mptcp_set_path_manager(struct mptcp_pernet *pernet, const char *name)
 {
 	struct mptcp_pm_ops *pm_ops;
 	int ret = 0;
@@ -218,7 +230,7 @@ static int mptcp_set_path_manager(char *path_manager, const char *name)
 	rcu_read_lock();
 	pm_ops = mptcp_pm_find(name);
 	if (pm_ops)
-		strscpy(path_manager, name, MPTCP_PM_NAME_MAX);
+		xchg(&pernet->path_manager, pm_ops);
 	else
 		ret = -ENOENT;
 	rcu_read_unlock();
@@ -232,7 +244,6 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
 	struct mptcp_pernet *pernet = container_of(ctl->data,
 						   struct mptcp_pernet,
 						   path_manager);
-	char (*path_manager)[MPTCP_PM_NAME_MAX] = ctl->data;
 	char pm_name[MPTCP_PM_NAME_MAX];
 	const struct ctl_table tbl = {
 		.data = pm_name,
@@ -240,11 +251,13 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
 	};
 	int ret;
 
-	strscpy(pm_name, *path_manager, MPTCP_PM_NAME_MAX);
+	rcu_read_lock();
+	strscpy(pm_name, mptcp_pernet_pm(pernet)->name, MPTCP_PM_NAME_MAX);
+	rcu_read_unlock();
 
 	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
 	if (write && ret == 0) {
-		ret = mptcp_set_path_manager(*path_manager, pm_name);
+		ret = mptcp_set_path_manager(pernet, pm_name);
 		if (ret == 0) {
 			u8 pm_type = __MPTCP_PM_TYPE_NR;
 
@@ -276,7 +289,7 @@ static int proc_pm_type(const struct ctl_table *ctl, int write,
 			pm_name = "kernel";
 		else if (pm_type == MPTCP_PM_TYPE_USERSPACE)
 			pm_name = "userspace";
-		mptcp_set_path_manager(pernet->path_manager, pm_name);
+		mptcp_set_path_manager(pernet, pm_name);
 	}
 
 	return ret;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d7c5b50b34cc..69a38cb48977 100644
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
index 5154c7ce3026..6f796d1c769a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -802,7 +802,7 @@ int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
 unsigned int mptcp_close_timeout(const struct sock *sk);
 int mptcp_get_pm_type(const struct net *net);
-const char *mptcp_get_path_manager(const struct net *net);
+void mptcp_get_path_manager(const struct net *net, char *name);
 struct mptcp_sched_ops *mptcp_get_scheduler(const struct net *net);
 unsigned int mptcp_add_addr_v6_port_drop_ts(const struct net *net);
 
@@ -1153,7 +1153,6 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 
-/* the default path manager, used in mptcp_pm_unregister */
 extern struct mptcp_pm_ops mptcp_pm_kernel;
 extern struct mptcp_sched_ops mptcp_sched_default;
 
-- 
2.43.0

