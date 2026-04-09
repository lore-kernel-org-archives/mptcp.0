Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008EA339719
	for <mptcp@lists.linux.dev>; Thu,  9 Apr 2026 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767945; cv=none; b=OiILovT9g2zSUSPVPNeoRTWXUyLYQToMnIGRLQeQTLZzdHzr+S1h4+yFVawkcdTaqn5hS3OQgV5bi3BcZysOs1aHPS9pu8+tRqDxnXR6iGWSk84/FaJnXk9yDRHaFiuRbuauR744x5XiI4uQeL1oLl6UhPjY6xJUv7rNjl+Unj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767945; c=relaxed/simple;
	bh=ViqX55Uz68XOYu6aE67wJQcjE7cCKwCUYRVJPumWrYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1Rt8L98aZG5kPyY2wMnBI1bgSdAKgFTIvxQz41e1ZOnZxl8/Vosh/5AXGIWxZpb8YNsdyZefltJ+sctrdINkDprU15DGmIDQJSgkVNRqHfA2OLIoStxvDdGAWXh57lPkTHMCtRsAJncDe1YcWrvH/Ne+12bil0wnP3QoTnb+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDohJINC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDohJINC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE73C4CEF7;
	Thu,  9 Apr 2026 20:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775767944;
	bh=ViqX55Uz68XOYu6aE67wJQcjE7cCKwCUYRVJPumWrYE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MDohJINCiDKXRxsanfvoacF1i7bO3x/+YdhSj7NPJG1pTnh82t2q38CI+GkSc3CFW
	 pkOX759d1pqhYhd4zGjUs6d8fUyAi2g1Wwbj8+eCeCD4ae/xB7nqK31uCLmz6wmNrz
	 hhgzwKjFOOAtfPboicIdVCi+yPPwr8iXTlD5NaObWbiqE16Sa3rTXKgWWJU56k9Jbt
	 84gwqPiP+wYJkkZNLHDerqmL8/+iVxtauImAn1EgKhu+o/CiXVTR0t6G0wvnTcz6cd
	 BXlneeHj7AG158NNMEMEbTE1c+nprgwRJLwYj67aYUWIwsXsClnxj+d7r7nJ5VTJH9
	 6bjKWzzchcPUw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 09 Apr 2026 22:51:56 +0200
Subject: [PATCH mptcp-next 16/16] mptcp: pm: clearer ADD_ADDR related
 helpers names
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mptcp-inc-limits-v1-16-0e45fa30d914@kernel.org>
References: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
In-Reply-To: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=15439; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ViqX55Uz68XOYu6aE67wJQcjE7cCKwCUYRVJPumWrYE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvCFZvn1lxQ5u74tYVA8NPByc/edOzMiZdwSH1QXKlv
 tOmEqEJHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABORP87I8Kx3wZbLt7c+e87+
 OvpjpsU7V7nzj7hXHu7dc3rZ9fZKWROG/+lynRmlbnw5LPyfvA5t1RCdYp/pmrL26L9+m9svvpq
 84AIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here is a suggestion, and if it is OK, I will split this in multiple
commits: it is not the first time the 'add' and 'anno' names to describe
ADD_ADDR related functions are confusing. Eric already pointed that in
[1].

I started by renaming only the internal helper names, then while at it,
I tried to uniform that.

WDYT?

Link: https://lore.kernel.org/20251117100745.1913963-1-edumazet@google.com [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c      |   2 +-
 net/mptcp/pm.c           | 122 ++++++++++++++++++++++++-----------------------
 net/mptcp/pm_kernel.c    |  16 +++----
 net/mptcp/pm_userspace.c |   4 +-
 net/mptcp/protocol.h     |  17 +++----
 net/mptcp/subflow.c      |   4 +-
 6 files changed, 84 insertions(+), 81 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4cc583fdc7a9..d353c6082d40 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1211,7 +1211,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 			} else {
 				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
-				mptcp_pm_del_add_timer(msk, &mp_opt.addr, true);
+				mptcp_pm_del_add_addr_timer(msk, &mp_opt.addr, true);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 			}
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e1dbc64134bf..a37b67dbe5cf 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -12,11 +12,11 @@
 
 #define ADD_ADDR_RETRANS_MAX	3
 
