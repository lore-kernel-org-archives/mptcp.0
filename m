Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8266C2C80
	for <mptcp@lists.linux.dev>; Thu,  6 Jan 2022 09:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1641460635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whjniXP9lGyR9WGkpQQgpOXKhvtwhrHKe16XPS6Kx+c=;
	b=EKIM7GGV13+0n3VJxtWWvpcPBiDBMZqy93Umo8s6O53Wrgl02EVehjEhH0AkohJVRdLdIJ
	Dp4IR/G5GjQLhfaxZ1CgU15jLw7IFN/IG1cfEN+AUjAUIrBCckx7E4b85S/09GcfKswQey
	nNGL7F5Vkp7POkav9LhI6MK1Ed8VIwk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-BWJv8Kg_PwW1ouRCqUMTmQ-1; Thu, 06 Jan 2022 04:17:12 -0500
X-MC-Unique: BWJv8Kg_PwW1ouRCqUMTmQ-1
Received: by mail-wm1-f71.google.com with SMTP id 7-20020a1c1907000000b003471d9bbe8dso127615wmz.0
        for <mptcp@lists.linux.dev>; Thu, 06 Jan 2022 01:17:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=whjniXP9lGyR9WGkpQQgpOXKhvtwhrHKe16XPS6Kx+c=;
        b=6pKpypCe9hm5k144NXJAo941JOHme1xkBPnRn0ART/Edkd4HXbxJHr5VYgv/XcQvYB
         DZatxopEIrdV8jUvsYI89S8e/yo2mAGGJxdMKDE84y3uMCQdClEYEx3LKJ1Yr3XKGyuN
         jfcJFb2WrfVzqfaxQKZ1IebqNluzO9JH5diNRr1DZFXrCxGTLRpYTSp091kptYvFpfrr
         FqnYcxfZMS50WxcgzDxZZyrWv9/sPyeU4W1p2YL78uhXuTdNS3EjAbUiRYAo+5/5dSe+
         /+Rrfs/A+mntMmZ7fiic9ctO0ucmn4tx0mBVhf0KMR6iBEU4Nm7WPktBT6mzxw822oe5
         PfMw==
X-Gm-Message-State: AOAM531emQ7TILisN5OleXa1E1TxoPfgKP2WjVRR5kM+guf8dLSKggVs
	GNGi3yC1wNkqMETvC+E8qStATvBTFbve9Bss+GsnslNwvJEk2pXZ++N1k93YI0pKammKNiggzpN
	b7MqYMli0l2kne8o=
X-Received: by 2002:a05:6000:91:: with SMTP id m17mr49471541wrx.250.1641460631707;
        Thu, 06 Jan 2022 01:17:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnuLrV4VHO8/qxNQJV1YN7JrHcnCIBjvqUKTLn9lYuXOqxqer9j11WuUmpR/eD/rEjpGzWZQ==
X-Received: by 2002:a05:6000:91:: with SMTP id m17mr49471521wrx.250.1641460631449;
        Thu, 06 Jan 2022 01:17:11 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-184.dyn.eolo.it. [146.241.97.184])
        by smtp.gmail.com with ESMTPSA id n12sm1250874wmq.30.2022.01.06.01.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 01:17:11 -0800 (PST)
Message-ID: <da864381a8c89a2166d1704c39908de71094ba34.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v2] mptcp: Check reclaim amount before
 reducing allocation
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Cc: syzbot+bc9e2d2dbcb347dd215a@syzkaller.appspotmail.com
Date: Thu, 06 Jan 2022 10:17:10 +0100
In-Reply-To: <20220106012928.158899-1-mathew.j.martineau@linux.intel.com>
References: <20220106012928.158899-1-mathew.j.martineau@linux.intel.com>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
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

