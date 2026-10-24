Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792822280;
	b=P/tmObBlGDmrJ3hDifBwX+nxP+rvmf8jLK2b/pMLjxQ8+Sq6u3Fckhqi2CebxcMHq0L1
	 OWo5GK7+77lD1PU+axxk+2Jpmn2U8FpQaaECTkr45dvTfO5tPXJ+uPPLAC9CkCuwzhuaU
	 fsdD+F1QfzvH0VYbUsnJuIiEKh2ZLqZz3B8OX7ba9gAXwPIhGOJV/xBU7ZVou3hBI41TZ
	 aXU9ELVwYt/5NDZh7+Eg7eeczWD7XiK9TScyMw5efc15H31Q/DGPDEEEIWQwcH+a9FimZ
	 m4NQP+l/O1gGhCNzRa87vWBc7tsxZK0OVbUKYoWh+9+2pra0hX8ARx9MbEXG91sJE2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792822280;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=A5LMAdAy/MQJ/rwz2D++GTgA8ktHd8jXXh5fI2mUe1A=;
	b=dK26Pe51etINPiS/GPuQNT+lzjMBq/oOPIAzcLJVw+r0CYyst1+GYRNu77M6ZRrfEEsj
	 R814RNKR5d/Rjb9mkO5QpDFVoXizx+oH5bRcfW3B9ooGyns6qziM/rPHvNBSMzQBpjE+1
	 o9kd4j47L12dbQ3xmnSs2V5EcS0JVwGOh1wYH8c4UZ/uoIKEolkccT0TBeyPL9nJqJrc9
	 BjDL6e4HZzxlnCa7T/rL2rywg/8DjXwxQ/4zZJ5OCgO/7Yk92r62C+2XSUoA0b9xoAavJ
	 ci9EY89/aHEMYf2R7xIZsrrK2xXEJlgV0WXIGuIdh4p3DvL6qByngcbW7DI7Bafn/bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G6BKucd/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CB9606A31E
	for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 06:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6BKucd/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3652D1F01828;
	Sat, 24 Oct 2026 06:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792822279;
	bh=A5LMAdAy/MQJ/rwz2D++GTgA8ktHd8jXXh5fI2mUe1A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G6BKucd/ZqJd+SR1yux3LV1iSmyJoOteliB+zyi4kAoPh6inRXUOegmHFlumrHNWF
	 vzyiparnyZQpjqA5hW8NqFYGlw1QZtw6s9WbAGgfUi6BanaKsXEeBslyka0Kzo4BkM
	 BM/zNSAuURtz8d6EIGAdL7OBv9B57Hr+o8RGRzpskfai92vo7uRjUmrZ6yaQaa+QHV
	 CL1CtNWBfsn0GLOj78EbZdj7ArI/P2+UCcA8trssMpMiFAX9NNB6nKVTT8k/c8haiy
	 lNMzwvyKvsSppx4zZKmZwqv5LJpPNoAwbmIQU1ZFkeU+Nhyrj2IDpJtKRkFc/PgHtJ
	 sM/aPpEthAasg==
Subject: Re: [PATCH mptcp-next v8 4/6] mptcp: pm: in-kernel: retry subflows
 closed after an error
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 24 Oct 2026 06:11:18 +0000
Message-ID: <179282227880.3132.17679916784723382534@kernel.org>
In-Reply-To: <20261022151130.2285198-5-anilkaushikwireless@gmail.com>
References: <20261022151130.2285198-5-anilkaushikwireless@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] TOCTOU race in mptcp_close_retry_subflows()
  (net/mptcp/protocol.c:3512) that can lead to a use-after-free.
- [Medium] This patch changes how a dead MPTCP client connection is
  detected, the change is on by default, and neither the commit message…
- [Medium] mptcp_pm_retry_path_error() (net/mptcp/pm_kernel.c:1616)
  treats only ETIMEDOUT, EHOSTUNREACH, ENETUNREACH, EHOSTDOWN and…

--

mptcp: pm: in-kernel: retry subflows closed after an error

