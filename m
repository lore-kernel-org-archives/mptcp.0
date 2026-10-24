Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792881769;
	b=USE3CKI0Gv3qk0tv+rOC9Da6ou3POUMJGnZdLXRLnmerkpgc5RI7yUcCjtgEzv4pTY8t
	 pnX/QvqkX5c8Cw2UL2sHb8PJyr1zpX2mdV9Ll4gOg1NK4oAQJRD3c8chZEy7Bl66Z1t2A
	 f81ZNpGwDSJwWBDVoBxZtNmKGoSN+//yqfaIpbs9IwavbcG2f6pTJDJL+vDcppHNQwYj7
	 2xs+IUEaiLJT6/oBjfEfE7Yod4Cj8YqjgrQoVkFTGPWPBjq4pntKORimbSU+YK/ahQdVd
	 b7LrCUJBgWEAGAmY0BitJCAbNWQJzMYr8tiodeUY6+VmB1ECU3L+5lK9hVQF9mPMNzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792881769;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=A1pZZCGydh9cu6mbm+6sBP/cfhZEp5gKcsoOm5NIb+E=;
	b=Auvg1hTSZmSmM0EipBbwWz/9EWuJS9wGfN8rKuvQB6EYJ3zyMPsRAH7gvDEuayJ+0rGK
	 zZt/KfMa/+dsLOF2vByy4PqDoQcXC1FagXpvw/IdItj/E8o+444xfAKpZawNU6yrIcc8k
	 41fOHDRtj+phh0HlUHoPilntiWc2pwZdT8NhBI09Vl7iotndrG697C1xk+f27nqMymMNd
	 B9/YkSJFIpMC52IHpTw+GM2DwtQLMC6c8G3ToBVr9ktuhO04m23W6cUbPPuOndX42FAQG
	 ZKvs3Qi7N6YS54tP4KRvLi2Tt/Dttmad1Gxdzqqcdl7gWh/1LCM/YKFAuyvMaktLUdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OFXFqU8V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4DA606A31A
	for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OFXFqU8V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701FC1F01825;
	Sat, 24 Oct 2026 22:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792881768;
	bh=A1pZZCGydh9cu6mbm+6sBP/cfhZEp5gKcsoOm5NIb+E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OFXFqU8V6Db3Nq8ozQxEu6E6V7O82NdDJdTr/7jjRhyGJmvbm8JDXAmgh9goMtty6
	 GDxksialmcI/6Rj7c6ahfugNw+DFhN5XYFCJdabd/FVv7ltQBO6j8hEXkX50Z+koEP
	 PEXwhUe1NpvA31Fz0XCKLQ37rFaTBoSvf+mGnrASWemnDDNIMYH8Ri0jmUQIMZafee
	 tpeGXk5VTAmG+wfDbaYajLKy31enMELH+fJkurFpu+7P81jHJlC6zOv9gohAqiQt64
	 KyOmq50jzHkZrSY+xHKX1rH0QJypIeDoeaXB7aetXEtRMzp7SoGogfSTVcKT1NIyga
	 gaQXpEdD8ywoA==
Subject: Re: [PATCH mptcp-next 1/2] nbd: allow MPTCP sockets
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Sat, 24 Oct 2026 22:42:47 +0000
Message-ID: <179288176799.3132.8840650312946859071@kernel.org>
In-Reply-To: =?utf-8?q?=3C1612e1611a1e5d78d651a4c1a69da38fdcf98ca8=2E1792746?=
 =?utf-8?q?800=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C1612e1611a1e5d78d651a4c1a69da38fdcf98ca8=2E17927468?=
 =?utf-8?q?00=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] NBD's memory-reserve setup for its socket does not reach the TCP
  subflows of an MPTCP socket.
- [High] Accepting MPTCP sockets lets an in-kernel, process-context
  worker hold the NBD msk socket lock while making reclaim-capable…
- [Medium] nbd_reclassify_socket() (drivers/block/nbd.c:1247-1274) moves
  only sock->sk into the NBD lock classes.

--

nbd: allow MPTCP sockets

This patch adds an msk_is_mptcp() check to nbd_get_socket(), so NBD
accepts MPTCP sockets as well as TCP and stream UNIX sockets. The
stated goal is to aggregate bandwidth across several NICs.

> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index ffce519bf0087..2aeb22b1ad40e 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c

[ ... ]

