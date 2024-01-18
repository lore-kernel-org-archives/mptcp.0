Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42988F40
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558353; cv=none; b=jf2NdCnpQEvI/r0Y0shEanV+oJnBE9rOSw6qNll+6/CTrG69OFMl1ZcradLHDGFToPs7pX5BgZ2GSOsiTAaikiVPQf+AzUcyjEcNHgwEC8dK+ila9g1Zq2PChBQy4w/nWSwaLn3yCwNnHcyCOyA0wEZFm7tAz8y/IGDn7Shdt4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558353; c=relaxed/simple;
	bh=YwvQ7oPWRudLqfFMGu68GfF9V2i2lmBKHkUq+IOfIdo=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=JAz3Dgli5eztQjPM1raxLE9zyzPq+tEohIrgdOX7y444GhVOahQJ5jIv79brXKkKB1yND3CIhTfwm7ibdU6FQpm2Q4eAL1rgC6smlJDdseeGi0zMVRxTRv8gR0Xh2iOA5qkxEbvUKjCWwX4pJRKiy9z99XNsDnCI2oj8WpLGqpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMuh7Ar/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMuh7Ar/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AC4C433F1;
	Thu, 18 Jan 2024 06:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558353;
	bh=YwvQ7oPWRudLqfFMGu68GfF9V2i2lmBKHkUq+IOfIdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hMuh7Ar/RM1OaWJwe+wwlqvc9+dKGUvEP9Y01ZaorE9mPp5tLrCcigCql5meiSwWY
	 VLdQKofYHKqssK7Y4YlgoMn8yBqwhxmxvi8fEljeivDyj/arKfMdxEeuQUPEXBawgq
	 y4CwpYIfZNuYZu6juWrdLuG1XU2hEogBE4x1J1ziTGX9zQE9zqgizWXzM1yVOtDdP1
	 ueMk/NPK/xDPMGz6xLaiZNsi7Wu9JRL5lx7LL8UL6LpNponxoDilo7uSQzWEDcsTiu
	 56USb8wfYxuW0sJdV+gDupv5/R8XaXc/pqgoXK7d8kuErTph84gsuwSGl5AYUJjCDZ
	 ryQ7iSsj80N4g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 18/23] mptcp: get addr in userspace pm list
Date: Thu, 18 Jan 2024 14:11:58 +0800
Message-Id: <c7012826c6c025d45f2cbda79f70be9c49cfbd8a.1705558030.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1705558030.git.tanggeliang@kylinos.cn>
References: <cover.1705558030.git.tanggeliang@kylinos.cn>
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
index 481f8becc3b4..d05c2c221932 100644
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
index 6fedf271e26d..c227c8909cd3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1657,7 +1657,7 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1707,6 +1707,11 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
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
index e2a8833bca05..a11d1a98beca 100644
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

