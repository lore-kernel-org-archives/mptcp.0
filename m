Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D9FC2C6
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 07:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494589; cv=none; b=ofpE7LxdXNL6LsSfUNiMFjaHqASNLEdrr9l+uwr9aebcH3YWze/6jjoVNN3GeeBLDWAk1z7BGAPXCPmQpEQaI5UDgXz63Xun33+1QRdkhbwnrNjdnXiTaMq80JyL8RvpCBL/SqCFKGkjojHw/UojziW69G6vUi95yW76b/TJep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494589; c=relaxed/simple;
	bh=6Nr0c6QpaJTpcLcZasXByiZBTqBhumeJ1fdNkOeVBv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3XIRy9NwmmYead8D02EkH+wduN61rciIstK5pVz82nfTI+gwMx6IMwsGwzvK1CNPKRlcTaMQhfKBYRPVCnd+ULWmPW9lsj2ZHB1njM1i9/DEHDKmzSg9jtg36qdnXsKvWynbKd7SSfoHOsW+uIWMDthKgoTOXIRJsKudRkGssM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ipm6gtUQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ipm6gtUQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C572C4CEE0;
	Fri, 10 Jan 2025 07:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736494589;
	bh=6Nr0c6QpaJTpcLcZasXByiZBTqBhumeJ1fdNkOeVBv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ipm6gtUQqzxo4WIl3m7tdRVh6rP8az8sv+zMY4m4zOH4jbNvht5diPvZWSg3VDV7o
	 SK5ZlYPXWevr1tusN0GgIkFhXC2KxLkjJsYxvlD1hI3CTAoO1HP/4r4AgLio4iGJjL
	 K/uSPbOOfeBQfI0Ewimx34bM2WVEXFa/agwNgfsR67G/of90WYHlOJ0IaStlDafd2v
	 6jUqq2eGarN/erKJxZsuqOU3NAQmM3i5mxjWl0SdW2HGM52TBpboKU+7LfDuJVOGP8
	 p1eBNRs6Gb+ZSTDKyXu9QmoOZyYloOGCq9Z3V4ghWzF7mjtjm3MtnzSHCMOM/vHo/3
	 54DG4M0rvXIHg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/7] mptcp: drop skb parameter of get_addr
Date: Fri, 10 Jan 2025 15:36:15 +0800
Message-ID: <cbcb5f114298d0d4ed4e2b73002f573e85b5d96c.1736494320.git.tanggeliang@kylinos.cn>
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
index 5cc6dea7b725..18f4d8176fc4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1773,7 +1773,7 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_get_addr(struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4e5511ede7af..ce627e1dd5a7 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -683,8 +683,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
-				struct genl_info *info)
+int mptcp_userspace_pm_get_addr(struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry addr, *entry;
 	struct mptcp_sock *msk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 99ab37417b25..36e5fbf84b2b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1124,9 +1124,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
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

