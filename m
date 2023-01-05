Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5AA320B
	for <mptcp@lists.linux.dev>; Thu,  5 Jan 2023 21:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1672952443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tzR1wuYK3UmrwZ+hCZQA6kbAzh2uxHYFM70DAhZqBlU=;
	b=JOZ5aTRGg4niU5T7/GnLhMQIZFPkt5Q/8gmE8vT9taDF0yoN8HnHAGiOmQCKGJs9qb0OXb
	ePf3iQqvCwGq4I4UIQ6O8EiFRavcr0larmFrkMLseCKxDpAtM2ox0m9/ZRr+LEOmtn2aYm
	I9iG83Jd7WK/yZptJN1Br6cXkc4GWEE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-322-m1NqFu7-NRC5vNGZ3QNoNQ-1; Thu, 05 Jan 2023 16:00:41 -0500
X-MC-Unique: m1NqFu7-NRC5vNGZ3QNoNQ-1
Received: by mail-pg1-f199.google.com with SMTP id e184-20020a6369c1000000b0049de6cfcc40so9428827pgc.19
        for <mptcp@lists.linux.dev>; Thu, 05 Jan 2023 13:00:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzR1wuYK3UmrwZ+hCZQA6kbAzh2uxHYFM70DAhZqBlU=;
        b=krXCsH6Ffq+r7kBL87oTipT3TPTfPcuUi+GPOQ0DOYvmMZNSZxNJSWJsbVT2M2tmKC
         2DxcXtH/iRaydg7fjacn93Y1uCPdzfnY9SOoravQf/hEAGuro/F5DWOjVC9GLLO1Seed
         YnsRkzRByj8DW9Wr5f6XmR+i6gOL4VwHgZwWr4H5TCnXLXS/WEQnFSHxhqjZfV2sB3TS
         E07HwWnJx+Z2Ho+MD+qntcNkt+KxlaXU0M4v+A6VtZAS5IqE2j8VB+lifhQ5TFYLgi1f
         5WZt9t4xCc/d2vUNaVfrb7J50O9WYDuGKekdxREG+ivBJmH2apc+za5nH7dJPLH//GKD
         Vx7w==
X-Gm-Message-State: AFqh2koL3BR8sn5Va/N3D3O7pwbGDkDsOzlbdDQPu+UWpirGXPL1KfJj
	uzIouHHs7/pQ60nrd/kX6GgYmVk12NyjlltL15pk/6A5CWheHMVZ1afVdhae2DFcKKmfg9fgNYV
	s8CxbNURbMWCR1I0=
X-Received: by 2002:a17:902:f604:b0:192:55ab:88fe with SMTP id n4-20020a170902f60400b0019255ab88femr59519112plg.56.1672952440604;
        Thu, 05 Jan 2023 13:00:40 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsStt8vIjhcmCC1xPxFgNuYCD+E2HWcvG2z9NLpGXZEusMwS+11yc/i6oZSoLkZhcemO6CG4A==
X-Received: by 2002:a17:902:f604:b0:192:55ab:88fe with SMTP id n4-20020a170902f60400b0019255ab88femr59519092plg.56.1672952440362;
        Thu, 05 Jan 2023 13:00:40 -0800 (PST)
Received: from kernel-devel ([240d:1a:c0d:9f00:ca6:1aff:fead:cef4])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902cf0900b0018999a3dd7esm26316946plg.28.2023.01.05.13.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 13:00:39 -0800 (PST)
Date: Fri, 6 Jan 2023 06:00:35 +0900
From: Shigeru Yoshida <syoshida@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: matthieu.baerts@tessares.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dmytro@shytyi.net,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mptcp: Fix deadlock in mptcp_sendmsg()
Message-ID: <Y7c6c+5h25bEcn/A@kernel-devel>
References: <20230105201205.1087439-1-syoshida@redhat.com>
 <548fc9cf-b674-f37e-8ff7-9abae0bf15a8@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <548fc9cf-b674-f37e-8ff7-9abae0bf15a8@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 05, 2023 at 12:26:29PM -0800, Mat Martineau wrote:
