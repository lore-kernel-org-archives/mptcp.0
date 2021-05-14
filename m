Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F9370
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 10:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620988564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AwDFH3jUNx5MWuqKtd/HwIaOU6F9khuHvf7jxlZvYsY=;
	b=ei4iID+qsFWeaTM/n3XlN6sSyAtaYF7kCMEw9wTFLjwXOmkJsUuovXg+9lsETJpCrQ8/6S
	bSKdxe1TwWtmg425TfmlOFdTbV+5DWgxS4R0Zx5NeVI7YVkLPG7t5E/TTtaQ5jVPeN2pWN
	Z90D5fEdTUuBnD/im5yOq7isBH499Cg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-btgsy265OaOKAWoOBZCYbw-1; Fri, 14 May 2021 06:36:01 -0400
X-MC-Unique: btgsy265OaOKAWoOBZCYbw-1
Received: by mail-wr1-f72.google.com with SMTP id 7-20020adf95070000b02901104ad3ef04so844413wrs.16
        for <mptcp@lists.linux.dev>; Fri, 14 May 2021 03:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=AwDFH3jUNx5MWuqKtd/HwIaOU6F9khuHvf7jxlZvYsY=;
        b=M7D6VzBqRvosJc95NodOe9Ei5cSLf7kIajXlC/dJlUrMRb5hrYmkFhaF/I0zKYVKW8
         U06d8as3HTW3CqXpDCzGyTSwismGV22Yk1o8UHNqxJwOx2xV6iY7dFIN1lO/NI+j8CVx
         0SVVeOTgzqLCXf1nDmhBbwvOdEOLEiK1OfN+o46cWwAzS3AbMwAnhI3B8TFfKZCjP6St
         rCJPDJA8JSky9M0ZxcMKNW4E1RZZ/HPGrAzrPTB2Qj5uhxSdDSR1Jt79vpATZp5plrv7
         P2Jjkw1Bcy+IHzS3DI7f+6HuvseEJ4ySBpEkisIgEbp6NuJpKjj4DmpI6wQjlWdZjxjO
         CahA==
X-Gm-Message-State: AOAM533JEqst7thVhyeJGBLUmsqGof2Adb9yPPa6erpYCwAyC8i1p5kA
	PQY78Ph2zHlnLoSV+YGB28S6yPTlTUuT4H07s96FWmJxj4KCu15mjVeDQSWhEFNXKw8nzxwog74
	XzZHKytcAUoccf+E=
X-Received: by 2002:adf:ce02:: with SMTP id p2mr6344135wrn.156.1620988559100;
        Fri, 14 May 2021 03:35:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlBOIShGZPM+/leTCPxR/z7cbfELrC1Mk30zXKAbih4kdArC6YgPX59EHeKS9busWVaBHrBA==
X-Received: by 2002:adf:ce02:: with SMTP id p2mr6344112wrn.156.1620988558756;
        Fri, 14 May 2021 03:35:58 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-238-255.dyn.eolo.it. [146.241.238.255])
        by smtp.gmail.com with ESMTPSA id t17sm6215847wrx.40.2021.05.14.03.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 03:35:58 -0700 (PDT)
Message-ID: <c5a5f4c6d85180665fcead4634c9af0fa52fdff0.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next 1/8] mptcp: enable busypoll from mptcp
 receive path
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Date: Fri, 14 May 2021 12:35:57 +0200
In-Reply-To: <20210514095730.GA30441@breakpoint.cc>
References: <20210511133659.29982-1-fw@strlen.de>
	 <20210511133659.29982-2-fw@strlen.de>
	 <83bc7a0dc52a0f362489067babfbbb5c4bd083e6.camel@redhat.com>
	 <20210512100413.GJ4038@breakpoint.cc>
	 <e5bad85c6b9d560f30f094a1b55fa4e901170931.camel@redhat.com>
	 <20210514095730.GA30441@breakpoint.cc>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2021-05-14 at 11:57 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
