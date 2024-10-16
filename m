Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59E1206067
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069986; cv=none; b=fRrbGHU+1gXNIhJVCMEOm5NmiOlilg7qv5VrrfhMF4mU3pkVwAqQ2Ff8aYckDUP4CPjT55jkKTUFYQT7kM1z6wSe5f3SyUYso+m4CeQd8myRjQkjwsHybwY2hdKdzFuYsx6qWL4hjH8Q3DTF06B0mOgq6MqlBEM/z+ER7yEdhIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069986; c=relaxed/simple;
	bh=vN77zTOlh1ttnBeT0h4+rM7J8prBWaD83n+ewBsv2Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qygnA0Wc7tg6C5Kswu0X4ZS9IRZX1C1XRvc0l2upGX0G+jS6ckMeBDKWgURDhbTH4+YZefZPxvf5SPG7aC4fgF5iTxzMuKsWFeKBaeF/hVrPKce7gpMAcpimW4c5OZ2XxiUiI+fnDuVcruHpRRbdHdKe/DvzXaS8MYXuCMSzR24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/xyVmGY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/xyVmGY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4B6C4CED2;
	Wed, 16 Oct 2024 09:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729069986;
	bh=vN77zTOlh1ttnBeT0h4+rM7J8prBWaD83n+ewBsv2Bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/xyVmGYp3uW32JemGYNvZ3Q7Fsrz6a25ReZkM1A3XOXc1WWXGOLeBbjltpqeW2N0
	 VYM0nhH+FEAn/ELQpt87KL54tRwkbMF6p7CiibK8UdupscoBVYewSYmfHp9Xskoy00
	 LlV39yl65iLegGNKHmmSKkLGpAZTMv6WMDxTcCJrUHRoGxhyK5TVUrCu7+o1eopL2i
	 u6Uvvl17tyRtiIbXlD7ir+F+F3+/zJhhwvafnG/nTVaCaoRsiXKLiw6+9vFpRSl/L3
	 kCNX+UZWu/T7ZGuyd144kTCBhyyk8pkB+0ysnjkoVG53Dm3vu0HFfXMHltUkIG2G9E
	 xHqZml6r4ABBA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 12/33] mptcp: change info of get_addr as const
Date: Wed, 16 Oct 2024 17:12:16 +0800
Message-ID: <32e740721a1b1d12293334783764258f2401ff40.1729069854.git.tanggeliang@kylinos.cn>
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

get_addr() interfeces will be invoked by dump_addr(), which using const
parameters "info", so this patch changes "info" parameters of get_addr()
as const too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 9 ++++++---
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 173d36f91274..e71e7e55b046 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1793,12 +1793,15 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 }
 
 static int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-				struct genl_info *info)
+				const struct genl_info *info)
 {
-	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
+	struct net *net = genl_info_net(info);
 	struct mptcp_pm_addr_entry *entry;
+	struct pm_nl_pernet *pernet;
 	int ret = -EINVAL;
 
+	pernet = pm_nl_get_pernet(net);
+
 	spin_lock_bh(&pernet->lock);
 	entry = __lookup_addr_by_id(pernet, id);
 	if (entry) {
@@ -1811,7 +1814,7 @@ static int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 }
 
 static int mptcp_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-			     struct genl_info *info)
+			     const struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
 		return mptcp_userspace_pm_get_addr(id, addr, info);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index dd2ecc9ee6d5..c10794154187 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -633,7 +633,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 }
 
 int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-				struct genl_info *info)
+				const struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 364f121f69c8..f8e79f477609 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1127,7 +1127,7 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
 int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-				struct genl_info *info);
+				const struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
-- 
2.43.0

