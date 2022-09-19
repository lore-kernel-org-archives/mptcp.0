Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9939C4A1F
	for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 11:22:29 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso4456144wma.1
        for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 04:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=e5CMxCFxDSTBA3tdwylqWIUDJI/5ayknjvgIVR7SiXg=;
        b=ITXl9M0NSgCF6mRHYElwAZFuw+GbR8koEH/0viLrXPlmwvXa5SF4ubJ1feCgeOQNOJ
         k38Zt+2oi+EbTY3AVKkl16gf/RHwJx1sWtjhmUkLl1V7DMk89i+s0Twp24De9AizyzMu
         1UfPsgY/gLQ1Gu5kmDoUGy8Cn31ql68lYX9DQ/Q7jUAcDo6r2mGUyIsBNoI8bAAbKEzF
         SMh3flaog0YvkJX2n+jU4swdi+rVysLZPrqcbmgBm2ZODwn0tsC24ZsXUWChdH0FxjH/
         MNIE1/4Af8PQv92Zx1mEFDdBL+z/OFNdijSX8J4auz4a5AqpATGj1Va47nLc3nsaYADA
         v79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=e5CMxCFxDSTBA3tdwylqWIUDJI/5ayknjvgIVR7SiXg=;
        b=myJ2hrJLOiwcT37nQ5PpWchrlL9srMj6mW57sGHDFJKn9s87lDYuYsnF9o+3ohS2Kv
         jbpYDKTCnZ71IXxauD0zFXc48pXaAhOn4a/PFNndRIxYAhuZwIkN6i6BZ0IkYnnCDNV9
         dOeKr4fw16XxU4OXXD0c1oH5CfmIxd0+w1+xWxF6yA0WcCs28PzEnt5NHbtPrDt5/K8C
         sFjUSMH6UT7Iry0yqmgMPVYjs0dOFWKuDmuLy6/qvgO5Cf6ypfpgdvJo9NHO4K7tJKcI
         34Msc9+RHBzrSrUVZVTkh+gpfnDyxOrvvd0SVv9z9AjzpMgOJ/SbmqhO3p6Sm2yhGfzO
         h5Kg==
X-Gm-Message-State: ACrzQf1HkQfeY9OUPD2hZx3hYBk0rslsNJqjqQfjx5/cvF5nrTPfj+G0
	7duwdJd0uyWetAgSX7Wt9ri0LA==
X-Google-Smtp-Source: AMsMyM4JuDgHz3eZhXoG5umQ7LhyHlWieKDR8Z0sK73QU5pqJ4GuXvvTTAaM4crsD33fOcF99LgWNg==
X-Received: by 2002:a05:600c:4606:b0:3b4:62b3:150b with SMTP id m6-20020a05600c460600b003b462b3150bmr12070604wmo.3.1663586547424;
        Mon, 19 Sep 2022 04:22:27 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id b14-20020adff90e000000b00225307f43fbsm13626749wrr.44.2022.09.19.04.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:22:26 -0700 (PDT)
Message-ID: <369dc9a1-eb92-00d3-0447-81e5e017d728@tessares.net>
Date: Mon, 19 Sep 2022 13:22:26 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH mptcp-next v7 03/11] Initiator: MSG_FASTOPEN sendto().
 request cookie
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Dmytro Shytyi <dmytro@shytyi.net>
References: <20220917222853.2406-1-dmytro@shytyi.net>
 <20220917222853.2406-4-dmytro@shytyi.net>
 <e1e8bfbc5f3ba023e01354e62c4f3a28f69c0bca.camel@redhat.com>
 <7f09e484ec0d6068d62bca82d4ca907a09db64d5.camel@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <7f09e484ec0d6068d62bca82d4ca907a09db64d5.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Dmytro,

On 19/09/2022 12:44, Paolo Abeni wrote:
> On Mon, 2022-09-19 at 12:35 +0200, Paolo Abeni wrote:
>> On Sun, 2022-09-18 at 00:28 +0200, Dmytro Shytyi wrote:

(...)

>>> +	skb = tcp_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true);
>>> +	if (unlikely(!skb))
>>> +		goto out_EFAULT;
>>> +	iph = ip_hdr(skb);
>>> +	if (unlikely(!iph))
>>> +		goto out_EFAULT;
>>
>> Use only lower case for macro names. Also EFAULT is probably not a good
>> return value. EINVAL should fit better. More importantly, it looks like
>> this check is not needed ?!?
> 
> Addendum: you probably need to add/duplicate the full checks
> implemented in tcp_sendmsg_fastopen():
> 
> https://elixir.bootlin.com/linux/v6.0-rc5/source/net/ipv4/tcp.c#L1174
> 
> lines 1174-1180

We discussed a bit about that at the last meeting and I think it might
make more sense to re-use tcp_sendmsg_fastopen() like Benjamin did in
his seris, see patch 2/10 and 3/10 from [1].

I think there were just some confusions here: it is not forbidden to
modify TCP code. Of course we don't want modifications for MPTCP
affecting TCP perf, especially the fast path but here, it makes sense to
export some functions to be re-used in MPTCP instead of duplicating a
big bunch of code.

It is not needed in our case here, it is more a generic comment about
MPTCP dev but I think we can also say that if needed, it might make
sense to refactor some code from TCP to export a part of it, no?

Cheers,
Matt

[1]
https://lore.kernel.org/mptcp/20220908133829.3410092-1-benjamin.hesmans@tessares.net/T/
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
