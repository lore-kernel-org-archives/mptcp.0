Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E32E1CD33
	for <mptcp@lists.linux.dev>; Tue, 12 Mar 2024 06:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710223220; cv=none; b=df1xA0yzF/YzbPUkp7j+tSRwnd4LgMZsoh+E4kNN0E3vFB8EfcsBi5AybhjdmEj62/qbgIP65qdP0rFpp7PkleFuXR7x07FxVVGHBW+IiTWZ5u8+Lmnt2HXbz/wTRvgq70IIJgfH9fWDo5ZnXMJs3Y03FzfpCIkX9lrHmgGePd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710223220; c=relaxed/simple;
	bh=d2O0BhCzR38ohkJHTmFwZx+q+34ZKQ2vx+p+v4sMNIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsBGWXoRan9XDHE3UEjSJx731tTKUjRT5BPDx8snU4mdlOyF3RnxgAXzxK21mt3GUm9o4s15GWEc2zfK2wKAjWKrSxAjUlu+h/chUhJMrn27iqcd1B220obX5J1LkMzMOaXeO8fBnRggvn/FQ7lvXYjfchF+GeRIZ+Zrul0KdTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMJxk/AB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMJxk/AB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD7AC433F1;
	Tue, 12 Mar 2024 06:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710223220;
	bh=d2O0BhCzR38ohkJHTmFwZx+q+34ZKQ2vx+p+v4sMNIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KMJxk/ABTXj/yxRG1lXvSbuwh88ZSc0R41SWz7eEniKqmrPZGzPsr3GUcc/lVVzvO
	 nMcqGV0hG10trqQruO9ADS19MGovPzhbdsM4/8VNQTPFhtdwFfJv6LbHXk9b2nK/BZ
	 M+yQCjd+iIYnZmE10KXGctmEUT2WkR8by7VDO6mOvalv8GOMeMPNH9rVgtAgg2ohz8
	 gHqNG68B1By2bAGNLGJ+27/9f8+bSW1stn9sw0Zc1fkzwnktmCV3V2QDS+HiSEVsFf
	 Fb710xDzgB7h+Vr/pBFi9bYVF//hWk8ornEbFl2gyOc6usRuQ/IR7aD0ff1TQsmoQL
	 GVxda9loFO79A==
Date: Tue, 12 Mar 2024 14:00:15 +0800
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH RFC] mptcp: react scheduler when subflow events pop up
Message-ID: <Ze/vb857Y9IWZf9X@t480>
References: <433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn>
 <54acb706fee5467bffa460e82146579469c5cdb6.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54acb706fee5467bffa460e82146579469c5cdb6.camel@redhat.com>

Hi Paolo,

Thanks for your review.

