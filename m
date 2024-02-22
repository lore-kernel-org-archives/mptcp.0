Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504B117BD3
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589050; cv=none; b=UkHWYYJtia2WXtVWkaIvdRNjdBzOpvjiPhkcjowBdJcZNHEwJKo0DPYUKxQaHOyfT+dK+ZOvDf6V7NjnGulf7KJrEHlD9S449bw+vnMrmOIl1RUcoGw67OTvMqD8At/5Uf9k9sM7uFza7ddXBFDY81zUZvNIukJEBLP1pdLk7SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589050; c=relaxed/simple;
	bh=ancl2DzBmhfqqS8OZ5ING8p/4YGbuu8z+XpjU1I6DB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WRrtaS64WDbEkUsXgRRUFieUD7fp1ZXXdCPEXlQaMXLbBWqcG8+1oM5od2Tu65bv05C9Gq59o81d+qAUZbof0Tz9vDp1fprglXjQGFqzjiUItLmnWvuXTCKE4ZZZN/uA94Zw1cNofl36sTZdo6b/vXUNVf3GiZleurAuFUoLBfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLHuXj6y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLHuXj6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B09BC433C7;
	Thu, 22 Feb 2024 08:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708589049;
	bh=ancl2DzBmhfqqS8OZ5ING8p/4YGbuu8z+XpjU1I6DB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QLHuXj6yQ7QsRNx62JYJHDufLDI8gb14Ko0ervtSm5yZF6TMk13tlRyiIqFRe0ljW
	 hAnNzNhaPT+j37xlcKEgpcZBxOfteAuy7OozhT/HBlE0IGrcBpl4r3DF29yg44n1XV
	 o6GGzHQOMkFoUo9p6ZS+w1UypmHP1HWRP2up/mQdR77vv86/hjkR0UUWF4VxgRIhAN
	 meNJZlrU6CkZ9pBJRjVf4U4JQWbzRxvwSTSx75M7PMMwAufgXUBKTdk6VlqWS5u+SN
	 7ZF98KWKGSyLEkUwdBFBFbZqOCrNb3R32lBfATarbnP5tkCgedcJUWZ1ojykIP8xFk
	 23Su2VOYEKwSQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 5/7] mptcp: drop lookup_by_id in lookup_addr
Date: Thu, 22 Feb 2024 16:03:56 +0800
Message-Id: <f555b05ef75161f9f73f897a967a3a115f5e3fa3.1708588977.git.tanggeliang@kylinos.cn>
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

When the lookup_by_id parameter of __lookup_addr() is true, it's the same
as __lookup_addr_by_id(), it can be replaced by __lookup_addr_by_id()
directly. So drop this parameter, let __lookup_addr() only looks up address
on the local address list by comparing addresses in it, not address ids.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 354083b8386f..5c17d39146ea 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -499,15 +499,12 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 }
 
 static struct mptcp_pm_addr_entry *
-__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
-	      bool lookup_by_id)
+__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if ((!lookup_by_id &&
-		     mptcp_addresses_equal(&entry->addr, info, entry->addr.port)) ||
-		    (lookup_by_id && entry->addr.id == info->id))
+		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
 	}
 	return NULL;
@@ -537,7 +534,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr, false);
+		entry = __lookup_addr(pernet, &mpc_addr);
 		if (entry) {
 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
 			msk->mpc_endpoint_id = entry->addr.id;
@@ -1918,7 +1915,8 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 		bkup = 1;
 
 	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr.addr.id) :
+			       __lookup_addr(pernet, &addr.addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		GENL_SET_ERR_MSG(info, "address not found");
-- 
2.40.1

