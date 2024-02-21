Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6B23C1D
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 06:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497086; cv=none; b=VsIJT6OZUDZKSzD+1Ri86AaSmy8HfNeDUmsj9oa76wPYh6uX4vjU9VvLgqLsOGMgNjd0FMj145w8ANKedYzsILVplK7NGmrwRzdZGa069grjiMGLzeVuRBndre2U/8wR6L95MXK44MS6ZlNKVlQwqJEaqCvBwu0rEABqFKYO5e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497086; c=relaxed/simple;
	bh=QgViPpcI22Pi+BtO3/Fhm6dq6EBky8F2BcTELngVd+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZwHAiYCEbfcuWAnDOVEFCxLBpxS7sWDrOP8ymd81tQM7UwvHccFmdKec4mQbQF1JQ8Qjr55ov9vEzFo+VMddJCA1dXunvCCBcd/9qtY3wA5K+5I38wSapqPeOBSY/q1aSILDQsQGAdFsyppHQKkDpGeA9rHyKaHbfaXtr0m91o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6HAFOxV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6HAFOxV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEB7C433F1;
	Wed, 21 Feb 2024 06:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708497086;
	bh=QgViPpcI22Pi+BtO3/Fhm6dq6EBky8F2BcTELngVd+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o6HAFOxVo1z4rG4RltW6L0HfmJxtHRMCl0L82ct2UcyJKGklzonayc3oD1Od0LSII
	 AiPy/y6iKZEo8VBXkuLCAZL8ebQ5+dDXk+0ejE6PjnVYaEGPRQ+ORKctR5T1y0/njM
	 6DNLT2pE3dB0pIYUlABk0RuUarcmXZEf1lT7ED1ax0nePeV0TMZJiLlhRHTANY8dd7
	 T+0+nHQYLlt2gKYOVZ7vZiJkJFsZYThX6HMjju/jKxYVZkq00H83LT7iK4xmYkpd2/
	 3Bdk2D5HRXvXFGqZSkKMAKODQLfiWAucqNmxoUNVkstk/FMZInUK1IvMG7aUo3l34w
	 fglIy6ooyWv6Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/8] mptcp: set error messages for set_flags
Date: Wed, 21 Feb 2024 14:31:11 +0800
Message-Id: <c8d6e3ae6b110da7d115b720825758708c9a7687.1708497039.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708497039.git.tanggeliang@kylinos.cn>
References: <cover.1708497039.git.tanggeliang@kylinos.cn>
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
and pm_userspace.c.

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
index 7ef3b69852f0..09a60f440fef 100644
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
+		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto set_flags_err;
+	}
 
 	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
 	if (ret < 0)
@@ -583,6 +587,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 
 	if (loc.addr.family == AF_UNSPEC ||
 	    rem.addr.family == AF_UNSPEC) {
+		GENL_SET_ERR_MSG(info, "address families do not match");
 		ret = -EINVAL;
 		goto set_flags_err;
 	}
-- 
2.40.1

