Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30072AF19
	for <mptcp@lists.linux.dev>; Fri, 14 Mar 2025 02:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741920362; cv=none; b=MJM/sS16h6zWpKtreS23mwXGcJTuYWw6WEsV9TgGtkGWx3m/ci8X+ufxFweBncjZvUPIaX4fCsocZCfWZGMS2z2vk9YPTo6RsbX7WJoTi/QiOflrOwCCOX2lkFs1lwnaTVvE2BHY7g3bVx2yJY09JGN5YHqDGwoDfJQlcQOoRLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741920362; c=relaxed/simple;
	bh=DXehY/hf7fb5Y4qysM9rBUyyA6EYM29TmGKigFlw4ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DploRq/JP/3hBc0e+UjplC7Wx+LHGKrXnbtadgBIVJ0w/7jK3aFRP3y/S8jPzneua8jK/047qa2oqVmW1n9mnUbktNt59xWzuyrtuqfZr9j31e+gxYNh6qQxynLaU3Iy0sxqVh3BVIRyPVK7Rkcmxo5kws+GBfqVZq5kjZ3uLn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDCXG9KI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDCXG9KI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05524C4CEDD;
	Fri, 14 Mar 2025 02:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741920362;
	bh=DXehY/hf7fb5Y4qysM9rBUyyA6EYM29TmGKigFlw4ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDCXG9KIfcGO80jNLrcW1u6xoc8XTZpweMxMrMRQOlewsN52JTFHUIeLezO2B45xe
	 PeajZluIxLGvbRV7dWFF0RSK1lR7tWC7cXPtK81moQxaDnqfPPllYO1eTnG/knNSiY
	 g92BQDqL7ykf/k+Nvph+6C+uyM577eq6TEMl5z9HyNr2bXIA+Gc+nXu1HdQN3HyG4V
	 V0yxkGNBVqpJui8FjwGSp5sLU6rGIKiQ9erDpY7dmOo09jz50g0nRz4erw52BqdtxT
	 CjPA4owG6rBrbpxAliyvdogvNUggCOCnevyQWmqj7Hx8nmR1o8I7xLTGjGB4urTmwu
	 U5W43LwIyQYNw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 09/10] mptcp: pm: add rm_addr_received() interface
Date: Fri, 14 Mar 2025 10:45:30 +0800
Message-ID: <9489a0504d552aa158824dc80e14143316fa714b.1741919893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1741919893.git.tanggeliang@kylinos.cn>
References: <cover.1741919893.git.tanggeliang@kylinos.cn>
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

Export mptcp_pm_rm_addr_recv() is to allow the MPTCP_PM_RM_ADDR_RECEIVED
worker can be invoke from the in-kernel PM.

With this, mptcp_pm_is_kernel() in mptcp_pm_rm_addr_or_subflow() can
be dropped.

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
index d5cb7c60d177..70611946dfbf 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -676,15 +676,17 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
 
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
@@ -704,6 +706,9 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 	for (i = 0; i < rm_list->nr; i++)
 		mptcp_event_addr_removed(msk, rm_list->ids[i]);
 
+	if (!pm->ops->rm_addr_received)
+		return;
+
 	spin_lock_bh(&pm->lock);
 	if (mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED))
 		pm->rm_list_rx = *rm_list;
@@ -930,7 +935,9 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 	}
 	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
 		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
-		mptcp_pm_rm_addr_recv(msk);
+		spin_unlock_bh(&msk->pm.lock);
+		pm->ops->rm_addr_received(msk);
+		return;
 	}
 	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
 		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 74838e2c66ba..d04dd1cece09 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1441,6 +1441,11 @@ static int mptcp_pm_kernel_add_addr_received(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 
+static void mptcp_pm_kernel_rm_addr_received(struct mptcp_sock *msk)
+{
+	mptcp_pm_rm_addr_recv(msk);
+}
+
 static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 {
 	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
@@ -1470,6 +1475,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
 	.add_addr_echo		= mptcp_pm_kernel_add_addr_echo,
 	.add_addr_received	= mptcp_pm_kernel_add_addr_received,
+	.rm_addr_received	= mptcp_pm_kernel_rm_addr_received,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8663350fac2f..d8b46f8ef8d3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1030,6 +1030,7 @@ void mptcp_pm_rm_subflow(struct mptcp_sock *msk,
 			 const struct mptcp_rm_list *rm_list);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
+void mptcp_pm_rm_addr_recv(struct mptcp_sock *msk);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
 int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
-- 
2.45.2

