Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFBA1D86ED
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020270; cv=none; b=jlj1/tB7ULTyXNFKzIU7jaKFR7cFaRVQgcIHUWR9pwGNNECkDFZ+Hh7jvPrx1ndTBIGP4iT1nOHjpXTfw31Q+GtoHZMd8D2/TG1bklIHTyAAx0MFu4qwjJtAMnOdLGqFRWgD84A7zKT4A2gR6ihnfT5s8rC7sNGWnykynBrO86M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020270; c=relaxed/simple;
	bh=WN2Pr1MPt7o+UW5Fyfq3vcMYMrHc10UABxqTthJbWdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuzuFfY6jOf22vKAz/0n4gVi7+Sx/yi3SPWvlwuW96+GZXhZTfZh0GpABoPtgpZFEg422NFjX503QvGuYJekNrXEMocdCVBCKZqoB82iIopDMHmeId9MZs+hYEX2qL5sGtheAvLaE86xIPUJci+nlgkEQVBRIyTXllapKYKB/So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDT73H2C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDT73H2C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63903C4CED6;
	Thu, 20 Feb 2025 02:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740020270;
	bh=WN2Pr1MPt7o+UW5Fyfq3vcMYMrHc10UABxqTthJbWdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aDT73H2Coo6l2O331+u/Z/soo2Bd01Pw2OPfM1h2q5VULjwssU+DnZWdODgIehXgF
	 dLrzSYEI7ajjv/p0tHhOJtrAupH1/RlC/YKjHQDkkqfRlk/otsIbluPIUqx6y+u28b
	 tRo0skOXji7giFpHDdmuFfym+YdEKiKBuKjG6Lo/5GtLev5zUBWTeRPOGF8q5RhAvF
	 qytITU46/d9y175Vt5mZEnuDybRBG8HWe7AM3caCjnbp7yqCuMi0pUMstORrHmjln6
	 9+4dn/DkfD/R1zo34h3AGvsnvaR7xtFBBnOAnfg3l28n7sH8HjHUy+mFRMtozuD00o
	 Fo5mXCIEIMplA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 6/9] mptcp: pm: userspace: register mptcp_userspace_pm
Date: Thu, 20 Feb 2025 10:57:30 +0800
Message-ID: <79352d1b04b46dc9f5541d466822a518edfb63fd.1740019794.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740019794.git.tanggeliang@kylinos.cn>
References: <cover.1740019794.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch defines the original userspace path manager as a new struct
mptcp_pm_ops named "mptcp_userspace_pm", and register it in
mptcp_pm_data_init().

Only get_local_id() and get_priority() interfaces are implemented here.
mptcp_userspace_pm_is_backup() becomes a wrapper of get_priority().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           |  1 +
 net/mptcp/pm_userspace.c | 26 ++++++++++++++++++++++++--
 net/mptcp/protocol.h     |  1 +
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f56b2d1e3409..91e377058243 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -665,6 +665,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 void __init mptcp_pm_init(void)
 {
 	mptcp_pm_nl_init();
+	mptcp_userspace_pm_init();
 }
 
 /* Must be called with rcu read lock held */
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index bd235b2d18b3..6e51335c8bc1 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -150,9 +150,10 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_append_new_local_addr(msk, skc, true);
 }
 
-bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
-				  struct mptcp_addr_info *skc)
+static bool mptcp_userspace_pm_get_priority(struct mptcp_sock *msk,
+					    struct mptcp_pm_param *param)
 {
+	struct mptcp_addr_info *skc = &param->addr;
 	struct mptcp_pm_addr_entry *entry;
 	bool backup;
 
@@ -164,6 +165,15 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
 	return backup;
 }
 
+bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
+				  struct mptcp_addr_info *skc)
+{
+	struct mptcp_pm_param param;
+
+	mptcp_pm_param_set_contexts(&param, NULL, skc);
+	return mptcp_userspace_pm_get_priority(msk, &param);
+}
+
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
 {
 	struct mptcp_sock *msk;
@@ -687,3 +697,15 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	sock_put(sk);
 	return ret;
 }
+
+static struct mptcp_pm_ops mptcp_userspace_pm = {
+	.get_local_id		= mptcp_userspace_pm_get_local_id,
+	.get_priority		= mptcp_userspace_pm_get_priority,
+	.type			= MPTCP_PM_TYPE_USERSPACE,
+	.owner			= THIS_MODULE,
+};
+
+void __init mptcp_userspace_pm_init(void)
+{
+	mptcp_pm_register(&mptcp_userspace_pm);
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f3e04927e214..021c0f87da1b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1152,6 +1152,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 }
 
 void __init mptcp_pm_nl_init(void);
+void __init mptcp_userspace_pm_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
-- 
2.43.0

