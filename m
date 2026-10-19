Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792431979;
	b=UFhuF+5mFyWyFRqDXcULEQiSiKE4CKkDqsHduuvGehDlh/tcyrbNqGnEFvxr6SJi/QmA
	 0OiRGpOk/gxxHt7meEVTgVgGvDJRPgqDbGeHkeqDW3i8kZeJah8byTtkGmAD5+Ks2bETY
	 qsUZpPDfDu4oFKR+JSTKhO3knyynqH4Ee1DTQ/GsjVvLzyO0iVRfTUzikmpoYyRUXulaj
	 EBHgJRf0/UsqDfnXTXupEM2Oh5vqiN6/SSrHGx1Mw7gO3mxvjSrolGXH1LZLzfZ7CYRRP
	 Lx43Z8ralqI1qAzfOULboPPZaPw/L2l/zRR/il/VZdDeDZPaxkfkmtuwjNCZ9q9Zezg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431979;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pBwXLkPBpd+s+uZi3lVSPssezaPGF9pGk78WvpeF1aY=;
	b=1u/xMCmEWGye1W+MHvXrZVZD0apO5VuQf+fiS6lfmcVekjA0cAAH6UkdxtNn3m1X0Vzt
	 wFChMJWk6c77QfyYJsUmqKzqIIiCdX0p44uW7qfMcLY0a+L4yrqNCwh6LZhZLDabFsjjr
	 TAqGMDylFr1LNuqGFm5+7Krl6Vh+Ya0Xe9yny4lbIE5Begw8OeUYoEnlSeTv5kcTf8Ysh
	 p3bVSTQJHAIFr+Lrn3CiFsRZ0qydVL3DTRehZw+0gXdcFILo3rqSTaq4WCLRC0tJFmzYT
	 PHPtDkErGrlY9jnNPtOoa5a9aBLiCvUxGyVDWCmnEs3Ujs5AlrczU9WfKCpcN1N2rgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVGNuxnv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762FC606A32D
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVGNuxnv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87641F000C7;
	Mon, 19 Oct 2026 17:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792431979;
	bh=pBwXLkPBpd+s+uZi3lVSPssezaPGF9pGk78WvpeF1aY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DVGNuxnv+rf+khdIeE0GnEFRJ3UX7lgPzZsIi/LuUbSqsB1+FXaxXolZ2mszI6oqY
	 VCgYyvtV/K7qgAk4AWkWDmHKwl2A4R77SzzsCphSUgV7Bc4v78XuvnUYrRcP74s9Y0
	 VgxCnat5PGGD6Rxfh2OzwlQM9z6c4VeHrkhSZYd/hRgdPxXn6p/L9bGxiIl7q71dpO
	 kkL9Qqsu1AmGzrw+fCpEGxsxa05cbs5p11gtAxFlPxibrbp/sR/hpdT0hSW6rpWjfY
	 utILI5xjL7IxwzMpB3l0I7rypXdi3A+3shIUc5MMd6xc/CT4FN5TDiGerPjTvQoSif
	 ChrLtjN6GxITg==
Subject: Re: [PATCH mptcp-next v6 4/6] mptcp: pm: in-kernel: retry subflows
 closed after an error
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 19 Oct 2026 17:46:18 +0000
Message-ID: <179243197845.3133.2892670749344813139@kernel.org>
In-Reply-To: <20261018041748.1655711-5-anilkaushikwireless@gmail.com>
References: <20261018041748.1655711-5-anilkaushikwireless@gmail.com>
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

Critical: 0 · High: 0 · Medium: 4 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] A remote peer can keep the in-kernel PM in an endless subflow
  re-creation loop, with no backoff.
- [Medium] mptcp_pm_rm_addr_or_subflow() (net/mptcp/pm.c) now loads the
  subflow TCP state twice without the ssk lock.
- [Medium] The new `no_retry:1` and `retry:1` bitfields share a byte with
  `reset_seen:1`, `reset_transient:1` and `reset_reason:4` in struct…
- [Medium] mptcp: pm: in-kernel: missing subflow->resetting check in
  mptcp_pm_kernel_retry_check()

--

mptcp: pm: in-kernel: retry subflows closed after an error

With the in-kernel PM, this patch re-creates a subflow initiated by this
side when TCP closes it after an error, as long as it had been fully
established. The SYN retries of the new subflow come from the
subflow-retries limit, and re-created subflows still connecting are closed
when the MPTCP socket is closed. Subflows reset with a non-transient MP_RST,
aborted locally, or using a removed address are not retried.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index d7c5b50b34cc9..54d94bc729630 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c

[ ... ]

