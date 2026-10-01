Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59825488757
	for <mptcp@lists.linux.dev>; Thu,  1 Oct 2026 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889132; cv=none; b=RdIeZkesqy3TYGrS0dSsKOt+hCinrSJxH8d2fFKvD6I4fUS5gQ9hIFCgAbrs58Fb0Tmvtw+65yDHvAt9TlZeln2mUACSY/FdrD+hhOIFJjWscB1Dx7UjWcgCG2u82AyPKCxMxE+zw14H8bqrr/EOtq3bCdZI2XvLMd98kJ2Qlv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889132; c=relaxed/simple;
	bh=fwHzVspzHLECmEKlLZJ6Om33nxd427XycnGUW8JMhD4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EKRWWFTEwQlW8wcUwmxHOEtj16ca/N6P82aDBQXfpopseER4l5SBccRicDLR7qQqlnZMkolFTfEU91+wuKVeFHBZpw008vM6EshFShD3wpY6gT+bZ4yv+1MXyXFZs7CHonTA1Y9TBC8e/eBKYrqh+CPXEqoBNj0KenC6PmCc5rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxolDw+4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxolDw+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15421F000FF;
	Thu,  1 Oct 2026 21:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790889131;
	bh=kLTxR+97v8dvqfNOx4zreOr7ES7HYNkMoquoyJ2AOP4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PxolDw+43nVYAR11/6Z0scWNVHZFqwGTIMjmBDLzYicviJji1um0pmpbZERO7wqN+
	 b7dEBfeRM00fd1HEHh92IigSGIOH5ORkvGITOZU0m1DU0Mmxc8LKug4CxpaE2SIzCc
	 8KS5mKBDRJ/azhHknKrOJDz3O56XZfuLP162zaFdFPzIeWZlu+73prwhIYZMkqqhdr
	 iSTqUTzJ7mPD5cMTHZgdoMTtGpDda8yVqIO2kXsoWIaScRkSu0Xj0hz+5TnaClbBBE
	 p9j7fULQTHBLyR/5UyBpxm20bmMKPvM/Qx5UbKZQKtNRzcTgZlMeSxeH3sz8hZALDz
	 zr+hRDJNeo8Zw==
Subject: Re: [PATCH mptcp-next v14 05/11] mptcp: defer read_sock cleanup to
 mptcp_worker
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc:
 mptcp@lists.linux.dev, pabeni@redhat.com, yangang@kylinos.cn, kuba@kernel.org
Date: Thu, 01 Oct 2026 21:12:10 +0000
Message-ID: <179088913030.3135.17267555452910281818@kernel.org>
In-Reply-To: =?utf-8?q?=3C1ce3c8d4b5fb4704bf81d1b9ee629a40f9ef67ec=2E1790734?=
 =?utf-8?q?083=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C1ce3c8d4b5fb4704bf81d1b9ee629a40f9ef67ec=2E17907340?=
 =?utf-8?q?83=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes a different change from the one
  the code makes.
- [Medium] The patch changes behaviour for every existing MPTCP read_sock
  user: splice via mptcp_splice_read(), and the in-kernel…
- [Medium] The new per-connection accumulator msk->read_copied is never
  reset when a connection is torn down or a socket is cloned.
- [Low] The patch is written as a fix ("Fix this by ...") for a lock
  recursion and a BH-context problem "when MPTCP carries TLS", but that…
- [Low] msk->read_copied is a signed int.

--

mptcp: defer read_sock cleanup to mptcp_worker

This patch moves the mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf()
calls out of __mptcp_read_sock() and into mptcp_worker(). The consumed
byte count is kept in a new msk->read_copied field and the worker is
signalled through a new MPTCP_WORK_READ_COMPLETE bit. The patch also
removes the backlog flush from mptcp_recv_skb() and the msk_owned_by_me()
assertion from __mptcp_read_sock().

> When MPTCP carries TLS, the data path runs under mptcp_data_lock().
> Reaching sk->sk_data_ready(sk) synchronously ends up at
> tls_strp_check_rcv() -> mptcp_recv_skb() -> mptcp_move_skbs(), which
> calls mptcp_data_lock() on the same sk and recurses on sk_lock.slock.

[Severity: Low]
Can this path be reached in the current tree?
mptcp_setsockopt_sol_tcp() still rejects TCP_ULP:

net/mptcp/sockopt.c:mptcp_setsockopt_sol_tcp() {
    ...
	case TCP_ULP:
		return -EOPNOTSUPP;
    ...
}

The TLS strparser also calls the TCP helpers directly:
tls_strp_read_copyin() calls tcp_read_sock(), and tls_strp_msg_load()
calls tcp_recv_skb(). There doesn't seem to be a route from
tls_strp_check_rcv() into mptcp_recv_skb().

Today the only callers of __mptcp_read_sock() are mptcp_read_sock() and
mptcp_splice_read(). Both run in process context under lock_sock().

If this is preparation for TLS over MPTCP support that hasn't been merged
yet, could the commit message say so? Otherwise stable/AUTOSEL tooling
and backporters may treat it as a fix for a reachable bug.

> Fix this by deferring sk->sk_data_ready(sk) to mptcp_worker() via a new
> MPTCP_WORK_READ_COMPLETE bit, reusing the existing mptcp_schedule_work()/
> mptcp_cancel_work() infrastructure. The wakeup bit is consumed after the
> SOCK_DEAD && TCP_CLOSE destroy branch, so a socket that reaches the destroy
> path drops the pending wakeup rather than running it post-free.

