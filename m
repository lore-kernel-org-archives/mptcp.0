Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EFB4689
	for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 09:05:01 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso640423f8f.0
        for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 02:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692349499; x=1692954299;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XNPmmPTld695wdC2gh0ik9JBKsZdYF7hlaTrtxrZYFc=;
        b=JQzhH/IHLwHbpLOy2ypL7fGyG51f16daKCiPNgep4mHzFQ1oxQXJ7K0CELgmF/Fzdj
         FHfTt4i7esQ6/4/NaAYfPJcja6iUncvokI6tdskuJAlwcGNQ1XtRXIvK3Ef7NG357CZv
         JBbfa78660v13GL6EAJ38v2POYaav8ePCMk4bp7hgFyFeVuHhlw7l8jawAYXhHX2kRON
         r5sOU/nDP7Tr7WC0AVwFIH1HsGANegiHNzmQYkL04839XByaiGB0X5319Xa9oCX6PZl5
         9O4YPuTatpkSBmuJ4D3ZR0uUvvua0/Q+h/m7AbZmaurfDwatt6//HRw6ztA6k7o3pNSA
         gYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692349499; x=1692954299;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XNPmmPTld695wdC2gh0ik9JBKsZdYF7hlaTrtxrZYFc=;
        b=ENggnVEGU4tlu6zpj+EyhflvHScGTQmmyEmPLAvnHBAN8zQU00KjGWoKS/5BbAWBS0
         rbvs4EbZ3NNVypuWbimL9yajNXkmlCtA8kfiSJ0czDE2lOJqcGZ7DZVxe9TXGJwCWOSD
         5w5GAMYMnYzvIu25Ydo+3fzHGRVSBkAi9ziNZPFPlJPgvDkJbfCakr0LhD9VP86Y6cnh
         +X7vR+1iKvQJj00gqs9EzFezNgHDf7HYCWPNYtaXTXZj+yCLjPHldi5+7f+m3PkHdo7r
         CT+mmOh/TJN3ibXnEsoeloHmT40Nju5ETAEeX0C6CkgPoyzKjgksao4PYYvB+mqZyfUQ
         uHCQ==
X-Gm-Message-State: AOJu0Yxca2suS3F1QSU8XQe+WSOtrZmKvHBzAPF4BPzw+7LM9iaH4cde
	7B+UcE9553mHBv8maxuQIdRH7Q==
X-Google-Smtp-Source: AGHT+IEzrqOwLzF6J52ldAV32jt+MijGlPCLOsIzgC+XyoEvbXBhMX/8Ta7kOcRz0WZVNhggaGIz1Q==
X-Received: by 2002:a05:6000:1141:b0:317:4ef8:1659 with SMTP id d1-20020a056000114100b003174ef81659mr1490364wrx.28.1692349499313;
        Fri, 18 Aug 2023 02:04:59 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id s15-20020adfea8f000000b0031807bd3614sm2076786wrm.90.2023.08.18.02.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 02:04:59 -0700 (PDT)
Message-ID: <ae0f37fb-d5ba-4019-8fee-f5d8fb7b9366@tessares.net>
Date: Fri, 18 Aug 2023 11:04:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 5/6] Squash to "bpf: Export more bpf_burst
 related functions"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1691036765.git.geliang.tang@suse.com>
 <644d34afc1b3b8d72b7c87baf099417d0be561ec.1691036765.git.geliang.tang@suse.com>
 <b2f50040-0373-4e5e-b4d1-f94c40e2f2b6@tessares.net>
 <20230818083931.GA21065@bogon>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <20230818083931.GA21065@bogon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 18/08/2023 10:39, Geliang Tang wrote:
> On Wed, Aug 16, 2023 at 01:55:01PM +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 03/08/2023 06:27, Geliang Tang wrote:
>>> Add "ignore -Wmissing-prototypes" for bpf_mptcp_subflow_queues_empty(),
>>> drop the declarations in protocol.h.
>>>
>>> Drop bpf_mptcp_subflow_memory_free(), it will be defined in BPF context.
>>>
>>> Update bpf_mptcp_subflow_queues_empty().
>>
>> I also had to partially revert this commit.
>>
>> Maybe "__bpf_kfunc" would avoid such issues reported by Sparse?
>>
>>   #define __bpf_kfunc __used noinline
>>
>> Do you mind looking at that please?
> 
> Hi Matt,
> 
> "__bpf_kfunc" doesn't work. I have to ask BPF maintainers what to do for
> this and hope to receive their response.

Thank you for having asked!

Good idea to have asked on the previous patch, I didn't see that
netdev's CI complained about that on this one:

https://patchwork.kernel.org/project/netdevbpf/patch/ac84be00f97072a46f8a72b4e2be46cbb7fa5053.1692147782.git.geliang.tang@suse.com/

We can see a similar warning for update_socket_protocol() in
netdev/build_allmodconfig_warn and netdev/build_32bit results.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
