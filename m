Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853431B95B
	for <mptcp@lists.linux.dev>; Sun, 10 Aug 2025 01:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754788438; cv=none; b=lIP6EnUsfrQ32b+ZMJcDOO8GacDuBvp+y11PUVrj9CSj6uNk4dUowdXRlFtzYRuiASD0xMepSq3+nhy2rlF68XD6tyScq79h0lX+pbBKut4elMllCIqf2JeaV3POUDl+mTyecy1K0d0EIJeFEOezhsi6hklK6KTIqxIXQOjE+V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754788438; c=relaxed/simple;
	bh=v6Z6pOz2EHYF7hD8Gy2w4Fu6ocIwJM5+/JdtB4uiBG8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WDZXBIdoJugxLK8yOa1nkIM8J1qWytk6lUlzfc/ext+duHV6zPTZotMkHUWBEMZ+Ic0uuFJ3ffnCpuVIbu847Mj/AzFTdJxw4jSZ1oM7doH6UB+iGDdIxcZSsZ6yMLCtMxiNJJ2o2y1NEg4onA5gBH1lmLVGig7ZDbg2vNvr44U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlTrakcv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlTrakcv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD231C4CEE7;
	Sun, 10 Aug 2025 01:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754788438;
	bh=v6Z6pOz2EHYF7hD8Gy2w4Fu6ocIwJM5+/JdtB4uiBG8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IlTrakcv/BDYdm6q/awqiP+J9u4WuMIw31jnhmpLrdYfoxZHURgGBk/2vUfKPaoZG
	 2vX+BAb2HuCOJLXKxVyFi7llVb9LUPxEsJKV/d5fs8ekV/rHIEuNeXhsfCRCEswAmV
	 eus9i3B6EqOWfI7vZVsmjPAMjqUSpeyI1d73z78gXpsRf4O1IthwPKQc+3sMjHi9a0
	 ZDT18O1/Znw24k1eEhj0QLL50FS1AopUOXrKyWe352Fj7Ia9gkWcDvo7OyujdCT9OJ
	 SO0dAFYwcP450sFZNjMAdZGGpKHbouuymLdgC4tsuRlFZJQG6EzEkKfagIAX/waTU/
	 MJ0RxIokW453g==
Message-ID: <78799855faff1bb19cdec5210ca5edf302d39974.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 2/3] mptcp: make ADD_ADDR retransmission
 timeout adaptive
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Christoph Paasch
 <cpaasch@openai.com>
Date: Sun, 10 Aug 2025 09:13:54 +0800
In-Reply-To: <b0a4ebe8-0dfd-4c15-89bf-98c4f7cfebc0@kernel.org>
References: <cover.1754449947.git.tanggeliang@kylinos.cn>
	 <c559f29eea1e019b6d25a35f05bbeb85fdd578e1.1754449947.git.tanggeliang@kylinos.cn>
	 <eb6c0e4d-938c-4712-83b2-ee12bd70aa12@kernel.org>
	 <f42defcb7fe7db02283fed5def29623cbc6a24d7.camel@kernel.org>
	 <b0a4ebe8-0dfd-4c15-89bf-98c4f7cfebc0@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2025-08-07 at 13:56 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 07/08/2025 05:25, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Wed, 2025-08-06 at 17:34 +0200, Matthieu Baerts wrote:
