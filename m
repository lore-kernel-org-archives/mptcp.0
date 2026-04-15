Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969202EA171
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247094; cv=none; b=MHN8Fmsm1IQzCM6SYnJhAYNexVkwtg4SSEXH18W1k3xaUMh5CXtKoHJmVZpnW1wafHemzZDVkhHLhRd3LyL0Rhjt3NIUZma7cYMIZGVKbszIZ6Lcy1oOKaFUyP4ZSkrogx5R8UmHqnmGHmhkdclNVFwvgx5n3bk57KNAPywCAdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247094; c=relaxed/simple;
	bh=ow8OvRYg7xBe9n7Ww6xKj+DPj4K1OPsCTGuhPmFSH8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IMHYKHOKoi9jjraQm13t2mhrq8ANOVAY3pAPxwND+txLwb1Imcuv4VdNaCFDZlqAYg2bPiOnN5mBmMp9QL7noduyc1QbC6PQN96D4M86SEERpbYs/eB59K/bdDV97mVrzIfF7zTfe92nJNicPeS1+ba+r3c9h9IU6QeETOXcBqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOuN+hEj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOuN+hEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4F8C2BCB5;
	Wed, 15 Apr 2026 09:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247094;
	bh=ow8OvRYg7xBe9n7Ww6xKj+DPj4K1OPsCTGuhPmFSH8s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iOuN+hEjXt9GrWbBH9mGXnVuVDCeAsFaL+38EeTXAJh6ERIWj2e6APAl45j5hi2I8
	 1bNFA0VQhOZ4MD0JK7n1g4WggdN5Ryd4XXiPHUYFw8jvVUN8luj/re+JucbCNYw5zZ
	 Uiymps0caWKGlj8vs/fCBgn81j4YB9LHry3QgGdTdasFh+vX9q/TftQjO7zaQO9BPs
	 ceCQ6yF3tV5I2XyXlzkiwQRb6IFKPG7PpkusXd1HV1epoitHlvYeBGK0tJVpD8rLJF
	 8gGX6Q4hxXCefwAv7OJG8mnL9o1ea9+9VV35xN9m2PeQ/c6s0LeYmZV1dCjozXavBc
	 3btSc40MLJzhg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 15 Apr 2026 11:56:53 +0200
Subject: [PATCH mptcp-net v5 05/20] mptcp: pm: ADD_ADDR rtx: free sk if
 last
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-mptcp-inc-limits-v5-5-e54c3bf80e4e@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
In-Reply-To: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3692; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ow8OvRYg7xBe9n7Ww6xKj+DPj4K1OPsCTGuhPmFSH8s=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvJ6p9b9z/fZ6S9LUJt+SuLRDcO6l3WoV+1ZTnf31v8
 Vx5q3QkvKOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAi7AsZGRp9bWK//37xRGLS
 UgvFd703O4XP25Y+erS6++BNFoXL+2sZGVZd/x9wlNGQddeGd0E9mfei7Te1v/jjXizL5SapF7L
 +CjMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer(),
and released at the end.

If at that moment, it was the last reference being held, the sk would
not be freed. sock_put() should then be called instead of __sock_put().

But that's not enough: if it is the last reference, sock_put() will call
sk_free(), which will end up calling sk_stop_timer_sync() on the same
timer, and waiting indefinitely to finish. So it is needed to mark that
the timer is done at the end of the timer handler when it has not been
rescheduled, not to call sk_stop_timer_sync() on "itself".

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3: support calling sk_free() from the timer handler. Note: I'm not very
    happy with this patch, it looks too big. Did I miss a simpler way?
v4: init timer_done after 'reset_timer' label to handle cases where the
    sysctl is changed in between.
v5: only set timer_done to true in the timer handler, safer and easier.
---
 net/mptcp/pm.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d3fcf441b208..0ff35f49d451 100644
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
@@ -434,6 +440,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 reset_timer:
+	add_entry->timer_done = false;
 	timeout = mptcp_adjust_add_addr_timeout(msk);
 	if (timeout)
 		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
@@ -454,7 +461,8 @@ static void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
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

