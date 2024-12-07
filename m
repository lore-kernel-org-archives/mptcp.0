Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4451722C6DC
	for <mptcp@lists.linux.dev>; Sat,  7 Dec 2024 01:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733533697; cv=none; b=Uk4MSPDteP8vEFRWojJ9BHrsZjurPkJD/DpwVJpE3DDDZhf0/HHf8DFopSk+wBzzmIH6lb+Ka/DcdSoIDB+2jIn0D3HCGGc0hqYuvglr1nGWklDPL2ykoT1htGqCDdBI34hJD5VE5OB1cYPAQ8hsA+8ylkV070rb88UU83aouxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733533697; c=relaxed/simple;
	bh=WkWJXcTwp5kr+PZqhVhA2BxQTLn2ts8KOXrstxbG+kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqyNy0RImKsnbbodoVcgGIJ/0fGmc5Db/k2VBtwcYrBjDRSk/dzLdqXL6HpgCYe/h7gdInHTu4UceOEBrtTkieZeWMO06NfrO5uQCWDN+cgBEjucbmaDp03vSeT+/AEbBxgzccrXZE9za0kBUK3mMatokxExwydTxIBChh2bBkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUiqNXts; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUiqNXts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3431DC4CED1;
	Sat,  7 Dec 2024 01:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733533696;
	bh=WkWJXcTwp5kr+PZqhVhA2BxQTLn2ts8KOXrstxbG+kE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUiqNXtsT0b5v3j2cHkfLmETxOBez8EE/V5+cwQDnPaj1xNuiw37b441cFFmJOkfU
	 nJuPKTZedkGBshzXbHdJr1z1vp1HiRdQgsGfZO2c5lPMbEvFkggE8/lTnfaSc4UZKZ
	 MK34kvkt13foEBmgGQ77r7qYO9z7/6P0u8NgQaZhXZSg/YPHnE+s7MEMPKAJ8CHp7b
	 QtbuycR5KiltD7MgwQ/BZ7qnsjPrLrqEmMcL3mKXAQCgfJXENfNE6ch6xVOBJjqMpC
	 DcZb41ytAUiy2/3iFN5qUhC6XcXOxs8rBoN1ebt4nN86A7EOlY2A+0VbY6RVcUg+Vh
	 UEyeGQoFtGqLg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 5/7] mptcp: change info of get_addr as const
Date: Sat,  7 Dec 2024 09:07:25 +0800
Message-ID: <49e8fea42b8e1acad5cf5f8db6d16b16eea647d0.1733533215.git.geliang@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733533215.git.geliang@kernel.org>
References: <cover.1733533215.git.geliang@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

get_addr() interfaces will be invoked by dump_addr(), which using const
parameters "info", so this patch changes "info" parameters of get_addr()
as const too.

Some adaptations are also needed. No longer use genl_info_pm_nl() because
it doesn't accept a 'const' variable, but that's OK to get pernet via
genl_info_net().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 2 +-
 net/mptcp/pm_netlink.c   | 7 +++++--
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 4 ++--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9f3d82a86746..080c842e9e90 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -435,7 +435,7 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 }
 
 static int mptcp_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-			     struct genl_info *info)
+			     const struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
 		return mptcp_userspace_pm_get_addr(id, addr, info);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index dce6a5b5ea4d..eb5f48e45187 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1763,12 +1763,15 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 }
 
 int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-			 struct genl_info *info)
+			 const struct genl_info *info)
 {
-	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
+	struct net *net = genl_info_net(info);
 	struct mptcp_pm_addr_entry *entry;
+	struct pm_nl_pernet *pernet;
 	int ret = -EINVAL;
 
+	pernet = pm_nl_get_pernet(net);
+
 	rcu_read_lock();
 	entry = __lookup_addr_by_id(pernet, id);
 	if (entry) {
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6dd5a3f1c0c7..7c5914012947 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -664,7 +664,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 }
 
 int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-				struct genl_info *info)
+				const struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a80a0191e2cd..a9fc30f20376 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1132,9 +1132,9 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
 int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-			 struct genl_info *info);
+			 const struct genl_info *info);
 int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-				struct genl_info *info);
+				const struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
-- 
2.45.2

