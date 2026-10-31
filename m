Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793472141;
	b=VRqdy4BZCmXIpjyC82I9K+1FjawvLrX75BwGM2/0ZeNS2Z2lwRSkyqOCcCI00khM5+zq
	 Frn2FdA7JGbsur/DsUCeB8WoJhRcXDoea369gOAoz/Aksu2QAM55cJhkjo+cr2VsptlYA
	 3Xq+spS1Ys4/AEqF8+FJBDZmHXYIJleLF2LiCPGq+pavGUfZc8H/gmhGilRPYF5M4vAVT
	 sL+vgy+u+KvIADynoqVE3yrHli0uP1XWOVg2uEDLJmhI/EI+zNhkdnhwaTnVB78keietO
	 iLnwN0CA65o/RkWMN8FiscadhL01dTtlTEtCneYB+tdp3ylvGtrNiKNjnVzeG+xiGcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793472141;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Q2zri0u6k0EgGg37ZUkkUKZt1TDvRXbwVy66RLUa+Jk=;
	b=E8Dvzz9MZ0sp57LFkyPD0YjQm8X4IkO/mUQpsdf+nrwUc+7/h0/h2lHxg09E3CSEfvrh
	 NRKpz8rB602SSrVr7F+ouzI/+6PCubJz4TiVf1ug1p3k+3Vz3tqcATkA+eG0YJGHmGrTw
	 RIcyUEtULesktGM2Yi2liikifDAfKIHEflCuBjNzcpwaeOQtrOnomoqKZxVkPMM/wuypV
	 vqaPBJm0cMg0Sd7clbwRaMXtMEGejIpTVyMsYzZTOSFPfnKUenWu/ZXW9LeNNKFUdLudi
	 2dGFgZHhjWgDP5o313/LYKsikzaPD+ob6cXxqx48RlHyfzSxasKm2Y4ReicZVy3nf5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWc+cV0f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C0A606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWc+cV0f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F1B1F000C1;
	Sat, 31 Oct 2026 18:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793472140;
	bh=Q2zri0u6k0EgGg37ZUkkUKZt1TDvRXbwVy66RLUa+Jk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GWc+cV0f5BrNwPtK0iPV/ozq5ZXE7P1EikedpS1AITqK+y9ulzPGZRqqwDj6LSh6p
	 p6JsromzkzeLzDLSyq9oVF2x1Gw6EThGh5ZahfvQWTZE1MzcPof3EJoLHMQMX+C+uo
	 wkFxrLS/098RWu02erijdnRUDMINVifAVju06EndcRU6sBFDpD9lTye+W6EvX5ti3M
	 xgE8BlC6EgekV471aPUKrndJFu85mbui9ZWCwhirEBWIXnR5N9S+sJX50LRZOiocvI
	 dRV0NMgJGREBGpJnkvJpt0lhgZyDpye4qc9B5M7CIq0Icwzy3MxSuvQqU3i2DOnkCI
	 w3F3RI5Cxztwg==
Subject: Re: [PATCH mptcp-next v13 4/6] mptcp: pm: in-kernel: retry subflows
 closed after an error
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 31 Oct 2026 18:42:20 +0000
Message-ID: <179347214019.3128.3694868377922628785@kernel.org>
In-Reply-To: <20261030050727.3534304-5-anilkaushikwireless@gmail.com>
References: <20261030050727.3534304-5-anilkaushikwireless@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says a closed re-created subflow 'gets an
  MPTCP_EVENT_SUB_CLOSED event, like a join that fails, also when the…
- [Low] The new mptcp.rst text (and the commit message) says 'TCP only
  gives up on a subflow after ``tcp_retries2`` retransmissions, about 15…
- [Low] The commit says a re-created subflow 'takes the place of the
  closed one in the subflows limit', but the slot is not handed over…

--

mptcp: pm: in-kernel: retry subflows closed after an error

With this patch, the in-kernel PM re-creates an established subflow
initiated by this host after TCP gives up on it following a
retransmission or keepalive timeout. The subflow-retries limit sets the
number of SYN retries. Re-creation only happens while another subflow
can send data. Re-created subflows that are not fully established yet
are closed on shutdown or close, or when no other subflow can send.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440

> diff --git a/Documentation/networking/mptcp.rst b/Documentation/networking/mptcp.rst
> index b6753ffb9c9a6..0d8fac8813a9e 100644
> --- a/Documentation/networking/mptcp.rst
> +++ b/Documentation/networking/mptcp.rst
> @@ -73,6 +73,27 @@ To be able to use multiple IP addresses on a host to create multiple *subflows*
>  addresses can be used. This can be configured with ``ip mptcp endpoint`` for
>  example.
>  
> +When TCP gives up on an established subflow created by this host, after a
> +retransmission or keepalive timeout, the in-kernel path manager creates it

[ ... ]

