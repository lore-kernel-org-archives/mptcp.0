Received: from mta1.migadu.com (out-16.mta1.migadu.com [95.215.58.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0A21DA60D
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 01:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786929903; cv=none; b=P/3dcE9yaf38jsIbYFGsKgGTWUpRlP5v+RNMXQ0nF/fgAdGm7FiidbtBFNTQqnoszQHyxHU+1HR5mPda1F4oO/beZEApJwAMfZHR3rZqonSCrSVofhVHXrDcwDnBjurE7W+C3Y5lkRuey/EuvZbpZ9Hr/YKICw8YA7UnkVEvbRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786929903; c=relaxed/simple;
	bh=kPGYUNPDvBkGhKiI8eEN0RoDpJmQxOWaNGkoaK4x3x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nbo6hDw+2Ju9OlGLF2c9Sx8/0mCEExAYkUrZKRP+YHqWeVpd3oLY6cFLg4ivrBdhUA9eK8seYDilenuOfN5z6a5+YvpctHE4rFI7nAvb5ZXPJdcv95XgyRVNQaCcaJ1aUnTIVJjJacw7ftGW76l/BG23oFXiehWEO4IieloLeqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TZASG8x5; arc=none smtp.client-ip=95.215.58.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TZASG8x5"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=kPGYUNPDvBkGhKiI8eEN0RoDpJmQxOWaNGkoaK4x3x8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786929898; v=1; x=1787534698;
 b=TZASG8x5f9vEIxwN5xz3alMhhlIymyg4QwAOjJcsclhxbddTeizqmE+HgxERfMnaeUnx6RGw
 u2gPE1QNktThOgY+N0j223n2Q7ucNf20VvhtbNXxyE7QsC/HkkIUFIM+OdUomuGRBw8IGr9R5aC
 EuYvAriX95xg9QBQgkwfKffA=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id bad7012b45d9ee1f;
	Mon, 17 Aug 2026 01:24:58 +0000
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH mptcp-next 1/3] mptcp: sched: change scheduler sysctl atomically
Date: Mon, 17 Aug 2026 09:24:50 +0800
Message-ID: <20260817012452.7519-2-gang.yan@linux.dev>
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

The per-netns scheduler name is stored as an inline char[] buffer and
updated via strscpy() from the sysctl handler. A concurrent reader (e.g.
mptcp_init_sock() resolving the default scheduler) can observe a
half-written name, which is also flagged by KCSAN. READ_ONCE() does not
help here as it cannot read a multi-byte string atomically.

Following the tcp_congestion_control() model, store a pointer to the
immutable struct mptcp_sched_ops instead of the name string:
  - mptcp_set_scheduler() now looks the ops up, takes a module reference,
    and atomically swaps the pernet pointer with xchg(), releasing the
    previous reference;
  - mptcp_get_scheduler() copies the ops name out under rcu_read_lock();
  - the default reference is taken in mptcp_pernet_set_defaults() and
    released in mptcp_net_exit(), mirroring tcp_sk_init()/tcp_sk_exit().

A pointer store is a single atomic word, so readers always observe a
consistent value.

Assisted-by: Claude:GLM5.2
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/626
Co-developed-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/ctrl.c     | 50 +++++++++++++++++++++++++++++++++-----------
 net/mptcp/protocol.c |  5 +++--
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/sched.c    |  2 +-
 4 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 63c5747f0f63..85e9d3e996db 100644
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
 
@@ -90,9 +90,14 @@ const char *mptcp_get_path_manager(const struct net *net)
 	return mptcp_get_pernet(net)->path_manager;
 }
 
-const char *mptcp_get_scheduler(const struct net *net)
+void mptcp_get_scheduler(const struct net *net, char *name)
 {
-	return mptcp_get_pernet(net)->scheduler;
+	struct mptcp_sched_ops *sched;
+
+	rcu_read_lock();
+	sched = rcu_dereference(mptcp_get_pernet(net)->scheduler);
+	strscpy(name, sched ? sched->name : "default", MPTCP_SCHED_NAME_MAX);
+	rcu_read_unlock();
 }
 
 unsigned int mptcp_add_addr_v6_port_drop_ts(const struct net *net)
@@ -112,23 +117,33 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
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
@@ -137,7 +152,10 @@ static int mptcp_set_scheduler(char *scheduler, const char *name)
 static int proc_scheduler(const struct ctl_table *ctl, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	char (*scheduler)[MPTCP_SCHED_NAME_MAX] = ctl->data;
+	struct mptcp_pernet *pernet = container_of(ctl->data,
+						   struct mptcp_pernet,
+						   scheduler);
+	struct mptcp_sched_ops *sched;
 	char val[MPTCP_SCHED_NAME_MAX];
 	struct ctl_table tbl = {
 		.data = val,
@@ -145,11 +163,14 @@ static int proc_scheduler(const struct ctl_table *ctl, int write,
 	};
 	int ret;
 
-	strscpy(val, *scheduler, MPTCP_SCHED_NAME_MAX);
+	rcu_read_lock();
+	sched = rcu_dereference(pernet->scheduler);
+	strscpy(val, sched ? sched->name : "default", MPTCP_SCHED_NAME_MAX);
+	rcu_read_unlock();
 
 	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
 	if (write && ret == 0)
-		ret = mptcp_set_scheduler(*scheduler, val);
+		ret = mptcp_set_scheduler(pernet, val);
 
 	return ret;
 }
@@ -573,8 +594,13 @@ static int __net_init mptcp_net_init(struct net *net)
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
index f879b1061f2d..9d84dd803802 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3260,6 +3260,7 @@ static void mptcp_ca_reset(struct sock *sk)
 static int mptcp_init_sock(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
+	char sched_name[MPTCP_SCHED_NAME_MAX];
 	int ret;
 
 	__mptcp_init_sock(sk);
@@ -3271,8 +3272,8 @@ static int mptcp_init_sock(struct sock *sk)
 		return -ENOMEM;
 
 	rcu_read_lock();
-	ret = mptcp_init_sched(mptcp_sk(sk),
-			       mptcp_sched_find(mptcp_get_scheduler(net)));
+	mptcp_get_scheduler(net, sched_name);
+	ret = mptcp_init_sched(mptcp_sk(sk), mptcp_sched_find(sched_name));
 	rcu_read_unlock();
 	if (ret)
 		return ret;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7e168e450fb0..af79b3450ab7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -803,7 +803,7 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net);
 unsigned int mptcp_close_timeout(const struct sock *sk);
 int mptcp_get_pm_type(const struct net *net);
 const char *mptcp_get_path_manager(const struct net *net);
-const char *mptcp_get_scheduler(const struct net *net);
+void mptcp_get_scheduler(const struct net *net, char *name);
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

