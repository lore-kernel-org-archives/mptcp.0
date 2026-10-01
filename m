Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A312F7EE7
	for <mptcp@lists.linux.dev>; Thu,  1 Oct 2026 21:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889130; cv=none; b=DJhl2qmWPYfFSCgGl8eKgMwQbFWtlV/9l91kXOPp9sqkL3cOcw6GLfgONwo7Dlvpu3xOqxEy+YnKveOl7kscA4lAfSNQsmQk9Y5GyHVVy6iJKhQqvx+2QFWCZ2xnR5uOJmoGZwgJTJEtHFMeIeS4fTg/dnfzUg6jUVWXNIMtIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889130; c=relaxed/simple;
	bh=iG1kT3sQVrqH7jDoqWUulcyMqVuBX7BC7myVaqkcr30=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kFx4jIR7Z5B9U81BqNsOH3TbSSpdGio1E/WI0C3NT624DWzd5JqkEck7kXuHwvlIp6CxmVVZ5sdwuXQJnM3ceVE9MUI4OBBXTB/wyjj41WXN7qr8YK0te97JUMlS1PEQKELmSEJR6YrLXfJcUu9A0Ee4YnyPU8uvzUWllrdQo5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuMELlcD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuMELlcD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5871F000FF;
	Thu,  1 Oct 2026 21:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790889128;
	bh=EIGhaNJpchajsL1NnmH9AlMywPYCDkQU7qE55p2HhBA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DuMELlcDK8F5EcjQN1Q6RReOqn8kI7j+0Wi0vc87mbFGczCpxi2uq6cYHiboDrn9r
	 EEWze9AaoGGP0z780vVlv0oSAjtChop+UopVw5V50D3aZh7D507PzrWVysi+tn4158
	 etV+dQNBNJTTcUWPFo7B1GhSnoqVH8VEWtzXaQAxbO9pf2NTenhL5gScnHPIagZnVk
	 XU0FbDploZnsUjeYRQtEpYegx5mrNjPbF0MbK9QY6zbZj9E9VxnqfmTbxV/dsxlvG+
	 8lcb7rrt60zFJHiIvw8CR3NlxBmgtMGlbj9YTQCtL+tqdgpPsMW4gIZCiKFvKQOxX8
	 vCEGyYkcI1ksA==
Subject:
 Re: [PATCH mptcp-next v14 02/11] mptcp: drop the cant_coalesce CB field
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc:
 mptcp@lists.linux.dev, pabeni@redhat.com, yangang@kylinos.cn, kuba@kernel.org
Date: Thu, 01 Oct 2026 21:12:07 +0000
Message-ID: <179088912762.3135.325160529103574361@kernel.org>
In-Reply-To: =?utf-8?q?=3Cdde0b48c30a611359c56ca28a40f3f3cd498f092=2E1790734?=
 =?utf-8?q?083=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3Cdde0b48c30a611359c56ca28a40f3f3cd498f092=2E17907340?=
 =?utf-8?q?83=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: High
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

Critical: 0 · High: 2 · Medium: 1 · Low: 2 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] `mptcp_inq_hint()` now takes `mptcp_data_lock()`
  (`spin_lock_bh(&sk->sk_lock.slock)`).
- [High] The new `test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)` in
  `__mptcp_move_skb()` (protocol.c:468) runs without the msk data lock.
- [Medium] `mptcp_inq_hint()` returns 0 while `MPTCP_SYNC_SEQ` is set,
  even though `skb_peek()` has just found an skb with unread data.
- [Low] `__mptcp_move_skb()` now calls
  `test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)` unconditionally…
- [Low] Baseline decision: false (resolved later in the series).

Pre-existing issues:
- [Low] Baseline decision: false.

--

mptcp: drop the cant_coalesce CB field

This patch removes the cant_coalesce field from the MPTCP skb control
block. Instead, it fixes up the TFO dummy mapping of the queued skb once
the IASN is known at 3rd ack time. The fixup runs directly in
subflow_set_remote_key(), or is deferred through a new MPTCP_SYNC_SEQ
cb_flags bit that __mptcp_move_skb() and mptcp_release_cb() consume, and
mptcp_inq_hint() now takes the msk data lock.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index dcb3ba098702f..1d3f29240387e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -168,7 +168,6 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
>  	int limit = READ_ONCE(sk->sk_rcvbuf);
>  
>  	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
> -	    unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
>  	    MPTCP_SKB_CB(from)->offset ||
>  	    ((to->len + from->len) > (limit >> 3)) ||
>  	    !skb_try_coalesce(to, from, fragstolen, delta))

