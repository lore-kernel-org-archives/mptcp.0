Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6283E835B
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225946; cv=none; b=DJOtQLN3961xqLlEFyZ2WAz8OFkxNYr97gXmQkzr16JlvDWiPz/Q7YzlbaFBWy3aS8a6suB3zHGOp1zVBuweqY9z+7uUEylrYRA6FSPlmFbV4lRmXpMr9lR8dLrpQ8WECJ4aSQQJ1RshU956+GxEDOGRrZ9O0MGrT+B9cyj3tnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225946; c=relaxed/simple;
	bh=VirNZYsHxD2lI4CIKqHH6zJxScxSxlXM87JWQznKJDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NtSU2ga8bY5oqH7uTcHOUdwnUUvpgOCNIei076W9CznnRnkm8UKyCQGrgxm4AsOMfkKr+B4LPSsxOiIO1AAIYOmviOCYLKsV1QYcPePp4sVkgHAAedcjHAss7hY61KmkuZOzg298pj1R/sbvz5vpIXCZRHeKBtX05K3+hWbba00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO2uJ1sO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO2uJ1sO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF4F1F000E9;
	Tue, 19 May 2026 21:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779225945;
	bh=8RzvkXX3ElK29UwnS8pi/rAEEMB6/RA2ht9Q2AnYwPo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NO2uJ1sOf10Pf0Fz/pfHW50y7ZPLB25ZlD/LDtZRwmHUk1P5d4PHxLv7JhGnM0UQM
	 gK0EwrL0qhK1ORQdLhl0lkjS4tfniB4F7ZOdXK/ApYp1nh91bXRg9zdtVmbZlYstCF
	 ZQGNO7qthwTtn3FlqvXwgdVQbMNWQmk5mzFs+fwW8nObKu5h6OQSG2hY7y9pFt3er2
	 PP/FqTUih+S06/I43duyCHh0QF9b4Zh+UZlCRXBmdQgQGQx3wuqT0qsIhmXCwAsPKD
	 L4SuW//Nz1XOFcyLAsLPHc87UYPkzwYnryB0/L3qkBFlAiSEynaAxe7DXi1S01v42e
	 /eAiMGJ1VOF4Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 20 May 2026 07:25:27 +1000
Subject: [PATCH mptcp-next v3 16/16] mptcp: pm: avoid confusing check_id in
 del_timer
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-mptcp-add-addr6-port-ts-v3-16-bffa658a7678@kernel.org>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
In-Reply-To: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2953; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VirNZYsHxD2lI4CIKqHH6zJxScxSxlXM87JWQznKJDc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqDNVBtv/nzHfbqjLRsri8Tk2pEVeCmU5PNuvlX
 THHaWHfmFGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagzVQQAKCRD2t4JPQmmg
 czn1D/0TrJnrzsz2Numu8lNhfKn6VhDxkr+vjalxqpgb02G+Ml3BW2Ju98W020YVIbJqRvE7jmX
 c9cOnJcjCVvbjRWp/lEcFR7YRu8S/Z9f+q630OK+tBlC6VVflNHGfYvfGkCzuYYNXggrglsrT7l
 WPSQtMThA8JzNiZaI6gOCcZ5nS+bmp3NL+Z+F0orAu7RIjYkAiOUVYzKsVnQ3oCWVMVDlWapH6F
 lcTrP6qPybExoSScX7tEI1qsWb0ZTiLs5M0/5CxYn3ZNklSJanOV833VoYpbsLIOXiSU5CQrefS
 e31GzTatCI9TiDB5akYfLz2XermPwV6NMWB6sz2SFdrMlnSaCIFRAUWOKXNHCcbjAi2DMEtx4Iq
 MZuKhndg1DHJRrXarFNjkU48O4gVoW+PaQTnL9AAkRKT0lnisKKeaqM9pKi+J7hEwChUEHtLAxu
 BEajE5X1/xHE54vSwB/gvBIpOkYqf2vPS6U/AItAsHEERgy5PP3BHPQyiDhJ8Y71/NVQSlkJNh6
 7iGFcaB9MHdm9qgja37OT4G4HsjpF8BaKRznUWhLnAAt826ouzCK8s7EEA6YeTIPsP6bGm3o3g7
 6QEhwXYWga2Q9SFNJGXubcnlBFISLjcZNhsBqdm5GyL61yZsw/c0kzhhF+9dKTEcIDiDSFTnEnL
 fB7DYyJkUhsX19g==
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
 net/mptcp/pm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ad52dd73d7e8..411893c476da 100644
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
@@ -161,23 +161,23 @@ mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
 
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
 
 	/* Note: entry might have been removed by another thread.
 	 * We hold rcu_read_lock() to ensure it is not freed under us.
 	 */
-	if (timer && check_id)
+	if (timer && !del_list)
 		sk_stop_timer(sk, timer);
 
 	rcu_read_unlock();
 
-	if (timer && !check_id)
+	if (timer && del_list)
 		sk_stop_timer_sync(sk, timer);
 
 	return entry;
@@ -189,7 +189,7 @@ bool mptcp_pm_announced_remove(struct mptcp_sock *msk,
 	struct mptcp_pm_add_addr *entry;
 	bool ret;
 
-	entry = mptcp_pm_announced_del_timer(msk, addr, false);
+	entry = mptcp_pm_announced_del_timer(msk, addr, true);
 	ret = entry;
 	kfree_rcu(entry, rcu);
 
@@ -734,7 +734,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	pr_debug("msk=%p\n", msk);
 
-	entry = mptcp_pm_announced_del_timer(msk, addr, true);
+	entry = mptcp_pm_announced_del_timer(msk, addr, false);
 
 	if (!entry || !READ_ONCE(pm->work_pending))
 		return;
@@ -986,7 +986,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
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