This patch makes the in-kernel PM re-create an established subflow that
this side initiated, once TCP gives up on it after a retransmission or
keepalive timeout. The new subflow takes its SYN retry count from the
subflow-retries limit. Re-created subflows that are still connecting are
closed when the MPTCP socket is closed.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 67bf421d117b5..23e8af94b1a45 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1610,6 +1610,124 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
>  	return true;
>  }
>  
> +/* TCP gave up on the path: a retransmission or keepalive timeout, possibly
> + * reported with an ICMP error received from the path.
> + */
> +static bool mptcp_pm_retry_path_error(int err)
> +{
> +	switch (err) {
> +	case ETIMEDOUT:
> +	case EHOSTUNREACH:
> +	case ENETUNREACH:
> +	case EHOSTDOWN:
> +	case ENETDOWN:
> +		return true;
> +	}
> +
> +	return false;
> +}

[ ... ]

> +	/* Only when the path stopped working. A reset, from the peer or from
> +	 * anything on the path, means the path works: re-creating the subflow
> +	 * right away could loop. Not after a reset by MPTCP itself either, with
> +	 * mptcp_subflow_reset(), whatever sk_err says.
> +	 */
> +	if (!mptcp_pm_retry_path_error(err) || subflow->resetting)
> +		return false;

[Severity: Medium]
Does this allow-list miss timeouts that had other ICMP errors before them?

When TCP gives up after a retransmission or keepalive timeout,
tcp_write_err() sets sk_err to the last soft error, not to ETIMEDOUT:

net/ipv4/tcp_timer.c:tcp_write_err() {
	tcp_done_with_error(sk, READ_ONCE(sk->sk_err_soft) ? : ETIMEDOUT);
	...
}

On an established socket without IP_RECVERR, tcp_v4_err() stores non-PMTU
ICMP errors in sk_err_soft and keeps retransmitting:

net/ipv4/tcp_ipv4.c:tcp_v4_err() {
	...
	} else	{ /* Only an error on timeout */
		WRITE_ONCE(sk->sk_err_soft, err);
	}
	...
}

That covers ECONNREFUSED (port unreachable, e.g. iptables -j REJECT),
ENOPROTOOPT, ENONET and EPROTO. tcp_v4_err() also stores EMSGSIZE. On
IPv6, icmpv6_err_convert() maps admin-prohibited, policy-fail and
reject-route to EACCES, and parameter problem to EPROTO.

In all of these cases the subflow is in TCP_CLOSE because TCP timed out.
Still, mptcp_pm_kernel_retry_check() returns false here, so the subflow is
never re-created.

IPv4 and IPv6 also seem to behave differently here. On IPv4,
administratively prohibited or filtered maps to ENETUNREACH or
EHOSTUNREACH and is retried. The IPv6 equivalent maps to EACCES and is
not.

Can the errno alone tell a TCP timeout apart from the last soft error
seen? The comment above mptcp_pm_retry_path_error() and the new mptcp.rst
text say any retransmission or keepalive timeout leads to a retry, and
they only exclude resets.

[ ... ]

