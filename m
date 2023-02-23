Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD2B258F
	for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 13:55:22 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id 6so10342082wrb.11
        for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 05:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uaWVLXm3B35gvyfujHMYtS6qqbA24gbcf7S5ZGwF4Oo=;
        b=LMQ32eHPB/iXPQEiTda8GbBLW+Cmpk1bkinIh2fDz94lT7STBSLHU0FnH/4k825Hla
         BghSvI8EkSY3oOgSYd4dA8QyuUSRew/1633ncCNwPk0Qo3oZJ3Tvv7fI81gy8+8X9lkN
         YsXl3RgCpznPFyJIdbPBH9/p9+TA44+vmt3A1U9fsQTX3KLYcAZAlFIFvaXGevMFc2OJ
         KpfaSRo01TIlCZb/tgpP7tsq/LdWBoKHcr05FbyD4FwEnpF42pY/mjB0vhkgKZoiFnhv
         Afh/jekenaoQQ++Lytm8rJ8EAqcFCPjR8qTtth2780H6Oz2TMa8l0Wvz+cDbYcOl3/MA
         wLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaWVLXm3B35gvyfujHMYtS6qqbA24gbcf7S5ZGwF4Oo=;
        b=Zf4kjh+dpnh23p7E01sofaBzvh8F1l30RkZS2wofq+QtobhoT64gMaNLp9zGpGGOAx
         iwdbnNsUFT2b/KSHwjUXI9Hvm87+j2s8Uj9O6+v9rqdtOXggADtK+3g2E9wR0j9hKF37
         0tZqXhqpoM2FRoSR7W860bna88m9H4uTM58L6K0db7YZDG35HYOalmKNSZoC6FfRoe9J
         RJW8ibnqss3byR0osw7mjai6yinmxeZBNaQzVpVE4sYtNUu0fgcQCpdSTH8UGfSlGFa0
         1wjCR/HkjLq7xq5FxVEbWtyoUbVl3CYMgABHQfO71RING52HQPCkCLdju5zn1+fnSK5D
         gSpQ==
X-Gm-Message-State: AO0yUKWmTTE9Qwib7wbJUFxOKPZw94PXJE4WHN1AWzEr335TmeLD7t5q
	Ss5ndjjCQGAg/LLRF8i2LZVyH9cpZGnxduQs1SA=
X-Google-Smtp-Source: AK7set84KvzKzPUWikZh0YeOzmqS6ILUiDikf4bQYuw0yoKfMBqhznhaxq55goYDYFW+HCFQMJWQYA==
X-Received: by 2002:a05:6000:80e:b0:2c3:be89:7c2a with SMTP id bt14-20020a056000080e00b002c3be897c2amr9814173wrb.13.1677160520728;
        Thu, 23 Feb 2023 05:55:20 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:b5a0:3898:2dad:3d15? ([2a02:578:8593:1200:b5a0:3898:2dad:3d15])
        by smtp.gmail.com with ESMTPSA id r189-20020a1c2bc6000000b003d9aa76dc6asm3681112wmr.0.2023.02.23.05.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 05:55:20 -0800 (PST)
Message-ID: <55591ba8-d9d4-2f79-d7a7-cd586b54a805@tessares.net>
Date: Thu, 23 Feb 2023 14:55:19 +0100
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

(...)

>> Do you mind if I change the target to mptcp-net and add a Fixes tag when
>> applying this patch?
>>
>> Fixes: b19bc2945b40 ("mptcp: implement delegated actions")
> 
> Fixes: 51fa7f8ebf0e2 ("mptcp: mark ops structures as ro_after_init")
> Maybe this fixes tag is better, WDYT?

If you don't mind, I will add both: the one you mention has been
backported to v5.10 while the other one is only in v5.12.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
