Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF01D70
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 10:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627468285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3LnaSln40pcY3bgv8BNGadkD4ZFhFtv8ADEsxndVyJo=;
	b=So1JkcrUnR4hpUD8783rXtx603bzbcrhUeoZJ5HcficJ4L2n412hnS41WylsZYCkj3LRt+
	VsSmD1j7a0zKp9eUMhMGhaWiNCvPH+cBklRErOFmZPPXI/vnDvTI4K1clUkQRoDV+VR2Uo
	oZz3E80sRUCA3FkIQdl8TWDTqkUCwKE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-krI_h-vtPz-PJS2KWuh7IA-1; Wed, 28 Jul 2021 06:31:24 -0400
X-MC-Unique: krI_h-vtPz-PJS2KWuh7IA-1
Received: by mail-wr1-f69.google.com with SMTP id r14-20020a5d4e4e0000b029015409d80a01so502729wrt.12
        for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 03:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3LnaSln40pcY3bgv8BNGadkD4ZFhFtv8ADEsxndVyJo=;
        b=EmLO2nmJ5Qst5FryhdkEHECzWBUrow/69JyCEU2lXenn2SgpyCAL58T3b5cQhn6m6r
         FefC4hBoctuD+Zq5HU5fkChC2oLxQTCvDnOc2YB2eCsYQ1qZsW2FAKwhbHmLjq55xT9n
         /bW6t1uBmzuojs2HaTpJrJudxhEhCqspCWusjzX/Y8WjTYkaoiUaA7fZXm9yjqTrZj+g
         SLcJnMY0p5tGT1Af1usBJMhiwO9SpUV/2TYJ9GEx+fHIXyVtJjVaXLDIKEMwA2EYZs+R
         pV5r+6SJ4eoIc2hn8h0DvcddmYdEnXay0ywgX9TPYMujBeXNcUYpjoRA7U0P8p5b3p/H
         WJ9Q==
X-Gm-Message-State: AOAM530CL71iXFCjoyKCZRed4FM+KAI/00xr4E5E3Af48hGMqLurm5UF
	1DA36nWG/KWIOkWnsBki94mO59gQQhWJRN4yH4iQWZp8taSKwTcKaEloxH+xRYinjLDnRNVxOen
	+jCrICp/Cs24y2kU=
X-Received: by 2002:a7b:c204:: with SMTP id x4mr12532449wmi.70.1627468283041;
        Wed, 28 Jul 2021 03:31:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxebEqtFUVlrRvxbU2yS7RWLh1EUQ1P1zb6+PEcCdwJpNcM10w/Fd/EDBQ0cqaGfhsFqRu+5Q==
X-Received: by 2002:a7b:c204:: with SMTP id x4mr12532432wmi.70.1627468282843;
        Wed, 28 Jul 2021 03:31:22 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id b6sm5603936wmj.34.2021.07.28.03.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 03:31:22 -0700 (PDT)
Message-ID: <8acb4b9a8d6a7032cc64260e86b95ed1e33b1f2b.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v6 mptcp-next 1/5] mptcp: MP_FAIL suboption
 sending
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Wed, 28 Jul 2021 12:31:21 +0200
In-Reply-To: <277ac1e6d1fde4c180eba3f1bb1846ea58679915.1627464017.git.geliangtang@xiaomi.com>
References: <cover.1627464017.git.geliangtang@xiaomi.com>
	 <277ac1e6d1fde4c180eba3f1bb1846ea58679915.1627464017.git.geliangtang@xiaomi.com>
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

Hello,

On Wed, 2021-07-28 at 17:35 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> This patch added the MP_FAIL suboption sending support.
> 
> Add a new flag named send_mp_fail in struct mptcp_subflow_context. If
> this flag is set, send out MP_FAIL suboption.
> 
> Add a new member fail_seq in struct mptcp_out_options to save the data
> sequence number to put into the MP_FAIL suboption.
> 
> An MP_FAIL option could be included in a RST or on the subflow-level
> ACK.
> 
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
>  include/net/mptcp.h  |  5 +++-
>  net/mptcp/options.c  | 61 +++++++++++++++++++++++++++++++++++++++++---
>  net/mptcp/protocol.h |  3 +++
>  3 files changed, 64 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 3236010afa29..6026bbefbffd 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -74,7 +74,10 @@ struct mptcp_out_options {
>  			struct mptcp_addr_info addr;
>  			u64 ahmac;
>  		};
> -		struct mptcp_ext ext_copy;
> +		struct {
> +			struct mptcp_ext ext_copy;
> +			u64 fail_seq;
> +		};
>  		struct {
>  			u32 nonce;
>  			u32 token;
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 753d6ac43bff..2b15063c8009 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -763,7 +763,7 @@ static bool mptcp_established_options_mp_prio(struct sock *sk,
>  	return true;
>  }
>  
> -static noinline void mptcp_established_options_rst(struct sock *sk, struct sk_buff *skb,
> +static noinline bool mptcp_established_options_rst(struct sock *sk, struct sk_buff *skb,
>  						   unsigned int *size,
>  						   unsigned int remaining,
>  						   struct mptcp_out_options *opts)
> @@ -771,12 +771,36 @@ static noinline void mptcp_established_options_rst(struct sock *sk, struct sk_bu
>  	const struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>  
>  	if (remaining < TCPOLEN_MPTCP_RST)
> -		return;
> +		return false;
>  
>  	*size = TCPOLEN_MPTCP_RST;
>  	opts->suboptions |= OPTION_MPTCP_RST;
>  	opts->reset_transient = subflow->reset_transient;
>  	opts->reset_reason = subflow->reset_reason;
> +
> +	return true;
> +}
> +
> +static bool mptcp_established_options_mp_fail(struct sock *sk,
> +					      unsigned int *size,
> +					      unsigned int remaining,
> +					      struct mptcp_out_options *opts)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +
> +	if (!subflow->send_mp_fail)
> +		return false;
> +
> +	if (remaining < TCPOLEN_MPTCP_FAIL)
> +		return false;
> +
> +	*size = TCPOLEN_MPTCP_FAIL;
> +	opts->suboptions |= OPTION_MPTCP_FAIL;
> +	opts->fail_seq = subflow->map_seq;
> +
> +	pr_debug("MP_FAIL fail_seq=%llu", opts->fail_seq);
> +
> +	return true;
>  }
>  
>  bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> @@ -795,15 +819,30 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>  		return false;
>  
>  	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
> -		mptcp_established_options_rst(sk, skb, size, remaining, opts);
> +		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
> +			*size += opt_size;
> +			remaining -= opt_size;
> +		}
> +		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
> +			*size += opt_size;
> +			remaining -= opt_size;
> +		}
>  		return true;
>  	}
>  
>  	snd_data_fin = mptcp_data_fin_enabled(msk);
>  	if (mptcp_established_options_mp(sk, skb, snd_data_fin, &opt_size, remaining, opts))
>  		ret = true;
> -	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, remaining, opts))
> +	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, remaining, opts)) {
>  		ret = true;
> +		if (opts->ext_copy.use_ack) {

I *think* we could drop this check as the RFC says:

"""
   it will send back an MP_FAIL option on
   the subflow-level ACK,
"""

And to me subflow-level ACK really means TCP ack, that is any packet on
a TCP-established subflow will do.

Anyhow I think we can adjust the above with a squash-to patch after
this series is merged, as it already went through several iterations
and overall it LGTM.

While at that a few 'unlikely()' annotation will help ;)

/P

