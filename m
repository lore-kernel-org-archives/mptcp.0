Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792937106;
	b=vox8x1NRWduVyPFSvFXLw9domltMWUum79e0a5vykIjD08Os4jcgEuKeiEEPdX16MPmk
	 4dhBn2n0krrBC4szDflcTeJcWiisFzf2+lRXkZCFkh4AOFDb+cISC/myKbhhSahwbQcEC
	 6MY5Mf7iL3Cy8m3L8hc444QvfX1LVsUH6pU430cLgSvJn5vv9Bh8Scu7Hc0Nu7FtOJRhk
	 EdhUl927GhMFAC5HZCQdRGPCGxENrAJ7FsMQ2+xgpfEgmOMVaB3RYDqDOw+OZ8Pr8y313
	 yQncixdEgaebLa3r/EWAg1gd61oTUx6cAmSMwndeZFxlE3SBHNXh1tt6ND4oHN626GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792937106;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fgt6nxggCHsvFBPdGCndTP3/j1JgzcOLWZKvqnWIq94=;
	b=uaZ3BK9Icfd3/KxsAgqCFPOUMzc7cSdfdGq+qIVvKNPxBYJdXAlnSLiv43mnB5Vyce2T
	 E/S7xIoA9r+612aS0SdRwZM4VaMquEwTIspLyJp2sB/VvoF8w2OQDgPuQSck5b8oG7yXG
	 jDdlf3OWozswUbR/5uD6UgL28pIax5fDw3HPMPzDvEYW/5rDXmpb/Xsrx1XfE7Hc1LQvC
	 PYdfOuWDVMJ82pLnMQ4pnD7J2otysO/t7EU8cnaECCYqIyAz14fCYmgklxLpI1uXLXTD5
	 CRKbYJ6HJvWpJ7O4775P7kN+1g89Os15Wlu9O05OUO2FFxaJEWLI4ovtDe3qdfa7tBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PETMV2sC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1E6606A31A
	for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PETMV2sC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569001F01825;
	Sun, 25 Oct 2026 14:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792937105;
	bh=fgt6nxggCHsvFBPdGCndTP3/j1JgzcOLWZKvqnWIq94=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=PETMV2sCCJjZngtD41QaHwly0bGGAVnwQ8i8L4DajWdiWWcoEC47old6gg+ZXdaeI
	 KE4HTtFfGxsZ3HdDp80TIMile8tfFnugeOkBdhbMaOUw3morShgDhucvWoFfzoPbLR
	 mQrK9DZ8gxJHcUsm5ieuqEzbSuQHUQw0QAWrTumybGacl2wOJ+T3a1bzT+wY0rJYz/
	 1MSA9ZCyd3tJ7mW89oj3LGNWvFodaNBjtNejgllJa+JZC6s1VhPwq7qIQn3lrpHxYZ
	 CEnatR3DfMwm8RtvzsVEg35uKR80tJxfXU/87G5tzalmLU+2ygRSvpMwsgn3gYpRKJ
	 ysnziUEQPlU1g==
Message-ID: <sashiko-outbox-184237@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH mptcp-next 1/1] mptcp: opportunistic reinjection on
 an idle subflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abdul Wasey" <w453y.me@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20261025134643.1537069-2-w453y.me@gmail.com>
References: <20261025134643.1537069-1-w453y.me@gmail.com>
 <20261025134643.1537069-2-w453y.me@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 14:05:04 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] mptcp: race on msk->conn_list in mptcp_oppr_check() when socke=
t owned
- [Medium] mptcp: missing csum_enabled check in mptcp_oppr_blocked()
- [Medium] mptcp: mptcp_oppr_send_range() does not cap info->limit to budget
- [Medium] mptcp: mptcp_oppr_collect() does not merge overlapping DSN ranges
- [Medium] mptcp: flawed gain and oppr_una tracking in mptcp_oppr_collect()
--

commit 44cedfbaa2769a1dea51657a670dc2d6b650eaf1
Author: Abdul Wasey <w453y.me@gmail.com>

mptcp: opportunistic reinjection on an idle subflow

