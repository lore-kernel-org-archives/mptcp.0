Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812495FEF9
	for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423115; cv=none; b=RQu+h+czY5KkHaRJK8FUabtsW3x0T2Ox46YhK3V5f0d9lJCYf39EbrvWKjJPHGSO6wf3qlIKNXy7dq9BjkBIYChRbavpQtDbqreAk7Km/bKxhEpHLOCISIoIWUSqAKuNxXXvIAen6jUXjqRXHZi27cHZg17Xbwrb55rM9tkYW4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423115; c=relaxed/simple;
	bh=YA13jGhC6upAe0bu1WkCSJyPoOXqRGk1yYi0XExMrMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JQNDWAaZ3cx38uGPx3Q2z8GCoPYnnfi7uuchCPwi4ysqY3D9EfXVQOAFWaNxFongUe1ydeZiguRaHQVLJL9dLVjH9wHETAgdq8PJDk9KUY+KkephzNE4EVP8pjdvyBXu4AR9P8h66518mCWFAe8w9x7lxOdioeyon5UGEFCpg80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDsePAv+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDsePAv+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88ECAC433F1;
	Tue, 20 Feb 2024 09:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708423115;
	bh=YA13jGhC6upAe0bu1WkCSJyPoOXqRGk1yYi0XExMrMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZDsePAv+juXxv0hGiEOsoLnFyLlsPuSJSuxHlyYetfpJaxQoHvp68fPqgEuufIQ97
	 U3W8lrXgqWHdJcQdbcQCkXtqWuceXZ5+iW0vfkddx2+ClRiW0hruQfwcpJXcAbG5Fg
	 7+vRoIRp4C+NJ17Mlw/uHWhpdDxuPwZP2RgNRtBlMwSEvd9YWFbyWHqHRJrt7lhXch
	 8cUMoewlXO1sSovz81X1qedc3xY7MPOGWqRISnsqnmPdn/Nlh8Bp79OADLPGZpAMoM
	 d2HNmXuDR+lAqnchqkmtU33Edpf1EVAOQ0jDFctl1gdzA27X5YxhmB62DzERjj2IJD
	 hTmODGEXW71+Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 01/14] mptcp: export mptcp_genl_family & mptcp_nl_fill_addr
Date: Tue, 20 Feb 2024 17:58:15 +0800
Message-Id: <9c0e29c5657d10995f3caeefaef6160017ac496e.1708422758.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708422758.git.tanggeliang@kylinos.cn>
References: <cover.1708422758.git.tanggeliang@kylinos.cn>
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
index 6343d640ce8f..843c1e31de3f 100644
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
@@ -1003,6 +1005,8 @@ void __mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflo
 				     const struct mptcp_options_received *mp_opt);
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req);
+int mptcp_nl_fill_addr(struct sk_buff *skb,
+		       struct mptcp_pm_addr_entry *entry);
 
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
-- 
2.40.1