> +too. A subflow reset by the peer, or by anything on the path, is not created
> +again either. TCP only gives up on a subflow after ``tcp_retries2``
> +retransmissions, about 15 minutes by default: shorter outages are handled by TCP
> +itself. A subflow that only receives data does not notice that its path stopped

[Severity: Low]
Is "after tcp_retries2 retransmissions" accurate here? The commit message
says the same thing:

  TCP only closes a subflow after tcp_retries2 retransmissions, about 15
  minutes by default.

Documentation/networking/ip-sysctl.rst describes tcp_retries2 as a
parameter of a hypothetical backoff schedule, not as a retransmission
count:

  Given a value of N, a hypothetical TCP connection following
  exponential backoff with an initial RTO of TCP_RTO_MIN would
  retransmit N times before killing the connection at the (N+1)th RTO.

tcp_write_timeout() matches this. For an established socket, it passes
sysctl_tcp_retries2 to retransmits_timed_out(), which checks elapsed
time, and TCP_USER_TIMEOUT can override it. A subflow whose RTO starts
above TCP_RTO_MIN, e.g. around 1s, is dropped after fewer retransmissions
(about 13).

Could the text describe this as a retransmission timeout controlled by
tcp_retries2, about 15 minutes by default, in both mptcp.rst and the
commit message?

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
> +
> +	if (!allowed ||
> +	    __mptcp_subflow_connect(sk, &retry->local, &retry->remote))
> +		return;

[Severity: Low]
The commit message says:

  A re-created subflow takes the place of the closed one in the subflows
  limit

Is the slot really handed over to the new subflow? In
__mptcp_close_subflow(), the closed subflow gives up its slot in one
pm.lock section, and this function takes the slot back in another:

__mptcp_close_subflow()
  mptcp_close_ssk()
    mptcp_pm_subflow_check_next()
      __mptcp_pm_close_subflow()
        --msk->pm.extra_subflows, accept_subflow set to true
        pm.lock dropped
    __mptcp_close_ssk()
      lock_sock_nested(ssk), __tcp_close(), release_sock(ssk)
  mptcp_pm_subflow_retry()
    mptcp_pm_kernel_retry()
      spin_lock_bh(&msk->pm.lock), limit checked again

A join started by the peer can be processed in softirq inside this
window:

  subflow_syn_recv_sock()
    mptcp_finish_join()
      mptcp_pm_allow_new_subflow()

That path takes only pm.lock, not the msk socket lock.

If the join takes the freed slot, allowed is false here, and the path
that timed out is never re-created, with no notice. This needs a host
that both starts and accepts joins, e.g. with a signal endpoint that has
a port, and a subflows limit that is fully used.

Could the slot be kept across the close when a retry is planned, so the
behaviour matches the commit message?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8c..cb1350ba1a41a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -2695,6 +2700,26 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  	 * subflow close.
>  	 */
>  	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
> +
> +	/* a re-created subflow, see mptcp_close_retry_subflows(): the ssk lock
> +	 * defers the 4th ACK, so it cannot get fully established meanwhile
> +	 */
> +	if (flags & MPTCP_CF_RETRY) {
> +		if (READ_ONCE(subflow->fully_established)) {
> +			release_sock(ssk);
> +			return;
> +		}
> +
> +		/* like mptcp_close_ssk(): it can have joined already */
> +		if (sk->sk_state == TCP_ESTABLISHED &&
> +		    !subflow->close_event_done) {
> +			subflow->close_event_done = true;
> +			mptcp_event(MPTCP_EVENT_SUB_CLOSED, msk, ssk,
> +				    GFP_KERNEL);
> +		}

[Severity: Low]
The commit message says:

  A closed one gets an MPTCP_EVENT_SUB_CLOSED event, like a join that
  fails, also when the MPTCP socket is closed.

Does this still hold once the msk has left TCP_ESTABLISHED? The event
is only sent when sk->sk_state == TCP_ESTABLISHED. However,
mptcp_retry_subflows_stale() returns true as soon as the msk is no
longer established.

For example, when the peer sends a DATA_FIN on another subflow:

mptcp_check_data_fin()
  mptcp_set_state(sk, TCP_CLOSE_WAIT)
  mptcp_schedule_work(sk)
mptcp_worker()
  mptcp_close_retry_subflows(sk, true)
    __mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_RETRY)

The re-created subflows are closed here with no SUB_CLOSED event. The
same happens when close() or shutdown(SHUT_WR) is called on a msk that
is already in CLOSE_WAIT: mptcp_close_retry_subflows(sk, false) runs
while sk_state is CLOSE_WAIT.

A re-created join that already got its SYN-ACK has had
MPTCP_EVENT_SUB_ESTABLISHED sent from mptcp_finish_join(). In these
cases, userspace never sees that subflow closed.

mptcp_close_ssk() already behaves this way. Should the commit message
say that the event is only sent while the msk is established?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030050727.3534304-1-anilkaushikwireless%40gmail.com
