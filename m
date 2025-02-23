Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDE226AF3
	for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320453; cv=none; b=QMdTSF6Pji4vfjiW4OkAPP4KjYwvakSX/mCjV7vk0onqXdp47CesZx4PT1DFqLJflMsInLQe7IbmEjEuFyTVFp+TS4YaLKswegXQSPsetK1bfft76siwZakkM0qz/v71xSFgVCsE8+R+XRRV2HdJrFxneSaSkx5WNgqJRDbH0/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320453; c=relaxed/simple;
	bh=2gkDybpH395OIbIaKZa2a1mkllL/GXzJNOIUnEymSGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAdWadVSLWDDbdRlcF2UGh0Jrx1GsUk+u9BU9bPxfkpuYMO439MvZJYaSA0Puy/x+Q4DH1KtYwSO2IybPwFB5Q9aCvA5+JzMB8cMsoEasoNOlTZTPQ+QSnEKyaYsvUb+PMuN90LyoLSF3U8clTPyJJY9Mw5ivSrcJU275/d6KdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlWXAVu7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlWXAVu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F363FC4CEDD;
	Sun, 23 Feb 2025 14:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740320451;
	bh=2gkDybpH395OIbIaKZa2a1mkllL/GXzJNOIUnEymSGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MlWXAVu7CfoH4xIOLFAFE9+EOeguOKXckWU5Pr8eO83cloDflYvVH6jlZezAy9Nyx
	 E4IzkJsAU349xfM1M2gdWlZeT+GsMiXbUNqsj/yYab6yOmJx4D2pKsWaq/73Fa62bO
	 cF9aWYSWcyK3N3xv/BdAFIIJk3MU6U2grmxHgzGJ/4auYe9lu0Ztlilwi2E+D80fIU
	 o5OmohoSHDFX3V248Xb9Puz4d9YeEEn3t4vcdeNxeSFokugQrowgbxBo4fBHjGS7+l
	 nJSlpH/Ly9fRIuIQ75d65xVUKMZ3eg20dGn+Dt9HHyYq9YSGaoPMR6SpIUnvKA+js+
	 fHZInIgOGWOUg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 02/13] mptcp: sysctl: add path_manager to set pm name
Date: Sun, 23 Feb 2025 22:19:50 +0800
Message-ID: <fca6f4a287a4b129d4d1598727f77794df11d795.1740320007.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740320007.git.tanggeliang@kylinos.cn>
References: <cover.1740320007.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

A new net.mptcp.path_manager sysctl is added to determine which path
manager will be used by each newly-created MPTCP socket by setting the
name of it. This sysctl will replace the old one pm_type.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 Documentation/networking/mptcp-sysctl.rst | 17 ++++++++
 net/mptcp/ctrl.c                          | 50 +++++++++++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 3 files changed, 68 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 03e1d3610333..a3218e35a328 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -89,6 +89,23 @@ pm_type - INTEGER
 
 	Default: 0
 
+path_manager - STRING
+	Set the default path manager name to use for each new MPTCP
+	socket. In-kernel path management will control subflow
+	connections and address advertisements according to
+	per-namespace values configured over the MPTCP netlink
+	API. Userspace path management puts per-MPTCP-connection subflow
+	connection decisions and address advertisements under control of
+	a privileged userspace program, at the cost of more netlink
+	traffic to propagate all of the related events and commands.
+
+	This is a per-namespace sysctl.
+
+	* "in-kernel" - In-kernel path manager
+	* "userspace" - Userspace path manager
+
+	Default: "in-kernel"
+
 scheduler - STRING
 	Select the scheduler of your choice.
 
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 030dbe46cc8a..759ce4c30392 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -38,6 +38,7 @@ struct mptcp_pernet {
 	u8 checksum_enabled;
 	u8 allow_join_initial_addr_port;
 	u8 pm_type;
+	char path_manager[MPTCP_PM_NAME_MAX];
 	char scheduler[MPTCP_SCHED_NAME_MAX];
 };
 
@@ -83,6 +84,11 @@ int mptcp_get_pm_type(const struct net *net)
 	return mptcp_get_pernet(net)->pm_type;
 }
 
+const char *mptcp_get_path_manager(const struct net *net)
+{
+	return mptcp_get_pernet(net)->path_manager;
+}
+
 const char *mptcp_get_scheduler(const struct net *net)
 {
 	return mptcp_get_pernet(net)->scheduler;
@@ -100,10 +106,47 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	pernet->allow_join_initial_addr_port = 1;
 	pernet->stale_loss_cnt = 4;
 	pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
+	strscpy(pernet->path_manager, "in-kernel", sizeof(pernet->path_manager));
 	strscpy(pernet->scheduler, "default", sizeof(pernet->scheduler));
 }
 
 #ifdef CONFIG_SYSCTL
+static int mptcp_set_path_manager(char *path_manager, const char *name)
+{
+	struct mptcp_pm_ops *pm;
+	int ret = 0;
+
+	rcu_read_lock();
+	pm = mptcp_pm_find(name);
+	if (pm)
+		strscpy(path_manager, name, MPTCP_PM_NAME_MAX);
+	else
+		ret = -ENOENT;
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static int proc_path_manager(const struct ctl_table *ctl, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos)
+{
+	char (*path_manager)[MPTCP_PM_NAME_MAX] = ctl->data;
+	char val[MPTCP_PM_NAME_MAX];
+	const struct ctl_table tbl = {
+		.data = val,
+		.maxlen = MPTCP_PM_NAME_MAX,
+	};
+	int ret;
+
+	strscpy(val, *path_manager, MPTCP_PM_NAME_MAX);
+
+	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
+	if (write && ret == 0)
+		ret = mptcp_set_path_manager(*path_manager, val);
+
+	return ret;
+}
+
 static int mptcp_set_scheduler(char *scheduler, const char *name)
 {
 	struct mptcp_sched_ops *sched;
@@ -222,6 +265,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.extra1       = SYSCTL_ZERO,
 		.extra2       = &mptcp_pm_type_max
 	},
+	{
+		.procname = "path_manager",
+		.maxlen	= MPTCP_PM_NAME_MAX,
+		.mode = 0644,
+		.proc_handler = proc_path_manager,
+	},
 	{
 		.procname = "scheduler",
 		.maxlen	= MPTCP_SCHED_NAME_MAX,
@@ -274,6 +323,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[i++].data = &pernet->allow_join_initial_addr_port;
 	table[i++].data = &pernet->stale_loss_cnt;
 	table[i++].data = &pernet->pm_type;
+	table[i++].data = &pernet->path_manager;
 	table[i++].data = &pernet->scheduler;
 	i++; /* table[i] is for available_schedulers which is read-only info */
 	table[i++].data = &pernet->close_timeout;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3d72ca155322..ae4544663f06 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -694,6 +694,7 @@ int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
 unsigned int mptcp_close_timeout(const struct sock *sk);
 int mptcp_get_pm_type(const struct net *net);
+const char *mptcp_get_path_manager(const struct net *net);
 const char *mptcp_get_scheduler(const struct net *net);
 
 void mptcp_active_disable(struct sock *sk);
-- 
2.43.0

