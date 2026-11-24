Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795563043;
	b=WNI068/CGp+oAWqcdFLdF+OACZJovRQHz98iFBLEGUeAA4h9J4ZMn+kl8KJmeBm3kIY3
	 65oErzfuKojtTsjmzjd9BS6ARbQRDr2esIRtLIjACNd6iD2CyKRwtZ5IlRU7RQF3R5USi
	 mA1ECy+Jt20OjdPVI37IN9jyJHintZnVnfsIbfh0gRZIuivFvY2Nk1WJMkmC4+5I+E5RO
	 80aBhsn3f7TviylqkRukXI5kuImK0FWhb2lYgUi+W8E5ilzszRFZBdGuEQXrobOJYveG1
	 WhgRdwRGhqbFQzo7IuucXncxEHM2Dmc2cL74/Ief18yKly8PTh5T6QEUf4Nmj7+zyhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795563043;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=qaue+IXHWY1nZGak3Y74QwLfFQRmoAcTdyibsPwS/IE=;
	b=kRB3bXUEXGnDQvxY2nGy5yk3/e4i6iRrqiHIEcBw+FBGTUA460tPqCy3Jd9x1wYZFY92
	 5VAUdN5Fu+m8DDRnCYgr0JdANsufeQZZIQPDUN2TSIBD6C0ZdMxSQyNdt4kLHpXNtgptf
	 wi4UmX6YRCpfugV12akn9xNh/9885S9kzF05xdKieg/sf07v90po5YZo/87nX6SurILTf
	 /M0hH96377adowYiXdTYwYXH7zO7PnvQSwj7u/WxqhYASOh6b5vJDr6SUb7Ne45BFDq3I
	 +s5D8+M4v/Qds/5zdim8tT49hIQxtRdz+k7pbJ6NN+WzSpY8xeTuly77baTm0ivC7jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyKIDz+j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E61606A33C
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 23:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyKIDz+j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FD81F000D1;
	Tue, 24 Nov 2026 23:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795563043;
	bh=qaue+IXHWY1nZGak3Y74QwLfFQRmoAcTdyibsPwS/IE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gyKIDz+jSgb/L/fpigbehvg8tc2ZHcWiLCcXNWnt7koBqi7KemZnUU3V7Eg8NZd/L
	 ikyWa0EyVCpO3EHqF6wUc18Qz8NxmbRWayMG+vRCLSo1wgGoLgJrKzPFofSO6KmGfK
	 Tdv2HKwmBY3FeaKUmIn+/Es7qEvI/g2p/BtcFSlR67do30Ydtjttzp6lCm5kQwyXy/
	 8Jr2+Ll7KpVZbEUCziQWTsD0VJEkjaWVK6QlDpgSg+sC4ca6ZwSG28WifkMapmynei
	 3mtJ7zqZDZoAkU3cFMZmvrI0lP0OITWMQxXmcTiEJ2bzYUeC7QP7Zu9EbDDzHQ2R45
	 N865Rce5QVaJw==
Subject: Re: [PATCH mptcp-next v8 5/7] mptcp: handle SO_ZEROCOPY in setsockopt
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 24 Nov 2026 23:30:42 +0000
Message-ID: <179556304261.3133.6680231180875461080@kernel.org>
In-Reply-To: <154898fde8a9acdf6562d2adda67ebfe3ddd7246.1795421388.git.tanggeliang@kylinos.cn>
References: <154898fde8a9acdf6562d2adda67ebfe3ddd7246.1795421388.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] mptcp_poll() in net/mptcp/protocol.c only sets EPOLLERR from
  READ_ONCE(sk->sk_err) (line 4696).
- [High] This patch lets unprivileged users turn on SOCK_ZEROCOPY on the
  msk, which exposes a gap in pinned-page accounting in…
- [High] On kernels with PAGE_SIZE >= 65536 (for example arm64 or ppc64le
  built with 64K pages), mptcp_sendmsg_zerocopy_iter()…
