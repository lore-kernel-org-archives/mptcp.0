Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8556614A08E
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494261; cv=none; b=r1EjVsCOzbf2onmdEjsAEZTQvUUKYHUZe2RitX/XC0yxshGqLrKEzvN3MLhvJ9CvuGwTnz43lQj+HsGm6xslBvSnjiwUCDlR6InWx/SEa1R5EAxY3EthGzXFzTh6AqgpDMt6wiiIg3is3bN7tLR2Ti3Enc2Tvs0kNPciJ8M90b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494261; c=relaxed/simple;
	bh=ryqPfoq5MUEionftiSxy5wiw4TKIMxx5kI/KWhc7des=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNm3NRiYRsqO5aA2UHYf/NeqX8PpaZPY/YabaUAnMivOkFi1W0M1XC0cGH4j5XOJHsWD0yUmUwRli4oJBFGCI87kt03vvN0CxL5zwcw6LvixnRSRyit5Y8zsmcp/s2gvWTqcwT/nbgs+hcI4lCy+fquMq+xwzYwVo8vCdDQVN9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbMc3fvE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbMc3fvE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8647C4CEE1;
	Fri, 10 Jan 2025 07:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736494260;
	bh=ryqPfoq5MUEionftiSxy5wiw4TKIMxx5kI/KWhc7des=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mbMc3fvEQqChytPZKAOFTtSkFMf6R4/5clGtlcrYUoEP6o13TpUz9/Zzxk61b3T0Z
	 tNxmgHHE05OiUdb6R58EXoG4OI6BYQ3yWZdf0dKqMLVy9BE32BieryJLLp1a43ntN+
	 QndwupXt4rSMHE7vjkDJwXcfPHBg74rkFfnCQu8tD4qqjD/FzfCRpx1RLkP7Nd/zXJ
	 gfkb9ZueMMDiNJR3+G7tFJ13JOt9o4xysrgM0PxXBcWC/y/t4pVI7qxp8W8ilCSgqw
	 LIQ9RPb24Nkj8n2bQC9oY8kOwVC6yLikYMMZIUYMrW32Z6hil6Q3L2RC1odhGsoGuG
	 5GpIZtjV331yQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v9 6/8] mptcp: pm: remove duplicated error messages
Date: Fri, 10 Jan 2025 15:30:40 +0800
Message-ID: <68f944b4629c58878753458a445ee0281d8e2108.1736493803.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736493803.git.tanggeliang@kylinos.cn>
References: <cover.1736493803.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

mptcp_pm_parse_entry() and mptcp_pm_parse_addr() will already set a
error message in case of parsing issue.

Then, no need to override this error message with another less precise
one: "error parsing address".

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4cbd234e2670..ab915716ed41 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -216,10 +216,8 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 
 	addr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
-	if (err < 0) {
-		GENL_SET_ERR_MSG(info, "error parsing local address");
+	if (err < 0)
 		goto announce_err;
-	}
 
 	if (addr_val.addr.id == 0) {
 		GENL_SET_ERR_MSG(info, "invalid addr id");
@@ -386,10 +384,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(laddr, info, true, &entry);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
+	if (err < 0)
 		goto create_err;
-	}
 
 	if (entry.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
 		GENL_SET_ERR_MSG(info, "invalid addr flags");
@@ -400,10 +396,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
+	if (err < 0)
 		goto create_err;
-	}
 
 	if (!mptcp_pm_addr_families_match(sk, &entry.addr, &addr_r)) {
 		GENL_SET_ERR_MSG(info, "families mismatch");
@@ -509,17 +503,13 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 
 	laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(laddr, info, true, &addr_l);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
+	if (err < 0)
 		goto destroy_err;
-	}
 
 	raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
+	if (err < 0)
 		goto destroy_err;
-	}
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (addr_l.addr.family == AF_INET && ipv6_addr_v4mapped(&addr_r.addr6)) {
-- 
2.45.2