> @@ -1221,8 +1222,9 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
>  		return NULL;
>  
>  	if (!sk_is_tcp(sock->sk) &&
> +	    !msk_is_mptcp(sock->sk) &&

[Severity: High]
Once an MPTCP socket is accepted here, does NBD's memalloc setup reach
the sockets that actually carry the traffic?

NBD marks sock->sk in nbd_start_device() and
nbd_genl_reconnect_sock_cb():

    sk_set_memalloc(config->socks[i]->sock->sk);

and __sock_xmit() sets:

    sock->sk->sk_allocation = GFP_NOIO | __GFP_MEMALLOC;
    sock->sk->sk_use_task_frag = false;

For MPTCP, sock->sk is the msk. The data travels on TCP subflows created
by mptcp_subflow_create_socket()->sock_create_kern().

sync_socket_options() in net/mptcp/sockopt.c copies SOCK_KEEPOPEN,
SOCK_LINGER, SOCK_DBG, priority, mark and similar settings to the
subflow. It does not copy SOCK_MEMALLOC or sk_allocation, and nothing
under net/mptcp/ seems to refer to SOCK_MEMALLOC.

On receive, tcp_v4_rcv()->tcp_filter()->sk_filter_trim_cap() checks
the subflow, not the msk:

net/core/filter.c:sk_filter_trim_cap() {
    ...
	if (skb_pfmemalloc(skb) && !sock_flag(sk, SOCK_MEMALLOC)) {
		NET_INC_STATS(sock_net(sk), LINUX_MIB_PFMEMALLOCDROP);
		return SKB_DROP_REASON_PFMEMALLOC;
	}
    ...
}

Because the msk is marked, sk_memalloc_socks() is enabled, and drivers
can pass up pfmemalloc RX skbs under memory pressure. Wouldn't every
NBD reply, and every retransmission, that arrives in such an skb be
dropped at the subflow?

Transmit allocations on the subflow (ACKs, SYNs, retransmit clones via
sk_gfp_mask(ssk, ...)) also keep the default GFP_KERNEL. Subflows that
the path manager adds later through __mptcp_subflow_connect() start
with the same defaults.

With swap or dirty writeback on an NBD-over-MPTCP device, can this
stall or livelock reclaim? Preventing that for TCP is the reason
sk_set_memalloc() is called. The commit message does not mention this
limitation.

[Severity: Medium]
Does nbd_reclassify_socket() still cover the socket locks NBD takes
when the socket is MPTCP?

nbd_reclassify_socket() only reclassifies sock->sk:

drivers/block/nbd.c:nbd_reclassify_socket() {
	struct sock *sk = sock->sk;
    ...
	case AF_INET:
		sock_lock_init_class_and_name(sk, "slock-AF_INET-NBD",
    ...
}

This helper came from commit d532cddb6c60 ("nbd: Reclassify sockets to
avoid lockdep circular dependency"). For MPTCP, only the msk lock moves
into the NBD class.

Every NBD send also takes subflow locks through
mptcp_sendmsg()->__mptcp_push_pending()->lock_sock(ssk). Subflows are
kernel sockets from sock_create_kern(), so they share the
k-sk_lock-AF_INET/AF_INET6 class with every other MPTCP subflow on the
system.

Ordinary MPTCP user sockets allocate with GFP_KERNEL while holding a
lock of that class. The path is
__subflow_push_pending()->mptcp_sendmsg_frag()->mptcp_alloc_tx_skb():

    gfp_t gfp = data_lock_held ? GFP_ATOMIC : sk->sk_allocation;

That records a k-sk_lock -> fs_reclaim dependency. Meanwhile, NBD I/O
issued under the block layer's reclaim ordering takes the same class.

Could this bring back the fs_reclaim/sk_lock circular dependency report
that d532cddb6c60 suppressed, this time through the subflow lock class?
Nothing seems to reclassify subflows, including the ones the path
manager creates later.

[Severity: High]
Can accepting MPTCP sockets lead to a deadlock between reclaim and the
msk socket lock?

mptcp_worker() runs on the system workqueue and holds the msk lock
while it runs the path manager and closes subflows:

net/mptcp/protocol.c:mptcp_worker() {
    ...
	lock_sock(sk);
    ...
	mptcp_pm_worker(msk);
    ...
	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
		__mptcp_close_subflow(sk);
    ...
}

>From there, __mptcp_subflow_connect() calls
mptcp_subflow_create_socket()->sock_create_kern() and
subflow_ulp_init()->subflow_create_ctx(sk, GFP_KERNEL). The subflow
close path also calls mptcp_close_ssk()->mptcp_event(..., GFP_KERNEL).
None of this runs under a memalloc_noio scope.

If direct reclaim in that worker waits on swap or writeback to the NBD
device, the NBD I/O needs the same msk lock:

    nbd_queue_rq()->sock_xmit()->mptcp_sendmsg()->lock_sock(msk)
    recv_work()->sock_xmit()->mptcp_recvmsg()->lock_sock(msk)

Wouldn't the worker and NBD then wait on each other?

There is also a self-deadlock case. If the worker's own reclaim flushes
a plug into the BLK_MQ_F_BLOCKING nbd queue from the worker's own
context, lock_sock() would wait on an msk that the same task already
holds.

The memalloc_noreclaim_save() call and the sk_allocation setting in
__sock_xmit() only cover the NBD task and allocations that use
sk_allocation. They do not cover explicit GFP_KERNEL allocations in the
MPTCP worker. With plain TCP, no in-kernel process context sleeps in
reclaim while holding the NBD socket lock.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792746800.git.tanggeliang%40kylinos.cn
