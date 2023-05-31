Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00A4171B8
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 16:01:37 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f60e536250so9061505e9.1
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685548896; x=1688140896;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RWHEvrI2/maR2Me91J2DpqRCeMkQlrdI5KKk7Y+//PI=;
        b=HOwGxBNiZO3W/AaaP+rAZzOO5mDQtZYqASPe4ieMBgeo0+jPoI5RWmZkJl4U6bHkk/
         s7/QOjYNBWeqQucStnJFwZy9vv6MnC2oqxCsk5+EqxbfNWLMibK/oUyfmYh56yoQvckP
         2e5R+uUCvS4tzoBoCZwJoBI5gfybKCAtyHumUKy0Ircl6oMkBA/x+yQWZLdJBiLgIYOG
         ekM5e0jQViIWAnmKm6qgG9Ipp17CC+chRAywEIIJ/nleSEhq0WbPwkxzuhJKo2wFc3+0
         g1YK5f5DiaO6vlQyi4PVIZNTaOxAMEXDhduib5wli9oD+0LnXXvtUaRXjtQy5JPEsYHQ
         SHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685548896; x=1688140896;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWHEvrI2/maR2Me91J2DpqRCeMkQlrdI5KKk7Y+//PI=;
        b=GgHYN3DbdHW1MdounPUXguQnkwPegUvZQU2F/Da05TBaGceq9rjZs/aneUAqW8/k8G
         M4M+JNE4Pa2WmVhCOLNMDejMWUdbGHRTXuA5tUQPjLFN93+fJ1X7Vk0Bv0kjxqNroZpw
         F1NwPe6IEVSgs7cn/Sa1EfV+Jwb4VlVicCekeZwRc5rJnrHY13j4JWgdiPyw3LrWhaqV
         fn7x6m7FwndpfDlWZszse4z+qeMvS6YcH4Py4N1w/oaTo0svPBEob+PYYDctM2WgrDph
         l+YQsyoWUVsIwVa8xZWzDZYpTsdBhT0F7nEH8G3RYdwDq/had4+J/EGtfPJjZztE2Pnx
         V74A==
X-Gm-Message-State: AC+VfDwC2UwRLFgM7rnedBVrQ4n+NqXwtYlFASZkY04AOrZ5Rs7G4Zu6
	EtK+YCq2jYxvemJfBRiYeWKdlA==
X-Google-Smtp-Source: ACHHUZ7yW9Xegi7uh/iZq+iPmA7F3io7DZvky78hPpJxhZMqZOjIc0X7IUal5MHhG+Gkd+wMbrx55Q==
X-Received: by 2002:a05:600c:2e0c:b0:3f4:255e:e375 with SMTP id o12-20020a05600c2e0c00b003f4255ee375mr11987043wmf.9.1685548895972;
        Wed, 31 May 2023 09:01:35 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:b1d9:81ac:cb3:35d0? ([2a02:578:8593:1200:b1d9:81ac:cb3:35d0])
        by smtp.gmail.com with ESMTPSA id c12-20020a7bc84c000000b003f3e50eb606sm21170079wml.13.2023.05.31.09.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 09:01:35 -0700 (PDT)
Message-ID: <6feb4ec9-c8a7-cdf7-59b2-3c70fbad4f9d@tessares.net>
Date: Wed, 31 May 2023 18:01:35 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 mptcp-net 2/2] mptcp: fix possible divide by zero in
 recvmsg()
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <360b09c704b56f03c42c4f3520e6602fbf884651.1685367663.git.pabeni@redhat.com>
 <42bb08e7d5ec3c1cc5cba43fa1215f80255e99a9.1685367663.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <42bb08e7d5ec3c1cc5cba43fa1215f80255e99a9.1685367663.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 29/05/2023 15:41, Paolo Abeni wrote:
