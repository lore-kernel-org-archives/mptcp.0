Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882D21FD3
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 21:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1645134297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QBQR2Q/3YGZHJOkOX0gjkQLxVWn2naaTBsFiPscPD8c=;
	b=UwU+fxQjz1GTDCJBBB0z1SVq6u/Z09IHSbmXeJP6kexVGWx6EDY6FM18Uigs002MxaDjcj
	B+41xRg+Pf92I3n+GiqxwQlfG0mzeXCIqv5i2/zMeIIDS+VzjS2Hi8SCJ7V2lq4I8+tBnl
	sC4t+b/6GQ6WOGvVUj9o+dT7Ual7u4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611--P_97MFjMqGEHoY5pxBrsg-1; Thu, 17 Feb 2022 16:44:55 -0500
X-MC-Unique: -P_97MFjMqGEHoY5pxBrsg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23CA015720
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 21:44:54 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4776445312
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 21:44:53 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v5 mptcp-next 2/4] mptcp: introduce implicit endpoints
Date: Thu, 17 Feb 2022 22:44:12 +0100
Message-Id: <c61d182cc55806cbc6379aeb42d8722c54b1b386.1645134065.git.pabeni@redhat.com>
In-Reply-To: <cover.1645134065.git.pabeni@redhat.com>
References: <cover.1645134065.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

In some edge scenarios, an MPTCP subflows can use a local address
mapped by a "implicit" endpoint created by the in-kernel path manager.

Such endpoints presence can be confusing, as it's creation is hard
to track and will prevent the later endpoint creation from the user-space
using the same address.

Define a new endpoint flag to mark implicit endpoints and allow the
user-space to replace implicit them with user-provided data at endpoint
creation time.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
 - fixed a few book-keeping issues detected by the paired self-test
---
 include/uapi/linux/mptcp.h                    |  1 +
 net/mptcp/pm_netlink.c                        | 61 +++++++++++++------
 .../testing/selftests/net/mptcp/mptcp_join.sh |  4 +-
 3 files changed, 47 insertions(+), 19 deletions(-)

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
index 619746611110..3bbc5f9b1983 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -877,10 +877,18 @@ static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 		MPTCP_PM_ADDR_FLAG_SIGNAL;
 }
 
+/* caller must ensure the RCU grace period is already elapsed */
+static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
+{
+	if (entry->lsk)
+		sock_release(entry->lsk);
+	kfree(entry);
+}
+
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 					     struct mptcp_pm_addr_entry *entry)
 {
-	struct mptcp_pm_addr_entry *cur;
+	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
 	unsigned int addr_max;
 	int ret = -EINVAL;
 
@@ -901,8 +909,22 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
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
+			entry->addr.id = cur->addr.id;
+			list_del_rcu(&cur->list);
+			del_entry = cur;
+			break;
+		}
 	}
 
 	if (!entry->addr.id) {
@@ -938,6 +960,12 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 
 out:
 	spin_unlock_bh(&pernet->lock);
+
+	/* just replaced an existing entry, free it */
+	if (del_entry) {
+		synchronize_rcu();
+		__mptcp_pm_release_addr_entry(del_entry);
+	}
 	return ret;
 }
 
@@ -1036,7 +1064,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	entry->addr.id = 0;
 	entry->addr.port = 0;
 	entry->ifindex = 0;
-	entry->flags = 0;
+	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0)
@@ -1238,6 +1266,11 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
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
@@ -1322,11 +1355,12 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
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
 
@@ -1346,7 +1380,8 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 
 		lock_sock(sk);
 		remove_subflow = lookup_subflow_by_saddr(&msk->conn_list, addr);
-		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow);
+		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
+					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 		if (remove_subflow)
 			mptcp_pm_remove_subflow(msk, &list);
 		release_sock(sk);
@@ -1359,14 +1394,6 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 	return 0;
 }
 
-/* caller must ensure the RCU grace period is already elapsed */
-static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
-{
-	if (entry->lsk)
-		sock_release(entry->lsk);
-	kfree(entry);
-}
-
 static int mptcp_nl_remove_id_zero_address(struct net *net,
 					   struct mptcp_addr_info *addr)
 {
@@ -1443,7 +1470,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	__clear_bit(entry->addr.id, pernet->id_bitmap);
 	spin_unlock_bh(&pernet->lock);
 
-	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), &entry->addr);
+	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), entry);
 	synchronize_rcu();
 	__mptcp_pm_release_addr_entry(entry);
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6f16337409e3..913866d5d570 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1819,7 +1819,7 @@ backup_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 	chk_join_nr "single address, backup" 1 1 1
 	chk_add_nr 1 1
-	chk_prio_nr 1 0
+	chk_prio_nr 1 1
 
 	# single address with port, backup
 	reset
@@ -1829,7 +1829,7 @@ backup_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 	chk_join_nr "single address with port, backup" 1 1 1
 	chk_add_nr 1 1
-	chk_prio_nr 1 0
+	chk_prio_nr 1 1
 }
 
 add_addr_ports_tests()
-- 
2.34.1