> On Fri, 6 Jan 2023, Shigeru Yoshida wrote:
> 
> > __mptcp_close_ssk() can be called from mptcp_sendmsg() with subflow
> > socket locked.  This can cause a deadlock as below:
> > 
> > mptcp_sendmsg()
> >  mptcp_sendmsg_fastopen() --> lock ssk
> >    tcp_sendmsg_fastopen()
> >       __inet_stream_connect()
> >          mptcp_disconnect()
> >             mptcp_destroy_common()
> >                __mptcp_close_ssk() --> lock ssk again
> > 
> > This patch fixes the issue by skipping locking for subflow socket
> > which is already locked.
> > 
> 
> Hi Shigeru -
> 
> I believe this has already been fixed by:
> 
> 7d803344fdc3 ("mptcp: fix deadlock in fastopen error path")
> 
> It is in the net repo:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git

Hi Mat,

Thank you so much for your prompt response.  I've missed above patch.
Yes, the patch fixed the same issue.

Thank you~

Shigeru

> 
> ...but hasn't been merged to net-next or Linus' tree yet. Jakub said to
> expect a net PR today, which should get the fix both upstream and in to
> net-next.
> 
> Thanks,
> 
> Mat
> 
> > Fixes: d98a82a6afc7 ("mptcp: handle defer connect in mptcp_sendmsg")
> > Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> > ---
> > net/mptcp/protocol.c | 15 +++++++++------
> > net/mptcp/protocol.h |  4 ++--
> > 2 files changed, 11 insertions(+), 8 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index f6f93957275b..979265f66082 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1672,9 +1672,9 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msgh
> > 	lock_sock(ssk);
> > 	msg->msg_flags |= MSG_DONTWAIT;
> > 	msk->connect_flags = O_NONBLOCK;
> > -	msk->is_sendmsg = 1;
> > +	msk->sendmsg_locked_sk = ssk;
> > 	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
> > -	msk->is_sendmsg = 0;
> > +	msk->sendmsg_locked_sk = NULL;
> > 	msg->msg_flags = saved_flags;
> > 	release_sock(ssk);
> > 
> > @@ -2319,7 +2319,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> > 	if (dispose_it)
> > 		list_del(&subflow->node);
> > 
> > -	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
> > +	if (msk->sendmsg_locked_sk != ssk)
> > +		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
> > 
> > 	if (flags & MPTCP_CF_FASTCLOSE) {
> > 		/* be sure to force the tcp_disconnect() path,
> > @@ -2335,7 +2336,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> > 		tcp_disconnect(ssk, 0);
> > 		msk->subflow->state = SS_UNCONNECTED;
> > 		mptcp_subflow_ctx_reset(subflow);
> > -		release_sock(ssk);
> > +		if (msk->sendmsg_locked_sk != ssk)
> > +			release_sock(ssk);
> > 
> > 		goto out;
> > 	}
> > @@ -2362,7 +2364,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> > 		/* close acquired an extra ref */
> > 		__sock_put(ssk);
> > 	}
> > -	release_sock(ssk);
> > +	if (msk->sendmsg_locked_sk != ssk)
> > +		release_sock(ssk);
> > 
> > 	sock_put(ssk);
> > 
> > @@ -3532,7 +3535,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
> > 	/* if reaching here via the fastopen/sendmsg path, the caller already
> > 	 * acquired the subflow socket lock, too.
> > 	 */
> > -	if (msk->is_sendmsg)
> > +	if (msk->sendmsg_locked_sk)
> > 		err = __inet_stream_connect(ssock, uaddr, addr_len, msk->connect_flags, 1);
> > 	else
> > 		err = inet_stream_connect(ssock, uaddr, addr_len, msk->connect_flags);
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 955fb3d88eb3..43afc399e16b 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -294,8 +294,7 @@ struct mptcp_sock {
> > 	u8		mpc_endpoint_id;
> > 	u8		recvmsg_inq:1,
> > 			cork:1,
> > -			nodelay:1,
> > -			is_sendmsg:1;
> > +			nodelay:1;
> > 	int		connect_flags;
> > 	struct work_struct work;
> > 	struct sk_buff  *ooo_last_skb;
> > @@ -318,6 +317,7 @@ struct mptcp_sock {
> > 	u32 setsockopt_seq;
> > 	char		ca_name[TCP_CA_NAME_MAX];
> > 	struct mptcp_sock	*dl_next;
> > +	struct sock	*sendmsg_locked_sk;
> > };
> > 
> > #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
> > -- 
> > 2.39.0
> > 
> > 
> 
> --
> Mat Martineau
> Intel
> 

