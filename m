Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACB32C9D
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 12:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1641902849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8/9ZmW7lVyd1YgZ0beURrAeJWPqAJdVDMC8rZ+4cj8k=;
	b=KxqL31ZIitPPAiUnkZsCdhFLOHRqJtGYQ/EC2LMdlGs4TUey8jD8QbkjB6yN1DPInLsL3y
	2ZfO2Z862eQzo6xRxFv0gmw5huD2cLJBxqq4Ilxw2WBVz1B/9MsvKAUJB6dslyZ7obh5nl
	UeLs6R4wBOX9e/6NPzSyDCmRw0Bbx3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-ScwQ-lPjNbuKxQzkf4J-sg-1; Tue, 11 Jan 2022 07:07:26 -0500
X-MC-Unique: ScwQ-lPjNbuKxQzkf4J-sg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02DE4344E1;
	Tue, 11 Jan 2022 12:07:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.69])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 388807B6E2;
	Tue, 11 Jan 2022 12:07:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-net] mptcp: fix msk traversal in mptcp_nl_cmd_set_flags()
Date: Tue, 11 Jan 2022 13:07:11 +0100
Message-Id: <a73b5ff4e26150d7db36a639ab671cb66c566e20.1641902813.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The MPTCP endpoint list is under RCU protection, guarded by the
pernet spinlock. mptcp_nl_cmd_set_flags() traverses the list
without acquiring the spin-lock nor under the RCU critical section.

This change addresses the issue performing the lookup and the endpoint
update under the pernet spinlock.

Fixes: 0f9f696a502e ("mptcp: add set_flags command in PM netlink")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f12effa71942..20b9037c4906 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -478,6 +478,20 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 	return NULL;
 }
 
+static struct mptcp_pm_addr_entry *
+__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
+	      bool lookup_by_id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &pernet->local_addr_list, list) {
+		if ((!lookup_by_id && addresses_equal(&entry->addr, info, true)) ||
+		    (lookup_by_id && entry->addr.id == info->id))
+			return entry;
+	}
+	return NULL;
+}
+
 static int
 lookup_id_by_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *addr)
 {
@@ -1757,18 +1771,21 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 			return -EOPNOTSUPP;
 	}
 
-	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if ((!lookup_by_id && addresses_equal(&entry->addr, &addr.addr, true)) ||
-		    (lookup_by_id && entry->addr.id == addr.addr.id)) {
-			mptcp_nl_addr_backup(net, &entry->addr, bkup);
-
-			if (bkup)
-				entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
-			else
-				entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
-		}
+	spin_lock_bh(&pernet->lock);
+	entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
+	if (!entry) {
+		spin_unlock_bh(&pernet->lock);
+		return -EINVAL;
 	}
 
+	if (bkup)
+		entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
+	else
+		entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
+	addr = *entry;
+	spin_unlock_bh(&pernet->lock);
+
+	mptcp_nl_addr_backup(net, &addr.addr, bkup);
 	return 0;
 }
 
-- 
2.33.1

