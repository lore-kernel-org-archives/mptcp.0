Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BFC1FCD00
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088455; cv=none; b=CiP0Nh2jf+t1fUhPbyM57CNA9dsxYIDWOyPaDv7ZoKgXNvVTL9X32t6TlJlVr8mBqs8V3tMTDCHIrdkrvQSvaz680ex1J1cQmthHzi8iqoSX8fnn0h5h0ywVVDIbdalOeSzoJDMwEz5u0CWQ13woC+WFImSrSOYRrc/zDl5QooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088455; c=relaxed/simple;
	bh=CNlCjvO+evCdk99ycH+QFZSd7wq0KDVvs5Fg4V12WwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sdl8thvPGm89TDkmI/djwuyY1xPsMs9VHp2QJcFGg289YoKDvs3Q4rHto8qvlbPQouz0Gxt4rimMDgVy9IpnM+Wq5xQhmP6cNBlJP09S+tVQ25boyNZvPdxjRC3olO8FhlGF+L5RMUE2FkqTER0EdrPZbK4WSzNPtkqQ29VygPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdaAK1n4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdaAK1n4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D035AC4CEEA;
	Tue,  4 Mar 2025 11:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741088454;
	bh=CNlCjvO+evCdk99ycH+QFZSd7wq0KDVvs5Fg4V12WwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kdaAK1n4xIEQx5VlLhlpmZiA6OghGVlrrHJ+DwFtyZQw7VL9K5CPM8BKaUcc/4HXL
	 ZJ62LBI6pCqVGp0mRK2m4Ek5JnlpoOMqOG7IWFEW2WIlXJMVv+otuiJgk7fUDUj8j+
	 9Q9c5lTtLJJHzwSFM0pP2aFfeJnm1fpphAGYCELC/s3TW52i2rSeRvazGWmDzIvKn6
	 KntIFUha5+z6LRB5Pf9+wbfZB8OwxL09PwmxNRHiZs+luKs6XjRQ7W+AuJHJfDIljx
	 TRJiU0F62OETRtYZtas/qZNOvm7TgP4jZ9PlIOG8nAyl6l1Ox9Cza6QhHcln6rgqeL
	 xS5lSXyEDqQnQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 05/12] mptcp: sysctl: add available_path_managers
Date: Tue,  4 Mar 2025 19:40:32 +0800
Message-ID: <7dcac63624dd38bc9e506e6f8ca909e6c4fcd541.1741088339.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741088339.git.tanggeliang@kylinos.cn>
References: <cover.1741088339.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Similarly to net.mptcp.available_schedulers, this patch adds a new one
net.mptcp.available_path_managers to list the available path managers.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 Documentation/networking/mptcp-sysctl.rst |  4 ++++
 include/net/mptcp.h                       |  2 ++
 net/mptcp/ctrl.c                          | 25 +++++++++++++++++++++++
 net/mptcp/pm.c                            | 19 +++++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 5 files changed, 51 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index b78a2254d452..5bfab01eff5a 100644
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
index aeb3b1e4d8f2..c53ffff0a4cd 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -123,6 +123,8 @@ struct mptcp_sched_ops {
 } ____cacheline_aligned_in_smp;
 
 #define MPTCP_PM_NAME_MAX	16
+#define MPTCP_PM_MAX		128
+#define MPTCP_PM_BUF_MAX	(MPTCP_PM_NAME_MAX * MPTCP_PM_MAX)
 
 struct mptcp_pm_ops {
 	char			name[MPTCP_PM_NAME_MAX];
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index a158a337cdb5..c11edcb683d0 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -252,6 +252,24 @@ static int proc_pm_type(const struct ctl_table *ctl, int write,
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
@@ -337,6 +355,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
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
@@ -363,6 +387,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[9].data = &pernet->blackhole_timeout;
 	table[10].data = &pernet->syn_retrans_before_tcp_fallback;
 	table[11].data = &pernet->path_manager;
+	/* table[12] is for available_path_managers which is read-only info */
 
 	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
 				     ARRAY_SIZE(mptcp_sysctl_table));
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 1af42c6a24c6..a2b210873b23 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1080,3 +1080,22 @@ void mptcp_pm_unregister(struct mptcp_pm_ops *pm)
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
index ff14d43bf8a9..246b44db9775 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1054,6 +1054,7 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name);
 int mptcp_pm_validate(struct mptcp_pm_ops *pm);
 int mptcp_pm_register(struct mptcp_pm_ops *pm);
 void mptcp_pm_unregister(struct mptcp_pm_ops *pm);
+void mptcp_pm_get_available(char *buf, size_t maxlen);
 
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
-- 
2.43.0

