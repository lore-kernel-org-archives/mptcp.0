Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4979234D389
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 05:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169877; cv=none; b=aogNiEAA9jV+TLpOZI/krFIatq+xy9WA6rtPYxVFQgJ4mqDQptbi9AwJSx1u/LfnYuwDcaaBAS/HhmXRbaXQIHYAGmbzy7Q441R0UJqQLBv123sMssw1W2aC4IIiMdTsYQ6mW7hx6ARJbvrluxAA2F5fQLii4lPWBVNoDyBVZTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169877; c=relaxed/simple;
	bh=n4GKkhlcFdAsynPMvsd4dz62FjPXn4HCDMmHYQbI9OY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WetbUCwF4029sICIuNR8Tx7DmrrN37Ht6lcrgNdIncpi/X4OavqqE6qKoO0pBVOmwwIRrJu6Hr1sn7B7aKl0CpGOpDTF1SD58CqO3/FppqmQuQ8TB6odrEofqWnOvPhoSD/7hWgCvEhRMbh3hceCne+oZg0b7nPIboNee6/vSHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jX9MWURb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jX9MWURb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D90FC2BCB3;
	Tue, 19 May 2026 05:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779169877;
	bh=n4GKkhlcFdAsynPMvsd4dz62FjPXn4HCDMmHYQbI9OY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jX9MWURbZy/KdKx7H/Fo9N8n2VjfxrRe0JZZ2QXjeGl0CAs+5jiB0vtwIyOYwiJwC
	 lK0FkBkAP/OvsIRTFV3XMduYKkmEu4j7U2hf2/vmWF9f1NCM8Wz9pyeIFWmNHmBu7m
	 6IvWDJl/lrwx++pQgTpHh/c+ejJ8+JUgpmQORxHcUuarIicWfjdxbLAx932q11PjNw
	 GGkLquJCvGP0ySmvYApMti7r9GWZuShry5MWSvcCC0NrrNMs4Nzf+kV90tUsGWHm/C
	 fByPCVk7L3hIn/Z73oUpnE+EAvIr23aMe9LJgh2zZb+CLPaR6QHfyzQ9YNWTuSEIcY
	 nn6YdCFuu1ZZA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 19 May 2026 15:51:10 +1000
Subject: [PATCH mptcp-net mptcp-next v2 01/15] mptcp: pm: avoid sleeping
 while holding rcu_read_lock
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mptcp-add-addr6-port-ts-v2-1-3b36a51e6a86@kernel.org>
References: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
In-Reply-To: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2030; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=n4GKkhlcFdAsynPMvsd4dz62FjPXn4HCDMmHYQbI9OY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqC/pSrj7Vvm0WBjG4H9g4W5UCGF8OIjpVzh+4V
 yFzKIQF+7+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagv6UgAKCRD2t4JPQmmg
 c/mLEACXXisk1S1WzDbczB+eT9p/bBjEewL3/zXLR5wdFk81ypq2KBigXJ2xCoF+tc/uwqx4Oq4
 5kwv/w3vazLYr7Huzv7T6KEcMAfpmOzq5LKfenqA14tfuwXMRGybW+eoBMq+zzwLhBxF3MneSaC
 rX9Zq5tD8pQvZIEvJQx+jyP4gldd/MaeScE5+Ma7DO/mYzY3iVMmdJkZibzrMA16kOMn027uqMU
 uqzDJYVM2Eig9J8qyCzLlk8KoydXPHepD992xmawxATEOCYqCiMIBdbfqCNGMgXP1fV862kNNht
 2t6+GdRV+T0PpZrIr9TVsqiQwq7uo9XMPTd0wnnaHARmQcNmslboILHjFbyR9wcJMbx3JY+n8Ys
 rgQydJ6vKV9nXaL1pWyFDPgchBdL/h5qgouCG6MZMC+TArDzVu5bZBq+zhansLtTf9bd2uis8DP
 gPtqKTxuXph1P/ju+o/bEo17+JURU3SkNZoJhNqMHm4vyTWUUsCnmcWlqk6eH6tghOx+8sVk95z
 ZsbiPmBwo92C6D5HyWlrdi+p2U02qj9puQVJjdcUZ8sFHo7vzcFM3D2f+pFg+4Ksar+niapTzLO
 ZiObwd7WG7rhbLFqj0mqsXGjpSc2v5vg7d3Jhxdh3n6p90pY8lFjaWNWIsky7x/PCCEsMMYPdU9
 hhezcpl7ii09q3g==
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
---
 net/mptcp/pm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index b460b153dc0f..ba58d057d040 100644
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
@@ -420,14 +420,15 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	/* Note: entry might have been removed by another thread.
 	 * We hold rcu_read_lock() to ensure it is not freed under us.
 	 */
-	if (stop_timer) {
+	rcu_read_unlock();
+
+	if (timer) {
 		if (check_id)
-			sk_stop_timer(sk, &entry->add_timer);
+			sk_stop_timer(sk, timer);
 		else
-			sk_stop_timer_sync(sk, &entry->add_timer);
+			sk_stop_timer_sync(sk, timer);
 	}
 
-	rcu_read_unlock();
 	return entry;
 }
 

-- 
2.53.0