[Severity: Low]
With cant_coalesce gone, can other data be coalesced into the TFO skb
while it still has the dummy mapping? At this point in the series,
mptcp_fastopen_subflow_synack_set_params() still does:

	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
	MPTCP_SKB_CB(skb)->end_seq = 0;

skb->len is unsigned int, so the negation happens in 32 bits and is
zero-extended into the u64 map_seq. Fallback data with map_seq 0 matches
the dummy end_seq 0 and passes the check above. mptcp_inq_hint() would
then keep reporting INT_MAX for longer.

A later patch in the series, "mptcp: remove CB offset field", fixes this.
It switches to -(u64)skb->len, computes the hint as ack_seq - copied_seq,
and uses a map_seq64 based coalesce check. Could the patches be reordered
or folded so this intermediate step stays consistent?

[ ... ]

> @@ -446,6 +465,19 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  
>  	mptcp_borrow_fwdmem(sk, skb);
>  
> +	if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
> +		/* Ensure we see the updated ack_seq after seeing the flag */
> +		smp_rmb();
> +
> +		mptcp_data_lock(sk);

[Severity: High]
Can this atomic clear race with the non-atomic cb_flags updates that are
done under the msk data lock? Both callers drop the slock before they
get here:

mptcp_move_skbs()
    mptcp_data_unlock(sk);
    __mptcp_move_skbs()
        __mptcp_move_skb()

mptcp_release_cb()
    spin_unlock_bh(&sk->sk_lock.slock);
    __mptcp_move_skbs()
        __mptcp_move_skb()

Softirq paths meanwhile do plain RMW on cb_flags under the slock while
the msk is owned. For example:

__mptcp_data_acked():
	__set_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->cb_flags);

mptcp_retransmit_timer():
	__set_bit(MPTCP_RETRANSMIT, &msk->cb_flags);

The same applies to MPTCP_PUSH_PENDING, and to MPTCP_ERROR_REPORT and
MPTCP_SYNC_STATE in subflow.c.

CPU0 (msk owner)                     CPU1 (softirq, slock held)
                                     __set_bit(MPTCP_CLEAN_UNA)
                                       load cb_flags, SYNC_SEQ set
test_and_clear_bit(MPTCP_SYNC_SEQ)
__mptcp_sync_rcv_sequence()
                                       store old value | CLEAN_UNA
                                       SYNC_SEQ is set again

At this commit, consuming the bit a second time in mptcp_release_cb() is
harmless because rcvd_dummy_seq is already false. Until then, though,
mptcp_inq_hint() returns 0.

Later in the series, after "mptcp: remove CB offset field", both
consumers also do:

	msk->copied_seq += mptcp_iasn(msk);

A resurrected bit would then add the IASN twice, and copied_seq would
end up far from the real stream position. __mptcp_recvmsg_mskq()
derives offset = (u32)*seq - map_seq from it, so it could skip or
misread skbs. mptcp_recv_skb() could also free unread skbs as if they
had been consumed.

Could the test-and-clear move inside the mptcp_data_lock() section just
below, using __test_and_clear_bit() like the other cb_flags users?

[Severity: Low]
The commit message says:

    Performance wise this trades a conditional in the fast path - in
    __mptcp_try_coalesce() - with a similar one in __mptcp_move_skb()
    and a couple more in slow paths.

Is that accurate? The removed cant_coalesce test was a plain load of a
byte already in cache. test_and_clear_bit() is a full-barrier atomic RMW
even when the bit is clear, and it now runs for every skb moved into the
msk.

mptcp_inq_hint() also gains a spin_lock_bh()/spin_unlock_bh() pair.
mptcp_rcv_space_adjust() calls it on the normal recvmsg path, so this is
not only a slow-path cost.

A test_bit() pre-check, or doing the test-and-clear inside the data lock
section that follows, would make the code match the message.

[ ... ]

