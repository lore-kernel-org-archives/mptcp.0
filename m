Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C59F7C
	for <mptcp@lists.linux.dev>; Fri, 25 Feb 2022 15:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1645802536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDu4UpSSxEahDtHA0053u1kwdN/1ATVZLikV5OGpIcU=;
	b=G1Ks2BPDHMh4w37n7ba/2jBvZmWxgh+kAoFFtb2W9tLR/59RSWmkljOu8PFpEzx5JiLitm
	4/Gcp6H6OrRqNq0BDvxyGLD6p+JUlA2fUbMyqhTlYeLBYR7Igl54DT6D9VZ4nKc9j3FFxF
	dSBclvI6dY2PUI+f9zUpT1hdCLkZBf8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-Ogg_cOLNPZ2RWMM7tta07Q-1; Fri, 25 Feb 2022 10:22:15 -0500
X-MC-Unique: Ogg_cOLNPZ2RWMM7tta07Q-1
Received: by mail-wr1-f71.google.com with SMTP id p9-20020adf9589000000b001e333885ac1so1005601wrp.10
        for <mptcp@lists.linux.dev>; Fri, 25 Feb 2022 07:22:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=hDu4UpSSxEahDtHA0053u1kwdN/1ATVZLikV5OGpIcU=;
        b=cDx5xCSpT3lAG2CRLRWUv/OZyzFDhtcRcb8jghTmjq7/HAREx/G68KKL+STVEoCDK8
         1LqbAexJu1lYTeQV2JpbdG9Cmxd4hQV/hFa9u7a/Dx2uGZdGJ7vC3MveD1EZhDUq6p+b
         m0MrwgvxYLGkG1x0GNXpjz+1IA4BcRsGHLw7Te+bq8HyLofp8XX6U8AFKcxnbKhs69zh
         Yq6UIKMtNodacha9iTxwj7B/6FpNVjBwkTkqUz3koVQdfAtTNtQ6vmPPMzOWCwf9tyVF
         CK/edsmm7rgHLnCsjylttqG566P/iBWLumjdNiCjPef0nIYpU8f+TlpZIe2cSCExBta7
         Th8w==
X-Gm-Message-State: AOAM530ROJYZHx4fHxH1pilMkIfKWRqcdf4RZcsV4OSJfyVRZZScqM3Q
	89i4LcbYYpBLeZWzbojKom5Z4gOQrPUGN6kdYfbWJS7N7tLjo75pEgjENKOg18YaWrTUdb9OzWT
	CSbrpGNY26bX+zRc=
X-Received: by 2002:a7b:c099:0:b0:381:38fa:4ae6 with SMTP id r25-20020a7bc099000000b0038138fa4ae6mr2451442wmh.128.1645802533617;
        Fri, 25 Feb 2022 07:22:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxb+SeVdzxJB/FpWPlHBWY95RJxHISLHlprqDh0xmapscYh1HBcpkvy857OPDKMUcws3rXcig==
X-Received: by 2002:a7b:c099:0:b0:381:38fa:4ae6 with SMTP id r25-20020a7bc099000000b0038138fa4ae6mr2451429wmh.128.1645802533310;
        Fri, 25 Feb 2022 07:22:13 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-242-142.dyn.eolo.it. [146.241.242.142])
        by smtp.gmail.com with ESMTPSA id k26-20020a05600c1c9a00b0037bdeaf5d30sm3058138wms.36.2022.02.25.07.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 07:22:13 -0800 (PST)
Message-ID: <f1b2e28b245f5da89de6e045a73e5baa327282bb.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next 4/4] tcp: Add TCP hooks for detecting
 MP_JOIN on a regular TCP listener
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Cc: fw@strlen.de
Date: Fri, 25 Feb 2022 16:22:11 +0100
In-Reply-To: <20220224232226.259304-5-mathew.j.martineau@linux.intel.com>
References: <20220224232226.259304-1-mathew.j.martineau@linux.intel.com>
	 <20220224232226.259304-5-mathew.j.martineau@linux.intel.com>
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
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

On Thu, 2022-02-24 at 15:22 -0800, Mat Martineau wrote:
> MPTCP uses a TCP SYN packet with the MP_JOIN option to add subflows to
> an existing MPTCP connection. This uses token lookup to match the
> incoming SYN with the appropriate MPTCP socket instead of the port
> number (in accordance with RFC 8684), and it is possible for a TCP
> listener to be present at the port that the MPTCP peer is trying to
> connect to. If the TCP listener ignores the MP_JOIN option and sends a
> normal TCP SYN-ACK without a MP_JOIN option header, the peer will be
> forced to send a RST.
> 
> Given that a peer sending MP_JOIN is guaranteed to reject a regular TCP
> SYN-ACK, it's better to attempt a MPTCP token lookup and either let
> MPTCP continue the handshake or immediately reject the connection
> attempt.
> 
> The only new conditional in the TCP SYN handling hot path is a check of
> the saw_mp_join bit. If that is set, tcp_check_req() returns early and
> tcp_v4_rcv() or tcp_v6_rcv() call the MPTCP join handler in an error
> path.
> 
> If MPTCP is not configured, all the code added in this commit should be
> optimized away.
> 
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
>  net/ipv4/tcp_ipv4.c      | 7 +++++++
>  net/ipv4/tcp_minisocks.c | 8 +++++++-
>  net/ipv6/tcp_ipv6.c      | 7 +++++++
>  3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 73e5726af8d0..124ad393e6fb 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -2082,6 +2082,13 @@ int tcp_v4_rcv(struct sk_buff *skb)
>  				tcp_v4_restore_cb(skb);
>  				sock_put(sk);
>  				goto lookup;
> +			} else if (req_status == TCP_REQ_MP_JOIN) {
> +				struct sock *msk = mptcp_handle_join4(skb);
> +
> +				if (msk) {
> +					sk = msk;
> +					goto process;
> +				}

If I read correctly, this will handle MPJ 3rd ack packets, we will need
a similar chunk for incoming MPJ syn in tcp_rcv_state_process(), and
likely something additional for syncookies.

>  			}
>  			goto discard_and_relse;
>  		}
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index 3d989f8676a5..4fdca31b33bb 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -572,10 +572,16 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
>  	bool own_req;
>  
>  	tmp_opt.saw_tstamp = 0;
> +	tmp_opt.saw_mp_join = 0;
>  	if (th->doff > (sizeof(struct tcphdr)>>2)) {
>  		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
>  
> -		if (tmp_opt.saw_tstamp) {
> +		if (unlikely(tmp_opt.saw_mp_join) &&
> +		    mptcp_is_enabled(sock_net(sk))) {
> +			*req_status = TCP_REQ_MP_JOIN;

If I read correctly, this skips all the state and sequence number check
we have on plain TCP 3rd ack. I think we want to preserve them.


Cheers,

Paolo

