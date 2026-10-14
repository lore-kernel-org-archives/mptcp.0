Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390152DCF46
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791963113; cv=none; b=CoXNbIuQjOB0/Z+P4lAjz6ZQ8kVl+jqni/jqKpoOd+Kuz18zEdsMbS1x7k8JX4xxQn2TI0pv6o8hUGK0tOpr//aVQTMljHIGmG0JBjqJ1up1Go8AI7pVT2TMCV7MQcqH4hdbvYJZvCJPtqUsbZZccjTjZHO1t90vPl4c1Whr+q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791963113; c=relaxed/simple;
	bh=GHAF+Kz6FZUp9RNZ+lB9eyqQ9zsJpCOO7HROZ0kM3Wo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=poD2nEsQ++M3b2sxH8MIj/zQgqDEHaxXEu9TaQVjbKmAGPciFIB3Qb5NzcaPrvZqXwdVvpCkt1pc5IzYQdTtkJNmMCByMZkbfs1eXFNDvuIxpzPeql2d6FKRyeva7E1AgUy/3ZPo/S7IsEAlLc3nrA0gzdXUBgpKaOONKeI0wCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kG5afwsT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kG5afwsT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2AA1F00893;
	Wed, 14 Oct 2026 07:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791963112;
	bh=wlsJdnYl2TfA9hzdcfcCOPPEcfb4A6Epzq8xmJq1oQ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kG5afwsTS1V7GyLWviZLUG2grJnwXo6FSDPJ31FU+5SUHE2jvpm6ZvODCYTGSmErE
	 15ptXjF08tSoa6tPvPuo8XKLfc8KuTUpq29bTFyRaxZOYWDihZtrYYF2+LasN3LPYk
	 J8NGH7T/w/9JF7U+6ST7j6gtlX/7hlddenh3/TbsTGuZZhAnsqCH33Z0Kmq9heOKhL
	 Cb8WFTIWHcujP90g7+ZMxnQ7GygLfjiOT5/4Rh9td2JdTbDYJNYzkQ4oXoGFArdoZa
	 o1oWGKfavfe/1bRxwKucbT+ngyHTAt/tbYqZmlqqPig0sMQ+dL/5cnZ0SEhkKSwtXD
	 20EW24mNp9H4w==
Subject: Re: [RFC PATCH mptcp-next 2/3] mptcp: pm: kernel: retry subflows
 closed after an error
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Wed, 14 Oct 2026 07:31:51 +0000
Message-ID: <179196311139.3135.7935197809108211658@kernel.org>
In-Reply-To: <20261012171740.464517-3-anilkaushikwireless@gmail.com>
References: <20261012171740.464517-3-anilkaushikwireless@gmail.com>
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

Critical: 0 · High: 1 · Medium: 4 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch inserts MPTCP_PM_SUBFLOW_RETRY into the middle of
  enum mptcp_pm_status (net/mptcp/protocol.h:201-213).
