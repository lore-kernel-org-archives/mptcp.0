Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C703426AC3
	for <mptcp@lists.linux.dev>; Fri, 28 Mar 2025 04:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743134506; cv=none; b=b+vwXC1pdOF1st/cC83sL8UMhiDQScvGkm1dXCkQ6k1zCqxU1iZzQEooY7lFiBtY2epHYidqcicqok7GbIbOqkRCg51qT4WqmMxQWpdii55IYsghe/Y0v7ztCaLkSBdwANhIvL4rgBVUiLqIB2kKs6G9GpGPhaOyCkaqHICVetU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743134506; c=relaxed/simple;
	bh=2EtNA7J7eLESaeHO7feiQ/6LA0T0qC1i4mXDfY2vKKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhTvVsYSvCFyBdZVzCsBfJ9F4gqDuFpyNBpwpX0U8i6392zckBh3RoksiyuN7uu96KNHUGr6XSYkS+nTMGK29BujiWVtwAcA1fcfhLy8KmOBJyrPhmxCyXV9Ut5z4oaF8anNFqjx4jkhjE5vEpmc350nUTd76eIkjUukzU2Q2d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iyblzl1+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iyblzl1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349DAC4CEE4;
	Fri, 28 Mar 2025 04:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743134506;
	bh=2EtNA7J7eLESaeHO7feiQ/6LA0T0qC1i4mXDfY2vKKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iyblzl1+Xw9NaVEu10rIdoj+adJi8vo7NHheko/PHb7lC/dNBEYLQlSYfzYSRrxxV
	 2MOHQ3eC/7vDmhbha7gTkWDbpVqWIrL3lRTMC44hx4vNkgEQTrnuy8sU+u2USJRTqJ
	 KJ2Yz0itxt5OxFnzXSzGtwHldxyOiJwBeiCMkhesdeolX2xPdsGHHauOwn0ClQuyzO
	 VZAceGtfnTIF2hTomny82PJSra8R/6Vywlaxd8G6d/3LJdhVsvUyuM4UBA6N5qR/gf
	 t1LMqM8XHvmmdCp17LkSwDKTNADzT6L67NWa9UcRvtUVgsIQ8rMkPXK9ELPI1nDh6n
	 CWfi/ejptvKlA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 3/5] mptcp: pm: add established() interface
Date: Fri, 28 Mar 2025 12:01:33 +0800
Message-ID: <99ed8e044c089127c478d8689ed41091a761c306.1743133948.git.tanggeliang@kylinos.cn>
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

This patch adds a .established interface for struct mptcp_pm_ops, and
calls pm->ops->established in from mptcp_pm_worker(). Then get rid of
the corresponding code from __mptcp_pm_kernel_worker().

Since mptcp_pm_addr_send_ack() is a sleepable kfunc, which is invoked
by mptcp_pm_create_subflow_or_signal_addr(), .established() interface
of BPF PM should be invoked by __bpf_prog_enter_sleepable(), which
can't be invoked under a lock. This patch unlocks the pm lock before
invoking this interface in mptcp_pm_worker(), while holding this lock
in mptcp_pm_kernel_established().

Add a helper to call mptcp_pm_create_subflow_or_signal_addr() while
holding mptcp pm lock, and rename the original one with "__" prefix.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h   |  3 +++
 net/mptcp/pm.c        |  8 ++++++--
 net/mptcp/pm_kernel.c | 22 +++++++++++++---------
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 549b8075cc86..97a237c9bfe0 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -125,6 +125,9 @@ struct mptcp_pm_ops {
 			     struct mptcp_addr_info *skc);
 	bool (*accept_new_subflow)(struct mptcp_sock *msk, bool allow);
 
+	/* optional, call from the msk context */
+	void (*established)(struct mptcp_sock *msk);
+
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index a96f3495d220..e7b3600239e0 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -513,7 +513,8 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk)
 	 * be sure to serve this event only once.
 	 */
 	if (READ_ONCE(pm->work_pending) &&
-	    !(pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)))
+	    !(pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)) &&
+	    pm->ops->established)
 		mptcp_pm_schedule_work(msk, MPTCP_PM_ESTABLISHED);
 
 	if ((pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)) == 0)
@@ -942,7 +943,8 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 void mptcp_pm_worker(struct mptcp_sock *msk)
 {
 	u8 status, mask = BIT(MPTCP_PM_ADD_ADDR_SEND_ACK) |
-			  BIT(MPTCP_PM_RM_ADDR_RECEIVED);
+			  BIT(MPTCP_PM_RM_ADDR_RECEIVED) |
+			  BIT(MPTCP_PM_ESTABLISHED);
 	struct mptcp_pm_data *pm = &msk->pm;
 
 	msk_owned_by_me(msk);
@@ -960,6 +962,8 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		mptcp_pm_addr_send_ack(msk);
 	if (status & BIT(MPTCP_PM_RM_ADDR_RECEIVED))
 		mptcp_pm_rm_addr_recv(msk);
+	if (status & BIT(MPTCP_PM_ESTABLISHED))
+		pm->ops->established(msk);
 	spin_lock_bh(&pm->lock);
 	__mptcp_pm_kernel_worker(msk);
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index eaf73c4cedd3..31794193442d 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -253,7 +253,7 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 	return NULL;
 }
 
-static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
+static void __mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
 	unsigned int add_addr_signal_max;
@@ -367,14 +367,21 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	mptcp_pm_nl_check_work_pending(msk);
 }
 
-static void mptcp_pm_nl_fully_established(struct mptcp_sock *msk)
+static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
+{
+	spin_lock_bh(&msk->pm.lock);
+	__mptcp_pm_create_subflow_or_signal_addr(msk);
+	spin_unlock_bh(&msk->pm.lock);
+}
+
+static void mptcp_pm_kernel_established(struct mptcp_sock *msk)
 {
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
 
 static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
 {
-	mptcp_pm_create_subflow_or_signal_addr(msk);
+	__mptcp_pm_create_subflow_or_signal_addr(msk);
 }
 
 /* Fill all the local addresses into the array addrs[],
@@ -758,7 +765,7 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net,
 		spin_lock_bh(&msk->pm.lock);
 		if (mptcp_addresses_equal(addr, &mpc_addr, addr->port))
 			msk->mpc_endpoint_id = addr->id;
-		mptcp_pm_create_subflow_or_signal_addr(msk);
+		__mptcp_pm_create_subflow_or_signal_addr(msk);
 		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 
@@ -1243,7 +1250,7 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_rm_subflow(msk, &list);
 	__mark_subflow_endp_available(msk, list.ids[0]);
-	mptcp_pm_create_subflow_or_signal_addr(msk);
+	__mptcp_pm_create_subflow_or_signal_addr(msk);
 	spin_unlock_bh(&msk->pm.lock);
 }
 
@@ -1348,10 +1355,6 @@ void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
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
@@ -1438,6 +1441,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_local_id		= mptcp_pm_kernel_get_local_id,
 	.get_priority		= mptcp_pm_kernel_get_priority,
 	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
+	.established		= mptcp_pm_kernel_established,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
-- 
2.43.0

