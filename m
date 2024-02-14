Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22E61B964
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910871; cv=none; b=k0KUoyyLldMpT7WCwphxq/KpgkpZCXOhBuWXFV4mQi8faySQOCQK2K7ATSAoKNh5kkDNY5s7e5Oz4VTGFc8W/DypZ1AZeL45yhOiw9R/zIY2qknHLXbsNWYMB4UVbmt8aj2oXv0M1Sa4dw5POJYSIeFlOqALgCKS9ZfLhUh6Ero=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910871; c=relaxed/simple;
	bh=UYlXxvMoWkZF081WLIoWdKVoOO4qA468ytMjPC6qLoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X7cQzQdUNrUbzTl7GxyQdXkojq1YF9+uhdeUKz6isxuZA76bG1vmCHIc4CfzZHK6LpFxmP2jZWNsdfsDWnSCOvi7gW5irZuuQaK7DURNy+/RqObNxZkP6x1IcEeJ3mWh+unhliOCV+FtCPS8m+YuVJfpME7ew6BEftYVu28kIY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWhGDjpr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWhGDjpr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B50CC43390;
	Wed, 14 Feb 2024 11:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707910869;
	bh=UYlXxvMoWkZF081WLIoWdKVoOO4qA468ytMjPC6qLoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qWhGDjpr0y/dwPL0fgXaqnYGvclqEHXQkSfgs+9hbArhT2V5s9ZWlBiXtEwRL3TKq
	 9IAa6AuOwSOGMBbDqj1QKkKYt/a8s/ft6kLnIchDkS8s8AeSEnEhwr1h6vq82bIXLa
	 sImcvCObUyiKvuv0HRxtsvhRmm2T26lCRPSLGPmQgqTlX5F4yBXQFjDILRKdZKPaQL
	 3F/TlVKLXHjI2Wc9JkqS87B0vP1tvoNwzgcLYTsRkDUUp4jyk6v8UbEV6FQ/ksL7Bp
	 qWRShMreNaoIS0z5IEKzI6DrhEo7yHTGLSXaENM8MIrsjStuaDs7ECjrjf2eZTR7aR
	 qm5Y60U2ti1bg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 13/15] mptcp: get addr in userspace pm list
Date: Wed, 14 Feb 2024 19:40:04 +0800
Message-Id: <b73ef346624500236fc4fe31cdd07c6447dc441a.1707910454.git.tanggeliang@kylinos.cn>
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

This patch renames mptcp_pm_nl_get_addr_doit() as a dedicated in-kernel
netlink PM get addr function mptcp_pm_nl_get_addr(). and invoke a new
wrapper mptcp_pm_get_addr() in mptcp_pm_nl_get_addr_doit.

If a token is gotten in the wrapper, that means a userspace PM is used.
So invoke mptcp_userspace_pm_get_addr() to get addr in userspace PM list.
Otherwise, invoke mptcp_pm_nl_get_addr().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c         | 7 +++++++
 net/mptcp/pm_netlink.c | 7 ++++++-
 net/mptcp/protocol.h   | 2 ++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 193198cec74a..b4bdd92a5648 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -441,6 +441,13 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
 	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
 }
 
+int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_get_addr(skb, info);
+	return mptcp_pm_nl_get_addr(skb, info);
+}
+
 int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	const struct genl_info *info = genl_info_dump(cb);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7b15bb4f12c1..f04e354b0c64 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1672,7 +1672,7 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1722,6 +1722,11 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return mptcp_pm_get_addr(skb, info);
+}
+
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb)
 {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a86708996954..75d9184db7ff 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1037,6 +1037,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
+int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info);
 int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
 				struct genl_info *info);
 
-- 
2.40.1

