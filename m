Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1533C8F40
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558359; cv=none; b=LbsdQmUSLCwPkEpxLJdhWDix/m91tEiq24L88oIUJZzHU4k91cSlLY0G08ht4f/+nsIjVimx1R1VCf8JoXwWE+tjDWok0/DdWfXg6YqKq1YnxmWfRtiHAvIJJYg3g1m0vqklYj1fynUYf4udSkiNR1XtjKLDb0rL8TQGFZzyPxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558359; c=relaxed/simple;
	bh=eyu4+mR9wo/LMPTYxbqKaR+MnTHC9Kb+tlp2XtfuVE8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=jXuydDX5TiWcWztdazRZWBYUnAvcPJOKsiGLMWbyJ9yqtQZ/3xC/x9sppTYYHos0OwKtI9pmYXz7NeDIlfKbYw/XLnFzP2FTeOM1JYKYxEbCn+qAU1E5lqYj2T49xd3nTfk5QSxNSFISTQkWsawFUgeEeHrN5XwlGsn7zSVZcPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb/4WAW4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb/4WAW4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BB6C433B2;
	Thu, 18 Jan 2024 06:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558358;
	bh=eyu4+mR9wo/LMPTYxbqKaR+MnTHC9Kb+tlp2XtfuVE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zb/4WAW4v05pOQthCoLbTuDu4YNB09TjsYwo71xlgxvZApxG0yL5Q0pdbJjd8UotV
	 kjvOg1QAmPfJY0B58tImt8GPN7IFcjEQ4fopuoq+oJHzD8t2aglVEw44xRoLVBZHeN
	 t9w3AgooqPm22HG51tOapUaDIy4CwL1er9RVphMYWsuwys55+7WQ2yvHVbWSP4Btm4
	 Thv6ebtNwadyTbcYV0JKvwpNirTqTLxeAuK1vZ9zGUfFeywI/9zSicLSWZP8/CFV0H
	 bWnus6A1T7WzIWT/U9B7DD/Nj0/ceAwR9OyFGmmduOLGrFKsWFtj+T3x9DoPlOq5J5
	 IoYUD1HxMd60A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 22/23] mptcp: set error messages for set_flags
Date: Thu, 18 Jan 2024 14:12:02 +0800
Message-Id: <8f5a0070ce87532667655e243a9c8f054c24862f.1705558030.git.tanggeliang@kylinos.cn>
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

In addition to returning the error value, this patch also sets an error
messages with GENL_SET_ERR_MSG or NL_SET_ERR_MSG_ATTR both for pm_netlink.c
and pm_userspace.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 6 +++++-
 net/mptcp/pm_userspace.c | 9 +++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6e913498ff79..4ab68f83ddd5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1896,8 +1896,10 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 
 	if (addr.addr.family == AF_UNSPEC) {
 		lookup_by_id = 1;
-		if (!addr.addr.id)
+		if (!addr.addr.id) {
+			GENL_SET_ERR_MSG(info, "missing required inputs");
 			return -EOPNOTSUPP;
+		}
 	}
 
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
@@ -1907,11 +1909,13 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
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
index bb5672a4332e..ea9e8612da68 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -566,13 +566,17 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
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
@@ -586,6 +590,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 
 	if (loc.addr.family == AF_UNSPEC ||
 	    rem.addr.family == AF_UNSPEC) {
+		GENL_SET_ERR_MSG(info, "address families do not match");
 		ret = -EINVAL;
 		goto set_flags_err;
 	}
-- 
2.40.1

