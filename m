Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E43518654
	for <mptcp@lists.linux.dev>; Fri, 27 Oct 2023 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imXvm/i5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698418019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JercDm1m0zXbwU/V7pgz+aJaYFxg9sbH4gaiHNhvvXA=;
	b=imXvm/i5gauni4wIUBMWi85z0eBXqn2ge4P7FekWDSEMvf67hrfY319S0/9IxN8Gnzz6mU
	BA5Fe+qKzekoTyXXVDG2DlyWj5yv2hvZ50fcYggHiC4NiYl5J7ucNFx2a9V6gbfNUX5lfC
	Ez75V+iHX1u2zPMr39kAhvvZIo5js9Y=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-lZazbA-QNf-kbik2MusBuQ-1; Fri, 27 Oct 2023 10:46:56 -0400
X-MC-Unique: lZazbA-QNf-kbik2MusBuQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5401a40d5e9so450436a12.1
        for <mptcp@lists.linux.dev>; Fri, 27 Oct 2023 07:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698418014; x=1699022814;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JercDm1m0zXbwU/V7pgz+aJaYFxg9sbH4gaiHNhvvXA=;
        b=u5/v1A2sl4fcyWnrCGO8YhlBW69OFVPAE9z9UBA/Q+/cWBXp+fQUrMstiI+pYqDo0v
         QIb0rycCAT7ySk3emiJQG7e024IXfP5RtZy2R70tGpq+Z0sGmYiD+cPg1B1FN3or2bb0
         qgWJ9/qzAhdDNO2DwIb3RbhNvLq/GYe+2Ne2ZLI1846MiV1DXZDvZ0+hlU0ZQhbMZxkH
         azwduHAVEfEPfYjpqj5lMgwpfcZPLLWBS5xnot2CBMjVEZa7oO3rTnnu542qhqEugUr9
         7jpAX989LR3xOsWTBz5un+wMt9ilRLzeg5wWWyaTL4aPauGkaPpEqoOISGFnZTRf4zRJ
         /Vtw==
X-Gm-Message-State: AOJu0YwhE6PUpZcGGsJ096D565RdI2S9z7GPhip5i1LLeWz2IvBdZI2d
	SsTZ3+WxppW+GFphQcaWGCj1gv2k8MbC26PHXheRUQa+T+lpy4PqcDFCfBGTxosPYFk6rMZBcAj
	rY4d8inE9zDg3CqmRmBUEkCFmcGcCZZdmU2Bp8oqSoVQkQ0wK4ckIOSuNlhb0n5OP7CeqAwbR
X-Received: by 2002:a05:6402:f23:b0:542:aa94:271c with SMTP id i35-20020a0564020f2300b00542aa94271cmr1489741eda.3.1698418014621;
        Fri, 27 Oct 2023 07:46:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRVisy7ruv3ZEuxqiQHkTZ4m9YsqItslLcahvjDizAkV6ZwG76wxeTQ6zzKn+jvBNcxavGyg==
X-Received: by 2002:a05:6402:f23:b0:542:aa94:271c with SMTP id i35-20020a0564020f2300b00542aa94271cmr1489724eda.3.1698418014259;
        Fri, 27 Oct 2023 07:46:54 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-240-51.dyn.eolo.it. [146.241.240.51])
        by smtp.gmail.com with ESMTPSA id n18-20020a50c212000000b005413bdb8de6sm1349112edf.89.2023.10.27.07.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:46:53 -0700 (PDT)
