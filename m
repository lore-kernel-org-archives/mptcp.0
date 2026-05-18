Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47C947A0D7
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109167; cv=none; b=FrrK17OAyBeDwWO3qQJ8P+OnzpP/INwohEJusR/192X2DqeN7mnoV5sydLjFEB+TZXffOBoWjm9h+F6QPQ//O3cmYDLRqKXzxn1ih5GBGDydt61Fo1VJxaBjOiOHqtKSNirVcdX36D3PK/09qG8r9TIvgfr/B3cljgo9SyG8Jmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109167; c=relaxed/simple;
	bh=yFQ/EfcPUhA/g59GNXLRhGbbWSDc4DDgwCGry1hLjk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kiU0Wr0qOkHcKTEfBLMMu1sFumNCGIy63UFgZIXiv4F86F+sltmbjGDU9pjTLmIYBGLcolDm0kfCLHhSFP/fuQDaZxQFW60q4fsyuikbK+HpL96dMYsSwNFjOavO7g62Y/5PRmke3K4TV9hVKe75Xyth7yfK7IC4PTpJHhzvamo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrN5QMKj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrN5QMKj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36BFC2BCB7;
	Mon, 18 May 2026 12:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779109166;
	bh=yFQ/EfcPUhA/g59GNXLRhGbbWSDc4DDgwCGry1hLjk8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LrN5QMKjGUWTWUPnrU6B86k1a4/pnU/+nf7uZ+V8SNvjxuK1j0TaUy/Gq+P9o5QqQ
	 Q8yMVNy0pUENkbJJIJE960/F3xzGlMbAVGhIdvJSrRpfCxHD9/vC4RVpgWLTySdLC4
	 6KAxZjAGxGterU75AAlTKm4H8WUywoqXa8I9AgvvaCRZqd3ms1pD/far1D1mgMn/gO
	 Nrb920ZDFbuNJVmjHSQgCeziUxhjMi31N+6TyaN/8zcF84rLGyZNreddN/jzz0S3qY
	 UrzHQqH5hKmEc5mlVE9dnx56Xm7ugTg0IkerkJtY5XG4u9f64nIkVUoFqFKuoLPgCS
	 2IFCE0kw7kM9Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 18 May 2026 22:59:12 +1000
Subject: [PATCH mptcp-next 08/12] mptcp: pm: uniform announced addresses
 helpers
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mptcp-add-addr6-port-ts-v1-8-f1ca26977fcd@kernel.org>
References: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
In-Reply-To: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11491; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yFQ/EfcPUhA/g59GNXLRhGbbWSDc4DDgwCGry1hLjk8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqCw0h1DK2WQpQhdoVHHaHRbv+AJn7ERyi+FrMX
 ywkKjXDDSWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagsNIQAKCRD2t4JPQmmg
 c2RKEACzv0ug5+zYRRqnYGXJ/vapmU+vieqWvTK2thmtLXwtmdtsnMGWM96FK170mS8E+5+SF7F
 JumR32SllJn+bnDYwin4PA8vk1Q6q7Lau1B7z0FdU7Fbu0Esh27ELiM0Gn1HQ3BWCcrpkG6nP3L
 oCU328gyr/FeefeOCJ6ZP1puNdH7/Sh8Tar4rJpm91oZrN+wfyCm43b3G5rpF+dyEAXkviNVwyQ
 GCP74l1QQF30qt80j2caKUAapXtAqkWb4zAjU1jj+y0pRfSjZWY8ouYnAAO06rEtwJdKFRHLCnd
 w+lMCczqhNbQKTU2cHRqDkb0c7GTlfkj6BT8YVUvsQD1AFEuRbTwXmKu+MFb7DPSkWsgVT25eME
 XVn2xLnZC1YjMGdTY5ksY+6pt8rKMIF6mIp+aRusPGjIEKMK1XyPVT19qAO2rO76QDyDPCWJwtc
 ujzC/svo2ZhCPn4sKDAXaXEmRyL7L66ALk3NDqmeXXNB9ZIhH47B3v9f1NsoSc/pUWuYO2S/c28
 j/9+8M/GPj9bezVGagXMQ92RW72buAjI1mcC7Bn8V0REmCykhgW5Uucvu/r9S0ULF89o+Nri2tT
 QMb3JkSICAPVV/h4JYvapExphbufPHoUAy5ZO4iTjlL1qBZo2yswQD3LOK1B4xsPCVfCDr1cuay
 STVxbUT5QAZ6PJg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Similar to the previous commit, only using the 'add' or 'anno' prefixes
