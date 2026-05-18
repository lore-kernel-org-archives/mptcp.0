Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B643290A5
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109172; cv=none; b=JvutPu/MB5R7U5Q6KVoVc1ev5MXwFHK9TnbYBRudhnF3cnUG1scZX/k9WI6o/SguKEMpXdzPiMu6bJ7jeZizJHTawK3R9WOuaZQgrgCdezgi+iiNShFVcI9Ncnnl+OJGrAf+bcc7y739NsaPmH14wlEGEG0Emhk/KVs1e4dZaCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109172; c=relaxed/simple;
	bh=hQz6YYZ+kAYwhqLrE1+Fab1nAo3HVOULmc4Cy5jqbzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a1+Viglx6u9g380MYTJbH+uH8WS4Z4n+U/RyU/t7Va+Nm8apiD26D3PKwe/0iRPJhQCdAcjYTu8mb3N4Mew2H96Z9fZU5NrJE2+E9KSzmaLV+hD85r+mKv6K3cmk4z+sj5fTkZPXNiw9EyDjgygswn8AGRuVSPA/bAkpEkOu6rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmGUHyJ6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmGUHyJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374F6C2BCC6;
	Mon, 18 May 2026 12:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779109172;
	bh=hQz6YYZ+kAYwhqLrE1+Fab1nAo3HVOULmc4Cy5jqbzc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YmGUHyJ6bGXqXADZfkgrcKsKF1rYUpJweaW0qKuqcgbyFgQ/jHR+KWlvYElPq5SEl
	 /cOyDINQFWYRTW13zG/Y7RTts5iqejtV2zEle3aoDM6L1U8tPHVt6QTolhXYF+FzuZ
	 Kfx5QFtsLca3SrhuAoKuaLga2jEWWr6sRcLm2N3bKC+W/lRQiCU6eovxU7nFB9hV+4
	 Vv0Ajyt0lufGdDp1kaAQ+32RNhPM3Hp9gdyR2iHAagok5Kp+1RPtEyBg0PJozT56YG
	 LEQp08OF2+b9Y4MQDRvQQMW64Dflt+XO7pLRVzMc6Y1M4JYEJ0knCDUYBbqak5ZuRu
	 NIc6XFs0WAzow==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 18 May 2026 22:59:16 +1000
Subject: [PATCH mptcp-next 12/12] mptcp: pm: avoid confusing check_id in
 del_timer
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mptcp-add-addr6-port-ts-v1-12-f1ca26977fcd@kernel.org>
References: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
In-Reply-To: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2818; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hQz6YYZ+kAYwhqLrE1+Fab1nAo3HVOULmc4Cy5jqbzc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqCw0hmgykSWGCdrGPj2TJOJgLvYBEFlKck3Y0z
 BPY8iDjeYaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagsNIQAKCRD2t4JPQmmg
 c3GvD/0czQUTeheultKM4XpKswgfRvgnNbwmW6oVk59nuw0YNoN/qikbNXTbyFmCUBbF9VOTLdU
 mdVZa92ZVwmkCmgDY/uD+sSl2+qRpmytxzXzld+sEmaIrx8ydJE3j4Yp1JYVeg4s/NITwQ7/Vu6
 StGdBkQN3yP7VkRY55ImZoRjdhKYUKVJf6gx6+zjeQAQWeae9k8dgCXoFYMH0SEEgCgn/Jkb/jw
 6t7j0M56jtdtN43jFzvdA5SA+NuBwVUL0931eA9bFeTankB0L0cEiHG0T655bhx7Bc/Wq2/Scfg
 KsASp2MOgsRsDc6IunZUisMZRGxhMkK18xvqm0aDpe75rCghnUZdyFcCESuv5xnXkX8FSKdFgZ+
 OCIzjdN/TQ/d3kr48KwTqmUEI7OZHldcugOu4NP0DHoDtSF/jjPz4T4wr7uzwTZr+c1QJDEZPMT
 jBlzYbOd8pJEohFY9IXnMuRu/oopJYiEJtgrgU6XgmT8hQsV/dbBfkMS94ifLp+/9aCt+AVTFyu
 8Ray+ZQMqPEvWnAgB9mfrM1KaBUwgCfud/nZ5RJn4SUYZb3Bpku6S+RkS30BZrfKOU8mKyZvirg
 aLvvTb1BYXEI4R2TKkfjSCZcpZlie/U/I1kiCZxAHXIMH17WqXZYDn6dN+tWiYzNiFDuo6WW+ZP
 1kwkPUjwHELy2hQ==
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
 net/mptcp/pm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index cf0a7b44e3ed..5b4aad2a2b27 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -151,7 +151,7 @@ mptcp_pm_announced_lookup(const struct mptcp_sock *msk,
 
 static struct mptcp_pm_add_addr *
 mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
-			     const struct mptcp_addr_info *addr, bool check_id)
+			     const struct mptcp_addr_info *addr, bool del_list)
 {
 	struct mptcp_pm_add_addr *entry;
 	struct sock *sk = (struct sock *)msk;
@@ -161,11 +161,11 @@ mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_pm_announced_lookup(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id)) {
+	if (entry && entry->addr.id == addr->id) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 		stop_timer = true;
 	}
-	if (!check_id && entry)
+	if (del_list && entry)
 		list_del(&entry->list);
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -173,7 +173,7 @@ mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
 	 * We hold rcu_read_lock() to ensure it is not freed under us.
 	 */
 	if (stop_timer) {
-		if (check_id)
+		if (del_list)
 			sk_stop_timer(sk, &entry->timer);
 		else
 			sk_stop_timer_sync(sk, &entry->timer);
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
@@ -985,7 +985,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
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

