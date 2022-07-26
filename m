Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DED2579
	for <mptcp@lists.linux.dev>; Tue, 26 Jul 2022 14:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1658845031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yiMhEp8997FaPwrUdOYzpdDaIjcsbwBCQURU6GKmHeU=;
	b=gS9OOTinUX76R+kA2qHZ4SXX9KfqH5Jez4d5NS/Xos0HdQpYzFtuNwacayCPTuWuDY5wCk
	R8r0TFSYgCx10DFbkJuhCLsBsutayaK3g4o0t17en0YKz9mSEv8BxKs9BS64HST5QkXc8i
	c6uAuc5Rb3d2mMWnhwxmBiX1VzZbMyg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-1onTw3EiMKeZ3DmTrFaNOg-1; Tue, 26 Jul 2022 10:17:10 -0400
X-MC-Unique: 1onTw3EiMKeZ3DmTrFaNOg-1
Received: by mail-wm1-f69.google.com with SMTP id i184-20020a1c3bc1000000b003a026f48333so7722254wma.4
        for <mptcp@lists.linux.dev>; Tue, 26 Jul 2022 07:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=yiMhEp8997FaPwrUdOYzpdDaIjcsbwBCQURU6GKmHeU=;
        b=i2vbkqJZ5GOEbdNJltg+tbrNu7P01XVXoOH6tWeM7Ii8Nf+GCqlTsZ17CotzyFgn4b
         xT7N8Js72PJ2Df4aHtFC0sjiTTz0bM4M1pXTJ7zE3tL2JOzTiffsBr5miYUFHPQbuI4D
         dLNbZnaePt0gn4gPlDlPBPregJAvsKOuta9VEloivxGs3hCo70auW54bVbNIP2osRZFN
         /BunmzcFi+uBEiZ1fKB+QK3p6lP5IGMcumjMlSm6nmkaOaYizxNsOJrqA/pPsao1Dsaa
         uTmm1sx0iPyy7pagZrF4+WXtDx0tGEI4rBK2h87WIIirSU7yrvdNEav7p5OP+tjdtn12
         aMPg==
X-Gm-Message-State: AJIora9qKhbSigy1SKqh621LZvhVQ0lAvHWDRf2ruJMGS1EreNNQ5Cs8
	kVesVgfVTuE0oLpw5WFFsw2X+9uv5BM4F5Gd7qRbI7d2J1Nn3ER3sucXBZUgPqRtksNAGsqeaaK
	5PrRckU7bd5PG9xA=
X-Received: by 2002:a05:600c:254f:b0:3a3:2848:caeb with SMTP id e15-20020a05600c254f00b003a32848caebmr25088762wma.187.1658845028699;
        Tue, 26 Jul 2022 07:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tw6xC3yfahDctVA5OmmGnHE86Qb3J+akvTbqwuAQbaWOzAnz0XQ6TweMinYjAZ9yOQydbDjg==
X-Received: by 2002:a05:600c:254f:b0:3a3:2848:caeb with SMTP id e15-20020a05600c254f00b003a32848caebmr25088736wma.187.1658845028305;
        Tue, 26 Jul 2022 07:17:08 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-164.dyn.eolo.it. [146.241.104.164])
        by smtp.gmail.com with ESMTPSA id f18-20020a7bc8d2000000b003a327b98c0asm17526451wml.22.2022.07.26.07.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 07:17:07 -0700 (PDT)
Message-ID: <8f1c3c67c6a1c9614eb459fb3799c7305bfc807b.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: do not queue data on closed subflows
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, Dipanjan Das <mail.dipanjan.das@gmail.com>
Date: Tue, 26 Jul 2022 16:17:05 +0200
In-Reply-To: <595ba8d4-5ba2-666-b336-e48977d8864e@linux.intel.com>
References: <937464128633daa18ebc093215ac04487f001b3f.1658769042.git.pabeni@redhat.com>
	 <595ba8d4-5ba2-666-b336-e48977d8864e@linux.intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
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

