Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D445636F
	for <mptcp@lists.linux.dev>; Thu, 13 Apr 2023 02:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681354636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5AzEg8Ao4jgsIZn9hnvRCP42sxSvRguawETbd/Q5Ewc=;
	b=YTAbzPnzlrZ7EONMW+HKpSZ5XKZdEimRsN+Hrc7KMji8U+ScXMtY1AAdUIvSt4ud5qQVgX
	LKie4WMBUoy7T7+sqzUbfKt1ttnE4W5LBXkAFruraASj434rUMaBZU9SVhddbuz+SRUhKY
	uWppyGw0DQBB7U7C42cnSe8f2y/BW1Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-WKjhx5-FNSSDYZ-s21GaHw-1; Wed, 12 Apr 2023 22:57:05 -0400
X-MC-Unique: WKjhx5-FNSSDYZ-s21GaHw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8493A185A78B;
	Thu, 13 Apr 2023 02:57:04 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A35AB40C83A9;
	Thu, 13 Apr 2023 02:56:54 +0000 (UTC)
Date: Thu, 13 Apr 2023 10:56:49 +0800
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
Message-ID: <ZDdvcSKLa6ZEAhRW@ovpn-8-18.pek2.redhat.com>
References: <20230406144330.1932798-1-leitao@debian.org>
 <20230406165705.3161734-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406165705.3161734-1-leitao@debian.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1

On Thu, Apr 06, 2023 at 09:57:05AM -0700, Breno Leitao wrote:
> Currently uring CMD operation relies on having large SQEs, but future
> operations might want to use normal SQE.
> 
> The io_uring_cmd currently only saves the payload (cmd) part of the SQE,
> but, for commands that use normal SQE size, it might be necessary to
> access the initial SQE fields outside of the payload/cmd block.  So,
> saves the whole SQE other than just the pdu.
> 
> This changes slighlty how the io_uring_cmd works, since the cmd
> structures and callbacks are not opaque to io_uring anymore. I.e, the
> callbacks can look at the SQE entries, not only, in the cmd structure.
> 
> The main advantage is that we don't need to create custom structures for
> simple commands.
> 
> Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---

...

> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index 2e4c483075d3..9648134ccae1 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -63,14 +63,15 @@ EXPORT_SYMBOL_GPL(io_uring_cmd_done);
>  int io_uring_cmd_prep_async(struct io_kiocb *req)
>  {
>  	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
> -	size_t cmd_size;
> +	size_t size = sizeof(struct io_uring_sqe);
>  
>  	BUILD_BUG_ON(uring_cmd_pdu_size(0) != 16);
>  	BUILD_BUG_ON(uring_cmd_pdu_size(1) != 80);
>  
> -	cmd_size = uring_cmd_pdu_size(req->ctx->flags & IORING_SETUP_SQE128);
> +	if (req->ctx->flags & IORING_SETUP_SQE128)
> +		size <<= 1;
>  
> -	memcpy(req->async_data, ioucmd->cmd, cmd_size);
> +	memcpy(req->async_data, ioucmd->sqe, size);

The copy will make some fields of sqe become READ TWICE, and driver may see
different sqe field value compared with the one observed in io_init_req().

Can this kind of inconsistency cause trouble to driver?

If it isn't one problem, this patch looks fine.

But I guess any access on cmd->sqe in driver may have to be careful for dealing
with potential post-sqe-update.

Thanks,
Ming

