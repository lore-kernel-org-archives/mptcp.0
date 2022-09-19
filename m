Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26CB4A1F
	for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 11:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663585895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vO3HzUIVKqFX8w0yScEyFxmuGl4RDGqLt2LIPrGu8yA=;
	b=if63LIjvuptzSZp219q9VwnGhEX/5HEGJo8/fcnnnRJ/RHDOnoJ8HBlZFkvswuTN0mDyyb
	g/RtRxnwmsuJqgnK/tYnCcJFzMARGYu9Z7V9VKDgOASDWFeMAZITPUfDZzlY42KIUTu9g8
	UXqpv4XcKKM2WmjVZjP+C1v0lCQvh7Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-480-LAcAj05cOm25J7bNUhbv2Q-1; Mon, 19 Sep 2022 07:11:34 -0400
X-MC-Unique: LAcAj05cOm25J7bNUhbv2Q-1
Received: by mail-wm1-f71.google.com with SMTP id i132-20020a1c3b8a000000b003b339a8556eso5421282wma.4
        for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 04:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=vO3HzUIVKqFX8w0yScEyFxmuGl4RDGqLt2LIPrGu8yA=;
        b=mDqmt+OdsISPAsAeYSgtqw7PMMG11kh+Nq0/NhruqJZrEFNffGg1z8oktWlXz+lxwP
         pHhF4hoAxWBdH4mvhQfs77WwY5Xqs87Z1Bv6r8gDth4p9Dh455BK8k3oD+kaxzsNm7Wj
         AL4z/EyK1OVsnWznqJi6NnJDk3J06NiIQ0yk5PdHHh+JXXGhFRUa6wdv34A38oyLsY+X
         bfDUsFVBkH1UvETLgtb24jsyUPxOI42dNyKXJDutPfvhQRsei0zVr5HVQILA3CQ1y4dz
         /kDOgvfJF4vV9NbEE31doRjo+GQn/ZhE/vJ4ngemlcAAFlzEEOzrn5WN+HICKG48vmYe
         Y0Tw==
X-Gm-Message-State: ACrzQf25M/viOlHlOUjhthhoSPkXK8g0Tx9nQb9nCxwFKKQAWle8JTwr
	UzlU5gnILIgQgcPxWKDS+h4ZVqAze2r42wskz7+bD1BZ02n1SVfNuGN30YDh/XIioJsap7UcYA5
	H9jjfpl/L1sbZ0s4=
X-Received: by 2002:a5d:540d:0:b0:22a:4069:1e3e with SMTP id g13-20020a5d540d000000b0022a40691e3emr10283087wrv.239.1663585893252;
        Mon, 19 Sep 2022 04:11:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5hjgfHzTnu5ZwMCRCDE+uxKAkWvOryTVCRPqlz5H963yW10zqyr9KC3FOOgOI82gatuqurGg==
X-Received: by 2002:a5d:540d:0:b0:22a:4069:1e3e with SMTP id g13-20020a5d540d000000b0022a40691e3emr10283074wrv.239.1663585892908;
        Mon, 19 Sep 2022 04:11:32 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-90.dyn.eolo.it. [146.241.114.90])
        by smtp.gmail.com with ESMTPSA id r13-20020a5d4e4d000000b0022ae4f8395dsm8633078wrt.96.2022.09.19.04.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 04:11:32 -0700 (PDT)
Message-ID: <be427fe3457391b7b50af213c255d8fd1f3703c7.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v7 07/11] mptfo variables for msk,
 options. Fix loop retrans
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Mon, 19 Sep 2022 13:11:31 +0200
In-Reply-To: <20220917222853.2406-8-dmytro@shytyi.net>
References: <20220917222853.2406-1-dmytro@shytyi.net>
	 <20220917222853.2406-8-dmytro@shytyi.net>
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
Content-Transfer-Encoding: 8bit

