Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3974C8D0
	for <mptcp@lists.linux.dev>; Wed, 16 Aug 2023 10:47:19 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso60084495e9.0
        for <mptcp@lists.linux.dev>; Wed, 16 Aug 2023 03:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692182838; x=1692787638;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JCx8mic/YOrYGST3bPLPtwes8Nd3PHV0HUaNXoydHDY=;
        b=K5LaVI+X2tj3fuqyYViJekiAo7lQa2V9zfxSa+6/YtVtTEHeYQyh2QHpGIhSSgxJuS
         shgFpPrBtLexipqrmnj1GFnksHE8y1/S0MxbyOc2do1UeyzGSfPtihJ/YbZ/m7Bv0VkX
         Psu59FUBwhsJD8YmSIXJ7wPQiYJAa/xQv6sqmaUOVpwyuGCE8KuNdfEiVKX5NrbS1UHj
         Cb4jr6fzzB62Fb3puW4qooc1K7K4Lb9FLdPOCUQfCHm2D7S6YT9tjf8qukKJid2eAoYN
         efHrIuXMYQQ+PQPoVvDF0EPas1BEOs786TcgJrIiQ6xLXpWouhFrr5aNSA5VzRwRjApF
         eZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692182838; x=1692787638;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCx8mic/YOrYGST3bPLPtwes8Nd3PHV0HUaNXoydHDY=;
        b=E52FsbL0+6lKHLruB6REiMVfALIc7Z4G5Lw3omgF6H9nkqOFyY39BVwWOak6D2d/5Q
         1+A54EdlvGNq9VrgPAw+qI7pKrQbfxD+3scZYath8hrJervIk6Xz72Ty8k6MgAozAEPl
         b/5yS5XW7MCQfyQJYicViRJmIyIB9iXbonx6GR+ZPbFJGJN8bn8+uv0LxLDhoZdpp/sp
         lQUqQzv9oMZh/0ynN9alWyzDj1jYbuauuknVtJLqCAiB1yxcL+glHnpWMwvGGbIwt2AJ
         EXojoeG/H6fmgDiqu0GUkJ3+WVqSTVyQy7Y090CO/C61epRNASGx9U/8L3NYlNrbhCYF
         Hb6g==
X-Gm-Message-State: AOJu0Yzq9oeTeq+v07/agxSlb7tds+5bI9+cmbYQ+qkd0hiWsKndLUnk
	Yo9ZSzxKHXD65LRtzq74bKA6ukTOtV+C4bjf3f0=
X-Google-Smtp-Source: AGHT+IHt6LhTqtdc3LYyQbzz9cP56IrrZWAmu5vtiORnRVzg51mf3DfBNz8rCIQnwBrVOJ+3jlJKBw==
X-Received: by 2002:a05:600c:1c17:b0:3fe:485f:ed1b with SMTP id j23-20020a05600c1c1700b003fe485fed1bmr1044665wms.28.1692182837031;
        Wed, 16 Aug 2023 03:47:17 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:8c09:b284:9ea1:cfb8? ([2a02:578:8593:1200:8c09:b284:9ea1:cfb8])
        by smtp.gmail.com with ESMTPSA id l24-20020a7bc458000000b003fbb25da65bsm20772377wmi.30.2023.08.16.03.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:47:16 -0700 (PDT)
Message-ID: <6d0f8071-b3e6-4ee2-b243-70916e4066ec@tessares.net>
Date: Wed, 16 Aug 2023 12:47:15 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 1/6] Squash to "mptcp: add sched_data
 helpers"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1691036765.git.geliang.tang@suse.com>
 <c5fabbf0010db69bbe7ed2824a8285f9401df09c.1691036765.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <c5fabbf0010db69bbe7ed2824a8285f9401df09c.1691036765.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 03/08/2023 06:27, Geliang Tang wrote:
> Add "ignore -Wmissing-prototypes" for mptcp_sched_data_set_contexts()
> and mptcp_subflow_ctx_by_pos(). Then the declarations of these functions
> in protocol.h can be dropped.

I just had to revert this patch because it was causing issues reported
by the CI when using 'sparce':

> $ touch net/mptcp/sched.c && make C=1 net/mptcp/sched.o
> net/mptcp/sched.c:203:6: warning: symbol 'mptcp_sched_data_set_contexts' was not declared. Should it be static?
> net/mptcp/sched.c:223:30: warning: symbol 'mptcp_subflow_ctx_by_pos' was not declared. Should it be static?

Would it not be better to move these two functions
(mptcp_sched_data_set_contexts - mptcp_subflow_ctx_by_pos) to
net/mptcp/bpf.c where they are "used" with "BTF_ID_FLAGS(func, <name>)"?

Also, when I look at other kfunc in the kernel (e.g.
bpf_skb_set_fou_encap()), I see that they are also always declared where
they are being "used" (BTF_ID_FLAGS(func, <name>)) but also they are
declared with "__bpf_kfunc" and the function name is prefixed with
"bpf_" (which makes sense if they are BPF specific). Should we not do
the same here with these 2 functions + bpf_mptcp_subflow_queues_empty()
(only "__bpf_kfunc" is missing for this one, it already has the prefix
and is declared where it is "used")?


About the revert:

New patches for t/upstream:
- 1701483e1326: Revert "Squash to "mptcp: add sched_data helpers""
- Results: ac006cd93f91..d30c287ad522 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230816T103753

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
