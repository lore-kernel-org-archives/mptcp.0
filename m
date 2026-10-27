Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144789;
	b=ZyeDuCln/jtaIVBvCqYVtv01fGgeRwtmu+z3TKqompUCcj7n6l4w4kaHdBWkQ7a0MCIK
	 qYlnuekf52nUXMqFDF6V6BzoJmJhI2GaTs0bfg8qUljEN64bk++n5121mNexWzgf/XtGY
	 fVSCvGdQKxOUFMcvzD+l8F5TqMUyPUyBZu7m4SxMZ3Os4f8JJWaTiBxZGJdJaTU3UjkTw
	 nrJAyCDWW6+yIabGhSi05lObjzNDXAtx1+1sGvSZzp0DfCYkrgaia9VyourcgWGzKfVou
	 z96kFoBn+GBSX0DIpR0XhGN0n+Dej1nAjMw0uegIiNHwjPXSoH9V1gPz8F1xqvZTIEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144789;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zNftzB1UBZhb8xpoko8z+Wi3jOZr4DinqeKu7PgOwQY=;
	b=A8MBIw2swSXgWR/+4rqzAASrBD+ogxTOUf3wJgCDsWahy505WZmmzk/SvCVh9gzl5r9b
	 VaHo1fsdXyczdy77TO2R5uPkimTAkU3LgJHP5ybOXx6cYCDU0IHgblyLShkaR6pGE6Io3
	 u8BtDbSxQAnmgw708XqaWwoWcVQVpYir487hTYWRv9/BUgJSXuq2NppK0L7fa4zFi7/rN
	 gTQHxiBAJKVz8JOWzvaPDcst9SpdrK6NS84WksFUf3hpL5DU4wYOQZEVT/LjiTF6nkhhZ
	 6K/ER1QuUaK1HO9iOGIu8epXno5H4sV8hdqEtTXFKo/w/fiHSSbK9+Gd8zpfmxrE2zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VpAaEq+B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2405E606A31A
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 23:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VpAaEq+B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5761F01828;
	Tue, 27 Oct 2026 23:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793144788;
	bh=zNftzB1UBZhb8xpoko8z+Wi3jOZr4DinqeKu7PgOwQY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VpAaEq+BIPMR57Gn5RvFYFwA+TWBYOhEVX15x80DeY0SD+P9vuum9pKgh1kEaoS5v
	 Ri9k4ie2Z52WzVbCI57WB6hZIh/lorQUw0oMwuXf1WWYggP49UObiGtlLeTVRpkEy0
	 4s+4Q8uzIGzQ/BYtkuP+CVVQavSNV5aenwQe3cFA6OixicbmJ5xNVNNdRGnx5IpmRC
	 Z725PRw4bxwFyG6o7ZOpzgUkplQmO5cxfWcFLJEfwMOt9XKbPJs2P+fdJ2BZcdYLTy
	 Ah7oLk7TDkyjB2+178Tu0NXm0O6AfSIfR/H8l85sdZ6hG4m1Z+S7UMG+3P7beiuHEu
	 taR6gDBknY8xA==
Subject:
 Re: [PATCH mptcp-next v2 2/4] sock: add set_memalloc protocol callback
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Tue, 27 Oct 2026 23:46:28 +0000
Message-ID: <179314478821.3132.6933487680636505359@kernel.org>
In-Reply-To: =?utf-8?q?=3C2394cada9a75d45edb8773c3d24e699e9211e98c=2E1793010?=
 =?utf-8?q?744=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C2394cada9a75d45edb8773c3d24e699e9211e98c=2E17930107?=
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Unbounded static-key refcount leak in the NBD I/O hot path.
- [High] mptcp_set_memalloc() (net/mptcp/protocol.c:4330-4348) walks
  msk->conn_list once while holding the msk lock and copies…
- [High] cpu_hotplug_lock is now taken on the NBD block/swap I/O path.
- [Medium] Data race / lost update on sk->sk_flags.

--

sock: add set_memalloc protocol callback

This adds a set_memalloc() callback to struct proto, called from
sk_set_memalloc() and sk_clear_memalloc(). MPTCP implements it to copy
SOCK_MEMALLOC, sk_allocation and sk_use_task_frag to its subflows, and NBD
now calls sk_set_memalloc() from __sock_xmit().

> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index ffce519bf0087..c5e26fc98d1aa 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -579,6 +579,7 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
>  		do {
>  			sock->sk->sk_allocation = GFP_NOIO | __GFP_MEMALLOC;
>  			sock->sk->sk_use_task_frag = false;
> +			sk_set_memalloc(sock->sk);

[Severity: High]
Does this leak references on memalloc_socks_key?

sk_set_memalloc() calls static_branch_inc() every time, even when
SOCK_MEMALLOC is already set:

net/core/sock.c:sk_set_memalloc() {
	sock_set_flag(sk, SOCK_MEMALLOC);
	sk->sk_allocation |= __GFP_MEMALLOC;
	static_branch_inc(&memalloc_socks_key);
	...
}

This call sits inside the do/while loop of __sock_xmit(). It runs for the
request header send, for the reply header receive, once per bvec segment
in nbd_handle_reply()->sock_xmit(), and once per partial send/recv loop
iteration.

nbd.c never calls sk_clear_memalloc(), so the count only goes up. This
hits every NBD socket, including plain TCP and UNIX, not only MPTCP.

When the count reaches INT_MAX, static_key_fast_inc_not_disabled() fails.
static_key_slow_inc_cpuslocked() then takes jump_label_mutex and reaches:

	if (WARN_ON_ONCE(!static_key_fast_inc_not_disabled(key)))
		return false;

>From then on, every NBD transfer serializes on jump_label_mutex. With
panic_on_warn set, the machine panics. sk_memalloc_socks() also stays true
system wide for good.

nbd_start_device() and nbd_reconnect_socket() already call
sk_set_memalloc() once per socket. Is the per-transfer call needed?

[Severity: High]
Can this deadlock against CPU hotplug? static_branch_inc() goes through
static_key_slow_inc(), which takes cpu_hotplug_lock for read before it
tries the fast path:

kernel/jump_label.c:static_key_slow_inc() {
	cpus_read_lock();
	ret = static_key_slow_inc_cpuslocked(key);
	cpus_read_unlock();
	...
}

Before this patch, the NBD I/O path never took cpu_hotplug_lock.

The first case is offlining a CPU while a multi-connection NBD device has
I/O in flight. _cpu_down() holds cpus_write_lock while
blk_mq_hctx_notify_offline() waits for the hctx to drain:

	while (blk_mq_hctx_has_requests(hctx)) {
		...
		msleep(5);
	}

Those requests only complete after recv_work reads the reply through
nbd_handle_reply()->sock_xmit()->__sock_xmit(). That path now blocks in
cpus_read_lock() behind the writer.

With num_connections > 1, nbd_xmit_timeout() only requeues the request
through nbd_requeue_cmd(), so the tag stays allocated. With timeout=0 it
only resets the timer. Does the hotplug operation ever finish here?

The second case is reclaim. The hotplug control task holds cpus_write_lock
while it runs callbacks that allocate with GFP_KERNEL. If that allocation
enters direct reclaim and swaps to NBD, the swap I/O can be issued inline
in the same task:

nbd_queue_rq()->__sock_xmit()->sk_set_memalloc()->cpus_read_lock()

Would that self-deadlock on the percpu rwsem?

[Severity: Medium]
Is it safe to write sk->sk_flags here without the socket lock?
sock_set_flag() is a non-atomic __set_bit():

include/net/sock.h:sock_set_flag() {
	__set_bit(flag, &sk->sk_flags);
}

__sock_xmit() is called from the send path, which holds only
nsock->tx_lock, and from recv_work, which holds no lock at all.

TCP softirq processing writes the same word when the socket is not owned
by user. For example, tcp_fin() calls sock_set_flag(sk, SOCK_DONE), and
SOCK_QUEUE_SHRUNK is updated through sk_wmem_free_skb() and
tcp_check_space().

A softirq update that lands between the load and the store of __set_bit()
is overwritten with the stale word, even though SOCK_MEMALLOC was already
set. Could a lost SOCK_QUEUE_SHRUNK suppress a write-space wakeup, or
could SOCK_DONE be lost?

Before this patch, the hot path only did plain stores to sk_allocation and
sk_use_task_frag. sk_flags was only written at attach time.

>  			msg.msg_flags = msg_flags | MSG_NOSIGNAL;
>  
>  			if (send)

[ ... ]

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d4f42dfc227e2..5eccff04151d7 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4327,6 +4327,26 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
>  	return 0;
>  }
>  
> +static void mptcp_set_memalloc(struct sock *sk)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> +	bool memalloc;
> +
> +	lock_sock(sk);
> +	memalloc = sock_flag(sk, SOCK_MEMALLOC);
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
> +		sock_valbool_flag(ssk, SOCK_MEMALLOC, memalloc);
> +		ssk->sk_allocation = sk->sk_allocation;
> +		ssk->sk_use_task_frag = sk->sk_use_task_frag;
> +		release_sock(ssk);
> +	}
> +	release_sock(sk);
> +}

[Severity: High]
What happens to subflows that are created or joined after this runs? The
loop only updates the subflows on msk->conn_list at the time of the call.

New subflows come from mptcp_subflow_create_socket()->sock_create_kern().
They start with GFP_KERNEL, no SOCK_MEMALLOC, and sk_use_task_frag set to
true.

Their only sync step is mptcp_sockopt_sync_locked()->sync_socket_options().
That doesn't copy SOCK_MEMALLOC, sk_allocation or sk_use_task_frag. It
also only runs when setsockopt_seq changes, and sk_set_memalloc() never
bumps it:

	if (READ_ONCE(subflow->setsockopt_seq) != msk->setsockopt_seq) {
		sync_socket_options(msk, ssk);
		...
	}

This affects three kinds of subflow:

- MP_JOIN subflows the path manager adds later
- passive joins that wait on join_list while this callback owns the msk
  (they are only spliced in by the final release_sock(sk))
- the lazily created first subflow

Under memory pressure, sk_filter_trim_cap() drops pfmemalloc skbs on such
a subflow:

	if (skb_pfmemalloc(skb) && !sock_flag(sk, SOCK_MEMALLOC))

Its allocations can also recurse into reclaim. With NBD over MPTCP (which
the later "nbd: allow MPTCP sockets" patch in the series enables), doesn't
this leave the swap forward-progress problem from the commit message
unsolved for these subflows?

The per-transfer sk_set_memalloc() call in __sock_xmit() only narrows the
window, since a recv_work thread blocked in sock_recvmsg() won't re-sync.

Would it work better to inherit these settings when a subflow is created
or joins, for example in sync_socket_options() or __mptcp_finish_join(),
rather than only notifying existing subflows?

>  static struct proto mptcp_prot = {
>  	.name		= "MPTCP",
>  	.owner		= THIS_MODULE,

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793010744.git.tanggeliang%40kylinos.cn
