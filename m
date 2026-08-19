Received: from mta0.migadu.com (out-233.mta0.migadu.com [91.218.175.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBE6223708
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144205; cv=none; b=iPvTaYLzg6K5HakeW0lJu9MSBC1EMl3UagEDxuBEJRebAPhW27OBqGGn9LEMcYo6XY6rgq09ghy1yLH2nFemYIfOseM0l0El2lOCJj7v3CnCTkdY8De7PDHj/j7ZmXdBhXLq5jniFAalf08T5Ds+hYpWZgq59cZf+cLh0YU9OdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144205; c=relaxed/simple;
	bh=Ho+lqZhyxkHvmJxHUtGDboXCe42DE+eO8ypgyWG0A0Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGm7m9YV5TDGzQsPvtUiIAq+8+ZWOYffyavzF2OxpWsA6xQV+wlPK1yU1ppqmHgXhiUsWgwsiumUFZXmfR+PCrN4su51pAAhfIV6RXUEQSPM3ibA1MWisYMUbVXa7ID2hawM6SQwTU47UwIw9ApndYay7NUHG5Ih0LdOy7whs2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U9RwvgS6; arc=none smtp.client-ip=91.218.175.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U9RwvgS6"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Ho+lqZhyxkHvmJxHUtGDboXCe42DE+eO8ypgyWG0A0Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787144201; v=1; x=1787749001;
 b=U9RwvgS6F0GTfCcD7QHIHjVpO3uv9nKYNzXSoXRsIsnKNTbGZEbjUfyRmCm1rQ/ijVQMsKLE
 FrY67OVGCkRQV86uJV1775lmuWHc3G40dHJvCOJEj0GGS/hL8XF8kxO/EsGKIOKwTgmhsP589jq
 rYFWE6+d1LXKla1rEzKy5/mY=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (223.70.160.239)
	by smtp.migadu.com with ESMTPS id 3366343d6d054415;
	Wed, 19 Aug 2026 12:56:41 +0000
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v3 2/5] mptcp: pm: change path_manager sysctl atomically
Date: Wed, 19 Aug 2026 20:56:26 +0800
Message-ID: <20260819125629.49823-3-gang.yan@linux.dev>
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
index 6447945be93c..bbcf0ecd72d1 100644
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

