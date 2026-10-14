Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8658568535
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999306; cv=none; b=MiLEV5DDk3y7A4Ps1ZN7y0Oudj4XbksrR5ehg7Fb1NXUSq0Df6Kh9G3JxD4FG1OHaANGEtNJ9QmJ6NBJ8uwrq+bYvjGk/MSh0mF3evLJKrsutdtcbVUQiJtvaVG5rCcKvBSiQ0ot1JTT0lshhfKzi4Wp3ll+y71pZ4fiQ8QP94s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999306; c=relaxed/simple;
	bh=hYHFNuRGR6YvW9Aa19Bq/9kv6AIk6AvjrRAOf/JlIGg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X3q//yV3IX6JhlrUMbNBmWv0Y/t6vqHJoPpLjzK3C46JjIbWqCtMrIPAWoc7Pytc8XlrJg81ZP03zazL8BGwYPksNzY2tOmBTHX9hcRCsuTHUVzNMlzqyc8z3ozT/+cCkaQUj17aABMCYwx/gEPwGp0mowbANW6zfNIQYgoPZP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtsoovDH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtsoovDH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06E71F000C4;
	Wed, 14 Oct 2026 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791999296;
	bh=fmvc78/wSkZEHWy2Fxviv4RpOJhfEpx1rnsKDtS+h+E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CtsoovDHNaKF95pvBQDY7u7RQ24gWc27plUoXBYcUlKTEP8Lw7sy2nsveVwge5VlV
	 JtqEcHvueFeqcH2wryfBA8dCJEQkUh9U+j96UecoE8qqo1uxcKM+tAz5FmghpNXysK
	 T+Fc8q9pnaoFhcMPhT9X6WBn/3nrwQSNjcmAaV9VMxsPTwpQlRd/zLKrMR2AMGuNaA
	 +OnykWurQKOdZQCfJqmK4/S8oAhc0NbzLlQu4JbNnO+o+SgflUheUFOrrEcVVoEOYi
	 t8ofpfnRElCIKMAPfBt61A0Im1LSuIEY4qYuvYUw2V8cm55/5TI0RCmIi6uCNpUeE+
	 MRuFr3vFM0EhA==
Subject: Re: [RFC PATCH mptcp-next v2 2/3] mptcp: pm: kernel: retry subflows
 closed after an error
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Wed, 14 Oct 2026 17:34:56 +0000
Message-ID: <179199929617.3135.4571363814787884121@kernel.org>
In-Reply-To: <20261013025653.523755-3-anilkaushikwireless@gmail.com>
References: <20261013025653.523755-3-anilkaushikwireless@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 4 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] For a subflow that reached fully_established,
  mptcp_pm_kernel_retry_check() accepts any non-zero sk_err, because the…
- [Medium] The commit message says the SYN retransmissions of the new
  subflow space out the attempts, so no extra state or timer is needed.
- [Medium] Failed subflow attempts are reported differently depending on
  which retry path handles them.
- [Medium] mptcp_subflow_reconnect() calls ssk->sk_prot->connect()
  directly after tcp_disconnect() and never calls sk_prot->pre_connect().
- [Medium] mptcp_pm_kernel_retry_check() builds the new subflow's local
  backup request from `subflow->request_bkup || subflow->backup`.
- [Low] Re-creating the client's initial MP_CAPABLE subflow needs a free
  extra-subflow slot, and the motivating main-link/backup example does…

--

mptcp: pm: kernel: retry subflows closed after an error

This adds an opt-in net.mptcp.subflow_retries sysctl. When it is set, the
in-kernel PM re-creates locally initiated subflows that TCP closed after an
error, using the same addresses. Failed attempts reuse the same socket
through a new mptcp_subflow_reconnect() helper, and a new SubflowRetry MIB
counter tracks the attempts.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index d3014bf57bf3c..c9199727c88cc 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1591,6 +1591,122 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
>  	return true;
>  }
>  
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

[Severity: Medium]
The commit message says:

    Its SYN retransmissions space out the attempts, so no extra state or
    timer is needed. If it cannot connect, the same socket is used for the
    next attempt.

The subflow_retries documentation says the same and points to
tcp_syn_retries. Is that true for any error other than ETIMEDOUT?

EHOSTUNREACH, ENETUNREACH, EHOSTDOWN and ENETDOWN usually come from ICMP.
In SYN_SENT, tcp_v4_err() aborts the connect as soon as the ICMP arrives:

net/ipv4/tcp_ipv4.c:tcp_v4_err() {
    ...
		if (!sock_owned_by_user(sk))
			tcp_done_with_error(sk, err);
    ...
}

