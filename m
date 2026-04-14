Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C688E146D5A
	for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173655; cv=none; b=GfV9PKiFvkc0rMBp+OAU4bTsqpEpfBiYZHw5BrF0PBpA6hQKvdagI8JhX14Oxz+WcQozX4K+iZq3Ge0frn3kA7nISK3lEdMHJYbqsZzcOJPbO0H61iPIkZVcAwKPVa+e+TaY3R57RTyxY6rShlOCAip6KA+LkH23ugsJhT4ITzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173655; c=relaxed/simple;
	bh=FRPidl+H9O8QOhm3CdDUKERP/ZpJ02lMg4zW9sxFL2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a2dlSPxUHM/i0A1k9hUp1vw1hPrE12lDwYF1rQ48wBymNF1yefPcPwWNCVA8oa7wS6+gRt7H2o4EWU8zsL80UwAdWq1k2V+xlbw3uIi5yzk5oPrZ9gQWreRRFlS6x53vVkX6xtzGsbmN7GWLmYCU3B4HHE4BkV1CVgrPKZqSM2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NogiKGbd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NogiKGbd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3592EC2BCB0;
	Tue, 14 Apr 2026 13:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776173655;
	bh=FRPidl+H9O8QOhm3CdDUKERP/ZpJ02lMg4zW9sxFL2Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NogiKGbdDFHPtcxxgBy9l9sS1awtAV7UtNRmr3LoXWA0tT49zRw8jjZKWIEqICAEt
	 tlSPa4SbnXln0H/gDF3NucKXW1OnmPP/Ej+jXOThMbogfNvFZTWtGTdjb7FLtxOmoS
	 r9Sxtu+KQtN7+ILk5XtdWvcAX2Miyrcbd+T1I3vnBKGxrmw6ZJtRnmSPSM5aOlPffr
	 qUrAAsmt11ihPwybzuvX4cZhMGdNT+bQVY2CoCifpaN5Qf2NB0ZpcQIAkJN/zovMRT
	 xROwNBYa+phMFhhyCrEHotbkkv8fnG3Z9OxK2nPgSdEgML/SzRVM89ptF4DEZX/RNr
	 wiAAs+dZgPMSg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Apr 2026 15:33:58 +0200
Subject: [PATCH mptcp-net v4 05/20] mptcp: pm: ADD_ADDR rtx: free sk if
 last
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-mptcp-inc-limits-v4-5-78274edda5dd@kernel.org>
References: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
In-Reply-To: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3617; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FRPidl+H9O8QOhm3CdDUKERP/ZpJ02lMg4zW9sxFL2Y=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvOXmvP8N47tzH/qfLivbbuc78Ga1m8M+n5daPVxLrQ
 la2HE7d0VHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjAR0wJGhmli/em6Odrz35l+
 u56o6+sq0X+ml+9ZmP0aGYa4DmeVpQx/uGPcnact8H7l/j5s2tyS/8a/o3m2/F659l5koanQsak
 ZjAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer(),
and released at the end.

If at that moment, it was the last reference being held, the sk would
not be freed. sock_put() should then be called instead of __sock_put().

But that's not enough: if it is the last reference, sock_put() will call
sk_free(), which will end up calling sk_stop_timer_sync() on the same
timer, and waiting indefinitely to finish. So it is needed to mark that
the timer is done, and no need to call sk_stop_timer_sync().

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3: support calling sk_free() from the timer handler. Note: I'm not very
    happy with this patch, it looks too big. Did I miss a simpler way?
v4: init timer_done after 'reset_timer' label to handle cases where the
    sysctl is changed in between.
---
 net/mptcp/pm.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d3fcf441b208..e477f6a7a740 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -16,6 +16,7 @@ struct mptcp_pm_add_entry {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
 	u8			retrans_times;
+	bool			timer_done;
 	struct timer_list	add_timer;
 	struct mptcp_sock	*sock;
 	struct rcu_head		rcu;
@@ -327,22 +328,22 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 							      add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
-	unsigned int timeout;
+	unsigned int timeout = 0;
 
 	pr_debug("msk=%p\n", msk);
 
-	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
-		goto exit;
-
 	bh_lock_sock(sk);
+	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
+		goto out;
+
 	if (sock_owned_by_user(sk)) {
 		/* Try again later. */
-		sk_reset_timer(sk, timer, jiffies + HZ / 20);
+		timeout = HZ / 20;
 		goto out;
 	}
 
 	if (mptcp_pm_should_add_signal_addr(msk)) {
-		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
+		timeout = TCP_RTO_MAX / 8;
 		goto out;
 	}
 
@@ -360,8 +361,9 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	}
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
-		sk_reset_timer(sk, timer,
-			       jiffies + (timeout << entry->retrans_times));
+		timeout <<= entry->retrans_times;
+	else
+		timeout = 0;
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -369,9 +371,13 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		mptcp_pm_subflow_established(msk);
 
 out:
+	if (timeout)
+		sk_reset_timer(sk, timer, jiffies + timeout);
+	else
+		/* if sock_put calls sk_free: avoid waiting for this timer */
+		entry->timer_done = true;
 	bh_unlock_sock(sk);
-exit:
-	__sock_put(sk);
+	sock_put(sk);
 }
 
 struct mptcp_pm_add_entry *
@@ -434,9 +440,12 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 reset_timer:
+	add_entry->timer_done = false;
 	timeout = mptcp_adjust_add_addr_timeout(msk);
 	if (timeout)
 		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
+	else
+		add_entry->timer_done = true;
 
 	return true;
 }
@@ -454,7 +463,8 @@ static void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
-		sk_stop_timer_sync(sk, &entry->add_timer);
+		if (!entry->timer_done)
+			sk_stop_timer_sync(sk, &entry->add_timer);
 		kfree_rcu(entry, rcu);
 	}
 }

-- 
2.53.0

