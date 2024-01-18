Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D1E8F40
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558337; cv=none; b=GPpcns5WkgB0rl8VnEPru3horjpJI5/fCM9PEHe3vxswwZmSp82bITlv6Yg3EOVuJkuBMRFjakOsdTe3vktQSrNVk0B/TuhjluYUeZ+nQU3hR4t8sdUSmfo5cRvnF809jQzh5G0lBIj5f27pNy5g2MajVsBdYRLWeSwJFfEORoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558337; c=relaxed/simple;
	bh=R1YiAPoeYvtDLUT2Kdo7R4fxqxuI943y84vpRK1qB2E=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=IUVRuT5XQ56WnvxCZlvnksNSs6rqow+G2o/Sh23EUundnDsgKqqHQZyf/7qoAGVY/QLyCkATdO0MOO5pDOm/kIaHvZb9ZAWCa66n5Be4fpsO1c4oNEsuNcVTco8Axy7T8Ridm511blpKDtAz5T/rNJ+1rnppIF41fw8P1Xpi/OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7Ky8rug; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7Ky8rug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE73C433B1;
	Thu, 18 Jan 2024 06:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558337;
	bh=R1YiAPoeYvtDLUT2Kdo7R4fxqxuI943y84vpRK1qB2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j7Ky8rugSgDUT8/gy+V1UNoRPs79YJ6JhvAHkFzy8jQajZ8dTy5r4Z9bUIv5KaK3v
	 EtG/UGzWUsqMdVM/6Fbv36VpOP7Gf4E0+vPIguP9TaL4c4F5oIFY1KIYH+sqbDPqRm
	 GL8WEPYYHhWAjPMe4K0g2E0qtVNTkW9WiirVftxBiy1uwKv/gnih3mopsGU05egr4N
	 bllP9oM2HSXH0WI3x8zSkvHsldFcIQtVa+qjym9hK1pbt+P+O5QABZhHzdAaiVfA3M
	 QkJfm7IDsUmovVz9+BR9Y7xqy1hQsb6byTkXiVNBpRfKjhlesNO3w2v07XX5j2Kcji
	 VzHTejCUYRvAg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 06/23] mptcp: export mptcp_genl_family & mptcp_nl_fill_addr
Date: Thu, 18 Jan 2024 14:11:46 +0800
Message-Id: <04e2fc9358a9068a4d12296cf443460d53ed51fb.1705558030.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1705558030.git.tanggeliang@kylinos.cn>
References: <cover.1705558030.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch exports struct mptcp_genl_family and mptcp_nl_fill_addr() helper
to allow them can be used in pm_userspace.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 9 +++------
 net/mptcp/protocol.h   | 4 ++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d158bfab1abc..1c3091fc4e1d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -18,9 +18,6 @@
 #include "protocol.h"
 #include "mib.h"
 
-/* forward declaration */
-static struct genl_family mptcp_genl_family;
-
 static int pm_nl_pernet_id;
 
 struct mptcp_pm_add_entry {
@@ -1621,8 +1618,8 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
-static int mptcp_nl_fill_addr(struct sk_buff *skb,
-			      struct mptcp_pm_addr_entry *entry)
+int mptcp_nl_fill_addr(struct sk_buff *skb,
+		       struct mptcp_pm_addr_entry *entry)
 {
 	struct mptcp_addr_info *addr = &entry->addr;
 	struct nlattr *attr;
@@ -2266,7 +2263,7 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 	nlmsg_free(skb);
 }
 
-static struct genl_family mptcp_genl_family __ro_after_init = {
+struct genl_family mptcp_genl_family __ro_after_init = {
 	.name		= MPTCP_PM_NAME,
 	.version	= MPTCP_PM_VER,
 	.netnsok	= true,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0d634e01c47d..bfb1bfea83c3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -341,6 +341,8 @@ struct mptcp_sock {
 #define mptcp_for_each_subflow_safe(__msk, __subflow, __tmp)			\
 	list_for_each_entry_safe(__subflow, __tmp, &((__msk)->conn_list), node)
 
+extern struct genl_family mptcp_genl_family;
+
 static inline void msk_owned_by_me(const struct mptcp_sock *msk)
 {
 	sock_owned_by_me((const struct sock *)msk);
@@ -964,6 +966,8 @@ void __mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflo
 				     const struct mptcp_options_received *mp_opt);
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req);
+int mptcp_nl_fill_addr(struct sk_buff *skb,
+		       struct mptcp_pm_addr_entry *entry);
 
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
-- 
2.40.1

