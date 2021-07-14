Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F20670
	for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 08:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1626252313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LOSu734yloq/fj/5Bs5uTJtlsO/ar8vClZTw50Sq8VI=;
	b=JRFbOjI8yH+FEP7siOeQdTLdoSgJEtBPTH1YsgyvZ3YSD6vXssOZMeKs/A4muNFYMc+Dw7
	/Ql5wg4KmqB01Qxgfb6Xki6HZf0BSZ1u/eHmx7zKxGlfCyyUUs9GW2y5+rbKt1VYUZ6XI1
	jTTmKz9YC/0BMWbNlOCt8LL90Hv4Hn4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-PNYxHSoQMvqzB9u9GJyXsw-1; Wed, 14 Jul 2021 04:45:11 -0400
X-MC-Unique: PNYxHSoQMvqzB9u9GJyXsw-1
Received: by mail-wr1-f69.google.com with SMTP id 5-20020a0560001565b029013fe432d176so1098907wrz.23
        for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 01:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LOSu734yloq/fj/5Bs5uTJtlsO/ar8vClZTw50Sq8VI=;
        b=lEGDn9DDpztgpUhk4+WHDonuBfzRZhFK0bSTyrmzfkKSzIQZgHMTOM470e80zpLf7E
         CybHi0tWyltw1Pne1JA5OUHFcmRw1EGVJNV9vqns6H7YioluuoQn1axfmlRre2gmwwPe
         4SXisAYZfMBRqeha7/YhbKIPbmxJJ/MXdB819GuEe7HXpz1hhZHvXkje1TuyBFpRucGT
         nrMBbNRMUpNdxEVB4cF9b0nneVVh3xpjhgtssceO5A0S8YeRs1B5P2aAoDAjsxGTx79q
         1mSWOCYuM5Etpsve2BpVxx43qwt4nkdN0FUeCL3FgPO+mhfILNIzktXBYeRWYahm09x+
         HUbw==
X-Gm-Message-State: AOAM532HeQWyrrcnYagDzicE9hlM7iCgcSz+y+LkP66YpGcjfSM/I49K
	ylK6DlvLGYKf0aPIyWj2WG/y29t/CJupgYsRelVvfeS85pzBiYzcatfIAFz7wfZQjwxQCOb+Rsx
	fPUgWR3bnOybq+EE=
X-Received: by 2002:a05:600c:ac3:: with SMTP id c3mr10193968wmr.4.1626252310168;
        Wed, 14 Jul 2021 01:45:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztJ7kltkgififofCqSkhSWLjq+UOCUuGkvpv2KAfVARV/5MEjUph0mzaXEz7o3o+vJfWFPzw==
X-Received: by 2002:a05:600c:ac3:: with SMTP id c3mr10193950wmr.4.1626252309829;
        Wed, 14 Jul 2021 01:45:09 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-126-220.dyn.eolo.it. [146.241.126.220])
        by smtp.gmail.com with ESMTPSA id h9sm1390603wmb.35.2021.07.14.01.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 01:45:09 -0700 (PDT)
Message-ID: <be269ef04813ede9084094b62f24d1fdcd7b91d0.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v3 mptcp-next 1/8] mptcp: MP_FAIL suboption
 sending
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Date: Wed, 14 Jul 2021 10:45:08 +0200
In-Reply-To: <3cc57b70ec147b4c77610737241aeadf4150f323.1624854005.git.geliangtang@gmail.com>
References: <cover.1624854005.git.geliangtang@gmail.com>
	 <3cc57b70ec147b4c77610737241aeadf4150f323.1624854005.git.geliangtang@gmail.com>
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

