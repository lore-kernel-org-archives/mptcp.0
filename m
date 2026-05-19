Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF522D978A
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169892; cv=none; b=Y6LhxNjnjKQCUwfTAU0EAvLLKK2S9YCPI7wqP2Eg3WSSeqO9MOBwRaGr60w11QVehTkMe3C5PymHp4ecqcXZ1d+T2jbrEvgc5zSCePtbFfLAKuZrrrmKpmjyfNC33gSlFkR49Df7jwSsC0+mHFFSPd5FoRTMfW2XqvAE2EtJc3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169892; c=relaxed/simple;
	bh=KH8HigeWBtmZ2tI5nMYw+oREZqs1iEdOC3vav1hS2vA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fhuNpuIc9BkOcxVkCf8Hq+RE6INzihvdPoF7H1UwK1N4UYfuw940Af8u68JEagjKmRoYf/vPx04S37kGP/ZKygaqd/xjmRYU5AlqNwc35k7HFv/ZSLVstAjBD/4L6OsOytQ7uhmGh3GAU8fk7MXLYMTxLIxFuov5aacopMwFIUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mas3mp1f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mas3mp1f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719D6C2BCC6;
	Tue, 19 May 2026 05:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779169892;
	bh=KH8HigeWBtmZ2tI5nMYw+oREZqs1iEdOC3vav1hS2vA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mas3mp1fYmxF6KnQUFG5ok4UoL/dud/plHG9vzEB9mxcD2XM2OKtJjz44wA4Gl2Qz
	 +kM1m7n5zd6w4AYaU/9DGHl9Elbnh9aCBE5S53earIVt/emZ6UHXlv02snTTnnyt/q
	 CCsZ0roRCzdD9pq8n07Wc9aSc/kLIuYh7J+bwTgHUY3j/gWMlwKXiyAas1xOYrnKFG
	 Y85PgREWO6/yNqGQUid9TR1m0NkdaPEQO2qrQdhDRIZr9fqawqnKoLOdM1TbL3eUUN
	 Bn+7Dl2XV9Y0LQxqjbaZNej91Z/V1QG/U1gESmm8TyQpvk/4g+CIy9FqjFq+DD1o/X
	 JTdV8ZXnE8o3A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 19 May 2026 15:51:23 +1000
Subject: [PATCH mptcp-next v2 14/15] mptcp: pm: avoid using del_timer
 directly
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mptcp-add-addr6-port-ts-v2-14-3b36a51e6a86@kernel.org>
References: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
In-Reply-To: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5273; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KH8HigeWBtmZ2tI5nMYw+oREZqs1iEdOC3vav1hS2vA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqC/pSQsfYGJoDuEuVAUMP9m7oiwJTlJXkoWwfX
 PK5GF/lSYOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagv6UgAKCRD2t4JPQmmg
 cyMXD/954I6oxT6D6OLkjbK1tSr+cpmRj1YKb955IW13ZZG6XrFRU8mnfj0yvkbnq8G7hTVVc1K
 SFNXItJ+YOaebFj/BDzY0iLTQEWmIjW0ghlTU+NDZoxZn5qf6zjArJDGyLsRo2tMGNj8Q9pOH3P
 hUWUYp5vH1ESluMlBYleYS9X4uZDYXFXuez//jqm8tL1CM2sl3CdmkNIUa0A6/Wm3Wm0E8it/Jz
 cOfeK71KW1TZtiNEnpiDktlF5itj3Lhyq3rRR3ausoLtyb11sJd4gJkjOft0tZEprdeYgGjusQr
 svS/Ig2ThqgqGL/B/gvkDFtl9FbDqabL3ksw22g7S7Yvckj+JDXY5HYSxwI2CwE6IyRNgvZraqU
 W5WlC7oLwcuaUhH3U5nFkWJ2pXr6fLpzOH7nyLlRIi1Tnv0/twxeFxi+hBo7/mT91zwzsVLKgPD
 fYChoG1z6dVjblePosm74rWZ3rTctyC/AqkJ0o1Xe6XHTCoJJpPiNxjGMoknhUL5u859+BZDeT0
 VMds0fIPH96Y/QAy4Kdkf0/tNq0fhQk2Ya5Enb7vCUw+SkCD9KidF5AuwO918v3Zb7p8JRF69Qh
 ddCkRB1QklsdjpctiG6x5mtgT2mAs0Leh64lW9HU6WXfjjZ2+LgGRT2Y1T3hN9ukkEmE6Q1lgFK
 75QsK+AQZHDPIFg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_pm_announced_del_timer() removes the matched ADD_ADDR entry (if
found) from the ADD_ADDR list only if check_id is true. That's
dangerous, and not clear, because it means the caller should be free the
entry only in some cases, and it easy to miss that.

