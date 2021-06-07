Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E782F80
	for <mptcp@lists.linux.dev>; Mon,  7 Jun 2021 11:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623064056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYR7IvghcfjA1rIi6+K8SF5sWzjZa/NR3N7J0MakUj0=;
	b=bbKTbmg2Y42ZOvPKCZpuZwn73/InBeVD7+eeAFafhQXITilqCAgQDPIF8efEPRyE+m5BaL
	Yv1alZeUzpwSlNoT0xGNasz5sYkHlnRw/JHip1Y/2WguY8QxCoGFTLpeu5fj6vH2wKdBnp
	L2WYc5JvUIWbNd+MXqAzaR8HT1jHMXI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-RSNtwcaVM5GTFfz7jzNblA-1; Mon, 07 Jun 2021 07:07:35 -0400
X-MC-Unique: RSNtwcaVM5GTFfz7jzNblA-1
Received: by mail-wm1-f69.google.com with SMTP id z19-20020a7bc1530000b02901ab5fafdcb4so504127wmi.0
        for <mptcp@lists.linux.dev>; Mon, 07 Jun 2021 04:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HYR7IvghcfjA1rIi6+K8SF5sWzjZa/NR3N7J0MakUj0=;
        b=FVPIzQ9NOtC/NYqvybK/mTTqNWf4gD1FSG3YlIiO0Fw9bsPhDbFp3NbP0UXVJuTYSN
         CxkXYMk6GtXAa3op1mDxynweaDdcckOvIMBw6C24J7QrnrsJvw/cqVx4KA2hrTbAbT2w
         jXD2Sfl0L8UTpliT+YToNwGIf96FwpdhYxon7CCgh26MUkX8tgS+woO+c/yhxOLWBvMg
         BRU0oDbicxanOAccEdLyaOthbF6iyPfBegbHUIe5DC9BTa/52T8Q1AATj46j8Muth4yu
         joNygcWdzbIV6JroCZe4KNfSUew92i4IrZmdJ9M3Y0LVU8IIp30L1UTIPlD92b5E9vem
         zS6g==
X-Gm-Message-State: AOAM530B1U5CEJ2bQkIcHQtL84RIS5IYxAkdjPZeAA3BvUFd/ACmheot
	llWTeEb/9xRbY0ZJxl9QR23Hlop1HYDmoh7cshvDp1D8JKjBWQTdk0U06Wp3Qu+jOwsuTFT+Y5a
	C/RmWOQUsvNyCD1Y=
X-Received: by 2002:a5d:684d:: with SMTP id o13mr16511033wrw.174.1623064053904;
        Mon, 07 Jun 2021 04:07:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqYL6FyHFa+GVMykIguzA9JoD6yic9u2aGYKc6gG+x3ysh4mFjwAulXimbXK6kVrxB7pVn3g==
X-Received: by 2002:a5d:684d:: with SMTP id o13mr16511020wrw.174.1623064053731;
        Mon, 07 Jun 2021 04:07:33 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-110-123.dyn.eolo.it. [146.241.110.123])
        by smtp.gmail.com with ESMTPSA id d131sm17251871wmd.4.2021.06.07.04.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:07:33 -0700 (PDT)
Message-ID: <36744bda70bf5200fbb43544daca75342341734d.camel@redhat.com>
Subject: Re: [PATCH] mptcp: fix warning in __skb_flow_dissect() when do syn
 cookie for subflow join
From: Paolo Abeni <pabeni@redhat.com>
To: Jianguo Wu <wujianguo106@163.com>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Date: Mon, 07 Jun 2021 13:07:32 +0200
In-Reply-To: <21423fd3-708f-fa57-c496-e50057db78e0@163.com>
References: <21423fd3-708f-fa57-c496-e50057db78e0@163.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello,