On Mon, 2021-06-28 at 12:28 +0800, Geliang Tang wrote:
> This patch added the MP_FAIL suboption sending support.
> 
> Add a new flag named send_mp_fail in struct mptcp_subflow_context. If
> this flag is set, send out MP_FAIL suboption.
> 
> Add a new member fail_seq in struct mptcp_out_options to save the data
> sequence number to put into the MP_FAIL suboption.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  include/net/mptcp.h  |  1 +
>  net/mptcp/options.c  | 54 ++++++++++++++++++++++++++++++++++++++++++--
>  net/mptcp/protocol.h |  4 ++++
>  3 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index cb580b06152f..f48d3b5a3fd4 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -72,6 +72,7 @@ struct mptcp_out_options {
>  	u32 nonce;
>  	u64 thmac;
>  	u32 token;
> +	u64 fail_seq;

Since we can't have both a valid mapping and MP_FAIL in the same
packet, it would be better to avoid increasing the 'mptcp_out_options'
size, e.g. re-using some ext_copy field, or unioning with some other
field.

mptcp_out_options has grown quite a bit and we should really look into
shrinking it.

>  	u8 hmac[20];
>  	struct mptcp_ext ext_copy;
>  #endif
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index b5850afea343..b78defe1aed9 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -771,6 +771,28 @@ static noinline void mptcp_established_options_rst(struct sock *sk, struct sk_bu
>  	opts->reset_reason = subflow->reset_reason;
>  }
>  
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
> +	opts->fail_seq = subflow->fail_seq;
> +
> +	pr_debug("MP_FAIL fail_seq=%llu", opts->fail_seq);
> +
> +	return true;
> +}
> +
>  bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>  			       unsigned int *size, unsigned int remaining,
>  			       struct mptcp_out_options *opts)
> @@ -787,15 +809,29 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>  		return false;
>  
>  	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
> -		mptcp_established_options_rst(sk, skb, size, remaining, opts);
> +		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
> +			*size += opt_size;
> +			remaining -= opt_size;
> +		}
> +		mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts);
> +		*size += opt_size;
> +		remaining -= opt_size;
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

Is the extra check on 'opts->ext_copy.use_ack' necessary? can we just
look for mp_fail?


> +			if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
> +				*size += opt_size;
> +				remaining -= opt_size;
> +				ret = true;
> +			}
> +		}
> +	}
>  
>  	/* we reserved enough space for the above options, and exceeding the
>  	 * TCP option space would be fatal
> @@ -1334,6 +1370,20 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>  				      opts->backup, TCPOPT_NOP);
>  	}
>  
> +	if (OPTION_MPTCP_FAIL & opts->suboptions) {
> +		const struct sock *ssk = (const struct sock *)tp;
> +		struct mptcp_subflow_context *subflow;
> +
> +		subflow = mptcp_subflow_ctx(ssk);
> +		subflow->send_mp_fail = 0;
> +
> +		*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
> +				      TCPOLEN_MPTCP_FAIL,
> +				      0, 0);
> +		put_unaligned_be64(opts->fail_seq, ptr);
> +		ptr += 2;
> +	}
> +
>  	if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
>  		*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
>  				      TCPOLEN_MPTCP_MPJ_SYN,
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 426ed80fe72f..007af5e4ba3d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -26,6 +26,7 @@
>  #define OPTION_MPTCP_FASTCLOSE	BIT(8)
>  #define OPTION_MPTCP_PRIO	BIT(9)
>  #define OPTION_MPTCP_RST	BIT(10)
> +#define OPTION_MPTCP_FAIL	BIT(11)
>  
>  /* MPTCP option subtypes */
>  #define MPTCPOPT_MP_CAPABLE	0
> @@ -67,6 +68,7 @@
>  #define TCPOLEN_MPTCP_PRIO_ALIGN	4
>  #define TCPOLEN_MPTCP_FASTCLOSE		12
>  #define TCPOLEN_MPTCP_RST		4
> +#define TCPOLEN_MPTCP_FAIL		12
>  
>  #define TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM	(TCPOLEN_MPTCP_DSS_CHECKSUM + TCPOLEN_MPTCP_MPC_ACK_DATA)
>  
> @@ -417,6 +419,7 @@ struct mptcp_subflow_context {
>  		mpc_map : 1,
>  		backup : 1,
>  		send_mp_prio : 1,
> +		send_mp_fail : 1,
>  		rx_eof : 1,
>  		can_ack : 1,        /* only after processing the remote a key */
>  		disposable : 1;	    /* ctx can be free at ulp release time */
> @@ -431,6 +434,7 @@ struct mptcp_subflow_context {
>  	u8	reset_seen:1;
>  	u8	reset_transient:1;
>  	u8	reset_reason:4;
> +	u64	fail_seq;
>  
>  	long	delegated_status;
>  	struct	list_head delegated_node;   /* link into delegated_action, protected by local BH */

