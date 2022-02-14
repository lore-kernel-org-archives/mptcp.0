Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3A67A
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 15:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644853172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J86av2Bkw6U2xVnT0WBv2YPqSRgcSeCjGVTPkPasr0k=;
	b=FR+wCEoWZZJ/NC1QvbtIT5i1mSGDKV4hShxHunisyqKKjUaA5A92/0Qm/E67L5nMfETsy7
	YoCoxtplzXiLPalIL5k+cOf4uLDnYEJ15c5nJniH4xNY+foOUVhko1D8BK4WGCVcogVc3e
	j/ubV/haH9dHllOK/pAFov2nmHLD93E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-Dx1plPEAPleIIqfdVNjY1Q-1; Mon, 14 Feb 2022 10:39:25 -0500
X-MC-Unique: Dx1plPEAPleIIqfdVNjY1Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E254F343C9
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 15:39:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.152])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 552E22B598
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 15:39:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-next 2/3] mptcp: more careful RM_ADDR generation
Date: Mon, 14 Feb 2022 16:38:56 +0100
Message-Id: <9ac38525eac5d4e812fd11f20125e28edd8514df.1644852970.git.pabeni@redhat.com>
In-Reply-To: <cover.1644852970.git.pabeni@redhat.com>
References: <cover.1644852970.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

In some edge scenarios, an MPTCP subflows can use a local address
mapped by a "implicit" endpoint created by the in-kernel path manager.

When such endpoint is deleted, the in kernel PM sends a RM_ADDR MPTCP
suboption. That is somewhat unexpected, as an MPTCP listener will keep
accepting incoming subflows targeting such address and the unexpected
options can confuse some self-tests.

Be more conservative about RM_ADDR generation: explicitly track the
implicit endpoint with an appropriate flag and exclude them from the
RM_ADDR generation.

Additionally allow the user-space to replace implicit endpoint with
user-provided data at endpoint creation time.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm_netlink.c     | 42 ++++++++++++++++++++++++++++----------
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index f106a3941cdf..9690efedb5fa 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -81,6 +81,7 @@ enum {
 #define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
 #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
 #define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
+#define MPTCP_PM_ADDR_FLAG_IMPLICIT			(1 << 4)
 
 enum {
 	MPTCP_PM_CMD_UNSPEC,
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 56f5603c10f2..66cda3a425c4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -901,8 +901,19 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 	list_for_each_entry(cur, &pernet->local_addr_list, list) {
 		if (addresses_equal(&cur->addr, &entry->addr,
 				    address_use_port(entry) &&
-				    address_use_port(cur)))
-			goto out;
+				    address_use_port(cur))) {
+			/* allow replacing the exiting endpoint only if such
+			 * endpoint is an implicit one and the user-space
+			 * did not provide an endpoint id
+			 */
+			if (!(cur->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT))
+				goto out;
+			if (entry->addr.id)
+				goto out;
+
+			pernet->addrs--;
+			list_del_rcu(&entry->list);
+		}
 	}
 
 	if (!entry->addr.id) {
@@ -1036,7 +1047,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	entry->addr.id = 0;
 	entry->addr.port = 0;
 	entry->ifindex = 0;
-	entry->flags = 0;
+	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0)
@@ -1238,6 +1249,11 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 
+	if (addr.flags & MPTCP_PM_ADDR_FLAG_IMPLICIT) {
+		GENL_SET_ERR_MSG(info, "can't create IMPLICIT endpoint");
+		return -EINVAL;
+	}
+
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry) {
 		GENL_SET_ERR_MSG(info, "can't allocate addr");
@@ -1322,11 +1338,12 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
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
 
@@ -1346,7 +1363,8 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 
 		lock_sock(sk);
 		remove_subflow = lookup_subflow_by_saddr(&msk->conn_list, addr);
-		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow);
+		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
+					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 		if (remove_subflow)
 			mptcp_pm_remove_subflow(msk, &list);
 		release_sock(sk);
@@ -1443,7 +1461,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	__clear_bit(entry->addr.id, pernet->id_bitmap);
 	spin_unlock_bh(&pernet->lock);
 
-	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), &entry->addr);
+	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), entry);
 	synchronize_rcu();
 	__mptcp_pm_release_addr_entry(entry);
 
@@ -1458,9 +1476,11 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 
 	list_for_each_entry(entry, rm_list, list) {
 		if (lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) &&
-		    alist.nr < MPTCP_RM_IDS_MAX &&
 		    slist.nr < MPTCP_RM_IDS_MAX) {
-			alist.ids[alist.nr++] = entry->addr.id;
+			/* skip RM_ADDR for dummy endpoints */
+			if (!(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT) &&
+			    alist.nr < MPTCP_RM_IDS_MAX)
+				alist.ids[alist.nr++] = entry->addr.id;
 			slist.ids[slist.nr++] = entry->addr.id;
 		} else if (remove_anno_list_by_saddr(msk, &entry->addr) &&
 			 alist.nr < MPTCP_RM_IDS_MAX) {
@@ -1811,7 +1831,7 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 
 	spin_lock_bh(&pernet->lock);
 	entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
-	if (!entry) {
+	if (!entry || (entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT)) {
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
 	}
-- 
2.34.1