This commit implements opportunistic reinjection for MPTCP when a connection
cannot send new data while an active subflow is idle and another slower or
inactive subflow still holds unacknowledged data. It collects the unacked
DSN ranges from the other subflows and resends them on the idle subflow via
the MPTCP worker.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index adbf8e0773dbb..b2b4e6b23b6b8 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1154,6 +1154,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
>  		__mptcp_data_acked(sk);
>  	}
>  	msk->last_ack_recv =3D tcp_jiffies32;
> +	mptcp_oppr_check(sk);
>  	mptcp_data_unlock(sk);
> =20
>  	trace_ack_update_msk(mp_opt->data_ack,
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8c..cd9aebd66b1e3 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> +/* the active subflow with nothing to send or retransmit and the lowest =
RTT */
> +static struct sock *mptcp_oppr_idle_ssk(struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *pick =3D NULL;
> +	u32 best =3D U32_MAX;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +		u32 rtt =3D READ_ONCE(tcp_sk(ssk)->srtt_us);
> +
> +		if (!__mptcp_subflow_active(subflow) || subflow->backup ||
> +		    subflow->request_bkup || subflow->stale || !rtt)
> +			continue;
> +		if (!tcp_rtx_and_write_queues_empty(ssk))
> +			continue;
> +		if (rtt < best) {
> +			best =3D rtt;
> +			pick =3D ssk;
> +		}
> +	}
> +	return pick;
> +}
> +
> +static bool mptcp_oppr_blocked(struct sock *sk)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	u64 snd_una =3D READ_ONCE(msk->snd_una);
> +
> +	if (snd_una =3D=3D READ_ONCE(msk->snd_nxt) ||
> +	    snd_una =3D=3D READ_ONCE(msk->oppr_una) ||
> +	    __mptcp_check_fallback(msk))
> +		return false;

[Severity: Medium]
Should mptcp_oppr_blocked() also check READ_ONCE(msk->csum_enabled) here?

In __mptcp_oppr(), the function returns early when msk->csum_enabled is set,
before msk->oppr_una is updated to msk->snd_una:

    if (!mptcp_oppr_blocked(sk) || READ_ONCE(msk->csum_enabled))
            return;
    ...
    una =3D msk->snd_una;
    WRITE_ONCE(msk->oppr_una, una);

Because mptcp_oppr_blocked() does not check msk->csum_enabled,
ack_update_msk() -> mptcp_oppr_check() will walk msk->conn_list twice and
schedule mptcp_worker on every incoming DATA_ACK while blocked when data
checksums are enabled, only for __mptcp_oppr() to immediately return without
updating msk->oppr_una.

> +
> +	/* new data can still go out: the scheduler will use the idle subflow */
> +	if (mptcp_send_head(sk) &&
> +	    mptcp_wnd_end(msk) - READ_ONCE(msk->snd_nxt) >=3D MPTCP_OPPR_MIN)
> +		return false;
> +	return true;
> +}

[ ... ]

> +static bool mptcp_oppr_worth(struct mptcp_sock *msk, struct sock *idle)
> +{
> +	struct mptcp_subflow_context *subflow;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +
> +		if (ssk =3D=3D idle || tcp_rtx_and_write_queues_empty(ssk))
> +			continue;
> +		if (!__mptcp_subflow_active(subflow) ||
> +		    mptcp_oppr_gain(ssk, idle))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +/* called on each DATA_ACK, under the msk data lock */
> +void mptcp_oppr_check(struct sock *sk)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	struct sock *idle;
> +
> +	if (!mptcp_oppr_blocked(sk))
> +		return;
> +	idle =3D mptcp_oppr_idle_ssk(msk);
> +	if (!idle || !mptcp_oppr_worth(msk, idle))
> +		return;
> +	if (!test_and_set_bit(MPTCP_WORK_OPPR, &msk->flags))
> +		mptcp_schedule_work(sk);
> +}

[Severity: Critical]
Can calling mptcp_oppr_check() from ack_update_msk() race with concurrent
modifications to msk->conn_list and subflow teardown when the msk socket is
owned by user context?

In ack_update_msk(), only mptcp_data_lock(sk) (sk->sk_lock.slock) is held.
When a process-context thread holds lock_sock(sk), sk->sk_lock.owned is set
while sk->sk_lock.slock is released. Under lock_sock(sk) and without holding
mptcp_data_lock(sk), msk->conn_list is modified with non-RCU list operations
and subflows are closed and freed, for instance in __mptcp_close_ssk():

    dispose_it =3D msk->free_first || ssk !=3D msk->first;
    if (dispose_it)
            list_del(&subflow->node);
    ...
    __tcp_close(ssk, 0);
    ...
    sock_put(ssk);

As well as list_add_tail() / list_del() in __mptcp_subflow_connect(),
list_move_tail() in __mptcp_flush_join_list(), and list_del() in
mptcp_subflow_drop_ctx(). Similarly, msk->first_pending (read via
mptcp_send_head(sk) in mptcp_oppr_blocked()) is updated under the msk socket
lock without holding mptcp_data_lock(sk).

Unlike __mptcp_check_push() and __mptcp_data_acked() in ack_update_msk(),
which check !sock_owned_by_user(sk) and defer work via msk->cb_flags when
the socket is owned, mptcp_oppr_check() walks msk->conn_list in
mptcp_oppr_idle_ssk() and mptcp_oppr_worth() and dereferences subflow and
ssk unconditionally. Could this dereference LIST_POISON1/LIST_POISON2 or a
freed ssk/subflow in softirq context?

[ ... ]

