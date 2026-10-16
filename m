Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A394054704D
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 05:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792127515; cv=none; b=VSrbwQfCyE7XRyCPpJ6XqL/pLsGx/6uc63gDx4ge8SFSJURjsjtwaQaf4hhE/mYYbS4D+PZnWp1mqjzIUzw7BVklJqUoDNQOJFDgOC7OY53NUdqg4IAaul6OymPwy70mtbYRTeN4zhnTirf0kCh38EzaoJ8WxQY5XZp99rHsJbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792127515; c=relaxed/simple;
	bh=WJEdoTXTkwmATFYGxVT4FSh2yYOLCeIt4L2WiISXvwM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XrUOVb7YEcV38oDWHpt3BZy2xPOWlHPfziIdmxX7VlYwaP40HrV1FLBpWqkEWzPlc+tGtWT4ncDoSevcdM3ZpAHTMPAt6sy+wHgZ6I4dpHdkmRVUzKhbTMB9A50tFAiHJsvQm7XuJMmcwDZLxTe/OBS+kzTwwvihLboJuk3fa+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSuHdytJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSuHdytJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270C51F000C5;
	Fri, 16 Oct 2026 05:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792127514;
	bh=EDZmJX8mRWRA56ddQxm1Q4yQtPA2PW2LJcGFEgQl7rQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hSuHdytJoIT7UiJ8nTLyuYavpqEr4jKOkJzHYE429+ntU2TG9DvtmwHFi8bA81AeO
	 TZj9AY4C0xIoTYBfK2JTZCk1hS/8hOn6GcSPYmKK41AUpWHhTHFGVLUWh2KaTTO/nj
	 b2w3oGb3Hl8DENZlhS0Qiak8b2PR4+ejkdkmeSAH2x4J92YzDIX7Yo3EOvYR5xxdYe
	 8aXwHeVqB28PZe8IjwjQf64pMbnOep3oPqcH8OYGQ+jfIS5fEif5gDh24DB62dY0Tr
	 vzgGMCkjtYoJPAz3w8NUnod5b3mY1YmArJEf+pn8YskhmoRobryo5vn4t/IHMig07R
	 z7hCRJujHl+pg==
Subject: Re: [RFC PATCH mptcp-next v3 2/3] mptcp: pm: kernel: retry subflows
 closed after an error
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Fri, 16 Oct 2026 05:11:53 +0000
Message-ID: <179212751371.3135.9163790784407185905@kernel.org>
In-Reply-To: <20261014143349.768138-3-anilkaushikwireless@gmail.com>
References: <20261014143349.768138-3-anilkaushikwireless@gmail.com>
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

Critical: 0 · High: 1 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit message and the sysctl documentation both say the
  retried subflow's SYN retransmissions space out the attempts, so no…
- [Medium] The window that resets the retry count is measured from when
  the re-created subflow's connect was issued, not from when it became…
- [Medium] When the same-socket retry fails synchronously,
  MPTCP_EVENT_SUB_CLOSED is sent twice for one subflow.
- [Low] MPTCP_SUBFLOW_NO_RETRY is U8_MAX (protocol.h:1269), and the same
  value is a valid attempt count.
- [Low] The sysctl documentation (mptcp-sysctl.rst:163) and the commit
  message say subflows 'reset by the peer without the transient flag ...…

--

mptcp: pm: kernel: retry subflows closed after an error

This patch adds an opt-in sysctl, net.mptcp.subflow_retries. With it, the
in-kernel PM re-creates a locally initiated subflow that TCP closed after
an error, using the same addresses. A failed attempt reuses the same
socket through the new mptcp_subflow_reconnect(). The attempt count
restarts once a re-created subflow has been stable for a minute, and a
new SubflowRetry MIB counter is added.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index d3014bf57bf3..d020e5f69c01 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1591,6 +1591,151 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
>  	return true;
>  }
>  
> +/* a re-created subflow reset sooner counts as a failed attempt */
> +#define MPTCP_PM_RETRY_STABLE	(60 * HZ)
> +
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

