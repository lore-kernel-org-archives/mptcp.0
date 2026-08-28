Received: from mta0.migadu.com (out-231.mta0.migadu.com [91.218.175.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792F853E0B
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 06:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787897218; cv=none; b=qwcFoU4qXEgYCW8hLl2Is/FBxsf9pAhuPRSm8/PAVBwdQDN4JVLfoN1jF9kXJ9rW4jvkU4VHzZTrvvVcuDNOviPyFzE3vkc0ryhc9yRn33Nu+JOezF2rW3MqWKwDo8AP9GwUSGh6i8caMeEKqMcV+1GMihgHkQo188QvWPzu+O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787897218; c=relaxed/simple;
	bh=bXkz3eJkWWjjscr9THUiuxu+5ydAwTJzTMVie+loEuY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdyCBl/+ibfGj2Dmd2sgtqXWVqstz+/z/XnRgjF8+V9ZdlZG1kcePsdun3+WQOzf40bNtsXJvaLnYipBz9HAS81YpTgmrGgWq2c1cNvRvIitoKcM1OpnIloPPMa0W9EvIjqRNuYRF26iF6Hjt4I0NBD2umeL7+PshNjozb+B05g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B7r5Kln/; arc=none smtp.client-ip=91.218.175.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B7r5Kln/"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=bXkz3eJkWWjjscr9THUiuxu+5ydAwTJzTMVie+loEuY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787897213; v=1; x=1788502013;
 b=B7r5Kln/TerwcraZ29EgUhYN0DAu73Qbf8e9PdDU232w3vOjEMLNvQ+VORRUoPiqymsZesSW
 B3cEbHAputOqayCjCvL2IK6rBsQIsic9JdcmMkj6zR/IzYPidNO6YdTmsaV6d3AKYhOSfULcWGk
 pnwqwk8AyVV/ANclPyo9wDyU=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id c34f3183dfc434b5;
	Fri, 28 Aug 2026 06:06:53 +0000
X-Mizu-Trace-ID: c34f3183dfc434b5
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v5 1/6] mptcp: sched: change scheduler sysctl atomically
Date: Fri, 28 Aug 2026 14:06:38 +0800
Message-ID: <20260828060643.14397-2-gang.yan@linux.dev>
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

The per-netns scheduler name is stored as an inline char[] buffer and
updated via strscpy() from the sysctl handler. A concurrent reader (e.g.
mptcp_init_sock() resolving the default scheduler) can observe a
half-written name, which is also flagged by KCSAN. READ_ONCE() does not
help here as it cannot read a multi-byte string atomically.

Following the tcp_congestion_control() model, store a pointer to the
immutable struct mptcp_sched_ops instead of the name string. A pointer
store is a single atomic word, so readers always observe a consistent
value, and mptcp_get_scheduler() can now return the ops directly
instead of going through mptcp_sched_find() again.

Assisted-by: Claude:GLM5.2
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/626
Co-developed-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/ctrl.c     | 63 +++++++++++++++++++++++++++++++++++---------
 net/mptcp/protocol.c |  3 +--
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/sched.c    |  2 +-
 4 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 63c5747f0f63..7d0f3421bd04 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -39,7 +39,7 @@ struct mptcp_pernet {
 	u8 allow_join_initial_addr_port;
 	u8 pm_type;
 	u8 add_addr_v6_port_drop_ts;
-	char scheduler[MPTCP_SCHED_NAME_MAX];
+	struct mptcp_sched_ops __rcu *scheduler;
 	char path_manager[MPTCP_PM_NAME_MAX];
 };
 
@@ -90,9 +90,17 @@ const char *mptcp_get_path_manager(const struct net *net)
 	return mptcp_get_pernet(net)->path_manager;
 }
 
-const char *mptcp_get_scheduler(const struct net *net)
+static struct mptcp_sched_ops *mptcp_pernet_sched(struct mptcp_pernet *pernet)
 {
-	return mptcp_get_pernet(net)->scheduler;
+	struct mptcp_sched_ops *sched;
+
+	sched = rcu_dereference(pernet->scheduler);
+	return sched ? sched : &mptcp_sched_default;
+}
+
+struct mptcp_sched_ops *mptcp_get_scheduler(const struct net *net)
+{
+	return mptcp_pernet_sched(mptcp_get_pernet(net));
 }
 
 unsigned int mptcp_add_addr_v6_port_drop_ts(const struct net *net)
@@ -112,23 +120,33 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	pernet->allow_join_initial_addr_port = 1;
 	pernet->stale_loss_cnt = 4;
 	pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
-	strscpy(pernet->scheduler, "default", sizeof(pernet->scheduler));
+
+	if (bpf_try_module_get(&mptcp_sched_default, mptcp_sched_default.owner))
+		RCU_INIT_POINTER(pernet->scheduler, &mptcp_sched_default);
+
 	strscpy(pernet->path_manager, "kernel", sizeof(pernet->path_manager));
 	pernet->add_addr_v6_port_drop_ts = 1;
 }
 
 #ifdef CONFIG_SYSCTL
