Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51A07082D
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 03:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024934; cv=none; b=JzMREdySf96acTqycI5S2pKREAhB61Di3QcC6MoUVt9q4jntPP1lv17jXXPtY1djCnX/4olMu1iVeC0fFnZFB5UG0Y2JgJhE3elj1AtONQQKspg2WCUFtl0BZGsrtPCZaFHyl0xAfqMcbVcA3Bj2LD87gD1sd2nL/TVfddxukUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024934; c=relaxed/simple;
	bh=KLJjoQk3knGnd478jSo84lYpTH/0kBtbEzSIxHwUUpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qe2QU7XyzLRZrjd5NyfE938KibbUWTzv/IzJsLg/KdXmpR64Z8wsxwDL/SuJzgKdFQi0VZmc3L4SEm3F4tphGzbKNK27TpatpfVtKkdZdVRYujmBds3oXA+1ggszVIeOCta/QJR6wurJJs/4XdwmYLSZCc2fNWBy3CdT8YzEvZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSwf8wnH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSwf8wnH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84301F00A3A;
	Fri, 29 May 2026 03:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780024933;
	bh=tplI13hOHUxE0HDL81Lp9//6cwD13Qq7Tu3aTqXovd0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MSwf8wnHM9TxRa9TxLSpDyeRv4bxHpMkQaleFQknjGKSDAdFfA+n7mIdSI4hRraUV
	 KJsnAF92/Py/5hePNNmQs7WT6//cazub0iIw70BN9ihxOnED0DsqGHG+3ehva8JwPw
	 +aZ8omK8gM/H1o7ACHotE0TK2kYlWa4vYwzyLQgpgoJVHW9+Ddy5vSgfWvUv8b7bjC
	 Dqmz128ke5+W+NPk2vmHp5ZFO6ugITeBk7M9SlaRtGaq2WHAdszIhAtbUdON0KTVlT
	 TEj3W5WQuiroNd2TSjErk0YdIOFheUFSyxPjNegob7oId4WzGcpLu9uoU62VleU7lQ
	 ebiRiOeEQj3dQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 May 2026 13:21:48 +1000
Subject: [PATCH mptcp-next v4 10/15] mptcp: pm: use for_each_subflow helper
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-mptcp-add-addr6-port-ts-v4-10-cea393fa33a2@kernel.org>
References: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
In-Reply-To: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4858; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KLJjoQk3knGnd478jSo84lYpTH/0kBtbEzSIxHwUUpw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqGQZWUu1CCKFswTVicyp4mDWFImwk0MWE8xt6m
 yWmGYdd8CGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahkGVgAKCRD2t4JPQmmg
 c5KdD/4iuGK5YlsyFpwRA0TPdEphxNbVJrrIMvB/QxnNfMgnqBI63BaW4fR4piTs+NT822qHoKX
 gQpR+E0w5I9jz8QBRB19eHoR9VnvWlBYGurwDGURiv0jMCJaIoeVTm4p35IiNTmV1I4rBIr3Y1O
 XgUtF3sZt7HqHmcKeDke+TEPVjEBy98H7qGzXQAkpzK9jWNRlwXO+blVTZwc8fNt78CUgSuEHm4
 VMdPFhdTbMGJ2jVasnyKU2hWFsNflquO3FC5oyhXR5an6bW0LRVqOcLXk4aQu3AbBgkxPHpHZiL
 pFhqnan6ZhbBAAdJ8uQCRm6L8m/xh3Elc9+Hn23EdTi70yJROyck2cqhzlPxHekreSPHETqTgFB
 byQrMaXFFz1z8qOP8DEoOOeSo0Een+M05mqf6VHclqGyT5sPPxvqFjDueu5TyU7sIHXa0P8Mjwe
 E+bk5bKXfT4WMypFYIxQM92x9jAUk6v8h5JqVIAvad1VcmB52Nvzj6rhQ0xbSEetvBGMYIllqY8
 Gx5rsSnoMVNHl1yNLZsQdint6fo2DWIuc3Uq+FIqmgvOHre6ds1tmMe+dE2qXZVZiGoqUsPa5R9
 W3rk7Rih4IaEqigVchYB5oYdzNJP4BbgDikCKwZKzFAYmWlOCogD0C+pZztqdj7UWLwxgRn25Xl
 CQDYhpuYy05dIRw==
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
index f63c6b117f97..08d06090a0a0 100644
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
index d285df7d41d2..74d00b2f2a76 100644
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
index bf4607c1fd04..1d9834252515 100644
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