> @@ -762,6 +782,24 @@ static void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
>  	mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
>  }
>  
> +/* A subflow closed by TCP but not collected yet must not be re-created with
> + * a removed address, see mptcp_pm_kernel_retry_check().
> + */
> +static void mptcp_pm_rm_no_retry(struct mptcp_subflow_context *subflow,
> +				 enum linux_mptcp_mib_field rm_type, u8 rm_id)
> +{
> +	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +	u8 id;
> +
> +	if (rm_type == MPTCP_MIB_RMADDR)
> +		id = READ_ONCE(subflow->remote_id);
> +	else
> +		id = subflow_get_local_id(subflow);
> +
> +	if (id == rm_id && inet_sk_state_load(ssk) == TCP_CLOSE)
> +		subflow->no_retry = 1;

[Severity: Medium]
Is this plain bitfield write safe without the ssk lock?

In struct mptcp_subflow_context, the new retry and no_retry bits share a
byte with the reset_* bits:

	u8	reset_seen:1;
	u8	reset_transient:1;
	u8	reset_reason:4;
	u8	retry:1;	    /* re-created after an error */
	u8	no_retry:1;	    /* closed, with a removed address */

mptcp_pm_rm_no_retry() does a read-modify-write of that byte while holding
only the msk socket lock and pm.lock. Before this patch, every writer of
this byte ran under the ssk lock.

Seeing TCP_CLOSE doesn't seem to mean that the ssk side has stopped writing.
tcp_done() publishes TCP_CLOSE first and then calls sk->sk_state_change():

tcp_done()
  tcp_set_state(sk, TCP_CLOSE)
  sk->sk_state_change(sk)
    subflow_state_change()
      mptcp_subflow_data_available()
        subflow_check_data_avail()

When data is still queued and the mapping is bad, subflow_check_data_avail()
writes to the same byte in softirq, holding only the ssk lock:

	subflow->reset_transient = 0;
	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSRESET);
	subflow->reset_reason = status == MAPPING_NODSS ?
	...

mptcp_send_active_reset_reason() later reads these values back to build the
MP_RST.

Suppose this races with an RM_ADDR or RM_SUBFLOW. Can the no_retry update
be lost, so the subflow is retried on the removed address? Or can
reset_transient and reset_reason be overwritten with stale values, so the
MP_RST sent to the peer carries the wrong flag or reason?

Would it help to move retry and no_retry next to close_event_done, which
the msk socket lock protects, or to take the ssk lock here?

> +}
> +
>  static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
>  					const struct mptcp_rm_list *rm_list,
>  					enum linux_mptcp_mib_field rm_type)
> @@ -794,6 +832,7 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
>  			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
>  			u8 id = subflow_get_local_id(subflow);
>  
> +			mptcp_pm_rm_no_retry(subflow, rm_type, rm_id);
>  			if ((1 << inet_sk_state_load(ssk)) &
>  			    (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING | TCPF_CLOSE))
>  				continue;

[Severity: Medium]
mptcp_pm_rm_addr_or_subflow() now loads the subflow state twice without
the ssk lock: once inside mptcp_pm_rm_no_retry(), and again in the check
above.

What happens if a matching subflow moves from ESTABLISHED to TCP_CLOSE in
softirq between those two loads? For example, tcp_reset() or
tcp_write_err() can end in tcp_done().

In that case mptcp_pm_rm_no_retry() sees a state that is not closed and
leaves no_retry at 0. The second load then sees TCP_CLOSE and takes the
continue, so mptcp_subflow_shutdown() and mptcp_close_ssk() are skipped and
close_event_done stays 0.

On the next worker run, __mptcp_close_subflow() calls
mptcp_pm_kernel_retry_check(). It sees TCP_CLOSE, sk_err set,
fully_established set, and close_event_done and no_retry both 0. Wouldn't
mptcp_pm_kernel_retry() then re-create the subflow on the address that was
just removed?

The commit message says:

  "... or using an address that has been removed are not retried either."

The window is small, but nothing seems to prevent it. Later patches in the
series only touch selftests, so it doesn't look like this is handled later.
Could the state be loaded only once, or could every matching subflow be
marked whatever its state?

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 0379e1495cf4d..e88c236b62e9f 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1610,6 +1610,106 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)

[ ... ]

> +	/* Only a path that worked is tried again. If a subflow never got
> +	 * established, the PM moves on to the next endpoints instead, and a
> +	 * re-created subflow that cannot connect is not retried again: its SYN
> +	 * retransmissions already spaced out the tries.
> +	 */
> +	if (!READ_ONCE(subflow->fully_established))
> +		return false;
> +
> +	/* its address has been removed, see mptcp_pm_rm_addr_or_subflow() */
> +	if (subflow->no_retry)
> +		return false;
> +
> +	/* The peer asked not to use this path again (MP_RST without the T
> +	 * flag), the subflow has been aborted locally, or it hit an MPTCP
> +	 * protocol error.
> +	 */
> +	if ((subflow->reset_seen && !subflow->reset_transient) ||
> +	    err == ECONNABORTED || err == EBADMSG)
> +		return false;

