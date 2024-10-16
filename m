Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C0117D378
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069979; cv=none; b=us6io0J41b7peP73fx1Gc1w/seNC2IGyq0UwWtiq+i8Hlqwev13951JM2v+6Sfm/5yvMvniVRARZGwpJXsKs/+SiM/S/3XliHu1F4Qd3y1ns8Xa4bp1flNix9TQMFkH6KuCrdMeXSLNe9a/hDNeiiTfOqZO9CXPO7cK6DsH3QOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069979; c=relaxed/simple;
	bh=8fWtnK4RyD5s7JHpfoWaVXyGrNw6wsz2iGW10NV5GAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFW7Pj582Xg4cn0ZZJe7GpnTrwYSDZP1GQ7M5mqAcpj3307w1is2buTatRy7tkUd6V6e/jThyXp36VNk93aeuxLk+0HL6uF+5bC/UEPSLIOHiHmmCp2AGP4dxW+0mS5piRVQF0IU9s2OiWDxsD8nf8TePnMhJ8rBQ6qkacfqiDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbhUiEzo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbhUiEzo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407E3C4CEC5;
	Wed, 16 Oct 2024 09:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729069979;
	bh=8fWtnK4RyD5s7JHpfoWaVXyGrNw6wsz2iGW10NV5GAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LbhUiEzoQG9QrJi00iuVOa9wwa//8g+O3xJDJBQCsLaGiytUcP/IF3Sbiw8ggA9H/
	 Sib03qWx/z9GS5JYvqyFtdKN9+Pvr8OyWxY+V+B4D0yyLk3vMZpnI0aocKjPJeWqh7
	 d8OX2KNu3yYrzEECBbBjB6v/10Y2edBFfjY3hb6ao0Jxp1HrZ6WiiiUt2+o3+BwX9a
	 1HWzWRxlmhVxuEZiUI1Vln2ssAJ+YZELcFaZ1nUWT3qnKIbucnDUSEJcb1MD+rOGkV
	 /jqh7DXv+NzuvVi24sqmEh0hhqVYnPxpZxr1KogcCVWWsqW6DBb7DYerlgXsw+YWwe
	 nq/LLAnPyF3vw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 08/33] mptcp: drop skb parameter of get_addr
Date: Wed, 16 Oct 2024 17:12:12 +0800
Message-ID: <603352e2447b2b7b936c97e670d3acb911457c3c.1729069853.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729069853.git.tanggeliang@kylinos.cn>
References: <cover.1729069853.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The first parameters "skb" of all three get_addr() interfaces are now
useless since mptcp_userspace_pm_get_sock() helper is used. This patch
drops these useless parameters of them.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 10 +++++-----
 net/mptcp/pm_userspace.c |  3 +--
 net/mptcp/protocol.h     |  3 +--
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f4b9f44796a4..fa320bdf2647 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1792,7 +1792,7 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_get_addr(struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1842,16 +1842,16 @@ static int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
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
index 79ae32c921b7..e61cc1805cee 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -632,8 +632,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
-				struct genl_info *info)
+int mptcp_userspace_pm_get_addr(struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct mptcp_pm_addr_entry addr, *entry;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 726b1561d204..93deec8f0557 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1126,8 +1126,7 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
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

