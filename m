Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552E22FF167
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217368; cv=none; b=Glfr1AErqqQU13fnZgi40bxLyyOOhCPHjsm01hEYrtCdsT7aGs2M9YPavj+AeQsRuaOPDNZnKAggC6YIKWXfjMgFOBNS/s6cvhqHZqciVreFxDB7MWTcicx603H7yh0IXaHlkoMvzvbP5ugVvNT2YQg4t8WRm6V2E4tFi/KL0OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217368; c=relaxed/simple;
	bh=o7yRTrAyyRKFeBWMuzmL5+OpCH6sBT7WZih6K07HQWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T+B64EWFFubRRofZ7LxqyM67H09obLmYWJli+AbX7+m+GfVQ4Op/8cSujuYYFzlNAniMRjNxDPxyHhHoeDc6StYXV1B1sU06hu1Off02qyWeWzFvbHp/+dZC7bKWuhpq0Ss9+maFM0/SEOJB9ODjocQTRf2WFjcDMHlXVTutV5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbCsUlTc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbCsUlTc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD58C4CEE7;
	Thu, 18 Sep 2025 17:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758217368;
	bh=o7yRTrAyyRKFeBWMuzmL5+OpCH6sBT7WZih6K07HQWA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RbCsUlTcT9dTctSmnJFBHb4lGcMHNrqqvU0slVzT9oZhcSZz8YiKHadkvwZ8g7GAP
	 XRHN/cgBflwWbv8c5lJPDCcQ/p9drnC7xU6OPCA0S/VDOL7n/zkxpe45iveyt4xLcf
	 0d0I937DCpHFIcIWGde0ITlb6dpry8tyJ6nz0Yn71xo5/DwrUz7a59sK/1/TG3tHsV
	 6EFe6X2wwAWyuoW2whZ31+hoqK+2j3FMHFtrFshFyL3J12lq445Tk4wI8nVCjJpL//
	 pQqlAJrSC/9aq9y0nfdxFJbK0GcmBIfuUOVj3g1lk57c1FAslS/pcTxgyJ05Ifaa9S
	 38X6omv3lRHCg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Sep 2025 19:42:22 +0200
Subject: [PATCH mptcp-next 06/10] mptcp: pm: in-kernel: rename
 'add_addr_signal_max' to 'endp_signal_max'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-pm-kern-endp-add_addr-v1-6-e12e58770a11@kernel.org>
References: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
In-Reply-To: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7189; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=o7yRTrAyyRKFeBWMuzmL5+OpCH6sBT7WZih6K07HQWA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOuPQ4ztX0lmZ7+I2J/3bXPhHFlCPyR78scDgyqbPsJ
 ZPy48TEjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkEn2b4n6f48bPkBA82jk2O
 bwIv6O69/XKX4CXGfUv+CW/crL58ZhjD/8j/ZYuK20xYLsVcVHD8ZHWHX6ai98adzdGbG07W7Ld
 z4wUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A few variables linked to the in-kernel Path-Manager are confusing, and
it would help current and future developers, to clarify them.

One of them is 'add_addr_signal_max', which in fact represents the
maximum number of 'signal' endpoints that can be used to announced
addresses, and not the number of ADD_ADDR that can be signalled.

While at it, add an additional name for the corresponding variable in
MPTCP INFO: mptcpi_endp_signal_max. Not to break the current uAPI, the
new name is added as a 'define' pointing to the former name. This will
then also help userspace devs.

No functional changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm_kernel.c      | 28 ++++++++++++++--------------
 net/mptcp/protocol.h       |  2 +-
 net/mptcp/sockopt.c        |  4 ++--
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 314200c61f150da445ff87debb154bfd98f324fc..69fc20db1c2f731d5f93cfee4e58a23119ff7a97 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -48,6 +48,7 @@ struct mptcp_info {
 	__u8	mptcpi_subflows_max;
 	#define mptcpi_limit_extra_subflows mptcpi_subflows_max
 	__u8	mptcpi_add_addr_signal_max;
+	#define mptcpi_endp_signal_max mptcpi_add_addr_signal_max
 	__u8	mptcpi_add_addr_accepted_max;
 	__u32	mptcpi_flags;
 	__u32	mptcpi_token;
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index e61d417da2154809ad83da5a1b8eede1216a2b5a..eb046d4b0d72ffe20a56a07781a8862b389c93bf 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -20,7 +20,7 @@ struct pm_nl_pernet {
 	struct list_head	local_addr_list;
 	unsigned int		addrs;
 	unsigned int		stale_loss_cnt;
-	unsigned int		add_addr_signal_max;
+	unsigned int		endp_signal_max;
 	unsigned int		add_addr_accept_max;
 	unsigned int		local_addr_max;
 	unsigned int		limit_extra_subflows;
@@ -46,13 +46,13 @@ static struct pm_nl_pernet *genl_info_pm_nl(struct genl_info *info)
 	return pm_nl_get_pernet(genl_info_net(info));
 }
 
-unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk)
+unsigned int mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk)
 {
 	const struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
-	return READ_ONCE(pernet->add_addr_signal_max);
+	return READ_ONCE(pernet->endp_signal_max);
 }
-EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_signal_max);
+EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_signal_max);
 
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk)
 {
@@ -271,15 +271,15 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
 	unsigned int limit_extra_subflows;
-	unsigned int add_addr_signal_max;
 	bool signal_and_subflow = false;
+	unsigned int endp_signal_max;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
 	struct mptcp_pm_local local;
 
 	pernet = pm_nl_get_pernet(sock_net(sk));
 
-	add_addr_signal_max = mptcp_pm_get_add_addr_signal_max(msk);
+	endp_signal_max = mptcp_pm_get_endp_signal_max(msk);
 	local_addr_max = mptcp_pm_get_local_addr_max(msk);
 	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 
@@ -308,11 +308,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	pr_debug("local %d:%d signal %d:%d subflows %d:%d\n",
 		 msk->pm.local_addr_used, local_addr_max,
-		 msk->pm.add_addr_signaled, add_addr_signal_max,
+		 msk->pm.add_addr_signaled, endp_signal_max,
 		 msk->pm.extra_subflows, limit_extra_subflows);
 
 	/* check first for announce */
-	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
+	if (msk->pm.add_addr_signaled < endp_signal_max) {
 		/* due to racing events on both ends we can reach here while
 		 * previous add address is still running: if we invoke now
 		 * mptcp_pm_announce_addr(), that will fail and the
@@ -686,8 +686,8 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		pernet->next_id = entry->addr.id;
 
 	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
-		addr_max = pernet->add_addr_signal_max;
-		WRITE_ONCE(pernet->add_addr_signal_max, addr_max + 1);
+		addr_max = pernet->endp_signal_max;
+		WRITE_ONCE(pernet->endp_signal_max, addr_max + 1);
 	}
 	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
 		addr_max = pernet->local_addr_max;
@@ -1086,8 +1086,8 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
-		addr_max = pernet->add_addr_signal_max;
-		WRITE_ONCE(pernet->add_addr_signal_max, addr_max - 1);
+		addr_max = pernet->endp_signal_max;
+		WRITE_ONCE(pernet->endp_signal_max, addr_max - 1);
 	}
 	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
 		addr_max = pernet->local_addr_max;
@@ -1173,7 +1173,7 @@ static void __flush_addrs(struct list_head *list)
 
 static void __reset_counters(struct pm_nl_pernet *pernet)
 {
-	WRITE_ONCE(pernet->add_addr_signal_max, 0);
+	WRITE_ONCE(pernet->endp_signal_max, 0);
 	WRITE_ONCE(pernet->local_addr_max, 0);
 	pernet->addrs = 0;
 }
@@ -1497,7 +1497,7 @@ static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 	WRITE_ONCE(pm->work_pending,
 		   (!!mptcp_pm_get_local_addr_max(msk) &&
 		    subflows_allowed) ||
-		   !!mptcp_pm_get_add_addr_signal_max(msk));
+		   !!mptcp_pm_get_endp_signal_max(msk));
 	WRITE_ONCE(pm->accept_addr,
 		   !!mptcp_pm_get_add_addr_accept_max(msk) &&
 		   subflows_allowed);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index acfe46e530cd75b14b33d9f4940b90fbf2867517..31da0aa0f52443c16324dfe2a266252994bf656c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1177,7 +1177,7 @@ void __init mptcp_pm_userspace_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 4e82bcfcd34e3a1dffb05799cf181ee2940e75d7..4688e0f25d15d9363b33bdcf3ad75c8295a810e3 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -974,8 +974,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	if (mptcp_pm_is_kernel(msk)) {
 		info->mptcpi_limit_extra_subflows =
 			mptcp_pm_get_limit_extra_subflows(msk);
-		info->mptcpi_add_addr_signal_max =
-			mptcp_pm_get_add_addr_signal_max(msk);
+		info->mptcpi_endp_signal_max =
+			mptcp_pm_get_endp_signal_max(msk);
 		info->mptcpi_add_addr_accepted_max =
 			mptcp_pm_get_add_addr_accept_max(msk);
 		info->mptcpi_local_addr_max =

-- 
2.51.0

