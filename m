Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4733E178372
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539294; cv=none; b=lM0UDNzwhFSiXHoEzlDup/5IheyLYNxCi4yeWk9vJMaECrZFOHB/vpPIZRiKS3HLwl/iBB53G1jPpeOIk5NhwhmLjzWrlbTqkurvdeXTmDqMz7fAvr1ki8Fkb3fvTQ3lAnKZZJHCS1dSuSYQMlNgXx+L0Jl7P4clsZs3g4ghfdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539294; c=relaxed/simple;
	bh=vJ2BY1wILGxIuUIk/rIufZZoVxSmrtgXkea5hC+dSf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMk67Sy9Hltv5255v06q/cBSSZ2Og/HI57oKaY87SdhawokFgRfFTiyIM+e5pgBcxXG/5kTXI3ySXzey59jvSVA0YUeC+wMJj+P3gnbMnnVwH3eVmID7SLHu2lM7osdQLUy8iVb/g6P2gt+5m9UEetMND5jrYsiMjNkRKMdlkgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTtKM1U7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTtKM1U7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF451C4CEC5;
	Thu, 10 Oct 2024 05:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728539294;
	bh=vJ2BY1wILGxIuUIk/rIufZZoVxSmrtgXkea5hC+dSf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tTtKM1U7Wu9+f06Qg9REvDmjQgnMeI3HhF5X6crqpZOSmc1UKVRJrjiLUDXEk4+ll
	 hF6jzk3BK7x+LU31ieFdUNp9YCWXvtNIXxZisyvcv1GbZShyO8TdESKi4+A0tcB8ZT
	 Kidv/362SBGTjR2JFzv7NcmabwTZgIB0wKxTiNouVHK0NzPc3JtOTDWt1RvEAWFpZO
	 1d1y2EKk3swsKxoImNiZS1gXEx6cIOi0T33OHOWK2VzWniLm0REnSL62KE3X40zGKI
	 CeilH5+dvbxU9FWe6AEnGznsak28MKbBCkl0QF+DO0+qrwidgt5EUUjxT4kvbbQlIv
	 E28ppMyVeob4g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 04/15] mptcp: change info of get_addr as const
Date: Thu, 10 Oct 2024 13:47:49 +0800
Message-ID: <6e7ce5e458e8703a93b71e345a696d4974ca0fdc.1728538976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728538975.git.tanggeliang@kylinos.cn>
References: <cover.1728538975.git.tanggeliang@kylinos.cn>
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
index 353878f64e8e..2888e4b303c0 100644
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
index 4c4693c5aae9..373ff0186bee 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -630,7 +630,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 }
 
 int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-				struct genl_info *info)
+				const struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e5319876c5f6..3b3a09f5d7fc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1126,7 +1126,7 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
 int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-				struct genl_info *info);
+				const struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
-- 
2.43.0

