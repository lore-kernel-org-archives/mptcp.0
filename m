Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8F07C
	for <mptcp@lists.linux.dev>; Tue,  7 Jun 2022 12:51:37 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso9475973wmn.4
        for <mptcp@lists.linux.dev>; Tue, 07 Jun 2022 05:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=h3EbdCBKR5JasXjJ3b/zApckIUzldA9DeSW+swXXQkQ=;
        b=uJytWOnVwKd2UMvXNDAzA6pGZQQUl2mN6rIO2TF4DI2tAn+yA28cY93Q/pPU9UfhoK
         QrVLxjCne30D/s7ZmMWOwb97RqAshPgZ5b5mnhXVNrpa6Ad/ysxJY3UrK37jJ1QZBlHI
         xHwCNFX6okAKQN2lWDXaHgSvKm+s+MDuhZBB8emBCddZqvripLoLmAi3mpm64usfgFgq
         YYTtx1K9O3DSiade9yAF3XPCOvaP9p1v9nCX7laPu3TB+WBJLTqOpnDHNf9r0cAP5baJ
         0PBHx85c0EKMGuNEIj0DavnYIlKVsqhqHJyb7N0Hn8OEJipF0H25Blcf3VctbxARlivY
         Xryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h3EbdCBKR5JasXjJ3b/zApckIUzldA9DeSW+swXXQkQ=;
        b=BJ++zSrctIrahfPCIh5yKczD2e4PjqngKpeu5siFEPSYSUNoLlm4KLkR0SssOMTF3n
         shmnIPbROgGMt8VD/42vCZQcdN6mgYLm4/51BKKb/TyC+ugS3p6qZop40M3o5N73ZMoU
         3BbTdtx/7Q8v1MI0IPL1M3mUrbG/j97F1Kqi7Ne6lwczKlAnxOswTHjsJeCZCz7icqke
         Aux7w0LKCZ7W5/bYw4WgPCeHopG7nzYT9T4rD0fOtGaUZE+Kpg8MLF3DzAj0eAVWpyR3
         Rnlax9YnLLFW1/HLS5HL4Wd1kna6zqVCcZTzay9vsfVLhVo+BlkSyAG5cPa9A+ZhI6Y/
         emfQ==
X-Gm-Message-State: AOAM533tD6eaMRvOAf7YX0sAoav0g08EZqRh8rFxTI+SOhj5I8piNqmT
	PV5LUqQL3P4TQg3Nm0DvNQJ9oR5SOWUjZw==
X-Google-Smtp-Source: ABdhPJzrnyAoW44DS1Qo8gXK48+RLyejMlMetaeUCmMXvPEZBl9Xsfum+zFFF1jyXi2xqwjfLsctuA==
X-Received: by 2002:a05:600c:4e51:b0:39c:4f18:4c29 with SMTP id e17-20020a05600c4e5100b0039c4f184c29mr11386245wmq.101.1654606295700;
        Tue, 07 Jun 2022 05:51:35 -0700 (PDT)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id k1-20020a1ca101000000b0039c4ff5e0a7sm5757007wme.38.2022.06.07.05.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 05:51:35 -0700 (PDT)
Message-ID: <6c021775-5dd6-7335-ef44-76725aa678ef@tessares.net>
Date: Tue, 7 Jun 2022 14:51:34 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH mptcp-next 0/3] cleanups for bpf sched selftests
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1654507832.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1654507832.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 06/06/2022 11:37, Geliang Tang wrote:
> do some cleanups for bpf sched selftests:
>  - add one more veth net device.
>  - use '10.0.1.1' to send data instead of use default '127.0.0.1'.
>  - add a new helper has_bytes_sent().
>  - update commit logs.
> 
> Geliang Tang (3):
>   Squash to "selftests/bpf: Add bpf_first test"
>   Squash to "selftests/bpf: Add bpf_bkup test"
>   Squash to "selftests/bpf: Add bpf_rr test"

Thank you for these patches and reviews!

- 8106c5f35319: "squashed" patch 1/3 in "selftests/bpf: Add bpf_first test"
- 1404767ad7db: tg:msg: import new commit message

- 8c2344d28fb6: "squashed" patch 2/3 in "selftests/bpf: Add bpf_bkup test"
- 65805439dcb2: tg:msg: import new commit message

- 9d020c5e7420: "squashed" patch 3/3 in "selftests/bpf: Add bpf_rr test"
- f1ca39aef385: tg:msg: import new commit message

- Results: 293143ba65b0..c3839c0496a1 (export)


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220607T125051
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
