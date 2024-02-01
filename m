Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9DE1EF19
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 05:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706764770; cv=none; b=LLVcnDUrf27z3sTccrAGFV3xfaAiTYtTcoP6+qYbSCWPT9lTtTKM/I0Umbo1EuNQmI944uaQ7o0kA8VHxPu44FSfjj/UGY0ekQWt55E/HhUu7R8B1yr6MbhVeKHVI1gDgGAOosPLbHg67K6Sej2+o07yH8RXg2U3Y77BmHt9ocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706764770; c=relaxed/simple;
	bh=ruFJpPj36Lt4TuHPjKFfPxAxO6H05WcRviUcNM1+9lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UoOsajQI7PdVp3C1dJ6lTPRyuu3bYZfqDINR/U49SllWD6pXn0vl1E8AJZVfUHLHzl+QtWmV5zuiZG5D84ybcsfBiYhPQDSYG00Zzq1IlfHzvTsmqKT7q4Rg8bPQw2UqO9aqZUtY8945OAvTXfMWmMW/8y+lJt6QohSorl9xWYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRjzvPfi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRjzvPfi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313D6C433C7;
	Thu,  1 Feb 2024 05:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706764770;
	bh=ruFJpPj36Lt4TuHPjKFfPxAxO6H05WcRviUcNM1+9lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GRjzvPfimi3hs5+cEZsP6br39NZG1B4DVwoSmNkWVHopDREKyhWt3HWffHHIS/Zkf
	 qpTygU0zHpxxjmMfggzFOpBk3N0ja+gnW6Hvv5aAM35X0UpkPy6OyI//gBIBXtHgnZ
	 rbPigU6D8dS59czubY1DTCYntQ9EIUglCvDo9qjZq+sLx1R6IdXCu0fBY1paJq39f7
	 W+09nuRVM9vVrniCf9l6wXN8jpWzSGhLzuMFsBlxNH1YY+IhDjZQ3NkbSw4S3imE+/
	 +TWd5kcAA2liUAbFmgX8oz1Of7epS+jwkpcaW2bSTuPJjDlkUNGZ8SfvVwZmzPZEH0
	 kBEOYT1r4Jl9A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 13/15] mptcp: get addr in userspace pm list
Date: Thu,  1 Feb 2024 13:19:03 +0800
Message-Id: <3abafddb569a0bfdd39966e7422a977f2b7b4b56.1706764519.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706764519.git.tanggeliang@kylinos.cn>
References: <cover.1706764519.git.tanggeliang@kylinos.cn>
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
index 876ac75a58e6..da4e75c753ad 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1669,7 +1669,7 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1719,6 +1719,11 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
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
index 3dd7adc6b7fc..49dd60a95c9c 100644
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

