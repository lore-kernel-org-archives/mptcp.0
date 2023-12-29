Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E657D111A6
	for <mptcp@lists.linux.dev>; Fri, 29 Dec 2023 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O51myiDh"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703854114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhFcg1lf0oz36e4EdnbO4QVX48RSgjKf8OPDSUsbLAc=;
	b=O51myiDhXucGQHd3t95sRu1rq2DcNzEx5UBXr0Lv82wUFpYlvaXOCZJJhLVvXLowKH/Fte
	sIbO3BDjtRxutvP2b17xjJi06YSaI9qZvqYGJdb3nJ9f3pdabswNCLuf7ETrO5xDTr7Fwd
	RXdB35XbPtIUdYwPJlJ5H+bcbBQrzOE=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v6 03/24] mptcp: test set_id flag when appending addr
Date: Fri, 29 Dec 2023 20:47:21 +0800
Message-Id: <17b98b8e390676fa330c1343db0c7ab2786a1beb.1703853512.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1703853512.git.geliang.tang@linux.dev>
References: <cover.1703853512.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch tests MPTCP_PM_ADDR_FLAG_SET_ID flag when appending a new
address in mptcp_pm_nl_append_new_local_addr() in pm_netlink.c and in
mptcp_userspace_pm_append_new_local_addr() in pm_userspace.c. If this
flag is set, do not alloc new address ID from id_bitmap, just keep the
userspace set address ID.

Fixes: e5ed101a6028 ("mptcp: userspace pm allow creating id 0 subflow")
Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_netlink.c   | 7 +++++--
 net/mptcp/pm_userspace.c | 9 +++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index dedc5a038b10..8a311b497603 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -949,7 +949,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id) {
+	if (!entry->addr.id && !(entry->flags & MPTCP_PM_ADDR_FLAG_SET_ID)) {
 find_next:
 		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
 						    MPTCP_PM_MAX_ADDR_ID + 1,
@@ -960,9 +960,12 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id)
+	if (!entry->addr.id && !(entry->flags & MPTCP_PM_ADDR_FLAG_SET_ID))
 		goto out;
 
+	if (entry->flags & MPTCP_PM_ADDR_FLAG_SET_ID)
+		entry->flags &= ~MPTCP_PM_ADDR_FLAG_SET_ID;
+
 	__set_bit(entry->addr.id, pernet->id_bitmap);
 	if (entry->addr.id > pernet->next_id)
 		pernet->next_id = entry->addr.id;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8134dbdc7005..ce8ae7aa5aad 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -41,8 +41,11 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
-		if (addr_match && entry->addr.id == 0)
+		if (addr_match && entry->addr.id == 0 &&
+		    !(entry->flags & MPTCP_PM_ADDR_FLAG_SET_ID))
 			entry->addr.id = e->addr.id;
+		else if (entry->flags & MPTCP_PM_ADDR_FLAG_SET_ID)
+			entry->flags &= ~MPTCP_PM_ADDR_FLAG_SET_ID;
 		id_match = (e->addr.id == entry->addr.id);
 		if (addr_match && id_match) {
 			match = e;
@@ -64,10 +67,12 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		}
 
 		*e = *entry;
-		if (!e->addr.id)
+		if (!e->addr.id && !(e->flags & MPTCP_PM_ADDR_FLAG_SET_ID))
 			e->addr.id = find_next_zero_bit(id_bitmap,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
+		else if (e->flags & MPTCP_PM_ADDR_FLAG_SET_ID)
+			e->flags &= ~MPTCP_PM_ADDR_FLAG_SET_ID;
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-- 
2.39.2

