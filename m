Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3E448D0
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 14:15:46 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id r13so39580625ejd.5
        for <mptcp@lists.linux.dev>; Tue, 08 Mar 2022 06:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=fF5a/JicjiBS/MM9IoTmlxdu72ABhWemWwldBK+DnwM=;
        b=OB1ubUyuhfYG0RuD2uU/rY9uvVB+rokhO1FLH6H0UBmBZS2kqxD9Rg6yiq06k8WdV1
         Btp7zB98iNXfSJlbVikAlMqgLxFneyCnTBuKRdayxnjQuNgP203M31yxoi9XBMk8PR2j
         iLM7/ckt8UFH55tsUJLhRyiIcywSmLfv6Nbs6qFYvsSYr9xcGjyvBY+9TTOsovMxzeyE
         S4JhZ6wlgUcwRPymIKvEvzjiUAjl96mbYePf+js3LE5Ue2NHUeSJKK6+iLa/QA6hw86I
         StMRahYBVF0mX4D2jTUG+1Scw9utwG1CpOUjTqFPOzlflSxF7czSnVBCvUrAHbvALh9f
         loAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fF5a/JicjiBS/MM9IoTmlxdu72ABhWemWwldBK+DnwM=;
        b=KKjlh1LCoIYcGR4ztqygfyMPD8yyDPhehX9/ql4gsDufahYvTCJ3DGZzTDmpPOqzsy
         HXlq/xVQU2K278sOH/vryWjpbbp3dY9NkcAxfHJZvGOZnBVJf45FPR58G/d7emM2XELI
         /dE9fEB9MwxReTl62BS8kcVllQlFD5lx+trTlyHZjtstoH/8q1SkS5qZFzEgosutX8aA
         iVOW87wYs6aXq890cMJJB+gDXwKeWZ4vsUcRvfdSxxiqVB1SoWQv6nGK0pXTW+/g4kB0
         c0iEnt2frNQxNxwaaMEh1gl6dIW2l2z1q6VBJC74nenMbMNDx6o1sj2Xbpjva5TxvOTG
         rjLw==
X-Gm-Message-State: AOAM530v+19BLulKEzIxsPBBD75pwdYTHCzdhIwS5yQdPGwyHPUkRhdM
	GzeZjVdkXOKBoNc+xFm6lMhIPD6WUYdGQw==
X-Google-Smtp-Source: ABdhPJxj6qjLmtRizikk/UZv+7zWz5El0CaBv9k9HaMjDX3Vj0biCFwM3N5i/2Yuz+pED98DyWd3fA==
X-Received: by 2002:a17:906:b50:b0:6d6:e503:131c with SMTP id v16-20020a1709060b5000b006d6e503131cmr13374989ejg.597.1646748944491;
        Tue, 08 Mar 2022 06:15:44 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:4a74:9d9d:42fe:ff08? ([2a02:578:8593:1200:4a74:9d9d:42fe:ff08])
        by smtp.gmail.com with ESMTPSA id s19-20020a056402521300b0041666640ffdsm1410679edd.6.2022.03.08.06.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 06:15:44 -0800 (PST)
Message-ID: <62df1f13-8341-052c-ebf6-4a438e84d47e@tessares.net>
Date: Tue, 8 Mar 2022 15:15:43 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next v9 3/5] bpf: add skc_to_mptcp_sock helper
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1646745228.git.geliang.tang@suse.com>
 <d6d33be9899118c5f542a6ce43f868d4e9e2766b.1646745228.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d6d33be9899118c5f542a6ce43f868d4e9e2766b.1646745228.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 08/03/2022 14:16, Geliang Tang wrote:
> This patch implemented bpf_skc_to_mptcp_sock helper. Defined a new bpf_id
> BTF_SOCK_TYPE_MPTCP, and added a new helper bpf_mptcp_sock_from_subflow()
> to get struct bpf_mptcp_sock from a given subflow socket.

Thank you for the new version!

I just noticed a small thing I didn't see before.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index f64454722a7e..538b6db4fd76 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11121,6 +11121,19 @@ const struct bpf_func_proto bpf_skc_to_unix_sock_proto = {
>  	.ret_btf_id		= &btf_sock_ids[BTF_SOCK_TYPE_UNIX],
>  };
>  
> +BPF_CALL_1(bpf_skc_to_mptcp_sock, struct sock *, sk)
> +{
> +	return (unsigned long)bpf_mptcp_sock_from_subflow(sk);
> +}
> +
> +static const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto = {
> +	.func		= bpf_skc_to_mptcp_sock,
> +	.gpl_only	= false,
> +	.ret_type	= RET_PTR_TO_BTF_ID_OR_NULL,
> +	.arg1_type	= ARG_PTR_TO_SOCK_COMMON,
> +	.ret_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_MPTCP],
> +};
> +
>  BPF_CALL_1(bpf_sock_from_file, struct file *, file)
>  {
>  	return (unsigned long)sock_from_file(file);
> @@ -11163,6 +11176,10 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
>  	case BPF_FUNC_skc_to_unix_sock:
>  		func = &bpf_skc_to_unix_sock_proto;
>  		break;
> +#ifdef CONFIG_MPTCP
> +	case BPF_FUNC_skc_to_mptcp_sock:
> +		return &bpf_skc_to_mptcp_sock_proto;

If I'm not mistaken, here you should set 'func' and not return.
Otherwise you will miss the check to know if the right capability is set
which is needed to access some fields of the MPTCP socket (token, etc.), no?

> +#endif /* CONFIG_MPTCP */
>  	case BPF_FUNC_ktime_get_coarse_ns:
>  		return &bpf_ktime_get_coarse_ns_proto;
>  	default:
> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
> index 48a9d978aaeb..0a0608b6b4b4 100644
> --- a/net/mptcp/Makefile
> +++ b/net/mptcp/Makefile
> @@ -11,3 +11,5 @@ obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
>  mptcp_crypto_test-objs := crypto_test.o
>  mptcp_token_test-objs := token_test.o
>  obj-$(CONFIG_MPTCP_KUNIT_TEST) += mptcp_crypto_test.o mptcp_token_test.o
> +
> +obj-$(CONFIG_BPF) += bpf.o
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> new file mode 100644
> index 000000000000..da79dae559b2
> --- /dev/null
> +++ b/net/mptcp/bpf.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Multipath TCP
> + *
> + * Copyright (c) 2020, Tessares SA.

(I don't mind if you add the entry you added before under this one ;) )

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
