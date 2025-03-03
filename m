Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D76C13C9D4
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 04:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740975923; cv=none; b=gnhFobkf0IWNUsH++9Hohl7R/u9clE6FIOajJpXImTp0qZ29durtTM+c1FJxx4iLklfGGt72dMmfTOFXsjCNI3BcKCDCJNhJxhxLa/ievlc7HvTVH46K55//HziDY/BJ1CdCBfTFhWwt0iul2C9+bqCEq/vaAOcGQpwWPttgWPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740975923; c=relaxed/simple;
	bh=XwJNhvKtEzvKoJc1RspRrMTtmkp+ceaB+8LAEwhGjNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzou/mdzMss3C3RD4snOIVJFdDl8g3xNrRX4RHBFGXESpk1ElpTbjFOGLNWPb9KvFApBDLM0xoQM4YsPlP9SD9d7SCytpMRoT0nYeluGf0XUyg+mpYPcBsXX6r9ltYCJ5/5t2FR2CS+510zUO9Mu9e/pJbkHp0z1F2ZproM5UcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+W4Ckl3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+W4Ckl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A029BC4CED6;
	Mon,  3 Mar 2025 04:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740975922;
	bh=XwJNhvKtEzvKoJc1RspRrMTtmkp+ceaB+8LAEwhGjNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J+W4Ckl3PS8TIxMMo/kspKpYjx67W/ikMMUm577nKzuXXgc2S33KIkFb9SasUw76j
	 yazLN5DdV6Ro8Ez7P1Mrrdc69WL+iZ098kn4lDQK847QtnW9nIVuG9FaWf4Xshqt3C
	 CK9WuwbKn/MdjqJJutICBrk7hBv6jKm8sCwxAqIhhw30Oa4qK/2WJyOqu0zKh+1FW3
	 p8jBHVSYnyQNr4HokhhzvTeOvQn+Yas5O1bmuCzffHYYm/p5lg1nCwj3ZLcAvGUcze
	 60hwDEcR8yEZSFg76LJKrdCh+mwHGdRJHgDucwAYpopXqZkH0Vj48gtL3bRLCOJLe9
	 oqH+GgdL0zUbQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 02/11] mptcp: sysctl: new sysctl to set path manager by name
Date: Mon,  3 Mar 2025 12:22:50 +0800
Message-ID: <6a04af1ad584b4e067b61ca4c7717f7d72c03202.1740975633.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740975633.git.tanggeliang@kylinos.cn>
References: <cover.1740975633.git.tanggeliang@kylinos.cn>
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
 Documentation/networking/mptcp-sysctl.rst | 22 ++++++++++
 net/mptcp/ctrl.c                          | 50 +++++++++++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 3 files changed, 73 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 03e1d3610333..5f6c02c12f5b 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -72,6 +72,26 @@ enabled - BOOLEAN
 
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
+	User-defined BPF-based path managers can also be set via this
+	sysctl.
+
+	This is a per-namespace sysctl.
+
+	* "kernel"          - In-kernel path manager
+	* "userspace"       - Userspace path manager
+	* all other strings - BPF-based path managers
+
+	Default: "kernel"
+
 pm_type - INTEGER
 	Set the default path manager type to use for each new MPTCP
 	socket. In-kernel path management will control subflow
@@ -84,6 +104,8 @@ pm_type - INTEGER
 
 	This is a per-namespace sysctl.
 
+	(Deprecated, use path_manager instead.).
+
 	* 0 - In-kernel path manager
 	* 1 - Userspace path manager
 
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index be6c0237e10b..d64e6b4f6d1d 100644
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
index 090592c108d6..737f148770e3 100644
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