[Severity: High]
The commit message says "Its SYN retransmissions space out the attempts,
so no extra state or timer is needed". The sysctl documentation also lists
"an unreachable path" as a case that gets retried. Does that spacing still
hold for the EHOSTUNREACH, ENETUNREACH, EHOSTDOWN and ENETDOWN cases that
mptcp_pm_retry_path_error() accepts?

These errors usually come from an ICMP unreachable or a local ARP failure.
For a socket in TCP_SYN_SENT, tcp_v4_err() aborts right away, with no SYN
retransmission:

net/ipv4/tcp_ipv4.c:tcp_v4_err() {
    ...
	case TCP_SYN_SENT:
	case TCP_SYN_RECV:
		...
		if (!sock_owned_by_user(sk))
			tcp_done_with_error(sk, err);
    ...
}

On the next __mptcp_close_subflow() pass, mptcp_pm_kernel_retry_check()
sets retry->reuse = !established && subflow->retries. Then
mptcp_pm_kernel_retry_reconnect() sends a new SYN immediately.

Can the whole subflow_retries budget be used up within a few RTTs, or
about 3 seconds per attempt with an ARP failure? The commit message
implies it would be spread over the ~127 second SYN timeout.

Synchronous failures seem to end recovery even when budget is left. This
happens if ip_route_connect() in tcp_v4_connect() fails with -ENETUNREACH,
or if pre_connect or kernel_bind() fails.

On the reuse path, mptcp_pm_kernel_retry_reconnect() returns false and
__mptcp_close_subflow() calls mptcp_close_ssk(). The replacement is then
skipped because retry.reuse is set:

		mptcp_close_ssk(sk, ssk, subflow);
		if (do_retry && !retry.reuse)
			mptcp_pm_kernel_retry(msk, &retry);

On the new-socket path, __mptcp_subflow_connect() fails and
mptcp_pm_kernel_retry() just returns.

The regular in-kernel PM does not recover either, because
select_local_address() skips IDs that are not set in
msk->pm.id_avail_bitmap:

	if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
		continue;

Take outages such as a gateway going down, or an upstream router sending
host-unreachable. Would connections still stay on the backup path for
good, which is the case the commit message says this fixes? Is a deferred
retry with some backoff needed here?

