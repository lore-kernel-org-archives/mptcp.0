Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B838A262BE
	for <mptcp@lists.linux.dev>; Thu, 27 Mar 2025 06:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743055479; cv=none; b=aUbNr6qLNcU5AsdHjkoezJl0rC3Zu7ikWGQu5/viZCqKyICqPvrLtKPbxFMmcgYGnARzi3uIujb3zGi6Elp/e7xUaXqyFoZNtSSC7y9+2RpAxGZTPWfPCFQ6ioTnGJ6RFEJm7KDdV1ACrDYaFMSPLQ9pmVQ2Vojk6g7ocx8/ZDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743055479; c=relaxed/simple;
	bh=9JQCLPrOL6SQGx6xaiGBbMJZWuKTLkU5AHZ3GHmIi9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCBbrELZsEPyEq1y0XhG0bUrPCfQ1HNOPmz3QEps9cRTtcqcXAxUSyqwjzrdGoj4rq/8r4J6OxulPIoGVRPhmEkW4AOwabeKqpxvrQWb0RkTPaPzJqxFoHxp0jWltO3aHabpmbgLulhPkx4JkRIzb4Uwl6Bsy6irXcjBG2uxpps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2kim7dD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2kim7dD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2378AC4CEDD;
	Thu, 27 Mar 2025 06:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743055479;
	bh=9JQCLPrOL6SQGx6xaiGBbMJZWuKTLkU5AHZ3GHmIi9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i2kim7dDLm+FP9Vzf1LpSb6RXqMx2eBD5ihm7pQskXu9TJPikpbDLl+QAsnsANIPu
	 nl/PfWyk2kxD0VYWmj3irV+h6wBDdm6CBuh5QR6nx+snXd0/EEY8BUnVi4BGO9Rh4+
	 tWJWgq5CruYQh1/bHQmJ7FgX3liAVcY4Li6OslwGUjbJPnKKhjBtpFo6eADKASA/ud
	 JBoQLeFTcoTL3RtOFJ8qyoFQnmCw3nsQ9CjcNiqB3wQAEnAaX9kYDbMhJBcGfrWEDA
	 PzLfvMS1V7b1oTriCJiMKi0RoJtfjqGcyAOTtHo02c1ZCqnOG3yDyMfp6jRF3Zb/PI
	 ZmJfMybCc/TKg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 5/7] mptcp: pm: add established() interface
Date: Thu, 27 Mar 2025 14:04:15 +0800
Message-ID: <f8c6e925aa200f47df383964af6d09273ef90f5f.1743054942.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1743054942.git.tanggeliang@kylinos.cn>
References: <cover.1743054942.git.tanggeliang@kylinos.cn>
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
 net/mptcp/pm.c        |  9 ++++++++-
 net/mptcp/pm_kernel.c | 22 +++++++++++++---------
 3 files changed, 24 insertions(+), 10 deletions(-)

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
index 1e681acaad7f..8dcf61a77b7d 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -505,7 +505,8 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk)
 	 * be sure to serve this event only once.
 	 */
 	if (READ_ONCE(pm->work_pending) &&
-	    !(pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)))
+	    !(pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)) &&
+	    pm->ops->established)
 		mptcp_pm_schedule_work(msk, MPTCP_PM_ESTABLISHED);
 
 	if ((pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)) == 0)
@@ -956,6 +957,12 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		mptcp_pm_rm_addr_recv(msk);
 		spin_unlock_bh(&pm->lock);
 	}
+	if (status & BIT(MPTCP_PM_ESTABLISHED)) {
+		spin_lock_bh(&pm->lock);
+		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
+		spin_unlock_bh(&pm->lock);
+		pm->ops->established(msk);
+	}
 	spin_lock_bh(&pm->lock);
 	__mptcp_pm_kernel_worker(msk);
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 5cc35ee122ff..5444565c8cf2 100644
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
@@ -1447,6 +1450,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_local_id		= mptcp_pm_kernel_get_local_id,
 	.get_priority		= mptcp_pm_kernel_get_priority,
 	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
+	.established		= mptcp_pm_kernel_established,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
-- 
2.43.0

