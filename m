Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF583090DB
	for <mptcp@lists.linux.dev>; Wed, 10 Dec 2025 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765361067; cv=none; b=Fx5YLrW0ZGDjkSDRIhL8gBvYCrPMPDAV/q2/ioSkH4Q20C+BzjYhNd8VSWNHP8+ZyLY8iSFT2G3lda/DyI+IafvOme7QP6sDg6GPGE9S8G+91JgxH8beEBUjXWFrm2mQCoS5XyKVwhXHhmWDTxgJUeffCDCY0ajFHWTnmnUhEP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765361067; c=relaxed/simple;
	bh=GQhiP0AmoNDa8RBRB38pHjrJ0jG9i07vm4JyMHQtmkI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OOWfi8EO3TDWgQl0vGISfuluu4ENMQ8IyDJRrY4j4sYDLzm9uAHbvoeiUtySJoIRlj+HYkPykVsJsQFQLTPjKheQdOowXjtz8QDP2aSaQEGHaHwteX94nNr3Bl+IIpaObQsBEwuZEedTsGlamD3o0gQmu3hKTUmbFS8eDEDrFpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P20K6JbC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P20K6JbC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E21C4CEF1;
	Wed, 10 Dec 2025 10:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765361067;
	bh=GQhiP0AmoNDa8RBRB38pHjrJ0jG9i07vm4JyMHQtmkI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=P20K6JbCyzlmWHNclViAuFxLl4YtkFIfJvC69PhSf5x41xERmNkZkCts9XhUIY528
	 zfTMuvHjkvsXS9H2D5AMpJBzXC66YYaNgKufRoYc2ZN7v3IzW0sBM33Sjb610CsbKb
	 3yCeS7hLF7ZxWgi/tBMt307FDwJI8hD1YjfsdZWAyPU+ijUERk1YMzAutMepGyuQOV
	 YeWuWeE4crIqQty/jgDRol/o0n4f2NK5wor2o1lWmPXqkUd9Dt3tDA7X9gBOx2E73G
	 lSKsKgfHQkh+R+JCuOEgrc2U9v23XedpkkIuWOlBb678uwhouyT9lZfcbGElV86b0K
	 lmHZThFwUAy9Q==
Message-ID: <001cfd6acc587905f0e95b6f2195b4d817a867a6.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/2] mptcp: use sk_is_tcp helper
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 10 Dec 2025 18:04:23 +0800
In-Reply-To: <b0db8dd7-a0dd-4673-bfa5-a62ebf8facc5@kernel.org>
References: <cover.1765354225.git.tanggeliang@kylinos.cn>
	 <f33c663ae39d50dbca2623822519f5628c04f9f0.1765354225.git.tanggeliang@kylinos.cn>
	 <b0db8dd7-a0dd-4673-bfa5-a62ebf8facc5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Wed, 2025-12-10 at 10:54 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for the patches.
> 
> On 10/12/2025 09:12, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch enhances the validation by using sk_is_tcp to determine
> > whether
> > the socket is a TCP socket. This approach is more rigorous than
> > simply
> > checking if sk_protocol equals IPPROTO_TCP, as the helper also
> > verifies
> > sk_family and sk_type.
> > 
> > Note: The modifications in the bpf_sk_stream_memory_free section
> > should be
> > squashed into the commit "bpf: Export mptcp packet scheduler
> > helpers".
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/bpf.c      | 4 ++--
> >  net/mptcp/protocol.h | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > index b261551f5d1b..372a21b96495 100644
> > --- a/net/mptcp/bpf.c
> > +++ b/net/mptcp/bpf.c
> > @@ -193,7 +193,7 @@ static struct bpf_struct_ops
> > bpf_mptcp_sched_ops = {
> >  
> >  struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
> >  {
> > -	if (sk && sk_fullsock(sk) && sk->sk_protocol ==
> > IPPROTO_TCP && sk_is_mptcp(sk))
> > +	if (sk && sk_fullsock(sk) && sk_is_tcp(sk) &&
> > sk_is_mptcp(sk))
> 
> I know that BPF has a few extra "hidden" checks: are you adding this
> because you saw issues where the protocol could be set to TCP, but
> the
> family and type are not the expected ones?

No, let's drop this patch then. 

How do you think about patch 2? Is sk_is_msk() a good name? I will
directly include patch 2 in the KTLS series.

Thanks,
-Geliang

> 
> If not, it might be harder to justify these patches upstream.
> 
> >  		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
> >  
> >  	return NULL;
> > @@ -294,7 +294,7 @@ __bpf_kfunc static bool
> > bpf_sk_stream_memory_free(const struct sock *sk__ign)
> >  	const struct sock *sk = sk__ign;
> >  
> >  	if (sk && sk_fullsock(sk) &&
> > -	    sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
> > +	    sk_is_tcp(sk) && sk_is_mptcp(sk))
> >  		return sk_stream_memory_free(sk);
> >  
> >  	return NULL;
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index cd5266099993..f418a0a0fa51 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -399,7 +399,7 @@ static inline void msk_owned_by_me(const struct
> > mptcp_sock *msk)
> >  #undef tcp_sk
> >  #define tcp_sk(ptr)
> > ({								\
> >  	typeof(ptr) _ptr =
> > (ptr);						\
> > -	WARN_ON(_ptr->sk_protocol !=
> > IPPROTO_TCP);				\
> > +	WARN_ON(!sk_is_tcp(_ptr));				
> > 		\
> 
> I don't think we should change that here. That will potentially cause
> issues with kunit, but also the check here is mainly to catch that
> 'tcp_sk()' is not called with an MPTCP socket. So only the protocol
> check is needed.
> 
> >  	container_of_const(_ptr, struct tcp_sock,
> > inet_conn.icsk_inet.sk);	\
> >  })
> >  #define mptcp_sk(ptr)
> > ({						\
> 
> Cheers,
> Matt
