Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529DB173
	for <mptcp@lists.linux.dev>; Fri, 13 Aug 2021 14:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1628863561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UPYznkH5TxdCv8GScDe2PiWfKmy0ZdUUChqXDGwLsu0=;
	b=P6NCo0/g5p5/G5Mq5Wc7vJuzZ8Kovx5dpNcueyxf/Iwjb8GKiZI4giCx2vRNFrqweZkKiW
	0wAQMOB6K/eOgQTvvfyOHzQb07ilCgN8Y7oBauNVfm3tgJUm9yNVClILAPxib1fqvDqM7R
	ATtySjIf2DaApna/Yg5iOofgRIVSOKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-ekli2kbjNUOikRgVRHnfVg-1; Fri, 13 Aug 2021 10:05:59 -0400
X-MC-Unique: ekli2kbjNUOikRgVRHnfVg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EDE7344E4;
	Fri, 13 Aug 2021 14:05:59 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.186])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4DF7060E3A;
	Fri, 13 Aug 2021 14:05:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-net v2] mptcp: fix memory leak on address flush
Date: Fri, 13 Aug 2021 16:05:52 +0200
Message-Id: <b73d65b78787ba0ecc36ec2d5d6fc2a68415d938.1628863533.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
v1 -> v2:
 - remove unused addr_entry_release_work definition, too - Mat
---
 net/mptcp/pm_netlink.c | 44 ++++++++++++------------------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 371607dc6ff7..1e4289c507ff 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1295,36 +1295,12 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 	return 0;
 }
 
-struct addr_entry_release_work {
-	struct rcu_work	rwork;
-	struct mptcp_pm_addr_entry *entry;
-};
-
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
@@ -1404,7 +1380,8 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	spin_unlock_bh(&pernet->lock);
 
 	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), &entry->addr);
-	mptcp_pm_free_addr_entry(entry);
+	synchronize_rcu();
+	__mptcp_pm_release_addr_entry(entry);
 
 	return ret;
 }
@@ -1457,6 +1434,7 @@ static void mptcp_nl_remove_addrs_list(struct net *net,
 	}
 }
 
+/* caller must ensure the RCU grace period is already elapsed */
 static void __flush_addrs(struct list_head *list)
 {
 	while (!list_empty(list)) {
@@ -1465,7 +1443,7 @@ static void __flush_addrs(struct list_head *list)
 		cur = list_entry(list->next,
 				 struct mptcp_pm_addr_entry, list);
 		list_del_rcu(&cur->list);
-		mptcp_pm_free_addr_entry(cur);
+		__mptcp_pm_release_addr_entry(cur);
 	}
 }
 
@@ -1489,6 +1467,7 @@ static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb, struct genl_info *info)
 	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
 	spin_unlock_bh(&pernet->lock);
 	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
+	synchronize_rcu();
 	__flush_addrs(&free_list);
 	return 0;
 }
@@ -2100,7 +2079,8 @@ static void __net_exit pm_nl_exit_net(struct list_head *net_list)
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

