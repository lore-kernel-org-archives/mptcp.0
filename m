Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA961AACE
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910858; cv=none; b=CTLyhrt3ZsMtrC+JMB5R62mgfC9VRubqOv45uD651h0qQwaeN/6Xvhj/ttEqMNJUIuONJU9BMqU/LgB0kFAUXCeC4U7avRVDZl7we3aqRjcxbw5ZVC37VTsxzywuwcWkAsBn70g94zrIlHjqRYnBEv1Nir1Q/3ACAgk6rFfOIAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910858; c=relaxed/simple;
	bh=tibaRUxbzkCdKyaYGOvM9dCcDxCnbZho5PwpmHnS4as=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cpu6T/zdwmhWCqI66dDEJ+m3N7MjP9EoK4bMQgyceboJLzlZcTH3oeolXeCgnljbeSzDn5xMDMkmmKbFjS+gbDbIDizojDUrVH336Px4ysKKntrOKkg2gZ8s3pPE+dfwrrcRTYvpC6LtwBOKUB/tjjOVWGz+4zE6zue2ELF//24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ja13gX5E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja13gX5E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97981C433C7;
	Wed, 14 Feb 2024 11:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707910857;
	bh=tibaRUxbzkCdKyaYGOvM9dCcDxCnbZho5PwpmHnS4as=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ja13gX5EPs34x0Yf+KrrFDgECnB8CXACRjXOn7Ntyg6Elxhf0twn4P54hhgYaorvS
	 cMemVAWAjmQu8W7yzbupEd8IMy0L+16O3cPS16WZXpVFRJXEXA0XXRsrxFgK8+n+Gy
	 XOatPtuQOQUhVpw/xwJfp4XGFPxkdu5zVW4nhYDteq8/Q68QAtL28ijFzuHrrIMdcB
	 UagHql67jsNUEm5lTkqP50x5CJG9qQemsyoOSj6GtaSsWM1xARLPp6zHOmOnDw6eZp
	 gpS/7Q4Jr6aUo4DCDlJMkeBdNhjrEp0FrAs+r0IuyYx5tdLmKqruIaPG1SvJ7v64jZ
	 +hf28Dv35qv4A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 05/15] mptcp: check userspace pm flags
Date: Wed, 14 Feb 2024 19:39:56 +0800
Message-Id: <85601d20f7e071407d31681062d70b64fa455549.1707910454.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707910454.git.tanggeliang@kylinos.cn>
References: <cover.1707910454.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Just like MPTCP_PM_ADDR_FLAG_SIGNAL flag is checked in userspace PM
announce mptcp_pm_nl_announce_doit(), PM flags should be checked in
mptcp_pm_nl_subflow_create_doit() too.

If MPTCP_PM_ADDR_FLAG_SUBFLOW flag is not set, there's no flags field
in the output of dump_addr. This looks a bit strange:

        id 10 flags  10.0.3.2

This patch uses mptcp_pm_parse_entry() instead of mptcp_pm_parse_addr()
to get the PM flags of the entry and check it. MPTCP_PM_ADDR_FLAG_SIGNAL
flag shouldn't be set here, and if MPTCP_PM_ADDR_FLAG_SUBFLOW flag is
missing from the netlink attribute, always set this flag.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d6b7be3afbe5..73ad286247f1 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -360,11 +360,20 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	err = mptcp_pm_parse_entry(laddr, info, true, &local);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto create_err;
 	}
+	addr_l = local.addr;
+
+	if (local.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
+		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		err = -EINVAL;
+		goto create_err;
+	}
+	if (!(local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
+		local.flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
 
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
@@ -378,7 +387,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	local.addr = addr_l;
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &local, false);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
-- 
2.40.1

