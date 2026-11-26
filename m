Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735799;
	b=Le5gZBdZt/84JkrshLQeLQ5iXvcru7hjSm2Xpiroqsdn+fP0xuw77eWWzdAzYL1mxG9p
	 LQ7MHBhzruB/lqNpOMsx2+Tixs/7LCmMDJ14f8tPyBUrCBE4OaOMn9o6De4cBPY1uuaSy
	 vhcVagoZQ7oUcmsnYlya5IInoU3SKZWbTwsrSnbPVZQLb9jRzGBgG1BiEbCA/eI8El0Hv
	 FGYFmvzwfr8xlaDto32G5knBych5J2c4LUoFXuULJy/poXE9fuOIHHVkxLx7tRO8lOFS1
	 znzcKZrQLHYloF4dkeJVx+HWlVYQ9z3Mxe6inkwUV4YVF3QcD5E7fCFPCjxRAcMaBDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735799;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vURz1urjeixfB1e6eZdk06jaUVV/FJM/DgaW2SXnS6Q=;
	b=uPx5U8e86qwfuMtgtCebrBsP/O6CNs6wtYs8PuvJ2Ip7NzULqswn1usago8dsVvdZUHz
	 S/w+77bN37lJx3uEOmNcKbBkKXO5ZACLSiw3U7TyASyeUluPF17qNW+2Pl63QDDWE2EHj
	 szUKF2WySCi63MM7yuZzX47WUJ8OIgEvJ3cCTzD2AxiY4bX3+6KfjRWPVQlRM0UAv3aph
	 JzQ3g7JElx7VGhtN/DvRyD/wv6dD5VowfWst/UJKof2JGp+f5KLw4CN0i8tihx4V4kPsr
	 Cq75JQsqVGfNryVgEzWOwSanHxDvYwoIo1ao14WoZ89AhSDDoLM5LUmPpLewLQy6zhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMFMg5ht;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89351606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMFMg5ht
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248E61F00899;
	Thu, 26 Nov 2026 23:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795735799;
	bh=vURz1urjeixfB1e6eZdk06jaUVV/FJM/DgaW2SXnS6Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iMFMg5htstiiq7ur5tG+uXTMQFhGrkxhD7MiNvEhwUawbHE3qTwBLyH8P9X2Wg7MR
	 olmMFnMPG5ugs1JlLnXTMHinuvK08l9nqgC5XwJ/jJtHzfnuWdKTOSnDFACaO2r+dI
	 IccU7jYA/tIJfewLFAdx1aQAHOik64JhjfymfDio/MtfUtPrVfZ7Low9/NOq8y/UyH
	 LVpao8MxgLl5Sef0kp0EQrzdyIl74lTghPlIiScFaC2SqF6O3DFFBhc5uYK/4usbqT
	 8j0Kfcs910bi64zRNYpSgXG63LMMwpSFns0YXaAUsozksRYpzv79rceHLIbY6xG2Us
	 EARkmRW95LKVg==
Subject: Re: [PATCH mptcp-next mptcp-net v3 48/50] mptcp: report errors as TCP
 does when closing
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 23:29:58 +0000
Message-ID: <179573579872.3133.12332671479932565054@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-48-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-48-416c0920c73f@kernel.org>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Spurious ECONNRESET after a clean MPTCP-level close, in
  __mptcp_close_ssk() (net/mptcp/protocol.c:2962-2968).
- [Medium] mptcp: skipped mptcp_check_rcv_close() in __mptcp_close_ssk()
  when ESTABLISHED
- [Medium] mptcp: premature TCP_CLOSE and wakeup before mptcp_close_err()
  on timeout
- [Low] The barrier-pairing comments disagree.

--

mptcp: report errors as TCP does when closing