> +/* The DSN ranges at or after @una that the subflows slower than @idle s=
till
> + * hold, sent or not: the data the peer is waiting for. Sorted by start.
> + * @gain is set to the largest time the copies can save.
> + */
> +static int mptcp_oppr_collect(struct mptcp_sock *msk, struct sock *idle,
> +			      u64 una, struct mptcp_oppr_range *r, u32 *gain)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	int n =3D 0, i, k;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +		struct sk_buff *skb;
> +		u64 last =3D 0;
> +		u32 g =3D 0;
> +
> +		if (ssk =3D=3D idle)
> +			continue;
> +		if (__mptcp_subflow_active(subflow)) {
> +			g =3D mptcp_oppr_gain(ssk, idle);
> +			if (!g)
> +				continue;
> +		}
> +		*gain =3D max(*gain, g);
> +
> +		lock_sock(ssk);
> +		skb_rbtree_walk(skb, &ssk->tcp_rtx_queue)
> +			n =3D mptcp_oppr_add_skb(skb, una, &last, r, n);
> +		skb_queue_walk(&ssk->sk_write_queue, skb)
> +			n =3D mptcp_oppr_add_skb(skb, una, &last, r, n);
> +		release_sock(ssk);
> +	}

[Severity: Medium]
Does updating *gain =3D max(*gain, g) before walking the queues of ssk cause
two issues with how gain is tracked?

First, unlike mptcp_oppr_worth(), this loop does not check whether ssk
actually holds any unacked ranges after una before updating *gain, so an
active slow subflow with empty queues can inflate *gain.

Second, for an inactive subflow (!__mptcp_subflow_active(subflow)), g is
left at 0 so that __mptcp_oppr() does not cap budget by the pacing rate
(since a subflow that is gone saves an MPTCP RTO). However, if another
active subflow on the connection has g > 0, *gain =3D max(*gain, g) overwri=
tes
the 0 sentinel with g, causing __mptcp_oppr() to cap the budget for the
inactive subflow's data.

In addition, in __mptcp_oppr(), WRITE_ONCE(msk->oppr_una, una) is executed
before calling mptcp_oppr_collect() and before checking whether any bytes
were actually copied. If mptcp_oppr_collect() returns 0 or no bytes are
sent, should msk->oppr_una remain unchanged so reinjection is not
permanently suppressed for that snd_una?

> +
> +	for (i =3D 1; i < n; i++) {
> +		struct mptcp_oppr_range t =3D r[i];
> +
> +		for (k =3D i; k > 0 && after64(r[k - 1].start, t.start); k--)
> +			r[k] =3D r[k - 1];
> +		r[k] =3D t;
> +	}
> +	return n;
> +}

[Severity: Medium]
What happens if two non-idle subflows hold overlapping or identical DSN
ranges in their queues (for example, after an earlier retransmission or
subflow closure)?

mptcp_oppr_collect() sorts r[] by start sequence number, but it does not
merge overlapping ranges where before64(r[i].start, r[i - 1].end). When
__mptcp_oppr() iterates over r[] and calls mptcp_oppr_send_range() for each
entry, won't it retransmit the overlapping DSN bytes multiple times on the
same idle subflow and consume the budget on duplicate copies?

> +
> +/* resend [start, end) on @ssk from the msk rtx queue; < 0 on a send err=
or */
> +static int mptcp_oppr_send_range(struct sock *sk, struct sock *ssk, u64 =
start,
> +				 u64 end, int budget,
> +				 struct mptcp_sendmsg_info *info)
> +{
> +	struct mptcp_data_frag *dfrag;
> +	int copied =3D 0, ret;
> +
> +	list_for_each_entry(dfrag, &mptcp_sk(sk)->rtx_queue, list) {
> +		if (!dfrag->already_sent || !before64(dfrag->data_seq, end))
> +			break;
> +		if (!after64(dfrag->data_seq + dfrag->already_sent, start))
> +			continue;
> +
> +		info->sent =3D before64(dfrag->data_seq, start) ?
> +			     start - dfrag->data_seq : 0;
> +		info->limit =3D min_t(u64, dfrag->already_sent,
> +				    end - dfrag->data_seq);
> +		while (info->sent < info->limit && copied < budget) {
> +			ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, info);

[Severity: Medium]
Can mptcp_oppr_send_range() exceed the caller's budget when a dfrag range is
larger than the remaining budget?

In mptcp_sendmsg_frag(), the amount copied in a single call is bounded by
info->limit - info->sent:

    copy =3D info->size_goal;
    ...
    copy =3D min_t(size_t, copy, info->limit - info->sent);

Because mptcp_oppr_send_range() sets info->limit from dfrag->already_sent
and end - dfrag->data_seq without clamping it to info->sent + budget -
copied, a single call to mptcp_sendmsg_frag() can copy up to info->size_goal
(or the entire dfrag) before the while loop rechecks copied < budget. Should
info->limit also be capped by info->sent + budget - copied?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025134643.1537=
069-1-w453y.me@gmail.com?part=3D1