[Severity: Medium]
Does this catch the local resets done through mptcp_subflow_reset()?

The comment above says that subflows aborted locally or hitting an
MPTCP protocol error are not retried, but the check only relies on
sk_err. mptcp_subflow_reset() is used by mptcp_mp_fail_no_response(),
mptcp_update_infinite_map() and mptcp_dss_corruption(). It sets
subflow->resetting, sends the MP_RST and calls tcp_done(ssk), but it
never writes ssk->sk_err.

So err is whatever was left on the subflow before. Can it be non-zero
at that point? If IP_RECVERR or IPV6_RECVERR is set on the MPTCP
socket, mptcp_sockopt_sync_locked() propagates it to the subflows.
tcp_v4_err() or tcp_v6_err() can then store an ICMP error such as
EHOSTUNREACH in ssk->sk_err while the subflow is established.
__mptcp_subflow_error_report() returns before sock_error(ssk) when the
subflow is not in SYN_SENT and the msk did not fall back, so that error
is not cleared.

Suppose an MP_FAIL timeout or a DSS corruption then resets that
subflow. mptcp_pm_kernel_retry_check() finds TCP_CLOSE, an err that is
neither ECONNABORTED nor EBADMSG, fully_established set and reset_seen
clear, and asks for a retry.

In the MP_FAIL cases, msk->allow_subflows is already false, so the new
subflow sends a SYN with MP_JOIN, only for mptcp_finish_join() to
reject it if the peer answers. With mptcp_dss_corruption(), the path
that just hit a protocol error is used again, which the comment says
should not happen.

Would checking subflow->resetting here, and maybe
READ_ONCE(msk->allow_subflows), be enough? Or should
mptcp_subflow_reset() set an error such as ECONNABORTED on the ssk, so
that the existing check catches it?

[ ... ]

> +/* Called with the msk socket lock held, after the subflow has been closed */
> +void mptcp_pm_kernel_retry(struct mptcp_sock *msk,
> +			   const struct mptcp_pm_retry *retry)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = (struct sock *)msk;
> +	struct sock *ssk;
> +	bool allowed;
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	allowed = msk->pm.extra_subflows <
> +		  mptcp_pm_get_limit_extra_subflows(msk);
> +	if (allowed)
> +		msk->pm.extra_subflows++;
> +	spin_unlock_bh(&msk->pm.lock);
> +
> +	if (!allowed ||
> +	    __mptcp_subflow_connect(sk, &retry->local, &retry->remote))
> +		return;

[Severity: Medium]
Can a remote peer keep the in-kernel PM in an endless subflow re-creation
loop here?

In mptcp_pm_kernel_retry_check(), the only "path worked" check is
subflow->fully_established, and the peer controls it.
check_fully_established() sets it as soon as an in-sequence packet carries
a DSS ack, which is the 4th ACK of the MP_JOIN:

	if (subflow->remote_key_valid &&
	    (((mp_opt->suboptions & OPTION_MPTCP_DSS) && mp_opt->use_ack) ||
	    ...
		goto set_fully_established;

The reset check after it lets two cases through: a plain TCP RST
(sk_err == ECONNRESET, reset_seen == 0) and an MP_RST with the T flag.
Nothing checks subflow->retry, the number of earlier attempts, or the time
since the last one.

mptcp_pm_kernel_retry() then connects immediately, and its only limit is
limit_extra_subflows. Just before, in __mptcp_close_subflow(),
mptcp_close_ssk() released that slot:

mptcp_close_ssk()
  mptcp_pm_subflow_check_next()
    __mptcp_pm_close_subflow()

The new subflow takes the slot straight back. It has request_join set, so
it can be retried again the next time it closes.

Consider a peer, or a middlebox injecting a RST after the MP_JOIN
handshake, that accepts each join, sends the 4th ACK and then resets the
subflow. Wouldn't the client then re-create the subflow every RTT or two,
for as long as the MPTCP socket stays established? Each cycle costs a
socket, a bind, HMAC work, SUB_ESTABLISHED and SUB_CLOSED netlink events,
and an ephemeral port.

The commit message says:

  "Its SYN retries, set like TCP_SYNCNT by the subflow-retries limit, space
  out the attempts."

That only seems to hold when SYNs are silently dropped, not when the peer
answers and then resets. Later patches in the series only touch selftests,
so this is still the case at the end of the series.

Would checking subflow->retry, or adding some backoff or a limit on
attempts per path, be needed here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018041748.1655711-1-anilkaushikwireless%40gmail.com
