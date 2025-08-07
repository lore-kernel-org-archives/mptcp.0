Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6188B189
	for <mptcp@lists.linux.dev>; Thu,  7 Aug 2025 03:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754537111; cv=none; b=RyGs80NnV4SvkndyaDR33C2w7UWD+RiljWNVKMfxjZxKpZR522GhrTb9N/832FsFvIkK8rHTE5xI8++fvYyoFZJp8JDhxniZDNv38Xdl0K9/xvwA5NDioVmDbgZeFdirZuRhuWuBEIl47+hFpfuQIoKbn36fo3kXz5MyY4rQ2kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754537111; c=relaxed/simple;
	bh=pjOlRgZ02Z2BROUoDRc744aj3+NJ46NBp35sntYms1I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CLAIMQnN8hLL26B8DR3wJIVthrnCPYdk/4DHlGrErcNC4ii/LFHuVJN6NvTzR7/JArVRg6foHoXD1w0dvyo3z9haTQTJWlJ3jFnbAWhT/jBgtvK0nOfe1f56tM9+jVFlQ8bR42pNZ0rMSH8r4C0DiYfmfLfdw9x+dApJ5QoRKu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB66I/Gu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB66I/Gu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753E9C4CEE7;
	Thu,  7 Aug 2025 03:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754537110;
	bh=pjOlRgZ02Z2BROUoDRc744aj3+NJ46NBp35sntYms1I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NB66I/GulRXbaUKK3EUoMhiq+aaijH7+J9rpqpIGRsG/y4IUVNcMcXO8hAoMBqROh
	 l6p5i+LrpTSIFmk/Oli1aiqAxA5Par3J58V6xwEmSW/RykrBScaOPV7awjmwI+dokv
	 8+tTw4HZZxsRYyqcJUDXg5o+l0S+n0sAnikJyaOtnXoy3RbIjw1bdpceJEVdZdcs3U
	 i2VYE+3qDwP7ytrCBoBwIgvMyk5MshIOoOKPgXTr53fADugyQ9rSALyPdFZCom1urg
	 WjNchhLyh95OIJmEQpjxOAUM+q/AisaeGNJBB6w+//HQ2FsuvO3JeWNTZFmBaiq6K5
	 wDEpLNTKcnv/A==
Message-ID: <f42defcb7fe7db02283fed5def29623cbc6a24d7.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 2/3] mptcp: make ADD_ADDR retransmission
 timeout adaptive
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Christoph Paasch
 <cpaasch@openai.com>
Date: Thu, 07 Aug 2025 11:25:06 +0800
In-Reply-To: <eb6c0e4d-938c-4712-83b2-ee12bd70aa12@kernel.org>
References: <cover.1754449947.git.tanggeliang@kylinos.cn>
	 <c559f29eea1e019b6d25a35f05bbeb85fdd578e1.1754449947.git.tanggeliang@kylinos.cn>
	 <eb6c0e4d-938c-4712-83b2-ee12bd70aa12@kernel.org>
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

