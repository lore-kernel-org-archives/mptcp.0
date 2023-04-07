Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B741FEBB
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 18:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42481C433EF;
	Fri,  7 Apr 2023 18:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680893508;
	bh=5YjxGm12gelTf8QcSjIiWnSgzT8fwGgHvG2QpLB2WSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQ1qbGd1qnLQd3QWnzmv3ZAI2tK1ZYUf6Y8fZvGt9y7PG/+mhwHNZ0ZJi18qkokxK
	 gI2LRbKFYVtv0TZTTKaqmzSDp919mtLpsqU4TwnQYtNCGXhzyrynGyH5BzrRlAIfGI
	 SAakRXulBW8DBbqgROCMw/4bHCgTldG1HZ02WRSeBbKEk+AlJuur8I6a4l0cBOgeyo
	 dw5RKVMOjZsfNj2GN5A2VV2sJvPimHbTfEsb2HzN1YA+xFg4bBLzeSFlzUIYZquEI2
	 566Sb7DWKyp6L6xtgMW622vGMM/L/F1T98srvQnKV9yXG3R9rhV6PTC3SE6CNnhDAh
	 XTtkEEk660lDg==
Date: Fri, 7 Apr 2023 12:51:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: asml.silence@gmail.com, axboe@kernel.dk, davem@davemloft.net,
	dccp@vger.kernel.org, dsahern@kernel.org, edumazet@google.com,
	io-uring@vger.kernel.org, kuba@kernel.org, leit@fb.com,
	linux-kernel@vger.kernel.org, marcelo.leitner@gmail.com,
	matthieu.baerts@tessares.net, mptcp@lists.linux.dev,
	netdev@vger.kernel.org, pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH RFC] io_uring: Pass whole sqe to commands
Message-ID: <ZDBmQOhbyU0iLhMw@kbusch-mbp.dhcp.thefacebook.com>
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

This looks good to me. The only disadvantage I can see is that the async
fallback allocates just a tiny bit more data than before, but no biggie.

Reviewed-by: Keith Busch <kbusch@kernel.org>
 
> @@ -63,14 +63,15 @@ EXPORT_SYMBOL_GPL(io_uring_cmd_done);
>  int io_uring_cmd_prep_async(struct io_kiocb *req)
>  {
>  	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
> -	size_t cmd_size;
> +	size_t size = sizeof(struct io_uring_sqe);
>  
>  	BUILD_BUG_ON(uring_cmd_pdu_size(0) != 16);
>  	BUILD_BUG_ON(uring_cmd_pdu_size(1) != 80);

One minor suggestion. The above is the only user of uring_cmd_pdu_size() now,
which is kind of a convoluted way to enfoce the offset of the 'cmd' field. It
may be more clear to replace these with:

	BUILD_BUG_ON(offsetof(struct io_uring_sqe, cmd) == 48);
  
> -	cmd_size = uring_cmd_pdu_size(req->ctx->flags & IORING_SETUP_SQE128);
> +	if (req->ctx->flags & IORING_SETUP_SQE128)
> +		size <<= 1;
>  
> -	memcpy(req->async_data, ioucmd->cmd, cmd_size);
> +	memcpy(req->async_data, ioucmd->sqe, size);
>  	return 0;
>  }
