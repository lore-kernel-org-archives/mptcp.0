Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3191CAA1
	for <mptcp@lists.linux.dev>; Wed,  1 Nov 2023 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVOttfBE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FEBC433C7;
	Wed,  1 Nov 2023 23:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698882942;
	bh=bVIl6J+Jkqv1aM2+x7k58TPVIGa/5UnILISArGUEKBs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=aVOttfBE/WthQBbiP1zkSnJ2EhcCla3zl6h7WjtPpKgMMQ9TTJnJtgnoAzYMkK3eQ
	 NJ+JPzw/EvTJU4ESyu1ucvZiA/Nm6WQrDO8xAXnPHzEpn73qy4n/NPUSUAu4MGfLvP
	 jJMYG5KK/HlJGnYBxl+Swyih7B+S+OmeIbMY0ux7rpHLnbyRwlql30zfVOkVgbyrIE
	 6OIDUS9/vmD4UwahDpuYdncvWvF44/MulMTRgYAfmj5zMwebp9b2c0JNvEZQjeyoHJ
	 ayDbBb3AStGxzmTUBEZxnHauVklLZ7TQphDlOD2tLUYYYgU3D3lPesM5EzTzKY/Xob
	 1YGIvF+dnqFyA==
Date: Wed, 1 Nov 2023 16:55:41 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Christoph Paasch <cpaasch@apple.com>
Subject: Re: [PATCH net-next] mptcp: deal with large GSO size.
In-Reply-To: <32c24621024b572e3dc50d3d84539ec7a2206b4d.camel@redhat.com>
Message-ID: <c79a92e3-1ed8-5a64-da36-3dcac2eb2a44@kernel.org>
References: <ce93989da39fd2e47baa4506fbbf4c2049c2da13.1698416467.git.pabeni@redhat.com> <32c24621024b572e3dc50d3d84539ec7a2206b4d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 27 Oct 2023, Paolo Abeni wrote:

> On Fri, 2023-10-27 at 16:21 +0200, Paolo Abeni wrote:
>> After the blamed commit below, the TCP sockets (and the MPTCP subflows)
>> can build egress packets larger then 64K. That exceeds the maximum DSS
>> data size, the length being misrepresent on the wire and the stream being
>> corrupted, as later observed on the receiver:
>>
>> WARNING: CPU: 0 PID: 9696 at net/mptcp/protocol.c:705 __mptcp_move_skbs_from_subflow+0x2604/0x26e0
>> CPU: 0 PID: 9696 Comm: syz-executor.7 Not tainted 6.6.0-rc5-gcd8bdf563d46 #45
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
>> netlink: 8 bytes leftover after parsing attributes in process `syz-executor.4'.
>> RIP: 0010:__mptcp_move_skbs_from_subflow+0x2604/0x26e0 net/mptcp/protocol.c:705
>> RSP: 0018:ffffc90000006e80 EFLAGS: 00010246
>> RAX: ffffffff83e9f674 RBX: ffff88802f45d870 RCX: ffff888102ad0000
>> netlink: 8 bytes leftover after parsing attributes in process `syz-executor.4'.
>> RDX: 0000000080000303 RSI: 0000000000013908 RDI: 0000000000003908
>> RBP: ffffc90000007110 R08: ffffffff83e9e078 R09: 1ffff1100e548c8a
>> R10: dffffc0000000000 R11: ffffed100e548c8b R12: 0000000000013908
>> R13: dffffc0000000000 R14: 0000000000003908 R15: 000000000031cf29
>> FS:  00007f239c47e700(0000) GS:ffff88811b200000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f239c45cd78 CR3: 000000006a66c006 CR4: 0000000000770ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
>> PKRU: 55555554
>> Call Trace:
>>  <IRQ>
>>  mptcp_data_ready+0x263/0xac0 net/mptcp/protocol.c:819
>>  subflow_data_ready+0x268/0x6d0 net/mptcp/subflow.c:1409
>>  tcp_data_queue+0x21a1/0x7a60 net/ipv4/tcp_input.c:5151
>>  tcp_rcv_established+0x950/0x1d90 net/ipv4/tcp_input.c:6098
>>  tcp_v6_do_rcv+0x554/0x12f0 net/ipv6/tcp_ipv6.c:1483
>>  tcp_v6_rcv+0x2e26/0x3810 net/ipv6/tcp_ipv6.c:1749
>>  ip6_protocol_deliver_rcu+0xd6b/0x1ae0 net/ipv6/ip6_input.c:438
>>  ip6_input+0x1c5/0x470 net/ipv6/ip6_input.c:483
>>  ipv6_rcv+0xef/0x2c0 include/linux/netfilter.h:304
>>  __netif_receive_skb+0x1ea/0x6a0 net/core/dev.c:5532
>>  process_backlog+0x353/0x660 net/core/dev.c:5974
>>  __napi_poll+0xc6/0x5a0 net/core/dev.c:6536
>>  net_rx_action+0x6a0/0xfd0 net/core/dev.c:6603
>>  __do_softirq+0x184/0x524 kernel/softirq.c:553
>>  do_softirq+0xdd/0x130 kernel/softirq.c:454
>>
>> Address the issue explicitly bounding the maximum GSO size to what MPTCP
>> actually allows.
>>
>> Reported-by: Christoph Paasch <cpaasch@apple.com>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/450
>> Fixes: 7c4e983c4f3c ("net: allow gso_max_size to exceed 65536")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> this is a rough quick attempt to address the issue. A cleaner one
>> would be catching sk_gso_max_size in the control path and bound the
>> value there. Done this way to:
>> - allow earlier testing
>> - create a much smaller patch.
>
> To share more details, the other option will need to check and bound
> sk_gso_max_size every time/place where such field is updated:
>
> 1) after icsk_af_ops->syn_recv_sock
> 2) after icsk_af_ops->rebuild_header
> 3) after icsk_af_ops->mtu_reduced
> 4) after icsk_af_ops->queue_xmit
> 5) after connect()
>
> 1) would be straight forward, 2) will require separate modification for
> ipv4 and ipv6, 3 & 4 the same, plus additional new subflow specific
> implementation, and finally 5 is problematic in the fastopen case,
> because we would need a new hook inside the tcp code.
>
> All in all I think we are better off adding just an additional
> conditional in the fastpath.

Hi Paolo -

I only see one place where sk_gso_max_size is updated, in sk_setup_caps():

 	sk->sk_gso_max_size = sk_dst_gso_max_size(sk, dst);

Looks like your list above is the call sites for sk_setup_caps()?

Seems like an earlier check and smaller patch to instead update the logic 
in sk_dst_gso_max_size():

 	if (max_size > GSO_LEGACY_MAX_SIZE && (!sk_is_tcp(sk) || sk_is_mptcp(sk)))
 		max_size = GSO_LEGACY_MAX_SIZE;

Fortunately by the time the sk_is_mptcp() is evaluated it has already been 
checked that sk is a struct tcp_sock *. Makes me wonder if sk_is_mptcp() 
should accept any sock pointer, I'll add a github issue for that.

- Mat