-struct mptcp_pm_add_entry {
+struct mptcp_pm_add_addr {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
 	u8			retrans_times;
-	struct timer_list	add_timer;
+	struct timer_list	timer;
 	struct mptcp_sock	*sock;
 	struct rcu_head		rcu;
 };
@@ -132,46 +132,47 @@ bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
 	return false;
 }
 
-static struct mptcp_pm_add_entry *
-mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr)
+static struct mptcp_pm_add_addr *
+mptcp_lookup_add_addr_by_saddr(const struct mptcp_sock *msk,
+			       const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *add_addr;
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, addr, true))
-			return entry;
+	list_for_each_entry(add_addr, &msk->pm.anno_list, list) {
+		if (mptcp_addresses_equal(&add_addr->addr, addr, true))
+			return add_addr;
 	}
 
 	return NULL;
 }
 
-bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				     const struct mptcp_addr_info *addr)
+bool mptcp_remove_add_addr_by_saddr(struct mptcp_sock *msk,
+				    const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *add_addr;
 	bool ret;
 
-	entry = mptcp_pm_del_add_timer(msk, addr, false);
-	ret = entry;
-	kfree_rcu(entry, rcu);
+	add_addr = mptcp_pm_del_add_addr_timer(msk, addr, false);
+	ret = add_addr;
+	kfree_rcu(add_addr, rcu);
 
 	return ret;
 }
 
-bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
+bool mptcp_pm_sport_in_add_addr_list(struct mptcp_sock *msk,
+				     const struct sock *sk)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *add_addr;
 	struct mptcp_addr_info saddr;
 	bool ret = false;
 
 	mptcp_local_address((struct sock_common *)sk, &saddr);
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &saddr, true)) {
+	list_for_each_entry(add_addr, &msk->pm.anno_list, list) {
+		if (mptcp_addresses_equal(&add_addr->addr, &saddr, true)) {
 			ret = true;
 			goto out;
 		}
@@ -334,11 +335,11 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
 	return max_stale && max_stale < rto ? max_stale : rto;
 }
 
-static void mptcp_pm_add_timer(struct timer_list *timer)
+static void mptcp_pm_add_addr_timer(struct timer_list *timer)
 {
-	struct mptcp_pm_add_entry *entry = timer_container_of(entry, timer,
-							      add_timer);
-	struct mptcp_sock *msk = entry->sock;
+	struct mptcp_pm_add_addr *add_addr = timer_container_of(add_addr, timer,
+								timer);
+	struct mptcp_sock *msk = add_addr->sock;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout;
 
@@ -359,95 +360,96 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (!mptcp_pm_should_add_signal_addr(msk)) {
-		pr_debug("retransmit ADD_ADDR id=%d\n", entry->addr.id);
-		mptcp_pm_announce_addr(msk, &entry->addr, false);
+		pr_debug("retransmit ADD_ADDR id=%d\n", add_addr->addr.id);
+		mptcp_pm_announce_addr(msk, &add_addr->addr, false);
 		mptcp_pm_add_addr_send_ack(msk);
-		entry->retrans_times++;
+		add_addr->retrans_times++;
 	}
 
-	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
+	if (add_addr->retrans_times < ADD_ADDR_RETRANS_MAX)
 		sk_reset_timer(sk, timer,
-			       jiffies + (timeout << entry->retrans_times));
+			       jiffies + (timeout << add_addr->retrans_times));
 
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry->retrans_times == ADD_ADDR_RETRANS_MAX)
+	if (add_addr->retrans_times == ADD_ADDR_RETRANS_MAX)
 		mptcp_pm_subflow_established(msk);
 
 out:
 	sock_put(sk);
 }
 
