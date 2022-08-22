Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A4E7FA
	for <mptcp@lists.linux.dev>; Mon, 22 Aug 2022 11:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661166134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rUVJVipDKbJrjb71F79QDSLH2qI5Nc48jzw0AKHiGwA=;
	b=GLA4x1E+lSuSy0oTTFk3wfESWCzHmkyjdmpR4zdFpJSniOpy3U8l9qj3kIGaavmMZcJpil
	Le8aPLwxSFjy9FdMAQCXavPS6I6ldhsLr9F4pGoSFc2g6q158eTPzV/GzuE+I4OEhJv+lC
	Q9dOzVbLnUcLByBThl1ynT9w6WmlLSw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-479-stWVFw4qMGKoyh4HSOl74w-1; Mon, 22 Aug 2022 07:02:13 -0400
X-MC-Unique: stWVFw4qMGKoyh4HSOl74w-1
Received: by mail-wm1-f71.google.com with SMTP id b16-20020a05600c4e1000b003a5a47762c3so6250250wmq.9
        for <mptcp@lists.linux.dev>; Mon, 22 Aug 2022 04:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc;
        bh=rUVJVipDKbJrjb71F79QDSLH2qI5Nc48jzw0AKHiGwA=;
        b=SlHhEFcc32A9UFhTzKJlnp0gZoPImlUWQD5sBj/lXuZSNhLte1yMV6IdpQyTBIuno6
         Joz5MXyo4JkZzsA94kcN203pOPh3h9+lxABUQ/AYmIgpQEYWuptSJy0H+8EWpaJJC2d5
         uHrp4knzacXLucqgLFAC8qpjdB9Y/WLlZQJLoKHjpholVDIn1vX8LTYiLwCbtZKlxH8L
         hVPy6LKgwH2PMa1wBQk6iTCcNANZIFzB+1Xlr3e0FSnRbrtVPtQSu/P36Ez7fwa8Lo6b
         w7IM2LQt1xuSCuNWlZY4+4fSUnrS2hOLdiWPrM/js9RzkA0EDFvmb5kcmZT9WaO3DUw6
         JebQ==
X-Gm-Message-State: ACgBeo38z3x5OcHRLUZAa+wESkl2W/PU9CBAcn9DqSIbeA1KpgWoQZ4Y
	hUzA83o3mvdyVt2qCgO6GoGtykk1B/K3gD9HCK2CchQxl1Tq0B2UsQZSTGK5HiisZPVtVrrWT+N
	HNeNqTVsfzuNyIXk=
X-Received: by 2002:a05:600c:25ce:b0:3a5:a3b7:bbfe with SMTP id 14-20020a05600c25ce00b003a5a3b7bbfemr15503364wml.115.1661166131967;
        Mon, 22 Aug 2022 04:02:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Ai2Zvu6863IpYentaaiov2bXNXztUuCFobPdRquGhyOZEJUHJBYxorN4jpHUtaE+McCD1Og==
X-Received: by 2002:a05:600c:25ce:b0:3a5:a3b7:bbfe with SMTP id 14-20020a05600c25ce00b003a5a3b7bbfemr15503341wml.115.1661166131572;
        Mon, 22 Aug 2022 04:02:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-176.dyn.eolo.it. [146.241.97.176])
        by smtp.gmail.com with ESMTPSA id c188-20020a1c35c5000000b003a5f4fccd4asm17436931wma.35.2022.08.22.04.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 04:02:11 -0700 (PDT)
