Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D482F80
	for <mptcp@lists.linux.dev>; Mon,  7 Jun 2021 11:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623064308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rbb7M7tTG8VE9ui9ZRO99omdWJQUgTHi2wD812VsKrM=;
	b=BUFfylG4dYp0WSiP3X9m0k0qQ+Ik+SPzaHA+PhzYm19SIXND8jPba2zx8rVTF/xrwA0I77
	bYXfIO14SCkOdTI+r2xEtZJnWYHDRtWhA47fXEY++CQBuKmLrzMNbmOTA0IiUoQzBawbpZ
	QjU8gGczEUwdGKqlCTi8Zop77Yk+rzA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-9j5OtyKHNKC1q9QNwfsF8g-1; Mon, 07 Jun 2021 07:11:44 -0400
X-MC-Unique: 9j5OtyKHNKC1q9QNwfsF8g-1
Received: by mail-wr1-f72.google.com with SMTP id s8-20020adff8080000b0290114e1eeb8c6so7693978wrp.23
        for <mptcp@lists.linux.dev>; Mon, 07 Jun 2021 04:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Rbb7M7tTG8VE9ui9ZRO99omdWJQUgTHi2wD812VsKrM=;
        b=UJTcJcbBQRHxd85GiDKDy+JAG9t+A5qpLZqj7ZgkI6XRsT2DWeOtOENTHYvUzcfdVo
         Hv8orMDRD5quG5Ay6QWiZyzHjvDHaIjw1h4nuJUb/pOp61KJQhmRNC+IciQYt+tEFqfS
         MuqwjdAUYOMOu/cFEeI6NoMJVYFhzm8USMMHKPzZLYofh3y7SlrcKIBUvVvb09sJ9Yxi
         wTd5T+U9ARMuCwUSIhrMsvegpoZX7jEXzKGWxH4x0T7mE6nWnKxxDyyIH/NZnQp35mDS
         jqKYt713rrTZMsIOnGDENujI0LzFwbSgF9mxrVX5XRL0e8jDrU+6xZpge+5sgFN2iemR
         h7qw==
X-Gm-Message-State: AOAM530c7iwMJRp4pXw/YDKn5/CZpCWGXqfYKXT+2tSewdtwJJdIXrO3
	upi3NYzKMfKlNG1NbXOHPlOEBGfpp9d5ioTe9v6mzwPpAhy238iXBG/mbJKf/S694ny8aSsCcwA
	XGmtv/2jVxWuOUCQ=
X-Received: by 2002:a05:600c:3586:: with SMTP id p6mr7695838wmq.28.1623064303727;
        Mon, 07 Jun 2021 04:11:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsSmhaRTHh9LcFw4IBhDzf3wvIhEK9hg7n+DhsgpHBSLByZZ2Rrdqwd1GHJJjWI67FanshFw==
X-Received: by 2002:a05:600c:3586:: with SMTP id p6mr7695822wmq.28.1623064303553;
        Mon, 07 Jun 2021 04:11:43 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-110-123.dyn.eolo.it. [146.241.110.123])
        by smtp.gmail.com with ESMTPSA id j9sm11562076wrs.49.2021.06.07.04.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:11:43 -0700 (PDT)
Message-ID: <b2006bfe993504c4eb6a8c32b80c50bed831b9e2.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: refine mptcp_cleanup_rbuf
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Mon, 07 Jun 2021 13:11:42 +0200
In-Reply-To: <26fba154-61e9-dbdf-f898-84c845474d0@linux.intel.com>
References: <ed4e9f7d165ec01c45b9f9b9d0a11dab5a17dcdd.1622824500.git.pabeni@redhat.com>
	 <26fba154-61e9-dbdf-f898-84c845474d0@linux.intel.com>
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

On Fri, 2021-06-04 at 14:29 -0700, Mat Martineau wrote:
> On Fri, 4 Jun 2021, Paolo Abeni wrote:
> 
> > The current cleanup rbuf tries a bit too hard to avoid acquiring
> > the subflow socket lock. We may end-up delaying the needed ack,
> > or skip acking a blocked subflow.
> > 
> > Address the above extending the conditions used to trigger the cleanup
> > to reflect more closely what TCP does and invoking tcp_cleanup_rbuf()
> > on all the active subflows.
> > 
> > Note that we can't replicate the exact tests implemented in
> > tcp_cleanup_rbuf(), as MPTCP lacks some of the required info - e.g.
> > ping-pong mode.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > This addresses the low tput I mesured in tests where BHs and U/S
> > processes runs on the same CPU, see scenario 4) in:
> > 
> > https://lore.kernel.org/mptcp/9af85be18465b0f9595459764013568456453ce9.camel@redhat.com/
> > 
> > notes:
> > 
> > -  this does not fix completely:
> > 
> > https://github.com/multipath-tcp/mptcp_net-next/issues/137
> > 
> > but figures are now more stable.
> > 
> > - while perfing all the above spotted:
> > 
> > https://github.com/multipath-tcp/mptcp_net-next/issues/200
> > 
> > which is bad!
> > 
> > ---
> > net/mptcp/protocol.c | 44 ++++++++++++++++----------------------------
> > net/mptcp/protocol.h |  1 -
> > 2 files changed, 16 insertions(+), 29 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index f9fd905d2d3b..40e97dd6c09f 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -457,34 +457,29 @@ static bool mptcp_subflow_cleanup_rbuf(struct sock *ssk)
> > 
> > static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
> > {
> > -	struct sock *ack_hint = READ_ONCE(msk->ack_hint);
> > 	int old_space = READ_ONCE(msk->old_wspace);
> > 	struct mptcp_subflow_context *subflow;
> > 	struct sock *sk = (struct sock *)msk;
> > -	bool cleanup;
> > +	int space =  __mptcp_space(sk);
> > +	bool cleanup, rx_empty;
> > 
> > -	/* this is a simple superset of what tcp_cleanup_rbuf() implements
> > -	 * so that we don't have to acquire the ssk socket lock most of the time
> > -	 * to do actually nothing
> > -	 */
> > -	cleanup = __mptcp_space(sk) - old_space >= max(0, old_space);
> > -	if (!cleanup)
> > -		return;
> > +	cleanup = (space > 0) && (space >= (old_space << 1));
> > +	rx_empty = !atomic_read(&sk->sk_rmem_alloc);
> > 
> > -	/* if the hinted ssk is still active, try to use it */
> > -	if (likely(ack_hint)) {
> > -		mptcp_for_each_subflow(msk, subflow) {
> > -			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> > +	mptcp_for_each_subflow(msk, subflow) {
> > +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> > +		const struct inet_connection_sock *icsk;
> > +		const struct tcp_sock *tp = tcp_sk(sk);
> > 
> > -			if (ack_hint == ssk && mptcp_subflow_cleanup_rbuf(ssk))
> > -				return;
> > -		}
> > +		icsk = inet_csk(ssk);
> > +		if (cleanup ||
> > +		    (inet_csk_ack_scheduled(sk) &&
> 
> Is this intended to check sk or ssk?        ^^
> 
> It doesn't look like icsk_ack.pending is ever updated for the mptcp sock, 
> which makes me think 'ssk' was the intent. If that's the case, note that 
> the inet_csk_ack_scheduled() helper doesn't use READ_ONCE().

Thanks for catching this! Indeed, should be 'ssk'.

I intentionally omitted the READ_ONCE() to avoid open-
coding inet_csk_ack_scheduled(). Still there is already a READ_ONCE()
for the relevant field just after, so better opt for the safer way.

I'll cook a v2.

/P