- [Medium] Now that SO_ZEROCOPY can be set on MPTCP, mptcp_sendmsg()
  (net/mptcp/protocol.c:2118-2119) clears MSG_ZEROCOPY whenever…
- [Medium] mptcp: SO_ZEROCOPY lost on passive TCP fallback in
  mptcp_stream_accept()
- [Low] The comment in mptcp_recvmsg() (net/mptcp/protocol.c:2530), '/*
  MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */', is now…
- [Low] Documentation/networking/msg_zerocopy.rst says 'The feature is
  currently implemented for TCP, UDP and VSOCK (with virtio transport)…

--

mptcp: handle SO_ZEROCOPY in setsockopt

This patch lets SO_ZEROCOPY be set on MPTCP sockets through the
SOL_SOCKET setsockopt dispatcher. The new helper,
mptcp_setsockopt_sol_socket_zerocopy(), accepts 0 or 1 and toggles
SOCK_ZEROCOPY on the msk. mptcp_sendmsg() then checks that flag to
enable the MSG_ZEROCOPY path.

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index fcf6feb2a9eb5..abcc7d4452b41 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -175,6 +175,19 @@ static int mptcp_setsockopt_sol_socket_tstamp(struct mptcp_sock *msk, int optnam
>  	return 0;
>  }
>  
> +static int mptcp_setsockopt_sol_socket_zerocopy(struct mptcp_sock *msk, int val)
> +{
> +	struct sock *sk = (struct sock *)msk;
> +
> +	if (val != 0 && val != 1)
> +		return -EINVAL;
> +
> +	lock_sock(sk);
> +	sock_valbool_flag(sk, SOCK_ZEROCOPY, val);

[Severity: Medium]
Does SOCK_ZEROCOPY survive a passive fallback to plain TCP?

This sets the flag only on the msk. It doesn't bump
msk->setsockopt_seq the way mptcp_sol_socket_sync_intval() does.
sync_socket_options() copies SOCK_KEEPOPEN, SOCK_LINGER and SOCK_DBG
to the subflows, but not SOCK_ZEROCOPY. So the listening subflow
msk->first never gets the flag, whether SO_ZEROCOPY is set before or
after listen().

Now suppose a non-MP_CAPABLE client connects to such a listener.
subflow_syn_recv_sock() creates the child through
listener->icsk_af_ops->syn_recv_sock(). That clones it from the
listening TCP subflow, so the child inherits the ssk's sk_flags rather
than the msk's. The fallback path then calls mptcp_subflow_drop_ctx()
on the child and returns it without ever calling
mptcp_sk_clone_init().

mptcp_stream_accept() then takes the tcpfallback branch.
__inet_accept() grafts the plain TCP child onto newsock, and the ops
are switched to mptcp_fallback_tcp_ops(). From that point sendmsg()
goes to tcp_sendmsg_locked() and getsockopt() goes to sk_getsockopt(),
both on the TCP child, where SOCK_ZEROCOPY is clear.

TCP zerocopy servers commonly set SO_ZEROCOPY on the listener and rely
on accepted sockets inheriting it. With this patch,
getsockopt(SO_ZEROCOPY) on the accepted socket returns 0. A
sendmsg(MSG_ZEROCOPY) is silently copied and no SO_EE_ORIGIN_ZEROCOPY
notification is queued. An application waiting on MSG_ERRQUEUE for
one completion per send could stall.

This also conflicts with the commit message's claim that setting the
flag on the msk alone is honoured on every data path without any
cross-socket propagation.

Should SOCK_ZEROCOPY be propagated to the subflows in
sync_socket_options(), as SOCK_DBG is, with a setsockopt_seq bump
here? Or would you rather copy it from the msk in the fallback accept
path?

[Severity: High]
Will poll() ever report the zerocopy completions that this enables?

mptcp_sendmsg() calls msg_zerocopy_realloc() on the msk. The
SO_EE_ORIGIN_ZEROCOPY notifications therefore go on msk->sk_error_queue,
and sk_err stays 0. mptcp_poll() in net/mptcp/protocol.c only checks
sk_err:

net/mptcp/protocol.c:mptcp_poll() {
    ...
	if (READ_ONCE(sk->sk_err))
		mask |= EPOLLERR;
    ...
}

tcp_poll() checks the error queue as well:

net/ipv4/tcp.c:tcp_poll() {
    ...
	if (READ_ONCE(sk->sk_err) ||
	    !skb_queue_empty_lockless(&sk->sk_error_queue))
		mask |= EPOLLERR;
    ...
}

Documentation/networking/msg_zerocopy.rst says poll "will set POLLERR in
its output flags" while a notification is outstanding. Its example uses
poll(&pfd, 1, -1).

When __msg_zerocopy_callback() calls sk_error_report(), the waiter wakes
up and runs mptcp_poll() again. It gets no EPOLLERR and goes back to
sleep. Level-triggered epoll misses the event in the same way.

Wouldn't an application that follows the documented pattern on an MPTCP
socket block forever, with the uncollected notifications still holding
optmem?

The selftest added later in the series ("selftests: mptcp: connect: add
zerocopy io mode") doesn't catch this. wait_for_completions_zc() calls
recvmsg(MSG_ERRQUEUE) itself and limits each poll() to 200 ms. No later
patch in the series changes mptcp_poll().

[Severity: High]
With this opt-in in place, can userspace hit the WARN_ON_ONCE() in
mptcp_sendmsg_zerocopy_iter() on kernels built with 64K pages?

net/mptcp/protocol.c:mptcp_sendmsg_zerocopy_iter() {
    ...
	if (pg_len > U16_MAX) {
		iov_iter_revert(&msg->msg_iter, pg_len - U16_MAX);
		pg_len = U16_MAX;
	}

	if (pg_off > U16_MAX) {
		...
	}

	if (pg_off + pg_len > U16_MAX) {
		size_t len = U16_MAX - pg_off;

		iov_iter_revert(&msg->msg_iter, pg_len - len);
		pg_len = len;
		if (WARN_ON_ONCE(!pg_len)) {
			put_page(pages[0]);
			return -EFAULT;
		}
	}
    ...
}

With PAGE_SIZE == 65536, take a sendmsg(MSG_ZEROCOPY) of 64KB or more
from a page-aligned buffer. The first call gets pg_off == 0 and
pg_len == 65536, and reverting one byte clamps pg_len to 65535.

The next iteration gets the last byte of the same page, with
pg_off == 65535 and pg_len == 1. The pg_off > U16_MAX check doesn't
catch pg_off == U16_MAX, so len becomes 0 and the WARN fires. Sending a
single byte from buf + 65535 triggers it directly.

The function then returns -EFAULT. mptcp_sendmsg() either returns a
short write or aborts the ubuf and falls back to copying. On 64K-page
systems zerocopy would keep falling back to copying. With panic_on_warn
set, the first such send would panic the kernel.

This code was added by the previous patch, but it only becomes reachable
now that SOCK_ZEROCOPY can be set on the msk.

[Severity: High]
Does this opt-in let an unprivileged user pin far more user pages than
the send buffer should allow?

Each mptcp_sendmsg_zerocopy_iter() call pins one full user page. It
charges the msk only for the bytes used plus the dfrag header:

net/mptcp/protocol.c:mptcp_sendmsg_zerocopy_iter() {
    ...
	pg_len = iov_iter_get_pages2(&msg->msg_iter, pages,
				     copy_limit, 1, &pg_off);
    ...
	dfrag->overhead = sizeof(struct mptcp_data_frag);
    ...
	sk_wmem_queued_add(sk, pg_len + dfrag->overhead);
    ...
}

With ITER_IOVEC, a 1-byte iovec segment gives pg_len == 1 but still
pins a whole page. On 64-bit, each pinned page then adds only about 49
bytes to sk_wmem_queued.

The only per-socket limit in the send loop is mptcp_send_limit(), which
compares sk_wmem_queued against sk_sndbuf. One msk could therefore pin
roughly sk_sndbuf / 49 pages.

For comparison, TCP charges the page-aligned size of each pinned page in
zerocopy_fill_skb_from_iter():

	skb->truesize += PAGE_ALIGN(copied + start);

The subflow side doesn't account for the pages either. For
pure-zerocopy skbs, mptcp_sendmsg_frag() adds only copy:

	skb->truesize += copy;
	sk_wmem_queued_add(ssk, copy);
	if (!skb_zcopy_pure(skb))
		sk_mem_charge(ssk, copy);

dfrag_uncharge() also skips sk_mem_uncharge() for ubuf dfrags.

mm_account_pinned_pages() charges RLIMIT_MEMLOCK by byte length:

	num_pg = (size >> PAGE_SHIFT) + 2;	/* worst case */

So 1024 one-byte iovecs on 1024 different pages are charged as 2 pages.

The pages stay pinned while the data sits unacknowledged in
msk->rtx_queue, for example when the local peer never reads.

Should the dfrag be charged for the full pinned page, as TCP does?

[Severity: Medium]
Now that applications can opt in, is it intended that MSG_FASTOPEN sends
silently drop MSG_ZEROCOPY without queueing a completion notification?

net/mptcp/protocol.c:mptcp_sendmsg() {
    ...
	if (msg->msg_flags & MSG_FASTOPEN || !sock_flag(sk, SOCK_ZEROCOPY))
		msg->msg_flags &= ~MSG_ZEROCOPY;
    ...
}

For these sends msg_zerocopy_realloc() is never called. sk_zckey
doesn't advance and no notification is queued.

Documentation/networking/msg_zerocopy.rst describes MSG_ZEROCOPY as "a
contract that the kernel will queue a completion notification".

TCP keeps that contract on the fastopen path:

net/ipv4/tcp.c:tcp_sendmsg_locked() {
    ...
	err = tcp_sendmsg_fastopen(sk, msg, &copied_syn, size, uarg);
    ...
}

The tcp_zerocopy_fastopen-client.pkt and -server.pkt packetdrill tests
check this behaviour. In its non-SG fallback cases, TCP queues a
"copied" notification (SO_EE_CODE_ZEROCOPY_COPIED) instead.

A TCP application that uses sendto(MSG_FASTOPEN | MSG_ZEROCOPY) and
waits for one notification per send would get nothing on MPTCP. It
could wait forever.

The previous patch's commit message says this downgrade is intentional.
This patch is what makes it visible to userspace.

> +	release_sock(sk);
> +	return 0;
> +}
> +

[ ... ]

> @@ -342,6 +357,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
>  	case SO_TIMESTAMP_NEW:
>  	case SO_TIMESTAMPNS_OLD:
>  	case SO_TIMESTAMPNS_NEW:
> +	case SO_ZEROCOPY:
>  		return mptcp_setsockopt_sol_socket_int(msk, optname, optval,
>  						       optlen);

[Severity: Low]
This isn't a bug, but Documentation/networking/msg_zerocopy.rst still
says:

  The feature is currently implemented for TCP, UDP and VSOCK (with
  virtio transport) sockets.

Should MPTCP be added there now that SO_ZEROCOPY is accepted on
IPPROTO_MPTCP sockets? The list already leaves out RDS, so it was
incomplete before this series.

[ ... ]

> @@ -387,7 +403,6 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
>  	 * SO_CNX_ADVICE is currently unsupported, could possibly be relevant,
>  	 * but likely needs careful design
>  	 *
> -	 * SO_ZEROCOPY is currently unsupported, TODO in sndmsg
>  	 * SO_TXTIME is currently unsupported
>  	 */

[Severity: Low]
This isn't a bug, but the matching comment in mptcp_recvmsg() in
net/mptcp/protocol.c is now out of date:

	/* MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */
	if (unlikely(flags & MSG_ERRQUEUE))
		return inet_recv_error(sk, msg, len);

Userspace now uses recvmsg(MSG_ERRQUEUE) to collect the zerocopy
completion notifications. Should that comment be updated as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795421388.git.tanggeliang%40kylinos.cn
