Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144790;
	b=vXoxrhbYq4Twd93NYtfFaHiShKYaB1VstsIN3semnXTepoipyq/pwJvgE493eBY98aX7
	 eLeUEdxVrKe6dn6Os6/URIaOKTymsKyC2K4GXP3pWG/ajje/71P6GKsOqvvgGj/dePJ/9
	 nRGqDkVmauY9nO0omEK52cosFSFC5koR9LaRCthQ4UGYZgOYGCyKCkREzCTpganpt85qL
	 x4fmSKAp2Yw/W+FHd703p4XyLYVlmS2Eyg0NCWkmDZzs2UEKgLuEortGWk8FN9Rv9S1SV
	 H6kYRpu/3Dtailx/GfCXMWYB1nTH4vIGPv5wcMFzPtLm0wfJQ/mTYXQDczVad8G6Pbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144790;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=yIsCfl6Nr+KMSmXdz72EfiH+jcKs1Lg82bNkEaEHMpw=;
	b=HRM13fH/Vj0WneatbZ9ctRt6T6wBmxT5ao/SulqaAC0UXoeD8ctDvjPXHwBH5PRpZAEc
	 4rn8KVZ/mwWF8ikvQpQesJ2kkrC03I9fwQq2WQG3+NkrfYSwdb4zZV/IZ9MNWUVibR0+q
	 qk/g+agnWZtw1VQBc2QgcJjeEW18J30yrak57Q+5ZLdOwBl3LZWotRDkPV4LHW/kq9wi/
	 /oEQ0LRych4gqYR0pPJgqmPfa2agVlzTYOavIPE8JZWckOs6ajUhND6YK0cKpBJ+oQfYt
	 SrDQ7KF+gI7E6lZkZSpSDUIixwbePq4s9HbBdHhJN+JJzbNDrvgznT3zlhQFxCSR6HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlCEFMYt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6722606A324
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 23:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlCEFMYt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB1A1F01829;
	Tue, 27 Oct 2026 23:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793144789;
	bh=yIsCfl6Nr+KMSmXdz72EfiH+jcKs1Lg82bNkEaEHMpw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YlCEFMYtj9GVvl1eBpEjlQCsME6PM1JotZzYB4PCMZUsSzmo2VZdMle3C3QcIRfvw
	 Uo0POgNrtanvQkII+qj2PaRP8OutH9TzlGw4RUncoCn8ZwDRrNy9Juz854f24UZS8f
	 nHDYCBf8XlyImMLj98PMnFBQq0SnaupERUwtJUscaBJ9ezjSCE/pGuXjqj7uyEws2/
	 +2XmHSYLGR6sP2oP93uPOlmVtipDUA6eW059H+kZz7F1+2whM720TxD3QWiSSDPqpG
	 qJoAavi9k6IdxfuPXLMGuWkIeNgcT8f4E/noL9M/qft6oOQcd53f8xfZI0f2dfDjEF
	 wdfwsxGGlNbvg==
Subject: Re: [PATCH mptcp-next v2 3/4] nbd: allow MPTCP sockets
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Tue, 27 Oct 2026 23:46:29 +0000
Message-ID: <179314478900.3132.11012834474298776948@kernel.org>
In-Reply-To: =?utf-8?q?=3Ced971f839d9482713fca427b4b3dad3935a593c4=2E1793010?=
 =?utf-8?q?744=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3Ced971f839d9482713fca427b4b3dad3935a593c4=2E17930107?=
 =?utf-8?q?44=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] __sock_xmit() (drivers/block/nbd.c:583) calls
  sk_set_memalloc(sock->sk) inside the do/while loop, so it runs once…
- [High] Once NBD accepts an MPTCP msk, an in-kernel agent can hold the
  NBD data socket's lock while doing allocations that may reclaim.
- [Medium] With this patch an MPTCP msk can be attached to NBD.
- [Medium] nbd_reclassify_socket() (drivers/block/nbd.c:1248-1276)
  switches on sk_family and moves only the top-level socket lock into…
- [Low] The commit author is 'Geliang Tang <geliang@kernel.org>', but the
  only Signed-off-by is 'Geliang Tang <tanggeliang@kylinos.cn>'.

--

nbd: allow MPTCP sockets

This commit makes nbd_get_socket() accept MPTCP sockets as well as TCP
and stream UNIX sockets, by adding an msk_is_mptcp() check. The goal is
to get MPTCP bandwidth aggregation across several NICs for NBD traffic.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author address (geliang@kernel.org) doesn't
match the Signed-off-by address (tanggeliang@kylinos.cn). checkpatch
reports this as FROM_SIGN_OFF_MISMATCH.

Could a matching Signed-off-by or From: line be added? The other patches
in the series seem to have the same mismatch.

> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index c5e26fc98d1aa..9cf89d53839a1 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c

[ ... ]

