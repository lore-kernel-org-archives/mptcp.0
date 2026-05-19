Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21462D978A
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169886; cv=none; b=AMGH+ee6Kqrf0Qt85tFiGBH6YHAiYqGuzLRIAAsOv92rvXYOUZ5STcmxQiusObr3TApNqK3lbiBJoekOKBbXP8i/ouqU4yGqN7ekp9PwzU1pYQh99J9N3Nm5mU8CVCcqBnogv0sbp3aE8ROvj7cE6i59Ejt87c6NJZIzOUWakPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169886; c=relaxed/simple;
	bh=SvJ6UYYeQiL72yiPpAAcfIBDJekaKC6uMuZCf/+rsb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QCG63oPj/d3tJr6Ex3tbPYgUgtJB74hFA4IzXYqkPx8f1Y0AprxZegW58CTTN4XFO5Rh5ax6ab5x+PmM2fPLPLYGqAMxPDBjwzlk3A1at83t6BZ1k37HVD/WqYiSIPSq6uaPuTZqIGL9/NKYMTR6KUqDkUZSO0ZbpQUQTcPlZ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhNbantm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhNbantm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9433C2BCC6;
	Tue, 19 May 2026 05:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779169886;
	bh=SvJ6UYYeQiL72yiPpAAcfIBDJekaKC6uMuZCf/+rsb8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LhNbantm/EA1CbZO9YNc8D/6qG8Fj3WnoVxYX6o543Wn+4dSC5wrKx421OOHgE928
	 biX44QEYfNgW6/aWkrDFZ7XAyqS1gVIbOmoicgZyRxSK46phP49Wd2aH3lkRcMTxNj
	 d3VzlP2HSLOjq0L6W0mEChwZsR7jZlujW3guEVCcAgAihjpPeXaLtYbKnlsKTm+5jG
	 F3WIavoRA8xJoC0ah7Mfqlbft50PsR1bGcqlQJMTqRWolKLC9xSLMv7GdKlB3mmbqx
	 VetCgOFsHD6dA76DBmLK72pSlQHzzD2LmNkJTxSmF32rSqQ/wN4N2FuDAnmbH6G/wt
	 PhDn0iKdMNF3Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 19 May 2026 15:51:18 +1000
Subject: [PATCH mptcp-next v2 09/15] mptcp: pm: use for_each_subflow helper
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mptcp-add-addr6-port-ts-v2-9-3b36a51e6a86@kernel.org>
References: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
In-Reply-To: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4858; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=SvJ6UYYeQiL72yiPpAAcfIBDJekaKC6uMuZCf/+rsb8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqC/pSuROnz9W+QhMyV509DHaACy4BbZLtEzxZT
 Nnyn808pIWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagv6UgAKCRD2t4JPQmmg
 c/M7D/0SwIPe6NUNk8hOxuSnAqmUjbk9SHoyhuRGbkkhiiErSe15SJqcyw2EmoM2V1Cq5HMjsMF
 I8OVl6r5+DEsGUsy2GKGy0uuetrJE3VxHE17dFgJZnr2RUIK6PR85c9lRMCz/VVboPnXC0cKqhA
 iv41seZ1M2Q/bXFemjayng4OoVrXMLhowvVHCghAd3XL2FHOs3pK1FIbbIEwU8RFlYKIOq56RH9
 2b2tLsDx/iJ+CU8duVOHNf8VEfH3htpyfMRtNFb1Prn9n+TfixVV6oRPp21LdTN5wp7lDzaarnV
 d6WxDYfwLqCB3DvliUfg62WnbSkOFnzJXl9XijFRDHyhi11PimEmouC3uUzSsJxy5px+ZXGHWZN
 8BEDFjU0Jd/zyTlMguiW6xNAywqAqKqLglIh0SjhfsZagj0DCTfC6wxd2VNBLj8+ichSw2Rww3B
 r4hrEA4nZUkNLyPicx0InMsE64hcvYA5gn+VlsZBLpOvwRFABiBLhp9u8/YcDXLIrnHKEhUxZ40
 evjn3A/JmP2e1ZDP5e7Ns4VDc0Uy+P0za+YpJ8jKT72q4LR1vo8LBkrpnUmtDlsCD8JOtLRb5ta
 PMfaW1C/et5gZhv6S2JmISzsh0VtOmLY1KggtbhWtPqpvgpLC6PjSDACkRW0ton+lC6PsflPJ0/
 8nfiqtmazSapevw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Similar to most places in the MPTCP code. So instead of passing the
