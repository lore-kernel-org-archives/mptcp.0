Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11D62DF68
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169893; cv=none; b=ldzFS3++f4+d37+bt6imDg0s9zEfr84AEF9J/FQrsS2kJ93O7WMAZE2W9EQHmPUwvaD5PS/CW7bGFzXxNVYqqmekxjyN/j7FUDArHabvl1uR7ildO+PdjFtXgJjPJdbjjaD7x/s9wkUN25YKQJ7VHRHtrGf6HrbkfIVYbxsSTn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169893; c=relaxed/simple;
	bh=LXkAqo7zKZtnbDTMAZcbhzqkvhMPS0aDuQPwdu2O99A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tW0BbklaKj1qZw7z4ER9vBG2t0t5bBPiueLWT/kHoyz1a+8klMXAbZPZl0tN/rYBpRsYLyGDdYLcD3RlIvU113DB0ulBPlA1s5l96CvfaWkqxVKd7ePaLLEwjepicFGXVoQYPZtAalp2Y8PJU9d/NEfmL+EC/DTf/I8eJLLwiz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQLOeP8D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQLOeP8D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984EAC2BCC6;
	Tue, 19 May 2026 05:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779169893;
	bh=LXkAqo7zKZtnbDTMAZcbhzqkvhMPS0aDuQPwdu2O99A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mQLOeP8DaAVd1ZicxPHiHvR9XmnQgHOgW5BK++aIQULfaQ8gb6MQfjQh92WMVZFWZ
	 1szrSMbDJR4JEDO0JT/EbTJe8WymnwPDpQJCY4E4ZYhd4WGMGuTuwakhwLzjEFamPl
	 E5LNxB417WzAM9OnjvahjCQIYHjmDeBhfzfaz5XaiMVAB7Rs9JWIZEE31/BPIsRCb1
	 ct16QHrZQr9+nGYDu7iQ+LRewKLjnerjMV+cJsz8XedclCrx9JbqapaaBdOtobKy9d
	 rs0TUoMMFuq5cqAd3o8VubMPzuTPwTLXSQt7i70kHOHPEbkWPSWTZdyrmkKD+28Zrj
	 d0y0v+bu9RO3Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 19 May 2026 15:51:24 +1000
Subject: [PATCH mptcp-next v2 15/15] mptcp: pm: avoid confusing check_id in
 del_timer
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mptcp-add-addr6-port-ts-v2-15-3b36a51e6a86@kernel.org>
References: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
In-Reply-To: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2826; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LXkAqo7zKZtnbDTMAZcbhzqkvhMPS0aDuQPwdu2O99A=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqC/pS9WlP7OrvRSFp7/iXpBNn3qI6JmDxIJA/r
 xS6zM7R/Q6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagv6UgAKCRD2t4JPQmmg
 czSYEADe0FqQ1igLvBrjwixLjfcDHQDNYi4leniw41nEsEjjel1QhxGFKRA01mZ/zwwuxYSqAkY
 /hR7uhI+WrLuBbqHCrGlB4MhVt3jJ0FmP0t6gG927sOEMQc+16IyEPsM8tlLYbR9s5ZcXSoGq/6
 mUytkZ+0vGHXp1UqlUDatK2PkB0EKzqHuS/jJru5blFftTPjSPwHP/RyqCcMAAYfmhUp49ydcYs
 5NbmR39Gn6hvL0YrPQFE3fr5Fk3jpnP86g32HIViLrK6V9vqVtpkHJ9Vw+eUwXG7wGLBlA9P/ME
 Tppyne3bx5TySCbZqDBdOQgiKCdq4hwZXxZYJPZxaeonjHd9ogt5nui567ahgl3+tB6N4Tr8KFN
 bImX6J0ip/L0jRkfwVuzld+KkXzMQuhx9OPbaHi/A82C7+l3gmEB7B7ycD5NJXlif25s2UXP//U
 7nhL/au4LAdts/UWz+8VfvgrxWi0X5Oz+j708GW8CeAhotg6VkQzZo+KsTPKiyzNTKKes2QbGMF
 oLhAE/CEbDaOF4M4fk/vWe4NIaqeFhP+3QBdolX/SSes64/GZQqsKZSofLewp0YwW5pbWR9z1fn
 X9BRNIIp9hg+GuYjJOORfIQi/ip7al/dhJO6mPrr0Ceo9R2OXHkW5hu/sVTDZ/O0CR/eIkt7QLT
 0WoXw+wFwE38SvA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

We an always check the ID in mptcp_pm_announced_del_timer: this check is
needed when an echo is received, but in other cases, the caller will use
an entry that was previously added in the list, so they have to match
too, otherwise that's not correct.

After having removed this extra check, the variable is only used to know
what to do with the list and the timer. Use del_list instead of
check_id: clearer that the action will remove the entry from the list.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: fix typo (check_id -> !del_list, '!' was missing in one case)
---
 net/mptcp/pm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 25826ea0a19f..3e06f3599b5a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -151,7 +151,7 @@ mptcp_pm_announced_lookup(const struct mptcp_sock *msk,
 
 static struct mptcp_pm_add_addr *
 mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
-			     const struct mptcp_addr_info *addr, bool check_id)
+			     const struct mptcp_addr_info *addr, bool del_list)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_add_addr *entry;
@@ -161,11 +161,11 @@ mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_pm_announced_lookup(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id)) {
+	if (entry && entry->addr.id == addr->id) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 		timer = &entry->timer;
 	}
-	if (!check_id && entry)
+	if (del_list && entry)
 		list_del(&entry->list);
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -175,7 +175,7 @@ mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
 	rcu_read_unlock();
 
 	if (timer) {
-		if (check_id)
+		if (!del_list)
 			sk_stop_timer(sk, timer);
 		else
 			sk_stop_timer_sync(sk, timer);
@@ -190,7 +190,7 @@ bool mptcp_pm_announced_remove(struct mptcp_sock *msk,
 	struct mptcp_pm_add_addr *entry;
 	bool ret;
 
-	entry = mptcp_pm_announced_del_timer(msk, addr, false);
+	entry = mptcp_pm_announced_del_timer(msk, addr, true);
 	ret = entry;
 	kfree_rcu(entry, rcu);
 
@@ -735,7 +735,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	pr_debug("msk=%p\n", msk);
 
-	entry = mptcp_pm_announced_del_timer(msk, addr, true);
+	entry = mptcp_pm_announced_del_timer(msk, addr, false);
 
 	if (!entry || !READ_ONCE(pm->work_pending))
 		return;
@@ -987,7 +987,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	 * let the PM state machine progress.
 	 */
 	if (skip_add_addr) {
-		mptcp_pm_announced_del_timer(msk, addr, true);
+		mptcp_pm_announced_del_timer(msk, addr, false);
 		mptcp_pm_subflow_established(msk);
 	}
 	return ret;

-- 
2.53.0

