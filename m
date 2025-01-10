Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6DBC2C6
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494588; cv=none; b=mOsz2Xr2Irq/U3iBKGn29sF3wPLzhAUGQRaOA2pMY8N3/+9cCofza5sPP7BR9uC3Zb2ChFlt4b22md6BszDhgUq7Pm9qJ1NLPIpMZ59fDYGOcPuYl2Xr9StvSoc7KRqydjtjU2jSqGsGy3Hr4B9Fv89KWsWF5npdAOMblAJVRG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494588; c=relaxed/simple;
	bh=7YOJjg49dkhC4WEbOceEz+WyeoVF1A0lFYypXoNZhl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2q+onLH/v8p0YGtExGxDFRWJf7RGTsXaCTxLtrA1mCRaztgc/lePKp4ujMqNmjvSg080zT6MjIA0h5qmYUB7PdSHj439M+60JDn7IEmCqmYR+tj3fxnzk1eWVy1VJy20yqrv/XCoXiKg9sfZQzAz2+HsavMhVw+3hoyV4Fzrmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RH5NTOGg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RH5NTOGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8FCC4CEDF;
	Fri, 10 Jan 2025 07:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736494587;
	bh=7YOJjg49dkhC4WEbOceEz+WyeoVF1A0lFYypXoNZhl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RH5NTOGgKp2YbHF52U1tw+On5VkOlXHYJeGmWXLGlY7EJMs7fInBR4XPPUkrL2EZA
	 iomGDmN5am4gkpz0gppbhMdfnOZL4V9UJfel5gbQpK/L69euC3zbyIm6m58O0XViHJ
	 kIIhtJ3huT9vmUWbBzqw4qcb0K0H2Zk1tSY424/mlAPTK82gcp7VzDDFqeqix0QggW
	 JLkRMS1pqb+Jorgv1fT4VKfccysE6QHjGqwfkyRl86WAzKdH7Rb0lQkF7u0OkONZ4k
	 u0KmHrKXSkJC4LjiAtQXljMdXkGYUv0lvBtAFmby6wfGgICMpXYdSHapULRuJnaj2R
	 xLBhwCUKU2Y5A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 1/7] mptcp: make three pm wrappers static
Date: Fri, 10 Jan 2025 15:36:14 +0800
Message-ID: <f5b7e1b57395857ec546a872c0fc5819ed30dd89.1736494320.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736494320.git.tanggeliang@kylinos.cn>
References: <cover.1736494320.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Three netlink functions:

	mptcp_pm_nl_get_addr_doit()
	mptcp_pm_nl_get_addr_dumpit()
	mptcp_pm_nl_set_flags_doit()

are generic, implemented for each PM, in-kernel PM and userspace PM. It's
clearer to move them from pm_netlink.c to pm.c.

And the linked three path manager wrappers

	mptcp_pm_get_addr()
	mptcp_pm_dump_addr()
	mptcp_pm_set_flags()

can be changed as static functions, no need to export them in protocol.h.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c         | 23 ++++++++++++++++++++---
 net/mptcp/pm_netlink.c | 16 ----------------
 net/mptcp/protocol.h   |  3 ---
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 16c336c51940..a29be5ff73a6 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -10,6 +10,7 @@
 #include "protocol.h"
 
 #include "mib.h"
+#include "mptcp_pm_gen.h"
 
 /* path manager command handlers */
 
@@ -433,14 +434,19 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
 }
 
-int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
 		return mptcp_userspace_pm_get_addr(skb, info);
 	return mptcp_pm_nl_get_addr(skb, info);
 }
 
-int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
+int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return mptcp_pm_get_addr(skb, info);
+}
+
+static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	const struct genl_info *info = genl_info_dump(cb);
 
@@ -449,13 +455,24 @@ int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
 	return mptcp_pm_nl_dump_addr(msg, cb);
 }
 
-int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
+				struct netlink_callback *cb)
+{
+	return mptcp_pm_dump_addr(msg, cb);
+}
+
+static int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
 		return mptcp_userspace_pm_set_flags(skb, info);
 	return mptcp_pm_nl_set_flags(skb, info);
 }
 
+int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return mptcp_pm_set_flags(skb, info);
+}
+
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c6fd3b1727d7..5cc6dea7b725 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1827,11 +1827,6 @@ int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	return mptcp_pm_get_addr(skb, info);
-}
-
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb)
 {
@@ -1875,12 +1870,6 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 	return msg->len;
 }
 
-int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
-				struct netlink_callback *cb)
-{
-	return mptcp_pm_dump_addr(msg, cb);
-}
-
 static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 {
 	struct nlattr *attr = info->attrs[id];
@@ -2056,11 +2045,6 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
-int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	return mptcp_pm_set_flags(skb, info);
-}
-
 static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gfp)
 {
 	genlmsg_multicast_netns(&mptcp_genl_family, net,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 891ffcfd1088..99ab37417b25 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1028,7 +1028,6 @@ bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
 				   const struct mptcp_addr_info *saddr);
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr);
-int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
@@ -1121,12 +1120,10 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_in
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb);
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info);
 int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info);
 int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
 				struct genl_info *info);
-- 
2.45.2

