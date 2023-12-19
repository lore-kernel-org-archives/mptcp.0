Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248901B274
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pBseVT1s"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702992708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Li9lFIPJk+suN5sphynXyeONR8VesPy1/x5786HlBE=;
	b=pBseVT1sqiUCS+CYx1xrwH6Y03F3O7oYNNUFtcLvwOtsFLAdLMvnOf8WXj/KN08tOc3v1o
	WHMsjucUsXEIv20EHbHgLzBhZsGIl+7JPxze3B32/im1ynWdO1ufYoyG5dbBcaIa2AaA03
	LZpqo0zEMonx8K0hLG6B1GozwULMzco=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v4 01/14] mptcp: export mptcp_genl_family & mptcp_nl_fill_addr
Date: Tue, 19 Dec 2023 21:32:05 +0800
Message-Id: <09b48a8894d10e9d6f2f7472e9c42da5f8318496.1702992525.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702992525.git.geliang.tang@linux.dev>
References: <cover.1702992525.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch exports struct mptcp_genl_family and mptcp_nl_fill_addr() helper
to allow them can be used in pm_userspace.c.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_netlink.c | 9 +++------
 net/mptcp/protocol.h   | 4 ++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1b754cf525de..29fdef4cfdfd 100644
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
@@ -1614,8 +1611,8 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
-static int mptcp_nl_fill_addr(struct sk_buff *skb,
-			      struct mptcp_pm_addr_entry *entry)
+int mptcp_nl_fill_addr(struct sk_buff *skb,
+		       struct mptcp_pm_addr_entry *entry)
 {
 	struct mptcp_addr_info *addr = &entry->addr;
 	struct nlattr *attr;
@@ -2259,7 +2256,7 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 	nlmsg_free(skb);
 }
 
-static struct genl_family mptcp_genl_family __ro_after_init = {
+struct genl_family mptcp_genl_family __ro_after_init = {
 	.name		= MPTCP_PM_NAME,
 	.version	= MPTCP_PM_VER,
 	.netnsok	= true,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f7b9c1b995df..9b0b3fa65ae5 100644
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
@@ -961,6 +963,8 @@ void mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_
 				   const struct mptcp_options_received *mp_opt);
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req);
+int mptcp_nl_fill_addr(struct sk_buff *skb,
+		       struct mptcp_pm_addr_entry *entry);
 
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
-- 
2.35.3