> +/* Called with the msk socket lock held, after the subflow has been closed */
> +void mptcp_pm_kernel_retry(struct mptcp_sock *msk,
> +			   const struct mptcp_pm_retry *retry)
> +{

[ ... ]

> +	if (!allowed ||
> +	    __mptcp_subflow_connect(sk, &retry->local, &retry->remote))
> +		return;
> +
> +	/* the new subflow is the last one */
> +	subflow = list_last_entry(&msk->conn_list, struct mptcp_subflow_context,
> +				  node);
> +	ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
> +	WRITE_ONCE(inet_csk(ssk)->icsk_syn_retries, retry->syn_retries);

[Severity: Medium]
Does this change how long a dead client connection with a single path
stays up?

Before this patch, when the last subflow of an established msk that had
not fallen back timed out, __mptcp_close_ssk() started the close timeout:

net/mptcp/protocol.c:__mptcp_close_ssk() {
	...
	if (list_is_singular(&msk->conn_list) && msk->first &&
	    inet_sk_state_load(msk->first) == TCP_CLOSE) {
		if (sk->sk_state != TCP_ESTABLISHED ||
		    msk->in_accept_queue || sock_flag(sk, SOCK_DEAD)) {
			...
		} else {
			mptcp_start_tout_timer(sk);
		}
	}
}

On such an msk, __mptcp_subflow_error_report() does not pass subflow
errors up. So this timer was how the application found out about the
failure: after close_timeout (60s by default), mptcp_worker() fastcloses
the msk and wakes the application.

With this patch, mptcp_pm_kernel_retry_check() accepts the client's
initial subflow, and the call chain becomes:

__mptcp_close_subflow()
  mptcp_close_ssk()
    __mptcp_close_ssk()
      mptcp_start_tout_timer()
  mptcp_pm_subflow_retry()
    mptcp_pm_kernel_retry()
      __mptcp_subflow_connect()
        mptcp_stop_tout_timer()

The defaults are subflows 2 and subflow-retries 127. With those, the new
subflow then stays in SYN_SENT for about 4 hours. During that time the msk
stays TCP_ESTABLISHED and the application gets no error.

mptcp.rst now recommends keepalive for detecting dead paths. With this
change, a keepalive timeout would reach the application after about 4
hours instead of about a minute.

Is this change in failure detection intended? Neither the commit message
nor mptcp.rst mentions it, or that setting subflow-retries to 0 turns the
retry off.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8c..f941533a1eb48 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -3501,6 +3506,34 @@ static void mptcp_check_listen_stop(struct sock *sk)
>  	release_sock(ssk);
>  }
>  
> +/* Re-created subflows still connecting are useless once the msk is closed,
> + * and their SYN retransmissions could keep them around for a long time.
> + */
> +static void mptcp_close_retry_subflows(struct sock *sk)
> +{
> +	struct mptcp_subflow_context *subflow, *tmp;
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +
> +	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		int state;
> +
> +		if (!subflow->retry || READ_ONCE(subflow->fully_established))
> +			continue;
> +
> +		/* still connecting, or already disconnected by
> +		 * mptcp_subflow_shutdown(), e.g. after shutdown(SHUT_WR)
> +		 */
> +		state = inet_sk_state_load(ssk);
> +		if (state != TCP_SYN_SENT && state != TCP_CLOSE)
> +			continue;
> +
> +		/* it never carried data: nothing to push or re-inject */
> +		mptcp_pm_subflow_check_next(msk, subflow);
> +		__mptcp_close_ssk(sk, ssk, subflow, 0);

[Severity: High]
Can the subflow finish its handshake and receive data between these
lockless checks and the ssk lock taken inside __mptcp_close_ssk()?

Only the msk socket lock is held here. fully_established and the ssk
state are read without the ssk lock. subflow->closing is only set later,
inside __mptcp_close_ssk().

Holding the msk lock does not keep softirq away from the ssk. In that
window:

softirq
subflow_finish_connect()
  mptcp_finish_join()       <- msk still TCP_ESTABLISHED, since
                               mptcp_close_state() runs later
...
subflow_data_ready()
  mptcp_data_ready()        <- closing == 0, msk owned by user
    __mptcp_move_skbs_from_subflow(msk, ssk, false)
      __mptcp_add_backlog() <- skb on msk->backlog_list, skb->sk == ssk

Because flags is 0, __mptcp_close_ssk() then skips the cleanup that would
clear skb->sk:

	if (flags & MPTCP_CF_PUSH)
		mptcp_cleanup_ssk_backlog(sk, ssk);

It then disposes of the ssk. Once the FIN is acked, the orphaned ssk
reaches tcp_time_wait() or tcp_done() and is freed.

Later, release_sock(sk) at the end of mptcp_close() runs
mptcp_release_cb() and spools the backlog, or mptcp_backlog_purge() runs.
Either way, mptcp_borrow_fwdmem() does:

	atomic_sub(skb->truesize, &ssk->sk_rmem_alloc);

on the freed, and possibly reused, ssk. Is that a use-after-free? The
comment in mptcp_borrow_fwdmem() assumes that "mptcp_close_ssk() already
released the ssk rcv memory", which does not hold on this path.

The same window also lets a subflow that already emitted
MPTCP_EVENT_SUB_ESTABLISHED be closed without MPTCP_EVENT_SUB_CLOSED.

Would passing MPTCP_CF_PUSH, re-checking the state and fully_established
under the ssk lock, or going through mptcp_close_ssk() avoid this?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022151130.2285198-1-anilkaushikwireless%40gmail.com
