Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7694313AC3
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 17:43:53 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9928abc11deso117241466b.1
        for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 10:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688060631; x=1690652631;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WIgujfVzy3iociziFgr/jhTRJ/U9u7I7RxLsEMD5WY=;
        b=3aII3b7TL+Pq8nOT+OaEQnEUWRDipDAwdBmoLiXqA9scDG3AxUny5JuB+CTNIygn4v
         o5F8L3vzA3EWk/DEmOD1SIhV7r3uBbhp4ABtlQWxYhQ++Ii/flny82gv9gt1eE4WJtXW
         NfHqcRjyqHT5Y42+U93V6VkDf/qJwKeLLSQZtoqSn0XJ4hw3s5wfRnp3rqHXjtVSGDFl
         xAITR94yjhc1lZ22ymbbB6hdjByElR2tKs1GpDtO9wNGyvZgSHS6aY3xLjCWccvIQt6m
         EE0JGgb5qLCtiQaVERBOcKZ6phhJoe6k2MkcI9FQzE3iS5HPBxpnj3YT/NHhr1jM+Y/S
         3x7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688060631; x=1690652631;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WIgujfVzy3iociziFgr/jhTRJ/U9u7I7RxLsEMD5WY=;
        b=jlwe8sggF4dZj9DZBaBnF0cGycSxIjr3KPvM6rTQD3j3THTvO7INbyayah8FmwL2/R
         FbPBY5M7RAerNCi59VTzNpo2sNDchcY93m+VvrSwXvBppMv1/JxOVrmPSJ/8Wb5nR0n1
         zJUpPMmYGCgQ/r/dbQYMQPRxvvHF2DBeAo+5E8Sh0m2rIlrW4FCdkqUz/SkLpKA/lwNK
         spjSJRludrTI706gS4DvcY7UccwP9v0IotjMrShKWXP1gpFdZW1DdomqoE85YrB7GbGG
         LGd1YUFy7M4m2a/SkVam79oLjDXzAP0PdCxa+mv7M0Jp0Poq5WYIEADXmD8waniQJ8c0
         Nc5Q==
X-Gm-Message-State: ABy/qLbmE82ZNAwB8E1zUmJ3darvnXhyWWZ0VR3oGZVyQBRHyD80gWSI
	r+7kTzip+RN4cP40idMCL+nXtST189mVzM3rXaLWTuS5
X-Google-Smtp-Source: APBJJlGZzXGOwehGo4Aug1+LS3JdZFtfDZGUOXmMuKo7676PYYPM/Y9shpvTz9EydmZA56yWH9BCEw==
X-Received: by 2002:a17:906:2dca:b0:94a:9f9a:b3c4 with SMTP id h10-20020a1709062dca00b0094a9f9ab3c4mr109850eji.49.1688060631192;
        Thu, 29 Jun 2023 10:43:51 -0700 (PDT)
Received: from [10.120.18.108] ([84.17.46.13])
        by smtp.gmail.com with ESMTPSA id b22-20020a17090636d600b0099293cdbc98sm1718539ejc.145.2023.06.29.10.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 10:43:50 -0700 (PDT)
Message-ID: <72dce095-9e4e-b9e2-0ce8-dfcfe58f7ed2@tessares.net>
Date: Thu, 29 Jun 2023 19:43:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next 2/4] bpf: Add bpf_mptcpify helper
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1688004307.git.geliang.tang@suse.com>
 <53359d2572fdd676206c35d29e823e9dffd5e9f6.1688004307.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <53359d2572fdd676206c35d29e823e9dffd5e9f6.1688004307.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 29/06/2023 04:12, Geliang Tang wrote:
> This patch implements a new struct bpf_func_proto bpf_mptcpify_proto. And
> define a new helper bpf_mptcpify() to mptcpify a TCP socket dynamically as
> an MPTCP one.

Nice feature, thank you for working on that!

Is it linked to what Nicolas Rybowski looked at a few years ago? I think
he put info in a Github ticket. Was there not an issue with this
technique? Did you see it and fix it?

I didn't look at the patchset in detail but I have one question, please
see below:

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 968139f4a1ac..e439f8b5f203 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11587,6 +11587,24 @@ const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto = {
>  	.ret_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_MPTCP],
>  };
>  
> +BPF_CALL_1(bpf_mptcpify, struct sock *, sk)
> +{
> +	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP) {
> +		sk->sk_protocol = IPPROTO_MPTCP;
> +		return (unsigned long)sk;
> +	}

How do we ensure such modifications are done at the right moment? I
mean: we can only change the protocol ID in very few places, before even
creating the socket (__sock_create()?). If we change it after, we will
break stuff: tcp ops, security labels, etc.

I thought it was not possible to hook at the right place when Nicolas
looked at that and/or ensure the restriction was done but I might be
mistaken and the situation has probably changed.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
