Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06DF2EA461
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 09:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272919; cv=none; b=pze8I5Ptd7CsbRZOXgcTX9JpAkwijb3oZ78jIadP76gRkursuiVnex9II8AyPGaR9H+AsewgLjwuNJVv1KD3SfsiuLDVaI2RkvD6qpiFPxMSHn3cFsPw9BPCC5oRPbfQQF4hghxPnwlgtngSI+O+XauPd8hniP7mLpEj2Diwcik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272919; c=relaxed/simple;
	bh=+oNi5BaDD0ui4ZuKPMSj+THCtiJg0wfC7uQ7iEAfCYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t2zU12MIOOoOR17TQkzkdXKyGlzxQLPy456HDmMgLL8KohKHwzcOnhLnBTtkyPB5b3DlRevl9eYCHj8apevyWEBy6MO5Oico8f9B0eCYl35t2XiSNZiwRu0V+mGC+uEPGTVTVgNOJuvG8WeiuW8xMkcnM8X/nfdvlA9QW88xEiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvQN4H2v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvQN4H2v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBE5C4CEF0;
	Fri, 19 Sep 2025 09:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758272919;
	bh=+oNi5BaDD0ui4ZuKPMSj+THCtiJg0wfC7uQ7iEAfCYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XvQN4H2vSoD89HjHid4HLZHFYGg/d6b4s5E2ZR/lUfLAg5Y+hLeVB31M5LVrZ1PyG
	 AFAkM6q/nLLAa5zzXsQTXTMbfEOVWF2h9XKZB3Hk3d/ozXhPMhldpUzaRLa/ugLHXs
	 fKlm2hgsj8X4bHHDX92HpMDIaLr7exoHJZl3iQ+H09BqQzZpNz413MfuKsyPyKvTGd
	 dPGPyntfOtIbdlSEPjZf21PZv9vnlAIFZh/CqunSn18jRV+zw5G6io/FwpWsK696Gs
	 uOneIK7b3FEoG93zbw5aDxDnlNW0ykYs3bVb+GPzvnTsNE6YSm0dReHw/TzA+AZaML
	 zvtBtMPs4PlsQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Sep 2025 11:08:12 +0200
Subject: [PATCH mptcp-next v2 06/10] mptcp: pm: in-kernel: rename
 'add_addr_signal_max' to 'endp_signal_max'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-pm-kern-endp-add_addr-v2-6-1f8f04f01914@kernel.org>
References: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
In-Reply-To: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7189; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+oNi5BaDD0ui4ZuKPMSj+THCtiJg0wfC7uQ7iEAfCYc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOynYp75iW+mu7hEHJp50rT039rskq5TwxTrHh9559n
 0O153dJd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEwkw4Phv+O8IoZdr8Kta3uX
 zg/8cWWv9mXNdae/Hv0fY/Hx/xzu66wM//M7TyZsfBzwunfe1EZLzUl7Wy8y1W4s781vSvpUvYz
 PkBkA
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
index ae6b8000ca61539c6927811558bb78dcb11531e4..1c6d0a21c346da90f6bb85d9a281b606dcc576e1 100644
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
@@ -275,15 +275,15 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
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
 
@@ -312,11 +312,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
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
@@ -690,8 +690,8 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		pernet->next_id = entry->addr.id;
 
 	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
-		addr_max = pernet->add_addr_signal_max;
-		WRITE_ONCE(pernet->add_addr_signal_max, addr_max + 1);
+		addr_max = pernet->endp_signal_max;
+		WRITE_ONCE(pernet->endp_signal_max, addr_max + 1);
 	}
 	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
 		addr_max = pernet->local_addr_max;
@@ -1090,8 +1090,8 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -1177,7 +1177,7 @@ static void __flush_addrs(struct list_head *list)
 
 static void __reset_counters(struct pm_nl_pernet *pernet)
 {
-	WRITE_ONCE(pernet->add_addr_signal_max, 0);
+	WRITE_ONCE(pernet->endp_signal_max, 0);
 	WRITE_ONCE(pernet->local_addr_max, 0);
 	pernet->addrs = 0;
 }
@@ -1501,7 +1501,7 @@ static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
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