Message-ID: <09c08d1262325db726f2d3d2d6e4efd351612a87.camel@redhat.com>
Subject: Re: [PATCH RFC mptcp] net: tcp: prevent transition to FIN_WAIT2
 when mptcp has unacked data_fin
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Date: Mon, 22 Aug 2022 13:02:10 +0200
In-Reply-To: <20220818162123.30198-1-fw@strlen.de>
References: <20220818162123.30198-1-fw@strlen.de>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2022-08-18 at 18:21 +0200, Florian Westphal wrote:
> When an mptcp connection closes down, a MPTCP-level DATA_FIN (flag in mp tcp
> options) is sent.
> 
> We should wait until we can be sure the peer has received the mptcp-level ack of
> that DATA_FIN.  Else, we can end up with the last mptcp subflow in FIN_WAIT2 state.
> 
> In that state, TCP won't respond to incoming ACK anymore, because no
> progress happens from TCP point of view.
> 
> mptcp-packetdrill example:
> 
> // MPTCP sk moves to FIN_WAIT1, subflow remains in ESTABLISHED state:
> +0.5   close(4) = 0
> +0.0   >   .  2:2(0)  ack 1  win 256    <dss dack4=1 dsn8=2 ssn=0 dll=1 nocs fin, nop, nop>
> 
> // receive DATA_FIN ack. MPTCP sk moves to FIN_WAIT2, subflow remains in ESTABLISHED state.
> +0.0  <  .  1:1(0)  ack 2  win 450    <dss dack4=3 dsn8=1 ssn=0 dll=0 nocs, nop, nop>
> 
> // Receive DATA_FIN.  MPTCP socket is removed, subflow sk moves to FIN_WAIT1.
> +0.0  <  .  1:1(0)  ack 2  win 450    <dss dack4=3 dsn8=1 ssn=0 dll=1 nocs fin, nop, nop>
> 
> // acks the clients DATA_FIN, but packet might get lost
> +0  >  .  2:2(0)  ack 1  win 256	<dss dack4=2 nocs>
> 
> // Receive DATA_FIN retransmission, subflow still in TCP_FIN1 state.
> +0.01  <  .  1:1(0)  ack 1 win 450    <dss dack4=2 dsn8=1 ssn=0 dll=1 nocs fin, nop, nop>
> 
> +0  >  F.  2:2(0)  ack 1  win 256     <dss dack4=2 nocs>
> 
> // Ack the tcp-level fin but also retransmit the data fin.
> // Note that we still claim mptcp-level dack4=2, i.e. the
> // servers DATA_FIN remains unacked.
> 
> // Without this change, this 'ack 3' moves the subflow to FIN_WAIT2 state.
> +0.0  < .  2:2(0)  ack 3 win 450    <dss dack4=2 dsn8=1 ssn=0 dll=1 nocs fin, nop, nop>
>
> +0 > . 3:3(0) ack 1 win 256 <dss dack4=2 nocs>
> 
> // receive another retransmit of data fin...
> +0.0  < .  2:2(0)  ack 3 win 450    <dss dack4=2 dsn8=1 ssn=0 dll=1 nocs fin, nop, nop>
> 
> // ... but without this patch, nothing happens, TW sk won't send anything.
> // With this patch, the subflow remains in FIN_WAIT1 and replies with a DSS ack.
> +0 > . 3:3(0) ack 1 win 256 <dss dack4=2 nocs>
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/181
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  include/net/mptcp.h  | 4 ++++
>  net/ipv4/tcp_input.c | 5 +++++
>  net/mptcp/subflow.c  | 8 ++++++++
>  3 files changed, 17 insertions(+)
> 
> Full test case stashed here for the time being:
> https://github.com/fw-strlen/packetdrill/commit/60a3f57ea309f910643e06dbf123236741c7f8d9
> 
> Its possible to either change tw_sk to have enough mptcp context to be
> able to send a packet back, or we can supress/delay the tw_sock
> transition.  This is what classic TCP is doing when it receives another
> FIN while in FIN1 state.
> 
> This change makes the test case work (another dss ack is sent), but
> there may be other corner cases where we need to delay the sk ->
> tw_sk transition.
> 
> If the general idea looks ok, perhaps its better to replace
> 
> tcp_time_wait(sk, skb, ..
> 
> with a mptcp aware helper, e.g.  tcp_time_wait_check(sk, skb, ..
> and place the option parsing for mptcp-subflows there?

_if_ (big if) I read correctly, this patch "always" (most common
shutdown sequence should match the condition checked here, right?)
delay the tw_sk transiction for mptcp sockets, keeping alive the whole
mptcp and subflow socks for a ??? timeout. Is that correct?

If so, and the mptcp_tw socket is not too invasive (again, big if), I
think implementing the mptcp_tw could be better: a busy server could
keep a lot of memory around for the shutting-down-socks.

I think the mptcp_tw will not need a reference to the mptcp sock, it
just need to know the mptcp-level data_fin seq to be acked. I guess it
will likely require 3 hooks: in tcp_time_wait() to fill the
data_fin_ack info and in tcp_v4_send_ack()/tcp_v6_send_response() to
fill the TCP options accordingly

> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 02ca83493470..de2249996671 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -152,6 +152,8 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
>  
>  void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info);
>  
> +bool mptcp_subflow_pending_data_fin_ack(const struct sock *ssk);
> +
>  /* move the skb extension owership, with the assumption that 'to' is
>   * newly allocated
>   */
> @@ -297,6 +299,8 @@ static inline int mptcp_subflow_init_cookie_req(struct request_sock *req,
>  }
>  
>  static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
> +
> +static inline bool mptcp_subflow_pending_data_fin_ack(const struct sock *ssk) { return false; }
>  #endif /* CONFIG_MPTCP */
>  
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index ab5f0ea166f1..c3281e0cf9db 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6608,6 +6608,11 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
>  			 * marginal case.
>  			 */
>  			inet_csk_reset_keepalive_timer(sk, tmo);
> +		} else if (sk_is_mptcp(sk) &&
> +			   mptcp_incoming_options(sk, skb) &&
> +			   mptcp_subflow_pending_data_fin_ack(sk)) {

Possibly ENOCOFFEE here, but could the above 2 function being replaced
by checking if the incoming packet carries a data_fin option?

(not sure if worthy and its very subjective, it "sounds" a little bit
clearer to me)

> +				inet_csk_schedule_ack(sk);

Why we explcitly need to schedule the ack, and the plain TCP-fin case
does not need it?

Cheers,

Paolo

