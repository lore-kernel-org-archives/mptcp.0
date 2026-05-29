Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8776B367B73
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 03:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024937; cv=none; b=qQMX19rIhvJgaujvY0WYq/D2Fm2sAOVa6Sz9mQRLSlDoUvzoeGH3B5+ahT4Ac6SFCSZU3ehEJc3sotkYiOoZRsBnaqNYSGhMvF3IDLwW+oy8mr03m+nnxwXke2AWTQRChkox/ZL7lkXfuUgCm7HK8uhkNqqZhw7MCWgI/Ue7Ov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024937; c=relaxed/simple;
	bh=cDu2PJoVyYus6UJlUK7GmMifuBXngwm64cPHljMp+nE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D0yRLH1aIOaHturDsngFSKEDaZQn8EutQRtmryVH2DR4sOxjAUAisjzTDgZRcBzzFhriRgZQKW0+PJivzrDWImYd5EZLj79awj3igfOJ9X4Y3/YCWvaW20BGiQW8C/P3Hv5S1lWDsUuMQc4eIbCqC/3ahBqLStckJy34lYieQQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldNMaWmy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldNMaWmy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1EA1F000E9;
	Fri, 29 May 2026 03:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780024936;
	bh=h9UH6Za/FbaCCf1KuXteF/I0jIDe1aMJkIG/p3W26Eo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ldNMaWmy3S6GdPvOgEESWhZLaL45gi46ICnMzbbGaDe6iD+bSYDgKOOLMsW9dNC70
	 rPapO19nHJW/1deFg7A0Ee9JFqHAhF74BJO14V0SVPARBvlEUu7Kaxv3DQcnMdjkXy
	 yK4gfT10lEVkti/D081Geen8MVFo0lOngEcPGFKK22CAKFQt9G2vqk7OtqdPk64ZV8
	 83q2in5K3BJ2aPYu1p69Wfzv/o5pvIMrVjMSIqqi8rAn12PaXgBii8K0n1xifdX1q6
	 lEpQBd7GgelsqQorLUi25bnxg6on8HqrSzahkBt5Ovl8G4OPAlD+PEKnx86LE3dYfu
	 liL4/M+polzXQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 May 2026 13:21:50 +1000
Subject: [PATCH mptcp-next v4 12/15] mptcp: pm: uniform announced addresses
 helpers
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-mptcp-add-addr6-port-ts-v4-12-cea393fa33a2@kernel.org>
References: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
In-Reply-To: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12026; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cDu2PJoVyYus6UJlUK7GmMifuBXngwm64cPHljMp+nE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqGQZXL58Uq7OS9pmi3bGjMGiswnjrsFqC0eYJi
 QD2RBVY2J2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahkGVwAKCRD2t4JPQmmg
 cwSfD/0Xj6HfagXkIs35KfYBr2W2kR8QdSwoQN9MsasutTMD+nfYtMtGWSQnADOhg9GSN7E+fyh
 ultEFQSVDh4Yexn9eXFX+lNOsLS5q7p3ebDwvsOtQnaz65/W+LS4YplF4U79aqYO37fnYrWBRo0
 i7DXszaDnjOOCqG7S+qnCDH2NRZIKNpUb2T26o3ySOp8hYd8UPZHiHeWWXfbWIHL9c4KbNGffMZ
 uZ32vdLWFF/2//Kch2I+gF+Zd9/YwANh5ne0ZuJJmg/Ng1R5h6s2ZDyXscNPHLLYx1nAfZSx4LB
 jCmIUUnkmzUCLtPK+4+3DzQsNvo45rRSM6rEbvzgbaITv5xRK+3Z5xDWksG6+X8Lt5iCHYGnpnX
 KykW6VcIJFi+18fC5AvxEvR7xCyOorl7X5hGGSsydbVmoxhTGywmyfc3gpGepNUM0y6+XrAN+j1
 PK2p/xAEZ998fKbuX1ygo4pZA2WYpdc8CtULo9p+DZbuvdG2LK1sCnUiBMzyt1r0P8zjGDf6JrI
 VBe5TaMi7OjvDpCQVott8/tB1GblDJbRGX/oV/farkorE1NYtJ+/jdLnMWz0IIMeTKyFIMsnfD7
 xbh5rFJav11dWviCBmUsaAG4fdf7gL8Y7hTz0QTMPkRi12DVWEYdoevwI65dJuXlyTQSZUKTIEb
 5DHqc56QyrTx0qw==
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
v2: also update comment mentioning mptcp_pm_announced_del_timer.
---
 net/mptcp/options.c      |  2 +-
 net/mptcp/pm.c           | 35 +++++++++++++++++------------------
 net/mptcp/pm_kernel.c    | 10 +++++-----
 net/mptcp/pm_userspace.c |  4 ++--
 net/mptcp/protocol.h     | 12 ++++++------
 net/mptcp/subflow.c      |  4 ++--
 6 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4673530018bf..5d9bfd559310 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1218,7 +1218,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 			} else {
 				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
-				mptcp_pm_del_add_timer(msk, &mp_opt.addr, true);
+				mptcp_pm_announced_del_timer(msk, &mp_opt.addr, true);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 			}
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3d930298d9d8..0f05222ecda2 100644
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
@@ -364,7 +364,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	spin_lock_bh(&msk->pm.lock);
 
-	/* The cancel path (mptcp_pm_del_add_timer()) can race with this
+	/* The cancel path (mptcp_pm_announced_del_timer()) can race with this
 	 * callback. Once cancel updates retrans_times to MAX, suppress further
 	 * retransmissions here. If this callback acquires pm.lock first, one
 	 * final transmit attempt is still possible.
@@ -398,8 +398,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 }
 
 struct mptcp_pm_add_addr *
-mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       const struct mptcp_addr_info *addr, bool check_id)
+mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
+			     const struct mptcp_addr_info *addr, bool check_id)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_add_addr *entry;
@@ -408,7 +408,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	rcu_read_lock();
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+	entry = mptcp_pm_announced_lookup(msk, addr);
 	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 		timer = &entry->add_timer;
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
@@ -739,7 +738,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
+	if (mptcp_pm_announced_lookup(msk, addr) && READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
@@ -983,7 +982,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	 * let the PM state machine progress.
 	 */
 	if (skip_add_addr) {
-		mptcp_pm_del_add_timer(msk, addr, true);
+		mptcp_pm_announced_del_timer(msk, addr, true);
 		mptcp_pm_subflow_established(msk);
 	}
 	return ret;
@@ -1171,7 +1170,7 @@ static void mptcp_pm_ops_release(struct mptcp_sock *msk)
 
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
index 74d00b2f2a76..ad6ba658e5a5 100644
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
index 52af825c3f8e..27a0354a1ebd 100644
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

