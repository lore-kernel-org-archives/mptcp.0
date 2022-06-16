Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ECF7A
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 07:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655363476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gdmj169Eh8JQ3UReALwwUF7dSpn7faHOX+Ia7TVr360=;
	b=Q4uqnlr3DL9W+UJZNlDpeT/oohsjuC3QrpMak1LVo3HpAjhhxVh/4Lugo1d00eJ5CnOMo0
	nQf9W53UIq378sgToQY0ek9BDLOmIUB3457HcErPO2MT7ZDhm0HXdVi98VvimDHdFGTCFK
	77YOea8UV/smKCzdKIutkrtmPQswj5g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-X8wny8mFMzyJXo0kyFcG7g-1; Thu, 16 Jun 2022 03:11:15 -0400
X-MC-Unique: X8wny8mFMzyJXo0kyFcG7g-1
Received: by mail-qk1-f198.google.com with SMTP id az18-20020a05620a171200b006a708307e94so796008qkb.14
        for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 00:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Gdmj169Eh8JQ3UReALwwUF7dSpn7faHOX+Ia7TVr360=;
        b=S8JA6SB8No9UOgqWUkZyqopI97VbVVY5mAAu0LhXuhPO+mqpYYyLcWxUOPrVR5j+vq
         HT3Ygug/vVNKLpC0uVeFC0iS0FO1EHcnvkHtsE+3tn1Jw0s3qmKFl89tV1lDb1NA96md
         OD7alCUSe6tUO4rEvplOqJG45SQcv5g5zmaqrGR3Gmd1OTbfRqKOToUJgZzVn5rfvTHz
         xX/24dzYW/9MW3kNnqjXw+Fwsl2PEeUPbJuEqtLe1FyPQ8C8H2cYf8JoCwv1ZnbSSWBc
         RO3FJ1ktI58DKXIKLSz0npGxpz5jfQOecdTgP8byoX7JLPQvGXCgZQjrxf647PJOmKbc
         QY2w==
X-Gm-Message-State: AJIora/7WjbTK9HVj3+M+29cv+aQIwfBnH7LJ45tm32GVgNJyfSax+1r
	ELZniqTz9mis1DPftJaBEOn9rrR3DpNLb+bsrGCECT8Q1x2hHjZhxUFr7/ocz5JQCUYT3h/Yy0Y
	ej1LBHvIMjt/s9NQ=
X-Received: by 2002:a05:622a:11d6:b0:306:6ec2:7a4f with SMTP id n22-20020a05622a11d600b003066ec27a4fmr2813683qtk.336.1655363474485;
        Thu, 16 Jun 2022 00:11:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sEJQHqkzAZPjzWCuK0afqnkA+xZx4WpwZjC7yVOz1TEIvb8ytEyCKnbyWmb/AQJHS6DLUkQw==
X-Received: by 2002:a05:622a:11d6:b0:306:6ec2:7a4f with SMTP id n22-20020a05622a11d600b003066ec27a4fmr2813668qtk.336.1655363474115;
        Thu, 16 Jun 2022 00:11:14 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-202.dyn.eolo.it. [146.241.113.202])
        by smtp.gmail.com with ESMTPSA id bk23-20020a05620a1a1700b006a711bb74b6sm1172849qkb.87.2022.06.16.00.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 00:11:13 -0700 (PDT)
Message-ID: <0eaffe68b6ffa6ad0465e8f0ec85e896a8a49d7b.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v2 3/6] Squash-to: "mptcp: invoke MP_FAIL
 response when needed"
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Thu, 16 Jun 2022 09:11:11 +0200
In-Reply-To: <58c2377-cc90-7f55-9aa5-1a9d6578fd8a@linux.intel.com>
References: <cover.1655324843.git.pabeni@redhat.com>
	 <1deca06703f8666dc199b76f39cd881733741666.1655324843.git.pabeni@redhat.com>
	 <58c2377-cc90-7f55-9aa5-1a9d6578fd8a@linux.intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
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
Content-Transfer-Encoding: 8bit