-struct mptcp_pm_add_entry *
-mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       const struct mptcp_addr_info *addr, bool check_id)
+struct mptcp_pm_add_addr *
+mptcp_pm_del_add_addr_timer(struct mptcp_sock *msk,
+			    const struct mptcp_addr_info *addr, bool check_id)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *add_addr;
 	struct sock *sk = (struct sock *)msk;
 	bool stop_timer = false;
 
 	rcu_read_lock();
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id)) {
-		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
+	add_addr = mptcp_lookup_add_addr_by_saddr(msk, addr);
+	if (add_addr && (!check_id || add_addr->addr.id == addr->id)) {
+		add_addr->retrans_times = ADD_ADDR_RETRANS_MAX;
 		stop_timer = true;
 	}
-	if (!check_id && entry)
-		list_del(&entry->list);
+	if (!check_id && add_addr)
+		list_del(&add_addr->list);
 	spin_unlock_bh(&msk->pm.lock);
 
 	/* Note: entry might have been removed by another thread.
 	 * We hold rcu_read_lock() to ensure it is not freed under us.
 	 */
 	if (stop_timer)
-		sk_stop_timer_sync(sk, &entry->add_timer);
+		sk_stop_timer_sync(sk, &add_addr->timer);
 
 	rcu_read_unlock();
-	return entry;
+	return add_addr;
 }
 
-bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_addr_info *addr)
+bool mptcp_pm_alloc_add_addr_list(struct mptcp_sock *msk,
+				  const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *add_entry = NULL;
+	struct mptcp_pm_add_addr *add_addr = NULL;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout;
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+	add_addr = mptcp_lookup_add_addr_by_saddr(msk, addr);
 
-	if (add_entry) {
+	if (add_addr) {
 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
 		goto reset_timer;
 	}
 
-	add_entry = kmalloc_obj(*add_entry, GFP_ATOMIC);
-	if (!add_entry)
+	add_addr = kmalloc_obj(*add_addr, GFP_ATOMIC);
+	if (!add_addr)
 		return false;
 
-	list_add(&add_entry->list, &msk->pm.anno_list);
+	list_add(&add_addr->list, &msk->pm.anno_list);
 
-	add_entry->addr = *addr;
-	add_entry->sock = msk;
-	add_entry->retrans_times = 0;
+	add_addr->addr = *addr;
+	add_addr->sock = msk;
+	add_addr->retrans_times = 0;
 
-	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+	timer_setup(&add_addr->timer, mptcp_pm_add_addr_timer, 0);
 reset_timer:
 	timeout = mptcp_adjust_add_addr_timeout(msk);
 	if (timeout)
-		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
+		sk_reset_timer(sk, &add_addr->timer,
+			       jiffies + timeout);
 
 	return true;
 }
 
-static void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
+static void mptcp_pm_free_add_addr_list(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_add_entry *entry, *tmp;
+	struct mptcp_pm_add_addr *add_addr, *tmp;
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
@@ -457,9 +459,9 @@ static void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	list_splice_init(&msk->pm.anno_list, &free_list);
 	spin_unlock_bh(&msk->pm.lock);
 
-	list_for_each_entry_safe(entry, tmp, &free_list, list) {
-		sk_stop_timer_sync(sk, &entry->add_timer);
-		kfree_rcu(entry, rcu);
+	list_for_each_entry_safe(add_addr, tmp, &free_list, list) {
+		sk_stop_timer_sync(sk, &add_addr->timer);
+		kfree_rcu(add_addr, rcu);
 	}
 }
 
@@ -713,7 +715,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
+	if (mptcp_lookup_add_addr_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
@@ -1082,7 +1084,7 @@ static void mptcp_pm_ops_release(struct mptcp_sock *msk)
 
 void mptcp_pm_destroy(struct mptcp_sock *msk)
 {
-	mptcp_pm_free_anno_list(msk);
+	mptcp_pm_free_add_addr_list(msk);
 	mptcp_pm_ops_release(msk);
 }
 
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index ee92a9a127c3..6acdaa3efbe7 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -367,7 +367,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		/* If the alloc fails, we are on memory pressure, not worth
 		 * continuing, and trying to create subflows.
 		 */
-		if (!mptcp_pm_alloc_anno_list(msk, &local.addr))
+		if (!mptcp_pm_alloc_add_addr_list(msk, &local.addr))
 			return;
 
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
@@ -1051,16 +1051,16 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static void mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
-				      const struct mptcp_addr_info *addr,
-				      bool force)
+static void mptcp_pm_remove_add_addr(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *addr,
+				     bool force)
 {
 	struct mptcp_rm_list list = { .nr = 0 };
 	bool announced;
 
 	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
-	announced = mptcp_remove_anno_list_by_saddr(msk, addr);
+	announced = mptcp_remove_add_addr_by_saddr(msk, addr);
 	if (announced || force) {
 		spin_lock_bh(&msk->pm.lock);
 		if (announced)
@@ -1097,8 +1097,8 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 
 		lock_sock(sk);
 		remove_subflow = mptcp_lookup_subflow_by_saddr(&msk->conn_list, addr);
-		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
-					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
+		mptcp_pm_remove_add_addr(msk, addr, remove_subflow &&
+					 !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
 		list.ids[0] = mptcp_endp_get_local_id(msk, addr);
 
@@ -1232,7 +1232,7 @@ static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 			slist.ids[slist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 
 		if (alist.nr < MPTCP_RM_IDS_MAX &&
-		    mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
+		    mptcp_remove_add_addr_by_saddr(msk, &entry->addr))
 			alist.ids[alist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 	}
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d838e8ea65fd..29e892a94ce2 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -228,7 +228,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
+	if (mptcp_pm_alloc_add_addr_list(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_addr_send_ack(msk);
@@ -281,7 +281,7 @@ void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 	int anno_nr = 0;
 
 	/* only delete if either announced or matching a subflow */
-	if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
+	if (mptcp_remove_add_addr_by_saddr(msk, &entry->addr))
 		anno_nr++;
 	else if (!mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
 		return;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 661600f8b573..f7a1d039f144 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1132,16 +1132,17 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 			      struct mptcp_addr_info *addr,
 			      struct mptcp_addr_info *rem,
 			      u8 bkup);
-bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_addr_info *addr);
-bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
-struct mptcp_pm_add_entry *
-mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       const struct mptcp_addr_info *addr, bool check_id);
+bool mptcp_pm_alloc_add_addr_list(struct mptcp_sock *msk,
+				  const struct mptcp_addr_info *addr);
+bool mptcp_pm_sport_in_add_addr_list(struct mptcp_sock *msk,
+				     const struct sock *sk);
+struct mptcp_pm_add_addr *
+mptcp_pm_del_add_addr_timer(struct mptcp_sock *msk,
+			    const struct mptcp_addr_info *addr, bool check_id);
 bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
 				   const struct mptcp_addr_info *saddr);
-bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				     const struct mptcp_addr_info *addr);
+bool mptcp_remove_add_addr_by_saddr(struct mptcp_sock *msk,
+				    const struct mptcp_addr_info *addr);
 int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 			  struct genl_info *info);
 int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c57ed27a5fb0..d0844e568119 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -235,7 +235,7 @@ static int subflow_check_req(struct request_sock *req,
 			pr_debug("syn inet_sport=%d %d\n",
 				 ntohs(inet_sk(sk_listener)->inet_sport),
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
-			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
+			if (!mptcp_pm_sport_in_add_addr_list(subflow_req->msk, sk_listener)) {
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
 				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 				return -EPERM;
@@ -926,7 +926,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				pr_debug("ack inet_sport=%d %d\n",
 					 ntohs(inet_sk(sk)->inet_sport),
 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
-				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
+				if (!mptcp_pm_sport_in_add_addr_list(owner, sk)) {
 					SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTACKRX);
 					subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 					goto dispose_child;

-- 
2.53.0

