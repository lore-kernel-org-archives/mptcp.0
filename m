Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612AE70
	for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 10:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1628762960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kw44xBNuJKYEqH7dlUQ7DAu83bnmBPKRZ9tYs9E6GRs=;
	b=gex+42XWLmyk5sSpsTVr+73WInAOGexLaXYyqQkmsLsq/bD9TvpQwVSOUieMepQysPZO4T
	1TceCINFHWXW+iFmB2NLy2mA7/4dNo0MKRmd9S/tX2z1GwPC2NkzzfxdkKyA5QQz6lW3iS
	X2ZJtRjWOOL/F2Ub24qXD/cuMTVLqFE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-mSjbqCH2NeG_uj9evgwkpA-1; Thu, 12 Aug 2021 06:09:17 -0400
X-MC-Unique: mSjbqCH2NeG_uj9evgwkpA-1
Received: by mail-wm1-f70.google.com with SMTP id c2-20020a7bc8420000b0290238db573ab7so3164614wml.5
        for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 03:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=kw44xBNuJKYEqH7dlUQ7DAu83bnmBPKRZ9tYs9E6GRs=;
        b=AbvlWeky3aaEtLkUoYK4OiQ7UXtE7mok4L2NPcjykztjLpDWShEF9XqpzjSWqYGgan
         m0fML9fqOMi51pzIkTECI4Oe7VqAJgSN97RTxwOpLMUMzKVBt/oi4puq88ba9aOlr0ip
         QuNxZGHGiMYOT28l1oEdANLj1YV5MWUs5Vg7rSw38AEBRlcMle5efxkc8JqCT/gIMvY8
         0shX1NKRvUFSfbjgnxfHiEPHAZP+pxkWNLusmwAs8E0087qqqkLrxCzaBuoZvQiqGVxP
         rRacqLtcplFn1Vj3lMXVZR3mK9/nalZKsA1trxrTJYUI3ptdSmltCU5gmPpuJXeGLf9e
         KH5A==
X-Gm-Message-State: AOAM533Fqqv9s8NLJkaDbi8YMkVPZM3UF/cAKj6lymz5HIL04vBuNMXB
	NuiRpmMSoJhEu7vehWXnuCUMuQVcq22+QO3LqRVDZzXLPo+GB6lGH292Q2dK30nLa+NpaLGNVvd
	7ybrUOsSyuIgMEg8=
X-Received: by 2002:a1c:2042:: with SMTP id g63mr12819927wmg.27.1628762956460;
        Thu, 12 Aug 2021 03:09:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFNalUFz14kvOXz+MDyLiO+Zbdnw51AQbRDT43iRAzM+YJVAXyZyQ3y3LnB5Id52BXE4vFIg==
X-Received: by 2002:a1c:2042:: with SMTP id g63mr12819902wmg.27.1628762956166;
        Thu, 12 Aug 2021 03:09:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-224-77.dyn.eolo.it. [146.241.224.77])
        by smtp.gmail.com with ESMTPSA id e25sm2910959wra.90.2021.08.12.03.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 03:09:15 -0700 (PDT)
Message-ID: <a43cce07d97b0e149be63ee1aaf0c4feeccb716a.camel@redhat.com>
Subject: Re: [MPTCP][PATCH mptcp-next] mptcp: free entry when release_work
 allocation fails
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Thu, 12 Aug 2021 12:09:15 +0200
In-Reply-To: <cba51616ec99f106c50dd7b0560450812adcd581.1628739395.git.geliangtang@xiaomi.com>
References: <cba51616ec99f106c50dd7b0560450812adcd581.1628739395.git.geliangtang@xiaomi.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2021-08-12 at 11:37 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> This patch fixed this syzkaller error:

Good catch!

