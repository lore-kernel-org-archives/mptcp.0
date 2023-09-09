Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E90B6FAC
	for <mptcp@lists.linux.dev>; Sat,  9 Sep 2023 15:27:53 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-401b0d97850so33206845e9.2
        for <mptcp@lists.linux.dev>; Sat, 09 Sep 2023 08:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1694273271; x=1694878071; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDMBGGAklP52nAyz2giFEAYmVgQJt4kIMxavcbEWOK0=;
        b=BxSYb7UgXniBXvTjEN+kKJ6VdjgAfrIf43uNRWQHXAmVfjSJ29sVMpTlmtRwEcV35h
         9oGWUBryMu7F3ihO8fiktCth2ps/9DISwT4w4sF+5ST8HLEjpOCdBbyCXnfz3noXykgO
         S2FvHst6t/LmUCQ7bWI+2rQiw9eCQWJuy0rOYOriiTzDOeBacXDIHiWqSDuT/G/8PV3K
         blLBZWCqRyYFaUNqTkgNssSpea6dpUrA/9FshY4TCsQtNcMRZdPCkzVPmdFPf9TK3bYE
         tIeqvPZPy+D4wMos5mV9+TgpUJgdB1j1U9NyAY4ummmJvUfEON55sRSN6jjV46LgPVh4
         /i+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694273271; x=1694878071;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDMBGGAklP52nAyz2giFEAYmVgQJt4kIMxavcbEWOK0=;
        b=npJv3WbnJrrSX2v5KdeR0qRiSFvXpkosof4S/922ySE6IGrXaoSeCHJWiCFrksAZtp
         YV6sPJR1LHrAkeIFqhMIdXDzl3G2vBxv3hrryKwYYO2oGKm5iCSpfmGXC7WrI6DeW5G8
         A1u9Zdei8B2vxSP3HkY16hn1Xg4DyJSM6tgXuI8+uBORsBxaWXRowFtD7uVdhyihA/qL
         Esl3OVYa+hEkFq/cljGn48Q8w1nZXwnf5zpICNFMV9E+7gzGcYQ5yYTd7AlQg5dDVger
         EQQ5AIy5DIc7WkDQh2Y3BaG7qrjv7y0i73pas+RvzpExA4LzbaW7jQBiF0Qbr4bz6cXv
         arcw==
X-Gm-Message-State: AOJu0Yw2atXd+uWKRUf0CQQT7577UMnWe5jRWQtHnBe6G5jMwaoeo/X4
	FCcBWA36q6/b//3TNgbU+K/fFw==
X-Google-Smtp-Source: AGHT+IEg3zz8Rgk3+SkUHK9rCqnB0Hw8t9NxmqMcd1pURP4Qb+d0VxrdFC/Nt9yzpWoM0AAWmhenJw==
X-Received: by 2002:a1c:7508:0:b0:3fe:d1e9:e6b8 with SMTP id o8-20020a1c7508000000b003fed1e9e6b8mr4609867wmc.12.1694273271375;
        Sat, 09 Sep 2023 08:27:51 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:91e4:ea9f:cc1e:927a? ([2a02:578:8593:1200:91e4:ea9f:cc1e:927a])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c204d00b00402d7105035sm8025901wmg.26.2023.09.09.08.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 08:27:50 -0700 (PDT)
Message-ID: <57024262-402f-41d3-901c-23b53645197a@tessares.net>
Date: Sat, 9 Sep 2023 17:27:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 0/5] add bpf_stale scheduler
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1692344463.git.geliang.tang@suse.com>
 <b8475d7f-24cf-4518-255f-4d9d5405ba1a@kernel.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <b8475d7f-24cf-4518-255f-4d9d5405ba1a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 02/09/2023 01:00, Mat Martineau wrote:
> On Fri, 18 Aug 2023, Geliang Tang wrote:
> 
>> v3:
>> - init sk_storage in .init, delete it in .release.
>> We invoke bpf_sk_storage_get() to get the sk_storage map many times. Only
>> the first call is the slow path (see bpf_local_storage_lookup in
>> kernel/bpf/bpf_local_storage.c), alloc the map and cache it. The
>> subsequent calls are all in fast path, the cache hits. So we should
>> first call bpf_sk_storage_get in .init, then call it many times in
>> .get_subflow.
>> - if no subflow is scheduled, it should return '-1' to indicate an error.
> 
> Thanks Geliang, patches 1-3 are ok to squash.

Thank you for the patches and your patience!

Now in our tree:

New patches for t/upstream:
- b2afd09b16a1: "squashed" patch 1/5 in "selftests/bpf: Add bpf_bkup
scheduler"
- ff989d90d2ea: "squashed" patch 2/5 in "selftests/bpf: Add bpf_rr
scheduler"
- ff0afb0f9763: "squashed" patch 3/5 in "selftests/bpf: Add bpf_burst
scheduler"
- Results: 86fa15fc9c4f..07a689bb4cbf (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230909T152638

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
