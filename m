Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89E213C9D4
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 04:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740975926; cv=none; b=mfVDe9gXv0zFRokZGI9xeWutshoqqUgGSeTWlv8BUPjdtFH26/MHPN3MdsrC5RBNqvqsYPxSa19ryiwL03pBh0sbnPy7v/KNn87KOyZmyFW/8PnTGeaEZ81Nm8N9vF8CjbYRyhj9haUPeZ9Eox5jdw8j1XlUhFKted3VrQDvBws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740975926; c=relaxed/simple;
	bh=j9cYNszI/mOSmcX1hpmr9uTGjdq4QkHSLGaE8XUcbas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGZEHpC/zM62ej0e/DvJ3clxL6XQcWmSxtAZJ9EuaQMFc84lZwthprjTWF7+u6BXnEtQWlenzXvSG96amnaVgFWBtUsMiA+5NmVgU91gOYwTdHV2h9ziEIfbcjekbwEJR3oJRJ899NFLBstZ+OYgpA++1RXVOhapNBmfEPagiuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmW+mAK+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmW+mAK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08424C4CED6;
	Mon,  3 Mar 2025 04:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740975926;
	bh=j9cYNszI/mOSmcX1hpmr9uTGjdq4QkHSLGaE8XUcbas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cmW+mAK+XO/EcTFKCTNy/gBWnRwG+lGYQGapxVOTuhfpUWfT55JZD0Bd3hgb5qGjL
	 y0OabNzgUq3NHD7eJRsomPX8SZtK9IaIl2B74COJDlFr22rl7nb6p3G/B8RxdkT1R6
	 QHo5iYyLIij+cKIOmhSIeYElc/M2d9/3nDdbfQoUlYt+i3akxE/MawJfTUTkk9YcxE
	 cce6G757FSabkVzO0kjZEkJkGBN4ucSsIlmNDrlukToITlj6Ga2625o9aEOdTvsMaA
	 SiiOYgjJzkITa03MWi+jnYj21wm9eur15i71Ew4Trg6yShIuAeeLB4eceeHfnbfAXe
	 oeWzHy2o7bPfA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 04/11] mptcp: sysctl: add available_path_managers
Date: Mon,  3 Mar 2025 12:22:52 +0800
Message-ID: <4af75cf9a0ebfef70ca6151d05624b8d5abc723b.1740975633.git.tanggeliang@kylinos.cn>
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

Similarly to net.mptcp.available_schedulers, this patch adds a new one
net.mptcp.available_path_managers to list the available path mangers.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 Documentation/networking/mptcp-sysctl.rst |  4 ++++
 include/net/mptcp.h                       |  2 ++
 net/mptcp/ctrl.c                          | 25 +++++++++++++++++++++++
 net/mptcp/pm.c                            | 19 +++++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 5 files changed, 51 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 5f6c02c12f5b..1f2397c11f65 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -30,6 +30,10 @@ allow_join_initial_addr_port - BOOLEAN
 
 	Default: 1
 
+available_path_managers - STRING
+	Shows the available path managers choices that are registered. More
+	path managers may be available, but not loaded.
+
 available_schedulers - STRING
 	Shows the available schedulers choices that are registered. More packet
 	schedulers may be available, but not loaded.
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 53e67b90c37a..83977fe3dd30 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -123,6 +123,8 @@ struct mptcp_sched_ops {
 } ____cacheline_aligned_in_smp;
 
 #define MPTCP_PM_NAME_MAX	16
+#define MPTCP_PM_MAX		128
+#define MPTCP_PM_BUF_MAX	(MPTCP_PM_NAME_MAX * MPTCP_PM_MAX)
 
 struct mptcp_pm_ops {
 	int (*get_local_id)(struct mptcp_sock *msk,
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 32f13ab7db0a..643472eb11b2 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -246,6 +246,24 @@ static int proc_pm_type(const struct ctl_table *ctl, int write,
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
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
@@ -329,6 +347,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0644,
 		.proc_handler = proc_path_manager,
 	},
+	{
+		.procname = "available_path_managers",
+		.maxlen	= MPTCP_PM_BUF_MAX,
+		.mode = 0444,
+		.proc_handler = proc_available_path_managers,
+	},
 };
 
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
@@ -355,6 +379,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[9].data = &pernet->blackhole_timeout;
 	table[10].data = &pernet->syn_retrans_before_tcp_fallback;
 	table[11].data = &pernet->path_manager;
+	/* table[12] is for available_path_managers which is read-only info */
 
 	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
 				     ARRAY_SIZE(mptcp_sysctl_table));
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 53a29adf7cae..88ff136b3786 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1079,3 +1079,22 @@ void mptcp_pm_unregister(struct mptcp_pm_ops *pm)
 	list_del_rcu(&pm->list);
 	spin_unlock(&mptcp_pm_list_lock);
 }
+
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
+		offs += snprintf(buf + offs, maxlen - offs, "%s%s",
+				 offs == 0 ? "" : " ", pm->name);
+
+		if (WARN_ON_ONCE(offs >= maxlen))
+			break;
+	}
+	rcu_read_unlock();
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 737f148770e3..9dbfde4027b3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1055,6 +1055,7 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name);
 int mptcp_pm_validate(struct mptcp_pm_ops *pm);
 int mptcp_pm_register(struct mptcp_pm_ops *pm);
 void mptcp_pm_unregister(struct mptcp_pm_ops *pm);
+void mptcp_pm_get_available(char *buf, size_t maxlen);
 
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
-- 
2.43.0

