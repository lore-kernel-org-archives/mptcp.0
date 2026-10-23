Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792748832;
	b=OdBUH2kZ57JVj6Lm7wfeaxbwLUcU+iXR5vWE6Pg+4Rw+ZBjojxRZsoPmZy/zW2DbF5yu
	 AkOUdZX/dgKXwA+YenEHNdvALZWqpNPlxSzlzb81L8iJrj/BXpNrYK8JQ9Rvt7YqjEpG9
	 M2nqPk6jtp1J/bVkc40pepY9H8iLzFfAR4m5+GUbvBC9sLLbdFgiii+S++zSyfqNGQEkr
	 32m0C+s2/9PlsEWoXpQrq6MXSwE1t7Q7kogOk1huUty+QoyPO5VrqqKSPbkSJs8Y6yHFO
	 sapdZm+YJm0eNyPTBVzZiqL6sHr9LeW/VgmXVg1wIzJ6urty3841Ili3g0BU+mhN9Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748832;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9oAbCgEMrP0mEyAoEYk2h9xY6C0kaWWKdK2Laon+PV8=;
	b=NR7dbUoKH80rby2lF/fvIX4ExatIxNG9BOkj8AQOT3dTJYpNUpEfoSlQ5JjGsIvVn1cj
	 QIE+7+q9tj4ivIV0SOyqtJIh29UfBsGQ6kLu4Z7mLGvRagv7EXl8JFameqdf/faF31JtF
	 ZHnoU2VqJbCNRb8Ne8K3C+xPZyl/pIKa6eipNQ8elAgPZod14VyDOowfTGeH9G1f/nhYO
	 drV93CTOU5SunK+2jtDEU9Jh63fj3s6AOcq1tMMOX0OCjLcLpfgTI/25sE6BMWb0Azgwx
	 RNYq1BYg4YbmWob3jKHq7JhxHg6LYoKVEg6rg9MSE4ILoQhXNZzTA4mIfRUG6mZIYjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3AiKO6w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B93C606A325
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3AiKO6w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459E11F01825;
	Fri, 23 Oct 2026 09:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792748832;
	bh=9oAbCgEMrP0mEyAoEYk2h9xY6C0kaWWKdK2Laon+PV8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=L3AiKO6whGpApL+8nA5GxLbpFn0ZWPVte193RROLqI3zyW7F/am5GRHypvn1Daoox
	 tIAKZdZa9uFra/xAkypRkyffChUuZPbMUUJLO8v9huE/A/6rM0pVf598rLwHF77PDa
	 BUdqGcq3lEQ2cmKYePq0eZ61mMwudG9fxNdmM6KXOQpZ5phNpSevs9JASU6z2IXn+7
	 OhhC49kK9SK6QZ9Rl/cEh/LGk7JO51EAkdGziXBhSgP22aONvTn+PSaQFv8cbJ7SON
	 pi7sWjIz8O0R0jVONksm9clQ/nCneqfQDsBpmSHPCHu7PooAivsMoee5M3gkYNeXXw
	 crGE11eEOxGyA==
Message-ID: <sashiko-outbox-182633@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next 1/2] nbd: allow MPTCP sockets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <1612e1611a1e5d78d651a4c1a69da38fdcf98ca8.1792746800.git.tanggeliang@kylinos.cn>
References: <cover.1792746800.git.tanggeliang@kylinos.cn>
 <1612e1611a1e5d78d651a4c1a69da38fdcf98ca8.1792746800.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 09:47:11 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] nbd: missing SOCK_MEMALLOC and sk_allocation propagation to MPTCP =
subflows
- [High] nbd: lockdep circular dependency and reclaim deadlock with MPTCP s=
ockets
--

commit dbca698e3d4256ddeebe565fd33ea333c059d349
Author: Geliang Tang <geliang@kernel.org>

nbd: allow MPTCP sockets

This commit allows MPTCP sockets to be used with NBD devices by checking
msk_is_mptcp(sock->sk) in nbd_get_socket().

> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index ffce519bf0087..2aeb22b1ad40e 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c

[ ... ]