- [Medium] mptcp_pm_retry_add() only filters by errno when the subflow
  never became fully established: `if (!established &&…
- [Medium] mptcp_pm_retry_add() counts every entry on msk->pm.retry_list,
  disabled ones included, and stops creating entries once…
- [Medium] mptcp_pm_retry_arm() reads the sysctl again on every call and
  arms the timer at `jiffies + min(timeout, max)`.
- [Medium] mptcp_pm_retry_add() matches an existing entry whether or not
  it is disabled, then sets `entry->disabled = false` and re-arms it.

--

mptcp: pm: kernel: retry subflows closed after an error

This adds an opt-in per-netns sysctl, net.mptcp.subflow_retry_timeout.
When it is set, the in-kernel PM re-creates subflows closed after an
error, using the same addresses and an exponential backoff capped by the
sysctl value. Retry state is kept per msk in a new retry_list, disabled
on endpoint or remote address removal, and freed in mptcp_pm_destroy().

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index d7c5b50b34cc9..2683e359695cd 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c

[ ... ]

> @@ -493,6 +509,250 @@ static void mptcp_pm_free_announced_list(struct mptcp_sock *msk)

[ ... ]

> +/* To be called while pm->lock is held */
> +static void mptcp_pm_retry_arm(struct mptcp_sock *msk,
> +			       struct mptcp_pm_retry *entry)
> +{
> +	unsigned long max = mptcp_subflow_retry_timeout(sock_net((struct sock *)msk));
> +	unsigned long timeout = TCP_TIMEOUT_INIT << min_t(u8, entry->attempts, 16);
> +
> +	entry->pending = false;
> +	entry->timer_done = false;
> +	if (entry->attempts < U8_MAX)
> +		entry->attempts++;
> +
> +	sk_reset_timer((struct sock *)msk, &entry->timer,
> +		       jiffies + min(timeout, max));
> +}

[Severity: Medium]
What happens here if net.mptcp.subflow_retry_timeout is set back to 0
while retry entries already exist? The documentation says "0 disables
the retries", but only mptcp_pm_retry_add() checks the sysctl for zero.

Timers that are already armed still fire. mptcp_pm_retry_timer() then
schedules MPTCP_PM_SUBFLOW_RETRY without looking at the sysctl, and
mptcp_pm_retry_subflows() re-arms the entry in two cases:

    if (msk->pm.extra_subflows >= mptcp_pm_get_limit_extra_subflows(msk)) {
        mptcp_pm_retry_arm(msk, entry);
    ...
    if (__mptcp_subflow_connect(sk, &local, &remote)) {
        ...
        mptcp_pm_retry_arm(msk, entry);

With max == 0, min(timeout, max) is 0, so the timer expires on the next
tick.

Can this loop every jiffy for each entry (up to 8 per msk)? It would
keep going while the limit is reached or __mptcp_subflow_connect() keeps
failing synchronously, for example when kernel_bind() fails because the
endpoint address is gone. In the connect failure case, each pass
creates, binds and releases a socket.

Also, proc_dointvec_jiffies has no bounds for this entry. Would a
negative write be stored as a large unsigned value that counts as
enabled?

[ ... ]

> +static void mptcp_pm_retry_add(struct mptcp_sock *msk,
> +			       const struct mptcp_subflow_context *subflow)
> +{

[ ... ]

> +	if (!err || !mptcp_subflow_retry_timeout(sock_net(sk)))
> +		return;
> +
> +	/* A subflow that never got established is retried only after network
> +	 * errors: if the peer rejected it, trying again will not help.
> +	 */
> +	if (!established && !mptcp_pm_retry_path_error(err))
> +		return;

[Severity: Medium]
Should established subflows be filtered here too? Once a subflow has
been fully established, any non-zero sk_err passes this check.
subflow->reset_seen, reset_transient and reset_reason are never looked
at.

mptcp_incoming_options() records the peer's MP_RST flags:

    subflow->reset_seen = 1;
    subflow->reset_reason = mp_opt.reset_reason;
    subflow->reset_transient = mp_opt.reset_transient;

So a subflow the peer reset with T=0 would be re-created over the same
path. RFC 8684 section 3.6 says the receiver should not do that when the
T flag is clear.

Subflows this host resets itself for fatal protocol errors also pass.
subflow_check_data_avail() sets reset_transient = 0, a reset_reason of
MPTCP_RST_EMIDDLEBOX or MPTCP_RST_EMPTCP, and sk_err = EBADMSG.

Since established also resets the backoff further down:

    if (established)
        entry->attempts = 0;

could a path where a middlebox or the peer kills the subflow after
establishment get retried about every TCP_TIMEOUT_INIT (1s) for the life
of the connection?

The commit message says "A subflow the peer refused is not retried", and
the documentation mentions "a timeout or an unreachable path". Neither
seems to match this behaviour.

[ ... ]

> +	list_for_each_entry(entry, &msk->pm.retry_list, list) {
> +		if (mptcp_addresses_equal(&entry->local.addr, &local, false) &&
> +		    mptcp_addresses_equal(&entry->remote, &remote, true))
> +			goto found;
> +		nr++;
> +	}
> +
> +	if (nr >= MPTCP_PM_RETRY_MAX)
> +		goto unlock;

[Severity: Medium]
Does this count disabled entries against MPTCP_PM_RETRY_MAX? Entries are
only freed in mptcp_pm_free_retry_list() at destroy time.
mptcp_pm_retry_disable() only marks them disabled, and a successful
recovery doesn't remove an entry either.

Take a long-lived connection with address churn, such as an endpoint
removed and re-added with a new IP, or RM_ADDR/ADD_ADDR from the peer.
Or take a fullmesh setup with more than 8 local/remote pairs (the kernel
PM allows up to MPTCP_PM_SUBFLOWS_MAX = 64 subflows).

Would every failing pair after the 8th silently get no retries? The
commit message and the documentation don't mention this limit.

[ ... ]

> +found:
> +	/* the path worked for a while: restart the backoff */
> +	if (established)
> +		entry->attempts = 0;
> +
> +	entry->local.addr = local;
> +	entry->local.flags = subflow->request_bkup || subflow->backup ?
> +			     MPTCP_PM_ADDR_FLAG_BACKUP : 0;
> +	entry->local.ifindex = ssk->sk_bound_dev_if;
> +	entry->remote = remote;
> +	entry->disabled = false;

[Severity: Medium]
Can this re-enable an entry that an address or endpoint removal has just
disabled?

mptcp_pm_rm_addr_or_subflow() disables the entries first, then skips
subflows that are already in TCP_CLOSE:

    if (rm_type == MPTCP_MIB_RMADDR)
        mptcp_pm_retry_disable(msk, NULL, rm_id);

    mptcp_for_each_subflow_safe(msk, subflow, tmp) {
        ...
        if ((1 << inet_sk_state_load(ssk)) &
            (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING | TCPF_CLOSE))
            continue;

Endpoint removal through mptcp_nl_remove_subflow_and_signal_addr() or the
flush path also calls mptcp_pm_retry_disable() and then
mptcp_pm_rm_subflow(), which goes through the same loop.

A subflow that died with ECONNRESET or ETIMEDOUT stays in TCP_CLOSE until
mptcp_worker() calls __mptcp_close_subflow(). That runs after
mptcp_pm_worker() in the same pass, and it can be deferred further while
ssk->sk_receive_queue is not empty.

The later call chain:

mptcp_close_ssk()
  mptcp_pm_subflow_check_next()
    mptcp_pm_retry_add()

then finds the disabled entry (or creates a new one), clears disabled
and re-arms the timer.

Would the PM then keep re-creating subflows towards a remote address ID
the peer withdrew, or from a local endpoint that was deleted? That seems
to contradict "Retries stop when the endpoint or the peer's address is
removed" in the commit message.

[ ... ]

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index ed2f363bb915c..d1ff62d1f9435 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -204,6 +204,7 @@ enum mptcp_pm_status {
>  	MPTCP_PM_RM_ADDR_RECEIVED,
>  	MPTCP_PM_ESTABLISHED,
>  	MPTCP_PM_SUBFLOW_ESTABLISHED,
> +	MPTCP_PM_SUBFLOW_RETRY,
>  	MPTCP_PM_ALREADY_ESTABLISHED,	/* persistent status, set after ESTABLISHED event */
>  	MPTCP_PM_MPC_ENDPOINT_ACCOUNTED, /* persistent status, set after MPC local address is
>  					  * accounted int id_avail_bitmap

[Severity: High]
Does this new enumerator push MPTCP_PM_DESTROYING out of the range of
pm.status?

After this insertion, MPTCP_PM_MPC_ENDPOINT_ACCOUNTED becomes 7 and
MPTCP_PM_DESTROYING becomes 8. struct mptcp_pm_data still has:

    u8		status;

So in mptcp_pm_destroy():

    msk->pm.status |= BIT(MPTCP_PM_DESTROYING);

BIT(8) is truncated and nothing is set. Every test of
status & BIT(MPTCP_PM_DESTROYING) then reads 0. That includes
mptcp_pm_announced_alloc(), mptcp_userspace_pm_append_new_local_addr(),
and the new checks in mptcp_pm_retry_timer() and mptcp_pm_retry_add().

Doesn't this silently undo the teardown fence added by commit
efc33b5102ff ("mptcp: pm: fix memory leak from alloc-during-teardown
race")?

A userspace PM MPTCP_PM_CMD_ANNOUNCE that races with close() or
disconnect() could again add entries after mptcp_pm_destroy() has
spliced and freed the lists. That covers mptcp_pm_add_addr entries (with
an armed timer) and mptcp_pm_addr_entry entries, and they would be
leaked. The command only needs CAP_NET_ADMIN in the user namespace that
owns the netns.

The later patches in this series only touch the selftests, so nothing
else in the series seems to address this. Should status be widened to
hold the extra bit?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012171740.464517-1-anilkaushikwireless%40gmail.com
