Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F063C8
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 08:10:53 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-313e742a787so3470076f8f.1
        for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 01:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1695111051; x=1695715851; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ix7uRFC0/JWdbRvtkSmRqWU5+U8mO2uxfg3vdgMHHjw=;
        b=te04idAExPncaZUJuIjN3yG/gBr0WAAz2o/gtd89QDno4/rU2JyBZvdfdEsF2lblk2
         LZTgEkouKf4tRLhdru7HSBqUcrRzA70luYUlMjiE8hUSN+i1AFA9CMh4A7he0CkqJr1t
         6XR5dzMniDdSUo4dqbj1mybYzwbO+AHtGI9FTFS85Dp5J7OAw8zvfbJtF5s1FVtRMJef
         G1L7Y27Ard/3elA4Z6I+Y1fSviw4Ub6uM7BrdkJWrKx/mPtSBb6aQNeNINl1plEOGCcX
         I0hpCgMjZDuBxTFoaQqjpHRpurA6BIBTr5a1MksXcEiqbbiIjwnuQmF45X9hKoqFCSsI
         v+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695111051; x=1695715851;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ix7uRFC0/JWdbRvtkSmRqWU5+U8mO2uxfg3vdgMHHjw=;
        b=vkv+kNGkSDwIgXJiKNjrp90NYIek0xoG02PftJqOtKKyrnBVM3s20h8dnOIyKLfgpz
         r61VDFo454zbWTXzouiJt19utARKIJ9Tt/WkI5se1QDTP+zDJ8S/PDkcJjohQQ7awAu6
         izl2W61PP0ItFjMQ6TKr6JlxpCV0pu8qiVlu5emCn657bRJDR5qlLHRc8BXMy4e5N2lP
         PeOLr8y8B5JQaxImO1l6PQT7Ytz/CEJ7zlYgzr5Z2V2ozKLIhfHTYolVyPM+PWnh7X4a
         L6WjVw91A3m9R+NdXYWvBzzz1tTx+InV+dS0Fd2h3g0eUTzkFSpEVPgMHXPb1dUFJgxa
         c9kQ==
X-Gm-Message-State: AOJu0YyVXio0EbMyxVIWPkUP7jZCWdumX8aHg7U60Udg0DEWc1UXHEp+
	a5F9HH8p4m+Ou2WqbuZYmGGZArLz6PiiLV/WqVK/lg==
X-Google-Smtp-Source: AGHT+IFlTs7v6MN2pjqS9ccLDxp+nPGofi50tkiIL6YZun8TRP7FZ7CbXWaT9ztHYxv+cuvuepePGw==
X-Received: by 2002:a5d:678d:0:b0:321:57a5:6e6c with SMTP id v13-20020a5d678d000000b0032157a56e6cmr1510981wru.34.1695111051377;
        Tue, 19 Sep 2023 01:10:51 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:61d9:bcd8:32b9:948b? ([2a02:578:8593:1200:61d9:bcd8:32b9:948b])
        by smtp.gmail.com with ESMTPSA id z15-20020adff1cf000000b003179d5aee67sm14656008wro.94.2023.09.19.01.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 01:10:51 -0700 (PDT)
Message-ID: <a6d90446-2604-451a-a148-5bd9321dc9ed@tessares.net>
Date: Tue, 19 Sep 2023 10:10:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: selftests: mptcp: add mptcp_lib_wait_local_port_listen: Build
 Failure
Content-Language: en-GB, fr-BE
To: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
References: <32a7f528dfd2ccb083f99dcec9ad8b3ba9717686.1695095289.git.geliang.tang@suse.com>
 <d9d64dbf-675e-1582-94e7-b2a74b8d585d@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <d9d64dbf-675e-1582-94e7-b2a74b8d585d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for your modifications!

On 19/09/2023 06:45, MPTCP CI wrote:
> Hi Geliang,
> 
> Thank you for your modifications, that's great!
> 
> But sadly, our CI spotted some issues with it when trying to build it.
> 
> You can find more details there:
> 
>   https://patchwork.kernel.org/project/mptcp/patch/32a7f528dfd2ccb083f99dcec9ad8b3ba9717686.1695095289.git.geliang.tang@suse.com/
>   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/6231100070
> 
> Status: failure
> Initiator: MPTCPimporter
> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/39f55eef611a

It looks like this failure is not due to your patch but to another one
from upstream [1].

I sent a workaround for that in our tree:

- 028d1cfc930c: bpf: Fix bpf_throw warning on 32-bit arch

So no need to worry about this issue.

Cheers,
Matt

[1]
https://lore.kernel.org/mptcp/fb51f3ed-a8aa-42f1-b649-eb684235323a@tessares.net/T/
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