> @@ -1221,8 +1222,9 @@ static struct socket *nbd_get_socket(struct nbd_dev=
ice *nbd, unsigned long fd,
>  		return NULL;
> =20
>  	if (!sk_is_tcp(sock->sk) &&
> +	    !msk_is_mptcp(sock->sk) &&
>  	    !sk_is_stream_unix(sock->sk)) {

[Severity: High]
When an MPTCP socket is attached to NBD, does SOCK_MEMALLOC and
sk_allocation get propagated to the underlying TCP subflow sockets (ssk)?

In drivers/block/nbd.c, nbd_start_device() and
nbd_genl_reconnect_sock_cb() call sk_set_memalloc(sock->sk), and
__sock_xmit() configures sock->sk->sk_allocation:

drivers/block/nbd.c:__sock_xmit()
    sock->sk->sk_allocation =3D GFP_NOIO | __GFP_MEMALLOC;
    sock->sk->sk_use_task_frag =3D false;

For an MPTCP socket, sock->sk is the master struct mptcp_sock (msk), while
actual wire segments are sent and received on the underlying TCP subflow
sockets (ssk). Calling sk_set_memalloc() on msk enables the global
memalloc_socks_key static key, but neither NBD nor MPTCP (such as
sync_socket_options() in net/mptcp/sockopt.c or
mptcp_subflow_create_socket() in net/mptcp/subflow.c) propagates
SOCK_MEMALLOC or sk_allocation to existing or newly created subflows.

Under memory pressure (for example, swap or writeback over NBD), incoming
packets allocated from emergency reserves have skb_pfmemalloc(skb) set.
When tcp_v4_rcv() or tcp_v6_rcv() looks up the subflow socket ssk, both
sk_filter_trim_cap() in net/core/filter.c:

    if (skb_pfmemalloc(skb) && !sock_flag(sk, SOCK_MEMALLOC)) {
        NET_INC_STATS(sock_net(sk), LINUX_MIB_PFMEMALLOCDROP);
        return SKB_DROP_REASON_PFMEMALLOC;
    }

and sk_add_backlog() in include/net/sock.h:

    if (skb_pfmemalloc(skb) && !sock_flag(sk, SOCK_MEMALLOC))
        return -ENOMEM;

check ssk rather than msk, dropping all incoming pfmemalloc packets. In
addition, subflow TX allocations in __tcp_push_pending_frames() and
__tcp_send_ack() use ssk->sk_allocation (which remains GFP_KERNEL without
__GFP_MEMALLOC). Won't this stall NBD I/O completion and cause a memory
reclaim deadlock under memory pressure?

[Severity: High]
Could attaching an MPTCP socket to NBD also trigger a lockdep circular
locking dependency splat and a reclaim deadlock via subflow socket locks
and mptcp_worker()?

When nbd_add_socket() attaches a socket, nbd_reclassify_socket() in
drivers/block/nbd.c only reclassifies the top-level sock->sk (msk) to
sk_lock-AF_INET-NBD or sk_lock-AF_INET6-NBD. The underlying TCP subflow
sockets created in mptcp_subflow_create_socket() via sock_create_kern()
retain the generic k-sk_lock-AF_INET or k-sk_lock-AF_INET6 lock class,
under which GFP_KERNEL allocations are performed:

net/mptcp/subflow.c:mptcp_subflow_create_socket()
    err =3D sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
    if (err)
        return err;

    lock_sock_nested(sf->sk, SINGLE_DEPTH_NESTING);
    ...
    sk_net_refcnt_upgrade(sf->sk);
    err =3D tcp_set_ulp(sf->sk, "mptcp");

This establishes k-sk_lock-AF_INET -> fs_reclaim. Meanwhile, on the NBD I/O
dispatch path, nbd_queue_rq() -> nbd_handle_cmd() -> nbd_send_cmd() ->
sock_xmit() -> __sock_xmit() -> sock_sendmsg() -> mptcp_sendmsg() ->
__mptcp_push_pending() runs under set->srcu (which is chained after
fs_reclaim -> &q->q_usage_counter(io)) and acquires lock_sock(ssk) in
net/mptcp/protocol.c:

net/mptcp/protocol.c:__mptcp_push_pending()
    lock_sock(ssk);

completing a circular dependency chain between k-sk_lock-AF_INET and
fs_reclaim.

Furthermore, mptcp_worker() in net/mptcp/protocol.c runs in workqueue
context without GFP_NOIO / PF_MEMALLOC, acquires lock_sock(sk) on msk
(sk_lock-AF_INET-NBD), and calls mptcp_pm_worker() and
__mptcp_close_subflow(), which perform GFP_KERNEL allocations while holding
msk->sk_lock. Can this cause a lockdep splat and deadlocks if
mptcp_worker() enters direct reclaim waiting on NBD writeback while
nbd_queue_rq() or recv_work() waits for lock_sock(msk)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792746800.gi=
t.tanggeliang@kylinos.cn?part=3D1
