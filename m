Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D172A548EE
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024922; cv=none; b=pBp8CmAaw1FgoO794ygldL8kT1nDvwZzw4lRim9DHbelWNkF2hjcVkuxyxhGRAdJmKWenNlktnh/BtE//ZaAkGFz8+x+SZ1QDhO+FJX5yQ3vHrt2fW0w1uJJ89O1zPkHjis4Rf2YnSuoR/15IrqQelPWDDrH1iv4XwKMb68CuJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024922; c=relaxed/simple;
	bh=lJGGm/Kdxb1DLcUzj7sFX/KOoBTXr86KZoluUkbaq+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TN6UhrVa40OulSapEmFFF1NNkIvWnMuZ39XdebpD6vR80HXlE21TCpl8HSVZJJ3J2hsFB9lifSuuWx70FAFmTwaqMhUTVHl3b5vVqwOdvhH9m1IFSgNOmc0GrUyBPFFPLAmU5E0iRc3dPriu7CMDqcv1WK5zOJWZhMJHbhwi8cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwcC5J0N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwcC5J0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001451F00A3A;
	Fri, 29 May 2026 03:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780024921;
	bh=Vb2dUnvubTYp4bbzZFQ6tugxo8Si6uZKEbksX61wpjY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cwcC5J0NfJqP75YXw1OflgsZVDiNf8AGk33YZ57j9wKSj1qhk6oY9BhlPUAzFeq+G
	 TcHz+vMiaxfuvNoEBIcMKZ51Viud3vFE60hnpWMxW9lIaknPG+OeU2qaepdkICzpIH
	 /MSLE1IW6qhf9s9416ySTtwc1VrWQPZgt90RD+rdbDPVpQuORU2RYPaJCat+1ZGzAL
	 SN/fkG9L3HGprb+7Y5fodzeOKWW7Jl1jRCGzk/ShFlUFsTI3LpZx78TxQYBozd9dw6
	 HE21A9riaATUhC4qPQ3chLxf/tBq1XSybkEYNkk9drm+wuOacP56Q9S6uKVBlWj/JN
	 Ond7dWuKBVnIQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 May 2026 13:21:39 +1000
Subject: [PATCH mptcp-net mptcp-next v4 01/15] mptcp: pm: avoid sleeping
 while holding rcu_read_lock
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-mptcp-add-addr6-port-ts-v4-1-cea393fa33a2@kernel.org>
References: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
In-Reply-To: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2104; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lJGGm/Kdxb1DLcUzj7sFX/KOoBTXr86KZoluUkbaq+I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqGQZWXIQBgxXUV6ck/NNNIinH8+qui3kxbrwkQ
 i74BmyMOqSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahkGVgAKCRD2t4JPQmmg
 c+rQEADb3DDB3hFYguNItpCjv3co/8ooIBOVPPVM9fndEA46DYa1KhGuTxMViFTKhijCrttVPiG
 QcyzH7Mm07Qq5r8G2x8fCqMonHoBKZTrRryqQgjSUUDX6rld/8kgctkhlPD5E5ZJWwjvKyPsD4i
 ASjDz0QUU9h8MiSfLq5fFWLzj9BHvzM8x5t3T1/IzTlr5h2DfUr8iECplIRlV0DlMWwoDzP4CJM
 X7gc1RJnHfk6hi8luIyLmDQJxZVfpHs/Zcwx/FRpM7omcBJzpFkvVZziC4qlEJ3su88+vjAmdY4
 PmSBKEhzLlnVgWJhrqJjWRWNaiPYNoF6LIcZu71fXA7Af57f/Dr8JMNpWb+sxO7WNeBRlMlNya8
 bXA1tzY3sH9Q9bBWouHkYN8QNwR+M36VzjRqEQusxCSJ7cia8G9tAx0g56CcjXHiaGDwhAmvXSk
 U+Qn1xhEauuMnRGPALjsjkWap6HZDOaxDYK30ETyQC0n1fYaBKa4r4ancjvXwphyYYUc9t7zUUq
 YmFVlcuXKjbki+wqch5GghxBxCGlXn4GH/80dde0KgvkkqCLw8N1JMdenHWK7OUXBqwEtJrhc3d
 DHIUgdNLvxSjks7t5/mBow8+vXNULYPQWr18NW8+ftzUkFycYBcFjct3EdCvLEg9h1G0LDietve
 2ytfMTjDBj36o/Q==
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
index 35427bee2963..851f6886ad23 100644
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

