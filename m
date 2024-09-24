Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6441A3A9C
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180852; cv=none; b=W7/ZLsJsHikyV+828Z51XewehLIbOFRDiQ3DTnOFHSFXjIhXOic8YvkoTi6Hm3axpf+JDRR54oVB41wbBAI79yMtMM4/LQ6MSQMxZVf7EU9lR4B7Ym4UuThwmzZwi5J7ssQj5WXav+Hn0dEQfmTvquN8CDdnSipb9+KuSKxg0wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180852; c=relaxed/simple;
	bh=eU2O0PTPjdrEynHN04weD+DBX49Cn5DZK4/RNN2Ehw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rxrc2clvRsSnw+T+rxXXEYzYrq7cQ1nqsUmAEYur38C3Antm30n0uP00woHbXTpUuNru/hu/84X6StYcWtci2PM1cTwrZRCMi5uM8jBiEbz4Sw1K+DVoVWOMSsl7Bs46iOWq3O11v83GIVxfWt8ALhVhWhgMBu+YUypCCM/rFls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIyd8sLf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIyd8sLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF8AC4CEC6;
	Tue, 24 Sep 2024 12:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727180852;
	bh=eU2O0PTPjdrEynHN04weD+DBX49Cn5DZK4/RNN2Ehw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rIyd8sLfJLaArDYlAqfhFHzQSdMRz1wCfU33rblE8MO0sLssETPjgrplTDpbbILEL
	 HJNPl7Vq6OoCAi39xzoJbxX36Xfb8ZWGw7w6eT96mxDgs0FfZOKODcgf8oBFomlZlH
	 odSCNHzL9oKulLLvxLsBnf4ljQGGnF8r8cAKV/6u5j3HMcoWEttc05OGSjXsCib0mN
	 bvv+1KPnUYp/SLsQYnZN+BG7XTHb0HM4mOwczZ+sBs2EAg/VqiaCSqL9NGuiBvifMH
	 1UGeiLc00DQ3E37y8jeEnP3cTWvgoaLdndLfyI+fn8fS9GzSEn+QSvV2RyoAURQRur
	 MzfdTadlpUP1g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] mptcp: drop skb parameters in get_addr interfaces
Date: Tue, 24 Sep 2024 20:27:24 +0800
Message-ID: <7d29c0e225ef4bd00a5820130a1125f165631c1b.1727180731.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727180731.git.tanggeliang@kylinos.cn>
References: <cover.1727180731.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The first parameter "skb" in mptcp_userspace_pm_get_addr() is only used
to obtained the network namespace, which can also be obtained through the
second parameter "info" by using genl_info_net() helper. This patch drop
this useless parameter in all three get_addr() interfaces:

	mptcp_pm_get_addr()
	mptcp_pm_nl_get_addr()
	mptcp_userspace_pm_get_addr().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 6 +++---
 net/mptcp/pm_netlink.c   | 4 ++--
 net/mptcp/pm_userspace.c | 5 ++---
 net/mptcp/protocol.h     | 7 +++----
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index fe7e5ca38dfd..58181e846cec 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -440,11 +440,11 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
 }
 
-int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_get_addr(struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_get_addr(skb, info);
-	return mptcp_pm_nl_get_addr(skb, info);
+		return mptcp_userspace_pm_get_addr(info);
+	return mptcp_pm_nl_get_addr(info);
 }
 
 int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index fe34297ea6dc..ed236522a30e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1796,7 +1796,7 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_get_addr(struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1848,7 +1848,7 @@ int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 
 int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return mptcp_pm_get_addr(skb, info);
+	return mptcp_pm_get_addr(info);
 }
 
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 2cceded3a83a..a68df40a62d3 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -669,13 +669,12 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
-				struct genl_info *info)
+int mptcp_userspace_pm_get_addr(struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct mptcp_pm_addr_entry addr, *entry;
-	struct net *net = sock_net(skb->sk);
+	struct net *net = genl_info_net(info);
 	struct mptcp_sock *msk;
 	struct sk_buff *msg;
 	int ret = -EINVAL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6d7a66ce77b3..ef66cc8c4d9a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1126,10 +1126,9 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info);
-int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info);
-int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
-				struct genl_info *info);
+int mptcp_pm_get_addr(struct genl_info *info);
+int mptcp_pm_nl_get_addr(struct genl_info *info);
+int mptcp_userspace_pm_get_addr(struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
-- 
2.43.0