>  BUG: memory leak
>  unreferenced object 0xffff88810680ea00 (size 64):
>    comm "syz-executor.6", pid 6191, jiffies 4295756280 (age 24.138s)
>    hex dump (first 32 bytes):
>      58 75 7d 3c 80 88 ff ff 22 01 00 00 00 00 ad de  Xu}<....".......
>      01 00 02 00 00 00 00 00 ac 1e 00 07 00 00 00 00  ................
>    backtrace:
>      [<0000000072a9f72a>] kmalloc include/linux/slab.h:591 [inline]
>      [<0000000072a9f72a>] mptcp_nl_cmd_add_addr+0x287/0x9f0 net/mptcp/pm_netlink.c:1170
>      [<00000000f6e931bf>] genl_family_rcv_msg_doit.isra.0+0x225/0x340 net/netlink/genetlink.c:731
>      [<00000000f1504a2c>] genl_family_rcv_msg net/netlink/genetlink.c:775 [inline]
>      [<00000000f1504a2c>] genl_rcv_msg+0x341/0x5b0 net/netlink/genetlink.c:792
>      [<0000000097e76f6a>] netlink_rcv_skb+0x148/0x430 net/netlink/af_netlink.c:2504
>      [<00000000ceefa2b8>] genl_rcv+0x24/0x40 net/netlink/genetlink.c:803
>      [<000000008ff91aec>] netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
>      [<000000008ff91aec>] netlink_unicast+0x537/0x750 net/netlink/af_netlink.c:1340
>      [<0000000041682c35>] netlink_sendmsg+0x846/0xd80 net/netlink/af_netlink.c:1929
>      [<00000000df3aa8e7>] sock_sendmsg_nosec net/socket.c:704 [inline]
>      [<00000000df3aa8e7>] sock_sendmsg+0x14e/0x190 net/socket.c:724
>      [<000000002154c54c>] ____sys_sendmsg+0x709/0x870 net/socket.c:2403
>      [<000000001aab01d7>] ___sys_sendmsg+0xff/0x170 net/socket.c:2457
>      [<00000000fa3b1446>] __sys_sendmsg+0xe5/0x1b0 net/socket.c:2486
>      [<00000000db2ee9c7>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>      [<00000000db2ee9c7>] do_syscall_64+0x38/0x90 arch/x86/entry/common.c:80
>      [<000000005873517d>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
>  BUG: leak checking failed
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/223
> Fixes: 1729cf186d8a5 (mptcp: create the listening socket for new port)
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
>  net/mptcp/pm_netlink.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 371607dc6ff7..184a75e1c8ec 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1324,6 +1324,8 @@ static void mptcp_pm_free_addr_entry(struct mptcp_pm_addr_entry *entry)
>  		INIT_RCU_WORK(&w->rwork, mptcp_pm_release_addr_entry);
>  		w->entry = entry;
>  		queue_rcu_work(system_wq, &w->rwork);
> +	} else {
> +		kfree(entry);
>  	}
>  }

We can't invoke kfree on pointer a pointer accesed with the RCU schema.

We also should not require an allocation to free a pointer. 

I can't recall why we did not include an rcu list entry
into mptcp_pm_addr_entry, likely to avoid making such pointer too big.

I think we can both fix the leak and avoid the extra allocation with
something alike the following. 

Only build-tested, could you please give it a spin? I can't reproduce
the leak locally ?!?
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
+static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry
*entry)
 {
-	struct addr_entry_release_work *w;
-	struct mptcp_pm_addr_entry *entry;
-
-	w = container_of(to_rcu_work(work), struct
addr_entry_release_work, rwork);
-	entry = w->entry;
-	if (entry) {
-		if (entry->lsk)
-			sock_release(entry->lsk);
-		kfree(entry);
-	}
-	kfree(w);
-}
-
-static void mptcp_pm_free_addr_entry(struct mptcp_pm_addr_entry
*entry)
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
@@ -1404,7 +1385,8 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff
*skb, struct genl_info *info)
 	spin_unlock_bh(&pernet->lock);
 
 	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk),
&entry->addr);
-	mptcp_pm_free_addr_entry(entry);
+	synchronize_rcu();
+	__mptcp_pm_release_addr_entry(entry);
 
 	return ret;
 }
@@ -1457,6 +1439,7 @@ static void mptcp_nl_remove_addrs_list(struct net
*net,
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
 
@@ -1489,6 +1472,7 @@ static int mptcp_nl_cmd_flush_addrs(struct
sk_buff *skb, struct genl_info *info)
 	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
 	spin_unlock_bh(&pernet->lock);
 	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
+	synchronize_rcu();
 	__flush_addrs(&free_list);
 	return 0;
 }
@@ -2100,7 +2084,8 @@ static void __net_exit pm_nl_exit_net(struct
list_head *net_list)
 		struct pm_nl_pernet *pernet = net_generic(net,
pm_nl_pernet_id);
 
 		/* net is removed from namespace list, can't race with
-		 * other modifiers
+		 * other modifiers, also netns core already waited for
a
+		 * RCU grace period.
 		 */
 		__flush_addrs(&pernet->local_addr_list);
 	}