is confusing -- generally associated to the action of adding something,
or the Latin name for "year" -- and lack of uniformity.

This has been causing issues in the past, e.g. del_add_timer seemed to
suggest the goal is to delete a previously added timer.

Instead, use the mptcp_pm_announced_ prefix.

While at it, slightly improves some helpers:

- mptcp_lookup_anno_list_by_saddr: no need to specify what is used to do
  the lookup: mptcp_pm_announced_lookup.

- mptcp_pm_sport_in_anno_list: it doesn't just compare the port, but the
  whole address linked to the sublow: mptcp_pm_announced_has_ssk.

- mptcp_pm_alloc_anno_list: it allocates one item of the list, not a
  whole list: mptcp_pm_announced_alloc.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c      |  2 +-
 net/mptcp/pm.c           | 33 ++++++++++++++++-----------------
 net/mptcp/pm_kernel.c    | 10 +++++-----
 net/mptcp/pm_userspace.c |  4 ++--
 net/mptcp/protocol.h     | 12 ++++++------
 net/mptcp/subflow.c      |  4 ++--
 6 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a2d2ff7336a0..6514776e9ce4 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1201,7 +1201,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 			} else {
 				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
-				mptcp_pm_del_add_timer(msk, &mp_opt.addr, true);
+				mptcp_pm_announced_del_timer(msk, &mp_opt.addr, true);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 			}
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 0a86b69ee214..f36f63f8bc7f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -134,8 +134,8 @@ bool mptcp_pm_has_subflow_saddr(const struct mptcp_sock *msk,
 }
 
 static struct mptcp_pm_add_addr *
-mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr)
+mptcp_pm_announced_lookup(const struct mptcp_sock *msk,
+			  const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_addr *entry;
 
@@ -149,26 +149,26 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 	return NULL;
 }
 
-bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				     const struct mptcp_addr_info *addr)
+bool mptcp_pm_announced_remove(struct mptcp_sock *msk,
+			       const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_addr *entry;
 	bool ret;
 
-	entry = mptcp_pm_del_add_timer(msk, addr, false);
+	entry = mptcp_pm_announced_del_timer(msk, addr, false);
 	ret = entry;
 	kfree_rcu(entry, rcu);
 
 	return ret;
 }
 
-bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
+bool mptcp_pm_announced_has_ssk(struct mptcp_sock *msk, const struct sock *ssk)
 {
 	struct mptcp_pm_add_addr *entry;
 	struct mptcp_addr_info saddr;
 	bool ret = false;
 
-	mptcp_local_address((struct sock_common *)sk, &saddr);
+	mptcp_local_address((struct sock_common *)ssk, &saddr);
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
@@ -398,8 +398,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 }
 
 struct mptcp_pm_add_addr *
-mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       const struct mptcp_addr_info *addr, bool check_id)
+mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
+			     const struct mptcp_addr_info *addr, bool check_id)
 {
 	struct mptcp_pm_add_addr *entry;
 	struct sock *sk = (struct sock *)msk;
@@ -408,7 +408,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	rcu_read_lock();
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+	entry = mptcp_pm_announced_lookup(msk, addr);
 	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 		stop_timer = true;
@@ -431,7 +431,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	return entry;
 }
 
-bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
+bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_addr *add_entry = NULL;
@@ -440,8 +440,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-
+	add_entry = mptcp_pm_announced_lookup(msk, addr);
 	if (add_entry) {
 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
@@ -469,7 +468,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	return true;
 }
 