Message-ID: <32c24621024b572e3dc50d3d84539ec7a2206b4d.camel@redhat.com>
Subject: Re: [PATCH net-next] mptcp: deal with large GSO size.
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Date: Fri, 27 Oct 2023 16:46:52 +0200
In-Reply-To: <ce93989da39fd2e47baa4506fbbf4c2049c2da13.1698416467.git.pabeni@redhat.com>
References: <ce93989da39fd2e47baa4506fbbf4c2049c2da13.1698416467.git.pabeni@redhat.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2023-10-27 at 16:21 +0200, Paolo Abeni wrote:
> After the blamed commit below, the TCP sockets (and the MPTCP subflows)
> can build egress packets larger then 64K. That exceeds the maximum DSS
> data size, the length being misrepresent on the wire and the stream being
> corrupted, as later observed on the receiver:
>=20
> WARNING: CPU: 0 PID: 9696 at net/mptcp/protocol.c:705 __mptcp_move_skbs_f=
rom_subflow+0x2604/0x26e0
> CPU: 0 PID: 9696 Comm: syz-executor.7 Not tainted 6.6.0-rc5-gcd8bdf563d46=
 #45
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 =
04/01/2014
> netlink: 8 bytes leftover after parsing attributes in process `syz-execut=
or.4'.
> RIP: 0010:__mptcp_move_skbs_from_subflow+0x2604/0x26e0 net/mptcp/protocol=
.c:705
> RSP: 0018:ffffc90000006e80 EFLAGS: 00010246
> RAX: ffffffff83e9f674 RBX: ffff88802f45d870 RCX: ffff888102ad0000
> netlink: 8 bytes leftover after parsing attributes in process `syz-execut=
or.4'.
> RDX: 0000000080000303 RSI: 0000000000013908 RDI: 0000000000003908
> RBP: ffffc90000007110 R08: ffffffff83e9e078 R09: 1ffff1100e548c8a
> R10: dffffc0000000000 R11: ffffed100e548c8b R12: 0000000000013908
> R13: dffffc0000000000 R14: 0000000000003908 R15: 000000000031cf29
> FS:  00007f239c47e700(0000) GS:ffff88811b200000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f239c45cd78 CR3: 000000006a66c006 CR4: 0000000000770ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> PKRU: 55555554
> Call Trace:
>  <IRQ>
>  mptcp_data_ready+0x263/0xac0 net/mptcp/protocol.c:819
>  subflow_data_ready+0x268/0x6d0 net/mptcp/subflow.c:1409
>  tcp_data_queue+0x21a1/0x7a60 net/ipv4/tcp_input.c:5151
>  tcp_rcv_established+0x950/0x1d90 net/ipv4/tcp_input.c:6098
>  tcp_v6_do_rcv+0x554/0x12f0 net/ipv6/tcp_ipv6.c:1483
>  tcp_v6_rcv+0x2e26/0x3810 net/ipv6/tcp_ipv6.c:1749
>  ip6_protocol_deliver_rcu+0xd6b/0x1ae0 net/ipv6/ip6_input.c:438
>  ip6_input+0x1c5/0x470 net/ipv6/ip6_input.c:483
>  ipv6_rcv+0xef/0x2c0 include/linux/netfilter.h:304
>  __netif_receive_skb+0x1ea/0x6a0 net/core/dev.c:5532
>  process_backlog+0x353/0x660 net/core/dev.c:5974
>  __napi_poll+0xc6/0x5a0 net/core/dev.c:6536
>  net_rx_action+0x6a0/0xfd0 net/core/dev.c:6603
>  __do_softirq+0x184/0x524 kernel/softirq.c:553
>  do_softirq+0xdd/0x130 kernel/softirq.c:454
>=20
> Address the issue explicitly bounding the maximum GSO size to what MPTCP
> actually allows.
>=20
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/450
> Fixes: 7c4e983c4f3c ("net: allow gso_max_size to exceed 65536")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> this is a rough quick attempt to address the issue. A cleaner one
> would be catching sk_gso_max_size in the control path and bound the
> value there. Done this way to:
> - allow earlier testing
> - create a much smaller patch.

To share more details, the other option will need to check and bound=20
sk_gso_max_size every time/place where such field is updated:

1) after icsk_af_ops->syn_recv_sock
2) after icsk_af_ops->rebuild_header=20
3) after icsk_af_ops->mtu_reduced=09
4) after icsk_af_ops->queue_xmit
5) after connect()

1) would be straight forward, 2) will require separate modification for
ipv4 and ipv6, 3 & 4 the same, plus additional new subflow specific
implementation, and finally 5 is problematic in the fastopen case,
because we would need a new hook inside the tcp code.

All in all I think we are better off adding just an additional
conditional in the fastpath.

Cheers,

Paolo