> @@ -2383,15 +2415,23 @@ static bool mptcp_move_skbs(struct sock *sk)
>  	return enqueued;
>  }
>  
> -static unsigned int mptcp_inq_hint(const struct sock *sk)
> +static unsigned int mptcp_inq_hint(struct sock *sk)
>  {
>  	const struct mptcp_sock *msk = mptcp_sk(sk);
>  	const struct sk_buff *skb;
> +	u64 hint_val;
>  
>  	skb = skb_peek(&sk->sk_receive_queue);
>  	if (skb) {
> -		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> +		/* Avoid races vs ack_seq updates and MPTCP_SYNC_SEQ flag. */
> +		mptcp_data_lock(sk);

[Severity: High]
The tracepoint in include/trace/events/mptcp.h also calls
mptcp_inq_hint():

TRACE_EVENT(mptcp_rcvbuf_grow)
    TP_fast_assign(
	...
	__entry->inq = mptcp_inq_hint(sk);
	...

TP_fast_assign() runs from trace_event_raw_event_##call() under
guard(preempt_notrace)(), so preemption is disabled at this point. On
PREEMPT_RT, sk_lock.slock is a sleeping spinlock_t. With
mptcp:mptcp_rcvbuf_grow enabled, does this take a sleeping lock with
preemption disabled?

mptcp_rcv_space_adjust()
    trace_mptcp_rcvbuf_grow()
        mptcp_inq_hint()
            mptcp_data_lock()
                spin_lock_bh(&sk->sk_lock.slock)

With CONFIG_DEBUG_ATOMIC_SLEEP this would trigger "BUG: sleeping
function called from invalid context". If subflow RX contends for the
lock, it would trigger a scheduling while atomic splat.

On every config, the event now also has side effects that happen only
when tracing is enabled. It does a lock/unlock round trip, and
local_bh_enable() can run pending softirqs inside the trace callback.

The problem is still present at the end of the series. Could
mptcp_rcv_space_adjust() compute inq and pass it to the tracepoint, or
could the tracepoint use a lockless snapshot?

> +		if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
> +			mptcp_data_unlock(sk);
> +			return 0;
> +		}

[Severity: Medium]
Can this report 0 while data is still queued? skb_peek() has just found
an skb. subflow_set_remote_key() sets MPTCP_SYNC_SEQ whenever the msk is
owned when the peer key arrives:

	} else {
		/* Ensure ack_seq is visible before setting the flag */
		smp_wmb();
		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
	}

For a passive MPTFO socket the key arrives with the 3rd ack, and the
accepted TFO child can already be read before that. Only two places
clear the flag: __mptcp_move_skb(), which runs only when there is
backlog data, and mptcp_release_cb() at release_sock() time.

There are two ways to hit this. First, mptcp_recvmsg() partially reads
the TFO skb while the pure 3rd ack arrives. The TCP_CM_INQ cmsg is built
before release_sock():

		if (cmsg_flags & MPTCP_CMSG_INQ) {
			unsigned int inq = mptcp_inq_hint(sk);

Second, ioctl(SIOCINQ) in mptcp_ioctl():

		if (mptcp_move_skbs(sk))
			mptcp_cleanup_rbuf(msk, 0);
		*karg = mptcp_inq_hint(sk);
		release_sock(sk);

With an empty backlog, mptcp_move_skbs() does nothing, so the flag stays
set and SIOCINQ reports 0. mptcp_rcv_space_adjust() also subtracts 0
instead of the real queue length.

In this state all later data sits in the backlog, so the TFO skb is the
only queued data and skb->len - offset is the exact answer. 0 is meant
to say there is nothing to read, which is why the function returns 1 at
EOF. Could an application that stops reading when INQ is 0 (for example
with EPOLLET) stall here?

The commit message describes this hunk only as "add locking". The early
return is still present at the end of the series, and the new
mptcp_inq() helper copies it.

>  
> +		hint_val = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;

[Severity: Low]
This is a pre-existing issue, and not introduced by this patch, but
before the 3rd ack the TFO skb at the head of the queue still carries
the truncated dummy map_seq (2^32 - len). ack_seq - map_seq therefore
wraps, and the hint is clamped to INT_MAX. Is that the value SIOCINQ and
TCP_CM_INQ are expected to report for a passive TFO socket at that
stage?

The problem predates f03afb3aeb9d ("mptcp: drop
__mptcp_fastopen_gen_msk_ackseq()"). __mptcp_fastopen_gen_msk_ackseq()
added ack_seq to a map_seq that was already truncated, so the value was
wrong before that commit too, and a Fixes: tag pointing at it would not
be accurate.

This patch does not fully remove the wrong value either. It goes away
only with "mptcp: remove CB offset field" later in the series.

> +		mptcp_data_unlock(sk);
>  		if (hint_val >= INT_MAX)
>  			return INT_MAX;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790734083.git.tanggeliang%40kylinos.cn