> +
> +/* A subflow initiated by this side and closed by TCP after an error can be
> + * re-created with the same addresses, see the 'subflow_retries' sysctl. The
> + * SYN retransmissions of the new subflow space out the attempts. Called with
> + * the msk socket lock held, before the subflow is closed.
> + */
> +bool mptcp_pm_kernel_retry_check(struct mptcp_sock *msk,
> +				 const struct mptcp_subflow_context *subflow,
> +				 struct mptcp_pm_retry *retry)
> +{

[ ... ]

> +	/* removed address, see mptcp_pm_rm_addr_or_subflow() */
> +	if (subflow->retries == MPTCP_SUBFLOW_NO_RETRY)
> +		return false;

[Severity: Low]
Can a real attempt count collide with this sentinel?
MPTCP_SUBFLOW_NO_RETRY is U8_MAX. The subflow_retries entry in
mptcp_sysctl_table in ctrl.c sets no extra1/extra2, so
proc_dou8vec_minmax() accepts 255.

With subflow_retries=255, a check with retries=254 passes. Then
mptcp_pm_kernel_retry_reconnect() or mptcp_pm_kernel_retry() stores:

	subflow->retries = retry->retries + 1;

which is 255.

Suppose that re-created subflow then stays established for more than a
minute and later fails. mptcp_pm_kernel_retry_check() returns false here,
before the stability-based restart logic runs, so the subflow is never
retried again.

Would bounding the sysctl with an extra2 below U8_MAX, or using a separate
flag for the removed address case, avoid this?

> +
> +	/* The peer asked not to use this path again (MP_RST without the T
> +	 * flag), the subflow has been aborted locally, or it hit an MPTCP
> +	 * protocol error.
> +	 */
> +	if ((subflow->reset_seen && !subflow->reset_transient) ||
> +	    err == ECONNABORTED || err == EBADMSG)
> +		return false;

[Severity: Low]
The sysctl documentation and the commit message say that subflows "reset
by the peer without the transient flag" are not retried. Does this check
match that?

subflow->reset_seen is only set when mptcp_incoming_options() parses an
MP_TCPRST option:

		if (mp_opt.suboptions & OPTION_MPTCP_RST) {
			subflow->reset_seen = 1;

A plain TCP RST without MP_TCPRST leaves reset_seen at 0 and sets err to
ECONNRESET. For an established subflow, mptcp_pm_retry_path_error() is not
consulted, so the subflow gets retried.

Should the documentation say "MP_RST without the T flag", like the code
comment does? Or should a plain RST be treated as non-transient?

[ ... ]

> +	/* Count the attempts from scratch only if the path worked for a
> +	 * while: a re-created subflow reset soon after its creation counts
> +	 * as a failed attempt.
> +	 */
> +	retry->retries = subflow->retries;
> +	if (established &&
> +	    (!subflow->retries ||
> +	     (u32)(tcp_jiffies32 - subflow->retry_stamp) >=
> +	     MPTCP_PM_RETRY_STABLE))
> +		retry->retries = 0;

[Severity: Medium]
Does this measure how long the subflow stayed established?
mptcp_pm_kernel_retry() and mptcp_pm_kernel_retry_reconnect() set
retry_stamp when the SYN is sent. The field comment in protocol.h calls it
the "creation of a re-created subflow".

The documentation says "The count starts again once a re-created subflow
stayed established for a minute". Here, though, the handshake time counts
toward that minute.

For example, with the default tcp_syn_retries=6, the last SYN
retransmission goes out about 63 seconds after the stamp. Say that SYN is
answered and the subflow is then closed quickly by a retryable error, such
as a plain RST. This check sees more than 60 seconds and resets the count
to 0.

On a path that flaps like this, could net.mptcp.subflow_retries stop
limiting the number of re-creations? Would recording a timestamp when the
subflow becomes fully established match the documented behaviour better?

[ ... ]

> +/* Called with the msk socket lock held, instead of closing the subflow */
> +bool mptcp_pm_kernel_retry_reconnect(struct mptcp_sock *msk, struct sock *ssk,
> +				     const struct mptcp_pm_retry *retry)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +	struct sock *sk = (struct sock *)msk;
> +
> +	/* like mptcp_close_ssk() does for the failed attempt */
> +	mptcp_event(MPTCP_EVENT_SUB_CLOSED, msk, ssk, GFP_KERNEL);
> +
> +	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_SUBFLOWRETRY);
> +	if (mptcp_subflow_reconnect(sk, ssk, &retry->local, &retry->remote))
> +		return false;

[Severity: Medium]
Can MPTCP_EVENT_SUB_CLOSED be sent twice for the same subflow when the
reconnect fails synchronously?

mptcp_subflow_reconnect() first runs tcp_disconnect(), which always
returns 0 and sets inet_dport to 0. It then calls
mptcp_subflow_ctx_reset(), which clears close_event_done and backup.
After that, subflow_set_local_id() gives local_id a valid value.

pre_connect() or sk_prot->connect() can fail after that, for example with
-ENETUNREACH from ip_route_connect() or a BPF cgroup rejection. In that
case this function returns false and __mptcp_close_subflow() falls through
to mptcp_close_ssk(). The guard there no longer stops it:

	if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
		return;

	subflow->close_event_done = true;

	if (sk->sk_state == TCP_ESTABLISHED)
		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);

The second event is built from a socket with dport 0 and the backup bit
cleared. Would userspace PM listeners then see one subflow closed twice,
the second time with wrong attributes?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014143349.768138-1-anilkaushikwireless%40gmail.com
