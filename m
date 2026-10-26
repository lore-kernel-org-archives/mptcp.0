Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015212;
	b=02WUEZOi7xzn2+ourG0ddME1NkSYHd4KM0gDUnSl7ZMCrXJomoPI2eQTukK8NmQZdR9X
	 rsyyTlgakmefMcqQBVWeA9d0tXs9uFgSOIC+e3pd5spcqUzbI7pf1Zs4kZajCHtp6bstM
	 iNQ6hxNwzh0oujWpI5yDWJrhbd2hI7Y6/N7bfdwEEih32VvB0vXgLVI4ilXxZADkNiZ1m
	 uQ9H5dY2DxqCarJxs03dvwwn9BIqMy8Y+HOOP/CLe9kvrHH6CkRMsr9woSlbUaOV2maKU
	 3TbWtFz1pyrYVhL+BLQMrE9Zh15Lw+KNmtqVSzcFd2wSha05vNmPvKlHiD43214K+XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015212;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nN7TCn17mlrpkw/ZxWQDOQa03Nu5/+jpyLWOcpT6K7I=;
	b=djyvtiH01H0aWQBYiDhRH3e6rK4fLghgv3udoW6f0EM4Fk308RCP7zqw8tnrroui5aDR
	 m99aX8k9udaswD4RjQnh/IBzCgnCcaOzrHipU0fl9JDiud1puo29eelxXdS5fykBGuVFj
	 FVDMYHLZPatYfK12b0EccuAPbsQQa5QdiVcL/RppeWHz4eq56BdCj+4Og51T67RxfhyDr
	 8TeYPAZMAKu/USxTFcVVuj1dpqlzeQRPlBoWlYc2lpFJsMQYruqLJcUBRv7zkJxbqsdtZ
	 sWt0HGoMftHcf6Fz8preGPvC3SYDGij/BXxNU7Idv3VWUu60l4Q+oL52mXhR/FofGfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ica2zS5c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F18606A324
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ica2zS5c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416891F01829;
	Mon, 26 Oct 2026 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793015211;
	bh=nN7TCn17mlrpkw/ZxWQDOQa03Nu5/+jpyLWOcpT6K7I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Ica2zS5coJmmhu0+X7cDJ63yZbV68KNN0EQFc7rmSwcMjeH6Jdy2KHMCrMLaYXaYK
	 dBlaVxCsHzWtmwnZIVfX8P+6exp1fTzdxIgSEjLU7zBbOi15C+ftoupUIVB3CipFR2
	 lldVbNYDr1pNtcrXKDBVOwLsYp3FWQUeSYkQCpxd5qzhNXRpao8b4Sm29R/soO2ntf
	 sXaI14vtzzOGrWJ8FR3G7PfJmcsSYpPZKXupTTpv3LXwXKaM+fiTnrdtidNCI1U82g
	 2Io6uAR0dY+jrGu7yKb0hDKLnIoFHttI2wKiw/98+y9+gG5DXbkASjpbTw57utTep4
	 VhXWvBjGkWGTg==
Message-ID: <sashiko-outbox-185117@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v2 2/4] sock: add set_memalloc protocol
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <2394cada9a75d45edb8773c3d24e699e9211e98c.1793010744.git.tanggeliang@kylinos.cn>
References: <cover.1793010744.git.tanggeliang@kylinos.cn>
 <2394cada9a75d45edb8773c3d24e699e9211e98c.1793010744.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:46:50 +0000
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
- [High] nbd: per-I/O sk_set_memalloc() in __sock_xmit() leaks static key a=
nd deadlocks
- [High] mptcp: mptcp_set_memalloc() misses subflows created or joined later
--

commit b144942ec73c0d6666c170f8c7917db0e4e17462
Author: Geliang Tang <geliang@kernel.org>

sock: add set_memalloc protocol callback

This patch adds a set_memalloc() callback to struct proto so protocols such=
 as
MPTCP can synchronize SOCK_MEMALLOC, sk_allocation, and sk_use_task_frag to
their subflows when sk_set_memalloc() or sk_clear_memalloc() is called. It
also updates NBD's __sock_xmit() to call sk_set_memalloc() on each transmit=
 or
receive loop iteration.

> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index ffce519bf0087..c5e26fc98d1aa 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -579,6 +579,7 @@ static int __sock_xmit(struct nbd_device *nbd, struct=
 socket *sock, int send,
>  		do {
>  			sock->sk->sk_allocation =3D GFP_NOIO | __GFP_MEMALLOC;
>  			sock->sk->sk_use_task_frag =3D false;
> +			sk_set_memalloc(sock->sk);

[Severity: High]
Should sk_set_memalloc() really be called inside the per-I/O loop in
__sock_xmit()?

NBD already calls sk_set_memalloc() once per socket during setup in
nbd_start_device() and during reconnection in nbd_genl_reconnect_sock_cb():

drivers/block/nbd.c:nbd_start_device() {
	...
	sk_set_memalloc(config->socks[i]->sock->sk);
	if (nbd->tag_set.timeout)
		config->socks[i]->sock->sk->sk_sndtimeo =3D
			nbd->tag_set.timeout;
	...
}

Calling sk_set_memalloc(sock->sk) on every send and receive iteration in
__sock_xmit() invokes static_branch_inc(&memalloc_socks_key) without a
matching sk_clear_memalloc(), which leaks a reference on
memalloc_socks_key.key.enabled on every I/O until the counter saturates at
INT_MAX and triggers WARN_ON_ONCE(!static_key_fast_inc_not_disabled(key)) in
static_key_slow_inc_cpuslocked().

In addition, static_branch_inc() -> static_key_slow_inc() acquires
cpus_read_lock() on every call while __sock_xmit() is running in the block =
I/O
and swap-out path under memalloc_noreclaim_save(). During CPU hot-unplug,
blk_mq_hctx_notify_offline() holds cpus_write_lock() while waiting for
in-flight requests on the queue to complete, which can deadlock if an NBD
request is waiting on cpus_read_lock() in __sock_xmit().

Furthermore, nbd_send_cmd() and recv_work() -> nbd_read_reply() call
__sock_xmit() concurrently on the same socket without holding lock_sock(), =
so
sock_set_flag(sk, SOCK_MEMALLOC) performs an unlocked non-atomic __set_bit()
on sk->sk_flags, and MPTCP sockets will acquire lock_sock(sk) and each subf=
low
lock on every packet.

Would it work to initialize sk_allocation and sk_use_task_frag before the
existing one-time sk_set_memalloc() calls in nbd_start_device() and
nbd_genl_reconnect_sock_cb() instead of calling sk_set_memalloc() in
__sock_xmit()?

[ ... ]

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d4f42dfc227e2..5eccff04151d7 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4327,6 +4327,26 @@ static int mptcp_connect(struct sock *sk, struct s=
ockaddr_unsized *uaddr,
>  	return 0;
>  }
> =20
> +static void mptcp_set_memalloc(struct sock *sk)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> +	bool memalloc;
> +
> +	lock_sock(sk);
> +	memalloc =3D sock_flag(sk, SOCK_MEMALLOC);
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +
> +		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
> +		sock_valbool_flag(ssk, SOCK_MEMALLOC, memalloc);
> +		ssk->sk_allocation =3D sk->sk_allocation;
> +		ssk->sk_use_task_frag =3D sk->sk_use_task_frag;
> +		release_sock(ssk);
> +	}
> +	release_sock(sk);
> +}

[Severity: High]
How are subflows that are created or joined after sk_set_memalloc() is call=
ed
handled?

mptcp_set_memalloc() only iterates over subflows currently in msk->conn_lis=
t.
If a caller invokes sk_set_memalloc() before connect() (where the first
subflow is created lazily via __mptcp_nmpc_sk() -> __mptcp_socket_create() =
->
mptcp_subflow_create_socket()), or when additional MP_JOIN subflows are
created later via __mptcp_subflow_connect() -> mptcp_subflow_create_socket()
or joined via mptcp_finish_join() -> __mptcp_finish_join() (including subfl=
ows
queued on msk->join_list while sk is locked), those subflows only run
mptcp_sockopt_sync_locked() -> sync_socket_options():

net/mptcp/sockopt.c:mptcp_sockopt_sync_locked() {
	...
	if (READ_ONCE(subflow->setsockopt_seq) !=3D msk->setsockopt_seq) {
		sync_socket_options(msk, ssk);

		subflow->setsockopt_seq =3D msk->setsockopt_seq;
	}
}

Because neither mptcp_sockopt_sync_locked() nor sync_socket_options()
propagates SOCK_MEMALLOC, sk_allocation, or sk_use_task_frag, any subflow
created or joined after sk_set_memalloc() will miss those settings and can
drop incoming pfmemalloc packets or allocate without __GFP_MEMALLOC under
memory pressure.

Also, when sk_clear_memalloc() clears SOCK_MEMALLOC, should
mptcp_set_memalloc() call sk_mem_reclaim(ssk) on each subflow socket just as
sk_clear_memalloc() does on sk?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793010744.gi=
t.tanggeliang@kylinos.cn?part=3D2
