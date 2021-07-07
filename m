Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5E3168
	for <mptcp@lists.linux.dev>; Wed,  7 Jul 2021 21:08:49 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id s15so5218093edt.13
        for <mptcp@lists.linux.dev>; Wed, 07 Jul 2021 14:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ysLypgnpow3zs5G5lNeNmYjLEvj8JLNtcNdAS0PJWGM=;
        b=tPgreUUSiFXX9rUCR2ikLRZ7hWExhLwmT8Azt/52y4YIxx3R0JOWz1Y2/a1ad7H2Jt
         HOVYcdPjm/EBHBOz4Wdvcp0g+4fMsPcGFQMYMXhCFTOnDoLRgKkqo0vQUGt7rZ9+eqek
         ABHxwnX7beQlGelT4BhS6Nqti3814o0idLx1HGjGKb++BsAD8huNzSIc21TBq33Ppn9o
         lP/AkAKLoN6gxEtjQgWTN0vGbVcdN80Ep2qGlFeYBPAPh3yuu9KFWb++9lSJxwqcFlvf
         zBr04TTLwfQ3+EU9Yp4D9Z0Ln2AsnzhkyeFNzWdPLvkuLMy54k574G00B45CRPOqYt4P
         R9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ysLypgnpow3zs5G5lNeNmYjLEvj8JLNtcNdAS0PJWGM=;
        b=KGOTybtvCHcaamUlWqVzrx0U7ewR7cEa+DqPs8rL/cX76ASRMfq182ErIMZqTdnSr6
         3Kt0dcT9NJbV6D9SIVyoZaXrEbSC83UiMEWym8ZRcDFHDLSHvWSY1sjCf7cAUcvP8h/Z
         wvoT8f0wjTPr/DViDf6qN0IBoHRAZtxx6h7WtJQXsE2mQoSWlqbumPWj/WplQkcVBCTS
         yPS54HzDItnxXXX9pjsr09pOsDmKcrolZ6ItgH8BYjx9SOqIUwj4qYTxRDZmlWa9Rc5D
         wMrgSIHuXCN6AJKhBpzVY2J0jpUJPX1y+N6ATO8etzcjmhctK6gYt03EXCx2/5M9+Ucp
         GSsQ==
X-Gm-Message-State: AOAM530Rb7A3DBZLJUXqkaux2BgvibQELSXOxlereaPvkE2paVgFYdzo
	o32IpLMBeU6GZQJ7IHH1WcQHKg==
X-Google-Smtp-Source: ABdhPJwCxgxKXW0VKJKX6wxG8bCGWJBWgls7tS76esWGoqal6S7fhORuOddGBZGY4m1aD2KRmkMfpQ==
X-Received: by 2002:a05:6402:7cf:: with SMTP id u15mr32731427edy.197.1625692127756;
        Wed, 07 Jul 2021 14:08:47 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:5a8f:f0b3:83fa:8d98])
        by smtp.gmail.com with ESMTPSA id jx17sm7374376ejc.60.2021.07.07.14.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 14:08:45 -0700 (PDT)
Subject: Re: [PATCH v2 mptcp-net] mptcp: properly account bulk freed memory
To: Paolo Abeni <pabeni@redhat.com>
References: <4a413026831df9aaf1d2073f9a8b5b29d4376bfe.1624894631.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <1a62d811-8788-ba92-494d-480a820bb28b@tessares.net>
Date: Wed, 7 Jul 2021 23:08:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4a413026831df9aaf1d2073f9a8b5b29d4376bfe.1624894631.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 28/06/2021 17:37, Paolo Abeni wrote:
> After commit 879526030c8b ("mptcp: protect the rx path with
> the msk socket spinlock") the rmem currently used by a given
> msk is really sk_rmem_alloc - rmem_released.
> 
> The safety check in mptcp_data_ready() does not take the above
> in due account, as a result legit incoming data is keept in
> subflow receive queue with no reason, delaying or blocking
> MPTCP-level ack generation.
> 
> This change addresses the issue introducing a new helper to fetch
> the rmem memory and using it as needed. Additionally add a MIB
> counter for the exceptional event described above - the peer is
> misbehaving.
> 
> Finally update introduce the required annotation when rmem_released
> is updated.
> 
> Fixes: 879526030c8b ("mptcp: protect the rx path with the msk socket spinlock")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/211
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch and the review!

Now in our tree (-net section) with Mat's RvB tag and without a small
typo in the commit message:

- 5c427089fbf1: mptcp: properly account bulk freed memory

- Results: ebd34c7ce3e9..1090cbb30c57

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210707T210808

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210707T210808

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