On Wed, 2022-01-05 at 17:29 -0800, Mat Martineau wrote:
> syzbot found a page counter underflow that was triggered by MPTCP's
> reclaim code:
> 
> page_counter underflow: -4294964789 nr_pages=4294967295
> WARNING: CPU: 2 PID: 3785 at mm/page_counter.c:56 page_counter_cancel+0xcf/0xe0 mm/page_counter.c:56
> Modules linked in:
> CPU: 2 PID: 3785 Comm: kworker/2:6 Not tainted 5.16.0-rc1-syzkaller #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> Workqueue: events mptcp_worker
> 
> RIP: 0010:page_counter_cancel+0xcf/0xe0 mm/page_counter.c:56
> Code: c7 04 24 00 00 00 00 45 31 f6 eb 97 e8 2a 2b b5 ff 4c 89 ea 48 89 ee 48 c7 c7 00 9e b8 89 c6 05 a0 c1 ba 0b 01 e8 95 e4 4b 07 <0f> 0b eb a8 4c 89 e7 e8 25 5a fb ff eb c7 0f 1f 00 41 56 41 55 49
> RSP: 0018:ffffc90002d4f918 EFLAGS: 00010082
> 
> RAX: 0000000000000000 RBX: ffff88806a494120 RCX: 0000000000000000
> RDX: ffff8880688c41c0 RSI: ffffffff815e8f28 RDI: fffff520005a9f15
> RBP: ffffffff000009cb R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffff815e2cfe R11: 0000000000000000 R12: ffff88806a494120
> R13: 00000000ffffffff R14: 0000000000000000 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2de21000 CR3: 000000005ad59000 CR4: 0000000000150ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  page_counter_uncharge+0x2e/0x60 mm/page_counter.c:160
>  drain_stock+0xc1/0x180 mm/memcontrol.c:2219
>  refill_stock+0x139/0x2f0 mm/memcontrol.c:2271
>  __sk_mem_reduce_allocated+0x24d/0x550 net/core/sock.c:2945
>  __mptcp_rmem_reclaim net/mptcp/protocol.c:167 [inline]
>  __mptcp_mem_reclaim_partial+0x124/0x410 net/mptcp/protocol.c:975
>  mptcp_mem_reclaim_partial net/mptcp/protocol.c:982 [inline]
>  mptcp_alloc_tx_skb net/mptcp/protocol.c:1212 [inline]
>  mptcp_sendmsg_frag+0x18c6/0x2190 net/mptcp/protocol.c:1279
>  __mptcp_push_pending+0x232/0x720 net/mptcp/protocol.c:1545
>  mptcp_release_cb+0xfe/0x200 net/mptcp/protocol.c:2975
>  release_sock+0xb4/0x1b0 net/core/sock.c:3306
>  mptcp_worker+0x51e/0xc10 net/mptcp/protocol.c:2443
>  process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
>  worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
>  kthread+0x405/0x4f0 kernel/kthread.c:327
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
>  </TASK>
> 
> __mptcp_mem_reclaim_partial() could call __mptcp_rmem_reclaim() with a
> negative value, which passed that negative value to
> __sk_mem_reduce_allocated() and triggered the splat above.
> 
> Check for a reclaim amount that is positive and large enough for
> __mptcp_rmem_reclaim() to actually adjust rmem_fwd_alloc (much like
> the sk_mem_reclaim_partial() code the function is based on).
> 
> v2: Use '>' instead of '>=', since SK_MEM_QUANTUM - 1 would get
> right-shifted into nothing by __mptcp_rmem_reclaim.
> 
> Fixes: 6511882cdd82 ("mptcp: allocate fwd memory separately on the rx and tx path")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/252
> Cc: pabeni@redhat.com
> Reported-and-tested-by: syzbot+bc9e2d2dbcb347dd215a@syzkaller.appspotmail.com
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
>  net/mptcp/protocol.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index fccfa65517da..5d6be1dce5d6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -967,7 +967,9 @@ static void __mptcp_mem_reclaim_partial(struct sock *sk)
>  
>  	lockdep_assert_held_once(&sk->sk_lock.slock);
>  
> -	__mptcp_rmem_reclaim(sk, reclaimable - 1);
> +	if (reclaimable > SK_MEM_QUANTUM)
> +		__mptcp_rmem_reclaim(sk, reclaimable - 1);
> +
>  	sk_mem_reclaim_partial(sk);
>  }
>  
> 
> base-commit: 9478f9d57df23cfa5caa4317e75a6efe6e782ab3


LGTM, thanks!

Acked-by: Paolo Abeni <pabeni@redhat.com>

I'm sorry, I'll be almost unreachable for a few more days.

/P