On Mon, Mar 11, 2024 at 02:10:25PM +0100, Paolo Abeni wrote:
> On Wed, 2024-03-06 at 10:55 +0800, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > The current packet scheduler will not react by queuing more packets if
> > some subflows only events are emitted, e.g. new TCP ACKs are received
> > only acking things at TCP-level but not at MPTCP level. The scheduler
> > should be called when such events happen.
> > 
> > ack_update_msk() is invoked when an ACK is received, so it's the right
> > place to call the scheduler by invoking __mptcp_check_push().
> > 
> > mptcp_subflow_timeout() is implemented to call the scheduler when a
> > subflow timeout happens. But I'm not sure where is the right place to
> > invoke it. I mean where is the right place when a RTO is fired. So I
> > temporarily do it in mptcp_worker().
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/343
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  include/net/tcp.h    |  3 +++
> >  net/ipv4/tcp_timer.c |  6 +++---
> >  net/mptcp/options.c  |  1 +
> >  net/mptcp/protocol.c | 23 ++++++++++++++++++++++-
> >  net/mptcp/protocol.h |  1 +
> >  5 files changed, 30 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 6ae35199d3b3..431a23a8ebfa 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -347,6 +347,9 @@ void tcp_release_cb(struct sock *sk);
> >  void tcp_wfree(struct sk_buff *skb);
> >  void tcp_write_timer_handler(struct sock *sk);
> >  void tcp_delack_timer_handler(struct sock *sk);
> > +bool retransmits_timed_out(struct sock *sk,
> > +			   unsigned int boundary,
> > +			   unsigned int timeout);
> >  int tcp_ioctl(struct sock *sk, int cmd, int *karg);
> >  enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
> >  void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
> > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > index d1ad20ce1c8c..cfedafc4ca36 100644
> > --- a/net/ipv4/tcp_timer.c
> > +++ b/net/ipv4/tcp_timer.c
> > @@ -212,9 +212,9 @@ static unsigned int tcp_model_timeout(struct sock *sk,
> >   * after "boundary" unsuccessful, exponentially backed-off
> >   * retransmissions with an initial RTO of TCP_RTO_MIN.
> >   */
> > -static bool retransmits_timed_out(struct sock *sk,
> > -				  unsigned int boundary,
> > -				  unsigned int timeout)
> > +bool retransmits_timed_out(struct sock *sk,
> > +			   unsigned int boundary,
> > +			   unsigned int timeout)
> >  {
> >  	struct tcp_sock *tp = tcp_sk(sk);
> >  	unsigned int start_ts, delta;
> 
> If we access the function from outside the tcp code, we additionally
> need to rename it as 'tcp_retransmits_timed_out' or the like.
> 
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 5926955625cf..4b091d3bce00 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -1069,6 +1069,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
> >  		__mptcp_snd_una_update(msk, new_snd_una);
> >  		__mptcp_data_acked(sk);
> >  	}
> > +	__mptcp_check_push(sk, ssk);
> 
> It we call __mptcp_check_push() unconditionally here, we must remove
> the previous conditional call, a few lines above.
> 
> Still I think we should not call it unconditionally: only if msk ack
> seq or the subflow ack seq changed.

I didn't notice that __mptcp_check_push() is just invoked a few lines
above. Yes, you're right, no need to add another one.

Here addresses first issue in #343, call the scheduler when TCP ACKs are
received.

It looks like the scheduler has already been called, (the previous
conditional call) when TCP ACKs are received. So we don't need to add
any more code, do we?

> 
> Additionally we need some performance figures the ensure this is not
> impacting [too much] the bulk transfer performances
> 
> Somewhat related. I *think* there is a possible issue WRT the current
> (prior to this patch) packet scheduler strategy:
> 
> When the msk ack sequence increases, we unconditionally push data on
> the subflow receiving such update:
> 
> https://elixir.bootlin.com/linux/latest/source/net/mptcp/protocol.c#L1643
> 
> That choice could be sup-optimal. I *think* we should always call the
> scheduler, and I'm not sure (I can't recall) the why of the current
> implementation.

The original code of this part is:

         /* the caller already invoked the packet scheduler,
          * check for a different subflow usage only after
          * spooling the first chunk of data
          */
         xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
         if (!xmit_ssk)
                 goto out;
         if (xmit_ssk != ssk) {
                 mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
                                        MPTCP_DELEGATE_SEND);
                 goto out;
         }

I guess the reason is in the comment: "the caller already invoked the
packet scheduler".

> 
> This could also explain some simult-subflow self-tests failures
> 
> >  	mptcp_data_unlock(sk);
> >  
> >  	trace_ack_update_msk(mp_opt->data_ack,
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index cdf9ec67795e..c935f6a7adb0 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -486,6 +486,26 @@ static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subfl
> >  	       inet_csk(ssk)->icsk_timeout - jiffies : 0;
> >  }
> >  
> > +static void __mptcp_subflow_timeout(struct sock *sk, struct sock *ssk, long tout)
> > +{
> > +	unsigned int boundary = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_retries1) + 1;
> > +
> > +	if (retransmits_timed_out(ssk, boundary, tout))
> > +		__mptcp_check_push(sk, ssk);
> 
> Both retransmits_timed_out() and __mptcp_check_push() must be called
> under the ssk socket lock.
> 
> I think we should look for a better solution then acquiring such lock
> unconditionally for each subflow.
> 
> More importantly why this hook is needed? the subflow did make any
> progress, we can't enqueue more data there.

Here addresses second issue in #343, call the scheduler when a subflow
timeout happens. As I described in the commit log:

"I'm not sure where is the right place when a RTO is fired. So I temporarily
do it in mptcp_worker()."

Thanks,
-Geliang

> 
> A possible alternative would be use this hook to mark the subflow as
> stale, but... do we have any issues with the current schema to detect
> stale subflows?
> 
> Thanks!
> 
> Paolo
> 
