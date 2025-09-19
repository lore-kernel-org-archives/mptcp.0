Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597C01BEF7E
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272922; cv=none; b=DTal2WHMYpF+M0CPMrzGA3fzeW+o+qx8jybbNI90zoHmwdOvihoK4pPdtydfsC1IRK1oZd4o9d6XW+gAxq3hyTfs9bx2yaT3VLgAsioXZGx0PZtdcGHwuvJdxUO5wVBtDSPaKA7zfnM+oA655doRupA8ixBzEr9M933/7DAKV2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272922; c=relaxed/simple;
	bh=ZqeA7A96Rq/XQqHJc1YWfhwJ9DHJQ4TOD7MQ2yLDfmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WEM2iffmrjxd+LKLwU4N+ah2IpcbUpmTulKq/ghz1ZxkpecRCpIOprADn1bdcwtLTvDJTTERry8AzboN+eZehSSR/QMh8rr6lHm4R8MmT2wRDjXFK7muQumeLyCtDHlnF3Aeq8aC44nGWLxLA6G2ZxVrt8SJlovrjHVCb4zxPZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpsxrVxF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpsxrVxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62516C4CEF0;
	Fri, 19 Sep 2025 09:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758272921;
	bh=ZqeA7A96Rq/XQqHJc1YWfhwJ9DHJQ4TOD7MQ2yLDfmU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FpsxrVxFbRsB6AMxurhb9FwnQOUAdPgiW1Jr7Xfn1ueXxEiERVDr0x5gbA1Y02fT2
	 +jO67GBAaRQR2XmuyDHBluFkwVzNkCdoDnwpfa1JBkWrYlJwFBO3Po0PN7JQr2InJk
	 ZAxVVxR4ThuXzSRGxrOKS29RjQPE8onSyL0Zewkuv49bTXKBPyIlDZHdvy/J/2nbdo
	 x3TISYX758Vv4uGgzNO1FWSutExhcl4r5IfG16fXpsILg1YzrtlF8Js7x8/ynXxw28
	 M3MbNj6fx2wMwk990PfAl9n/GlfKtKPDurlSVcEKWcYOiOIMU2FRNtmq0a+sI8LNoF
	 3vQaAWqYjNZ2A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Sep 2025 11:08:15 +0200
Subject: [PATCH mptcp-next v2 09/10] mptcp: pm: in-kernel: rename
 'local_addr_list' to 'endp_list'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-pm-kern-endp-add_addr-v2-9-1f8f04f01914@kernel.org>
References: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
In-Reply-To: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4732; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ZqeA7A96Rq/XQqHJc1YWfhwJ9DHJQ4TOD7MQ2yLDfmU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOyvYbbDQqOe9tescwIpbr3YYfq/OEJRYkLijasWmXH
 XM8Z9+hjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImwvWdkmJnyrTG8ZceH3dOf
 Bpi8i3nMZDh/pjXras+iT2Ydx1kWngaqENrLfmxF/Ql7y7X2c2br6v3ti9yhvNvlmk3SpGM/m02
 4AQ==
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
index a4f7ea1f43f6c7e9de6a36b84285d4dcc8731ca2..39ba27aa731ae10df4c34a387b6c0e4c9c6d21cf 100644
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
 
@@ -250,7 +250,7 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list,
+	list_for_each_entry_rcu(entry, &pernet->endp_list, list,
 				lockdep_is_held(&pernet->lock)) {
 		if (entry->addr.id == id)
 			return entry;
@@ -263,7 +263,7 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list,
+	list_for_each_entry_rcu(entry, &pernet->endp_list, list,
 				lockdep_is_held(&pernet->lock)) {
 		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
@@ -413,7 +413,7 @@ fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
 	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+	list_for_each_entry_rcu(entry, &pernet->endp_list, list) {
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
 			continue;
 
@@ -641,7 +641,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 	 */
 	if (!address_use_port(entry))
 		entry->addr.port = 0;
-	list_for_each_entry(cur, &pernet->local_addr_list, list) {
+	list_for_each_entry(cur, &pernet->endp_list, list) {
 		if (mptcp_addresses_equal(&cur->addr, &entry->addr,
 					  cur->addr.port || entry->addr.port)) {
 			/* allow replacing the exiting endpoint only if such
@@ -703,9 +703,9 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 
 	pernet->addrs++;
 	if (!entry->addr.port)
-		list_add_tail_rcu(&entry->list, &pernet->local_addr_list);
+		list_add_tail_rcu(&entry->list, &pernet->endp_list);
 	else
-		list_add_rcu(&entry->list, &pernet->local_addr_list);
+		list_add_rcu(&entry->list, &pernet->endp_list);
 	ret = entry->addr.id;
 
 out:
@@ -1191,7 +1191,7 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	LIST_HEAD(free_list);
 
 	spin_lock_bh(&pernet->lock);
-	list_splice_init(&pernet->local_addr_list, &free_list);
+	list_splice_init(&pernet->endp_list, &free_list);
 	__reset_counters(pernet);
 	pernet->next_id = 1;
 	bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
@@ -1456,7 +1456,7 @@ static int __net_init pm_nl_init_net(struct net *net)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet(net);
 
-	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
+	INIT_LIST_HEAD_RCU(&pernet->endp_list);
 
 	/* Cit. 2 subflows ought to be enough for anybody. */
 	pernet->limit_extra_subflows = 2;
@@ -1482,7 +1482,7 @@ static void __net_exit pm_nl_exit_net(struct list_head *net_list)
 		 * other modifiers, also netns core already waited for a
 		 * RCU grace period.
 		 */
-		__flush_addrs(&pernet->local_addr_list);
+		__flush_addrs(&pernet->endp_list);
 	}
 }
 

-- 
2.51.0

