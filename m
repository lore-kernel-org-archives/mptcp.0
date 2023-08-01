Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AD31B177
	for <mptcp@lists.linux.dev>; Tue,  1 Aug 2023 14:35:16 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-99bf3f59905so643882766b.3
        for <mptcp@lists.linux.dev>; Tue, 01 Aug 2023 07:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690900514; x=1691505314;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u1Ec/fS0YosRk1QmbUA7bqjnkb96mzrElREh2QP3Luw=;
        b=VGIAwWoFlFdoJxYG9KzEr+5xEC2m3FSOx5nOV7/5mK26T4gp320llvOnFT0cH89Qhv
         M/LIqKgOfzthAsRJLYykOBrJR1cL11ULcsK2n5g90slt627F1R0w8qaLd4nJFXTna3e1
         ZQ/+wAIdeYh4yk++cAKL+h4iAxG2YtMYDQqDhXwk0UOcdNdidLi668Je2Emr+ZL9xtx/
         ueSTwSpVRhXCplgHoG+cwJN+BHZW4Bg2/PvEWYpKcrkHTajyRewO7aj2KFu9vOHqVDQ6
         VCORhhpilCuTtAzllbUZ8NBwTQTEiyQ4oAkGNrX4GNPK1WJkK6sI0quDYFApLzOfja8V
         oDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900514; x=1691505314;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1Ec/fS0YosRk1QmbUA7bqjnkb96mzrElREh2QP3Luw=;
        b=BolzgoXUMOtrGWWIIxxITe6SH2m3svR0ukzImvIOZtD4ZRkR3hQ6stvnzlJwdOfYhS
         0opKkHZ41aMsRSScFjZWBJSGQ19w8F5/+4QEKyD8elMmL/rz3KUcbSb9ALbfR3abkTTs
         OL0ZFseixjOCKfl3IEz+E7BaYr9YZlxBHVZSOwqRjObBzOyD+4tK6c9uBCvyrfqyFJZA
         gQTwg0ZUz7ec5s+u5z8cNx0YFsPbXxXq3sZbSdXfCEEukqFQpxjpctSF2E6/74Bii3aY
         GIZFopIZO+DQpa33n/cUMu+vH6xLObCpmlpKydg8hAxefYwoyiEyIsH7yWEHOloAK8Zd
         sLug==
X-Gm-Message-State: ABy/qLYMJ3CMpFyTMyHCsYNBS12nsp5pGYCtZJBtwzK99yqD0Nptt9Lq
	BJKEi53GAYBl9QFSrPiM6lyKQhM1Stt/iL1Yiqu6oOi7
X-Google-Smtp-Source: APBJJlHc4toiG6IpFoPHAOs3P9af1Hv0tu8BpgtVBEw3fwDC2KSDhDtzAUqS275Xd+wvXrEd+FeUVg==
X-Received: by 2002:a17:906:3112:b0:965:9602:1f07 with SMTP id 18-20020a170906311200b0096596021f07mr2275852ejx.39.1690900514465;
        Tue, 01 Aug 2023 07:35:14 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:2cb4:ff10:2449:c7aa? ([2a02:578:8593:1200:2cb4:ff10:2449:c7aa])
        by smtp.gmail.com with ESMTPSA id h15-20020a1709063c0f00b009929ab17be0sm7757290ejg.162.2023.08.01.07.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 07:35:13 -0700 (PDT)
Message-ID: <65b1b7c0-89d4-436c-be08-4d47245ccd68@tessares.net>
Date: Tue, 1 Aug 2023 16:35:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: fix disconnect vs accept race
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <68f1f65f9b5542fd200f995844f7ed71bdfbfc30.1690840586.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <68f1f65f9b5542fd200f995844f7ed71bdfbfc30.1690840586.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 01/08/2023 00:25, Paolo Abeni wrote:
> Despite commit 0ad529d9fd2b ("mptcp: fix possible divide by zero in
> recvmsg()"), the mptcp protocol is still prone to a race between
> disconnect() (or shutdown) and accept.
> 
> The root cause is that the mentioned commit checks the msk-level
> flag, but mptcp_stream_accept() does acquire the msk-level lock,
> as it can rely directly on the first subflow lock.
> 
> As reported by Christoph than can lead to a race where an msk
> socket is accepted after that mptcp_subflow_queue_clean() releases
> the listener socket lock and just before it takes destructive
> actions leading to the following splat:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000012
> PGD 5a4ca067 P4D 5a4ca067 PUD 37d4c067 PMD 0
> Oops: 0000 [#1] PREEMPT SMP
> CPU: 2 PID: 10955 Comm: syz-executor.5 Not tainted 6.5.0-rc1-gdc7b257ee5dd #37
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
> RIP: 0010:mptcp_stream_accept+0x1ee/0x2f0 include/net/inet_sock.h:330
> Code: 0a 09 00 48 8b 1b 4c 39 e3 74 07 e8 bc 7c 7f fe eb a1 e8 b5 7c 7f fe 4c 8b 6c 24 08 eb 05 e8 a9 7c 7f fe 49 8b 85 d8 09 00 00 <0f> b6 40 12 88 44 24 07 0f b6 6c 24 07 bf 07 00 00 00 89 ee e8 89
> RSP: 0018:ffffc90000d07dc0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff888037e8d020 RCX: ffff88803b093300
> RDX: 0000000000000000 RSI: ffffffff833822c5 RDI: ffffffff8333896a
> RBP: 0000607f82031520 R08: ffff88803b093300 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000003e83 R12: ffff888037e8d020
> R13: ffff888037e8c680 R14: ffff888009af7900 R15: ffff888009af6880
> FS:  00007fc26d708640(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000012 CR3: 0000000066bc5001 CR4: 0000000000370ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  do_accept+0x1ae/0x260 net/socket.c:1872
>  __sys_accept4+0x9b/0x110 net/socket.c:1913
>  __do_sys_accept4 net/socket.c:1954 [inline]
>  __se_sys_accept4 net/socket.c:1951 [inline]
>  __x64_sys_accept4+0x20/0x30 net/socket.c:1951
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x47/0xa0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> 
> Address the issue by temporary removing the pending request socket
> from the accept queue, so that racing accept() can't touch them.
> 
> After depleting the msk - the ssk still exists, as plain TCP sockets,
> re-insert them into the accept queue, so that later inet_csk_listen_stop()
> will complete the tcp socket disposal.
> 
> Fixes: 2a6a870e44dd ("mptcp: stops worker on unaccepted sockets at listener close")
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/423
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch!

Now in our tree (fix for -net):

New patches for t/upstream-net and t/upstream:
- bd950ed266b6: mptcp: fix disconnect vs accept race
- Results: 7096265245f8..7e8e603725ca (export-net)
- Results: 42fa6a1925b9..829c05bb214b (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230801T143213
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230801T143213

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
