Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793302167;
	b=Qv0DixgmCLIzB0A+4D7gUdYVkxZ+p9jVeMQcrCpIQdQW2yzhv2Is5YjlaC5SOeIQ9RRh
	 Op1mmAfwXsvOdY09dg6vFFfrTZvXOJwn6ORQNimeYgtzxu/ERDflamiHYfFQkpYi/VxMY
	 VT0g8MNqK43CaagEo6swkUHbLBVqpqecqgsRqRg3/otseIy4Z+dxV4MCXFaHuR+rvtCIp
	 VlxIcYj75j6bs1Uoa0qY6WcwGWhcSO8E7Uz6kTeZz3bBNGh1Faxp9iIdBRTNWtsEjYVC0
	 82DrU7jpZ/2GLNbGWvzPLuGjfJM3MPgR1iCNzSJQGgCfWu5Oyx1nu/kWspcbi1NVhAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793302167;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CNPOascVWc7HSbBJUWuO8TARYJZj0aD/qW99XZQrmIU=;
	b=qz2lRFCE/QtMECt15QlRabt/O9vrC3Jw9kgudXk8OotixvP9wUfETy7s8iluj5Uh5YfG
	 ZWBzr+iU11zFg+WG9+5boVdzSJEifUd3ej9TJXv0K9u5X+Wv9LTDqYXEv3HiwbEFcS5O2
	 TaqNzigX40dxbAQ7a338eMx8PmRHKdJMywXzdjNKDARXxDG2E4I6XucUitTifiwTd66qq
	 uNqalDwhysMvb5DjmQhTjTJNFYEgcqwRJglkhJftsio9WPSU1MmFdhbJIGz0S5lmDgBbJ
	 APZLrLP4RkLMmMQfHb6CH+bC6lChh2s3m+gVMIhDxEUPItizky1ksi/aCjI9LlVP+Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VaMYscoO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDA6606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VaMYscoO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B2D1F01816;
	Thu, 29 Oct 2026 19:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793302167;
	bh=CNPOascVWc7HSbBJUWuO8TARYJZj0aD/qW99XZQrmIU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VaMYscoOJWwkkcUFBBo5RCa2gSeq6BYw0eQPgA5BzptH/HvDFPWJS9xZl8Vk5htDp
	 kZI1ezLMsTzrjGSBrN2DvSbaM155FrmQ/MFZB79+GAKC0CUOqExdnd2Y9rSB/e0lcw
	 qNCdFHop7QjUugCr1LK83g9jkukGnq2L4GV+YmnwXuH6+UiFa5A6S12Fp9KQxBqB3m
	 CB3hY4VItjydpANGNzTZCnsAqzl+Sr/TH6c2dXomFR42jj3vS+r/y+FKvqxh0i2xdQ
	 gxb8Ioly3iXaJfvSakh7vfhB7EpI4+aEXWnW9181IsDrelXLdkp9whCXMDDRGs48dD
	 gBTIzFZQeTWXA==
Subject: Re: [PATCH mptcp-next v12 4/6] mptcp: pm: in-kernel: retry subflows
 closed after an error
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 29 Oct 2026 19:29:26 +0000
Message-ID: <179330216645.3132.209910252774259512@kernel.org>
In-Reply-To: <20261028054143.3222998-5-anilkaushikwireless@gmail.com>
References: <20261028054143.3222998-5-anilkaushikwireless@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When an established additional subflow dies, its re-creation
  takes back the PM slot before the in-kernel PM can fail over to an…
- [Medium] mptcp_worker() always cleans up stale re-created subflows with
  mptcp_close_retry_subflows(sk, true).
- [Medium] mptcp_close_retry_subflows() (net/mptcp/protocol.c) checks the
  retry subflow's TCP state (TCP_SYN_SENT, in connecting mode) and…

--

mptcp: pm: in-kernel: retry subflows closed after an error

With the in-kernel PM, when TCP gives up on an established, locally
initiated subflow after a timeout, this patch creates a new subflow with
the same addresses. The subflow-retries limit is used as its SYN retry
count. Retry subflows that are not established yet are closed when no
other subflow can send data, or when the MPTCP socket is shut down or
closed.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 7fb4c78743409..f06b24a9cd538 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1610,6 +1610,143 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)

[ ... ]

> +/* Called with the msk socket lock held, after the subflow has been closed */
> +void mptcp_pm_kernel_retry(struct mptcp_sock *msk,
> +			   const struct mptcp_pm_retry *retry)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = (struct sock *)msk;
> +	bool allowed;
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	allowed = msk->pm.extra_subflows <
> +		  mptcp_pm_get_limit_extra_subflows(msk);
> +	if (allowed)
> +		msk->pm.extra_subflows++;
> +	spin_unlock_bh(&msk->pm.lock);

[Severity: Medium]

Does this take back the extra_subflows slot before the PM has a chance to
fail over to an unused endpoint?

For a subflow that timed out, __mptcp_close_subflow() runs:

__mptcp_close_subflow()
  mptcp_pm_subflow_retry_check()
  mptcp_close_ssk()
    mptcp_pm_subflow_check_next()
      __mptcp_pm_close_subflow()        /* extra_subflows-- */
      mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED)
  mptcp_pm_subflow_retry()
    mptcp_pm_kernel_retry()             /* extra_subflows++ */

