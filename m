Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E951C1ADB
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521545; cv=none; b=JxzoCk7jipKuTGEvmPnAE90xglxK1v3XVXBE0NBMt0fUIsHs2HabX4EqEZhaUf9n8o5XU0GF8rBEjBB+FxG+flM481cO5OJNR2tq+DFP/3OZs0lYdDLMXqindkw9ExcMf6xrMGERNJbO9EmGfI5+mg6KAH3URJqUJW1oi5uY9ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521545; c=relaxed/simple;
	bh=NUNvE9uuJa+p/x7Z3o/sW1CiTbhp8dp/ZVyOjt+mWOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4HGlDX89gu5q4s5XAuslM17RXw1qJ53b7l4291lzfA+ZA5FLBlSIg9n/SXyjofPOULWAyKo0wRsoS7fMcRmIMEUTBVy43sQVV++hhL0hmZTBjxmpk0odMBaSEA9hJFojGRG5KFzEU8AyBI7VR8JCIzGg70XUkyk/uptr+FAPwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cG32Jyfr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cG32Jyfr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB948C4CEEA;
	Fri, 21 Mar 2025 01:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742521543;
	bh=NUNvE9uuJa+p/x7Z3o/sW1CiTbhp8dp/ZVyOjt+mWOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cG32JyfrxNBXEFbLRvmmbObDJiKPX9A8fIdZ/vuGZsqMM5VAezg8atqIt9KqrONL6
	 0b/wdzbhiJmpUs2MRrINwhq8HP/5AA3sunl4vZ2NeZkYve+BdkgUSAsnlGHcuKXMaw
	 O6GjIJZFRkd+XfMk5DYffYJFvbDB4cE9etgwjEONwocerF2xJP6WevYDSxHlgMEEsV
	 nn63og049uKc7yyQ2N2EtmtdbACDBc8DKA4mFwgfR1oHBNSLyWR0SySrjY7elDm5CQ
	 KVfNJoEfEemeRzbzKD89kllfNy2KN/AXLWGzrF2r4rwG1c/BsgUxtRujw78YOIWkQU
	 VmY3JOkeBjk3g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 03/10] mptcp: pm: add established() interface
Date: Fri, 21 Mar 2025 09:44:57 +0800
Message-ID: <3f7cfd8a8e45e26e9afacf66f0adc61b9cd9356c.1742521397.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742521397.git.tanggeliang@kylinos.cn>
References: <cover.1742521397.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a .established interface for struct mptcp_pm_ops, and
calls pm->ops->established in from mptcp_pm_worker(). Then get rid of
the corresponding code from __mptcp_pm_kernel_worker().

Since mptcp_pm_addr_send_ack() is a sleepable kfunc, which is invoked
by mptcp_pm_create_subflow_or_signal_addr(), .established() interface
of BPF PM should be invoked by __bpf_prog_enter_sleepable(), which
can't be invoked under a lock. This patch unlocks the pm lock before
invoking this interface in mptcp_pm_worker(), while holding this lock
in mptcp_pm_kernel_established().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h   | 3 +++
 net/mptcp/pm.c        | 9 ++++++++-
 net/mptcp/pm_kernel.c | 9 ++++-----
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 9f28ef550e10..d7410f08399e 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -124,6 +124,9 @@ struct mptcp_pm_ops {
 	bool (*get_priority)(struct mptcp_sock *msk,
 			     struct mptcp_addr_info *skc);
 
+	/* optional */
+	void (*established)(struct mptcp_sock *msk);
+
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4895318b94cc..a121c08b456e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -516,7 +516,8 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk)
 	 * be sure to serve this event only once.
 	 */
 	if (READ_ONCE(pm->work_pending) &&
-	    !(pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)))
+	    !(pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)) &&
+	    pm->ops->established)
 		mptcp_pm_schedule_work(msk, MPTCP_PM_ESTABLISHED);
 
 	if ((pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)) == 0)
@@ -964,6 +965,12 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
 		mptcp_pm_rm_addr_recv(msk);
 	}
+	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
+		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
+		spin_unlock_bh(&pm->lock);
+		pm->ops->established(msk);
+		spin_lock_bh(&pm->lock);
+	}
 	__mptcp_pm_kernel_worker(msk);
 
 	spin_unlock_bh(&msk->pm.lock);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 7ec81d5195d4..6d30d5958f0e 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -367,9 +367,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	mptcp_pm_nl_check_work_pending(msk);
 }
 
-static void mptcp_pm_nl_fully_established(struct mptcp_sock *msk)
+static void mptcp_pm_kernel_established(struct mptcp_sock *msk)
 {
+	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_create_subflow_or_signal_addr(msk);
+	spin_unlock_bh(&msk->pm.lock);
 }
 
 static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
@@ -1348,10 +1350,6 @@ void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
 		mptcp_pm_nl_add_addr_received(msk);
 	}
-	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
-		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
-		mptcp_pm_nl_fully_established(msk);
-	}
 	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
 		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
 		mptcp_pm_nl_subflow_established(msk);
@@ -1422,6 +1420,7 @@ static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_local_id		= mptcp_pm_kernel_get_local_id,
 	.get_priority		= mptcp_pm_kernel_get_priority,
+	.established		= mptcp_pm_kernel_established,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
-- 
2.43.0

