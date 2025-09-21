Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8024C6D
	for <mptcp@lists.linux.dev>; Sun, 21 Sep 2025 01:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758416490; cv=none; b=iXE1uTQO8LceUbEnAkGYBS76FVop6wD9D31ifMQedikyBxiUEa3Z+HhHeK08kmUtSvbgVJlE4Qx8VSHOl4fTw/pGZ1Iy9nNO1fj04OcKA77A3mMPHVvulp9lDLb0bCcrhIZ+Zx5D24rvW9+uPnhbCB1qu/mnjwGiXfq2IuymGes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758416490; c=relaxed/simple;
	bh=dtISwzodfXBUFFoiH8dZKRAEAEjGtZUeUow7xOMLhXc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H5RiFB7128eh+DceISvLaKmsJ6Dj1e0Ko1huRtC0C8j2xs+RbaKzHjYi/fWnae9+FPV0bnuCbDaz3IWXUaSrQtm1joGvvZfZR3Gg38K5nUyTRs+QBPM5R0mdUldorsrJIFSgCQD6MSTBCQyilutlqT0i9UW1js5/pkrJwiz7V8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfxklIFN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfxklIFN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87A8C4CEEB;
	Sun, 21 Sep 2025 01:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758416489;
	bh=dtISwzodfXBUFFoiH8dZKRAEAEjGtZUeUow7xOMLhXc=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=BfxklIFNP3+7GSd1dHDgYUXoCXWO2n+6InddCKjCHnL9LVkzjPWTAvcrQQHZkeC29
	 uDI+Z3wKOnfFDEmWF50lTHxdrQRmI1gDvX8aegGLg8k2BGewEQsBM+YpxS0OsdsVGA
	 D76R+yhKLQ6c8VYWgI+AHd3B2aqhgzlsl3ydV4LofaFi+aeDoPE79so+m8S73KYZJl
	 n0uPgnXigIubF4FsWeVn+PGe/x0sfHmqEBsepnfaK+r8tTGPzFPGPp/mAuEJ82Jex/
	 LfDI3QqI/1CtAyPThQVz55N7GQlUYs/0pkEL5UCuwQLLaAMuvDfibjkWuW81pdKob/
	 n/U+EaEEK9iaw==
Message-ID: <71ec0d4b89140d421e953d1ca03009f960fd9de8.camel@kernel.org>
Subject: Re: [MPTCP next v3 09/12] mptcp: cleanup fallback dummy mapping
 generation.
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Sun, 21 Sep 2025 09:01:26 +0800
In-Reply-To: <4d3650ef680da6d172bf69223bda3dea2bb4a71c.camel@kernel.org>
References: <cover.1758296923.git.pabeni@redhat.com>
		 <31bedb1bf0f3448fa804d3ef8d41fada09636a26.1758296923.git.pabeni@redhat.com>
	 <4d3650ef680da6d172bf69223bda3dea2bb4a71c.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2025-09-20 at 08:06 +0800, Geliang Tang wrote:
> On Fri, 2025-09-19 at 17:53 +0200, Paolo Abeni wrote:
> > MPTCP currently access ack_seq outside the msk socket log scope to
> > generate the dummy mapping for fallback socket. Soon we are going
> > to introduce backlog usage and even for fallback socket the ack_seq
> > value will be significantly off outside of the msk socket lock
> > scope.
> > 
> > Avoid relying on ack_seq for dummy mapping generation, using
> > instead
> > the subflow sequence number. Note that in case of disconnect() and
> > (re)connect() we must ensure that any previous state is re-set.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v2 -> v3:
> >  - reordered before the backlog introduction to avoid transiently
> >    break the fallback
> >  - explicitly reset ack_seq
> > ---
> >  net/mptcp/protocol.c | 3 +++
> >  net/mptcp/subflow.c  | 8 +++++++-
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index fce70cdad2a7f..c8b02048126a9 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -3224,6 +3224,9 @@ static int mptcp_disconnect(struct sock *sk,
> > int flags)
> >  	msk->bytes_retrans = 0;
> >  	msk->rcvspace_init = 0;
> >  
> > +	/* for fallback's sake */
> > +	WRITE_ONCE(msk->ack_seq, 0);
> > +
> >  	WRITE_ONCE(sk->sk_shutdown, 0);
> >  	sk_error_report(sk);
> >  	return 0;
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index b9455c04e8a46..ac8616e7521e8 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -491,6 +491,9 @@ static void subflow_set_remote_key(struct
> > mptcp_sock *msk,
> >  	mptcp_crypto_key_sha(subflow->remote_key, NULL, &subflow-
> > > iasn);
> >  	subflow->iasn++;
> >  
> > +	/* for fallback's sake */
> > +	subflow->map_seq = subflow->iasn;
> > +
> >  	WRITE_ONCE(msk->remote_key, subflow->remote_key);
> >  	WRITE_ONCE(msk->ack_seq, subflow->iasn);
> >  	WRITE_ONCE(msk->can_ack, true);
> > @@ -1435,9 +1438,12 @@ static bool subflow_check_data_avail(struct
> > sock *ssk)
> >  
> >  	skb = skb_peek(&ssk->sk_receive_queue);
> >  	subflow->map_valid = 1;
> > -	subflow->map_seq = READ_ONCE(msk->ack_seq);
> 
> nit:
> 
> How about replacing this line in place? I mean, do not move it to a
> later position:
> 
> +	subflow->map_seq = __mptcp_expand_seq(subflow->map_seq,
> +					      subflow->iasn +
> +					      TCP_SKB_CB(skb)->seq -
> +					      subflow->ssn_offset -
> 1);
> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Tested-by: Geliang Tang <geliang@kernel.org>

Please delete the sentence in the subject of this patch too.

Thanks,
-Geliang

> 
> Thanks,
> -Geliang
> 
> >  	subflow->map_data_len = skb->len;
> >  	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq -
> > subflow->ssn_offset;
> > +	subflow->map_seq = __mptcp_expand_seq(subflow->map_seq,
> > +					      subflow->iasn +
> > +					      TCP_SKB_CB(skb)->seq
> > -
> > +					      subflow->ssn_offset
> > -
> > 1);
> >  	WRITE_ONCE(subflow->data_avail, true);
> >  	return true;
> >  }