So the SYN is never retransmitted with backoff. The worker then runs
__mptcp_close_subflow() and reconnects right away.

During an outage, wouldn't each attempt fail within about one RTT? The
whole subflow_retries budget would then be used up in a few RTTs.

A synchronous connect failure also seems to end the retry chain. For
example, tcp_v4_connect() returns -ENETUNREACH from the route lookup when
no route exists while the link is down:

net/ipv4/tcp_ipv4.c:tcp_v4_connect() {
    ...
	if (IS_ERR(rt)) {
		err = PTR_ERR(rt);
		if (err == -ENETUNREACH)
			IP_INC_STATS(net, IPSTATS_MIB_OUTNOROUTES);
		return err;
	}
    ...
}

On the fresh socket path, mptcp_pm_kernel_retry() just returns when
__mptcp_subflow_connect() fails.

On the reuse path, mptcp_pm_kernel_retry_reconnect() returns false and
__mptcp_close_subflow() falls through to mptcp_close_ssk(). Because
retry.reuse is true, mptcp_pm_kernel_retry() is not called either.

No retry state is left anywhere in that case. Is the path ever re-created
once it recovers, even when budget is still left?

> +
> +/* A subflow initiated by this side and closed by TCP after an error can be
> + * re-created with the same addresses, see the 'subflow_retries' sysctl. The
> + * SYN retransmissions of the new subflow space out the attempts. Called with
> + * the msk socket lock held, before the subflow is closed.
> + */

[ ... ]

> +	/* A subflow that never got established is retried only after network
> +	 * errors: if the peer rejected it, trying again will not help.
> +	 */
> +	if (!established && !mptcp_pm_retry_path_error(err))
> +		return false;
> +
> +	/* Only re-create subflows initiated by this side: MP_JOIN ones, or the
> +	 * initial one on the client side.
> +	 */
> +	if (!subflow->request_join &&
> +	    (subflow->mp_join || READ_ONCE(msk->pm.server_side)))
> +		return false;
> +
> +	/* the path worked for a while: count the attempts from scratch */
> +	retry->retries = established ? 0 : subflow->retries;

[Severity: High]
For a fully established subflow, any non-zero sk_err passes the error
check above, and the attempt count is reset to 0. Can this turn into an
unbounded reconnect loop?

ECONNRESET from a peer RST or MP_RST would go down this path. So would
ECONNABORTED from a local ss -K or bpf_sock_destroy, through
tcp_abort() -> tcp_done_with_error():

__mptcp_close_subflow()
  mptcp_pm_kernel_retry_check()    /* retries = 0 */
  mptcp_close_ssk()                /* frees the extra_subflows slot */
  mptcp_pm_kernel_retry()
    __mptcp_subflow_connect()      /* no delay */

A peer, or an on-path attacker able to inject an in-window RST, could
accept each MP_JOIN, let it become fully established, and then reset it.
The client would then reconnect every RTT, and the subflow_retries cap
would never apply.

This check also ignores subflow->reset_seen and subflow->reset_transient,
which mptcp_incoming_options() already records from MP_RST. Per RFC 8684,
a subflow reset with T=0 should not be re-established on that path.

Should a non-transient MP_RST, or a local administrative abort, be
excluded from the retry?

> +	/* a failed attempt is retried with the same socket */
> +	retry->reuse = !established && subflow->retries;
> +	if (retry->retries >= mptcp_subflow_retries(sock_net(sk)))
> +		return false;

[ ... ]

> +	mptcp_local_address((struct sock_common *)ssk, &retry->local.addr);
> +	retry->local.addr.port = 0;
> +	retry->local.addr.id = subflow_get_local_id(subflow);
> +	retry->local.flags = subflow->request_bkup || subflow->backup ?
> +			     MPTCP_PM_ADDR_FLAG_BACKUP : 0;

[Severity: Medium]
Is subflow->backup the right input here? It holds the peer's backup flag.
subflow_finish_connect() sets it from the SYN-ACK, and
mptcp_pm_mp_prio_received() sets it from a received MP_PRIO. The local
preference is request_bkup.

Both __mptcp_subflow_connect() and mptcp_subflow_reconnect() turn
MPTCP_PM_ADDR_FLAG_BACKUP into request_bkup, which is sent as the MP_JOIN
B bit. A subflow that only the peer marked as backup would therefore be
re-created with request_bkup=1.

The local side would then advertise a backup preference that was never
configured for the endpoint. The local scheduler would also keep treating
the path as backup, even after the peer clears its own flag with MP_PRIO
B=0.

Should this use only subflow->request_bkup?

