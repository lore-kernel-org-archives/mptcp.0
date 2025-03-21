Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA271E376C
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 01:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521554; cv=none; b=GeF6FCaV+2MH02B8Pymg7+Ua/IQl6zac+tQv5eVToYZepbLEPDeaxocGO1hcgkBJFrmk5Hz3mppB0wPT7edoRrWhTuK+wwS1RMfQWW7k7XG+VAj5jZ8EP2zc5JGRDsxk/C7YKYvYE9wwNlB7roUSmWQnZHk/DPFGurDWO2sp4aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521554; c=relaxed/simple;
	bh=lqAzjRXwF0QmBhz+bESOm1UPkkw84/jF82YBP7ftVsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlXrtZ7MvYNdjNfE8obpAELy5hXars3qvjQedK5KwTF46rxlAGnZnvVfayV2V9PIwnfFYozYUKwqIFCm3PWpWrGs1IHm308ISu/UltBbkPvr5xXdYidjMEFeih1Y7dvCMPTZZU7vZ8kESLKZyWpzQ//hfgDZYqqa2eKS1cgsdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWDkIAn9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWDkIAn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C933C4CEEA;
	Fri, 21 Mar 2025 01:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742521554;
	bh=lqAzjRXwF0QmBhz+bESOm1UPkkw84/jF82YBP7ftVsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pWDkIAn919e4JwDX9+IPYM3DRie7PZOkA683hRocXPUfP9twaH4eHD1qIinjVth4N
	 UVaqWqDwD6Tn8ihTmKOa2sgSQUDwW1mDcRiMcVBxVcWlVnxlnUNge+4v4GOUVATzaT
	 0FwleCG0KnQEX+ENbaHKZzA53rmaUnv5YTElF3yhhxzzXa1BOYWFnFty67xWvzajMO
	 NDbJWMdh7foo3NvsI45iybMycBWX9GseVgORsGuZyq7/AWS+ipSY4bOEHtRmVyWrsb
	 r0DtLd93i84LL7eCXnz+GIydJ6q6T2Dct0Fo7rYhWBofUAbd/M7LScAO24oKH5myvh
	 OLmSTkl3vmeHQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 09/10] mptcp: pm: add rm_addr_received() interface
Date: Fri, 21 Mar 2025 09:45:03 +0800
Message-ID: <e14151bf63b9ae2fa6f75061e1d0d2de069ec6b1.1742521397.git.tanggeliang@kylinos.cn>
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

This patch adds an optional .rm_addr_received interface for struct
mptcp_pm_ops and invokes it in mptcp_pm_worker() without PM lock.
Since mptcp_subflow_shutdown() and mptcp_close_ssk() are sleepable
kfuncs, .rm_addr_received interface of BPF PM should be invoked by
__bpf_prog_enter_sleepable(), which can't be invoked under a lock.
This patch unlocks the pm lock before invoking this interface in
mptcp_pm_worker(), while holding this lock in mptcp_pm_rm_addr_recv().

Export mptcp_pm_rm_addr_recv() is to allow the MPTCP_PM_RM_ADDR_RECEIVED
worker can be invoke from the in-kernel PM.

With this, mptcp_pm_is_kernel() in mptcp_pm_rm_addr_or_subflow() can be
dropped.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h   |  1 +
 net/mptcp/pm.c        | 13 ++++++++++---
 net/mptcp/pm_kernel.c |  6 ++++++
 net/mptcp/protocol.h  |  1 +
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 90fda6d1468c..bd8a20b9d02b 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -137,6 +137,7 @@ struct mptcp_pm_ops {
 	/* optional */
 	int (*add_addr_received)(struct mptcp_sock *msk,
 				 const struct mptcp_addr_info *addr);
+	void (*rm_addr_received)(struct mptcp_sock *msk);
 
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 7b34a59977cf..bb456e203665 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -677,15 +677,17 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
 
 		if (rm_type == MPTCP_MIB_RMADDR) {
 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
-			if (removed && mptcp_pm_is_kernel(msk))
+			if (removed)
 				mptcp_pm_nl_rm_addr(msk, rm_id);
 		}
 	}
 }
 
-static void mptcp_pm_rm_addr_recv(struct mptcp_sock *msk)
+void mptcp_pm_rm_addr_recv(struct mptcp_sock *msk)
 {
+	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR);
+	spin_unlock_bh(&msk->pm.lock);
 }
 
 void mptcp_pm_rm_subflow(struct mptcp_sock *msk,
@@ -705,6 +707,9 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 	for (i = 0; i < rm_list->nr; i++)
 		mptcp_event_addr_removed(msk, rm_list->ids[i]);
 
+	if (!pm->ops->rm_addr_received)
+		return;
+
 	spin_lock_bh(&pm->lock);
 	if (mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED))
 		pm->rm_list_rx = *rm_list;
@@ -931,7 +936,9 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 	}
 	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
 		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
-		mptcp_pm_rm_addr_recv(msk);
+		spin_unlock_bh(&pm->lock);
+		pm->ops->rm_addr_received(msk);
+		spin_lock_bh(&pm->lock);
 	}
 	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
 		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 1a434abcf862..4f7b2e0e998d 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1446,6 +1446,11 @@ static int mptcp_pm_kernel_add_addr_received(struct mptcp_sock *msk,
 	return ret;
 }
 
+static void mptcp_pm_kernel_rm_addr_received(struct mptcp_sock *msk)
+{
+	mptcp_pm_rm_addr_recv(msk);
+}
+
 static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 {
 	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
@@ -1475,6 +1480,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
 	.add_addr_echo		= mptcp_pm_kernel_add_addr_echo,
 	.add_addr_received	= mptcp_pm_kernel_add_addr_received,
+	.rm_addr_received	= mptcp_pm_kernel_rm_addr_received,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 784e787cf667..4883f786e8ea 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1031,6 +1031,7 @@ void mptcp_pm_rm_subflow(struct mptcp_sock *msk,
 			 const struct mptcp_rm_list *rm_list);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
+void mptcp_pm_rm_addr_recv(struct mptcp_sock *msk);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
 int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
-- 
2.43.0

