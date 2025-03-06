Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8540F1FECB8
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258918; cv=none; b=txgP2BBQPqH3IddeSkDdnuiXC7Q5dPqwPqEClqBi90vh7jbNOPZuANyQ5+Nnftmo3vb4yRB9r77Jx23UPJTIy/fiYnqk43Kj3GzfpwEmP0zZ860X6ouMpsIDrSWCQtVHiNaY3cUs9DHKx+egdiH+dwXfk31qHTctkRIVyeii/ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258918; c=relaxed/simple;
	bh=bQZEKIurEns2cSfeBYOv2AQqUU0vruYP+h0ciwq6YsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsGCzDwZGkXIR4J1EVA7nNq85DuC/o9ww9RY1BsDs26j6rCdroXrvClO6M5jbdRC1cG4NDVNKQN/muwQSetEPJpX0DPgSamqGDNJUn8ztCr625bspSjupWG2Oh8bRTe6XnRhk9VIdk8ucZGTlraJPtU3i20TOJg9GTcLCwyvaYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4VzD/Yh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4VzD/Yh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17FCC4CEE2;
	Thu,  6 Mar 2025 11:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741258918;
	bh=bQZEKIurEns2cSfeBYOv2AQqUU0vruYP+h0ciwq6YsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q4VzD/Yhdh8G3dBzgZwrU5FQlcFJ+vJWsp75Oc+CirtDV9d6eRUR/hYJZ288NoLJg
	 /ISBD4m+a8cXmgUlSp6Wzirzc9ku+D4MlBXBautNImr8xlQBFJM1sPrmPtw10Nd42S
	 c+dttT4VWqemM774AZ8BTYbeDqcjLtFsHNqeq7Coh90/EJIWmXpBNvIKFgaUFd59cw
	 ZDo5dElkdwtEs6ta82VX4EfOZxNio1MXGqktpV1MGQkrdsgC8fkc+VJ7+kDcse6SxV
	 UzKVxgWjq1zcj7umK2PZEEJ5n1sjkSUI4oTkXkcadbFBsnhCVV/Hw4H2QF5BDpLjSy
	 XZDOO6UzSRk/A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 03/12] mptcp: sysctl: set path manager by name
Date: Thu,  6 Mar 2025 19:01:38 +0800
Message-ID: <3b6949a2eda46c8aed7164e7a66516772a6d512e.1741258415.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741258415.git.tanggeliang@kylinos.cn>
References: <cover.1741258415.git.tanggeliang@kylinos.cn>
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
name of it.

This sysctl makes the old one "pm_type" deprecated.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 Documentation/networking/mptcp-sysctl.rst | 19 +++++++++
 net/mptcp/ctrl.c                          | 50 +++++++++++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 3 files changed, 70 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 03e1d3610333..b78a2254d452 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -72,6 +72,23 @@ enabled - BOOLEAN
 
 	Default: 1 (enabled)
 
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
+	* "kernel"          - In-kernel path manager
+	* "userspace"       - Userspace path manager
+
+	Default: "kernel"
+
 pm_type - INTEGER
 	Set the default path manager type to use for each new MPTCP
 	socket. In-kernel path management will control subflow
@@ -84,6 +101,8 @@ pm_type - INTEGER
 
 	This is a per-namespace sysctl.
 
+	Deprecated since v6.15, use path_manager instead.
+
 	* 0 - In-kernel path manager
 	* 1 - Userspace path manager
 
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index be6c0237e10b..1f405be6bc00 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -39,6 +39,7 @@ struct mptcp_pernet {
 	u8 allow_join_initial_addr_port;
 	u8 pm_type;
 	char scheduler[MPTCP_SCHED_NAME_MAX];
+	char path_manager[MPTCP_PM_NAME_MAX];
 };
 
 static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
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
@@ -101,6 +107,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	pernet->stale_loss_cnt = 4;
 	pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
 	strscpy(pernet->scheduler, "default", sizeof(pernet->scheduler));
+	strscpy(pernet->path_manager, "kernel", sizeof(pernet->path_manager));
 }
 
 #ifdef CONFIG_SYSCTL
@@ -174,6 +181,42 @@ static int proc_blackhole_detect_timeout(const struct ctl_table *table,
 	return ret;
 }
 
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
+	char pm_name[MPTCP_PM_NAME_MAX];
+	const struct ctl_table tbl = {
+		.data = pm_name,
+		.maxlen = MPTCP_PM_NAME_MAX,
+	};
+	int ret;
+
+	strscpy(pm_name, *path_manager, MPTCP_PM_NAME_MAX);
+
+	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
+	if (write && ret == 0)
+		ret = mptcp_set_path_manager(*path_manager, pm_name);
+
+	return ret;
+}
+
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
@@ -253,6 +296,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0644,
 		.proc_handler = proc_dou8vec_minmax,
 	},
+	{
+		.procname = "path_manager",
+		.maxlen	= MPTCP_PM_NAME_MAX,
+		.mode = 0644,
+		.proc_handler = proc_path_manager,
+	},
 };
 
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
@@ -278,6 +327,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[8].data = &pernet->close_timeout;
 	table[9].data = &pernet->blackhole_timeout;
 	table[10].data = &pernet->syn_retrans_before_tcp_fallback;
+	table[11].data = &pernet->path_manager;
 
 	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
 				     ARRAY_SIZE(mptcp_sysctl_table));
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3f820a9e453f..0ef758d233b7 100644
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

