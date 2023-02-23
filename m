Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B720F258F
	for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 13:49:58 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id p18-20020a05600c359200b003dc57ea0dfeso10531231wmq.0
        for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 05:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uAAoXHk9mX8rCcoccCGHlQnGF9rmRaN7RFLV5C/a6nE=;
        b=mXD/XBLfdcmo1i/Yy5s93AS0y49p8wb05bLcHmD6h90a97hhD5NVW2isc2QybMHS9s
         RpeIVtaPU0/ZY/MVJllAQxABibKXnzl6OQ5Y9PrW0JSqSlGKbY92vgfc+21XfKaI954N
         AKHMN3ibpct2sJKRPEj2nrBcG5LC7NxpMBuDgPKxulk0lKUyOOvdsN5HDU6jr0AxTvH0
         5SGE0TTIUWqp5zPR+dso38pUQRLijHQjtINf+qDywhOvtLkE/vYJvu44qN2Ih2bRfKYu
         FEOz/GD2NYGkOXTxfsVj0+vf1fCdgitOqAkqg+lTTJfR9Srp1WnVr9NU0+/aYA/2Q9RF
         0ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAAoXHk9mX8rCcoccCGHlQnGF9rmRaN7RFLV5C/a6nE=;
        b=6bEKAuZYL5946A92bFtV9F4MRTIFxr+sz1qQXFq71jRbxg+TmncEQbP8F4/SRjzHVL
         9k9AS36ztj7pMV0i9D4eugxNKQw8AZJFz/XtHNK0IjVEHbIvV3W7DTEYc5V3PJzgUPk6
         Xm4ANlRjVGI/d0530JYi8kXO04D4R02PJMqfLfgqlIy3YM3BmHmx3CXudA103L1cUtMr
         MD1Nv2FBAP33PwVLDz4K3prDEsSB2p7iuUp4IlZDN/ck+8V/SglkMHK6iH41MfiMGbvM
         K3nLN/O7kvb/TfjnTPp71cvrXLO/ncZQCmkhMcA/VZfdXJxriyMHE3RhWJFfzxZgmqmp
         hQ4g==
X-Gm-Message-State: AO0yUKWHhD1xSYh1AWjMCfxAdP0zTSG27+ckv4b3gF9/mEeFyyT9uE5m
	DLVkFJC+XCf5J/4fIbpedKrJbakQ0MnXx5rxPeA=
X-Google-Smtp-Source: AK7set/8WgvwsiuRJiEfNhZfbAH8T3aUP/X11+23BzM2uQMqsJhd6FQnjuTpKIPDCUrfUTnVwG4EHQ==
X-Received: by 2002:a05:600c:492a:b0:3dc:42d2:aee4 with SMTP id f42-20020a05600c492a00b003dc42d2aee4mr3295493wmp.25.1677160196700;
        Thu, 23 Feb 2023 05:49:56 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:b5a0:3898:2dad:3d15? ([2a02:578:8593:1200:b5a0:3898:2dad:3d15])
        by smtp.gmail.com with ESMTPSA id bi27-20020a05600c3d9b00b003dff870ce0esm4347948wmb.2.2023.02.23.05.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 05:49:56 -0800 (PST)
Message-ID: <a60ca644-0139-26e1-bf5a-6817adeb7e5c@tessares.net>
Date: Thu, 23 Feb 2023 14:49:55 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH mptcp-next] mptcp: add ro_after_init for
 tcp{,v6}_prot_override
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <f2d3a14b9382645f8770ad6496fcba6db699ad19.1677123443.git.geliang.tang@suse.com>
 <db64d10e-3887-fc95-a91c-33408e3670f9@tessares.net>
 <20230223133558.GA2878@bogon>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230223133558.GA2878@bogon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/02/2023 14:35, Geliang Tang wrote:
> On Thu, Feb 23, 2023 at 10:10:25AM +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> Thank you for this patch!
>>
>> On 23/02/2023 04:37, Geliang Tang wrote:
>>> Add __ro_after_init labels for the variables tcp_prot_override and
>>> tcpv6_prot_override, just like other variables adjacent to them, to
>>> indicate that they are initialised from the init hoos and no writes
>>
>> (Do you mean s/hoos/hook/?)
> 
> Yes, it should be 'hooks'. Please fix this for me.

Yes, I can do that!

>>> occur afterwards.
>>
>> Good catch!
>>
>> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>
>> Do you mind if I change the target to mptcp-net and add a Fixes tag when
>> applying this patch?
>>
>> Fixes: b19bc2945b40 ("mptcp: implement delegated actions")
> 
> Fixes: 51fa7f8ebf0e2 ("mptcp: mark ops structures as ro_after_init")
> Maybe this fixes tag is better, WDYT?

Good idea!

When looking at 51fa7f8ebf0e2 ("mptcp: mark ops structures as
ro_after_init"), I wonder why this flag has not been added to
tcp{,v6}_prot_override. I guess we just missed it :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