> > On Wed, 2021-05-12 at 12:04 +0200, Florian Westphal wrote:
> > > Paolo Abeni <pabeni@redhat.com> wrote:
> > > > On Tue, 2021-05-11 at 15:36 +0200, Florian Westphal wrote:
> > > > > +	if (sk_can_busy_loop(sk) &&
> > > > > +	    skb_queue_empty_lockless(&msk->receive_queue) &&
> > > > > +	    skb_queue_empty_lockless(&sk->sk_receive_queue) &&
> > > > > +	    inet_sk_state_load(sk) == TCP_ESTABLISHED)
> > > > > +		sk_busy_loop(sk, nonblock);
> > > > 
> > > > If I understand the code correctly, here we need a valid sk-
> > > > > sk_napi_id. That field is set by the TCP input path
> > > > in tcp_finish_connect()/tcp_v{4,6}_do_rcv()/tcp_child_process() for the
> > > > subflow ssk.
> > > > 
> > > > I think sk_napi_id is not currently available for the msk?!? 
> > > > Copying it from the subflow requires some care, as the msk could end-up 
> > > > busy polling on the 'wrong' napi instance ?!?
> > > 
> > > What about:
> > > 
> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -303,6 +303,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
> > >  		if (tail && mptcp_try_coalesce(sk, tail, skb))
> > >  			return true;
> > >  
> > > +		sk_mark_napi_id_once(sk, skb);
> > >  		skb_set_owner_r(skb, sk);
> > >  		__skb_queue_tail(&sk->sk_receive_queue, skb);
> > >  		return true;
> > > 
> > > This sets the napi id to one that provided the last mptcp-in-sequence skb.
> > 
> > I *think* the above sets napi it to the one provided by the first
> > received skb.
> 
> Depends on wheter the receive queue is empty or not.
> 
> Its the most recent subflow that had activity.

I mean: sk_mark_napi_id_once() is called on the most recent subflow
that had activity, but AFAICS it only sets sk->sk_napi_id - the msk
napi id, in this case - if the current value is 0 - that is, if such
field has not been intialized yet.

> > +	for (;;) {
> > +		int nr, napi_id = napi_id_by_subflow_nr(sk, 0);
> > +
> > +		for (nr = 0; napi_id >= 0 ; napi_id = napi_id_by_subflow_nr(sk, ++nr)) }
> > +			napi_busy_loop(napi_id, NULL, NULL,
> > +			       READ_ONCE(sk->sk_prefer_busy_poll),
> > +			       READ_ONCE(sk->sk_busy_poll_budget) ?: BUSY_POLL_BUDGET);
> > +			if (skb_queue_empty_lockless(&sk->sk_receive_queue))
> > +				return;
> 
> We would need a new conditional to early-terminate the busypoll loop.
> 
> Else we might be busypolling on napi instance 1 while another instance
> just made a packet available.
> 
> Futhermore, we'd have to divide the budget among the napi instances to
> avoid excess usage.

With the above code, in the inner looop, we will do a single ->poll()
invocation on each napi_id: passing a NULL 'loop_end' argument
to napi_busy_loop() causes the latter to do a single poll invocation.

That should also produce fair budget usage.

> The way I see it busypoll should never increase latency, but with the
> above, afaics, it would since we don't have a 1:1 mapping of mptcp
> socket to a napi instance that we expect packets on.

We will have a N:1 mapping (where N is the number of subflows using the
code above and could be "optimized" to the number of different napi_id
in use by such subflows with the changes discussed in the last part of
my previous email).

But still should not introuce additional latency. If e.g. we are
polling on napi_id_1 and packets arrive on napi id_2, since the msk
socket lock is not held, the rx subflow input path will deliver them to
the msk receive queue and the:

	'if (skb_queue_empty_lockless(&sk->sk_receive_queue))'

check will terminate the loop as soon as polling no napi_id_1
completes.

Well, that could actually introduce some latency, e.g. if napi_id_1 is
under heavy traffic sent from some different peer. Not 110% sure
anyway: BP reduce lantency mostly by avoiding tripping on the process
scheduler, and we will get that part right.

Assuming this later consideration is correct, we could eventually
consider always doing busy polling on a single napi instance (belonging
to an active, non backup subflow) even in presence of multiple active
subflows, and that should still reduce latency.

I guess a little experimentation will help ;) 

> The way I see it there are two options:
> 1. Ignore buyspoll requests, or.
> 2. Set the napi instance ID from __mptcp_move_skb().
>    As soon as the instance changes (anoter subflow on different path),
>    disable busypoll for that mptcp socket.
> 
> 1) is simpler, 2) would still support busypoll for fallback mode and
> for '1 flow' resp. 'multiple flows on same napi instance'.

Both sound reasonable

> The latter could happen if we assume server with single
> link that serves clients with multiple uplinks.

... and such link/NIC has a single napi instance, which is quite
uncommon on server H/W, I think.

I'm open to any option. 

Could you please review the above obove stuff regarding multiple napis
BP? does that make any sense?

Thanks!

Paolo