> @@ -1222,8 +1223,9 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
>  		return NULL;
>  
>  	if (!sk_is_tcp(sock->sk) &&
> +	    !msk_is_mptcp(sock->sk) &&

[Severity: High]
Now that MPTCP sockets are accepted here, does the sk_set_memalloc() call
that runs on every loop iteration in __sock_xmit() cause problems on the
I/O path?

drivers/block/nbd.c:__sock_xmit() {
    ...
		do {
			sock->sk->sk_allocation = GFP_NOIO | __GFP_MEMALLOC;
			sock->sk->sk_use_task_frag = false;
			sk_set_memalloc(sock->sk);
			msg.msg_flags = msg_flags | MSG_NOSIGNAL;
    ...
}

That call came from the earlier "sock: add set_memalloc protocol
callback" commit in this series. sk_set_memalloc() increments the global
static key every time, even when SOCK_MEMALLOC is already set:

net/core/sock.c:sk_set_memalloc() {
	sock_set_flag(sk, SOCK_MEMALLOC);
	sk->sk_allocation |= __GFP_MEMALLOC;
	static_branch_inc(&memalloc_socks_key);
	...
}

NBD never calls sk_clear_memalloc(). So memalloc_socks_key goes up once
per send/recv fragment and never comes down. Each increment takes
cpus_read_lock() through static_key_slow_inc().

When the count reaches INT_MAX, static_key_slow_inc_cpuslocked() hits
WARN_ON_ONCE(). After that, every call takes jump_label_mutex.

For MPTCP, each iteration also calls mptcp_set_memalloc(). That takes
lock_sock() on the msk and lock_sock_nested() on every subflow before the
actual sendmsg/recvmsg:

net/mptcp/protocol.c:mptcp_set_memalloc() {
	...
	lock_sock(sk);
	memalloc = sock_flag(sk, SOCK_MEMALLOC);
	mptcp_for_each_subflow(msk, subflow) {
		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);

		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
	...
}

Should this setup happen once at attach time, as nbd_start_device() and
nbd_reconnect_socket() already do it, and be undone at teardown?

[Severity: Medium]
Do MPTCP subflows created after the socket is attached get the
reclaim-safe settings?

mptcp_set_memalloc() copies SOCK_MEMALLOC, sk_allocation and
sk_use_task_frag only to the subflows that are on msk->conn_list when it
runs. Subflows still on join_list are skipped.

The PM worker creates new subflows through:

mptcp_worker()->mptcp_pm_worker()->__mptcp_subflow_connect()->
    mptcp_subflow_create_socket()->sock_create_kern()

These start with GFP_KERNEL, SOCK_MEMALLOC clear and sk_use_task_frag
set. mptcp_sockopt_sync_locked() doesn't copy these fields, and nothing
else in net/mptcp/ appears to write them.

Until some later __sock_xmit() iteration resyncs them, can
sk_filter_trim_cap() drop pfmemalloc skbs that arrive on such a subflow?
Can the subflow's allocations also enter reclaim in a swap-over-NBD
setup?

And if the sk_set_memalloc() call is moved to attach time, would late
subflows ever be covered?

[Severity: High]
Can this add a reclaim deadlock that plain TCP NBD sockets don't have?

mptcp_worker() holds the msk socket lock while the PM creates subflows:

net/mptcp/protocol.c:mptcp_worker() {
	...
	lock_sock(sk);
	...
	mptcp_pm_worker(msk);
	...
}

mptcp_pm_worker() reaches __mptcp_subflow_connect(). That calls
mptcp_subflow_create_socket()->sock_create_kern(), which does a
GFP_KERNEL sk_alloc. It then calls kernel_connect(), where tcp_connect()
allocates with the subflow's default GFP_KERNEL sk_allocation. The
userspace PM does the same under lock_sock(). None of this runs under
memalloc_noio_save().

Suppose one of those allocations enters direct reclaim and waits on
writeback or swap-out to the NBD device. The NBD I/O that reclaim is
waiting for also needs the msk lock:

__sock_xmit()->sk_set_memalloc()->mptcp_set_memalloc()->lock_sock(msk)
__sock_xmit()->sock_sendmsg()->mptcp_sendmsg()->lock_sock(msk)
__sock_xmit()->sock_recvmsg()->mptcp_recvmsg()->lock_sock(msk)

The timeout path doesn't seem to break the cycle either:
nbd_xmit_timeout()->sock_shutdown()->kernel_sock_shutdown()->
mptcp_shutdown() also takes lock_sock(msk).

The NBD peer can trigger subflow creation remotely, for example with an
ADD_ADDR. That is the multi-subflow setup the commit message describes.

Does anything prevent this cycle: reclaim waits on NBD, NBD waits on the
msk lock, and the msk lock holder waits on reclaim?

[Severity: Medium]
Could this bring back the lockdep circular dependency that commit
d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular
dependency") removed?

nbd_reclassify_socket() reclassifies only the top-level sock. For MPTCP,
that means only the msk lock moves to the sk_lock-AF_INET(6)-NBD class:

drivers/block/nbd.c:nbd_reclassify_socket() {
	...
	switch (sk->sk_family) {
	case AF_INET:
		sock_lock_init_class_and_name(sk, "slock-AF_INET-NBD",
	...
}

The subflows come from sock_create_kern(). They stay in the shared
k-sk_lock-AF_INET(6) class that every kernel TCP socket uses.

NBD I/O takes those subflow locks while holding the NBD-classed msk lock.
Examples are lock_sock(ssk) in __mptcp_push_pending() and
lock_sock_nested(ssk) in mptcp_set_memalloc().

Lockdep already records fs_reclaim -> sk_lock-AF_INET-NBD, so this adds
fs_reclaim -> k-sk_lock-AF_INET.

Any kernel TCP socket in that class that allocates with GFP_KERNEL under
lock_sock() records the reverse edge. One example is
__mptcp_subflow_connect()->kernel_connect()->tcp_connect() on a join
subflow.

Do the subflow locks need to be reclassified too?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793010744.git.tanggeliang%40kylinos.cn