-static int mptcp_set_scheduler(char *scheduler, const char *name)
+static int mptcp_set_scheduler(struct mptcp_pernet *pernet, const char *name)
 {
-	struct mptcp_sched_ops *sched;
+	struct mptcp_sched_ops *sched, *prev;
 	int ret = 0;
 
 	rcu_read_lock();
 	sched = mptcp_sched_find(name);
-	if (sched)
-		strscpy(scheduler, name, MPTCP_SCHED_NAME_MAX);
-	else
+	if (sched) {
+		if (bpf_try_module_get(sched, sched->owner)) {
+			prev = xchg(&pernet->scheduler, sched);
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
@@ -137,7 +155,9 @@ static int mptcp_set_scheduler(char *scheduler, const char *name)
 static int proc_scheduler(const struct ctl_table *ctl, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	char (*scheduler)[MPTCP_SCHED_NAME_MAX] = ctl->data;
+	struct mptcp_pernet *pernet = container_of(ctl->data,
+						   struct mptcp_pernet,
+						   scheduler);
 	char val[MPTCP_SCHED_NAME_MAX];
 	struct ctl_table tbl = {
 		.data = val,
@@ -145,11 +165,13 @@ static int proc_scheduler(const struct ctl_table *ctl, int write,
 	};
 	int ret;
 
-	strscpy(val, *scheduler, MPTCP_SCHED_NAME_MAX);
+	rcu_read_lock();
+	strscpy(val, mptcp_pernet_sched(pernet)->name, MPTCP_SCHED_NAME_MAX);
+	rcu_read_unlock();
 
 	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
 	if (write && ret == 0)
-		ret = mptcp_set_scheduler(*scheduler, val);
+		ret = mptcp_set_scheduler(pernet, val);
 
 	return ret;
 }
@@ -563,18 +585,33 @@ void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
 static int __net_init mptcp_net_init(struct net *net)
 {
 	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
+	int ret;
 
 	mptcp_pernet_set_defaults(pernet);
 
-	return mptcp_pernet_new_table(net, pernet);
+	ret = mptcp_pernet_new_table(net, pernet);
+	if (ret) {
+		struct mptcp_sched_ops *sched;
+
+		sched = rcu_dereference_protected(pernet->scheduler, true);
+		if (sched)
+			bpf_module_put(sched, sched->owner);
+	}
+
+	return ret;
 }
 
 /* Note: the callback will only be called per extra netns */
 static void __net_exit mptcp_net_exit(struct net *net)
 {
 	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
+	struct mptcp_sched_ops *sched;
 
 	mptcp_pernet_del_table(pernet);
+
+	sched = rcu_dereference_protected(pernet->scheduler, true);
+	if (sched)
+		bpf_module_put(sched, sched->owner);
 }
 
 static struct pernet_operations mptcp_pernet_ops = {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f22d64ab1c53..6bd7d522281c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3273,8 +3273,7 @@ static int mptcp_init_sock(struct sock *sk)
 		return -ENOMEM;
 
 	rcu_read_lock();
-	ret = mptcp_init_sched(mptcp_sk(sk),
-			       mptcp_sched_find(mptcp_get_scheduler(net)));
+	ret = mptcp_init_sched(mptcp_sk(sk), mptcp_get_scheduler(net));
 	rcu_read_unlock();
 	if (ret)
 		return ret;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3d250e8204d5..3b13d507433b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -803,7 +803,7 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net);
 unsigned int mptcp_close_timeout(const struct sock *sk);
 int mptcp_get_pm_type(const struct net *net);
 const char *mptcp_get_path_manager(const struct net *net);
-const char *mptcp_get_scheduler(const struct net *net);
+struct mptcp_sched_ops *mptcp_get_scheduler(const struct net *net);
 unsigned int mptcp_add_addr_v6_port_drop_ts(const struct net *net);
 
 void mptcp_active_disable(struct sock *sk);
@@ -1155,6 +1155,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 
 /* the default path manager, used in mptcp_pm_unregister */
 extern struct mptcp_pm_ops mptcp_pm_kernel;
+extern struct mptcp_sched_ops mptcp_sched_default;
 
 struct mptcp_pm_ops *mptcp_pm_find(const char *name);
 int mptcp_pm_register(struct mptcp_pm_ops *pm_ops);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 1e59072d478c..0d13ee46ffdf 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -40,7 +40,7 @@ static int mptcp_sched_default_get_retrans(struct mptcp_sock *msk)
 	return 0;
 }
 
-static struct mptcp_sched_ops mptcp_sched_default = {
+struct mptcp_sched_ops mptcp_sched_default = {
 	.get_send	= mptcp_sched_default_get_send,
 	.get_retrans	= mptcp_sched_default_get_retrans,
 	.name		= "default",
-- 
2.43.0

