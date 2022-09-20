Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DFF7462
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 14:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663685781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDZmhOXYXQtoId3shDXmi8yD+Lbhk154QykdhR+GxcI=;
	b=YmLLNHlyAhTICm1gY9fotWrOLxr8h7y/E9ti6GGIozTKXHPakRkwqy49rzH6KhI651wXFy
	OJKkGEm26fmY1oyt9w40qYUv/jbJajQxVnkOj2wmvGrDo8djsvzmMl6fLJwtUBJ0orDqz4
	HFRYEP4dNsXO3EBxE4bX8Yi6f2BbP4s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-503-LwKvI1A7O6KmyhsndlbmNg-1; Tue, 20 Sep 2022 10:56:20 -0400
X-MC-Unique: LwKvI1A7O6KmyhsndlbmNg-1
Received: by mail-wr1-f69.google.com with SMTP id r23-20020adfb1d7000000b002286358a916so1260169wra.3
        for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 07:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=ZDZmhOXYXQtoId3shDXmi8yD+Lbhk154QykdhR+GxcI=;
        b=BVUuI58StcumTdmGajJiNapy7t7qh8UhTBokYsZqbUHjvce9+7PCn1nrctlKWaShPd
         sz5s4Y2Pg90O7MgUtcC2TQIkLV0P8etl6NhTjEj6wTZ3hUnPyCHTtiOPExikrnO661tv
         wpL2P22ncQ9Xnes2rREnbOYvPR2vfnyyixiiNPpPd6KkhVmELfzR2x4kI+bz+Qy8+C0q
         F6ia0AsOhz/RVGgMzY3i92tQN0IUK4+FAPFOhRLbkio8NZ6v7wBdwGiPTJMzuT15U7Rw
         fi4EtpOzNhqGHXIDaaYGl5/tAwTGV8o8BUwAAw2Ct6ERfcFeRe05micTgEuESbZ3C6Bz
         cT4w==
X-Gm-Message-State: ACrzQf0S2X+x6jTawqMl2dcP+v69o1gGFOo4wI8fJvxchlnTZb2a1LHt
	docbxftf0unhwvSwELoFC1sXSx0I6Hcf7aW/EwKbYfR2fxNVaOL3I+qE5KogkC1b7GU47J4C/w5
	SZ8CVUJKqOSFsNXo=
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id b13-20020adff90d000000b0020cde324d35mr14305817wrr.583.1663685779109;
        Tue, 20 Sep 2022 07:56:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM63sMYWoAM9u5c9EigsBJkL5esyr2lGcUppY8godsAy96KDsITBkF/si7N7xXTSnHguuqynYA==
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id b13-20020adff90d000000b0020cde324d35mr14305796wrr.583.1663685778688;
        Tue, 20 Sep 2022 07:56:18 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-90.dyn.eolo.it. [146.241.114.90])
        by smtp.gmail.com with ESMTPSA id a9-20020a5d5709000000b002205cbc1c74sm159861wrv.101.2022.09.20.07.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:56:18 -0700 (PDT)
Message-ID: <a4d7a03d006a9379111cb2193bd2d73d072429b9.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v8 4/7] mptfo variables for msk, options.
 Fix loop retrans
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Tue, 20 Sep 2022 16:56:17 +0200
In-Reply-To: <20220920125243.2880-5-dmytro@shytyi.net>
References: <20220920125243.2880-1-dmytro@shytyi.net>
	 <20220920125243.2880-5-dmytro@shytyi.net>
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

On Tue, 2022-09-20 at 14:52 +0200, Dmytro Shytyi wrote:
> Introduce mptfo variables for msk and options.
> Also fix the infinite retransmissions in the end of second session.

I think the above sentence belongs more the changelog than to the
commit message itself.

> The variable 2nd ack received in struct mptcp_options_received identifies the
> received ack on the listener side during 3way handshake in mptfo context
> and miningless alone if used alone. It is further used(checked)
> in conjunction in the same "if" statement with variable is_mptfo
> from struct mptcp_sock.
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> ---
>  net/mptcp/fastopen.c | 14 ++++++++++++++
>  net/mptcp/options.c  |  4 ++++
>  net/mptcp/protocol.h |  6 +++++-
>  3 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
> index 9ef49a2d2ea2..92885e459f93 100644
> --- a/net/mptcp/fastopen.c
> +++ b/net/mptcp/fastopen.c
> @@ -30,3 +30,17 @@ int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t optval,
>  
>  	return ret;
>  }
> +
> +void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
> +				   struct mptcp_options_received mp_opt)
> +{
> +	u64 ack_seq;
> +
> +	msk->can_ack = true;
> +	msk->remote_key = mp_opt.sndr_key;

likely the above two statements need WRITE_ONCE() annotation.

Additionally it's better to add some safeguards here:
- ssk should be in TCP_SYN_RECV state - to be verified, it's guess and
I haven't check it yet.
- msk should be in the same state of the ssk subflow.

> +	mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
> +	ack_seq++;
> +	WRITE_ONCE(msk->ack_seq, ack_seq);
> +	pr_debug("ack_seq=%llu sndr_key=%llu", msk->ack_seq, mp_opt.sndr_key);
> +	atomic64_set(&msk->rcv_wnd_sent, ack_seq);
> +}
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 30d289044e71..8852a13cfe62 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -91,6 +91,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>  			ptr += 8;
>  		}
>  		if (opsize >= TCPOLEN_MPTCP_MPC_ACK) {
> +			mp_opt->hns_2nd_ack_rcvd = 1;

Not needed, see below...

>  			mp_opt->rcvr_key = get_unaligned_be64(ptr);
>  			ptr += 8;
>  		}
> @@ -1124,6 +1125,9 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  		return sk->sk_state != TCP_CLOSE;
>  
>  	if (unlikely(mp_opt.suboptions != OPTION_MPTCP_DSS)) {
> +		if (mp_opt.suboptions & OPTIONS_MPTCP_MPC && mp_opt.hns_2nd_ack_rcvd && msk->is_mptfo)

You can simply check for:

		if (mp_opt.suboptions & OPTIONS_MPTCP_MPC_ACK) && msk->is_mptfo)

> +			mptcp_gen_msk_ackseq_fastopen(msk, subflow, mp_opt);
> +
>  		if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
>  		    msk->local_key == mp_opt.rcvr_key) {
>  			WRITE_ONCE(msk->rcv_fastclose, true);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 57596cdfb1f9..3b9a349a7080 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -155,7 +155,8 @@ struct mptcp_options_received {
>  		echo:1,
>  		backup:1,
>  		deny_join_id0:1,
> -		__unused:2;
> +		__unused:1;
> +	u8	hns_2nd_ack_rcvd:1;

... again not needed, see above ;)

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
> @@ -842,6 +844,8 @@ int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr, int addr_l
>  // Fast Open Mechanism functions begin
>  int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t optval,
>  				      unsigned int optlen);
> +void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
> +				   struct mptcp_options_received mp_opt);
>  // Fast Open Mechanism functions end
>  
>  static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)