-static void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
+static void mptcp_pm_free_announced_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_add_addr *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
@@ -738,7 +737,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
+	if (mptcp_pm_announced_lookup(msk, addr) && READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
@@ -981,7 +980,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	 * let the PM state machine progress.
 	 */
 	if (skip_add_addr) {
-		mptcp_pm_del_add_timer(msk, addr, true);
+		mptcp_pm_announced_del_timer(msk, addr, true);
 		mptcp_pm_subflow_established(msk);
 	}
 	return ret;
@@ -1169,7 +1168,7 @@ static void mptcp_pm_ops_release(struct mptcp_sock *msk)
 
 void mptcp_pm_destroy(struct mptcp_sock *msk)
 {
-	mptcp_pm_free_anno_list(msk);
+	mptcp_pm_free_announced_list(msk);
 	mptcp_pm_ops_release(msk);
 }
 
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 8436e66daab6..331f6fa99014 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -374,7 +374,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		/* If the alloc fails, we are on memory pressure, not worth
 		 * continuing, and trying to create subflows.
 		 */
-		if (!mptcp_pm_alloc_anno_list(msk, &local.addr))
+		if (!mptcp_pm_announced_alloc(msk, &local.addr))
 			return;
 
 		__clear_bit(endp_id, msk->pm.id_avail_bitmap);
@@ -1054,7 +1054,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static void mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
+static void mptcp_pm_remove_announced(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr,
 				      bool force)
 {
@@ -1063,7 +1063,7 @@ static void mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 
 	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
-	announced = mptcp_remove_anno_list_by_saddr(msk, addr);
+	announced = mptcp_pm_announced_remove(msk, addr);
 	if (announced || force) {
 		spin_lock_bh(&msk->pm.lock);
 		if (announced)
@@ -1100,7 +1100,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 
 		lock_sock(sk);
 		remove_subflow = mptcp_pm_has_subflow_saddr(msk, addr);
-		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
+		mptcp_pm_remove_announced(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
 		list.ids[0] = mptcp_endp_get_local_id(msk, addr);
@@ -1240,7 +1240,7 @@ static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 		if (mptcp_pm_has_subflow_saddr(msk, &entry->addr))
 			slist.ids[slist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 
-		if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
+		if (mptcp_pm_announced_remove(msk, &entry->addr))
 			alist.ids[alist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 
 		if (slist.nr == MPTCP_RM_IDS_MAX ||
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ff0bbd96cd09..8a342a65bd34 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -228,7 +228,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
+	if (mptcp_pm_announced_alloc(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_addr_send_ack(msk);
@@ -281,7 +281,7 @@ void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 	int anno_nr = 0;
 
 	/* only delete if either announced or matching a subflow */
-	if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
+	if (mptcp_pm_announced_remove(msk, &entry->addr))
 		anno_nr++;
 	else if (!mptcp_pm_has_subflow_saddr(msk, &entry->addr))
 		return;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 16424229fe15..885c5722d79c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1133,16 +1133,16 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 			      struct mptcp_addr_info *addr,
 			      struct mptcp_addr_info *rem,
 			      u8 bkup);
-bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
+bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
-bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_addr *
-mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       const struct mptcp_addr_info *addr, bool check_id);
+mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
+			     const struct mptcp_addr_info *addr, bool check_id);
+bool mptcp_pm_announced_remove(struct mptcp_sock *msk,
+			       const struct mptcp_addr_info *addr);
+bool mptcp_pm_announced_has_ssk(struct mptcp_sock *msk, const struct sock *ssk);
 bool mptcp_pm_has_subflow_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *saddr);
-bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				     const struct mptcp_addr_info *addr);
 int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 			  struct genl_info *info);
 int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d562e149606f..8e386899ceb9 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -235,7 +235,7 @@ static int subflow_check_req(struct request_sock *req,
 			pr_debug("syn inet_sport=%d %d\n",
 				 ntohs(inet_sk(sk_listener)->inet_sport),
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
-			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
+			if (!mptcp_pm_announced_has_ssk(subflow_req->msk, sk_listener)) {
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
 				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 				return -EPERM;
@@ -926,7 +926,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				pr_debug("ack inet_sport=%d %d\n",
 					 ntohs(inet_sk(sk)->inet_sport),
 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
-				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
+				if (!mptcp_pm_announced_has_ssk(owner, sk)) {
 					SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTACKRX);
 					subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 					goto dispose_child;

-- 
2.53.0