On Mon, 2022-07-25 at 18:14 -0700, Mat Martineau wrote:
> On Mon, 25 Jul 2022, Paolo Abeni wrote:
> 
> > Dipanjan reported a syzbot splat at close time:
> > 
> > WARNING: CPU: 1 PID: 10818 at net/ipv4/af_inet.c:153
> > inet_sock_destruct+0x6d0/0x8e0 net/ipv4/af_inet.c:153
> > Modules linked in: uio_ivshmem(OE) uio(E)
> > CPU: 1 PID: 10818 Comm: kworker/1:16 Tainted: G           OE
> > 5.19.0-rc6-g2eae0556bb9d #2
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > 1.13.0-1ubuntu1.1 04/01/2014
> > Workqueue: events mptcp_worker
> > RIP: 0010:inet_sock_destruct+0x6d0/0x8e0 net/ipv4/af_inet.c:153
> > Code: 21 02 00 00 41 8b 9c 24 28 02 00 00 e9 07 ff ff ff e8 34 4d 91
> > f9 89 ee 4c 89 e7 e8 4a 47 60 ff e9 a6 fc ff ff e8 20 4d 91 f9 <0f> 0b
> > e9 84 fe ff ff e8 14 4d 91 f9 0f 0b e9 d4 fd ff ff e8 08 4d
> > RSP: 0018:ffffc9001b35fa78 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: 00000000002879d0 RCX: ffff8881326f3b00
> > RDX: 0000000000000000 RSI: ffff8881326f3b00 RDI: 0000000000000002
> > RBP: ffff888179662674 R08: ffffffff87e983a0 R09: 0000000000000000
> > R10: 0000000000000005 R11: 00000000000004ea R12: ffff888179662400
> > R13: ffff888179662428 R14: 0000000000000001 R15: ffff88817e38e258
> > FS:  0000000000000000(0000) GS:ffff8881f5f00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020007bc0 CR3: 0000000179592000 CR4: 0000000000150ee0
> > Call Trace:
> > <TASK>
> > __sk_destruct+0x4f/0x8e0 net/core/sock.c:2067
> > sk_destruct+0xbd/0xe0 net/core/sock.c:2112
> > __sk_free+0xef/0x3d0 net/core/sock.c:2123
> > sk_free+0x78/0xa0 net/core/sock.c:2134
> > sock_put include/net/sock.h:1927 [inline]
> > __mptcp_close_ssk+0x50f/0x780 net/mptcp/protocol.c:2351
> > __mptcp_destroy_sock+0x332/0x760 net/mptcp/protocol.c:2828
> > mptcp_worker+0x5d2/0xc90 net/mptcp/protocol.c:2586
> > process_one_work+0x9cc/0x1650 kernel/workqueue.c:2289
> > worker_thread+0x623/0x1070 kernel/workqueue.c:2436
> > kthread+0x2e9/0x3a0 kernel/kthread.c:376
> > ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
> > </TASK>
> > 
> > The root cause of the problem is that an mptcp-level (re)transmit can
> > race with mptcp_close() and the packet scheduler checks the subflow
> > state before acquiring the socket lock: we can try to (re)transmit on
> > an already closed ssk.
> > 
> > Fix the issue checking again the subflow socket status under the
> > subflow socket lock protection. Additionally add the missing check
> > for the fallback-to-tcp case.
> > 
> > Reported-by: Dipanjan Das <mail.dipanjan.das@gmail.com>
> > Fixes: d5f49190def6 ("mptcp: allow picking different xmit subflows")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> Thanks Paolo.
> 
> Patchew didn't tag this for some reason, so I manually pushed a tag to 
> trigger the CI builds:
> 
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2736071165
> https://cirrus-ci.com/build/5132666281394176
> 
> 
> The tests I ran worked ok, but the c reproducer didn't trigger the crash 
> in my syzkaller vm with v5.19-rc6.

I could reproduce the issue using the config attached to the report
(CONFIG_PREEMPT=y). I think the issue is possible even without that,
but with a much smaller window of opportunity.


> One question below.
> 
> > ---
> > net/mptcp/protocol.c |  8 +++++++-
> > net/mptcp/protocol.h | 11 +++++++----
> > 2 files changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index cc21fafd9726..7c7670942e76 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1275,6 +1275,9 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> > 			 info->limit > dfrag->data_len))
> > 		return 0;
> > 
> > +	if (unlikely(!__tcp_can_send(ssk)))
> > +		return -EAGAIN;
> > +
> > 	/* compute send limit */
> > 	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
> > 	copy = info->size_goal;
> > @@ -1448,7 +1451,8 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> > 	if (__mptcp_check_fallback(msk)) {
> > 		if (!msk->first)
> > 			return NULL;
> > -		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
> > +		return __tcp_can_send(msk->first) &&
> > +		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
> > 	}
> > 
> > 	/* re-use last subflow, if the burst allow that */
> > @@ -1599,6 +1603,8 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> > 
> > 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
> > 			if (ret <= 0) {
> > +				if (ret == -EAGAIN)
> > +					continue;
> 
> There are two other mptcp_sendmsg_frag() callers: 
> __mptcp_subflow_push_pending() and __mptcp_retrans(). The code for those 
> has not changed to check for -EAGAIN like the line of code above, and it 
> looks like such changes are not needed. Does my reasoning for these two 
> other cases match yours:
> 
> __mptcp_subflow_push_pending() has the subflow lock held when it calls 
> mptcp_subflow_get_send(), so it shouldn't run in to the problem you 
> described in the commit message.


when mptcp_subflow_get_send is called, the lock held, if any refers to
the "previous" ssk. AFAICS the race could happen even there. The
"lifesaver" check is inside mptcp_sendmsg_frag(), so it protects both
caller. 

The main point is that when __mptcp_subflow_push_pending() we pick a
racing to close subflow, we still need to try to select another
subflow, or we could end-up not pushing any data even the mptcp-level
window allow for that, and the actual data transfer could be delayed (a
lot of time) for no reasons.

__mptcp_retrans() is less critical, because it's a slower path, we are
not 100% we have really to send any data (could be just high jitter),
and the retrans function will be called later no matter what.

Please let me know if the above answer your question,
thanks!

Paolo

