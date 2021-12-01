Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2242C2C82
	for <mptcp@lists.linux.dev>; Wed,  1 Dec 2021 10:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1638355237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80Na/fJR1Sv4zb8uMqm+uzF9IvGNgmQE1+S2leFNbys=;
	b=WgQYgx8MaaeFSGVxIY+9dnvqPP/+yGtmzHTsH03eV5PqTbnWFM7k6n3XuCYTtAsp1NEbMy
	nAxGXU3d0A7t/R4P+mVgyJHebWF6K6nWUuBL5NRsfUDzJG6Wu0vEvpQRmNu+O8Rg9CmAGt
	7E+UugZMb/xSWoEol4ckNnYLL+/2qS8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-lGC40p-1NdeK45r9oW5NPg-1; Wed, 01 Dec 2021 05:40:36 -0500
X-MC-Unique: lGC40p-1NdeK45r9oW5NPg-1
Received: by mail-ed1-f71.google.com with SMTP id q17-20020aa7da91000000b003e7c0641b9cso19892109eds.12
        for <mptcp@lists.linux.dev>; Wed, 01 Dec 2021 02:40:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=80Na/fJR1Sv4zb8uMqm+uzF9IvGNgmQE1+S2leFNbys=;
        b=gOAbQJ86zPgVy52R8lYq7iG4PciTtEkSQOxVqSFDEaxvLPxMunuIfdC/2K5w4r2Rbu
         iNJ7fPDt+bWvhPEk0gj7xsa0EiQTikVVDF+e0m2fSFWhkSND87eWdToluTJVjEZ41KVM
         4zq852kj5mmbJ0AMOFS73JTO+c10q98SzOREJ97sqO13ItfvarfkZSDnvawIvIl0Q4DT
         T7sVOPVsBbDqR3XMD41qRWA/imP7IXiiNzt/Wx7P3fF/YX9QD/BXFvchA9VzgwnHzoaD
         lMx7aSWCy14ubgUSDqDKdPSmPkH2Wuk+j8O+/eDqXOHD7gRoitDKSAYlZ/nMqiiZN4Jz
         42YA==
X-Gm-Message-State: AOAM533wCJAFMH/syrnO8efgiklBebSL4VxA7ZXU/EF6IKjL0X5Psh8a
	ddZqSj4DBpQuuAovtLfGvYCWWSFDUqMgkLM4+zHBuUaVuxPMd/rzlO2WfuosJBZAbZWw96B2QpI
	psaMMcb3HRbjOqdU=
X-Received: by 2002:a17:907:16a1:: with SMTP id hc33mr6067844ejc.486.1638355235401;
        Wed, 01 Dec 2021 02:40:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxrDUvbG+v/s5QodT6tunvkEOZr0afgyJCi//uz77XxFYnd0jQEjaUKK64TG8xSoJKE9f8Rtg==
X-Received: by 2002:a17:907:16a1:: with SMTP id hc33mr6067817ejc.486.1638355235138;
        Wed, 01 Dec 2021 02:40:35 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-140.dyn.eolo.it. [146.241.97.140])
        by smtp.gmail.com with ESMTPSA id sb19sm11323935ejc.120.2021.12.01.02.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 02:40:34 -0800 (PST)
Message-ID: <05864fd724521fcde2e7e40b95a825f5e21a3e2c.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: implement fastclose xmit
 path"
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Date: Wed, 01 Dec 2021 11:40:32 +0100
In-Reply-To: <20211130165527.1506827-1-matthieu.baerts@tessares.net>
References: <e7427851-a812-05b7-6441-cb9e6f61e65c@tessares.net>
	 <20211130165527.1506827-1-matthieu.baerts@tessares.net>
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35)
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

On Tue, 2021-11-30 at 17:55 +0100, Matthieu Baerts wrote:
> This is linked to Geliang's patch with the same title.
> 
> If I understand the RFC properly, we can use MP_RST with an MP_FASTCLOSE
> and an MP_FAIL (or none of them) but we cannot use MP_FASTCLOSE and
> MP_FAIL together.
> 
> This patch implements this logic in both mptcp_established_options() and
> mptcp_write_options(). Before this patch, the first function was not
> allowing any of these 3 options to be used at the same time while the
> second one was allowing MP_FAIL to be used with either MP_FASTCLOSE or
> MP_RST.
> 
> Small note: I tried to keep Paolo's idea of reducing conditions for
> "normal" options by moving MP_RST at the end and allow to jump there
> from MP_FAIL and MP_FASTCLOSE but I'm not sure it makes it easy to read
> and really improves perfs. We can also move MP_RST check at the
> beginning.
> 
> @Geliang: feel free to re-use this patch if it looks OK to you.
> 
> PS: I didn't try this patch, just quickly wrote it to better explain
> what I had in mind.
> 
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Geliang Tang <geliang.tang@suse.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> 
> Notes:
>     to be squashed in "mptcp: implement fastclose xmit path"
> 
>  net/mptcp/options.c | 62 +++++++++++++++++++++++++++------------------
>  1 file changed, 37 insertions(+), 25 deletions(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 8a1020e4285c..07091971a51a 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -829,11 +829,17 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>  
>  	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
>  		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) ||
> -		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
> -		    mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
> +		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
>  			*size += opt_size;
>  			remaining -= opt_size;
>  		}
> +
> +		/* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if there is room */
> +		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
> +			*size += opt_size;
> +			remaining -= opt_size;
> +		}
> +
>  		return true;
>  	}
>  
> @@ -1257,21 +1263,7 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
>  void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>  			 struct mptcp_out_options *opts)
>  {
> -	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
> -		const struct sock *ssk = (const struct sock *)tp;
> -		struct mptcp_subflow_context *subflow;
> -
> -		subflow = mptcp_subflow_ctx(ssk);
> -		subflow->send_mp_fail = 0;
> -
> -		*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
> -				      TCPOLEN_MPTCP_FAIL,
> -				      0, 0);
> -		put_unaligned_be64(opts->fail_seq, ptr);
> -		ptr += 2;
> -	}
> -
> -	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
> +	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and FAIL are mutually exclusive,
>  	 * see mptcp_established_options*()
>  	 */
>  	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
> @@ -1458,19 +1450,39 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>  				ptr += 1;
>  			}
>  		}
> -	} else if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
> -		/* RST is mutually exclusive with everything else */
> -		*ptr++ = mptcp_option(MPTCPOPT_RST,
> -				      TCPOLEN_MPTCP_RST,
> -				      opts->reset_transient,
> -				      opts->reset_reason);
> -		return;
>  	} else if (unlikely(OPTION_MPTCP_FASTCLOSE & opts->suboptions)) {
> -		/* FASTCLOSE is mutually exclusive with everything else */
> +		/* FASTCLOSE is mutually exclusive with others except RST */
>  		*ptr++ = mptcp_option(MPTCPOPT_MP_FASTCLOSE,
>  				      TCPOLEN_MPTCP_FASTCLOSE,
>  				      0, 0);
>  		put_unaligned_be64(opts->rcvr_key, ptr);
> +
> +		if (OPTION_MPTCP_RST & opts->suboptions)
> +			goto mp_rst;
> +		return;
> +	} else if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
> +		/* MP_FAIL is mutually exclusive with others except RST */
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
> +
> +		if (OPTION_MPTCP_RST & opts->suboptions)
> +			goto mp_rst;
> +		return

As the CI spotted, missing ';' here.

Otherwise LGTM!

Thanks,

Paolo

