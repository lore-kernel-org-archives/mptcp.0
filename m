Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B557200B85
	for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320837; cv=none; b=XiL0rrU6wcfXejLNfv38icDH4R+Hx4kOZF4f0AshmaXiWJj8NxBb4pnQIjZd7xJxUN/4xQ0fZW7JfLSNSNSDU2+/zjt28f//K7pJ3vfztS0Wj1HgSMgx7hRRlvvu+JBRUXE29kBPNtCyxq53J+k7nRJSDKQnxQzr+qzjEXRikgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320837; c=relaxed/simple;
	bh=lHpC8OchawP77y2I/KZAzGjHOLlMNTkgnRXnxd5oSTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UweNZ3P9DAafUJjgKVyWM6jRVoSsGGelayaJS4zX1fCeP3MnijvKXn9frcmXADCjP+McLqPfnJ1Bd8pXgHQDbjpBeJiUITDNAiTFsSgNE/qmWSaRpJ2U6fRIqbdNUqxibcOFItdYT2VDwVMUybS3/70JxCZsPd0D1mzANLKUIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+f4qEbD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+f4qEbD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4262BC4CEE7;
	Sun, 23 Feb 2025 14:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740320836;
	bh=lHpC8OchawP77y2I/KZAzGjHOLlMNTkgnRXnxd5oSTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+f4qEbDnR9WHP3f50TOPdI1P2TyAd8f9mXB6/Jqn0Rgyg9NgqjlOsBwa81YVee/O
	 Xb5QPUsBl136M2OZmujBHPwWe7y0HjfGl4Zjyqg9TXvYvdVlIveMya8v9AsJlmpbJp
	 XESP0eI6s/FELUZxHMg1slTW/P1nAMIIIgPgdIqcc3qHuz0o0crJhFYbU5n0ergGtO
	 Zm9yVeNi8ce7Gk0YjQCzvkXqpsY2w6IRv7NPwjCLxty3H2g+hbobX0SdO8MMcTKofF
	 dkgoOw6CdYLqavI0scitZpMGQxtXX/YJhldNP//eDl9+GQ4m8i2UZZPQK2jD4798I6
	 rWbV00eJJVN7A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 09/13] mptcp: sysctl: drop old pm_type sysctl
Date: Sun, 23 Feb 2025 22:26:14 +0800
Message-ID: <af9b1582f77de77b09b8d688d641353023a26832.1740320007.git.tanggeliang@kylinos.cn>
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

Old path manager sysctl "pm_type" can be replaced by the newly added
"path_manager". Drop it together with mptcp_get_pm_type() helper.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 Documentation/networking/mptcp-sysctl.rst | 17 -----------------
 net/mptcp/ctrl.c                          | 20 --------------------
 net/mptcp/protocol.h                      |  1 -
 3 files changed, 38 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index a3218e35a328..454ce87bc1c5 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -72,23 +72,6 @@ enabled - BOOLEAN
 
 	Default: 1 (enabled)
 
-pm_type - INTEGER
-	Set the default path manager type to use for each new MPTCP
-	socket. In-kernel path management will control subflow
-	connections and address advertisements according to
-	per-namespace values configured over the MPTCP netlink
-	API. Userspace path management puts per-MPTCP-connection subflow
-	connection decisions and address advertisements under control of
-	a privileged userspace program, at the cost of more netlink
-	traffic to propagate all of the related events and commands.
-
-	This is a per-namespace sysctl.
-
-	* 0 - In-kernel path manager
-	* 1 - Userspace path manager
-
-	Default: 0
-
 path_manager - STRING
 	Set the default path manager name to use for each new MPTCP
 	socket. In-kernel path management will control subflow
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 759ce4c30392..b8eaf1f58ab2 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -18,10 +18,6 @@
 
 static int mptcp_pernet_id;
 
-#ifdef CONFIG_SYSCTL
-static int mptcp_pm_type_max = __MPTCP_PM_TYPE_MAX;
-#endif
-
 struct mptcp_pernet {
 #ifdef CONFIG_SYSCTL
 	struct ctl_table_header *ctl_table_hdr;
@@ -37,7 +33,6 @@ struct mptcp_pernet {
 	u8 mptcp_enabled;
 	u8 checksum_enabled;
 	u8 allow_join_initial_addr_port;
-	u8 pm_type;
 	char path_manager[MPTCP_PM_NAME_MAX];
 	char scheduler[MPTCP_SCHED_NAME_MAX];
 };
@@ -79,11 +74,6 @@ unsigned int mptcp_close_timeout(const struct sock *sk)
 	return mptcp_get_pernet(sock_net(sk))->close_timeout;
 }
 
-int mptcp_get_pm_type(const struct net *net)
-{
-	return mptcp_get_pernet(net)->pm_type;
-}
-
 const char *mptcp_get_path_manager(const struct net *net)
 {
 	return mptcp_get_pernet(net)->path_manager;
@@ -105,7 +95,6 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	pernet->checksum_enabled = 0;
 	pernet->allow_join_initial_addr_port = 1;
 	pernet->stale_loss_cnt = 4;
-	pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
 	strscpy(pernet->path_manager, "in-kernel", sizeof(pernet->path_manager));
 	strscpy(pernet->scheduler, "default", sizeof(pernet->scheduler));
 }
@@ -257,14 +246,6 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0644,
 		.proc_handler = proc_douintvec_minmax,
 	},
-	{
-		.procname = "pm_type",
-		.maxlen = sizeof(u8),
-		.mode = 0644,
-		.proc_handler = proc_dou8vec_minmax,
-		.extra1       = SYSCTL_ZERO,
-		.extra2       = &mptcp_pm_type_max
-	},
 	{
 		.procname = "path_manager",
 		.maxlen	= MPTCP_PM_NAME_MAX,
@@ -322,7 +303,6 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[i++].data = &pernet->checksum_enabled;
 	table[i++].data = &pernet->allow_join_initial_addr_port;
 	table[i++].data = &pernet->stale_loss_cnt;
-	table[i++].data = &pernet->pm_type;
 	table[i++].data = &pernet->path_manager;
 	table[i++].data = &pernet->scheduler;
 	i++; /* table[i] is for available_schedulers which is read-only info */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a5b0fbb3a272..e5917b9ecd74 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -693,7 +693,6 @@ int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
 unsigned int mptcp_close_timeout(const struct sock *sk);
-int mptcp_get_pm_type(const struct net *net);
 const char *mptcp_get_path_manager(const struct net *net);
 const char *mptcp_get_scheduler(const struct net *net);
 
-- 
2.43.0

