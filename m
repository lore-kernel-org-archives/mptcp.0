Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA88317BD9
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589049; cv=none; b=dhYC/EwOzmm5E03QxDpqqmXAUpyH4kndiG3lOu2W4kGn23V1rZcVYwgp33Togc4NmYzbkloS9LQK4tBO4OAD28Vhh7uto2UQjPbB1kYufotf375YDPD5WeYNONUXrA6fJM3SRhBV1zHy52ere+ndTAtm1SliiBguFPM/UcjSk+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589049; c=relaxed/simple;
	bh=QBkh2Zicsocn0K0m92k5uZN4Jw86khcAHLTfalFjZqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EZaws4aaBtBusx4Nk9D+uZx6lPo97Ds/3bWgdbseXMKpI/nulT6asyZye/I51fxfa3Ood2UA1+RjPHDGy45FDY6oWuKMNS/wBK+oQV0lgnTa0QbALmzcnHlUDjuCvf3xjRESIA248xmqHx7eWXakfzjCVSXf9P3t9roWDqNLFyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViVj4vqs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViVj4vqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50CFC433F1;
	Thu, 22 Feb 2024 08:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708589048;
	bh=QBkh2Zicsocn0K0m92k5uZN4Jw86khcAHLTfalFjZqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ViVj4vqsQ1S3SLqF86XhP6IbNjGlrdTLFuxJaxTlbPOCsIP2L6ny3f5JwhEjoodf0
	 FRctSIGLSkDuQ+pmi4j2oTOHlGLq3ttb4DiSlaCwCa5qL9Ih4y0YhfK4jcbzWCbA5e
	 b4h5TG39r7lutE9QggGLa5DiQiT3LwSoIkgaESXgwGpQUZkBjU1+sauU5fDOWOss+m
	 9aXCqGTUTAaOptcurEdrejHbQIaztQmT7nehoVPON/iusqzeqg1wWwSOqnKQhFLUpC
	 7pcin0B25ygidofuDOh4K723KLpUK3+PpuOqP6hvr/PTbjXw2b3lnODL5n0PlnEVZb
	 lIzXH9hoVn13g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/7] mptcp: set error messages for set_flags
Date: Thu, 22 Feb 2024 16:03:55 +0800
Message-Id: <8d81f9269356ffaf710daef741ae9c155c63efdc.1708588977.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708588977.git.tanggeliang@kylinos.cn>
References: <cover.1708588977.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In addition to returning the error value, this patch also sets an error
messages with GENL_SET_ERR_MSG or NL_SET_ERR_MSG_ATTR both for pm_netlink.c
and pm_userspace.c. It will help the userspace to identify the issue.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 6 +++++-
 net/mptcp/pm_userspace.c | 9 +++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c799fe84dfd3..354083b8386f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1908,8 +1908,10 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 
 	if (addr.addr.family == AF_UNSPEC) {
 		lookup_by_id = 1;
-		if (!addr.addr.id)
+		if (!addr.addr.id) {
+			GENL_SET_ERR_MSG(info, "missing required inputs");
 			return -EOPNOTSUPP;
+		}
 	}
 
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
@@ -1919,11 +1921,13 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 	entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
+		GENL_SET_ERR_MSG(info, "address not found");
 		return -EINVAL;
 	}
 	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
 	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
 		spin_unlock_bh(&pernet->lock);
+		GENL_SET_ERR_MSG(info, "invalid addr flags");
 		return -EINVAL;
 	}
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7ef3b69852f0..9f5d422d5ef6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -563,13 +563,17 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	token_val = nla_get_u32(token);
 
 	msk = mptcp_token_get_sock(net, token_val);
-	if (!msk)
+	if (!msk) {
+		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
 		return ret;
+	}
 
 	sk = (struct sock *)msk;
 
-	if (!mptcp_pm_is_userspace(msk))
+	if (!mptcp_pm_is_userspace(msk)) {
+		GENL_SET_ERR_MSG(info, "userspace PM not selected");
 		goto set_flags_err;
+	}
 
 	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
 	if (ret < 0)
@@ -583,6 +587,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 
 	if (loc.addr.family == AF_UNSPEC ||
 	    rem.addr.family == AF_UNSPEC) {
+		GENL_SET_ERR_MSG(info, "invalid address families");
 		ret = -EINVAL;
 		goto set_flags_err;
 	}
-- 
2.40.1

