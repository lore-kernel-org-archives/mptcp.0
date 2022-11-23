Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07EA7E
	for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 15:36:46 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id me22so27043883ejb.8
        for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 07:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yD5+5T6O2Ef+zwzMWsYIJO1DcP4shO7Cg5HU2Z6UpxI=;
        b=vpYEkeQHI5uBOPfTYEZd4mRFdSPcOQR8kTtLNAj1875pi6DlNky1+LLlWzRgeF2QYx
         nUKwDstog1qPJoi55yC2ON3fKU6ZjA2vSdMqpW30ancBHz+U4pYiXdGJXopkZkWK1ZRZ
         AOQzB6sI1bHQbGkK/v6QrTQKVwW0UXEAKdvr5p+Hh9wR7KiZpwfMYrIQasiMAOvvFZWh
         FCJLpwZzhCQcNpL0S69kjSnPbNvdug/7b9xSAbS+QUbJjR4x/j7H18wYs0K3oQWPJh2+
         rVYgpHdRoSt6II9xz7h6UFBweoxMrf5G2gSjVSn1yiDUiAnU9WJ/rn+euyjdC0LMT5G4
         SNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yD5+5T6O2Ef+zwzMWsYIJO1DcP4shO7Cg5HU2Z6UpxI=;
        b=ekWY7HQ+nngtFRzzNlX0OPNwEcu/FUJebFdK5zT19T4BLpwhRLXv3k84FT4iLUQCuz
         1TQ0rrPARLYjrnkuxiiN9euLIiJJKdS0hDUpFWiI9svUlEzQP/okL3h+/F+jdeMoV5yY
         6vD6U1OX3QDoyjynuGrhDs2vEsoP7h7rrxBvM2e7Lce84FE6wFJIPB2Wt96JJ6a6gPsP
         YFKSePld8oo2s36W0Yxpv0rzTeUYw5CTj30UoithJbC+QtvPUx2kCjrwztsjV4GNy9I4
         hj/PvKHw/g9ZpD5lyqZZsU6Z/sDKOCeqblIl4zV3+RC3HzAJvOidIFQPJZBPG7no3qp3
         5DDw==
X-Gm-Message-State: ANoB5plLqeZ1zhdPpJaBImD7BcMS4tTKBOY64622cpLpffKXaDkppuQD
	3Z542OxPvRfSFwOesTlY4STQLw==
X-Google-Smtp-Source: AA0mqf7TRXaC2e02DL7aUzAxRv4yiKa9tGFexcvnzRwAf4YfYOLf20SGIKm/FqOXAf8Ic77kOZc8ug==
X-Received: by 2002:a17:906:1354:b0:78d:36d7:ed29 with SMTP id x20-20020a170906135400b0078d36d7ed29mr25203307ejb.655.1669217804424;
        Wed, 23 Nov 2022 07:36:44 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:aeed:e7e9:2ae2:91e2? ([2a02:578:8593:1200:aeed:e7e9:2ae2:91e2])
        by smtp.gmail.com with ESMTPSA id p19-20020a17090653d300b007aea1dc1840sm7283908ejo.111.2022.11.23.07.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 07:36:43 -0800 (PST)
Message-ID: <4f78725c-7e72-63fe-854a-c6b48f09b932@tessares.net>
Date: Wed, 23 Nov 2022 16:36:43 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-net] mptcp: fix sleep in atomic at close time
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Jiang Biao <benbjiang@tencent.com>, Mengen Sun <mengensun@tencent.com>
References: <feee93bcba06bf05a9308188f91007e7f6cbe5f4.1669201422.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <feee93bcba06bf05a9308188f91007e7f6cbe5f4.1669201422.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for the patch!

On 23/11/2022 12:23, Paolo Abeni wrote:
> Mat reported a splat at msk close time:
> 
> BUG: sleeping function called from invalid context at net/mptcp/protocol.c:2877
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 155, name: packetdrill
> preempt_count: 201, expected: 0
> RCU nest depth: 0, expected: 0
> 4 locks held by packetdrill/155:
> #0: ffff888001536990 (&sb->s_type->i_mutex_key#6){+.+.}-{3:3}, at: __sock_release (net/socket.c:650)
> #1: ffff88800b498130 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_close (net/mptcp/protocol.c:2973)
> #2: ffff88800b49a130 (sk_lock-AF_INET/1){+.+.}-{0:0}, at: __mptcp_close_ssk (net/mptcp/protocol.c:2363)
> #3: ffff88800b49a0b0 (slock-AF_INET){+...}-{2:2}, at: __lock_sock_fast (include/net/sock.h:1820)
> Preemption disabled at:
> 0x0
> CPU: 1 PID: 155 Comm: packetdrill Not tainted 6.1.0-rc5 #365
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
> <TASK>
> dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4))
> __might_resched.cold (kernel/sched/core.c:9891)
> __mptcp_destroy_sock (include/linux/kernel.h:110)
> __mptcp_close (net/mptcp/protocol.c:2959)
> mptcp_subflow_queue_clean (include/net/sock.h:1777)
> __mptcp_close_ssk (net/mptcp/protocol.c:2363)
> mptcp_destroy_common (net/mptcp/protocol.c:3170)
> mptcp_destroy (include/net/sock.h:1495)
> __mptcp_destroy_sock (net/mptcp/protocol.c:2886)
> __mptcp_close (net/mptcp/protocol.c:2959)
> mptcp_close (net/mptcp/protocol.c:2974)
> inet_release (net/ipv4/af_inet.c:432)
> __sock_release (net/socket.c:651)
> sock_close (net/socket.c:1367)
> __fput (fs/file_table.c:320)
> task_work_run (kernel/task_work.c:181 (discriminator 1))
> exit_to_user_mode_prepare (include/linux/resume_user_mode.h:49)
> syscall_exit_to_user_mode (kernel/entry/common.c:130)
> do_syscall_64 (arch/x86/entry/common.c:87)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> 
> We can't acquire call mptcp_close under the 'fast' socket lock veriant,

I guess I can remove "acquire" (and s/veriant/variant/)

> replace it with a sock_lock_nested() as the relevant code is already
> under the listening msk socket lock protection.
> 
> Reported-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Closes: Matthieu Baerts <matthieu.baerts@tessares.net>

Please don't close me, it took me some times to find how to re-open
myself...

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/316

For the rest, it looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
