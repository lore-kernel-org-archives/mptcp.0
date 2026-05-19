Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A812D3BB68B
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 21:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225925; cv=none; b=fq9EtoafZh+VscBzYRZ/BGXhWvoG5SOX54jukKi70CLHABcQOaceocs4IyGDb405iooDVL3JIHeMZIGpTwXTMhXlEWX+FdyIExFgAcAOg5WjcFrpdIwuOF4eqcgBaEXN0vg41Bxzt6lZwhq4QYWzGD5mrxT6s06ftyFrz3cnDyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225925; c=relaxed/simple;
	bh=mR0L5IhMzumzxywVJel6qYAyqVhXjzd8Qy6dYYVzRNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J564z7MQPV/ZYZlZrf6SlaO67OLxKbLBNmmFyQDtf8ow7ZqzYq4+z0FpWTpBupCYrm5bnMTZbJgfucE8sQBjVqSnfJpgPb1EnX6inQB357trwCxVBWQ0bfT2Oku2QXWQyeHPviKYM+fO6YsLJv/LekJP5giHLlk6/59seOABvto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBhe/DNi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBhe/DNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFAC1F00893;
	Tue, 19 May 2026 21:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779225924;
	bh=kVmzNYh7ytITgw1CMys8w0w6x9atevCJhI6CdeFkKgY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DBhe/DNiYiJSz9i5SSkU5grtMZLj99ZvngcQpDaye/YYgE1yaOM52gYBQKoSMA2FZ
	 +7TSlsxW3iONaPyHww//AJ4VZ5du/7VrHFruKhNfg5qB7DqkE/6CZYDnnXK5ERX34L
	 Q6U4+5s2EEap8b8+vaidrREDTucqJmxNkEc4RbLMs+/VmZck+9YvQEGjQNFlIS43He
	 2stFHO6Rs5iym+aZBAdNh62rNMpTCpR4jCepjj5J14MHqtDWQPJcl5v+627flNSc2E
	 UirJbcdYUoGVqnq23gmg78QhEK6/K2Q8RaGGh1COB4z96YLIOuT3TiyJW2TcToJWrn
	 FN5uzH8gQqPbw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 20 May 2026 07:25:12 +1000
Subject: [PATCH mptcp-net mptcp-next v3 01/16] mptcp: pm: avoid sleeping
 while holding rcu_read_lock
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-mptcp-add-addr6-port-ts-v3-1-bffa658a7678@kernel.org>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
In-Reply-To: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2104; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mR0L5IhMzumzxywVJel6qYAyqVhXjzd8Qy6dYYVzRNU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqDNVAVOUyf+QmSNWQKIZQyghU5g5qE52TrnfC/
 vAbdf0JoNWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagzVQAAKCRD2t4JPQmmg
 cwRtEACKr/B0l7Rfr0ah9tjab5xKsuA+MvCdDeuFT1L/Q4aF++GlsU9cspOHus1MdUHD1aCFgGg
 EhfuDwcGDRCWlFUdCqbvOTDdzYgJkOnAnBXXpTZOrnMmCePPjQj3Jlm+IwHD3JISs6VAICENoHS
 qavgCE7EHbJs3tnuJudv/jwjw0LJhCfUBTloJIBsc9gpTOHnPNuy8M5BcWJg4BR1eZykE+HUBx1
 PtUG+nkAk9mUVOV+NBR7cJHHQdzMkJuu5cziDoqznj43ymgfJ+m0DXPPJDHZcawgz51eQhJBK3W
 QUkjoPkGbDmAdyTKUMCJQnTdpXB+ceZWZuUzC1ISKLtMCy71kLs9vE9+EB3XKPPw/pN7fszoaCx
 tVb6Af0eY1+sSXbwajP71h5y420wt1rF/hI0sbZ1EKQ5+rdLMYWHLiIAIiyUA1zBFn+u7TSMHCm
 Y2PpsC+5xpLzJQLEdpoYcoj8smvshRpZqCCZW8B7UTmZYWl2Q5lCHEBoUEtD7b3aWJxY3EFq20n
 sGM/aBkiBMRglePxFXUWLqA54xO4ZIrb3yukm8ZxIovadz1e4vX/K9rW99uMRTxlAVZpGn9IsAK
 +JpuJaeggNiPOsZ3y7Nz90TM6AGtVt63BrOP2/VWCDDjGRPKXHLImPI7X4yzSKFD9okoDO9yCnF
 Db7lsCCItQdVfcA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

sk_stop_timer_sync() calls del_timer_sync(), which spin-waits for the
timer callback to complete on non-RT kernels. But on PREEMPT_RT, it can
sleep. Sleeping inside an RCU read-side critical section might trigger a
lockdep splat.

Instead, keep a reference to the timer, under rcu_read_lock, and call
sk_stop_timer*() without the RCU lock.

While at it, apply the reversed Xmas order when declaring variables.

Fixes: 426358d9be7c ("mptcp: fix a race in mptcp_pm_del_add_timer()")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
For -net.
v3: sk_stop_timer() should still be called under rcu.
---
 net/mptcp/pm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index b460b153dc0f..4fc7d648b672 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -401,9 +401,9 @@ struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id)
 {
-	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
-	bool stop_timer = false;
+	struct mptcp_pm_add_entry *entry;
+	struct timer_list *timer = NULL;
 
 	rcu_read_lock();
 
@@ -411,7 +411,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
-		stop_timer = true;
+		timer = &entry->add_timer;
 	}
 	if (!check_id && entry)
 		list_del(&entry->list);
@@ -420,14 +420,14 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	/* Note: entry might have been removed by another thread.
 	 * We hold rcu_read_lock() to ensure it is not freed under us.
 	 */
-	if (stop_timer) {
-		if (check_id)
-			sk_stop_timer(sk, &entry->add_timer);
-		else
-			sk_stop_timer_sync(sk, &entry->add_timer);
-	}
+	if (timer && check_id)
+		sk_stop_timer(sk, timer);
 
 	rcu_read_unlock();
+
+	if (timer && !check_id)
+		sk_stop_timer_sync(sk, timer);
+
 	return entry;
 }
 

-- 
2.53.0

