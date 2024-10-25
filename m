Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DB61D356E
	for <mptcp@lists.linux.dev>; Fri, 25 Oct 2024 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848774; cv=none; b=iqjzRfQwPHGDI8ta7sB1IF37HJYLwkSpDTtLz6QezNJM11K1rtyoTJrV/mYkXYQW6WpogUf0/vmxjPdIB4zJrSPI7oY8Uh73NybfrFjmGPzNCP7mj2Sy9qR97iMkNKl4yY+QYEWVyM/8CFgXg4XcRdTxgNBISsJGFFqRByLrVDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848774; c=relaxed/simple;
	bh=pe0ozo/m4xULdH9orv2JKinsOrPLim+Ex/qUym0rLrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p7Ch4cRV09Z2AV/yvc1zFKA0YSu+RTmlRzwS/nD69jPHWLDK8zAfoudTqqUtiWx2jhJyWrMN/r21R1ALBxTSn4hT3Koip3cKk12oTXMeSGIEguymuNv8K8kfy0r2pRYX44/KHEhyXqeEeaU9a+SlzYL2T/X2fXdFUZirR9U9dWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rI2nByDP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rI2nByDP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D06BC4CEE7;
	Fri, 25 Oct 2024 09:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729848773;
	bh=pe0ozo/m4xULdH9orv2JKinsOrPLim+Ex/qUym0rLrs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rI2nByDPeYGZd8hz4KbZasbSOlldh0O9PQlCKcRQnUihkyPC5h2GiHrH7te10kkoS
	 xZtt0rwwqqfRAtwjeMCyrhf69BbJjtF2Z4x9+aTO9VhsiyaTV5zlYZ70ojYZi1U+HH
	 +eNQv9Smpi9/Lz19Ny8K9AhWsDaegNxiuBkmRkm4RWrm/KKPVrpjnJVNWpj6DPsKgG
	 JzUuGO+Lp54vSlHD/mttQ+AUlsKeR7njp2q1CAaCZjrpipjRZqIXOMY58IVXBdVNK7
	 3qjPEOGeRk2CLTVbOyL2xJpxtgnUYoqb892Ij40UXPbecnFBWdluqpnjelHKgxUaTW
	 kvxTpRg/0FO+A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 25 Oct 2024 11:32:30 +0200
Subject: [PATCH mptcp-net v2 2/3] mptcp: pm: lockless list traversal
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-mptcp-pm-lookup_addr_rcu-v2-2-1478f6c4b205@kernel.org>
References: <20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org>
In-Reply-To: <20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4532; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pe0ozo/m4xULdH9orv2JKinsOrPLim+Ex/qUym0rLrs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnG2XCE6q5DSbhHdp5/RJ3uYMBZYsNP19UFWnll
 KZH9yq5xdqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxtlwgAKCRD2t4JPQmmg
 cxrtD/4pC8G1SWeVVX6GdIxSxAA0xUaRfb5mLG7HrU9b1tvKn0x+8K5nJVi1yuYw8MmT6X3aHxd
 X8vyC8GgxwJk3zXosPVn9fOyUtPtNNnuMwtKnAqzVs0W7WbxANROmtxrqcTeefMJxKiTnteWMnV
 Iu5X1jC/Vs74+84NO1hY0nHJb0V02ooONuAY4+99YpGKTCamyFAfeyCIndQmDlxzh0u1Bc7SL14
 TmNis40CYuemAf2FpvPaZ3F9re/zYtQ/Zt5sO/H8pz08Yvz3vIs16VXetFbaEDLv/SeBkQ8IhJZ
 bK4hiRM+N2wdMMC5qUSWR0aJSEMK2X1OkanASZqadIoG2QvVF199ogCTfrTo0S+LsHVG+fbHd3P
 wLs5X2tj4ARgYtoOxbMozLHztgc3YbpmcCRE22CDwteMTwZ+JfuUqTf6CVMuFyt3B8CKT7Vya1k
 1s59KTVzsbapF7iKDchcFjkH/mEZEaqumQS+Oo8i2xMRikIs/qFEU7UhOLbmdWkbH/elsKwsDc1
 yzZR9SaR/kCk/NcuTex/9Wcc58B9WfYYE9cq7nhEkBfh1+IfgzWg/CuP1UoNEVGwMzCY+k5QIYI
 53DiSy66FI0OYwunhpCqKdh7tF1bKXb8Af9zZy4adOc6MeN7tmo6k1V6HanLAqrolRX70CS2s/j
 47JKRc1mO01bD0g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In a few places -- to get an endpoint, dump all of them, and change