[Severity: Medium]
Does this description match the code? Nothing on the
MPTCP_WORK_READ_COMPLETE path calls sk_data_ready(). mptcp_read_complete()
only drains msk->read_copied and then calls:

	mptcp_rcv_space_adjust(msk, read_copied);
	mptcp_cleanup_rbuf(msk, read_copied);

So the deferred work is rcvbuf autotuning plus a window update, not a
wakeup. That is also what gets dropped on the destroy path.

The recursion described in the first paragraph seems to be fixed by
removing this from mptcp_recv_skb():

-	if (!list_empty(&msk->backlog_list))
-		mptcp_move_skbs(sk);

The commit message doesn't mention that. It also doesn't mention that
msk_owned_by_me() is removed from __mptcp_read_sock().

Could the commit message be updated to describe these changes?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a4a21717867fe..58b48a8962ccf 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4666,11 +4679,14 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>  	if (noack)
>  		goto out;
>  
> -	mptcp_rcv_space_adjust(msk, copied);
> -
> +	/* The backlog flushing is only needed when some data is actually
> +	 * moved and will take place in the workers's release callback.
> +	 */
>  	if (copied > 0) {
>  		mptcp_recv_skb(sk, &offset);
> -		mptcp_cleanup_rbuf(msk, copied);
> +		msk->read_copied += copied;
> +		set_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags);
> +		mptcp_schedule_work(sk);
>  	}
>  out:
>  	return copied;

[Severity: Medium]
This changes behaviour for every existing read_sock user. All of them
run in process context with the msk lock held: mptcp_splice_read(), and
in-kernel sock->ops->read_sock() callers such as nvme_tcp_try_recv() and
strparser.

Before this patch, mptcp_cleanup_rbuf() sent the window-opening ACK as
soon as data was consumed. Now every read_sock call that returns data
does a sock_hold() and queue_work(). The window update and autotuning
only run once mptcp_worker() gets the socket lock:

mptcp_worker()
    lock_sock(sk);
    ...
    if (test_and_clear_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags))
        mptcp_read_complete(sk);

While mptcp_splice_read() holds the msk lock, the worker can only get in
during the release_sock()/lock_sock() gap between iterations, or after
splice returns. Could a sender stalled on a closed receive window end up
waiting for workqueue scheduling here?

The backlog drain is also removed from mptcp_recv_skb(), so data that
reached msk->backlog_list while the reader held the lock is no longer
picked up in the same call. Would a non-blocking splice (timeo == 0) now
return -EAGAIN while data is sitting in the backlog? The data would only
be spooled by mptcp_release_cb() at the next release_sock().

Process-context callers already own the socket lock. Could they keep
calling mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf() inline, with
deferral used only for the BH case?

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 0258b4462d80d..2bf97e570d37b 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h

[ ... ]

> @@ -326,6 +327,7 @@ struct mptcp_sock {
>  	u32		last_data_sent;
>  	u32		last_data_recv;
>  	u32		last_ack_recv;
> +	int		read_copied;

[Severity: Medium]
Is read_copied reset anywhere other than mptcp_read_complete()?
mptcp_disconnect() clears the pending bit:

	WRITE_ONCE(msk->flags, 0);

It also resets bytes_consumed, rcvspace_init, copied_seq and similar
fields, but it doesn't touch msk->read_copied. __mptcp_init_sock()
doesn't initialise it either.

There seem to be two ways for a byte count to be left behind.

(a) __mptcp_read_sock() runs when the msk is already in TCP_CLOSE, for
example when splicing leftover data after a peer fastclose. In that case
mptcp_schedule_work() refuses to queue the worker:

	if (inet_sk_state_load(sk) == TCP_CLOSE)
		return false;

so read_copied is never consumed.

(b) The worker is still pending when mptcp_disconnect() runs. When it
runs later, MPTCP_WORK_READ_COMPLETE has already been cleared, so it
skips mptcp_read_complete().

If the socket is then reused via connect() or listen(), won't the first
read_sock on the new connection pass the stale count plus copied to
mptcp_rcv_space_adjust()?

On the listen path, sk_clone_lock() -> sock_copy() copies the whole
mptcp_sock. Would every accepted child then inherit the listener's stale
read_copied as well?

[Severity: Low]
Can this signed int counter wrap? __mptcp_read_sock() adds to it on
every successful call, and only mptcp_read_complete() resets it.

In TCP_CLOSE the worker is never queued, and mptcp_worker() jumps
straight to unlock for CLOSE/LISTEN. Combined with the missing reset in
mptcp_disconnect(), repeated cycles of reading in TCP_CLOSE and then
reconnecting keep adding to it.

If it passes INT_MAX and goes negative, mptcp_rcv_space_adjust() returns
early on copied <= 0. mptcp_cleanup_rbuf() then passes a negative copied
to tcp_cleanup_rbuf(), which skips the window update for that batch.

A large positive value could also overflow msk->rcvq_space.copied (an
int) inside mptcp_rcv_space_adjust().

>  	unsigned long	timer_ival;
>  	u32		token;
>  	u32		tfo_skb_len;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790734083.git.tanggeliang%40kylinos.cn
