Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9F41A58E
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910852; cv=none; b=qlM3LEokd7EtLjYHLUVKcdYMfLoUe4/Q5/WcpTiQPaLV0nz1RmgGJI2Os+bM44DpHFw3u5kG1bY8y/NWdNgTnnealB+wKQdfZweHL9d81fzE4/vZk11LvCaeIHXBTqANCtwIkkNHX15Tab3Mtht8Rm2sDpoQIeLEajewWxGOTgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910852; c=relaxed/simple;
	bh=8c1yyNExST0iOyTH4GSXbdVGozpOeodQucCFwVqh+4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HYIAHDWpRew6+SbuJCzjPbXNujCzgsn53CcYANBnpMEPQpVZxKcSa1rUSuZRDhgI0ggp4/iL7WICN5uz5EFwHEmzNCfO+Q4uzmpT/QgUPwLGWe6wW5gNU1EuNTtbwSetDcI193DKwx2elnsmDvXRvl3YCVF3gzRCj++DK326Pxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4MqnCqZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4MqnCqZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1FFC433F1;
	Wed, 14 Feb 2024 11:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707910852;
	bh=8c1yyNExST0iOyTH4GSXbdVGozpOeodQucCFwVqh+4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n4MqnCqZNRJkSenL6STo3sQ2SQj91GD85KSWSt+b+U0C77ncEfDlen6fDe6/16yqG
	 VrK1bjxQaHUj/caAHG1KlNUj2NDxNw9amkq+P1YEIz1HMx7w/WiCU8Vvl1ENptOind
	 BTXThYWZ7pZ7CziG/g1Df4GcEunvJFeU1nkuEKi+O89tNqsg7bE04IDinOWGx5dJwx
	 sxbgl3PFb84Ks9LkDsSu1gFHOsgvupJDbupIRNwiUbxNQKPCthsJMVwu7R292QIC30
	 +gVZKwArkgWUHlPfGb67W3hvt7RuqKGhQIfKxS1ih05EiuXm1q25mcxo0gC7KcmIY6
	 TkyZIROpxm3Qg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 01/15] mptcp: export mptcp_genl_family & mptcp_nl_fill_addr
Date: Wed, 14 Feb 2024 19:39:52 +0800
Message-Id: <944c18a030e9dcac7175d6c59006b7273eb866ff.1707910454.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707910454.git.tanggeliang@kylinos.cn>
References: <cover.1707910454.git.tanggeliang@kylinos.cn>
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
index d5a942b9ab29..5cca84c6b87b 100644
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
@@ -1636,8 +1633,8 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
-static int mptcp_nl_fill_addr(struct sk_buff *skb,
-			      struct mptcp_pm_addr_entry *entry)
+int mptcp_nl_fill_addr(struct sk_buff *skb,
+		       struct mptcp_pm_addr_entry *entry)
 {
 	struct mptcp_addr_info *addr = &entry->addr;
 	struct nlattr *attr;
@@ -2281,7 +2278,7 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 	nlmsg_free(skb);
 }
 
-static struct genl_family mptcp_genl_family __ro_after_init = {
+struct genl_family mptcp_genl_family __ro_after_init = {
 	.name		= MPTCP_PM_NAME,
 	.version	= MPTCP_PM_VER,
 	.netnsok	= true,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 486fff865803..60de3f997de2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -343,6 +343,8 @@ struct mptcp_sock {
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

