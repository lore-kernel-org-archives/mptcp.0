Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792667873;
	b=pJrQjgU3v7KldP+J/3lI3ZRHOM4xyy07ZRpTLujMsypnxO5rj4mg+09+lIv58ewFywst
	 vL0vILvdswJ/AtcJHDWg8l5mIplCG1t6cTahhBTZM9AW/U3PqIFjGB/JGDTrsodjwCbpX
	 1SgVPaOWbaBJ3S5iaPxbEV0xbzFuTKeK1OabiJNBIV9Jc3F2RUsWXxVPnqiIBaJn39rFg
	 m5syX76fAAOTTEUMSzumTpJfJs/REkF+Uce0530UMPMqbubWhYcB+ojTOuMeB4yxPHtGe
	 sIcHedoU7aifa8QAL51GsGVtUhaU9EV75ttJUFxWNKs4d2y/iVrLr4GgfosNds/d3Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792667873;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=h7+J0U3lvfvF1yCcBdaCydq6NkgERK4I0MzDhq//0Zw=;
	b=g9lu5Ca2CDfuo5FoIKvG3hKvmhHNoakyoP+tnSe6ZtCEpisoYyxgDTYNRyE9W8nDi8Ue
	 Nu3dUrMIayJ0Af5D8A2Iklr5Qxw793pky9uOcn9CiP/zPcMXVMgjF0qHFKpCyr+z9Cou1
	 14gOPZBk39nV2LRgoAUpCFm/mFBEDsvwRT4xywmLX7WjMHHg7lzNEjJKGa5QdtWYby9eM
	 r7+ZD6oUhJx6baWcbqrNPMqsSwOKl3nNay4Iust3r8V0jVWbqdZV3UnJHPBq1is3Wsr8q
	 YwMjQjhy9EBWtWRE7q3jOfdQXX6cQrCeYYKmU3hX5fGptrmyjwCt+j3ksSQh1dvxsYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n9PQgpa0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161AE606A319
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n9PQgpa0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096231F000C1;
	Thu, 22 Oct 2026 11:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792667872;
	bh=h7+J0U3lvfvF1yCcBdaCydq6NkgERK4I0MzDhq//0Zw=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=n9PQgpa0BsB8cuixHOj7oY5n3NCsrekzIq6uUUSj+vtmS7eOPAeie//7clDKhLLlM
	 74k1K1iqrkaZhyK8LKPpNFlltXseMBi63npbeNhI4qhOLo01QS8wqaMAA9TTeVTvIo
	 Q47le9c93BetvSe5OhYQYEbFcIVvZZf5ARMw7e0Skls0FHNrVUhig8jqcauKFBYzbP
	 4/kUFE5dWr5IYpJ9334B1usTPAkBiU4lBl35KoQ8V3KjL3aV7vN4bKxf3P7k7I/Iqu
	 Dz0Xap09brTDNcpErxjgMcQzoS/cicIrw2DSyJ4GJxTJO7oA6UGRJ6MXDVW2Id2oyA
	 pjYXTse4wrnZw==
Message-ID: <14824187-7186-4c9e-bb14-77c8599a3fd0@kernel.org>
Date: Thu, 22 Oct 2026 13:17:50 +0200
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2] mptcp: annotate lockless access to
 msk->scaling_ratio
Content-Language: fr
To: quanyeyang@proton.me, MPTCP Linux <mptcp@lists.linux.dev>
References: <20261016-t-mptcp-scaling-ratio-kcsan-v2-1-241d1f92dcf1@proton.me>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261016-t-mptcp-scaling-ratio-kcsan-v2-1-241d1f92dcf1@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Quanye,

On 17/10/2026 07:23, Quanye Yang via B4 Relay wrote:
> From: Quanye Yang <quanyeyang@proton.me>
> 
> mptcp_rcv_rtt_update() writes msk->scaling_ratio from BH while holding
> the msk data lock (sk->sk_lock.slock). mptcp_cleanup_rbuf() reads the
> same byte via mptcp_win_from_space() after mptcp_release_cb() drops
> that lock, so it can run concurrently with the RX path.
> 
> KCSAN reports:
> 
>   BUG: KCSAN: data-race in mptcp_cleanup_rbuf / mptcp_data_ready
> 
>   write to 0xffff888014978790 of 1 bytes by interrupt on cpu 1:
>    mptcp_rcv_rtt_update net/mptcp/protocol.c:1045 [inline]
>    mptcp_data_ready+0x1c1/0x4d0 net/mptcp/protocol.c:1062
>    subflow_data_ready+0x271/0x350 net/mptcp/subflow.c:1536
>    tcp_data_ready+0x92/0x2c0 net/ipv4/tcp_input.c:5604
>    tcp_data_queue+0x1236/0x26c0 net/ipv4/tcp_input.c:5694
>    tcp_rcv_established+0x695/0x1fb0 net/ipv4/tcp_input.c:6689
>    tcp_v4_do_rcv+0x356/0x6e0 net/ipv4/tcp_ipv4.c:1854
>    tcp_v4_rcv+0x1b04/0x26b0 net/ipv4/tcp_ipv4.c:2248
> 
>   read to 0xffff888014978790 of 1 bytes by task 2624 on cpu 0:
>    mptcp_win_from_space net/mptcp/protocol.h:421 [inline]
>    __mptcp_space net/mptcp/protocol.h:431 [inline]
>    mptcp_cleanup_rbuf+0x8a/0x380 net/mptcp/protocol.c:680
>    mptcp_release_cb+0x375/0x900 net/mptcp/protocol.c:3889
>    release_sock+0x100/0x150 net/core/sock.c:3866
>    sk_wait_data+0x141/0x2f0 net/core/sock.c:3314
>    mptcp_recvmsg+0x6cd/0xd50 net/mptcp/protocol.c:2496
> 
>   value changed: 0xd0 -> 0xd5
> 
>   Reported by Kernel Concurrency Sanitizer on:
>   CPU: 0 UID: 0 PID: 2624 Comm: syz.7.22 Not tainted 7.3.0-rc1-gbaff4b3d06ef #77 PREEMPT(full)
> 
> The u8 EWMA is used only to convert sk_rcvbuf occupancy into an
> advertised window. A slightly stale ratio is acceptable, so annotate
> the lockless accesses with READ_ONCE()/WRITE_ONCE() instead of
> widening the data lock. Do the same in mptcp_space_from_win(), which
> reads the same field from DRS and SO_RCVLOWAT.

Thank you, it looks good to me:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

I just applied it in our tree, but for net-next because from what I
understood, KCSAN issues are not considered as "urgent", so it should go
to -next first.

New patches for t/upstream:
- ab82be554559: mptcp: annotate lockless access to msk->scaling_ratio
- Results: 54143bb812b1..15904a7a5590 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/10148edc4b64c7799f9109d3ece843362819f108/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

