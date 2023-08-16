Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8197ED307
	for <mptcp@lists.linux.dev>; Wed, 16 Aug 2023 09:15:43 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3fe8a158fcbso43929345e9.2
        for <mptcp@lists.linux.dev>; Wed, 16 Aug 2023 02:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692177341; x=1692782141;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y3v2Y8QozA2jpf8nayzJKojrNONPKK3Ae9IR+IktplI=;
        b=4JlD3EGKsBCDuHetvIWqe7WzdCJiIv0XP6o2NP9gB8p8FoRDKDoYOTkwz4KAIDPUlc
         iGwnmPIRPYca1lJXeg7fNlnn7ZRJYvyjfCwN/c6tXjPOZFS20Eao7HztlDCSedn8lM4c
         6M/LJFGqzdUeHIclHIg9neZhqLEucCnazUFNE3zm4gY8ygwk3hgAmZnewSooIoarWDMo
         xr3ttnSi5/J0avJ0pwRJrWuaKDW4PvY18xraPbTlPu5G542IWtR+rsXstkRvfYmxkoIK
         fqdtdj75L+/2rubK7kS/v2L1IM8j/x4Cn73MI8ZZtho5e05Ti2urzvn1qmFyypzSnH07
         kS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692177341; x=1692782141;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3v2Y8QozA2jpf8nayzJKojrNONPKK3Ae9IR+IktplI=;
        b=iICgdjs4lLDn/seHAdJHUpk9FqhyVN2ywkAnjueKrzVBvn6RnwyEzsgMvZ/KDsaAIn
         aj7Xiq+s+nOpGkeB9H8TA9t25xtKPsSx1tRvCA5F6lKp8Z7CH1sQpCYfCd0SzfgfKpr4
         EuONsZAdSX4P0ocfqWPiSi6V8C9yA4/23sU10Crp/n9FisXGCNdprgC87UHNCVyJMVmL
         O6QiA3VTRrbpPQuix2J+LAeVgE0R0c3OQwhjxDFB9o7fAf005JG0Og84i8+C3r0UZqjs
         UfAAJ1WpJ3GpGMbVUtnJGiicU7j6cke3cg/IS7jAwUrH5L9tjB6qZ9Yz21EY0VTyo3gW
         7tAg==
X-Gm-Message-State: AOJu0YyasLrCrC1QKv1T/2CovMp/AgTtyMXwXCMxaZIuXY9/6dT6PN0j
	RlTNC8eLS3NsTNRA3g5MFyiCag==
X-Google-Smtp-Source: AGHT+IGus2unfda1e4zGFPoeSCCdmK/EQDFXVyMJsGPVC0WY7VywOatpn3/qk/lGLH6b863ZKuL/Zg==
X-Received: by 2002:a7b:c5c5:0:b0:3fe:25b3:951d with SMTP id n5-20020a7bc5c5000000b003fe25b3951dmr1081191wmk.5.1692177339203;
        Wed, 16 Aug 2023 02:15:39 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:8c09:b284:9ea1:cfb8? ([2a02:578:8593:1200:8c09:b284:9ea1:cfb8])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003fe2f3a89d4sm20563400wma.7.2023.08.16.02.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 02:15:38 -0700 (PDT)
Message-ID: <1372659f-01a2-47a8-aa09-79687985bb72@tessares.net>
Date: Wed, 16 Aug 2023 11:15:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 13/15] inet: move inet->defer_connect to
 inet->inet_flags
Content-Language: en-GB
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
 Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Simon Horman <horms@kernel.org>,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <20230816081547.1272409-1-edumazet@google.com>
 <20230816081547.1272409-14-edumazet@google.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <20230816081547.1272409-14-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric,

(+ Cc MPTCP ML)

On 16/08/2023 10:15, Eric Dumazet wrote:
> Make room in struct inet_sock by removing this bit field,
> using one available bit in inet_flags instead.
> 
> Also move local_port_range to fill the resulting hole,
> saving 8 bytes on 64bit arches.

Thank you for this cleanup!

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  include/net/inet_sock.h | 10 ++++------
>  net/ipv4/af_inet.c      |  4 ++--
>  net/ipv4/inet_diag.c    |  2 +-
>  net/ipv4/tcp.c          | 12 +++++++-----
>  net/ipv4/tcp_fastopen.c |  2 +-

The modifications in MPTCP code...

>  net/mptcp/protocol.c    | 10 ++++++----

... look good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

>  6 files changed, 21 insertions(+), 19 deletions(-)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
