Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E371
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 09:57:32 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lhUZW-0006vf-RZ; Fri, 14 May 2021 11:57:30 +0200
Date: Fri, 14 May 2021 11:57:30 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 1/8] mptcp: enable busypoll from mptcp
 receive path
Message-ID: <20210514095730.GA30441@breakpoint.cc>
References: <20210511133659.29982-1-fw@strlen.de>
 <20210511133659.29982-2-fw@strlen.de>
 <83bc7a0dc52a0f362489067babfbbb5c4bd083e6.camel@redhat.com>
 <20210512100413.GJ4038@breakpoint.cc>
 <e5bad85c6b9d560f30f094a1b55fa4e901170931.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5bad85c6b9d560f30f094a1b55fa4e901170931.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> On Wed, 2021-05-12 at 12:04 +0200, Florian Westphal wrote:
> > Paolo Abeni <pabeni@redhat.com> wrote:
> > > On Tue, 2021-05-11 at 15:36 +0200, Florian Westphal wrote:
> > > > +	if (sk_can_busy_loop(sk) &&
> > > > +	    skb_queue_empty_lockless(&msk->receive_queue) &&
> > > > +	    skb_queue_empty_lockless(&sk->sk_receive_queue) &&
> > > > +	    inet_sk_state_load(sk) == TCP_ESTABLISHED)
> > > > +		sk_busy_loop(sk, nonblock);
> > > 
> > > If I understand the code correctly, here we need a valid sk-
> > > > sk_napi_id. That field is set by the TCP input path
> > > in tcp_finish_connect()/tcp_v{4,6}_do_rcv()/tcp_child_process() for the
> > > subflow ssk.
> > > 
> > > I think sk_napi_id is not currently available for the msk?!? 
> > > Copying it from the subflow requires some care, as the msk could end-up 
> > > busy polling on the 'wrong' napi instance ?!?
> > 
> > What about:
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -303,6 +303,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
> >  		if (tail && mptcp_try_coalesce(sk, tail, skb))
> >  			return true;
> >  
> > +		sk_mark_napi_id_once(sk, skb);
> >  		skb_set_owner_r(skb, sk);
> >  		__skb_queue_tail(&sk->sk_receive_queue, skb);
> >  		return true;
> > 
> > This sets the napi id to one that provided the last mptcp-in-sequence skb.
> 
> I *think* the above sets napi it to the one provided by the first
> received skb.

Depends on wheter the receive queue is empty or not.

Its the most recent subflow that had activity.

> What about something as crazy as the following? not even build tested,
> but I hope it can illustrate the idea bettern than words.

I'm no longer convicend busypolling makes any sense with mptcp sockets,
see below.

> +	for (;;) {
> +		int nr, napi_id = napi_id_by_subflow_nr(sk, 0);
> +
> +		for (nr = 0; napi_id >= 0 ; napi_id = napi_id_by_subflow_nr(sk, ++nr)) }
> +			napi_busy_loop(napi_id, NULL, NULL,
> +			       READ_ONCE(sk->sk_prefer_busy_poll),
> +			       READ_ONCE(sk->sk_busy_poll_budget) ?: BUSY_POLL_BUDGET);
> +			if (skb_queue_empty_lockless(&sk->sk_receive_queue))
> +				return;

We would need a new conditional to early-terminate the busypoll loop.

Else we might be busypolling on napi instance 1 while another instance
just made a packet available.

Futhermore, we'd have to divide the budget among the napi instances to
avoid excess usage.

The way I see it busypoll should never increase latency, but with the
above, afaics, it would since we don't have a 1:1 mapping of mptcp
socket to a napi instance that we expect packets on.

The way I see it there are two options:
1. Ignore buyspoll requests, or.
2. Set the napi instance ID from __mptcp_move_skb().
   As soon as the instance changes (anoter subflow on different path),
   disable busypoll for that mptcp socket.

1) is simpler, 2) would still support busypoll for fallback mode and
for '1 flow' resp. 'multiple flows on same napi instance'.

The latter could happen if we assume server with single
link that serves clients with multiple uplinks.
