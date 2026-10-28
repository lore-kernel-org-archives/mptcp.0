Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153672;
	b=UBuUBGi5d9uy98JNezZlAIT1v0DC7Xj8YQXwsx761BtyU4JD5BuTm2/nIeb9O+g48w9D
	 bKl9eDTmyYfecmGwfa19YULfxWzCe02yr9NZWALBZG2oQjVGMeNrXt0Uc+9i2EH5GtPsd
	 rwHZvAnOqAT3JjfZVEDnnKwcyFoygaOXoBbG7lUQGwHmmcFNe8pADJt2DW/yVTouFSkSu
	 NXpW4Z6DNSgA6ifQ45GB/F9Eyawdwg50i0AHJkK1OCHqJNxmAGQaCYGb4YOPRbLQR3Df5
	 TYbJybZtNCjwqgLuyJG1XOUIl4i66vz5MJR3N+rzxLHRUws3X1LDlPPF8NHY8F8vq6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153672;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=XPPrVGFqSggMmnexVwRgjXLcbuX4ebSPfc+XYIXCe5U=;
	b=q3ipTQYaSkxyBG6oVg4T6hTLJDuY74+bRJ75P19OmcnIyBqobhTUolyn6cvWLW8DzVmB
	 WMPYGgGyxf1KYi9MjOaULbnlwgC3Yfl+7iSRaEUqxtXT+pvDK15JLcM+LzMVv/PA+K1iy
	 QluK/ibv8KE/Qxd7B8kL/5eKmEYeeuwB0haA2NcwNbG2z+qR29HP9F9T4XhJZ6GpkiCvJ
	 JELqUZRnhY20AVgNqJ9atjuvE9/sW5xFiKrhRPG0+KMkUGGRxbua0VMq6GI/NCw2oDx/I
	 0gr7OdFf6mSqlRyzsNdpOPVovJVhPA08WBN6l3Ba1Nzt1Hn5SkaWTHaP2N+n/RqZYag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RA/gkuIj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87440606A320
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 02:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RA/gkuIj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9831F01828;
	Wed, 28 Oct 2026 02:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793153672;
	bh=XPPrVGFqSggMmnexVwRgjXLcbuX4ebSPfc+XYIXCe5U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RA/gkuIj/HeGcdr2Y47t/jNgXcT/zT8OAV2rr8hUgjP5JvTdc/b/1i6zeARKfJwis
	 Ddb2xPgTSWottHQIAG3Ksq2Dbhktwl+5lDk5UtkKkezCHPLof+OCirSoHkKZX8tSjB
	 qX/3KnTxqKog3rON+cEvT5gV2uaBv6mvS05+T+tD7I5xf9fshFnyfX8xaXwppPKesL
	 yIYuZ4R9OcgWmK1FcP85LFQbbCEFiqd2Q5KWJkeLdiuaVHX6OEruCZtlC6jVcnnPKU
	 cRXN1mlQLReS9mTDwUGd1elc7vXu/bw/+2UJvOizKNfJNkLY0BoSmAgQrmZqr9qc0U
	 C3HSqeZpdiEkw==
Subject: Re: [PATCH mptcp-next v11 4/6] mptcp: pm: in-kernel: retry subflows
 closed after an error
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Wed, 28 Oct 2026 02:14:31 +0000
Message-ID: <179315367155.3132.2651716349664922662@kernel.org>
In-Reply-To: <20261026125345.3019372-5-anilkaushikwireless@gmail.com>
References: <20261026125345.3019372-5-anilkaushikwireless@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mptcp_close_retry_subflows() (net/mptcp/protocol.c) decides
  whether to close a re-created subflow by reading…
- [Low] The patch uses two different definitions of 'another subflow can
  send data'.
- [Low] The new paragraph in Documentation/networking/mptcp.rst says the
  in-kernel PM re-creates 'the additional subflows, and ... the initial…

--

mptcp: pm: in-kernel: retry subflows closed after an error

With this commit, the in-kernel PM re-creates an established subflow
initiated by this side when TCP gives up on it after a retransmission or
keepalive timeout, as long as another subflow can still send data. The
re-created subflow uses the subflow-retries limit as its SYN retries. It
is closed if it is still not established when no other subflow can send
data, or when the MPTCP socket is shut down or closed.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440

> diff --git a/Documentation/networking/mptcp.rst b/Documentation/networking/mptcp.rst
> index b6753ffb9c9a6..72a91aeed9c6e 100644
> --- a/Documentation/networking/mptcp.rst
> +++ b/Documentation/networking/mptcp.rst
> @@ -73,6 +73,24 @@ To be able to use multiple IP addresses on a host to create multiple *subflows*
>  addresses can be used. This can be configured with ``ip mptcp endpoint`` for
>  example.
>  
> +When TCP gives up on an established subflow created by this host, after a
> +retransmission or keepalive timeout, the in-kernel path manager creates it
> +again, with the ``subflow-retries`` limit as its number of SYN retries, like
> +``TCP_SYNCNT``: 127 by default, about 4 hours, and 0 to not re-create it. This
> +is done for the additional subflows, and for the initial one on the client side:

[Severity: Low]
Is this description complete? mptcp_pm_kernel_retry_check() also skips
the initial subflow when the peer set the C flag in MP_CAPABLE:

