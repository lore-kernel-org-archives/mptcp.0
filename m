Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3F726AC3
	for <mptcp@lists.linux.dev>; Fri, 28 Mar 2025 04:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743134508; cv=none; b=uZx8BACqbimTxdjWY3mznkXaTQlIOq1nt0mHfCt5FEERqRCw58ISATgM0nkRm1UCUHwOXAIx2e0GJ8ExVdXrNgWMIWuGKMS1KtCmIdwiM+5sC520DvelSGwc+39c2YmgCkhwq6WMKpXly11zpiJusmodHgYXzLwE9dcC/q/72CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743134508; c=relaxed/simple;
	bh=GND6xI2k5Hk4P2tk8pnyQ8Xkg2Ozs7rdtaOXxFuNR+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8K67h3XVvZatRoj9FzglsxeFzxTH5C4aiL6L+FsAKAIz9dECADcwzmf9ef2WwsNNpZIueyx2z3H4G/45kEIMgqcJ5PolSO4MUxRuhSOMvEZr9j6Zgb9vY2AomH7NsJvmclsaHVAHokF1a+FP7XQaYvNLrTWRhBAAh1xHwWOqpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfhKKt6c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfhKKt6c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1E3C4CEE4;
	Fri, 28 Mar 2025 04:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743134507;
	bh=GND6xI2k5Hk4P2tk8pnyQ8Xkg2Ozs7rdtaOXxFuNR+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZfhKKt6cDmYKisL72oBQX2Dlh0UxAXOWTBR5UiF33nElcSgMjMYi22BIy0jRI5yxD
	 bvpkcKGU0fpcT36wGrJ2hP/c4yDnxaXTsiPGqlwAXl+Vw5cMgRMnGwIyfatGspC9I3
	 TW5GBcL6Mp1l4kJG5h0nt4BwcPFyPUtFFoda77i+nQscAa0XOcrc4tEA724WM3ua6p
	 8cCfUoVAczhTnsNjZZakuD4VvcaVNnCtJNc6Hi0fyn55nMUK1iquE2B2jQ6FgiRt0T
	 VR1XBUUp6qwVr6em1fqgdrF2knTzTKEiu34XNpNLBwzDt2iHkWGNRiO2/uS0J9y0tJ
	 e0EV7iGiJNoKQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 4/5] mptcp: pm: add subflow_established() interface
Date: Fri, 28 Mar 2025 12:01:34 +0800
Message-ID: <2b2ca63b7c3e1bcb42af404ca3b7203b4ff946bb.1743133948.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1743133948.git.tanggeliang@kylinos.cn>
References: <cover.1743133948.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a .subflow_established interface for struct mptcp_pm_ops,
and calls pm->ops->subflow_established in from mptcp_pm_worker(). Then
get rid of the corresponding code from __mptcp_pm_kernel_worker().

Since mptcp_pm_addr_send_ack() is a sleepable kfunc, which is invoked
by mptcp_pm_create_subflow_or_signal_addr(), .subflow_established()
interface of BPF PM should be invoked by __bpf_prog_enter_sleepable(),
which can't be invoked under a lock. This patch unlocks the pm lock
before invoking this interface in mptcp_pm_worker(), while holding this
lock in mptcp_pm_kernel_subflow_established().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h   |  1 +
 net/mptcp/pm.c        | 12 ++++++++----
 net/mptcp/pm_kernel.c |  9 +++------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 97a237c9bfe0..1eae68c9e662 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -127,6 +127,7 @@ struct mptcp_pm_ops {
 
 	/* optional, call from the msk context */
 	void (*established)(struct mptcp_sock *msk);
+	void (*subflow_established)(struct mptcp_sock *msk);
 
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e7b3600239e0..673313b9b25f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -541,7 +541,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!READ_ONCE(pm->work_pending))
+	if (!READ_ONCE(pm->work_pending) || !pm->ops->subflow_established)
 		return;
 
 	spin_lock_bh(&pm->lock);
@@ -568,7 +568,8 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 		return;
 	}
 
-	if (!READ_ONCE(pm->work_pending) && !update_subflows)
+	if (!pm->ops->subflow_established ||
+	    (!READ_ONCE(pm->work_pending) && !update_subflows))
 		return;
 
 	spin_lock_bh(&pm->lock);
@@ -626,7 +627,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!READ_ONCE(pm->work_pending))
+	if (!READ_ONCE(pm->work_pending) || !pm->ops->subflow_established)
 		return;
 
 	spin_lock_bh(&pm->lock);
@@ -944,7 +945,8 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 {
 	u8 status, mask = BIT(MPTCP_PM_ADD_ADDR_SEND_ACK) |
 			  BIT(MPTCP_PM_RM_ADDR_RECEIVED) |
-			  BIT(MPTCP_PM_ESTABLISHED);
+			  BIT(MPTCP_PM_ESTABLISHED) |
+			  BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
 	struct mptcp_pm_data *pm = &msk->pm;
 
 	msk_owned_by_me(msk);
@@ -964,6 +966,8 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		mptcp_pm_rm_addr_recv(msk);
 	if (status & BIT(MPTCP_PM_ESTABLISHED))
 		pm->ops->established(msk);
+	if (status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED))
+		pm->ops->subflow_established(msk);
 	spin_lock_bh(&pm->lock);
 	__mptcp_pm_kernel_worker(msk);
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 31794193442d..000f4f173ad5 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -379,9 +379,9 @@ static void mptcp_pm_kernel_established(struct mptcp_sock *msk)
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
 
-static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
+static void mptcp_pm_kernel_subflow_established(struct mptcp_sock *msk)
 {
-	__mptcp_pm_create_subflow_or_signal_addr(msk);
+	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
 
 /* Fill all the local addresses into the array addrs[],
@@ -1355,10 +1355,6 @@ void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
 		mptcp_pm_nl_add_addr_received(msk);
 	}
-	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
-		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
-		mptcp_pm_nl_subflow_established(msk);
-	}
 }
 
 static int __net_init pm_nl_init_net(struct net *net)
@@ -1442,6 +1438,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_priority		= mptcp_pm_kernel_get_priority,
 	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
 	.established		= mptcp_pm_kernel_established,
+	.subflow_established	= mptcp_pm_kernel_subflow_established,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
-- 
2.43.0

