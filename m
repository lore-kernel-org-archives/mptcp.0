Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F342F2B
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 11:14:49 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id da10so4429885edb.3
        for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 03:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3S8Xasm70ik9IB+rlfhmTZ0XXdcuF+B8pGoj7pTbmlQ=;
        b=b3PJIbrKcb4Q0m3b60L4AhQkWwqw+xjAfMshDpVUue1jvxUGWdfB9fi2yrzN3gbtEY
         xDWpb2BIzlKi9oMCK/wGDj14u9OGFuCCmQnM8s7wHC9wfzXWAOt+WQ7TSdF3zNfC5F3F
         rdAJfIOx8VwUX7efZl0ZJjH6m+CEoIVNTCnMmdCT09jEp5RmsIQTBKoIf0qT73VaYLlw
         KJ3HwACaKYKEypAr7+pYNRGkn5S1nmisXkghInR8BpL/75piqQOJxz9HCkGExPE6/xnP
         gJamD8d7tavgndot6OAkwTJNapmTltC/I0yvgkUTlW5xrHbAG04/Te7sIdaf3eZd7Cgy
         KQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3S8Xasm70ik9IB+rlfhmTZ0XXdcuF+B8pGoj7pTbmlQ=;
        b=uBMM+wlC4S5hMU1El/Y3zfqUsSkwhJw1R1TWMnFzlNoG6eldptjNKIV430T/AXoywl
         uakPfn+RyA29jZX0FXVgEcta1NS8ctJeplsJgYTyrx/Y+kqqvj5sKBpN72u8CJRjjljQ
         gycFC4+e84ph4Fq5+2Olh/vTf9SOwetPIxslWUgMGd4LU2Ww1P681smvdLpg6/6wpiUp
         fD0C/CUeL6MKUOQ9T3OCTf4KsfZytju7fGWKxa6ilS5z8udJsrwfpRm+mN6T21rP/J+E
         zM13N1KoI14BVjsJ5z75jx0UupuupgV/3rfTrf8Pc+RDt+8RLjQHiSxM1h9xTuSsaM9X
         2XFg==
X-Gm-Message-State: AO0yUKWzyYOg87lbysCjzUY8374yWXZPvyDIhp/zXAUoanxjYeyGrq7O
	iO9PEFEFZnqUK5cvUkvZwQQnFQ==
X-Google-Smtp-Source: AK7set8G1ehzjVJtS3SByNqrzLhrcBdSBeNROpOMvovEyW0Ymgra6Dt06UdwhzNFbXu4ZypckAKFxg==
X-Received: by 2002:a17:906:aca:b0:8b1:7841:9f28 with SMTP id z10-20020a1709060aca00b008b178419f28mr11978758ejf.55.1676891687926;
        Mon, 20 Feb 2023 03:14:47 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id i13-20020a170906444d00b008d6348a5524sm818128ejp.184.2023.02.20.03.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 03:14:47 -0800 (PST)
Message-ID: <5eb0dec3-172a-953d-110d-009cadaa711f@tessares.net>
Date: Mon, 20 Feb 2023 12:14:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 mptcp-net 2/2] mptcp: fix UaF in listener shutdown
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <b5b35cfd2d10179fc81643e601e125aa881f7c79.1675968499.git.pabeni@redhat.com>
 <ad634b00b9c4cfb0f8cd6c8ec57d1a7405ba3799.1675968499.git.pabeni@redhat.com>
 <7c02bf27-2de1-cea8-691a-120c988c4da0@tessares.net>
In-Reply-To: <7c02bf27-2de1-cea8-691a-120c988c4da0@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 17/02/2023 18:58, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 09/02/2023 19:48, Paolo Abeni wrote:
>> As reported by Christoph, the mptcp listener shutdown path is prone
>> to an UaF issue.
> 
> Again, thank you for the two patches!
> 
> Now in our tree (fixes for -net) with my RvB tag.
> 
> I had a few conflicts when applying them on -net (and later when
> propagating them to our tree, see below), I hope that's OK but don't
> hesitate to double check if you have the opportunity :)

I probably didn't resolve the conflicts properly (or maybe some
adaptations are needed on -net) because this introduce some regressions
on export-net (not on net-next):

Any idea what could cause that?

https://github.com/multipath-tcp/mptcp_net-next/issues/361

Cheers,
Matt

> New patches for t/upstream-net and t/upstream:
> - 4f70189ea062: mptcp: use the workqueue to destroy unaccepted sockets
> - 477601b8695d: mptcp: fix UaF in listener shutdown
> - Results: 2a5c259387e2..de8ae10003bd (export-net)
> 
> - 1c2f1e5c434b: conflict in t/mptcp-refactor-passive-socket-initialization
> - 1fed9c65e6d5: conflict in t/mptcp-drop-legacy-code
> - a5a7fffe5413: conflict in
> t/mptcp-fastclose-msk-when-cleaning-unaccepted-sockets
> - Results: c6f15583a946..2275e6265ebe (export)
> 
> Tests are now in progress:
> 
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230217T145032
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230217T145032
> 
> Cheers,
> Matt

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