On Wed, 2022-06-15 at 17:59 -0700, Mat Martineau wrote:
> On Wed, 15 Jun 2022, Paolo Abeni wrote:
> 
> > This tries to address a few issues outstanding in the mentioned
> > patch:
> > - we explicitly need to reset the timeout timer for mp_fail's sake
> > - we need to explicitly generate a tcp ack for mp_fail, otherwise
> >  there are no guarantees for suck option being sent out
> > - the timeout timer needs handling need some caring, as it's still
> >  shared between mp_fail and msk socket timeout.
> > - we can re-use msk->first for msk->fail_ssk, as only the first/mpc
> >  subflow can fail without reset. That additionally avoid the need
> >  to clear fail_ssk on the relevant subflow close.
> > - fail_tout would need some additional annotation. Just to be on the
> >  safe side move its manipulaiton under the ssk socket lock.
> > 
> > Last 2 paragraph of the squash to commit should be replaced with:
> > 
> > """
> > It leverages the fact that only the MPC/first subflow can gracefully
> > fail to avoid unneeded subflows traversal: the failing subflow can
> > be only msk->first.
> > 
> > A new 'fail_tout' field is added to the subflow context to record the
> > MP_FAIL response timeout and use such field to reliably share the
> > timeout timer between the MP_FAIL event and the MPTCP socket close timeout.
> > 
> > Finally, a new ack is generated to send out MP_FAIL notification as soon
> > as we hit the relevant condition, instead of waiting a possibly unbound
> > time for the next data packet.
> > """
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/pm.c       |  4 +++-
> > net/mptcp/protocol.c | 54 ++++++++++++++++++++++++++++++++++++--------
> > net/mptcp/protocol.h |  4 ++--
> > net/mptcp/subflow.c  | 24 ++++++++++++++++++--
> > 4 files changed, 72 insertions(+), 14 deletions(-)
> > 
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index 3c7f07bb124e..45e2a48397b9 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -305,13 +305,15 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> > 	if (!READ_ONCE(msk->allow_infinite_fallback))
> > 		return;
> > 
> > -	if (!msk->fail_ssk) {
> > +	if (!subflow->fail_tout) {
> > 		pr_debug("send MP_FAIL response and infinite map");
> > 
> > 		subflow->send_mp_fail = 1;
> > 		subflow->send_infinite_map = 1;
> > +		tcp_send_ack(sk);
> > 	} else {
> > 		pr_debug("MP_FAIL response received");
> > +		WRITE_ONCE(subflow->fail_tout, 0);
> > 	}
> > }
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index a0f9f3831509..50026b8da625 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -500,7 +500,7 @@ static void mptcp_set_timeout(struct sock *sk)
> > 	__mptcp_set_timeout(sk, tout);
> > }
> > 
> > -static bool tcp_can_send_ack(const struct sock *ssk)
> > +static inline bool tcp_can_send_ack(const struct sock *ssk)
> > {
> > 	return !((1 << inet_sk_state_load(ssk)) &
> > 	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
> > @@ -2490,24 +2490,56 @@ static void __mptcp_retrans(struct sock *sk)
> > 		mptcp_reset_timer(sk);
> > }
> > 
> > +/* schedule the timeout timer for the nearest relevant event: either
> > + * close timeout or mp_fail timeout. Both of them could be not
> > + * scheduled yet
> > + */
> > +void mptcp_reset_timeout(struct mptcp_sock *msk, unsigned long fail_tout)
> > +{
> > +	struct sock *sk = (struct sock *)msk;
> > +	unsigned long timeout, close_timeout;
> > +
> > +	if (!fail_tout && !sock_flag(sk, SOCK_DEAD))
> > +		return;
> > +
> > +	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies + TCP_TIMEWAIT_LEN;
> > +
> > +	/* the following is basically time_min(close_timeout, fail_tout) */
> > +	if (!fail_tout)
> > +		timeout = close_timeout;
> > +	else if (!sock_flag(sk, SOCK_DEAD))
> > +		timeout = fail_tout;
> > +	else if (time_after(close_timeout, fail_tout))
> > +		timeout = fail_tout;
> > +	else
> > +		timeout = close_timeout;
> > +
> > +	sk_reset_timer(sk, &sk->sk_timer, timeout);
> > +}
> 
> Hi Paolo -
> 
> The above function seems more complex than needed. If mptcp_close() has 
> been called, the fail timeout should be considered canceled and the 
> "close" has exclusive use of sk_timer. subflow->fail_tout can be set to 0 
> and sk_timer can be set only based on TCP_TIMEWAIT_LEN.

I agree the above function is non trivial, on the flip side, it helps
keeping all the timeout logic in a single place.

Note that msk->first->fail_tout is under the subflow socket lock
protection, and this function is not always invoked under such lock, so
we will need to either add more read/write once annotation or split the
logic in the caller.

Side note: I agree a bit with David Laight wrt *_once preoliferation,
possibly with less divisive language: 

https://lore.kernel.org/netdev/cea2c2c39d0e4f27b2e75cdbc8fce09d@AcuMS.aculab.com/

;)

*_ONCE are a bit hard to track and difficult to verify formally, so I
tried hard to reduce their usage. Currently we have only a single READ
operation outside the relevant lock, which is AFAIK the 'safer'
possible scenario with such annotations. All the write operations are
under the subflow socket lock.

> TCP_RTO_MAX for the MP_FAIL timeout was kind of arbitrary - the spec 
> doesn't say what exactly to do. We didn't want the connection to be in the 
> "unacknowledged" MP_FAIL state forever, but also didn't want to give up 
> too fast.

This function don't make any assumption on the relative timeout length
and should fit the case if we will make them configurable someday

> Given that, do you think the complexity is justified to possibly reset the 
> subflow earlier in this "unacknowledged MP_FAIL followed by a close" 
> scenario?

IMHO yes ;) But if you have strong opinion otherwise I can refactor the
code...

Cheers,

Paolo

