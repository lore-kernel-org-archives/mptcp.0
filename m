Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3A03264EF
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109164; cv=none; b=kbTo92zWTj4GFjodwQoT7q2ko+XE2ieq/JqSuiB4N0s5a9P5BzlE8GM+t854Iw5dfw7/fgvxwronHCJPrIhulyaBR325f0oiP6pKzZTbrG3i0MkUSyoIUDRY7mhlFpTkBkWw9BSxGW4jv578caovwbmP7cocz41nOT+61Pbt6IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109164; c=relaxed/simple;
	bh=D6akQKCecfCq/chQdSJpl4yJT2FOKkwxDUSNxRoYOpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XX11QPtXE03RJ0sXnKjUY4yA22tQOdDAHxMwZ4h6ZOGHXwqH4yq1NWzAJ+7tI5O2O9GZISctoPfG5gWJcqFry+buokIAySqbdixznOM/H0tHXDJ1LBLlOM/+iqHdA9xPYpC/W6m6+l8bwpc+0uvfeaBQkN+AWUOuYEg9wsDpH8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ytb6r+GV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ytb6r+GV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05089C2BCF7;
	Mon, 18 May 2026 12:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779109163;
	bh=D6akQKCecfCq/chQdSJpl4yJT2FOKkwxDUSNxRoYOpU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ytb6r+GVctbUlbVCNL0PM+Tkp/AVuz94lFXOIg7jFR19vOLZTyJJGj+nEsP9ZxziD
	 O0nmdgkqXmKvmfpRgw+A6fqrF51cOt04nmMc7re7mmyWUxego/u7JPW74M2x7/XI1J
	 4L6jqSXPXmkIa85GivWY/Lu4ON6UDvyUO21q0Zwtr9ZZdtvWgAcKxGL9mdCEsZtQy0
	 EKfYLYKcDzuZLLNop4RVb8lq0tp6jHGm2sFgKUzHn90bp5NLEoOL3hCx5SbupvGq2G
	 cE2MY33qXyw1+NoiWDGkNmrv3j6T7IHCyIpgxKTit/L8LRHP9ze7JO5p4Kn7Z1qjlv
	 MZuRSbhIsoPeg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 18 May 2026 22:59:10 +1000
Subject: [PATCH mptcp-next 06/12] mptcp: pm: use for_each_subflow helper
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mptcp-add-addr6-port-ts-v1-6-f1ca26977fcd@kernel.org>
References: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
In-Reply-To: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4858; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=D6akQKCecfCq/chQdSJpl4yJT2FOKkwxDUSNxRoYOpU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqCw0h/FXGM0+/nxI07U4VlDW5VTtA8HZsmrW94
 Yj/C1sb7/6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagsNIQAKCRD2t4JPQmmg
 c1RcD/4leedzm6JVal00O9BBtyHoWpseLPAym0wBSza1GgkpJgWNZenDaX3xiuNlQ+15ab3S8zw
 gXcjgwx6AwIrQfKK0ysHqKlRvP8V2ZaXDyivp7LnjEE+0XCtMG8HURW77NMzQQVceerEZT7j/O3
 2P/3urCC+kHzLW4W83obFmLUXboSV4cllt2ebEr5Y3UN/A5pFh3C9cTUsZFcBh5ar8LKxcHrGlU
 YclV9m/m5aCXJ5rpf+76vZhxjsswiMdoWqERAVe4ycjBhT7TZHxMfAdEfs4Z3xgDxILxKhlviMl
 jT5FTyPgARaSLXYSt0yXiQ9b4iFWrqnOfWQ3n8MWv46+uel/Rw/Blw/ZPI6RMkwY1X0cMOkJ169
 +IQzWxFksJJV5fBDKmR5IfjpAMNmjBxK2FZMs3vfDtmjyXtBrS6xNGoZlnl1wdwGIaB/kZhxAi/
 AjNrf0XDFreQb7qYDr4dxYDdW+ZsLynoSqY0sZ+upu1Di6pl0H4+IDbO6C9PQNKl4czFKllt3YS
 9z0fiouP8N54Y7erZqh6okhd6Cn6jbUDZtnF/hSDVZ2DTt3N7+HUIvPM8RbB/6WX4JjYKyWeQc9
 bzkggpxmPoEdKDwdU9xnMsP/vtK6CDSNy0rr6vEAIWjrsaSj2pqjBQWfIS0k0B+IrE8vAcbIlCg
 meG9Y3dYKPDLJeg==
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
index ad496ff3d6ad..55d6427bab92 100644
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
index c84e630c6e57..2987f88f465a 100644
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

