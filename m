Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C47525D204
	for <mptcp@lists.linux.dev>; Mon, 24 Mar 2025 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742804395; cv=none; b=bdAZ8tYHuZEvvSfSuQfQuxZ8l0PIXvWQ49ZUOR7hX106M7ESX29H1YEQr79zJGI3DP9IJmeTW+jmtK1c4duikioWed9Eei4O5VvALXlyINXWk7FoeQVP2Hj/l9bG9+i/oVwuj7Sv5CJD/t/tW2f1wtaZcWAvBJ7jjK0xwcOhFp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742804395; c=relaxed/simple;
	bh=MNFlSDavUG5zv1IuuiCezCSDOHNvgQKy1BPm5hbCVNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z77D8uJ9J+KbmOzI/fmAbWllO+ZlOVn/fQnqdqHS5aTmvlGfRyOklEv+1H7ww6YPonu+cjcvrngsuSxH9Y7iA9LeUQxtiwBmJRkn3f9Bbth+mgvc/KC6zHvsZuhbWzpuHN/J8RR3g7FjzDtDgEod+L1sjlR3rNNluzsf6pvplZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrzrCodz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrzrCodz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CF6C4CEE4;
	Mon, 24 Mar 2025 08:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742804395;
	bh=MNFlSDavUG5zv1IuuiCezCSDOHNvgQKy1BPm5hbCVNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jrzrCodz7WoL7jj6UhVlanqdRxiofCBuBBKHoqcGzs+LGywsnDwD3JzZ2REcoHlg7
	 mSpi+2H4e4ejlQwNl/xIuhpjNSM+wBntHSHRi/liir38tE76bmrH2dYqli18BYibS6
	 0iz70JRijPlhrhDkpCJ9jbZb59kPL5nBEgx8OFLSNCv8hFqUwYhYpfi/HY6BO2elJG
	 yMFj9BlTeS+FZAcDoFpWujtm5xyVXNkCnZkA472eD8MrkMroz+sAwz51fO5UFRviu/
	 ij/Cobr/0394DM6NsQzhb94XcFlRLcZ9PE+A3FTHJoMkh9kBv9T5LcL/6L/eNH4xh5
	 oBrdySEPVF2cQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/9] mptcp: pm: add established interfaces
Date: Mon, 24 Mar 2025 16:19:36 +0800
Message-ID: <27d299ece14b91a1668a1310b07dda9bf84a2dbf.1742804266.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742804266.git.tanggeliang@kylinos.cn>
References: <cover.1742804266.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds .established and .subflow_established interfaces for
struct mptcp_pm_ops, and calls pm->ops->established/subflow_established
in from mptcp_pm_worker(). Then get rid of the corresponding code from
__mptcp_pm_kernel_worker().

Since mptcp_pm_addr_send_ack() is a sleepable kfunc, which is invoked
by mptcp_pm_create_subflow_or_signal_addr(), .established() and
.subflow_established() interfaces of BPF PM should be invoked by
__bpf_prog_enter_sleepable(), which can't be invoked under a lock.
This patch unlocks the pm lock before invoking this interface in
mptcp_pm_worker(), while holding this lock in mptcp_pm_kernel_established()
and mptcp_pm_kernel_subflow_established().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h   |  4 ++++
 net/mptcp/pm.c        | 32 ++++++++++++++++++++++++--------
 net/mptcp/pm_kernel.c | 25 +++++++++++--------------
 3 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 9f28ef550e10..4ac936e4ce0d 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -124,6 +124,10 @@ struct mptcp_pm_ops {
 	bool (*get_priority)(struct mptcp_sock *msk,
 			     struct mptcp_addr_info *skc);
 
+	/* optional */
+	void (*established)(struct mptcp_sock *msk);
+	void (*subflow_established)(struct mptcp_sock *msk);
+
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ba7424582ebf..e2b2c874a9f8 100644
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
@@ -543,7 +544,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!READ_ONCE(pm->work_pending))
+	if (!READ_ONCE(pm->work_pending) || !pm->ops->subflow_established)
 		return;
 
 	spin_lock_bh(&pm->lock);
@@ -570,7 +571,8 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 		return;
 	}
 
-	if (!READ_ONCE(pm->work_pending) && !update_subflows)
+	if (!pm->ops->subflow_established ||
+	    (!READ_ONCE(pm->work_pending) && !update_subflows))
 		return;
 
 	spin_lock_bh(&pm->lock);
