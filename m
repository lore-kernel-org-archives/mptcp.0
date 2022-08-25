Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4504F2F47
	for <mptcp@lists.linux.dev>; Thu, 25 Aug 2022 17:20:40 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id gb36so40818958ejc.10
        for <mptcp@lists.linux.dev>; Thu, 25 Aug 2022 10:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=qmkHnolvq4vqnVeOjZQ7xXl27ABc5sswvUxQekCMKzE=;
        b=bEbsjOX4e/tWoaK7RBkiKcswyF3Zg/VmYsqCLuJWXGBd46V4GoQLF0dI+gJ75wRoOs
         9WXL/OhwoMUnsViX+1JKULdr4w6ke71JohBLRmQ7mGj6CKSn2TS9KYsB5HFqajxUSBgF
         0NazdK2vkQnPzoO00Tr1mWpK4Kl1f9HzZtRaopHutYMege8UWNYdHoH9uyk/0jZe8pFt
         DWGnYSjepU1KK5yEnPMVTo3nU4kAYUFzKMErT1hF/m4n+pU+iWMUv+KBceGJPEpJLB1s
         ImVGPvoSPDgpSTPTKLIPsv2UQezzsRx/cerqHoOP36ZW4dsa4B9rwufbTMVpa6QJJlGy
         ZLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=qmkHnolvq4vqnVeOjZQ7xXl27ABc5sswvUxQekCMKzE=;
        b=c9oBV4Qyu+trXWKxCsjwBXdub8hsLGWacxPxP0vN4VjZrQN6m1BadUv1sUG2QmHcup
         vaWOKAJHLy7AE3hSYhUV+Xx4alOFRbaY1vAvezr6SR8NnOttRUpK+UJk+uWbX9uB07p2
         8dYz0vzCW48f2HOZjWPCztQOALoI+NZnEI4IGeaWa1hsjU66Bph9eiKPvdf9oxEeVRHz
         udEIlXZniKAoG6HUTcH92RGph5xsvVo+NNsFUCQ1q2jbPbf69/Ydogk/1YXIo6D+KP1F
         Wgd0LPD4a2Kur6g06imjk1RZNYtcuDtdjNeJmTjl2vqOwEBF2PvFtKeVKJ9NXS5b4wLT
         jrtg==
X-Gm-Message-State: ACgBeo2MrZ/F1/xIkB3TINbXGnbpYhMEBXvpyrZR3hhXjGrhjgVYGe0J
	iszEZ9SUhuHXxsC7STwAztbXeQ==
X-Google-Smtp-Source: AA6agR7n+TWMr/TyGxIpUxfxoZvsbvLBc2wxaCkb+Vqf56Jk4AGKz3yERan9M+sBdEnmh4ADBvxNfA==
X-Received: by 2002:a17:907:2e19:b0:730:acf0:4921 with SMTP id ig25-20020a1709072e1900b00730acf04921mr3000863ejc.416.1661448039023;
        Thu, 25 Aug 2022 10:20:39 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:307d:9f57:279f:4cb4? ([2a02:578:8593:1200:307d:9f57:279f:4cb4])
        by smtp.gmail.com with ESMTPSA id i2-20020aa7c702000000b0043cb1a83c9fsm1123edq.71.2022.08.25.10.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 10:20:38 -0700 (PDT)
Message-ID: <a33aad39-902a-3244-0f9f-2cae704c36ea@tessares.net>
Date: Thu, 25 Aug 2022 19:20:37 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH mptcp-net] mptcp: fix fwd memory accounting on coalesce
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <e07e982885b904607d42e1e45840c4eb3c124d4b.1661426770.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
In-Reply-To: <e07e982885b904607d42e1e45840c4eb3c124d4b.1661426770.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 25/08/2022 13:29, Paolo Abeni wrote:
> The intel bot reported a memory accounting related splat:

(...)

> After commit d24141fe7b48 ("mptcp: drop SK_RECLAIM_* macros"),
> if rmem_fwd_alloc become negative, mptcp_rmem_uncharge() can
> try to reclaim a negative amount of pages, since the expression:
> 
> 	reclaimable >= PAGE_SIZE
> 
> will evaluate to true for any negative value of the int
> 'reclaimable': 'PAGE_SIZE' is an unsigned long and
> the negative integer will be promoted to a (very large)
> unsigned long value.
> 
> Still after the mentioned commit, kfree_skb_partial()
> in mptcp_try_coalesce() will reclaim most of just released fwd
> memory, so that following charging of the skb delta size will
> lead to negative fwd memory values.
> 
> At that point a racing recvmsg() can trigger the splat.
> 
> Address the issue switching the order of the memory accounting
> operations. The fwd memory can still transiently reach negative
> values, but that will happen in an atomic scope and no code
> path could touch/use such value.

Thank you for the patch and the explanation at the meeting we just had!

> Reported-by: kernel test robot <oliver.sang@intel.com>
> Fixes: d24141fe7b ("mptcp: drop SK_RECLAIM_* macros")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> - Given all the above, I think we should revert/drop the 
>   rx path refactor patches: not needed to address the memory
>   accounting issue, and with too much problems to be solved
>   in a reasonable time-frame.

As discussed at the last meeting, I first reverted these 4 patches from
our tree:

- mptcp: move RCVPRUNE event later
- mptcp: more accurate receive buffer updates
- mptcp: move msk input path under full msk socket lock
- mptcp: use common helper for rmem memory accounting

- Results: f937b3dbcdfa..de53498937c4 (export)


Then I applied the new patch:

New patches for t/upstream-net:
- f5d40f685b8a: mptcp: fix fwd memory accounting on coalesce
- Results: 1d1e5f83f7a4..0449ad887e88 (export-net)

New patches for t/upstream:
- f5d40f685b8a: mptcp: fix fwd memory accounting on coalesce
- Results: de53498937c4..aa5df4a5bcf9 (export)


As expected, I had a small conflict to resolve but while at it, I also
fixed a small typo (accunting) and added a new line before the "return".


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220825T171734
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220825T171734


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
