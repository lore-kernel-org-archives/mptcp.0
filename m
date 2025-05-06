Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63A2264A7C
	for <mptcp@lists.linux.dev>; Tue,  6 May 2025 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521737; cv=none; b=uzhYd7nNWes5jAN+00BMXUp3bDzA/tokrva77TzeaKpOFsm3IGUM5UKJyA7fK4ceVwUSTKyCGv/dYik7O7MTp25Z33hM0K+jTTA/neBrt6Jcmc5y9aQVY5sk12L3tLMuWZ9cnUwmMlBx3pN+S+rQxDmg8L8Saiu+QflFCsTLS7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521737; c=relaxed/simple;
	bh=w0qiJ10IGQHqO6YKC0Go7J6o9D1hT81Jssm9Q7Q8HD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5JnF0M2BMqRAA3apyOoOVbd33LLs6nJEA5ck5zWCwXkWGJ7K75zYHrHnNu5J4UBh/safqfdck9jsFJB7OO+33B54YC3bbu8y6x/olrLXB+ltsccFo6iMMvzzJirwSv7oNZVaeLkTlTy3MXWxZGzfsKxz8cquTDFu/tQ9HgzS20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ss18NGy6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss18NGy6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A236C4CEF0;
	Tue,  6 May 2025 08:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746521737;
	bh=w0qiJ10IGQHqO6YKC0Go7J6o9D1hT81Jssm9Q7Q8HD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ss18NGy6Rkdt3xIgDrsaS/I2bruVyzFnaSUKmo4mdAR1O6jS2jPyzd3FKO+jdeQMx
	 KzrrahZESJ6Toj4TERgpsFVuU7Za7r8AdSxiFgtwyyKKKg6sPeV4wTIzPMWnVYyPR/
	 jVnTdWVJQsMowg5qohprLp49d/MWnGAYu8Zd8tzo7u0qo0rF0bL5yQ+NUO2sDEQSxp
	 GHog5aYft/cPYvlTjeBS2BPTDb6YgRuuwYmJk9Y+X29dNXH7z1odGS7W6K67DPuv6z
	 RV+H9gA+by40v1FLJ1/qmXVZOVVp2HqmqMsNNVq1gFibHSQ+xLv6lnR0ysyURCT+EI
	 wPYAFoS9i3m6A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 3/5] mptcp: pm: add established() interface
Date: Tue,  6 May 2025 16:55:24 +0800
Message-ID: <3f7f9167519e283a638f43fee0d5b72a1c18b893.1746521233.git.tanggeliang@kylinos.cn>
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
 net/mptcp/pm.c        | 5 ++++-
 net/mptcp/pm_kernel.c | 7 ++++---
 3 files changed, 11 insertions(+), 4 deletions(-)

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
index 1abe3a3a86f2..cf2d5918b6ba 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -506,7 +506,8 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk)
 	 * be sure to serve this event only once.
 	 */
 	if (READ_ONCE(pm->work_pending) &&
-	    !(pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)))
+	    !(pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)) &&
+	    pm->ops->established)
 		mptcp_pm_schedule_work(msk, MPTCP_PM_ESTABLISHED);
 
 	if ((pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)) == 0)
@@ -956,6 +957,8 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		mptcp_pm_rm_addr_recv(msk);
 		spin_unlock_bh(&pm->lock);
 	}
+	if (status & BIT(MPTCP_PM_ESTABLISHED))
+		pm->ops->established(msk);
 	spin_lock_bh(&msk->pm.lock);
 	__mptcp_pm_kernel_worker(msk, status);
 
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index a1c5dabb6e56..45a4ae1852ff 100644
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
@@ -1344,8 +1346,6 @@ void __mptcp_pm_kernel_worker(struct mptcp_sock *msk, u8 status)
 {
 	if (status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED))
 		mptcp_pm_nl_add_addr_received(msk);
-	if (status & BIT(MPTCP_PM_ESTABLISHED))
-		mptcp_pm_nl_fully_established(msk);
 	if (status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED))
 		mptcp_pm_nl_subflow_established(msk);
 }
@@ -1430,6 +1430,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_local_id		= mptcp_pm_kernel_get_local_id,
 	.get_priority		= mptcp_pm_kernel_get_priority,
 	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
+	.established		= mptcp_pm_kernel_established,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
-- 
2.43.0

