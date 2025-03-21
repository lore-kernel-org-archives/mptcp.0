Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4812635947
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 01:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521547; cv=none; b=JPzqtR4MpaGTTpSUq6ESbPBnv47Fnx8r7p/460bVUODBBr4YM4Wk+OaUCBK0f+Ta5lBwqvBAPoQFof40aWmbAhbfaHWyzbMncL+EC0PvsL7++lOGRezliP46FnrWBCcsObBw4TgFQ8OT4xtRs+kFoeZFPHzpEKyx6aH5xUDofTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521547; c=relaxed/simple;
	bh=k2LQi3qslZfqk/987X++r2Wkmn13DH0FkjjSS5+sQEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfmzfZEX9o7+CcuH17QW6uMT2bQnHtmcmdX2796E1Xx4vKCL9LqpK6fGZrPd8s8p7axNIqnOn7ROwepFtEadWFUGw2bXqIGOv66/e/AQ6rOoOFO2RheDEM4oCu+q9Wmkl29SR6ZbQTvpTT29R6d/GYacBPF8BjWsVka5/baOYRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjjaGZRq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjjaGZRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C26BC4CEDD;
	Fri, 21 Mar 2025 01:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742521545;
	bh=k2LQi3qslZfqk/987X++r2Wkmn13DH0FkjjSS5+sQEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjjaGZRqFIa5DXWLhLksIcRLOoYSjfS2edxXcsT98GxerK28KBFX8yd3J5z/VnHv4
	 pQ1T4cCayNmUXV6USjegT4CnPJkq4cSzjo1imoIFj8uB6SIAsul62pv5tGBFgrBvRf
	 3WNZzOecJyZnPlc5/5pQlVWXEIFbzHVzejrNUMrDPiSD0dTCMURXloanA4Wv/hDguu
	 5dxcCTMT9fRo94Sb93fFgthLQ+u2nJaOUNcabFn9zGG91ov3YMkSqhxl5KJ1L9Tefy
	 m3GxjhXhrjItFEnFsxsLYyuK3SA/mq/38VQDQiCGQmbniYHStQh5IfNlU/2mi41Lh7
	 zekKwK5bn2Q3Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 04/10] mptcp: pm: add subflow_established() interface
Date: Fri, 21 Mar 2025 09:44:58 +0800
Message-ID: <0851219a7e333127fc1dbd927c5a8bd5f11efcc5.1742521397.git.tanggeliang@kylinos.cn>
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
 net/mptcp/pm.c        | 13 +++++++++++--
 net/mptcp/pm_kernel.c |  9 ++++-----
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d7410f08399e..4ac936e4ce0d 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -126,6 +126,7 @@ struct mptcp_pm_ops {
 
 	/* optional */
 	void (*established)(struct mptcp_sock *msk);
+	void (*subflow_established)(struct mptcp_sock *msk);
 
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index a121c08b456e..35361d525101 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -544,7 +544,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!READ_ONCE(pm->work_pending))
+	if (!READ_ONCE(pm->work_pending) || !pm->ops->subflow_established)
 		return;
 
 	spin_lock_bh(&pm->lock);
@@ -571,6 +571,9 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 		return;
 	}
 
+	if (!pm->ops->subflow_established)
+		return;
+
 	if (!READ_ONCE(pm->work_pending) && !update_subflows)
 		return;
 
@@ -633,7 +636,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!READ_ONCE(pm->work_pending))
+	if (!READ_ONCE(pm->work_pending) || !pm->ops->subflow_established)
 		return;
 
 	spin_lock_bh(&pm->lock);
@@ -971,6 +974,12 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		pm->ops->established(msk);
 		spin_lock_bh(&pm->lock);
 	}
+	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
+		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
+		spin_unlock_bh(&pm->lock);
+		pm->ops->subflow_established(msk);
+		spin_lock_bh(&pm->lock);
+	}
 	__mptcp_pm_kernel_worker(msk);
 
 	spin_unlock_bh(&msk->pm.lock);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 6d30d5958f0e..bd17b1afee2c 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -374,9 +374,11 @@ static void mptcp_pm_kernel_established(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 
-static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
+static void mptcp_pm_kernel_subflow_established(struct mptcp_sock *msk)
 {
+	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_create_subflow_or_signal_addr(msk);
+	spin_unlock_bh(&msk->pm.lock);
 }
 
 /* Fill all the local addresses into the array addrs[],
@@ -1350,10 +1352,6 @@ void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
 		mptcp_pm_nl_add_addr_received(msk);
 	}
-	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
-		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
-		mptcp_pm_nl_subflow_established(msk);
-	}
 }
 
 static int __net_init pm_nl_init_net(struct net *net)
@@ -1421,6 +1419,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_local_id		= mptcp_pm_kernel_get_local_id,
 	.get_priority		= mptcp_pm_kernel_get_priority,
 	.established		= mptcp_pm_kernel_established,
+	.subflow_established	= mptcp_pm_kernel_subflow_established,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
-- 
2.43.0

