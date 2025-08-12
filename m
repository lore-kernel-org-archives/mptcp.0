Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5681A2E7639
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987965; cv=none; b=USfHUkV6b5U/rgxnedrNNS2K+AP+nvDujB/ZfFDIhITu9OAABTdCq7z6L9hroDv/d2NgC/WpKW7cGU1URbCXJZHM5ahYxDShJIrFIXZVAk1DajL2Sg+1r10KGgH9rfJ1ExK2Zsvtcin5dBarat/Vfr6pBZ91aJNpDAjf/5DqPuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987965; c=relaxed/simple;
	bh=D2LN6TLti854X5Liyc1EgMclQyJKV3L+RA5FxoC3LdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKSjfFaTmpqrUTCIL6yC/TZ7Oub4g1x7YffCXijvFkQB8219gunguDHfHKCJFf05NdEgRJi9hYcfj7YnCXYElVPPP0HMlCBc5DeJzBHm7lFN4lpQc97/q7E8f2tTO4YnK4rjTDxTwxvFEsaZiuSRpBMaRdVNNC9FSauwLWzlv+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw/Xf0I+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw/Xf0I+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45C7C4CEF4;
	Tue, 12 Aug 2025 08:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754987965;
	bh=D2LN6TLti854X5Liyc1EgMclQyJKV3L+RA5FxoC3LdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gw/Xf0I+h+/HfvQ89UsdbDYG+OuKN4Lm7zobMoOvo6Q/lo869cq8lAGkdD0rPr6aE
	 QyhoLuj7FI/jiXGSuFFCXJI5q4pmQyifrpdQQnHuFWSuBmh2SqqxZDFXSResOkbn6D
	 rQ6ZBeC/evu9rJrroIVNJAuIwmHiyG5WunG9JiUYxFSWa3yczdKORiVGwpREm8keCT
	 1D7yr+QN6yE4QkAAU3Gd8WuQmn3Xj6tOGvzjzhvlNle/cu3wnHnwKtuvn+ZQsn4/Nq
	 QlByIMt6b9Y/VyL4LkExkUqofUXYVyr1wNK56XO9BNfIU90771itmIhuTf3h5qLvJZ
	 xEbgCbeVtDdAA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Christoph Paasch <cpaasch@openai.com>
Subject: [PATCH mptcp-next v4 1/2] mptcp: make ADD_ADDR retransmission timeout adaptive
Date: Tue, 12 Aug 2025 16:39:15 +0800
Message-ID: <a0d3e4caeb991f06de2ce2692b4c00c57c0460e6.1754987655.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754987655.git.tanggeliang@kylinos.cn>
References: <cover.1754987655.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Currently the ADD_ADDR option is retransmitted with a fixed timeout. This
patch makes the retransmission timeout adaptive by using the maximum RTO
among all the subflows, while still capping it at the configured maximum
value (add_addr_timeout_max). This improves responsiveness when
establishing new subflows.

Specifically:
1. Adds mptcp_adjust_add_addr_timeout() helper to compute the adaptive
timeout.
2. Uses maximum subflow RTO (icsk_rto) when available.
3. Applies exponential backoff based on retransmission count.
4. Maintains fallback to configured max timeout when no RTO data exists.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/576
Reviewed-by: Christoph Paasch <cpaasch@openai.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 Documentation/networking/mptcp-sysctl.rst |  4 ++--
 net/mptcp/pm.c                            | 28 +++++++++++++++++++----
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 1683c139821e..2b8e8fb99ee2 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -8,8 +8,8 @@ MPTCP Sysfs variables
 ===============================
 
 add_addr_timeout - INTEGER (seconds)
-	Set the timeout after which an ADD_ADDR control message will be
-	resent to an MPTCP peer that has not acknowledged a previous
+	Set the maximum value of timeout after which an ADD_ADDR control message
+	will be resent to an MPTCP peer that has not acknowledged a previous
 	ADD_ADDR message.
 
 	Do not retransmit if set to 0.
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e6dcc5b62645..02dfb379417e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -268,6 +268,27 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 
+static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
+{
+	const struct net *net = sock_net((struct sock *)msk);
+	unsigned int rto = mptcp_get_add_addr_timeout(net);
+	struct mptcp_subflow_context *subflow;
+	unsigned int max = 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		struct inet_connection_sock *icsk = inet_csk(ssk);
+
+		if (icsk->icsk_rto > max)
+			max = icsk->icsk_rto;
+	}
+
+	if (max && max < rto)
+		rto = max;
+
+	return rto;
+}
+
 static void mptcp_pm_add_timer(struct timer_list *timer)
 {
 	struct mptcp_pm_add_entry *entry = timer_container_of(entry, timer,
@@ -292,7 +313,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		goto out;
 	}
 
-	timeout = mptcp_get_add_addr_timeout(sock_net(sk));
+	timeout = mptcp_adjust_add_addr_timeout(msk);
 	if (!timeout)
 		goto out;
 
@@ -307,7 +328,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
 		sk_reset_timer(sk, timer,
-			       jiffies + timeout);
+			       jiffies + (timeout << entry->retrans_times));
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -348,7 +369,6 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
-	struct net *net = sock_net(sk);
 	unsigned int timeout;
 
 	lockdep_assert_held(&msk->pm.lock);
@@ -374,7 +394,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 reset_timer:
-	timeout = mptcp_get_add_addr_timeout(net);
+	timeout = mptcp_adjust_add_addr_timeout(msk);
 	if (timeout)
 		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
 
-- 
2.48.1