their flags -- the list is iterated while holding the pernet->lock, but
only to read the content of the list. In these cases, we can replace the
spin locks, by RCU read ones, and use the _rcu variants to iterate over
the entries list in a lockless way.

To make it clear, the lookup helpers using the _rcu variant are renamed
with a _rcu suffix. The previous __lookup_addr() helper can then be
removed, but __lookup_addr_by_id() is still needed.

While at it, the IDs bitmap is copied before iterating the list to dump
the different addresses, to avoid any consistencies.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - This is not a fix, a small improvement for -next.
---
 net/mptcp/pm_netlink.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a93b9b7776b48781a883673fe5fd521a978487ff..f38e1ccd34e95cd88b179a8b50e6965731542871 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -520,12 +520,12 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 }
 
 static struct mptcp_pm_addr_entry *
-__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
+__lookup_addr_by_id_rcu(struct pm_nl_pernet *pernet, unsigned int id)
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+		if (entry->addr.id == id)
 			return entry;
 	}
 	return NULL;
@@ -1836,8 +1836,8 @@ int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 		goto fail;
 	}
 
-	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr_by_id(pernet, addr.addr.id);
+	rcu_read_lock();
+	entry = __lookup_addr_by_id_rcu(pernet, addr.addr.id);
 	if (!entry) {
 		GENL_SET_ERR_MSG(info, "address not found");
 		ret = -EINVAL;
@@ -1850,11 +1850,11 @@ int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 
 	genlmsg_end(msg, reply);
 	ret = genlmsg_reply(msg, info);
-	spin_unlock_bh(&pernet->lock);
+	rcu_read_unlock();
 	return ret;
 
 unlock_fail:
-	spin_unlock_bh(&pernet->lock);
+	rcu_read_unlock();
 
 fail:
 	nlmsg_free(msg);
@@ -1872,16 +1872,18 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 	struct net *net = sock_net(msg->sk);
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
+	unsigned long id_bitmap[4];
 	int id = cb->args[0];
 	void *hdr;
 	int i;
 
 	pernet = pm_nl_get_pernet(net);
+	bitmap_copy(id_bitmap, pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 
-	spin_lock_bh(&pernet->lock);
+	rcu_read_lock();
 	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
-		if (test_bit(i, pernet->id_bitmap)) {
-			entry = __lookup_addr_by_id(pernet, i);
+		if (test_bit(i, id_bitmap)) {
+			entry = __lookup_addr_by_id_rcu(pernet, i);
 			if (!entry)
 				break;
 
@@ -1903,7 +1905,7 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			genlmsg_end(msg, hdr);
 		}
 	}
-	spin_unlock_bh(&pernet->lock);
+	rcu_read_unlock();
 
 	cb->args[0] = id;
 	return msg->len;
@@ -2060,17 +2062,17 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
-	spin_lock_bh(&pernet->lock);
-	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr.addr.id) :
-			       __lookup_addr(pernet, &addr.addr);
+	rcu_read_lock();
+	entry = lookup_by_id ? __lookup_addr_by_id_rcu(pernet, addr.addr.id) :
+			       __lookup_addr_rcu(pernet, &addr.addr);
 	if (!entry) {
-		spin_unlock_bh(&pernet->lock);
+		rcu_read_unlock();
 		GENL_SET_ERR_MSG(info, "address not found");
 		return -EINVAL;
 	}
 	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
 	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-		spin_unlock_bh(&pernet->lock);
+		rcu_read_unlock();
 		GENL_SET_ERR_MSG(info, "invalid addr flags");
 		return -EINVAL;
 	}
@@ -2078,7 +2080,7 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 	changed = (addr.flags ^ entry->flags) & mask;
 	entry->flags = (entry->flags & ~mask) | (addr.flags & mask);
 	addr = *entry;
-	spin_unlock_bh(&pernet->lock);
+	rcu_read_unlock();
 
 	mptcp_nl_set_flags(net, &addr.addr, bkup, changed);
 	return 0;

-- 
2.45.2