> +	retry->local.ifindex = ssk->sk_bound_dev_if;
> +
> +	return true;
> +}

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
> +	allowed = msk->pm.extra_subflows < mptcp_pm_get_limit_extra_subflows(msk);
> +	if (allowed)
> +		msk->pm.extra_subflows++;
> +	spin_unlock_bh(&msk->pm.lock);
> +
> +	if (!allowed)
> +		return;

[Severity: Low]
mptcp_pm_kernel_retry_check() explicitly allows retrying the client's
initial subflow. When that MP_CAPABLE subflow closes,
mptcp_pm_subflow_check_next() does not decrement pm.extra_subflows:

net/mptcp/pm.c:mptcp_pm_subflow_check_next() {
    ...
	update_subflows = subflow->request_join || subflow->mp_join;
    ...
}

Its MP_JOIN replacement therefore needs a free extra-subflow slot. What
happens when the existing MPJ subflows already use the whole
limit_extra_subflows quota? One example is a limit of 1 with one backup
endpoint.

mptcp_pm_kernel_retry_check() would accept the initial subflow, but this
check would then return without retrying. The connection would stay on the
backup, which is the main-link/backup case the commit message describes.

Could the documentation say that replacing the initial subflow uses an
extra subflow slot?

> +
> +	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_SUBFLOWRETRY);
> +	if (__mptcp_subflow_connect(sk, &retry->local, &retry->remote))
> +		return;

[ ... ]

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 60cbd91be6320..f29cfd2ad69b9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -2827,7 +2829,14 @@ static void __mptcp_close_subflow(struct sock *sk)
>  		if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
>  			continue;
>  
> +		do_retry = mptcp_pm_kernel_retry_check(msk, subflow, &retry);
> +		if (do_retry && retry.reuse &&
> +		    mptcp_pm_kernel_retry_reconnect(msk, ssk, &retry))
> +			continue;

[Severity: Medium]
When a fresh socket attempt fails, mptcp_close_ssk() runs and emits
MPTCP_EVENT_SUB_CLOSED, since the msk is TCP_ESTABLISHED:

net/mptcp/protocol.c:mptcp_close_ssk() {
    ...
	if (sk->sk_state == TCP_ESTABLISHED)
		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
    ...
}

When later attempts fail and take the reuse path, this continue skips
mptcp_close_ssk(). mptcp_subflow_reconnect() then resets the context and
assigns a new subflow_id without sending a SUB_CLOSED event.

Will userspace event listeners miss those failed attempts?

The MIB counters also look inconsistent. mptcp_subflow_reconnect() counts
MPTCP_MIB_JOINSYNTX on success:

	if (!err)
		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTX);

But unlike __mptcp_subflow_connect(), it does not count
MPTCP_MIB_JOINSYNTXCONNECTERR when the connect fails.

> +
>  		mptcp_close_ssk(sk, ssk, subflow);
> +		if (do_retry && !retry.reuse)
> +			mptcp_pm_kernel_retry(msk, &retry);
>  	}

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 78e886b202585..0f1d3fae446e2 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

[ ... ]

> +	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
> +	addrlen = sizeof(struct sockaddr_in);
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	if (addr.ss_family == AF_INET6)
> +		addrlen = sizeof(struct sockaddr_in6);
> +#endif
> +	err = ssk->sk_prot->connect(ssk, (struct sockaddr_unsized *)&addr, addrlen);

[Severity: Medium]
This calls sk_prot->connect() directly without running
sk_prot->pre_connect() first. Are the cgroup BPF connect4/connect6
programs skipped for every reused socket attempt?

__mptcp_subflow_connect() goes through kernel_connect() ->
__inet_stream_connect(), which runs the hook:

net/ipv4/af_inet.c:__inet_stream_connect() {
    ...
		if (BPF_CGROUP_PRE_CONNECT_ENABLED(sk)) {
			err = sk->sk_prot->pre_connect(sk, uaddr, addr_len);
    ...
}

mptcp_connect() also calls it explicitly before its own direct
sk_prot->connect():

net/mptcp/protocol.c:mptcp_connect() {
    ...
	if (BPF_CGROUP_PRE_CONNECT_ENABLED(ssk)) {
		err = ssk->sk_prot->pre_connect(ssk, uaddr, addr_len);
    ...
}

Subflow sockets inherit the msk's cgroup. With subflow_retries >= 2, a
connect4/connect6 program that applies deny policy, accounting or backend
selection would never see the second and later attempts.

> +
> +out:
> +	release_sock(ssk);
> +	if (!err)
> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTX);
> +	return err;
> +}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013025653.523755-1-anilkaushikwireless%40gmail.com