Later the PM work runs mptcp_pm_create_subflow_or_signal_addr(), and its
loop requires:

	while (msk->pm.local_addr_used < endp_subflow_max &&
	       msk->pm.extra_subflows < limit_extra_subflows) {

Take a subflows limit of 1 with two subflow endpoints, A and B. After A
times out, B is never tried. The SYN_SENT retry to the dead path keeps
the slot until it gives up. With the default subflow-retries of 127,
that is about 4 hours.

Before this patch, such a setup moved to endpoint B right away.

Is this priority intended? If so, could the commit message and mptcp.rst
say that a retry now takes precedence over the next endpoint while the
subflows limit is reached? The commit message only says "the PM keeps
trying the next endpoints, as before", and only for subflows that never
got established.

> +
> +	if (!allowed ||
> +	    __mptcp_subflow_connect(sk, &retry->local, &retry->remote))
> +		return;

[ ... ]

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8c..257059ffdc7e9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -2788,6 +2795,49 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  	}
>  }
>
> +/* Re-created subflows not established yet are useless once the msk is
> + * closed or shut down. When no other subflow can send data, see
> + * mptcp_retry_subflows_stale(), only the ones still connecting are: a joined
> + * one is fully established soon. Not called while iterating on the subflows.
> + */
> +static void mptcp_close_retry_subflows(struct sock *sk, bool connecting)
> +{
> +	struct mptcp_subflow_context *subflow, *tmp;
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +
> +	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +		if (!subflow->retry || READ_ONCE(subflow->fully_established))
> +			continue;
> +
> +		if (connecting) {
> +			if (inet_sk_state_load(ssk) != TCP_SYN_SENT)
> +				continue;

[Severity: Medium]

Can a joined retry subflow that never becomes fully established stay
around forever?

mptcp_worker() always passes connecting as true:

	if (mptcp_retry_subflows_stale(msk))
		mptcp_close_retry_subflows(sk, true);

So a retry subflow that is TCP_ESTABLISHED but not yet fully_established
is always skipped here.

The comment above assumes "a joined one is fully established soon". If
the path drops again between the SYN/ACK and the fourth ACK, the subflow
only retransmits the third ACK through schedule_3rdack_retransmission().
That timer re-arms with no limit.

No data is sent on this subflow, because __mptcp_subflow_active() rejects
request_join subflows that are not fully established. So no RTO ever
closes it.

Now suppose the last subflow that can send times out. It is not retried,
because mptcp_pm_retry_other_subflow() finds nothing. conn_list then
holds the closed msk->first plus this retry subflow, so this check in
__mptcp_close_ssk() is false:

	if (list_is_singular(&msk->conn_list) && msk->first &&
	    inet_sk_state_load(msk->first) == TCP_CLOSE) {

As a result, mptcp_start_tout_timer() is never armed. The worker then
skips the retry subflow again, since it is not in TCP_SYN_SENT.

With keepalive disabled, wouldn't the msk stay ESTABLISHED with no usable
path and no close timeout? The new mptcp.rst text says that without
another subflow able to send data, "the connection is closed after
close_timeout, as before, and the subflows being re-created are closed
too".

There is a smaller case too. After a DATA_FIN moves the msk to
CLOSE_WAIT, mptcp_retry_subflows_stale() returns true, and its comment
says such subflows "must not keep the connection open". The worker still
passes connecting as true.

Wouldn't a joined but unfinished retry subflow then keep its socket and
PM slot until the application shuts down or closes the socket?

> +			/* another one got established in the meantime */
> +			if (!mptcp_retry_subflows_stale(msk))
> +				break;
> +		}
> +
> +		/* like mptcp_close_ssk(): it can have joined already */
> +		if (sk->sk_state == TCP_ESTABLISHED &&
> +		    !subflow->close_event_done) {
> +			subflow->close_event_done = true;
> +			mptcp_event(MPTCP_EVENT_SUB_CLOSED, msk, ssk,
> +				    GFP_KERNEL);
> +		}

[Severity: Medium]

Can netlink PM listeners get MPTCP_EVENT_SUB_CLOSED and then
MPTCP_EVENT_SUB_ESTABLISHED for the same subflow?

The TCP_SYN_SENT and fully_established checks above run without the ssk
lock. The ssk lock is only taken later, by lock_sock_nested() inside
__mptcp_close_ssk(), and the state is not checked again. In between,
the GFP_KERNEL allocation in mptcp_event() can sleep.

Meanwhile, a SYN/ACK handled in softirq on another CPU can complete the
join:

tcp_finish_connect()
  subflow_finish_connect()
    mptcp_finish_join()
      mptcp_subflow_joined()
        mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);

For an active subflow already in conn_list, mptcp_finish_join() only
takes msk->fallback_lock. It does not check whether the msk owner is
closing the subflow.

close_event_done is already set, and __mptcp_close_ssk() then removes the
subflow from conn_list. So no second SUB_CLOSED is sent.

Would userspace then keep tracking a subflow that no longer exists, until
MPTCP_EVENT_CLOSED? The comment below accepts that a subflow which just
joined "is then closed anyway", but the event ordering does not seem to
be handled.

> +
> +		/* Checked without the ssk lock: it can have joined, or been
> +		 * established in between, and is then closed anyway.
> +		 * __mptcp_close_ssk() cleans its data in the msk backlog, and
> +		 * the MPTCP retransmissions cover what it sent. No need to push
> +		 * the pending data again.
> +		 */
> +		mptcp_pm_subflow_check_next(msk, subflow);
> +		__mptcp_close_ssk(sk, ssk, subflow, 0);
> +	}
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028054143.3222998-1-anilkaushikwireless%40gmail.com
