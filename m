Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41C016409
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:28:48 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2af177f12d1so65557191fa.0
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685543327; x=1688135327;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bqxc1gQBmFfkqN2gkqKodtkKlqw3ckKgE7BeEOJc8x0=;
        b=tZVts0NbWTML4sVgtK/21YjfoEF5m4h1Qal0tXly8hGaLjGt66Z89kQnL4JWxS5Hrr
         meTGkj0tm6qbRx9qc/PrMfUoNSepDWSxbuF4y2dlb+MvgEIlv11sGWBlaNiJC2t3NH1G
         7Of8BhXlC57iB9jI+/FG8/82dJs2BKhOo2QvTgsvMuhZ2/Mg8QvEa40Synku0hoC1rkH
         kE284EpCpa+Z8VDC6xnwTkh9aydw5vJYx5NRrMQl/I4cF3Jm7zlQ87SOWiasTnmmVLui
         zleNllaQO3pFNK3j9nLpsDMA98c8C8vEm+tbHb5WaBUZGq2P4VHxPDPaZ/SqgFhLxkTq
         9Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685543327; x=1688135327;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bqxc1gQBmFfkqN2gkqKodtkKlqw3ckKgE7BeEOJc8x0=;
        b=AjbYDa7ozDcxkvrNloYTDDu/D0oOxVjDxuXYm/7+T7uFV3q4XnXWWUjUSguEWVsB+T
         YGlmXtcHIsmnaG/3XOFgU3LWWj6NHC53bqpY7ZcKNvWW5ImPcpWBgDWHM0CVqAn+ArR/
         p6AOMiwg650VwCrV+SxjI+9TjXa+mYtUq3hIlgt66Zld2ts7CuY0Qkr5WrfbWhuvvPa3
         1YifYW++GRPszEHd6PkGlytReziB9ThtKQzQzYZHascHAEEpzGE7aXPYGDDpMWdTqL+J
         mlDtTMriOUapn/O9y6iBw8p9cqdgNMI0jPi9VbvqGb4jLFT4Rqv2HmL4kc37LLB45Ypn
         +Gzg==
X-Gm-Message-State: AC+VfDxZF21vz+W7SUTDGeyElGDRQC6TUwdQhiQkdUlcNT7lpqNvz4Xc
	YbuTmiSpo6vBEQnzLczmd1DzUgncsccpiKwlBO9vLZAo
X-Google-Smtp-Source: ACHHUZ7rwSG9CnrQeO+y90KrSffxz+g3eWD9rq89IXQMhoblHts6OqCftMVeF2hNlTswJOP9ymNoJg==
X-Received: by 2002:a05:651c:112:b0:2ad:fef4:94f8 with SMTP id a18-20020a05651c011200b002adfef494f8mr2881705ljb.6.1685543326737;
        Wed, 31 May 2023 07:28:46 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:b1d9:81ac:cb3:35d0? ([2a02:578:8593:1200:b1d9:81ac:cb3:35d0])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003f4e47c6504sm24687544wmg.21.2023.05.31.07.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 07:28:46 -0700 (PDT)
Message-ID: <355b422b-bd88-56f2-6563-c73c4d052615@tessares.net>
Date: Wed, 31 May 2023 16:28:45 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v2 0/4] unify PM interfaces
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1685067241.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1685067241.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 26/05/2023 04:16, Geliang Tang wrote:
> v2:
>  - address Matt's comments in v1.

Thank you for this new version! LGTM!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
