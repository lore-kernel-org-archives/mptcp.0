Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034F72C9E
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 18:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644518974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Y25qPVEtZdEWPZPhZ8Fu9k9PFMIJUGonmkwYLBriCs=;
	b=IBojfdVK39NratIw1SF8FqiXohvMwsJe6a4MTyeY9ExNhqz0h0CekCkM82EqjfgsziIG/b
	/u3wFOV63w2lh0eo2sKVYsC/skgXQeyzR0/lT4tpkECC/80/LMJoq19YHpum/9XoMDzMMT
	q68qB6toNuWoCOH78kLQ2YwW3E+VAGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-FKbHNahNMFCBBY_6tGi0LQ-1; Thu, 10 Feb 2022 13:49:30 -0500
X-MC-Unique: FKbHNahNMFCBBY_6tGi0LQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 363A01091DA5
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 18:49:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.220])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9A631106C0D5
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 18:49:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 2/3] mptcp: more careful RM_ADDR generation
Date: Thu, 10 Feb 2022 19:49:16 +0100
Message-Id: <baade0ed606c745a8acd5bcb075269550cd80544.1644518737.git.pabeni@redhat.com>
In-Reply-To: <cover.1644518737.git.pabeni@redhat.com>
References: <cover.1644518737.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

In some edge scenarios, an MPTCP subflows can use a local address
mapped by a "dummy" endpoint created by the in kernel path manager.

When such endpoint is deleted, the in kernel PM sends a RM_ADDR MPTCP
suboption. That is somewhat unexpected, as an MPTCP listener will keep
accepting incoming subflows targeting such address and the unexpected
options can confuse some self-tests.

Be more conservative about RM_ADDR generation: do it only if the
relevant endpoint has either the SIGNAL or SUBFLOW flag - it's not a
dummy one.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm_netlink.c     | 25 +++++++++++++++++--------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index f106a3941cdf..34ca8c04f64e 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -81,6 +81,7 @@ enum {
 #define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
 #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
 #define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
+#define MPTCP_PM_ADDR_FLAG_DUMMY			(1 << 4)
 
 enum {
 	MPTCP_PM_CMD_UNSPEC,
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 56f5603c10f2..928ebe4949e9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1036,7 +1036,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	entry->addr.id = 0;
 	entry->addr.port = 0;
 	entry->ifindex = 0;
-	entry->flags = 0;
+	entry->flags = MPTCP_PM_ADDR_FLAG_DUMMY;
 	entry->lsk = NULL;
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0)
@@ -1238,6 +1238,11 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 
+	if (addr.flags & MPTCP_PM_ADDR_FLAG_DUMMY) {
+		GENL_SET_ERR_MSG(info, "can't create DUMMY endpoint");
+		return -EINVAL;
+	}
+
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry) {
 		GENL_SET_ERR_MSG(info, "can't allocate addr");
@@ -1322,11 +1327,12 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 }
 
 static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
-						   struct mptcp_addr_info *addr)
+						   const struct mptcp_pm_addr_entry *entry)
 {
-	struct mptcp_sock *msk;
-	long s_slot = 0, s_num = 0;
+	const struct mptcp_addr_info *addr = &entry->addr;
 	struct mptcp_rm_list list = { .nr = 0 };
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
 
 	pr_debug("remove_id=%d", addr->id);
 
@@ -1346,7 +1352,8 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 
 		lock_sock(sk);
 		remove_subflow = lookup_subflow_by_saddr(&msk->conn_list, addr);
-		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow);
+		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
+						     !(entry->flags & MPTCP_PM_ADDR_FLAG_DUMMY));
 		if (remove_subflow)
 			mptcp_pm_remove_subflow(msk, &list);
 		release_sock(sk);
@@ -1443,7 +1450,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	__clear_bit(entry->addr.id, pernet->id_bitmap);
 	spin_unlock_bh(&pernet->lock);
 
-	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), &entry->addr);
+	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), entry);
 	synchronize_rcu();
 	__mptcp_pm_release_addr_entry(entry);
 
@@ -1458,9 +1465,11 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 
 	list_for_each_entry(entry, rm_list, list) {
 		if (lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) &&
-		    alist.nr < MPTCP_RM_IDS_MAX &&
 		    slist.nr < MPTCP_RM_IDS_MAX) {
-			alist.ids[alist.nr++] = entry->addr.id;
+			/* skip RM_ADDR for dummy endpoints */
+			if (!(entry->flags & MPTCP_PM_ADDR_FLAG_DUMMY) &&
+			    alist.nr < MPTCP_RM_IDS_MAX)
+				alist.ids[alist.nr++] = entry->addr.id;
 			slist.ids[slist.nr++] = entry->addr.id;
 		} else if (remove_anno_list_by_saddr(msk, &entry->addr) &&
 			 alist.nr < MPTCP_RM_IDS_MAX) {
-- 
2.34.1

