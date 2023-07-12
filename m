Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B930EAE7
	for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 21:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032BAC433C8;
	Wed, 12 Jul 2023 21:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689198911;
	bh=nCopk5knjjoLBnkSXBGUSvZZzSK+7oiciS+onF0vtJQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=KSYBYuBrq04b+e1O7kV1fqjRAUDWQCD27buNsqkKfU6pX3OwP0ViY9bm8o9Zx96tP
	 WveGwStQafzRFAmOrF/WzRSV4Dzkd3ygBfOpbcjuUjmnA19KIRQ3+jUpx0b9R6Wsot
	 Kiz1myErs5pscczS0YvlxdV3YRoFCFLEdrpHP+YSwgHE3sRXbDAGA+m6FWvj8bLfXQ
	 B9bcAFsWlPeSWxC05Rz6R2+u0BrVHJE+AW7RMH13pfhXY+9vzsM/W07kAh3AfFkx2T
	 aEW5QVsgwsA+U1Vr32TeJMHvTAU1mwHCZyeZ991ckWLOLVDUbbUNPA9F0k28rtipmz
	 ztPiYDIWBRS4A==
Date: Wed, 12 Jul 2023 14:55:05 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 10/14] mptcp: avoid unneeded indirection in
 mptcp_stream_accept()
In-Reply-To: <7e485259a201fdac1807c56746bd437d4335edd1.1688993569.git.pabeni@redhat.com>
Message-ID: <059ab23a-f925-a1c7-2a1d-a4e03714d66e@kernel.org>
References: <cover.1688993569.git.pabeni@redhat.com> <7e485259a201fdac1807c56746bd437d4335edd1.1688993569.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 10 Jul 2023, Paolo Abeni wrote:

> We are going to remove the first subflow socket soon, so avoid
> the addictional indirection at accept() time. Instead access
> directly the first subflow sock.
>
> No functional changes intended.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 17 +++++------------
> 1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4e5c9770d8d6..00cfed1d0ebd 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3220,17 +3220,12 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
> 				 bool kern)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> -	struct socket *listener;
> -	struct sock *newsk;
> +	struct sock *ssk, *newsk;
>
> -	listener = READ_ONCE(msk->subflow);
> -	if (WARN_ON_ONCE(!listener)) {
> -		*err = -EINVAL;
> -		return NULL;
> -	}
> +	ssk = READ_ONCE(msk->first);

There's a check for NULL msk->first in mptcp_stream_accept() below, but 
the analogous NULL check in this function has been removed. Should this 
be checking? (not sure if we have test coverage for out-of-sequence 
accept() calls)

>
> -	pr_debug("msk=%p, listener=%p", msk, mptcp_subflow_ctx(listener->sk));
> -	newsk = inet_csk_accept(listener->sk, flags, err, kern);
> +	pr_debug("msk=%p, listener=%p", msk, mptcp_subflow_ctx(ssk));
> +	newsk = inet_csk_accept(ssk, flags, err, kern);
> 	if (!newsk)
> 		return NULL;
>
> @@ -3801,7 +3796,6 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
> 			       int flags, bool kern)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
> -	struct socket *ssock;
> 	struct sock *newsk;
> 	int err;
>
> @@ -3810,8 +3804,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
> 	/* Buggy applications can call accept on socket states other then LISTEN
> 	 * but no need to allocate the first subflow just to error out.
> 	 */
> -	ssock = READ_ONCE(msk->subflow);
> -	if (!ssock)
> +	if (!READ_ONCE(msk->first))
> 		return -EINVAL;
>
> 	newsk = mptcp_accept(sock->sk, flags, &err, kern);
> -- 
> 2.41.0
>
>
>
