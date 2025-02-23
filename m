Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843CE163
	for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320837; cv=none; b=jWt45MXtWQcHqtFOeXc/iMHT0MUpffwwqO/uIzaFeh7t3Y1u2OyH53BdhpBq2N4bNHtPHzGvW39JIJ5uJlgPwZMf0Kdryw60sOJMaGbyB8wVUrekBK2IxPmW15ms2S0gsFcOo4vvhJXPUVxSte+UA1MEUg019yDg1DcPOVnUpAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320837; c=relaxed/simple;
	bh=jNsIlt+t75DHMSdUG6Q/zqYgq9/oGhPX2TmB5pgjyUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIQyzwWgPB9RJzr/2IuNC5bf9qmPRif2Ifc+C53foWUBmOB+OixfGsvHbWY8398KP+azmg1tTYhevej91Lpbk+w8adhRPi+45W+QK79UTuJTTFK84cYZk+mSnvKyaFZeOxKpR4cTyQcPNLN2LKin+t7am3LZcTIMbX1XZNFVNC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROuABeAt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROuABeAt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC59C4CEDD;
	Sun, 23 Feb 2025 14:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740320837;
	bh=jNsIlt+t75DHMSdUG6Q/zqYgq9/oGhPX2TmB5pgjyUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ROuABeAteqCjyeb77O/UOAqeT+muBXcTHOCygaW5qZkD6UDP3PrPo/ZaYht7VQxiw
	 w6YumY8whH23TLKeZCboAFF6aPw8KuCwtrj9HUC9i5jAebBoJDwEVhDu8ba2qv17kq
	 efzXGoTMAJ+rtB49F+87Iqqrzno4dR/Ei8IMwo8+d+3v8DU2LPAJddJIlRxJjif6DE
	 KkbhaHtzXtvAun6GfcUyr56ijqwHpDt3OX4ccEQ9SAjdQ9axA86Zel7G9jLpp714Ry
	 uixv0d0NfPfxS9tUI5lpRBGq1DWH/tKCyLzBrUWF8mKKL0LQxp0trYnKJuJRIBxDK+
	 Eh7nTw49NuCNQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 10/13] mptcp: sysctl: add available_path_managers
Date: Sun, 23 Feb 2025 22:26:15 +0800
Message-ID: <6d1a4f40c9116c66d96486c8e56adb37cc659d5f.1740320007.git.tanggeliang@kylinos.cn>
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

Similarly to net.mptcp.available_schedulers, this patch adds a new one
net.mptcp.available_path_managers to list the available path mangers.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 Documentation/networking/mptcp-sysctl.rst |  4 ++++
 include/net/mptcp.h                       |  2 ++
 net/mptcp/ctrl.c                          | 25 +++++++++++++++++++++++
 net/mptcp/pm.c                            | 20 ++++++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 5 files changed, 52 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 454ce87bc1c5..ee0b553b51a1 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -89,6 +89,10 @@ path_manager - STRING
 
 	Default: "in-kernel"
 
+available_path_managers - STRING
+	Shows the available path managers choices that are registered. More
+        path managers may be available, but not loaded.
+
 scheduler - STRING
 	Select the scheduler of your choice.
 
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 689926d1f39f..bcddaf0a588a 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -123,6 +123,8 @@ struct mptcp_sched_ops {
 } ____cacheline_aligned_in_smp;
 
 #define MPTCP_PM_NAME_MAX	16
+#define MPTCP_PM_MAX		128
+#define MPTCP_PM_BUF_MAX	(MPTCP_PM_NAME_MAX * MPTCP_PM_MAX)
 
 struct mptcp_pm_ops {
 	int (*created)(struct mptcp_sock *msk);
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index b8eaf1f58ab2..b61778c51706 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -136,6 +136,24 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
 	return ret;
 }
 
+static int proc_available_path_managers(const struct ctl_table *ctl,
+					int write, void *buffer,
+					size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table tbl = { .maxlen = MPTCP_PM_BUF_MAX, };
+	int ret;
+
+	tbl.data = kmalloc(tbl.maxlen, GFP_USER);
+	if (!tbl.data)
+		return -ENOMEM;
+
+	mptcp_pm_get_available(tbl.data, MPTCP_PM_BUF_MAX);
+	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
+	kfree(tbl.data);
+
+	return ret;
+}
+
 static int mptcp_set_scheduler(char *scheduler, const char *name)
 {
 	struct mptcp_sched_ops *sched;
@@ -252,6 +270,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0644,
 		.proc_handler = proc_path_manager,
 	},
+	{
+		.procname = "available_path_managers",
+		.maxlen	= MPTCP_PM_BUF_MAX,
+		.mode = 0444,
+		.proc_handler = proc_available_path_managers,
+	},
 	{
 		.procname = "scheduler",
 		.maxlen	= MPTCP_SCHED_NAME_MAX,
@@ -304,6 +328,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[i++].data = &pernet->allow_join_initial_addr_port;
 	table[i++].data = &pernet->stale_loss_cnt;
 	table[i++].data = &pernet->path_manager;
+	i++; /* table[i] is for available_path_managers which is read-only info */
 	table[i++].data = &pernet->scheduler;
 	i++; /* table[i] is for available_schedulers which is read-only info */
 	table[i++].data = &pernet->close_timeout;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9f9e9cf18847..103b6b205dca 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -673,6 +673,26 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
 	return NULL;
 }
 
+/* Build string with list of available path manager values.
+ * Similar to tcp_get_available_congestion_control()
+ */
+void mptcp_pm_get_available(char *buf, size_t maxlen)
+{
+	struct mptcp_pm_ops *pm;
+	size_t offs = 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(pm, &mptcp_pm_list, list) {
+		offs += snprintf(buf + offs, maxlen - offs,
+				 "%s%s",
+				 offs == 0 ? "" : " ", pm->name);
+
+		if (WARN_ON_ONCE(offs >= maxlen))
+			break;
+	}
+	rcu_read_unlock();
+}
+
 int mptcp_pm_validate(struct mptcp_pm_ops *pm)
 {
 	if (!pm->get_local_id || !pm->get_priority) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e5917b9ecd74..809611125c5e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1050,6 +1050,7 @@ void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 extern struct mptcp_pm_ops mptcp_in_kernel_pm;
 
 struct mptcp_pm_ops *mptcp_pm_find(const char *name);
+void mptcp_pm_get_available(char *buf, size_t maxlen);
 int mptcp_pm_validate(struct mptcp_pm_ops *pm);
 int mptcp_pm_register(struct mptcp_pm_ops *pm);
 void mptcp_pm_unregister(struct mptcp_pm_ops *pm);
-- 
2.43.0