On Sat, 2021-06-05 at 11:24 +0800, Jianguo Wu wrote:
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> I got the following warning message while doing the test:
> 
> [   55.552626] TCP: request_sock_subflow: Possible SYN flooding on port 8099. Sending cookies.  Check SNMP counters.
> [   55.553024] ------------[ cut here ]------------
> [   55.553027] WARNING: CPU: 0 PID: 10 at net/core/flow_dissector.c:984 __skb_flow_dissect+0x280/0x1650
> ...
> [   55.553117] CPU: 0 PID: 10 Comm: ksoftirqd/0 Not tainted 5.12.0+ #18
> [   55.553121] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
> [   55.553124] RIP: 0010:__skb_flow_dissect+0x280/0x1650
> ...
> [   55.553133] RSP: 0018:ffffb79580087770 EFLAGS: 00010246
> [   55.553137] RAX: 0000000000000000 RBX: ffffffff8ddb58e0 RCX: ffffb79580087888
> [   55.553139] RDX: ffffffff8ddb58e0 RSI: ffff8f7e4652b600 RDI: 0000000000000000
> [   55.553141] RBP: ffffb79580087858 R08: 0000000000000000 R09: 0000000000000008
> [   55.553143] R10: 000000008c622965 R11: 00000000d3313a5b R12: ffff8f7e4652b600
> [   55.553146] R13: ffff8f7e465c9062 R14: 0000000000000000 R15: ffffb79580087888
> [   55.553149] FS:  0000000000000000(0000) GS:ffff8f7f75e00000(0000) knlGS:0000000000000000
> [   55.553152] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   55.553154] CR2: 00007f73d1d19000 CR3: 0000000135e10004 CR4: 00000000003706f0
> [   55.553160] Call Trace:
> [   55.553166]  ? __sha256_final+0x67/0xd0
> [   55.553173]  ? sha256+0x7e/0xa0
> [   55.553177]  __skb_get_hash+0x57/0x210
> [   55.553182]  subflow_init_req_cookie_join_save+0xac/0xc0
> [   55.553189]  subflow_check_req+0x474/0x550
> [   55.553195]  ? ip_route_output_key_hash+0x67/0x90
> [   55.553200]  ? xfrm_lookup_route+0x1d/0xa0
> [   55.553207]  subflow_v4_route_req+0x8e/0xd0
> [   55.553212]  tcp_conn_request+0x31e/0xab0
> [   55.553218]  ? selinux_socket_sock_rcv_skb+0x116/0x210
> [   55.553224]  ? tcp_rcv_state_process+0x179/0x6d0
> [   55.553229]  tcp_rcv_state_process+0x179/0x6d0
> [   55.553235]  tcp_v4_do_rcv+0xaf/0x220
> [   55.553239]  tcp_v4_rcv+0xce4/0xd80
> [   55.553243]  ? ip_route_input_rcu+0x246/0x260
> [   55.553248]  ip_protocol_deliver_rcu+0x35/0x1b0
> [   55.553253]  ip_local_deliver_finish+0x44/0x50
> [   55.553258]  ip_local_deliver+0x6c/0x110
> [   55.553262]  ? ip_rcv_finish_core.isra.19+0x5a/0x400
> [   55.553267]  ip_rcv+0xd1/0xe0
> ...
> 
> After debugging, I found in __skb_flow_dissect(), skb->dev and skb->sk are both NULL,
> then net is NULL, and trigger WARN_ON_ONCE(!net), actually net is always NULL in this
> code path.
> 
> Code snippet in __skb_flow_dissect() that trigger warning:
>   975         if (skb) {
>   976                 if (!net) {
>   977                         if (skb->dev)
>   978                                 net = dev_net(skb->dev);
>   979                         else if (skb->sk)
>   980                                 net = sock_net(skb->sk);
>   981                 }
>   982         }
>   983
>   984         WARN_ON_ONCE(!net);
> 
> skb->dev is set to NULL in tcp_v4_rcv(), and skb->sk is never set in this code path.
> But for sk_state is TCP_NEW_SYN_RECV or TCP_TIME_WAIT, skb->dev is not set to NULL,
> so we can remove skb->dev = NULL in tcp_v4_rcv()?

Thank you for the detailed report!

I'm unable to find easily any negative side effect to remove such
assignment, still I'm more than a bit uneasy for such change.

The issue is clearly an mptcp-specific one, so I think event the fix
should be mptcp-specific.

If the skb->hash is not available - !skb_get_hash_raw(skb) == 0, then
we could fallback using an sk-derived hash, e.g. doing something alike
what inet_ehashfn() does - with different seeds/secrets.

Cheers,

Paolo

