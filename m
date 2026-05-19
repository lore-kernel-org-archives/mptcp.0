Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076F43E5EE8
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225938; cv=none; b=a39YaTaSN8+C+ULckzXVzMUXwczPbiF5Q4uAE0PsfvE14JRKVTgvgLmjel7iQZKeAQyPBFRIPrLWTBCqC6jTdEMrZDEOigiMxbGiZfyCYGJitSLfAbGZ22yydjGnrO9Vg9W7dQEfzu1Y/HdbOW7kAi6i1FSOw8l5u+fDHlvKg/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225938; c=relaxed/simple;
	bh=+GeSStJqDp/Y/y9qQusHIJhJZQABlXmiVVzPEVe6NfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c04UPLYcA0VDm+GHLcEu43OQ1Dvu8QxS8cH7YHu9a08HELAA1lEJfVSaL0KTOvBAnkH2XluYdeb01XfaD9y5zQWntQMB69UcBIpV6/jbGH3WfPv1JRe8XCCNgLH2ap/CQdJGt77gbOMvnblXK3Gp/wc8Z7vGoQvHLr8W2jLGNzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4g+LtO8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4g+LtO8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEA81F000E9;
	Tue, 19 May 2026 21:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779225936;
	bh=8eYGKQrzfJHnh7qWtZy0+GYL4RwcEhLCYUfMuYp3RZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=m4g+LtO8HO/cmmKTvCipTVOWF9dDZehzReridQdtqn1PwxtCxa51ziU2+EbWDiEPj
	 kN0Ggghc6KOKcpoCAKDO8zC5G/rb3z2t15qbjHNBngCLcnbp+nHqieryNwJov+QnoU
	 Z1cg+6TSnpPZII44SasWZraY1fWyTQaz5vDa7V3NUW3OCaXcxT31mb24MRNENT/S2P
	 ZWJ47QLV9k/3lbsJExpEOntPVRQqPXzD3Fa4sQyRpVuyJx6DWswIZS8NAPBsYi1qjN
	 8NnR7j+VynpTzdCgVIgQ1kge6qPZw+xNnm8nlx1Idh4s5UWhij7CQndckHpgJUmem0
	 iVXIDr8JiHu2A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 20 May 2026 07:25:21 +1000
Subject: [PATCH mptcp-next v3 10/16] mptcp: pm: use for_each_subflow helper
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-mptcp-add-addr6-port-ts-v3-10-bffa658a7678@kernel.org>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
In-Reply-To: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4858; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+GeSStJqDp/Y/y9qQusHIJhJZQABlXmiVVzPEVe6NfU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqDNVBYPb2lxdaZelOFfK34+OU41j9R6sIVDBSt
 rZjcPS6/JmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagzVQQAKCRD2t4JPQmmg
 c4GREACC6AFe9jUJCAYD+3CFx6RtqCArDPlAGO0LQaQFaSD9l6x5oFVG2NTdIcdv26CisyRh9pW
 Boea+OF/7RWeFAWNOgyYqnz6ANNMl9xECppJeLeujc5pYOFE6mvziWxVi6to2adqjmKswWpSXqX
 UK4VxH165jhI3+1O4D1UlBA0ZooMmeFY0g/eycm1fvVpRu4bshgNx8ryVAm/44waTKq5gSFEJsP
 zjkQLboB1u1eD4eIZYSHZrubrcObH7qtf6uBrbhkOc10snkwxDskPulmvyZfGoJKXrzAg7o3iK+
 +u2GpBk08aBxPss4Pfd5guwtgholpuvt4yBNFu4h40OjiU3w0Yu4BY6gtexl/JI1o/yC5CjLY+P
 Ne/4uCfc2asVURbz9NfvXz+3CzmPkz7jMBfz8sRjXURwGX/cMVbIEjT8mqNMpKllu5g9cmMFPCP
 3f9ov42yKPsvf44WX0+zaNQDyoBD7cBZVIhiwZiubdq6e6lAutAXyY4LPQFvFxif59VFnZBEhMN
 UITfItiWpN9+orpV3GZuGT2DSe5nKRjVQ4Gh0nX+bMwys/76P+hyx5OpM/rxUr85wSiKDdirw2t
 L+J1UVCn7WnDT47QX6qxfsbSFy3U29vm+ONEzYLSfQJJNCO2axd8iCaUBKBNB/2viGWIhaX7TRN
 Jj5afMwDfXYBiXQ==
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
index cc07cfef67dc..f7d00be60ce5 100644
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

