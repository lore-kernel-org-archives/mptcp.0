Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6353C487BF
	for <mptcp@lists.linux.dev>; Wed, 10 Jan 2024 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gst5xVD3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704892787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zatsqEzqKcWjrliKxwxGqXbL/l7nsN7Z6hxdAqJhLg4=;
	b=gst5xVD38BPDXHhdlSkGK3TT00MufZLKhjCjGHMdvDYjo3q+Q/F1E5NIfI0FyLih+JptQh
	uZMOiff2dFF5i5TiJ9NQCnTv+oeNME4RBrzMcgQMbdETgkqgXsA54MBBybgf0+wUsgl5+T
	fvQZZWsSPhQKntttXpEXaCO7YQontiU=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v8 02/23] mptcp: add needs_id for userspace appending addr
Date: Wed, 10 Jan 2024 21:19:10 +0800
Message-Id: <aeeff185a55f2dead9c1213ae65b3070eda07185.1704892316.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1704892316.git.geliang.tang@linux.dev>
References: <cover.1704892316.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When userspace PM requires to create an ID 0 subflow in "userspace pm
create id 0 subflow" test like this:

        userspace_pm_add_sf $ns2 10.0.3.2 0

An ID 1 subflow, in fact, is created.

Since in mptcp_pm_nl_append_new_local_addr(), 'id 0' will be treated as
no ID is set by userspace, and will allocate a new ID immediately:

     if (!e->addr.id)
             e->addr.id = find_next_zero_bit(pernet->id_bitmap,
                                             MPTCP_PM_MAX_ADDR_ID + 1,
                                             1);

To solve this issue, a new parameter needs_id is added for
mptcp_userspace_pm_append_new_local_addr() to distinguish between
whether userspace PM has set an ID 0 or whether userspace PM has
not set any address.

In mptcp_userspace_pm_get_local_id(), needs_id is always true, but in
mptcp_pm_nl_announce_doit() and mptcp_pm_nl_subflow_create_doit(),
pass mptcp_pm_parse_needs_id() to needs_it.

Fixes: e5ed101a6028 ("mptcp: userspace pm allow creating id 0 subflow")
Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_userspace.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4f3901d5b8ef..26bf627abc87 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -26,7 +26,8 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 }
 
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
-						    struct mptcp_pm_addr_entry *entry)
+						    struct mptcp_pm_addr_entry *entry,
+						    bool needs_id)
 {
 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct mptcp_pm_addr_entry *match = NULL;
@@ -41,7 +42,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
-		if (addr_match && entry->addr.id == 0)
+		if (addr_match && entry->addr.id == 0 && needs_id)
 			entry->addr.id = e->addr.id;
 		id_match = (e->addr.id == entry->addr.id);
 		if (addr_match && id_match) {
@@ -64,7 +65,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		}
 
 		*e = *entry;
-		if (!e->addr.id)
+		if (!e->addr.id && needs_id)
 			e->addr.id = find_next_zero_bit(id_bitmap,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
@@ -153,7 +154,7 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	if (new_entry.addr.port == msk_sport)
 		new_entry.addr.port = 0;
 
-	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry);
+	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry, true);
 }
 
 int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
@@ -198,7 +199,8 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val);
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val,
+						       mptcp_pm_parse_needs_id(addr, info));
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
 		goto announce_err;
@@ -378,7 +380,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	local.addr = addr_l;
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &local,
+						       mptcp_pm_parse_needs_id(laddr, info));
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
 		goto create_err;
-- 
2.40.1