This patch makes the MPTCP socket set SHUTDOWN_MASK and an error when it
moves to TCP_CLOSE. This covers the close timeout (ETIMEDOUT), the last
subflow closing outside ESTABLISHED, and the late cleanup in accept(). In
those cases the error is the last subflow's error, or one picked from the
MPTCP-level state, matching tcp_done_with_error().

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/648

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 016b16b3cc925..0a7600aea181e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -518,6 +518,56 @@ static void mptcp_close_wake_up(struct sock *sk)
>  		sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
>  }
>  
> +/* Mirror the tcp_reset() error propagation */
> +static int mptcp_reset_err(const struct sock *sk)
> +{
> +	int err;
> +
> +	switch (sk->sk_state) {
> +	case TCP_SYN_SENT:
> +		err = ECONNREFUSED;
> +		break;
> +	case TCP_CLOSE_WAIT:
> +		err = EPIPE;
> +		break;
> +	default:
> +		err = ECONNRESET;
> +	}
> +
> +	return err;
> +}
> +
> +/* No more data can be exchanged: report it, as tcp_done_with_error() does */
> +static void mptcp_close_err(struct sock *sk, int err)
> +{
> +	WRITE_ONCE(sk->sk_err, err);
> +	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
> +	smp_wmb();

[Severity: Low]

This isn't a bug, but the comment on the reader side in mptcp_poll() still
names only __mptcp_error_report() as the matching writer:

	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
	smp_rmb();

__mptcp_error_report() has no smp_wmb() of its own. The writers are
__mptcp_subflow_error_report() and now mptcp_close_err().

The ordering itself looks correct. Could the mptcp_poll() comment be updated
to name the new writer too?

> +	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
> +	mptcp_set_state(sk, TCP_CLOSE);
> +	if (sock_flag(sk, SOCK_DEAD))
> +		return;
> +
> +	mptcp_close_wake_up(sk);
> +	sk_error_report(sk);
> +}
> +
> +/* As TCP: the error of the last subflow, e.g. ETIMEDOUT, but after a reset
> + * (EBADMSG: by MPTCP) or without error, it depends on the msk state
> + */
> +static void mptcp_close_last_err(struct sock *sk, int err)
> +{
> +	switch (err) {
> +	case 0:
> +	case ECONNREFUSED:
> +	case ECONNRESET:
> +	case EPIPE:
> +	case EBADMSG:
> +		err = mptcp_reset_err(sk);
> +	}
> +	mptcp_close_err(sk, err);
> +}
> +

[ ... ]

