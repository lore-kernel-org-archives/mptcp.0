Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FADB134D5
	for <mptcp@lists.linux.dev>; Fri,  8 Dec 2023 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wGxIPd2u"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702030032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/W/SLMN8iWwqkS8rQ743ci5RCMTJH+kP9lh017PWi+I=;
	b=wGxIPd2uHmcGgodXAL3tA6XOw1k5LuP9w4U7X9ZUT+0Su4CCqCew/gDjo4mCJvRSnOjZbx
	D0TQ08Ws/iZ5kAV70Tk0KyRwe68VsCPkUcc0HQvAcGWJxOZVZsugik12gQw/m+AMqSG6+u
	E7gkSQROjYknwXlpWFrulxs+m25u63I=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v14 05/25] mptcp: drop lookup_by_id parameter in lookup_addr
Date: Fri,  8 Dec 2023 18:07:18 +0800
Message-Id: <f50042d8de73da78583a69776f14e1d16c0ba201.1702029538.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702029538.git.geliang.tang@linux.dev>
References: <cover.1702029538.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When the lookup_by_id parameter of __lookup_addr() is true, it's the same
as __lookup_addr_by_id(), it can be replaced by __lookup_addr_by_id()
directly. So drop this parameter, let __lookup_addr() only looks up address
on the local address list by comparing addresses in it, not address ids.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_netlink.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2246904c6cf5..1c85d711a86e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -458,15 +458,12 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
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
@@ -496,7 +493,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr, false);
+		entry = __lookup_addr(pernet, &mpc_addr);
 		if (entry) {
 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
 			msk->mpc_endpoint_id = entry->addr.id;
@@ -1835,7 +1832,8 @@ int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8
 	}
 
 	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr(pernet, &addr->addr, lookup_by_id);
+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr->addr.id) :
+			       __lookup_addr(pernet, &addr->addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
-- 
2.35.3

