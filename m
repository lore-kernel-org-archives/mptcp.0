Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A872A168
	for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 16:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1628786254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2e37t0DZjhZIpa7DdhNVqHLU3Zx/kPflYdZU8w6KOWI=;
	b=hDASNt7a3qLzrvRc39kop7SXf3VCB0iFoNMYZ6JVXxKvB6N/nB5ZDyvzfZ2+2Wgij+bMgm
	Jc30iTxK9POIs0gn1peQpQUOk3+GhMGFRCRNsm5zUQ26qCHMcUncFKgPsusYcGAZdkDNWT
	lR6CBEztjpsyciUMQNZXtjaaxLQojzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-i7L0ZSIcNm-Gq4_kcheaaA-1; Thu, 12 Aug 2021 12:37:33 -0400
X-MC-Unique: i7L0ZSIcNm-Gq4_kcheaaA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 283C9884E47;
	Thu, 12 Aug 2021 16:37:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.179])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CBE306F578;
	Thu, 12 Aug 2021 16:37:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-net] mptcp: fix memory leak on address flush
Date: Thu, 12 Aug 2021 18:37:18 +0200
Message-Id: <45e2a42be5357636c8c3ab3f72499b0e060d36d5.1628786192.git.pabeni@redhat.com>
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

The endpoint cleanup path is prone to a memory leak, as reported
by syzkaller:

 BUG: memory leak
 unreferenced object 0xffff88810680ea00 (size 64):
   comm "syz-executor.6", pid 6191, jiffies 4295756280 (age 24.138s)
   hex dump (first 32 bytes):
     58 75 7d 3c 80 88 ff ff 22 01 00 00 00 00 ad de  Xu}<....".......
     01 00 02 00 00 00 00 00 ac 1e 00 07 00 00 00 00  ................
   backtrace:
     [<0000000072a9f72a>] kmalloc include/linux/slab.h:591 [inline]
     [<0000000072a9f72a>] mptcp_nl_cmd_add_addr+0x287/0x9f0 net/mptcp/pm_netlink.c:1170
     [<00000000f6e931bf>] genl_family_rcv_msg_doit.isra.0+0x225/0x340 net/netlink/genetlink.c:731
     [<00000000f1504a2c>] genl_family_rcv_msg net/netlink/genetlink.c:775 [inline]
     [<00000000f1504a2c>] genl_rcv_msg+0x341/0x5b0 net/netlink/genetlink.c:792
     [<0000000097e76f6a>] netlink_rcv_skb+0x148/0x430 net/netlink/af_netlink.c:2504
     [<00000000ceefa2b8>] genl_rcv+0x24/0x40 net/netlink/genetlink.c:803
     [<000000008ff91aec>] netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
     [<000000008ff91aec>] netlink_unicast+0x537/0x750 net/netlink/af_netlink.c:1340
     [<0000000041682c35>] netlink_sendmsg+0x846/0xd80 net/netlink/af_netlink.c:1929
     [<00000000df3aa8e7>] sock_sendmsg_nosec net/socket.c:704 [inline]
     [<00000000df3aa8e7>] sock_sendmsg+0x14e/0x190 net/socket.c:724
     [<000000002154c54c>] ____sys_sendmsg+0x709/0x870 net/socket.c:2403
     [<000000001aab01d7>] ___sys_sendmsg+0xff/0x170 net/socket.c:2457
     [<00000000fa3b1446>] __sys_sendmsg+0xe5/0x1b0 net/socket.c:2486
     [<00000000db2ee9c7>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
     [<00000000db2ee9c7>] do_syscall_64+0x38/0x90 arch/x86/entry/common.c:80
     [<000000005873517d>] entry_SYSCALL_64_after_hwframe+0x44/0xae

We should not require an allocation to cleanup stuff.

Rework the code a bit so that the additional RCU work is no more needed.

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c | 39 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 371607dc6ff7..116009376ed7 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1300,31 +1300,12 @@ struct addr_entry_release_work {
 	struct mptcp_pm_addr_entry *entry;
 };
 
-static void mptcp_pm_release_addr_entry(struct work_struct *work)
+/* caller must ensure the RCU grace period is already elapsed */
+static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 {
-	struct addr_entry_release_work *w;
-	struct mptcp_pm_addr_entry *entry;
-
-	w = container_of(to_rcu_work(work), struct addr_entry_release_work, rwork);
-	entry = w->entry;
-	if (entry) {
-		if (entry->lsk)
-			sock_release(entry->lsk);
-		kfree(entry);
-	}
-	kfree(w);
-}
-
-static void mptcp_pm_free_addr_entry(struct mptcp_pm_addr_entry *entry)
-{
-	struct addr_entry_release_work *w;
-
-	w = kmalloc(sizeof(*w), GFP_ATOMIC);
-	if (w) {
-		INIT_RCU_WORK(&w->rwork, mptcp_pm_release_addr_entry);
-		w->entry = entry;
-		queue_rcu_work(system_wq, &w->rwork);
-	}
+	if (entry->lsk)
+		sock_release(entry->lsk);
+	kfree(entry);
 }
 
 static int mptcp_nl_remove_id_zero_address(struct net *net,
@@ -1404,7 +1385,8 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	spin_unlock_bh(&pernet->lock);
 
 	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), &entry->addr);
-	mptcp_pm_free_addr_entry(entry);
+	synchronize_rcu();
+	__mptcp_pm_release_addr_entry(entry);
 
 	return ret;
 }
@@ -1457,6 +1439,7 @@ static void mptcp_nl_remove_addrs_list(struct net *net,
 	}
 }
 
+/* caller must ensure the RCU grace period is already elapsed */
 static void __flush_addrs(struct list_head *list)
 {
 	while (!list_empty(list)) {
@@ -1465,7 +1448,7 @@ static void __flush_addrs(struct list_head *list)
 		cur = list_entry(list->next,
 				 struct mptcp_pm_addr_entry, list);
 		list_del_rcu(&cur->list);
-		mptcp_pm_free_addr_entry(cur);
+		__mptcp_pm_release_addr_entry(cur);
 	}
 }
 
@@ -1489,6 +1472,7 @@ static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb, struct genl_info *info)
 	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
 	spin_unlock_bh(&pernet->lock);
 	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
+	synchronize_rcu();
 	__flush_addrs(&free_list);
 	return 0;
 }
@@ -2100,7 +2084,8 @@ static void __net_exit pm_nl_exit_net(struct list_head *net_list)
 		struct pm_nl_pernet *pernet = net_generic(net, pm_nl_pernet_id);
 
 		/* net is removed from namespace list, can't race with
-		 * other modifiers
+		 * other modifiers, also netns core already waited for a
+		 * RCU grace period.
 		 */
 		__flush_addrs(&pernet->local_addr_list);
 	}
-- 
2.26.3