> Christoph reported a devide by zero bug in mptcp_recvmsg():
> 
> divide error: 0000 [#1] PREEMPT SMP
> CPU: 1 PID: 19978 Comm: syz-executor.6 Not tainted 6.4.0-rc2-gffcc7899081b #20
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
> RIP: 0010:__tcp_select_window+0x30e/0x420 net/ipv4/tcp_output.c:3018
> Code: 11 ff 0f b7 cd c1 e9 0c b8 ff ff ff ff d3 e0 89 c1 f7 d1 01 cb 21 c3 eb 17 e8 2e 83 11 ff 31 db eb 0e e8 25 83 11 ff 89 d8 99 <f7> 7c 24 04 29 d3 65 48 8b 04 25 28 00 00 00 48 3b 44 24 10 75 60
> RSP: 0018:ffffc90000a07a18 EFLAGS: 00010246
> RAX: 000000000000ffd7 RBX: 000000000000ffd7 RCX: 0000000000040000
> RDX: 0000000000000000 RSI: 000000000003ffff RDI: 0000000000040000
> RBP: 000000000000ffd7 R08: ffffffff820cf297 R09: 0000000000000001
> R10: 0000000000000000 R11: ffffffff8103d1a0 R12: 0000000000003f00
> R13: 0000000000300000 R14: ffff888101cf3540 R15: 0000000000180000
> FS:  00007f9af4c09640(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b33824000 CR3: 000000012f241001 CR4: 0000000000170ee0
> Call Trace:
>  <TASK>
>  __tcp_cleanup_rbuf+0x138/0x1d0 net/ipv4/tcp.c:1611
>  mptcp_recvmsg+0xcb8/0xdd0 net/mptcp/protocol.c:2034
>  inet_recvmsg+0x127/0x1f0 net/ipv4/af_inet.c:861
>  ____sys_recvmsg+0x269/0x2b0 net/socket.c:1019
>  ___sys_recvmsg+0xe6/0x260 net/socket.c:2764
>  do_recvmmsg+0x1a5/0x470 net/socket.c:2858
>  __do_sys_recvmmsg net/socket.c:2937 [inline]
>  __se_sys_recvmmsg net/socket.c:2953 [inline]
>  __x64_sys_recvmmsg+0xa6/0x130 net/socket.c:2953
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x47/0xa0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> RIP: 0033:0x7f9af58fc6a9
> Code: 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 37 0d 00 f7 d8 64 89 01 48
> RSP: 002b:00007f9af4c08cd8 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
> RAX: ffffffffffffffda RBX: 00000000006bc050 RCX: 00007f9af58fc6a9
> RDX: 0000000000000001 RSI: 0000000020000140 RDI: 0000000000000004
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000f00 R11: 0000000000000246 R12: 00000000006bc05c
> R13: fffffffffffffea8 R14: 00000000006bc050 R15: 000000000001fe40
>  </TASK>
> 
> mptcp_recvmsg is allowed to release the msk socket lock when
> blocking, and before re-acquiring it another thread could have
> switched the sock to TCP_LISTEN status - with a prior
> connect(AF_UNSPEC) - also clearing icsk_ack.rcv_mss.
> 
> Address the issue preventing the disconnect if some other process is
> concurrently performing a blocking syscall on the same socket, alike
> commit XXXXXXXXX ("tcp: deny tcp_disconnect() when threads are waiting").

FYI, I used: 4faeee0cf8a5

> Fixes: a6b118febbab ("mptcp: add receive buffer auto-tuning")
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/404
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>   - refactor on top of the TCP fix
> note:
>   - the hash of the TCP fix is missing, such commit should be applied
>     today or tomorrow morning in the worst-case scenario.

Thank you for the patches and the tests!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Now in our tree (fixes for -net) without typos reported by codespell:

New patches for t/upstream-net and t/upstream:
- 1e8b6536343a: mptcp: handle correctly disconnect() failures
- ffcd0af9b916: mptcp: fix possible divide by zero in recvmsg()
- Results: cb95946976d7..978898338078 (export-net)
- Results: d5bf0f97d0f0..bd369ef919fb (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230531T155928
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230531T155928

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
