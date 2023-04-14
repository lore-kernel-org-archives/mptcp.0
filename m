Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB48620
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 02:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681438395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xU5po7bo+0f7mtpnyY2arS5aqu7vRvq3JKh8xv5QFh4=;
	b=eWElPULZVnf/qz9IFt8FTiHU9+UWRyyH7/RNerp9v+DoHDz8Gpb90Q4sNZr8B9WVpZHGOn
	Bzh2rgB2hIfIgkK2HatbEgWZYs+W10qA5B54neblzN/zR+FpDnSVC0eNSqfjoypdwN79lB
	9ZRyr5a7iieJu0K6xHBqQg/l4cXPd/Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-VKX7xa-EOl-aq5sktc-3bA-1; Thu, 13 Apr 2023 22:13:10 -0400
X-MC-Unique: VKX7xa-EOl-aq5sktc-3bA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 814258996F5;
	Fri, 14 Apr 2023 02:13:09 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F1F9214171B6;
	Fri, 14 Apr 2023 02:12:58 +0000 (UTC)
Date: Fri, 14 Apr 2023 10:12:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: asml.silence@gmail.com, axboe@kernel.dk, davem@davemloft.net,
	dccp@vger.kernel.org, dsahern@kernel.org, edumazet@google.com,
	io-uring@vger.kernel.org, kuba@kernel.org, leit@fb.com,
	linux-kernel@vger.kernel.org, marcelo.leitner@gmail.com,
	matthieu.baerts@tessares.net, mptcp@lists.linux.dev,
	netdev@vger.kernel.org, pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com, ming.lei@redhat.com
Subject: Re: [PATCH RFC] io_uring: Pass whole sqe to commands
Message-ID: <ZDi2pP4jgHwCvJRm@ovpn-8-21.pek2.redhat.com>
References: <20230406144330.1932798-1-leitao@debian.org>
 <20230406165705.3161734-1-leitao@debian.org>
 <ZDdvcSKLa6ZEAhRW@ovpn-8-18.pek2.redhat.com>
 <ZDgyPL6UrX/MaBR4@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDgyPL6UrX/MaBR4@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7

On Thu, Apr 13, 2023 at 09:47:56AM -0700, Breno Leitao wrote:
> Hello Ming,
> 
> On Thu, Apr 13, 2023 at 10:56:49AM +0800, Ming Lei wrote:
> > On Thu, Apr 06, 2023 at 09:57:05AM -0700, Breno Leitao wrote:
> > > Currently uring CMD operation relies on having large SQEs, but future
> > > operations might want to use normal SQE.
> > > 
> > > The io_uring_cmd currently only saves the payload (cmd) part of the SQE,
> > > but, for commands that use normal SQE size, it might be necessary to
> > > access the initial SQE fields outside of the payload/cmd block.  So,
> > > saves the whole SQE other than just the pdu.
> > > 
> > > This changes slighlty how the io_uring_cmd works, since the cmd
> > > structures and callbacks are not opaque to io_uring anymore. I.e, the
> > > callbacks can look at the SQE entries, not only, in the cmd structure.
> > > 
> > > The main advantage is that we don't need to create custom structures for
> > > simple commands.
> > > 
> > > Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > ---
> > 
> > ...
> > 
> > > diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> > > index 2e4c483075d3..9648134ccae1 100644
> > > --- a/io_uring/uring_cmd.c
> > > +++ b/io_uring/uring_cmd.c
> > > @@ -63,14 +63,15 @@ EXPORT_SYMBOL_GPL(io_uring_cmd_done);
> > >  int io_uring_cmd_prep_async(struct io_kiocb *req)
> > >  {
> > >  	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
> > > -	size_t cmd_size;
> > > +	size_t size = sizeof(struct io_uring_sqe);
> > >  
> > >  	BUILD_BUG_ON(uring_cmd_pdu_size(0) != 16);
> > >  	BUILD_BUG_ON(uring_cmd_pdu_size(1) != 80);
> > >  
> > > -	cmd_size = uring_cmd_pdu_size(req->ctx->flags & IORING_SETUP_SQE128);
> > > +	if (req->ctx->flags & IORING_SETUP_SQE128)
> > > +		size <<= 1;
> > >  
> > > -	memcpy(req->async_data, ioucmd->cmd, cmd_size);
> > > +	memcpy(req->async_data, ioucmd->sqe, size);
> > 
> > The copy will make some fields of sqe become READ TWICE, and driver may see
> > different sqe field value compared with the one observed in io_init_req().
> 
> This copy only happens if the operation goes to the async path
> (calling io_uring_cmd_prep_async()).  This only happens if
> f_op->uring_cmd() returns -EAGAIN.
> 
>           ret = file->f_op->uring_cmd(ioucmd, issue_flags);
>           if (ret == -EAGAIN) {
>                   if (!req_has_async_data(req)) {
>                           if (io_alloc_async_data(req))
>                                   return -ENOMEM;
>                           io_uring_cmd_prep_async(req);
>                   }
>                   return -EAGAIN;
>           }
> 
> Are you saying that after this copy, the operation is still reading from
> sqe instead of req->async_data?

I meant that the 2nd read is on the sqe copy(req->aync_data), but same
fields can become different between the two READs(first is done on original
SQE during io_init_req(), and second is done on sqe copy in driver).

Will this kind of inconsistency cause trouble for driver? Cause READ
TWICE becomes possible with this patch.

> 
> If you have an example of the two copes flow, that would be great.

Not any example yet, but also not see any access on cmd->sqe(except for cmd_op)
in your patches too.


Thanks,
Ming