On Wed, 2025-08-06 at 17:34 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 06/08/2025 05:17, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Replace the fixed ADD_ADDR retransmission timeout with an adaptive
> > mechanism that uses the maximum RTO among existing subflows. This
> > improves responsiveness when establishing new subflows while
> > maintaining
> > an upper bound through the configured add_addr_timeout value.
> > 
> > Key changes:
> > 1. Compute timeout as min(max_subflow_RTO, configured_max_timeout)
> > 2. Apply exponential backoff based on retransmission count
> > 3. Maintain fallback to configured max timeout when no subflows
> > exist
> > 4. Update documentation to clarify add_addr_timeout is now the
> > maximum
> > value
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/576
> > Reviewed-by: Christoph Paasch <cpaasch@openai.com>
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  Documentation/networking/mptcp-sysctl.rst |  4 +--
> >  net/mptcp/pm.c                            | 30
> > ++++++++++++++++++++---
> >  2 files changed, 29 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/networking/mptcp-sysctl.rst
> > b/Documentation/networking/mptcp-sysctl.rst
> > index 1683c139821e..2b8e8fb99ee2 100644
> > --- a/Documentation/networking/mptcp-sysctl.rst
> > +++ b/Documentation/networking/mptcp-sysctl.rst
> > @@ -8,8 +8,8 @@ MPTCP Sysfs variables
> >  ===============================
> >  
> >  add_addr_timeout - INTEGER (seconds)
> > -	Set the timeout after which an ADD_ADDR control message
> > will be
> > -	resent to an MPTCP peer that has not acknowledged a
> > previous
> > +	Set the maximum value of timeout after which an ADD_ADDR
> > control message
> > +	will be resent to an MPTCP peer that has not acknowledged
> > a previous
> >  	ADD_ADDR message.
> >  
> >  	Do not retransmit if set to 0.
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index 1330af6a2154..34cc4f45bc7d 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -268,6 +268,30 @@ int mptcp_pm_mp_prio_send_ack(struct
> > mptcp_sock *msk,
> >  	return -EINVAL;
> >  }
> >  
> > +static unsigned int mptcp_adjust_add_addr_timeout(struct
> > mptcp_sock *msk)
> > +{
> > +	struct mptcp_subflow_context *subflow;
> > +	struct sock *sk = (struct sock *)msk;
> > +	unsigned int max_rto = 0;
> > +	unsigned int timeout;
> > +
> > +	timeout = mptcp_get_add_addr_timeout(sock_net(sk));
> > +
> > +	mptcp_for_each_subflow(msk, subflow) {
> > +		struct sock *ssk =
> > mptcp_subflow_tcp_sock(subflow);
> > +		unsigned int subflow_rto;
> > +
> > +		subflow_rto = __tcp_set_rto(tcp_sk(ssk)) * 2;
> 
> Why "* 2"? Is it what TCP is doing?
> 
> (Probably best to add a comment here above, and in the commit
> message.)
> 
> (Also, I guess the compiler will do the optimisation, but you could
> write: ">> 1" instead of "* 2".

Yes, "<< 1" is much better. I added a comment here:

+               /*
+                * icsk->icsk_rto is not used directly since
+                * it's not updated frequently enough.
+                *
+                * subflow_rto is twice of rto, and allow
+                * some tolerance for add_addr echo.
+                */
+               subflow_rto = __tcp_set_rto(tcp_sk(ssk)) << 1;

Is this okay?

Thanks,
-Geliang

> 
> > +		if (subflow_rto > max_rto)
> > +			max_rto = subflow_rto;
> > +	}
> > +
> > +	if (max_rto && max_rto < timeout)
> > +		timeout = max_rto;
> > +
> > +	return timeout;
> > +}
> > +
> >  static void mptcp_pm_add_timer(struct timer_list *timer)
> >  {
> >  	struct mptcp_pm_add_entry *entry =
> > timer_container_of(entry, timer,
> > @@ -292,7 +316,7 @@ static void mptcp_pm_add_timer(struct
> > timer_list *timer)
> >  		goto out;
> >  	}
> >  
> > -	timeout = mptcp_get_add_addr_timeout(sock_net(sk));
> > +	timeout = mptcp_adjust_add_addr_timeout(msk);
> >  	if (!timeout)
> >  		goto out;
> >  
> > @@ -307,7 +331,7 @@ static void mptcp_pm_add_timer(struct
> > timer_list *timer)
> >  
> >  	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
> >  		sk_reset_timer(sk, timer,
> > -			       jiffies + timeout);
> > +			       jiffies + (timeout << entry-
> > >retrans_times));
> >  
> >  	spin_unlock_bh(&msk->pm.lock);
> >  
> > @@ -373,7 +397,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock
> > *msk,
> >  	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
> >  out:
> >  	sk_reset_timer(sk, &add_entry->add_timer,
> > -		       jiffies +
> > mptcp_get_add_addr_timeout(sock_net(sk)));
> > +		       jiffies +
> > mptcp_adjust_add_addr_timeout(msk));
> >  
> >  	return true;
> >  }
> 
> Cheers,
> Matt
