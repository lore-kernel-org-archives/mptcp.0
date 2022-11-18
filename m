Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400FC2F43
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 14:52:41 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id w14so9611891wru.8
        for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 06:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILU183FpX0CP40BDetssedboWs8tpQYa0n8mItAr9ao=;
        b=L9T7I2e6fpCEJI5qgh2UQUvV7/EbPU84bQa491EcUrawrv5mtEVQ5r8iwWgGA15Kdj
         P4cHGzUuxmXCjBWniK6Hf5QelTwP3iMbnRX/oyfWHTGicDuIqie18SAFP0FZYzhGvphd
         /Y8gor4oT38A8fmQthoTJJ53jCVx5ecio3LZxBHKAuSezGbYV71yDTZjnZ83VMaIZDzk
         WnSz7WI5ts/Sbuy6Ldi3qXn3D5EfDS71LWtyzoiWYSvyhy6q1VH4Xq/sh4WlSUlpwOT0
         UFqcbQ3o18Y15Q+fKwYrB4OVGZeekQ8JYzs2suk63/4ulpbqTQYaGMIVZrflVTj9DGb1
         kQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILU183FpX0CP40BDetssedboWs8tpQYa0n8mItAr9ao=;
        b=bmtinmuR7xcsq/sV2bsKjm03jZrFnQWF2f10JCFSTWwYFVy9itGIeZ0oFn9yR1MyeU
         mHtUnxsIYYUOancrcCbGldhG0Xv7YrQcX7Xb9UvWpg5UK2fvPaSxWYLzdO0E27guQiBz
         UXcDqyYQbeXOIiZBbuCaDjpEagdFMiRneOl3b8YZtZRw86p0Z39rvLHdOA94/Flb4+xb
         AcVRndqdguGk6pNm9iHv55xKJGFda12+40fWKQFW+pIkHIkztgA0MgfNionZa48a+qgG
         ij9dn1ZlOE/2lozENIcDBOGYSijCwAf3fILi7Vc2HusImjJW6XfJvQ+f1L5Aza/nvzxy
         PYKQ==
X-Gm-Message-State: ANoB5pnoMQPzt+8xYKIQjXx9aZUGJjXzCeoJZGirhyN54mjKPhYr6sMt
	/Yl5Jj7Ga+ARKUNJE/sQJhcjk/Q/yBADkpXw
X-Google-Smtp-Source: AA0mqf5olKpQdhM1ErDnPFeXEsx/UmSSozPUrxrGLH49bChA+D5BIWVJrM9nL0U5+DYPcBMokmr6DQ==
X-Received: by 2002:a5d:6b84:0:b0:236:6fb2:ff91 with SMTP id n4-20020a5d6b84000000b002366fb2ff91mr4410138wrx.520.1668783159994;
        Fri, 18 Nov 2022 06:52:39 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4f08000000b0022cc0a2cbecsm3850035wru.15.2022.11.18.06.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 06:52:39 -0800 (PST)
Message-ID: <ae42a5ff-8d1b-e4ce-6702-eb3b3045cfec@tessares.net>
Date: Fri, 18 Nov 2022 15:52:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next v19 0/9] BPF redundant scheduler, part 1
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1668151131.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1668151131.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 11/11/2022 08:47, Geliang Tang wrote:
> v19:
>  - update patch 1.
>  - split "BPF redundant scheduler" into two parts.
>  - rebased on "export/20221111T055536".
> 
> Geliang Tang (9):
>   mptcp: refactor push_pending logic
>   mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
>   mptcp: add sched_data_set_contexts helper
>   Squash to "mptcp: add struct mptcp_sched_ops"
>   Squash to "bpf: Add bpf_mptcp_sched_ops"
>   Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
>   Squash to "selftests/bpf: Add bpf_first scheduler"
>   Squash to "selftests/bpf: Add bpf_bkup scheduler"
>   Squash to "selftests/bpf: Add bpf_rr scheduler"

Thank you for the patches and the reviews!

I just applied them (+ an additional squash-to patch) in our tree (feat.
for other trees (bpf)) with Mat's RvB tag.

Patches 1/9 and 2/9 have been added at the beginning. Patch 3/9 depends
on "mptcp: add struct mptcp_sched_ops" and it has been applied just
before "bpf: Add bpf_mptcp_sched_ops" as mentioned by Geliang.

Please also note that patch 5/9 has been squashed in "selftests/bpf: Add
mptcp sched structs" instead of "bpf: Add bpf_mptcp_sched_ops. Do not
hesitate to tell me if something is not OK!

New patches for t/upstream:
- 602fba0955d1: mptcp: refactor push_pending logic
- 343f8eed9abb: mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
- Results: 69720c6cd168..ac857086fdb8 (export)

- 65e9504361f6: mptcp: add sched_data_set_contexts helper
- Results: ac857086fdb8..ae9c4d4cf58f (export)

- 82721c73112e: "squashed" patch 4/9 in "mptcp: add struct mptcp_sched_ops"
- a7c2367dd1d2: "squashed" patch 5/9 in "selftests/bpf: Add mptcp sched
structs"
- ee74ff707e4b: "squashed" patch 6/9 in "bpf: Add bpf_mptcp_sched_kfunc_set"
- 813537758eb5: "squashed" patch 7/9 in "selftests/bpf: Add bpf_first
scheduler"
- 762c5b194975: "squashed" patch 8/9 in "selftests/bpf: Add bpf_bkup
scheduler"
- 5db53c2d3ef6: "squashed" patch 9/9 in "selftests/bpf: Add bpf_rr
scheduler"
- Results: ae9c4d4cf58f..0814e9ff0a94 (export)

- 7b3058027867: "squashed" in "mptcp: refactor push_pending logic"
- Results: 0814e9ff0a94..d98411bcedd1 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221118T145003

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
