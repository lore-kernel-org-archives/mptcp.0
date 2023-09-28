Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A925123C
	for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 17:11:26 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-532c81b9adbso16743211a12.1
        for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1695921084; x=1696525884; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hYWNSZZSYoFbH32gV8OaMXcvHaicTguaR0A4sg6KjhI=;
        b=8XCFA4qGKw5OzJ7iki0kq0e1kJySGTSopUp8t+8FI7OT3q8/3sVjrGoGWxwrPbAsGB
         pI3qLaPY31leKTna0k3Bdyk6lKRcvnmfO1ZBZGdOH8INcRVWLuHfFZLDHUcRPXCcuxDF
         7hi8S9mqh2x3UZED0+M8Xof78Z3ED6RllJsHljnO3RmdxlYAp155q4DbrTkYCINxk0gi
         fl87Id6L43SxlFLdtkmUj/6T8HjLjd4N1HUNP2lJJ3/HnryLCFejevJdIDimPzveMvgP
         VAUhoFb/54t08Q8Sakm4R+AMBneEpp5661JGGRywixMKrLh8vVFCN3c3O5cPHc5Ysjf6
         aESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695921084; x=1696525884;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYWNSZZSYoFbH32gV8OaMXcvHaicTguaR0A4sg6KjhI=;
        b=YqP8Pf4UR8dcb/t0iM9zDYxKDhSmfEE8ZdM75aBS6nyDbXYVmxhJSUvDH4yrRWq6lc
         DmMOnNbHc8UqrMSRjYV081EFpyd6ff+1ZH6XOX1hNcpG87WrTZu8IO4EOAfK68inn7B7
         Luq0P5jX534Z1Zb2a+Ti3mlJq6gTGX2Vi/VUerp0w8714DD+xYpzsEvMkj7gQ9V/uY54
         C2jApmF6wSUGYELxTQpiP+DCSATVyilbLYOSRxgNfXxd4VhXHA1Mhuf/ZduAH30THO9N
         wd8plv+IgvyjZUYdNDaL7lfFV0Nwsr5iLJewF4oVVAiutnVxbb6jZa+AOgsy/YAr8Kak
         xoSA==
X-Gm-Message-State: AOJu0YzFaDDPEW8LmpgJ/GrjAyhHgLkJ0DY2eZosmWoWcO15G/hxjTjf
	3uADmQKaHUYkYL9Elu1KJi4Gew==
X-Google-Smtp-Source: AGHT+IFWqxu/pb2RvvHqzi1uWYtZIr50WICQJVSRt2brkFSNCgFS5a1apy7+CzKufWt1LjhZP07HOg==
X-Received: by 2002:aa7:c2cc:0:b0:522:3d36:ff27 with SMTP id m12-20020aa7c2cc000000b005223d36ff27mr1712994edp.31.1695921084703;
        Thu, 28 Sep 2023 10:11:24 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:61de:313e:ae4a:9b5b? ([2a02:578:8593:1200:61de:313e:ae4a:9b5b])
        by smtp.gmail.com with ESMTPSA id d7-20020a056402516700b0052f3471ccf6sm9965191ede.6.2023.09.28.10.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 10:11:24 -0700 (PDT)
Message-ID: <215e55a9-74df-4df1-867c-c942cea85283@tessares.net>
Date: Thu, 28 Sep 2023 19:11:23 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] Squash-to: "mptcp: give rcvlowat some love"
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <56f04f69f7e7c37e0a1820787f7e9063a50bf937.1695911979.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <56f04f69f7e7c37e0a1820787f7e9063a50bf937.1695911979.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 28/09/2023 17:52, Paolo Abeni wrote:
> Christoph reported a couple of serious splat caused by
> the mentioned patch.
> 
> mptcp_set_rcvlowat() can use msk->scaling_ratio, before
> such field is initialized, causing a divide by zero: we
> need to init it in the sock constructor.
> 
> Additionally the same function bogusly cast an msk to a
> tcp_sock, causing memory corruption. The reproducer likely
> clears the sk refcount for the next msk allocated into the
> same slab.
> 
> The intent was to properly propagate the rcvbuf changes to
> the subflows. Let's do that explicitly.

Thank you for fixing all that!

> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> --
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/442
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/443
> 
> since the above issues are introduced by the squash-to patch, I think
> we can't have the tag in the final patch.
> ---
>  net/mptcp/protocol.c |  2 ++
>  net/mptcp/sockopt.c  | 17 ++++++++++++++---
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6f9e116598ed..3ef6368e26f6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2758,6 +2758,8 @@ static void __mptcp_init_sock(struct sock *sk)
>  	msk->rmem_fwd_alloc = 0;
>  	WRITE_ONCE(msk->rmem_released, 0);
>  	msk->timer_ival = TCP_RTO_MIN;
> +	msk->scaling_ratio = (1200 << TCP_RMEM_TO_WIN_SCALE) /
> +			     SKB_TRUESIZE(4096);

I see that the code in TCP is quite recent: dfa2f0483360 ("tcp: get rid
of sysctl_tcp_adv_win_scale").

Do we want to add a new function in include/net/tcp.h which returns:

  (1200 << TCP_RMEM_TO_WIN_SCALE) / SKB_TRUESIZE(4096);

and use it here and in tcp_scaling_ratio_init()?

>  
>  	WRITE_ONCE(msk->first, NULL);
>  	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
