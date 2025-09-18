Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C8C215077
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217371; cv=none; b=YJiji4Z+WmWomEGthMf1ayC7WYcLPqN4am7YYaEFDhiM0lbWrE3ukJPl16B+gqjtdScGxjGjiOJW246IyyOgUDiONywJCoF+dS5cT5bOJySQT76Cu7iBJMen/KLDCd/RqbHh2xwXLUJOYX/3d+f0YaWpYPL7dRiTUVURqMscwdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217371; c=relaxed/simple;
	bh=Tw1T8wn6kyQwhoSTdmUHkaaZcY5A7FRxPAOV0rZVTkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q0pXkhUMDXgmgSuy+El7XAdYegjZ6HHesInnNI2o9fz8WMth9rQSt+JYwz/9fD0EAcq1zNWoou98CnUBLQ2Q3DIwTHWMGZCYjfmZezixRg7BZu35SQP/ZDjD76YOvvlshjxbkXwvxuYc7/kYo5ZD+ic6Bg+Vop7DWKBpI3nNd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCobSEzU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCobSEzU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD2BC4CEF0;
	Thu, 18 Sep 2025 17:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758217370;
	bh=Tw1T8wn6kyQwhoSTdmUHkaaZcY5A7FRxPAOV0rZVTkE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XCobSEzUPgGZekzP+y7KJKx6Se3qstpFZ4WaOjqSs1yHtrXUUccbp7CfznD9nHY7+
	 NvnHSCd7pJVztdtOJGNVXooQKzWQYYkYzWHjFY74j9nzjYgj4HLrwndSrclMGw3ioB
	 HmNRRRFxc/YXarc93f0svS2hl1gUy0RICk28gDo0rHctHgIoe+W94BG0WVPAeZYRmh
	 s/P9maIkdOBJdr2PAKni8y42iAV3VNegaf6+de+S8MumJNB7t7GkN/nY9HqtgrOnXi
	 xAc+EdqKHyPDeRn9M2/Yd2k1NAeAokIc+I/srZ500avAEz0KTnrP8g2ZH32kwqGT3K
	 uxYtMP46tcL6g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Sep 2025 19:42:25 +0200
Subject: [PATCH mptcp-next 09/10] mptcp: pm: in-kernel: rename
 'local_addr_list' to 'endp_list'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-pm-kern-endp-add_addr-v1-9-e12e58770a11@kernel.org>
References: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
In-Reply-To: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4732; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Tw1T8wn6kyQwhoSTdmUHkaaZcY5A7FRxPAOV0rZVTkE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOuEyQ01rmkbgyOH//137jyLzf9oe1OXfKKP+c9frMr
 +PMsp+vdJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzktQrDP1vzSSHB1rtP9q5Y
 /nFx77QJu4NKuiYG5qzLuR6/i0tkcgHD/1Bl0QnKNeHKR68trAy3FVb+4HYgbNXU+czfREJj2bS
 cGAE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A few variables linked to the in-kernel Path-Manager are confusing, and
it would help current and future developers, to clarify them.

One of them is 'local_addr_list', which in fact represents the list of
endpoints, and not only the 'subflow' endpoints.

No functional changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index e65449a1395270d46ee550a0814c94525586b4b4..eee931f1466afc166ad34658e8071e9b30cf9906 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -17,7 +17,7 @@ static int pm_nl_pernet_id;
 struct pm_nl_pernet {
 	/* protects pernet updates */
 	spinlock_t		lock;
-	struct list_head	local_addr_list;
+	struct list_head	endp_list;
 	unsigned int		addrs;
 	unsigned int		stale_loss_cnt;
 	unsigned int		endp_signal_max;
@@ -110,7 +110,7 @@ select_local_address(const struct pm_nl_pernet *pernet,
 	msk_owned_by_me(msk);
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+	list_for_each_entry_rcu(entry, &pernet->endp_list, list) {
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 			continue;
 
@@ -141,7 +141,7 @@ select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
 	 * Note: removal from the local address list during the msk life-cycle
 	 * can lead to additional addresses not being announced.
 	 */
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+	list_for_each_entry_rcu(entry, &pernet->endp_list, list) {
 		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
 			continue;
 
@@ -246,7 +246,7 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list,
+	list_for_each_entry_rcu(entry, &pernet->endp_list, list,
 				lockdep_is_held(&pernet->lock)) {
 		if (entry->addr.id == id)
 			return entry;
@@ -259,7 +259,7 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list,
+	list_for_each_entry_rcu(entry, &pernet->endp_list, list,
 				lockdep_is_held(&pernet->lock)) {
 		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
@@ -409,7 +409,7 @@ fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
 	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+	list_for_each_entry_rcu(entry, &pernet->endp_list, list) {
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
 			continue;
 
@@ -634,7 +634,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 	 */
 	if (!address_use_port(entry))
 		entry->addr.port = 0;
-	list_for_each_entry(cur, &pernet->local_addr_list, list) {
+	list_for_each_entry(cur, &pernet->endp_list, list) {
 		if (mptcp_addresses_equal(&cur->addr, &entry->addr,
 					  cur->addr.port || entry->addr.port)) {
 			/* allow replacing the exiting endpoint only if such
@@ -696,9 +696,9 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 
 	pernet->addrs++;
 	if (!entry->addr.port)
-		list_add_tail_rcu(&entry->list, &pernet->local_addr_list);
+		list_add_tail_rcu(&entry->list, &pernet->endp_list);
 	else
-		list_add_rcu(&entry->list, &pernet->local_addr_list);
+		list_add_rcu(&entry->list, &pernet->endp_list);
 	ret = entry->addr.id;
 
 out:
@@ -1184,7 +1184,7 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	LIST_HEAD(free_list);
 
 	spin_lock_bh(&pernet->lock);
-	list_splice_init(&pernet->local_addr_list, &free_list);
+	list_splice_init(&pernet->endp_list, &free_list);
 	__reset_counters(pernet);
 	pernet->next_id = 1;
 	bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
@@ -1449,7 +1449,7 @@ static int __net_init pm_nl_init_net(struct net *net)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet(net);
 
-	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
+	INIT_LIST_HEAD_RCU(&pernet->endp_list);
 
 	/* Cit. 2 subflows ought to be enough for anybody. */
 	pernet->limit_extra_subflows = 2;
@@ -1475,7 +1475,7 @@ static void __net_exit pm_nl_exit_net(struct list_head *net_list)
 		 * other modifiers, also netns core already waited for a
 		 * RCU grace period.
 		 */
-		__flush_addrs(&pernet->local_addr_list);
+		__flush_addrs(&pernet->endp_list);
 	}
 }
 

-- 
2.51.0

