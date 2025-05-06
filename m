Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1013A26562A
	for <mptcp@lists.linux.dev>; Tue,  6 May 2025 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521739; cv=none; b=J4cQZamkbkVTuyRofVurhEz04/KK3bOyxM3j8X2i1FQwco0wvcjR7bbai64RYOS8xdmnCJfiPrUIyMCo3dzm22bvTGpwrjT58magiIpsBWRRGojokfegZSubFBwoys6HriWgcN2E6UoiBx0i6GW7NrpXO3hACgdvTkD87HTVaBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521739; c=relaxed/simple;
	bh=mwJp8zwsoUmbjfUj6wSiW2q6wZT2CCkw+s0NBs4ua8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+zvnSeGt10a6vGaVvXQi94RQP0X+52YHt3I701mImOcEtec9kE1ZuK7wpccFv4d7mpoY70nsHFoMr7owlSZRQqMEVsY3mRNus/ONwQHeL6kmh4IFU+Q4Es+eIxLh5vycYuNXKuEW1fcLvPLRLFAptNUY0IFK85ROPxXY/j4/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqV9Prof; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqV9Prof"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A27C4CEED;
	Tue,  6 May 2025 08:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746521738;
	bh=mwJp8zwsoUmbjfUj6wSiW2q6wZT2CCkw+s0NBs4ua8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WqV9ProfozPPi27NQIykpUNxXEwNfRbGSYaThJyxEk6aPLb8anOtmGat1NAtMsgCi
	 1PTiBxcz5ZXKZZ0qfQcB2GosZ3dFtPRtmq9YGkxjP9Ek5KImkXuPe6E6LsaOjKlwec
	 5U/yXkOB6oN9UzCxkRVfhhzePdDeDRNj7LIBkRvO3vB4OulwzNbb099DOh3R64kgfy
	 3/yI5Vq/ChaVK/KLaZPWaEhWBjKX34A4nqsURkFw6EFOzlRBbNk65HTFytDCudxd6y
	 FCpRE2kAQVWetF833/2AXPMW1NQUAts4A6PWR94bXI26J4MOCQ79Cn6HdUkhyslu9g
	 HJOUdGZJwZ96Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 4/5] mptcp: pm: add subflow_established() interface
Date: Tue,  6 May 2025 16:55:25 +0800
Message-ID: <bb70f5ba9c98f8604bc3804775694aa55c97d3dd.1746521233.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746521233.git.tanggeliang@kylinos.cn>
References: <cover.1746521233.git.tanggeliang@kylinos.cn>
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
 include/net/mptcp.h   | 1 +
 net/mptcp/pm.c        | 9 ++++++---
 net/mptcp/pm_kernel.c | 7 ++++---
 3 files changed, 11 insertions(+), 6 deletions(-)

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
index cf2d5918b6ba..7d67789fd09d 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -534,7 +534,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!READ_ONCE(pm->work_pending))
+	if (!READ_ONCE(pm->work_pending) || !pm->ops->subflow_established)
 		return;
 
 	spin_lock_bh(&pm->lock);
@@ -561,7 +561,8 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 		return;
 	}
 
-	if (!READ_ONCE(pm->work_pending) && !update_subflows)
+	if (!pm->ops->subflow_established ||
+	    (!READ_ONCE(pm->work_pending) && !update_subflows))
 		return;
 
 	spin_lock_bh(&pm->lock);
@@ -619,7 +620,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!READ_ONCE(pm->work_pending))
+	if (!READ_ONCE(pm->work_pending) || !pm->ops->subflow_established)
 		return;
 
 	spin_lock_bh(&pm->lock);
@@ -959,6 +960,8 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 	}
 	if (status & BIT(MPTCP_PM_ESTABLISHED))
 		pm->ops->established(msk);
+	if (status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED))
+		pm->ops->subflow_established(msk);
 	spin_lock_bh(&msk->pm.lock);
 	__mptcp_pm_kernel_worker(msk, status);
 
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 45a4ae1852ff..782642718429 100644
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
@@ -1346,8 +1348,6 @@ void __mptcp_pm_kernel_worker(struct mptcp_sock *msk, u8 status)
 {
 	if (status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED))
 		mptcp_pm_nl_add_addr_received(msk);
-	if (status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED))
-		mptcp_pm_nl_subflow_established(msk);
 }
 
 static int __net_init pm_nl_init_net(struct net *net)
@@ -1431,6 +1431,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_priority		= mptcp_pm_kernel_get_priority,
 	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
 	.established		= mptcp_pm_kernel_established,
+	.subflow_established	= mptcp_pm_kernel_subflow_established,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
-- 
2.43.0

