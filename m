Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D4168
	for <mptcp@lists.linux.dev>; Tue,  2 Nov 2021 17:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635875810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqJSac3XBsxo4U0ulYjOhMfZm33s65KVrvwxdNRr1p8=;
	b=K4wk4PBJ2QKO6ICH+SlTjQIlr72xtrQ82ddgDgBO5Ok3B8md5oDjLevZB6Q9G/alF9uhs9
	RRMCKdLaAWmgxb+A3rrAuyQ6teIQF6R0xDwksYjpEETp/Kn/8BRkeKrOGcW9kt9D+e5cuE
	JWRclabRQlVOX5KCjg65v4ArowON/wU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-0E7Eb90zPeyLa9IwT0wkyQ-1; Tue, 02 Nov 2021 13:56:49 -0400
X-MC-Unique: 0E7Eb90zPeyLa9IwT0wkyQ-1
Received: by mail-ed1-f72.google.com with SMTP id t18-20020a056402021200b003db9e6b0e57so113041edv.10
        for <mptcp@lists.linux.dev>; Tue, 02 Nov 2021 10:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=qqJSac3XBsxo4U0ulYjOhMfZm33s65KVrvwxdNRr1p8=;
        b=rO3rBz2qYQdkXGzcGoCCxYGEHFGjlENBS6KwqnT409gaxtrbtSCjx7286bFr/McpDM
         n6MWjgz3w23mLe0f/bD2cUgkVzaFwgOOqB4Av80KproW6wb5rm5uCzqM4jUVHy2gxDEK
         wywI9ycOfCB/wi2o5Clod2X3ls7Eie2ZcETsh809JcvPKtwjb6WW5Jnz4LMcbTBfszww
         0KirzkKl4AOI3B8MejBJd+r4/0swGZSWPuJKDq4pKV/7ff8jnkWHf6UZ21XpdPOwxIeh
         AHykWC3YYP5aAIGVium88cbJ3QAryoWWNvFas6+NinnNLN5x3L/PH66auq6CluBdgkAa
         L+lg==
X-Gm-Message-State: AOAM530bG/USZYzT2AlyFuk2b5lOZrjbZaA87RInmrfHIctXiaxgZPAv
	xurvacy37S0NR7y5PAjWcdmRkgvGyo0qzgPkMtOoPDFYe67mmOZP80zJTMWTsY/gE9l3y6h1H1Q
	w1h4dHuixxw22qyA=
X-Received: by 2002:a17:907:1c03:: with SMTP id nc3mr33114945ejc.290.1635875808108;
        Tue, 02 Nov 2021 10:56:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzV8WJB2Viiu2y0mIR2ruwvNx3HOwlVyUaXl/PPetzy4KZHxF/mgj9F6aLb/lrEv1QnVno+9w==
X-Received: by 2002:a17:907:1c03:: with SMTP id nc3mr33114918ejc.290.1635875807807;
        Tue, 02 Nov 2021 10:56:47 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-236.dyn.eolo.it. [146.241.113.236])
        by smtp.gmail.com with ESMTPSA id dt4sm8584887ejb.27.2021.11.02.10.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 10:56:47 -0700 (PDT)
Message-ID: <add8d649ec371b5cc43d5ac92c55bd98839a7911.camel@redhat.com>
Subject: Re: [PATCH mptcp-net 2/2] mptcp: use delegate action to schedule
 3rd ack retrans
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp <mptcp@lists.linux.dev>
Date: Tue, 02 Nov 2021 18:56:46 +0100
In-Reply-To: <b3ce1954-ad3-71b6-92af-870e63f40c3@linux.intel.com>
References: <cover.1635426465.git.pabeni@redhat.com>
	 <2a28807616445b389496dc0f172e206180f5a099.1635426465.git.pabeni@redhat.com>
	 <b3ce1954-ad3-71b6-92af-870e63f40c3@linux.intel.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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
Content-Transfer-Encoding: 7bit

