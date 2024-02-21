Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB98D3C1D
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497087; cv=none; b=j9s2xtsC+rLi6sQScFueIsaJl0cmPUglOrXy1VqPOdPFRjEWqTnCGmmqUDb6YN6fWyHE6WNwPFaCdhcA1Uf05hvYQaFxiFKE4/0NqMQF3O6zDet4xxD0r468CY/jFZe8LwEHC9Q4AnqmXton5nMPVxWcvvh9SdHzVEtOvQZQerQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497087; c=relaxed/simple;
	bh=ancl2DzBmhfqqS8OZ5ING8p/4YGbuu8z+XpjU1I6DB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UjOOqdECNp0sP4BFPZcsholML5cj+5BtJAzldwpJl+Y6CLIT5qMiszQjYmivhbLtdMOtKID6F8aaBiGKDCux9EThQ56edw/pxDujs0hUHf5TmL4l63bb2lLDMRtB0gfkXaqLqgdNrH7fcTOdaBXjitNgd4r9NSMAYPZ3XE0J9Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qpiz/+NS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qpiz/+NS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B161BC43399;
	Wed, 21 Feb 2024 06:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708497087;
	bh=ancl2DzBmhfqqS8OZ5ING8p/4YGbuu8z+XpjU1I6DB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qpiz/+NSgqe/hgcIf45s8xclAukOLPBpqHXLJfTCnVgPufRpZqmEDlkwpGPWJm0MT
	 gU4dCe3F0fsIBCDTPbYJ3Tb8tV1z8Xfn0UfRBRWt4w5kk1qAX+niiiuhyEFoJGGV1Z
	 z2kw6Oe+6Gn8CSQvIEJmt1CHdyrMyMvRdG/z6LJTySU/JIJZsgedQ5CWgou+E8H2rC
	 j+4mMNBynI/+Abl7Oj7968E5Js+6qmB/UK5q4c3u4XLypJ7JLojklRYc+FR3hgzmSX
	 cwIFLSlxYe4dKpvMOknZphA7ypyI1vrqeQ4n7brwt5+5Kg524pID1NkKzoHpbhA/br
	 dRdMamWeb7VKw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 5/8] mptcp: drop lookup_by_id in lookup_addr
Date: Wed, 21 Feb 2024 14:31:12 +0800
Message-Id: <d2268d6f3f74da2ccaf45bd184c95556795ffc3d.1708497039.git.tanggeliang@kylinos.cn>
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