subflow list and use list_for_each_entry(subflow, list, node), pass the
msk and use mptcp_for_each_subflow(msk, subflow).

That's clearer and more uniform with the rest.

While at it, add 'pm_' prefix for the exported one to easily identify
the origin. Plus replace 'lookup' by 'has', because a bool is returned.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           |  6 +++---
 net/mptcp/pm_kernel.c    | 12 ++++++------
 net/mptcp/pm_userspace.c |  2 +-
 net/mptcp/protocol.h     |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5e6a32fc583b..5c4ff1dce1a3 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -115,14 +115,14 @@ static bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
 	return mptcp_addresses_equal(&mpc_remote, remote, remote->port);
 }
 
-bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
-				   const struct mptcp_addr_info *saddr)
+bool mptcp_pm_has_subflow_saddr(const struct mptcp_sock *msk,
+				const struct mptcp_addr_info *saddr)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
 	struct sock_common *skc;
 
-	list_for_each_entry(subflow, list, node) {
+	mptcp_for_each_subflow(msk, subflow) {
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
 		mptcp_local_address(skc, &cur);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index ae28c96adb91..8436e66daab6 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -96,13 +96,13 @@ u8 mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_limit_extra_subflows);
 
-static bool lookup_subflow_by_daddr(const struct list_head *list,
-				    const struct mptcp_addr_info *daddr)
+static bool has_subflow_daddr(const struct mptcp_sock *msk,
+			      const struct mptcp_addr_info *daddr)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
 
-	list_for_each_entry(subflow, list, node) {
+	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 		if (!((1 << inet_sk_state_load(ssk)) &
@@ -673,7 +673,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	mptcp_pm_addr_send_ack(msk);
 	mptcp_mpc_endpoint_setup(msk);
 
-	if (lookup_subflow_by_daddr(&msk->conn_list, &remote))
+	if (has_subflow_daddr(msk, &remote))
 		return;
 
 	/* pick id 0 port, if none is provided the remote address */
@@ -1099,7 +1099,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 			goto next;
 
 		lock_sock(sk);
-		remove_subflow = mptcp_lookup_subflow_by_saddr(&msk->conn_list, addr);
+		remove_subflow = mptcp_pm_has_subflow_saddr(msk, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
@@ -1237,7 +1237,7 @@ static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 
 	entry = list_prepare_entry(entry, rm_list, list);
 	list_for_each_entry_continue(entry, rm_list, list) {
-		if (mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
+		if (mptcp_pm_has_subflow_saddr(msk, &entry->addr))
 			slist.ids[slist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 
 		if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d838e8ea65fd..ff0bbd96cd09 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -283,7 +283,7 @@ void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 	/* only delete if either announced or matching a subflow */
 	if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
 		anno_nr++;
-	else if (!mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
+	else if (!mptcp_pm_has_subflow_saddr(msk, &entry->addr))
 		return;
 
 	alist.ids[alist.nr++] = entry->addr.id;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6323b5195b3f..7a0f04e5b08a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1139,8 +1139,8 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id);
-bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
-				   const struct mptcp_addr_info *saddr);
+bool mptcp_pm_has_subflow_saddr(const struct mptcp_sock *msk,
+				const struct mptcp_addr_info *saddr);
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr);
 int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,

-- 
2.53.0

