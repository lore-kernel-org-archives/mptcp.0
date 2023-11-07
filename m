Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BEE347A0
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4CiK3Xj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76B9C433C8;
	Tue,  7 Nov 2023 17:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699377818;
	bh=BxYexYBfjLaZrcWqEVUTIAaH0afxFfLvwVjgbjPvJno=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=u4CiK3XjnKIQiiqxE13QVIygg6DKu/FqSGkw4OEK2TBeJ2nE+eGzW+ghz6gto4G0G
	 3zasRuf1SUO2jRSzCKfo8gs7jy15qUSPFvkhpHWa4UUkG6an8UQ6TqoNa4pyfkFGto
	 JknBabYcSw9Dlq9xWnpXGgIpXWgev49OGCw/dtqOC/NStpNVzilH58pNf7yw6BDikM
	 0KyYNFVlU9xGi2xTiaIODGs42vkTkCjgVskhgvK4E4roMHr/L6GRvK6/jaRc//hUoD
	 arGw5uyC+qubJFl+EcoICVYeO8d9/m2GnPxHIGXiBicXaymSYWzliEBOf91amNsvMo
	 NTq8FFrsm58ww==
Date: Tue, 7 Nov 2023 09:23:38 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Christoph Paasch <cpaasch@apple.com>
Subject: Re: [PATCH net-next] mptcp: deal with large GSO size.
In-Reply-To: <ce93989da39fd2e47baa4506fbbf4c2049c2da13.1698416467.git.pabeni@redhat.com>
Message-ID: <1a21de2c-c2d3-96af-52b3-db45858c39f8@kernel.org>
References: <ce93989da39fd2e47baa4506fbbf4c2049c2da13.1698416467.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 27 Oct 2023, Paolo Abeni wrote:

> After the blamed commit below, the TCP sockets (and the MPTCP subflows)
> can build egress packets larger then 64K. That exceeds the maximum DSS
> data size, the length being misrepresent on the wire and the stream being
> corrupted, as later observed on the receiver:
>
> WARNING: CPU: 0 PID: 9696 at net/mptcp/protocol.c:705 __mptcp_move_skbs_from_subflow+0x2604/0x26e0
> CPU: 0 PID: 9696 Comm: syz-executor.7 Not tainted 6.6.0-rc5-gcd8bdf563d46 #45
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
> netlink: 8 bytes leftover after parsing attributes in process `syz-executor.4'.
> RIP: 0010:__mptcp_move_skbs_from_subflow+0x2604/0x26e0 net/mptcp/protocol.c:705
> RSP: 0018:ffffc90000006e80 EFLAGS: 00010246
> RAX: ffffffff83e9f674 RBX: ffff88802f45d870 RCX: ffff888102ad0000
> netlink: 8 bytes leftover after parsing attributes in process `syz-executor.4'.
> RDX: 0000000080000303 RSI: 0000000000013908 RDI: 0000000000003908
> RBP: ffffc90000007110 R08: ffffffff83e9e078 R09: 1ffff1100e548c8a
> R10: dffffc0000000000 R11: ffffed100e548c8b R12: 0000000000013908
> R13: dffffc0000000000 R14: 0000000000003908 R15: 000000000031cf29
> FS:  00007f239c47e700(0000) GS:ffff88811b200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f239c45cd78 CR3: 000000006a66c006 CR4: 0000000000770ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> PKRU: 55555554
> Call Trace:
> <IRQ>
> mptcp_data_ready+0x263/0xac0 net/mptcp/protocol.c:819
> subflow_data_ready+0x268/0x6d0 net/mptcp/subflow.c:1409
> tcp_data_queue+0x21a1/0x7a60 net/ipv4/tcp_input.c:5151
> tcp_rcv_established+0x950/0x1d90 net/ipv4/tcp_input.c:6098
> tcp_v6_do_rcv+0x554/0x12f0 net/ipv6/tcp_ipv6.c:1483
> tcp_v6_rcv+0x2e26/0x3810 net/ipv6/tcp_ipv6.c:1749
> ip6_protocol_deliver_rcu+0xd6b/0x1ae0 net/ipv6/ip6_input.c:438
> ip6_input+0x1c5/0x470 net/ipv6/ip6_input.c:483
> ipv6_rcv+0xef/0x2c0 include/linux/netfilter.h:304
> __netif_receive_skb+0x1ea/0x6a0 net/core/dev.c:5532
> process_backlog+0x353/0x660 net/core/dev.c:5974
> __napi_poll+0xc6/0x5a0 net/core/dev.c:6536
> net_rx_action+0x6a0/0xfd0 net/core/dev.c:6603
> __do_softirq+0x184/0x524 kernel/softirq.c:553
> do_softirq+0xdd/0x130 kernel/softirq.c:454
>
> Address the issue explicitly bounding the maximum GSO size to what MPTCP
> actually allows.
>
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
> ---
> net/mptcp/protocol.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b41f8c3e0c00..d522fabc863d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1234,6 +1234,8 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
> 	mptcp_do_fallback(ssk);
> }
>
> +#define MPTCP_MAX_GSO_SIZE (GSO_LEGACY_MAX_SIZE - (MAX_TCP_HEADER + 1))
> +
> static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> 			      struct mptcp_data_frag *dfrag,
> 			      struct mptcp_sendmsg_info *info)
> @@ -1260,6 +1262,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> 		return -EAGAIN;
>
> 	/* compute send limit */
> +	if (unlikely(ssk->sk_gso_max_size > MPTCP_MAX_GSO_SIZE))
> +		ssk->sk_gso_max_size = MPTCP_MAX_GSO_SIZE;
> 	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
> 	copy = info->size_goal;
>

As we discussed in the meeting, since the limit is related to the 
MPTCP-specific DSS limitations (which could change) rather than anything 
directly related to GSO, it's helpful to have this check in the MPTCP 
code.

Reviewed-by: Mat Martineau <martineau@kernel.org>