> > > Hi Geliang,
> > > 
> > > On 06/08/2025 05:17, Geliang Tang wrote:
> > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > 
> > > > Replace the fixed ADD_ADDR retransmission timeout with an
> > > > adaptive
> > > > mechanism that uses the maximum RTO among existing subflows.
> > > > This
> > > > improves responsiveness when establishing new subflows while
> > > > maintaining
> > > > an upper bound through the configured add_addr_timeout value.
> > > > 
> > > > Key changes:
> > > > 1. Compute timeout as min(max_subflow_RTO,
> > > > configured_max_timeout)
> > > > 2. Apply exponential backoff based on retransmission count
> > > > 3. Maintain fallback to configured max timeout when no subflows
> > > > exist
> > > > 4. Update documentation to clarify add_addr_timeout is now the
> > > > maximum
> > > > value
> > > > 
> > > > Closes:
> > > > https://github.com/multipath-tcp/mptcp_net-next/issues/576
> > > > Reviewed-by: Christoph Paasch <cpaasch@openai.com>
> > > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > > ---
> > > >  Documentation/networking/mptcp-sysctl.rst |  4 +--
> > > >  net/mptcp/pm.c                            | 30
> > > > ++++++++++++++++++++---
> > > >  2 files changed, 29 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/Documentation/networking/mptcp-sysctl.rst
> > > > b/Documentation/networking/mptcp-sysctl.rst
> > > > index 1683c139821e..2b8e8fb99ee2 100644
> > > > --- a/Documentation/networking/mptcp-sysctl.rst
> > > > +++ b/Documentation/networking/mptcp-sysctl.rst
> > > > @@ -8,8 +8,8 @@ MPTCP Sysfs variables
> > > >  ===============================
> > > >  
> > > >  add_addr_timeout - INTEGER (seconds)
> > > > -	Set the timeout after which an ADD_ADDR control
> > > > message
> > > > will be
> > > > -	resent to an MPTCP peer that has not acknowledged a
> > > > previous
> > > > +	Set the maximum value of timeout after which an
> > > > ADD_ADDR
> > > > control message
> > > > +	will be resent to an MPTCP peer that has not
> > > > acknowledged
> > > > a previous
> > > >  	ADD_ADDR message.
> > > >  
> > > >  	Do not retransmit if set to 0.
> > > > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > > > index 1330af6a2154..34cc4f45bc7d 100644
> > > > --- a/net/mptcp/pm.c
> > > > +++ b/net/mptcp/pm.c
> > > > @@ -268,6 +268,30 @@ int mptcp_pm_mp_prio_send_ack(struct
> > > > mptcp_sock *msk,
> > > >  	return -EINVAL;
> > > >  }
> > > >  
> > > > +static unsigned int mptcp_adjust_add_addr_timeout(struct
> > > > mptcp_sock *msk)
> > > > +{
> > > > +	struct mptcp_subflow_context *subflow;
> > > > +	struct sock *sk = (struct sock *)msk;
> > > > +	unsigned int max_rto = 0;
> > > > +	unsigned int timeout;
> > > > +
> > > > +	timeout = mptcp_get_add_addr_timeout(sock_net(sk));
> > > > +
> > > > +	mptcp_for_each_subflow(msk, subflow) {
> > > > +		struct sock *ssk =
> > > > mptcp_subflow_tcp_sock(subflow);
> > > > +		unsigned int subflow_rto;
> > > > +
> > > > +		subflow_rto = __tcp_set_rto(tcp_sk(ssk)) * 2;
> > > 
> > > Why "* 2"? Is it what TCP is doing?
> > > 
> > > (Probably best to add a comment here above, and in the commit
> > > message.)
> > > 
> > > (Also, I guess the compiler will do the optimisation, but you
> > > could
> > > write: ">> 1" instead of "* 2".
> > 
> > Yes, "<< 1" is much better. I added a comment here:
> > 
> > +               /*
> > +                * icsk->icsk_rto is not used directly since
> > +                * it's not updated frequently enough.
> > +                *
> > +                * subflow_rto is twice of rto, and allow
> > +                * some tolerance for add_addr echo.
> > +                */
> > +               subflow_rto = __tcp_set_rto(tcp_sk(ssk)) << 1;
> > 
> > Is this okay?
> 
> No :)
> 
> I don't think the comment explain why it is twice the default TCP
> RTO.
> Why having an exception here for the ADD_ADDR? I mean: I'm OK with
> the
> idea of doubling the RTO, but only if there is a reason behind that
> :)

How about this one (answered by DeepSeek, an AI from China):

        /*   
         * icsk->icsk_rto is not used directly since it's not
         * updated frequently enough.
         *
         * Setting subflow_rto to twice of RTO provides a safety
         * buffer for RTT estimation variance, kernel RTO update
         * delays, and a full transmission retry cycle while
         * minimizing false failures.
         */
        subflow_rto = __tcp_set_rto(tcp_sk(ssk)) << 1;

Thanks,
-Geliang

> 
> Cheers,
> Matt