Instead, make it static, and call it from mptcp_pm_add_addr_echoed,
which is the only case where mptcp_pm_add_addr_del_timer should be
called with check_id set to true. Bonus with that: a second call to
mptcp_pm_add_addr_lookup_by_addr() can be avoided.

Note that instead of adding the signature above to avoid a compilation
issue because this helper is called before the definition of the
function, the whole helper is moved above where it is first called. Its
content is untouched, except the addition of the 'static' keyboard.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  |  1 -
 net/mptcp/pm.c       | 77 +++++++++++++++++++++++++++-------------------------
 net/mptcp/protocol.h |  3 --
 3 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f50642f0ec27..0de3ed9d6697 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1199,7 +1199,6 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 			} else {
 				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
-				mptcp_pm_announced_del_timer(msk, &mp_opt.addr, true);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 			}
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c60d8fce64f2..25826ea0a19f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -149,6 +149,41 @@ mptcp_pm_announced_lookup(const struct mptcp_sock *msk,
 	return NULL;
 }
 
+static struct mptcp_pm_add_addr *
+mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
+			     const struct mptcp_addr_info *addr, bool check_id)
+{
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_add_addr *entry;
+	struct timer_list *timer = NULL;
+
+	rcu_read_lock();
+
+	spin_lock_bh(&msk->pm.lock);
+	entry = mptcp_pm_announced_lookup(msk, addr);
+	if (entry && (!check_id || entry->addr.id == addr->id)) {
+		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
+		timer = &entry->timer;
+	}
+	if (!check_id && entry)
+		list_del(&entry->list);
+	spin_unlock_bh(&msk->pm.lock);
+
+	/* Note: entry might have been removed by another thread.
+	 * We hold rcu_read_lock() to ensure it is not freed under us.
+	 */
+	rcu_read_unlock();
+
+	if (timer) {
+		if (check_id)
+			sk_stop_timer(sk, timer);
+		else
+			sk_stop_timer_sync(sk, timer);
+	}
+
+	return entry;
+}
+
 bool mptcp_pm_announced_remove(struct mptcp_sock *msk,
 			       const struct mptcp_addr_info *addr)
 {
@@ -398,41 +433,6 @@ static void mptcp_pm_add_addr_timer(struct timer_list *timer)
 	sock_put(sk);
 }
 
-struct mptcp_pm_add_addr *
-mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
-			     const struct mptcp_addr_info *addr, bool check_id)
-{
-	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_add_addr *entry;
-	struct timer_list *timer = NULL;
-
-	rcu_read_lock();
-
-	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_pm_announced_lookup(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id)) {
-		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
-		timer = &entry->timer;
-	}
-	if (!check_id && entry)
-		list_del(&entry->list);
-	spin_unlock_bh(&msk->pm.lock);
-
-	/* Note: entry might have been removed by another thread.
-	 * We hold rcu_read_lock() to ensure it is not freed under us.
-	 */
-	rcu_read_unlock();
-
-	if (timer) {
-		if (check_id)
-			sk_stop_timer(sk, timer);
-		else
-			sk_stop_timer_sync(sk, timer);
-	}
-
-	return entry;
-}
-
 bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr)
 {
@@ -731,15 +731,18 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
+	struct mptcp_pm_add_addr *entry;
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!READ_ONCE(pm->work_pending))
+	entry = mptcp_pm_announced_del_timer(msk, addr, true);
+
+	if (!entry || !READ_ONCE(pm->work_pending))
 		return;
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_pm_announced_lookup(msk, addr) && READ_ONCE(pm->work_pending))
+	if (READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a0d2d72a5401..ddb0be7f19bd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1134,9 +1134,6 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 			      u8 bkup);
 bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
-struct mptcp_pm_add_addr *
-mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
-			     const struct mptcp_addr_info *addr, bool check_id);
 bool mptcp_pm_announced_remove(struct mptcp_sock *msk,
 			       const struct mptcp_addr_info *addr);
 bool mptcp_pm_announced_has_ssk(struct mptcp_sock *msk, const struct sock *ssk);

-- 
2.53.0