On Fri, 2021-10-29 at 16:36 -0700, Mat Martineau wrote:
> On Thu, 28 Oct 2021, Paolo Abeni wrote:
> 
> > Scheduling a delack in mptcp_established_options_mp() is
> > not a good idea: such function is called by tcp_send_ack() and
> > the pending delayed ack will be cleared shortly after by the
> > tcp_event_ack_sent() call in __tcp_transmit_skb().
> > 
> > Instead use the mptcp delegated action infrastructure to
> > schedule the delayed ack after the current bh processing completes.
> > 
> > Additionally moves the schedule_3rdack_retransmission() helper
> > into protocol.c to avoid making it visible in a different compilation
> > unit.
> > 
> > Fixes: ec3edaa7ca6ce02f ("mptcp: Add handling of outgoing MP_JOIN requests")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > side note:
> > Why we already see 3rd ack retransimssion in pcap traces even if the delack timer
> > was broken sice the beginning?!? I guess that is due to pure ack generated
> > by mptcp_recvmsg() and pushed on all the subflow. mptcp_send_ack() only
> > checks for the TCP status and not the MPTCP one. When landing on MPJ
> > subflows not already fully established, such data-ack will be converted in MPJ
> > 3rd ack by the MPTCP output path/out options building, as the MPJ option
> > has higher priority than DSS
> > ---
> > net/mptcp/options.c  | 33 ++++++++---------------------
> > net/mptcp/protocol.c | 50 ++++++++++++++++++++++++++++++++++++--------
> > net/mptcp/protocol.h | 17 ++++++++-------
> > 3 files changed, 59 insertions(+), 41 deletions(-)
> > 
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 465d4143d555..12ffee025373 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -422,29 +422,6 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
> > 	return false;
> > }
> > 
> > -/* MP_JOIN client subflow must wait for 4th ack before sending any data:
> > - * TCP can't schedule delack timer before the subflow is fully established.
> > - * MPTCP uses the delack timer to do 3rd ack retransmissions
> > - */
> > -static void schedule_3rdack_retransmission(struct sock *sk)
> > -{
> > -	struct inet_connection_sock *icsk = inet_csk(sk);
> > -	struct tcp_sock *tp = tcp_sk(sk);
> > -	unsigned long timeout;
> > -
> > -	/* reschedule with a timeout above RTT, as we must look only for drop */
> > -	if (tp->srtt_us)
> > -		timeout = usecs_to_jiffies(tp->srtt_us >> (3-1));
> > -	else
> > -		timeout = TCP_TIMEOUT_INIT;
> > -	timeout += jiffies;
> > -
> > -	WARN_ON_ONCE(icsk->icsk_ack.pending & ICSK_ACK_TIMER);
> > -	icsk->icsk_ack.pending |= ICSK_ACK_SCHED | ICSK_ACK_TIMER;
> > -	icsk->icsk_ack.timeout = timeout;
> > -	sk_reset_timer(sk, &icsk->icsk_delack_timer, timeout);
> > -}
> > -
> > static void clear_3rdack_retransmission(struct sock *sk)
> > {
> > 	struct inet_connection_sock *icsk = inet_csk(sk);
> > @@ -527,7 +504,15 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
> > 		*size = TCPOLEN_MPTCP_MPJ_ACK;
> > 		pr_debug("subflow=%p", subflow);
> > 
> > -		schedule_3rdack_retransmission(sk);
> > +		/* we can use the full delegate action helper only from BH context
> > +		 * If we are in process context - sk is flushing the backlog at
> > +		 * socket lock release time - just set the appropriate flag, will
> > +		 * be handled by the release callback
> > +		 */
> > +		if (sock_owned_by_user(sk))
> > +			set_bit(MPTCP_DELEGATE_SEND, &subflow->delegated_status);
> 
> I believe you intended MPTCP_DELEGATE_ACK here

Indeed! self-test did not catch the above because the mpj ssh is almost
never owned by user before being fully-acked (and generally speaking
every subflow has a very small probability of being owned by user)

I'll send a new version, thanks!

Paolo