@@ -628,7 +630,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!READ_ONCE(pm->work_pending))
+	if (!READ_ONCE(pm->work_pending) || !pm->ops->subflow_established)
 		return;
 
 	spin_lock_bh(&pm->lock);
@@ -949,20 +951,34 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 	if (!(pm->status & MPTCP_PM_WORK_MASK))
 		return;
 
-	spin_lock_bh(&msk->pm.lock);
-
 	pr_debug("msk=%p status=%x\n", msk, pm->status);
 	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
+		spin_lock_bh(&pm->lock);
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);
 		mptcp_pm_addr_send_ack(msk);
+		spin_unlock_bh(&pm->lock);
 	}
 	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
+		spin_lock_bh(&pm->lock);
 		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
 		mptcp_pm_rm_addr_recv(msk);
+		spin_unlock_bh(&pm->lock);
+	}
+	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
+		spin_lock_bh(&pm->lock);
+		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
+		spin_unlock_bh(&pm->lock);
+		pm->ops->established(msk);
+	}
+	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
+		spin_lock_bh(&pm->lock);
+		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
+		spin_unlock_bh(&pm->lock);
+		pm->ops->subflow_established(msk);
 	}
+	spin_lock_bh(&pm->lock);
 	__mptcp_pm_kernel_worker(msk);
-
-	spin_unlock_bh(&msk->pm.lock);
+	spin_unlock_bh(&pm->lock);
 }
 
 static void mptcp_pm_ops_init(struct mptcp_sock *msk,
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 7ec81d5195d4..2e181224bccb 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -269,6 +269,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	local_addr_max = mptcp_pm_get_local_addr_max(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
+	spin_lock_bh(&msk->pm.lock);
 	/* do lazy endpoint usage accounting for the MPC subflows */
 	if (unlikely(!(msk->pm.status & BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED))) && msk->first) {
 		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(msk->first);
@@ -307,7 +308,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		 * current address announce will be completed.
 		 */
 		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
-			return;
+			goto out;
 
 		if (!select_signal_address(pernet, msk, &local))
 			goto subflow;
@@ -316,7 +317,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		 * continuing, and trying to create subflows.
 		 */
 		if (!mptcp_pm_alloc_anno_list(msk, &local.addr))
-			return;
+			goto out;
 
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;
@@ -365,14 +366,16 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		spin_lock_bh(&msk->pm.lock);
 	}
 	mptcp_pm_nl_check_work_pending(msk);
+out:
+	spin_unlock_bh(&msk->pm.lock);
 }
 
-static void mptcp_pm_nl_fully_established(struct mptcp_sock *msk)
+static void mptcp_pm_kernel_established(struct mptcp_sock *msk)
 {
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
 
-static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
+static void mptcp_pm_kernel_subflow_established(struct mptcp_sock *msk)
 {
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
@@ -758,8 +761,8 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net,
 		spin_lock_bh(&msk->pm.lock);
 		if (mptcp_addresses_equal(addr, &mpc_addr, addr->port))
 			msk->mpc_endpoint_id = addr->id;
-		mptcp_pm_create_subflow_or_signal_addr(msk);
 		spin_unlock_bh(&msk->pm.lock);
+		mptcp_pm_create_subflow_or_signal_addr(msk);
 		release_sock(sk);
 
 next:
@@ -1243,8 +1246,8 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_rm_subflow(msk, &list);
 	__mark_subflow_endp_available(msk, list.ids[0]);
-	mptcp_pm_create_subflow_or_signal_addr(msk);
 	spin_unlock_bh(&msk->pm.lock);
+	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
 
 static void mptcp_pm_nl_set_flags_all(struct net *net,
@@ -1348,14 +1351,6 @@ void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
 		mptcp_pm_nl_add_addr_received(msk);
 	}
-	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
-		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
-		mptcp_pm_nl_fully_established(msk);
-	}
-	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
-		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
-		mptcp_pm_nl_subflow_established(msk);
-	}
 }
 
 static int __net_init pm_nl_init_net(struct net *net)
@@ -1422,6 +1417,8 @@ static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_local_id		= mptcp_pm_kernel_get_local_id,
 	.get_priority		= mptcp_pm_kernel_get_priority,
+	.established		= mptcp_pm_kernel_established,
+	.subflow_established	= mptcp_pm_kernel_subflow_established,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
-- 
2.43.0

