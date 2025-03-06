Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C8205E25
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258931; cv=none; b=bqry1bDYJ3WrTCm9+Ju7d9dtA5JqK8AqF69KPbSj/fwOGEiiKtAUR7ZGI69NIyeW4GVDE8gL8hWorNq7iA58dLj1DL2s1PZc3l5Suvl2oeJZGAMixmYaruHfJVEfNb65tGPDiMhgog2gw/1CiBFr/bttrCe7FcJT5+v8N6CM0gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258931; c=relaxed/simple;
	bh=nWbGRbCRgYZIRNZfjyRxCpdNerMpFC7txV2DoSSF/60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epIYBwQd6e+5wzfEuXmc2YoyGWTMMRf6EN0OdyNFl21QIND+HAInsIfxc2NmQ/qv4NHb+PeaPzlr/z1Z3jDqzKYA3C0oFv9JadohxGFmLGFCXW52T7jGJ3o/N0ViEUPjvXTNwUQ0oggFpfvcaLb2Wjvkve9LheJFJGhwQL/wSlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUG6rrbW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUG6rrbW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5282FC4CEE2;
	Thu,  6 Mar 2025 11:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741258931;
	bh=nWbGRbCRgYZIRNZfjyRxCpdNerMpFC7txV2DoSSF/60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZUG6rrbWP4IjjCbMk2Z5Wl8XLLccgKRerJc76x4ayeM2FjSRXYCH/zfFQA/wwW+d4
	 TmslfuFqI8SEtKb142mwByOy1SMpVGH0V+mOUfMUX4LPnQKY+p0KNzWeJ0PxHt38A5
	 hf1Hk15LB/AmwwlYHTit2bmpsimsLCqvREM+EKgyEf28M/xnWjt5vLk0plBQ7iq3FO
	 Uw3CSLs24TpREZ4ZGHDDwrXCRLSpaGe63vBfMfQlapL4guFKSUdCtjexxZc1+YlUTm
	 duPSayZIFw51LDYJBNFl4ycbn/E7rAiwjEBHkiCbviGQzOZCthNiK3JFxUDDHXYNNW
	 cun7BX9Gt/Xrg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 11/12] mptcp: sysctl: add available_path_managers
Date: Thu,  6 Mar 2025 19:01:46 +0800
Message-ID: <269ed2f20a9f017e9a32ace3728dde2f63774936.1741258415.git.tanggeliang@kylinos.cn>
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
index b344b909e749..6a08ac862bbe 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -114,6 +114,8 @@ struct mptcp_sched_ops {
 } ____cacheline_aligned_in_smp;
 
 #define MPTCP_PM_NAME_MAX	16
+#define MPTCP_PM_MAX		128
+#define MPTCP_PM_BUF_MAX	(MPTCP_PM_NAME_MAX * MPTCP_PM_MAX)
 
 struct mptcp_pm_ops {
 	int (*get_local_id)(struct mptcp_sock *msk,
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 357083977ba5..14c32d06f51e 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -251,6 +251,24 @@ static int proc_pm_type(const struct ctl_table *ctl, int write,
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
@@ -336,6 +354,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
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
@@ -362,6 +386,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[9].data = &pernet->blackhole_timeout;
 	table[10].data = &pernet->syn_retrans_before_tcp_fallback;
 	table[11].data = &pernet->path_manager;
+	/* table[12] is for available_path_managers which is read-only info */
 
 	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
 				     ARRAY_SIZE(mptcp_sysctl_table));
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5d666b0891b3..ef76939435bf 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1085,3 +1085,22 @@ void mptcp_pm_unregister(struct mptcp_pm_ops *pm_ops)
 	list_del_rcu(&pm_ops->list);
 	spin_unlock(&mptcp_pm_list_lock);
 }
+
+/* Build string with list of available path manager values.
+ * Similar to tcp_get_available_congestion_control()
+ */
+void mptcp_pm_get_available(char *buf, size_t maxlen)
+{
+	struct mptcp_pm_ops *pm_ops;
+	size_t offs = 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(pm_ops, &mptcp_pm_list, list) {
+		offs += snprintf(buf + offs, maxlen - offs, "%s%s",
+				 offs == 0 ? "" : " ", pm_ops->name);
+
+		if (WARN_ON_ONCE(offs >= maxlen))
+			break;
+	}
+	rcu_read_unlock();
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1ce6c22cb295..5a64ed3049d1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1060,6 +1060,7 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name);
 int mptcp_pm_register(struct mptcp_pm_ops *pm_ops);
 void mptcp_pm_unregister(struct mptcp_pm_ops *pm_ops);
 int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops);
+void mptcp_pm_get_available(char *buf, size_t maxlen);
 
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
-- 
2.43.0

