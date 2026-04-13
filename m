Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B73D75C3
	for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089530; cv=none; b=hnOc0qe0bd98WwdFChFU6W2TEfaUK00usJNOAn2BPWKMdjxsE6IpaSZTSHKSn53oZxOFDD+Sr2u/c96GJrKe+3muvvFrjMWRO9NoCNYSdn08KN2OyEJNeqZKAgZ+GOvTTS0zFHcWlR61GeKav/gRY5dgCw5gu+QYH0XIh/VeQic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089530; c=relaxed/simple;
	bh=GnVcK+k6p55UYcQNlYBgs9oGPxvxqm9Qo+2p6Q0pZk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p8/ED6r4SkEl5Hn1WTE2XyYFEV93K6s5ORrc93JdSDtqlrFDln95eEDl7AuwRGPwRN4jwQkrxAxT6yULM5V7fAZwroquIOo132k4CWzRMeh1ApdXuAUkURR8uTHxU1mxtMhkm929Kz0sq7oquxIrNsGO60Cm4+7fAZQTIz8qm7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzr9WIjH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzr9WIjH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1FDC2BCB5;
	Mon, 13 Apr 2026 14:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776089530;
	bh=GnVcK+k6p55UYcQNlYBgs9oGPxvxqm9Qo+2p6Q0pZk4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pzr9WIjH4IpdfbLzwB3ebofO9oG8BoeuHaZVLsUrc3iFEUcf4aGnaSdKBOF0DVOwX
	 Wz971RssjvJUC48DpkxW6wKB9/KeDPYrGTzQtidyHT3kpTCn1vrF2CfyVR44HmVenV
	 GbVcb9jGgRARH7V5Vz3jfTGuyK38JWzEy3RS9cjP4C91keovn8uhJ/w7w+NW0KMbpA
	 zZE7N+JFsPB/L2sRaWbTSpCv1X0ipt0sV70rS1QbW0LArYl43zsP92o9KM5pOEam1d
	 onIJwHMVtnCjv7FfrHCfoflBmsNBEPGvmJjc+MtiZEhEGvMLFEllfK8UG8tiWuOso5
	 4e4LEQaVSMVDQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 13 Apr 2026 16:11:51 +0200
Subject: [PATCH mptcp-net v3 05/19] mptcp: pm: ADD_ADDR rtx: free sk if
 last
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-mptcp-inc-limits-v3-5-dd36c9360432@kernel.org>
References: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
In-Reply-To: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3597; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=GnVcK+k6p55UYcQNlYBgs9oGPxvxqm9Qo+2p6Q0pZk4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLv/FzN8tZps44tz4GrR5yE9J1eH7s5d8p37nUHg7d1L
 JK6qPO6saOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiHqEM/9QO2y1hORZ7Y++7
 VX8KF5+3a1j42/Dd022/z9yPOPDk8ZrHDP8rTok9jbXXDFPunfAn8fVZiQmFcxV3d7UvyotV9Hg
 1czYPAA==
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
---
 net/mptcp/pm.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d3fcf441b208..adbebf46dcce 100644
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
@@ -431,12 +437,15 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->addr = *addr;
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
+	add_entry->timer_done = false;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 reset_timer:
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