net/mptcp/pm_kernel.c:mptcp_pm_kernel_retry_check() {
    ...
	retry->remote.id = READ_ONCE(subflow->remote_id);
	if (!retry->remote.id && READ_ONCE(msk->pm.remote_deny_join_id0))
		return false;
    ...
}

The client's initial subflow always has remote id 0. So with a server
that denies joins to its initial address (for example with
allow_join_initial_addr_port set to 0), the initial subflow is never
re-created.

Skipping it is correct protocol behaviour. Could the documentation
mention this exception?

> +the new subflow then takes one of the additional subflows allowed by the
> +``subflows`` limit. This is a single connection attempt: an ICMP error, or a

[ ... ]

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8c..9a32c908ea986 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -2788,6 +2795,39 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  	}
>  }
>  
> +/* Re-created subflows not established yet are useless once the msk is
> + * closed or shut down, or no other subflow can send data, see
> + * mptcp_retry_subflows_stale(). Not called while iterating on the subflows.
> + */
> +static void mptcp_close_retry_subflows(struct sock *sk)
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
> +		/* like mptcp_close_ssk(): it can have joined already */
> +		if (sk->sk_state == TCP_ESTABLISHED &&
> +		    !subflow->close_event_done) {
> +			subflow->close_event_done = true;
> +			mptcp_event(MPTCP_EVENT_SUB_CLOSED, msk, ssk,
> +				    GFP_KERNEL);
> +		}
> +
> +		/* Checked without the ssk lock: it can have been established
> +		 * in between. __mptcp_close_ssk() cleans its data in the msk
> +		 * backlog, and the MPTCP retransmissions cover what it sent.
> +		 * No need to push the pending data again.
> +		 */
> +		mptcp_pm_subflow_check_next(msk, subflow);
> +		__mptcp_close_ssk(sk, ssk, subflow, 0);
> +	}
> +}

[Severity: Medium]
Can a re-created subflow that has just become usable still get closed
here?

fully_established is read without the ssk lock. The ssk lock is only
taken later, inside __mptcp_close_ssk(). In between, mptcp_event() can
sleep in its GFP_KERNEL allocation. Nothing re-checks fully_established
once lock_sock_nested(ssk) is held.

For an active MP_JOIN subflow, fully_established is set from softirq
without the msk socket lock:

net/mptcp/options.c:check_fully_established() {
    ...
	mptcp_data_lock((struct sock *)msk);
	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
	mptcp_data_unlock((struct sock *)msk);
    ...
}

So another CPU can process the 4th ACK after the READ_ONCE() and before
the close.

The caller also computes the stale decision only once, before the loop:

mptcp_worker()
    if (mptcp_retry_subflows_stale(msk))
        mptcp_close_retry_subflows(sk);

If one re-created subflow gets established during the loop, the other
pending re-created subflows are still closed, even though the msk is no
longer stale.

If the only usable path gets torn down this way, __mptcp_close_ssk() can
find conn_list singular with the first subflow closed. It then starts the
close timeout, so the connection gets closed even though a working path
existed.

The same window seems to let mptcp_finish_join() handle a SYN-ACK and
emit MPTCP_EVENT_SUB_ESTABLISHED after this loop already sent
MPTCP_EVENT_SUB_CLOSED for that subflow.

The comment above says the subflow "can have been established in
between", but it only covers the data side. Would re-checking
fully_established and the stale condition under the ssk lock close this
window?

[ ... ]

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 4aa4aedb2ba76..245d3d24ae2e7 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h

[ ... ]

> @@ -919,6 +921,28 @@ static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
>  	return __tcp_can_send(mptcp_subflow_tcp_sock(subflow));
>  }
>  
> +/* Re-created subflows not established yet, while no other subflow can send
> + * data, or once the msk is no longer established: they cannot join anymore,
> + * see mptcp_finish_join(), or must not keep the connection open.
> + */
> +static inline bool mptcp_retry_subflows_stale(struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = (struct sock *)msk;
> +	bool retry = false;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		if (sk->sk_state == TCP_ESTABLISHED &&
> +		    __mptcp_subflow_active(subflow))
> +			return false;

[Severity: Low]
Should this check use the same definition of "another subflow can send
data" as mptcp_pm_retry_other_subflow()?

That helper runs before a retry is created, and it excludes CLOSE_WAIT:

net/mptcp/pm_kernel.c:mptcp_pm_retry_other_subflow() {
    ...
		if (__mptcp_subflow_active(subflow) &&
		    inet_sk_state_load(ssk) == TCP_ESTABLISHED)
			return true;
    ...
}

This check uses only __mptcp_subflow_active(), and __tcp_can_send()
accepts TCPF_CLOSE_WAIT. So a subflow in CLOSE_WAIT is not enough to
start a retry, but it is enough to keep a still-connecting re-created
subflow open. That subflow can keep sending SYNs, up to the
subflow-retries limit (about 4 hours by default).

This lasts until __mptcp_close_subflow() collects the CLOSE_WAIT
subflow, which only happens once its receive queue is empty.

The comment on mptcp_pm_retry_other_subflow() and the v11 changelog say
a CLOSE_WAIT subflow does not count. mptcp.rst also only describes that
definition.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026125345.3019372-1-anilkaushikwireless%40gmail.com
