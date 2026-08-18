Received: from mta0.migadu.com (out-72.mta0.migadu.com [91.218.175.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89FF43F0B8
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046522; cv=none; b=DeizKZzfe2YD9gaqKA/fScTrvk0Hb78RveX2hu83hJHGTtEN068MbbScgvFLGLFR0+WTNQ4pVBESF93cDxjrf4a4OnZp7H8bkfZUuH34my/4AXqH1AV83KX0QeWIM0Noy60sIarpzzhEHVAfXgHF9vCo3DUCicCUM6nsfuuC740=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046522; c=relaxed/simple;
	bh=AmanxY6H7ETiONFDj3xk4NmGJs6kcBNWQt76OaUOEKk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OETcntg4xKcF60S+rIV5hl1TPkIh057S6Qww3MIXtpJJ0ORz6EY2GRjurjkTawTSz4TbpMqtWV4x9T19KC22bWcMRTHZ0kTTFHJRB75kLhtfhb8YPjQ26vOthD4rjbwsvZaUonglJnqouyUHYsthL1hyVWZZsuLEZVB6GdLU6a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ffR22wXX; arc=none smtp.client-ip=91.218.175.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ffR22wXX"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=AmanxY6H7ETiONFDj3xk4NmGJs6kcBNWQt76OaUOEKk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787046518; v=1; x=1787651318;
 b=ffR22wXXzLKIIObEP4oS3oTZHZqi1Fy6mV3fvI7yGZPZMdQV3FZxut+dKs88w4pph/959qLt
 aNoqE/gQ7vka99fDIM7AgAvXwFzXdL+YorfgjRMUgJbF1EvDIeFHeuoUmIO/6JB6+U8hxoBa7c+
 mhfXQ6nuK5zrYQ80PI2JYNjI=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id e13d26de5bcb86be;
	Tue, 18 Aug 2026 09:48:38 +0000
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 2/5] mptcp: pm: change path_manager sysctl atomically
Date: Tue, 18 Aug 2026 17:48:22 +0800
Message-ID: <20260818094825.48446-3-gang.yan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818094825.48446-1-gang.yan@linux.dev>
References: <20260818094825.48446-1-gang.yan@linux.dev>
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
  - mptcp_set_path_manager() looks the ops up and atomically swaps the
    pernet pointer with xchg();
  - mptcp_get_path_manager() copies the ops name out under rcu_read_lock();
  - the default ops is assigned in mptcp_pernet_set_defaults().

Assisted-by: Claude:GLM5.2
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/626
Co-developed-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/ctrl.c     | 28 ++++++++++++++++++----------
 net/mptcp/pm.c       |  3 ++-
 net/mptcp/protocol.h |  3 +--
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 479b31eb3007..c0481b09c1a1 100644
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
@@ -119,8 +124,8 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
 
 	RCU_INIT_POINTER(pernet->scheduler, &mptcp_sched_default);
+	RCU_INIT_POINTER(pernet->path_manager, &mptcp_pm_kernel);
 
-	strscpy(pernet->path_manager, "kernel", sizeof(pernet->path_manager));
 	pernet->add_addr_v6_port_drop_ts = 1;
 }
 
@@ -201,7 +206,7 @@ static int proc_blackhole_detect_timeout(const struct ctl_table *table,
 	return ret;
 }
 
-static int mptcp_set_path_manager(char *path_manager, const char *name)
+static int mptcp_set_path_manager(struct mptcp_pernet *pernet, const char *name)
 {
 	struct mptcp_pm_ops *pm_ops;
 	int ret = 0;
@@ -209,7 +214,7 @@ static int mptcp_set_path_manager(char *path_manager, const char *name)
 	rcu_read_lock();
 	pm_ops = mptcp_pm_find(name);
 	if (pm_ops)
-		strscpy(path_manager, name, MPTCP_PM_NAME_MAX);
+		xchg(&pernet->path_manager, pm_ops);
 	else
 		ret = -ENOENT;
 	rcu_read_unlock();
@@ -223,7 +228,7 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
 	struct mptcp_pernet *pernet = container_of(ctl->data,
 						   struct mptcp_pernet,
 						   path_manager);
-	char (*path_manager)[MPTCP_PM_NAME_MAX] = ctl->data;
+	struct mptcp_pm_ops *pm_ops;
 	char pm_name[MPTCP_PM_NAME_MAX];
 	const struct ctl_table tbl = {
 		.data = pm_name,
@@ -231,11 +236,14 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
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
 
@@ -267,7 +275,7 @@ static int proc_pm_type(const struct ctl_table *ctl, int write,
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