On Sun, 2022-09-18 at 00:28 +0200, Dmytro Shytyi wrote:
> Introduce mptfo variables for msk and options.
> Also fixe the infinite retransmissions in the end of second session.
> Suggestion @palbeni (SEP 1) during the meting to 'look at ack'
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> ---
>  net/mptcp/fastopen.c | 16 ++++++++++++++++
>  net/mptcp/options.c  |  3 +++
>  net/mptcp/protocol.h |  6 +++++-
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
> index 436e773d798a..149a4b1d3dac 100644
> --- a/net/mptcp/fastopen.c
> +++ b/net/mptcp/fastopen.c
> @@ -91,3 +91,19 @@ int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t optval,
>  
>  	return ret;
>  }
> +
> +void mptcp_treat_hshake_ack_fastopen(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
> +				     struct mptcp_options_received mp_opt)
> +{
> +	u64 ack_seq;
> +
> +	if (mp_opt.suboptions & OPTIONS_MPTCP_MPC && mp_opt.is_mptfo && msk->is_mptfo) {
> +		msk->can_ack = true;
> +		msk->remote_key = mp_opt.sndr_key;
> +		mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
> +		ack_seq++;
> +		WRITE_ONCE(msk->ack_seq, ack_seq);
> +		pr_debug("ack_seq=%llu sndr_key=%llu", msk->ack_seq, mp_opt.sndr_key);
> +		atomic64_set(&msk->rcv_wnd_sent, ack_seq);

It's not clear to me why the above is needed. According to the RFC we
should not do additional MPTCP-level key management for TFO' sake ?!?

> +	}
> +}
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 30d289044e71..185b069e57f4 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -91,6 +91,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>  			ptr += 8;
>  		}
>  		if (opsize >= TCPOLEN_MPTCP_MPC_ACK) {
> +			mp_opt->is_mptfo = 1;

This looks incorrect. Plain MPTCP MP_CAPABLE handshake will be marked
as TFO regardless of the actual TCP option exchange.

It looks like the only already available hook to catch the 'incoming
fast open' info would be implementing custom mptcp subflow {v4,v6}
send_synack and checking the 'foc' pointer.

Otherwise you can add TCPOPT_FASTOPEN parsing capability to
mptcp_parse_option(), but that would be more duplicate code, I think it
would be better to avoid that if possible.

>  			mp_opt->rcvr_key = get_unaligned_be64(ptr);
>  			ptr += 8;
>  		}
> @@ -1124,6 +1125,8 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  		return sk->sk_state != TCP_CLOSE;
>  
>  	if (unlikely(mp_opt.suboptions != OPTION_MPTCP_DSS)) {
> +		mptcp_treat_hshake_ack_fastopen(msk, subflow, mp_opt);
> +
>  		if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
>  		    msk->local_key == mp_opt.rcvr_key) {
>  			WRITE_ONCE(msk->rcv_fastclose, true);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 8caaeeedb9da..b90279c734ae 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -155,7 +155,8 @@ struct mptcp_options_received {
>  		echo:1,
>  		backup:1,
>  		deny_join_id0:1,
> -		__unused:2;
> +		is_mptfo:1,
> +		__unused:1;
>  	u8	join_id;
>  	u64	thmac;
>  	u8	hmac[MPTCPOPT_HMAC_LEN];
> @@ -282,6 +283,7 @@ struct mptcp_sock {
>  	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
>  	bool		csum_enabled;
>  	bool		allow_infinite_fallback;
> +	bool		is_mptfo;
>  	u8		mpc_endpoint_id;
>  	u8		recvmsg_inq:1,
>  			cork:1,
> @@ -845,6 +847,8 @@ int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>  			   size_t *copied);
>  int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t optval,
>  				      unsigned int optlen);
> +void mptcp_treat_hshake_ack_fastopen(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
> +				     struct mptcp_options_received mp_opt);
>  // Fast Open Mechanism functions end
>  
>  static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)

