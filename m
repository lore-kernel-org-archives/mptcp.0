Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F9018BC1C
	for <mptcp@lists.linux.dev>; Mon,  7 Oct 2024 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298423; cv=none; b=nF6iUf7tw93sM3IdiaewW96MZvMuLFf5skZTg2YvN0CDDJZbnr7nUZWgvAfOg1+eKGOTRkr7vY4Gnl7nj0YrxTCkDtyUyldYAgLbDZgXCbPajMCXMWhF1DcSSFLQQY227ggwJb5qzYp5y8h+ODSajA1uJRBsr/f8wteA0Zo+79g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298423; c=relaxed/simple;
	bh=rfoqoFvML2u+ErY2Y+MLv96V9ZZDcbPgf9yAnZ+7uW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvyInkQlBvh8p8T+iDO1mcQT7e+rjUGETu9LK24BhkcuDDflChyAh6x9r+o1pzPCIGX0y12Zochf67fKZHMSfTE5VJAQS2M4MQqXrh/fvxIXrtYIA0nw0w53Wkvs+brz2s0JPDwMmvYk3c3coTLsLcE1eEKSq8osw6slgmonhK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnh2FQOU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnh2FQOU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35BCC4CEC6;
	Mon,  7 Oct 2024 10:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728298422;
	bh=rfoqoFvML2u+ErY2Y+MLv96V9ZZDcbPgf9yAnZ+7uW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lnh2FQOUsmny5U/LFlh7+nAbze+ERayvjThwhUP0ssDAbvLEjxc3HAJLL38i0HOOQ
	 UqJLQzmTXvdeJU9u5uCa0FDbAZxP8ZhmwazzSq60g8PqOB7/KQu1TFhQgjfHY6B0sl
	 mqxGJ/+ROWXo+Un6FhR2Hy6UyDGFUBivFMu6ilAw54ofm3N2Ycp9jZNmxih0DAlmJM
	 ad1UIyD+6g6nLQJQKIE68xN/GpWgncTmShXxDUWw5z1Y1RKl4VLQfvKJG9z5uUQ5ED
	 plqXVCjkvqQaGOTdh8UedA36bwuRSxiZRl/kekUodnUBUs03UGdtqzFxqKkWPJ43Uc
	 eKXUWEVlhvGzg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 09/10] mptcp: drop skb parameter of get_addr
Date: Mon,  7 Oct 2024 18:53:21 +0800
Message-ID: <316169717f06be08a2892c121adb07c67525813c.1728298100.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728298100.git.tanggeliang@kylinos.cn>
References: <cover.1728298100.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The first parameters "skb" of all three get_addr() interfaces are now
useless. This patch drops them.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 10 +++++-----
 net/mptcp/pm_userspace.c |  3 +--
 net/mptcp/protocol.h     |  3 +--
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d7a4199b142e..f02378e9a9c8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1790,7 +1790,7 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_get_addr(struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1840,16 +1840,16 @@ static int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_get_addr(struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_get_addr(skb, info);
-	return mptcp_pm_nl_get_addr(skb, info);
+		return mptcp_userspace_pm_get_addr(info);
+	return mptcp_pm_nl_get_addr(info);
 }
 
 int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return mptcp_pm_get_addr(skb, info);
+	return mptcp_pm_get_addr(info);
 }
 
 static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5d6801ff48ca..e9977eddd1d3 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -629,8 +629,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
-				struct genl_info *info)
+int mptcp_userspace_pm_get_addr(struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct mptcp_pm_addr_entry addr, *entry;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 95533d5b82c4..238fb2ddb68a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1127,8 +1127,7 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
-				struct genl_info *info);
+int mptcp_userspace_pm_get_addr(struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
-- 
2.43.0

