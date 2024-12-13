Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D1188CC9
	for <mptcp@lists.linux.dev>; Fri, 13 Dec 2024 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734075343; cv=none; b=tFOvKoEKBS+Ih2Xb2ssWcyKxXzrU1pJ5ChhkNhNTrBJDwpxukqbJSwzQYFJEL8aTOnJtKXqmxHLRn5Plvgfo9CVIvocxntlO+p0pmmwYuHYfB1uK/9emVptbTXe2pclGrj8jFe5igOTi15+VfwWtRBOjj2FV048IOYe+FnJEeAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734075343; c=relaxed/simple;
	bh=WP5zRwz20kYRmrXTrG67NeIVHf1GKhYrs69R3SdslX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nc3pDLfYpr+hjNwa6u65K6R8OM4dweYjVRx0ygbIQRHxlpQ4il11I9kaYve2oAap+816kvVV8eZjzg/+C9Hx/qZYQrXdCD06Sw9sTsBmQF/0dB8pNX73xyqBx/fUNsD2viqDjDWm6Q4lDxd9BsIwYqr2nxBNq+J/RTXIFcoZ2G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQkyltYC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQkyltYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06668C4CED0;
	Fri, 13 Dec 2024 07:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734075343;
	bh=WP5zRwz20kYRmrXTrG67NeIVHf1GKhYrs69R3SdslX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQkyltYCCtyc7Jhdw2O1JzgiTHVS3Ji1Q23t/3ofxey8TEdtT5vHMQpaPQgOBca/2
	 J1sCZ+jBBlskE1sOwnqd9OOTEBMRrOhsodlbJpmAVhowl3fFcv9DTO8/ql+jKQ6Pp7
	 dlvEtIsbfNMkugDMhD7huoZEk1NgJM97jVMRZcUf3/iDiZnArNzXByBnOTS8H6rJFW
	 8d3YtSxPY77MpH6P2Ng5K/o/miVXVlNKLGpNqLmhVq08C3IacRRBvUYZJzBT5lmrNW
	 fmyPl0uTEXLLHbU3zMrYkhSH9HaRMEDgyJZ59zLm2ZubImwGHtc11QSwH6IsP2Ybe0
	 MW1TQ1ab5y4xQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/8] mptcp: drop skb parameter of get_addr
Date: Fri, 13 Dec 2024 15:35:23 +0800
Message-ID: <e97a846797ff1cf43d1cdfb3cf42963c24ee8745.1734074788.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734074788.git.tanggeliang@kylinos.cn>
References: <cover.1734074788.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The first parameters 'skb' of get_addr() interfaces are now useless
since mptcp_userspace_pm_get_sock() helper is used. This patch drops
these useless parameters of them.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 8 ++++----
 net/mptcp/pm_netlink.c   | 2 +-
 net/mptcp/pm_userspace.c | 3 +--
 net/mptcp/protocol.h     | 5 ++---
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index a29be5ff73a6..526e5bca1fa1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -434,16 +434,16 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
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
 
 static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 32367fcc728e..92b4dcc310d3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1762,7 +1762,7 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_get_addr(struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 740a10d669f8..ab92efec6618 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -663,8 +663,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
-				struct genl_info *info)
+int mptcp_userspace_pm_get_addr(struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct mptcp_pm_addr_entry addr, *entry;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3bff78efd8ed..dd673b41f0ce 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1131,9 +1131,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info);
-int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
-				struct genl_info *info);
+int mptcp_pm_nl_get_addr(struct genl_info *info);
+int mptcp_userspace_pm_get_addr(struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
-- 
2.45.2