> @@ -2905,13 +2957,15 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  			mptcp_set_close_tout(sk, tcp_jiffies32 -
>  					     (mptcp_close_timeout(sk) + 1));
>  			mptcp_schedule_work(sk);
> +		} else if (sk->sk_state == TCP_CLOSE) {
> +			mptcp_close_wake_up(sk);
>  		} else if (sk->sk_state != TCP_ESTABLISHED ||
>  			   msk->in_accept_queue) {
>  			mptcp_check_rcv_close(sk);
> -			mptcp_set_state(sk, TCP_CLOSE);
> -			WRITE_ONCE(sk->sk_shutdown,
> -				   sk->sk_shutdown | SEND_SHUTDOWN);
> -			mptcp_close_wake_up(sk);
> +			if (sk->sk_state == TCP_CLOSE)
> +				mptcp_close_wake_up(sk);
> +			else
> +				mptcp_close_last_err(sk, ssk_err);

[Severity: Medium]
Can waiters be woken here before the error is set, on the close
timeout path?

When mptcp_close_tout_expired() is true in mptcp_worker(),
mptcp_do_fastclose() moves the msk to TCP_CLOSE first, while sk_err is
still 0 and sk_shutdown is not SHUTDOWN_MASK. The loop then calls
__mptcp_close_ssk() on each subflow. Once only msk->first is left, in
TCP_CLOSE, this new branch calls mptcp_close_wake_up() on a socket
that is not SOCK_DEAD. That runs sk_state_change() before
mptcp_close_err(sk, ETIMEDOUT) has written sk_err and sk_shutdown.

mptcp_poll() and getsockopt(SO_ERROR) do not take the msk socket lock.
A waiter woken on another CPU can therefore see TCP_CLOSE with
sk_shutdown at 0 and sk_err at 0. It gets EPOLLHUP without EPOLLERR,
EPOLLIN or EPOLLOUT, and SO_ERROR returns 0 instead of ETIMEDOUT. An
application acting on that first wakeup would miss the timeout this
patch is meant to report. mptcp_close_err() then wakes everybody a
second time.

The ordering mptcp_close_err() sets up (sk_err, smp_wmb(),
SHUTDOWN_MASK, then TCP_CLOSE) does not help here, as the state was
already published by mptcp_do_fastclose(). mptcp_check_fastclose() has
a similar, older inversion: TCP_CLOSE is set before SHUTDOWN_MASK, and
there is no smp_wmb() after sk_err.

Should the wake up in __mptcp_close_ssk() be left to mptcp_close_err()
on the close timeout path? Or should sk_err and sk_shutdown be set
before mptcp_do_fastclose() changes the state?

[Severity: Medium]
Can a DATA_FIN still sitting in msk->backlog_list be missed here?

Suppose the peer sends its last data with a DATA_FIN, then closes or
resets the only subflow, while mptcp_worker() owns the msk socket lock.
The skb is queued in msk->backlog_list and msk->rcv_data_fin is set,
but msk->ack_seq has not reached msk->rcv_data_fin_seq yet. The
mptcp_check_data_fin() call in mptcp_worker() does not spool the
backlog, so sk_state is still TCP_ESTABLISHED when
__mptcp_close_subflow() reaches __mptcp_close_ssk().

mptcp_close_ssk() only spools the backlog for the first subflow after
a fallback. The TCP_ESTABLISHED test above also runs before
mptcp_check_rcv_close() gets a chance to, so this ends up in the
mptcp_start_tout_timer() branch. The backlog is only moved later, from
mptcp_release_cb(), which then processes the DATA_FIN and moves the msk
to TCP_CLOSE_WAIT with no subflow left.

The msk then sits in TCP_CLOSE_WAIT until the close timeout expires.
With this patch, mptcp_worker() then reports ETIMEDOUT through
mptcp_close_err(), on a connection the peer closed cleanly. Had the
DATA_FIN been processed first, mptcp_close_last_err() would have
closed it at once with EPIPE. An MP_FASTCLOSE received in the same
window looks to be skipped the same way.

The TCP_ESTABLISHED gating predates this patch, but the new error
reporting makes the difference visible to applications. Should
mptcp_check_rcv_close() be called before sk_state is tested here, or
is the pending DATA_FIN expected to be handled somewhere else?

[Severity: Medium]

Can this report ECONNRESET after a clean MPTCP-level close?

mptcp_check_rcv_close() only handles the receive side, through
mptcp_check_data_fin() and mptcp_check_fastclose(). When our own DATA_FIN is
acked, the move to TCP_CLOSE is done only by mptcp_check_data_fin_ack(),
which is called only from mptcp_worker():

net/mptcp/protocol.c:mptcp_check_data_fin_ack() {
    ...
	if (mptcp_pending_data_fin_ack(sk)) {
		...
		case TCP_CLOSING:
		case TCP_LAST_ACK:
			mptcp_shutdown_subflows(msk);
			mptcp_set_state(sk, TCP_CLOSE);
    ...
}

When the DATA_ACK arrives, __mptcp_clean_una() only schedules the worker:

	if (mptcp_pending_data_fin_ack(sk))
		mptcp_schedule_work(sk);

So until the worker runs, the msk can still be in TCP_LAST_ACK or
TCP_CLOSING with our DATA_FIN already acked.

Suppose msk->first is already in TCP_CLOSE and the one other subflow is
removed in that window. One way is a peer RM_ADDR, handled earlier in the
same worker run:

mptcp_worker()
  mptcp_pm_worker()
    mptcp_pm_rm_addr_recv()
      mptcp_pm_rm_addr_or_subflow()
        mptcp_close_ssk()
          __mptcp_close_ssk()
  ...
  mptcp_check_data_fin_ack()   <- runs only after this

mptcp_pm_rm_addr_or_subflow() skips only subflows in FIN_WAIT1, FIN_WAIT2,
CLOSING or CLOSE, so an ESTABLISHED or CLOSE_WAIT subflow is still removed.
A netlink endpoint delete or flush, or a userspace PM subflow destroy, can
also reach mptcp_close_ssk() directly under the msk lock.

In that case ssk_err is 0, and for a socket that is not SOCK_DEAD (for
example after shutdown(SHUT_WR)) the result is:

mptcp_close_last_err(sk, 0)
  mptcp_reset_err(sk)            -> ECONNRESET for LAST_ACK / CLOSING
  mptcp_close_err(sk, ECONNRESET)

When mptcp_check_data_fin_ack() runs later, the msk is already in
TCP_CLOSE, mptcp_pending_data_fin_ack() returns false, and sk_err stays at
ECONNRESET. mptcp_poll() then reports EPOLLERR and SO_ERROR returns
ECONNRESET on a connection that finished its DATA_FIN exchange cleanly.

Before this patch, this path moved to TCP_CLOSE without setting sk_err.
TCP also sets no error when the final ACK arrives in LAST_ACK or CLOSING.

Should the pending DATA_FIN ack be processed first, either through
mptcp_check_data_fin_ack() or a mptcp_pending_data_fin_ack() test, before
the error is picked? This doesn't seem to be addressed by the later patches
in the series.

>  		} else {
>  			mptcp_start_tout_timer(sk);
>  		}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124-mptcp-cmason-fixes-v3-0-416c0920c73f%40kernel.org
