Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793071735;
	b=d4R0phDrajG8Dwe47YudwrSSJiqzy3kapJX1TPKvDsry3i2BPP3o3Nb0naU/wPgiqC9F
	 iAYI9062O0KJ4jPO7NzYrVFxx6U5hyfY3Nu/prU+ASEk63yMEVDNdx19BMLTgJ8BD04mR
	 HrsSLdv3VXbNpVm2o9DgPPZ25XciKX9Fz+LNMvbmblx34HTBDYWSPwg1OIZll6r5V08ys
	 t20rAaFw3xi7WXX27A3Y4apaz8S++NaG7z3ayg04maL/KGdlZ+s9s8ILNXJb5epIJKWBQ
	 XQFA+KWUnor0u2iyd50Q/Upxrj+dPbvWTZDoo2lhMo8t9cCC2s7mzngd8RULZJkA7uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071735;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uF+WgSrxnSovU4Le3K/ctrNjrwrS64MCcIyTuVdpUN4=;
	b=HgJTkRSrn0ZwY2fCWUZdKytg8cTBYVjLMb4yU3fb7MkCKvJ1F51dt/4glJpYuOvIPVHN
	 Och6nx2R7dHsZD1LJ/3SFlaAlVRNQvSsQPBWXzrfX2D60N9LbCliQAtwyEVLgUljUFBlV
	 92y4VB62t8f0JfBl5H+fjuFPVgxyqlC13J44indIRmPpGaMrnGBy5TwuUc2kf5kRi7Qpi
	 6xzQxbMXWNdTLXWY9G+1ddJRyh0chWjeEGn74qpYCTM16dyYtw+hWpEAbheav8AjgxR0f
	 6jD5mHHnQct+oft4TEo2UlpKEqlAtiQUue6mwWFW8tQPhYDtolNafyYAN8I6skZR/RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eBAsdonH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC65F606A322
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 03:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eBAsdonH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701111F01828;
	Tue, 27 Oct 2026 03:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793071734;
	bh=uF+WgSrxnSovU4Le3K/ctrNjrwrS64MCcIyTuVdpUN4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eBAsdonHPPhdo+pcEoXm7TAfCSfc2XXCuHWBaXtrPWCSyxpo+2LYf1Y5DB+Ie1Z94
	 5IkKLXm29UKVC0mu+a2JEuoGNI5jnvltHbrmTf+Q2FPmFrXWpPvKN3bdBu+aL5Ze8A
	 ZV3xebkW6vaDeSQoakvTfezYcT0E/B+Ge/qdyD6G8e5hDA7o1VHMD96mezA7N7+fwv
	 Dbi6VItSS1YpKFLX0RDkeddtpGWkq1OgNjmD6cmLM4HaEQb2g+I+x6hNWlV7NaNNyg
	 xJb9FpUkCWqVtAnydWTVVDZRCNlKLehOsTXil1Y+IoNB1Zi2ReAHMdfJ9ls9t//yC2
	 bKBRdFZMw2p0Q==
Subject: Re: [PATCH mptcp-next v9 4/6] mptcp: pm: in-kernel: retry subflows
 closed after an error
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 27 Oct 2026 03:28:54 +0000
Message-ID: <179307173401.3132.17987804192674072716@kernel.org>
In-Reply-To: <20261025134909.2794368-5-anilkaushikwireless@gmail.com>
References: <20261025134909.2794368-5-anilkaushikwireless@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The close timeout is armed again when a subflow is re-created,
  and nothing cancels it once that subflow connects.
- [Medium] mptcp: pm: retry subflows keep half-closed sockets open when
  all subflows close

--

mptcp: pm: in-kernel: retry subflows closed after an error

With this patch, the in-kernel PM re-creates an established subflow that
this side initiated, once TCP gives up on it after a retransmission or
keepalive timeout. The subflow-retries limit is used as the new subflow's
SYN retries. When no other subflow can send, the close timeout is armed
while the re-created subflow connects. Re-created subflows that are still
connecting are closed together with the MPTCP socket.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8c..25fd0628686c3 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -2788,6 +2791,32 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  	}
>  }
>  
> +/* With no subflow left to send data, a re-created subflow still connecting
> + * must not keep the connection open longer than the close timeout, as when
> + * all the subflows are closed, see __mptcp_close_ssk(). A join stops it.
> + */
> +static void mptcp_retry_check_tout(struct sock *sk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	bool connecting = false;
> +
> +	if (sk->sk_state != TCP_ESTABLISHED ||
> +	    inet_csk(sk)->icsk_mtup.probe_timestamp)
> +		return;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		if (__mptcp_subflow_active(subflow))
> +			return;
> +
> +		connecting |= subflow->retry &&
> +			      !READ_ONCE(subflow->fully_established);
> +	}
> +
> +	if (connecting)
> +		mptcp_start_tout_timer(sk);
> +}

[Severity: Medium]
Can this early return leave a half-closed msk open for the whole SYN
retry period of a re-created subflow?

Take a connection with two subflows. The first one times out while the
msk is TCP_ESTABLISHED. __mptcp_close_subflow() then re-creates it
through mptcp_pm_subflow_retry(), in TCP_SYN_SENT, with
icsk_syn_retries set from subflow-retries (127 by default). The second
subflow is still active, so mptcp_retry_check_tout() does not arm the
close timeout. That part is fine.

The msk can then leave TCP_ESTABLISHED before close() is called:

 - mptcp_check_data_fin() moves it to TCP_CLOSE_WAIT when the peer
   sends a DATA_FIN.
 - shutdown(SHUT_WR) moves it to TCP_FIN_WAIT1 or TCP_LAST_ACK in
   mptcp_shutdown(). If data is still pending,
   mptcp_check_send_data_fin() returns before mptcp_subflow_shutdown()
   is called, so the connecting subflow is not touched.

After that, mptcp_is_fully_established() is false, and
mptcp_finish_join() would reset the re-created subflow with
MPTCP_RST_EMPTCP. It can no longer carry data. It still stays on
conn_list, because mptcp_close_retry_subflows() is only called from
__mptcp_close().

When the second subflow closes later, this check at the end of
__mptcp_close_ssk() is false:

	if (list_is_singular(&msk->conn_list) && msk->first &&
	    inet_sk_state_load(msk->first) == TCP_CLOSE) {

msk->first and the re-created subflow are both still on the list, so
the msk is not moved to TCP_CLOSE and mptcp_close_wake_up() is not
called. mptcp_retry_check_tout() also returns early here, because
sk_state is not TCP_ESTABLISHED. So the close timeout is not armed
either.

Would the msk then stay half-closed until the re-created subflow gets
an answer, or until TCP gives up on its SYN retries? With the default
limit that is about 4 hours, and the path has just failed, so a quick
answer seems unlikely. An application waiting for the connection to
finish closing would be stuck for that long. That covers both waiting
after shutdown(SHUT_WR) and waiting after reading the peer's EOF.

What is the right place to handle this? One option is to close the
re-created subflows that are still connecting as soon as the msk
leaves TCP_ESTABLISHED, as mptcp_close_retry_subflows() does on
close(). Another is for the "all subflows closed" check in
__mptcp_close_ssk() to ignore them.

[Severity: High]
Is the "A join stops it." part of the comment above true for the
re-created subflow?

On success, __mptcp_subflow_connect() stops the timer. But
__mptcp_close_subflow() calls mptcp_retry_check_tout() right after:

    mptcp_pm_subflow_retry(msk, &retry);
    /* creating a subflow stopped the close timeout */
    mptcp_retry_check_tout(sk);

At this point probe_timestamp is 0 and the old subflow is TCP_CLOSE. The
new subflow has request_join set but not fully_established. So
__mptcp_subflow_active() is false for every subflow, and
mptcp_start_tout_timer() arms the timer again.

The same thing happens through mptcp_close_ssk()->mptcp_retry_check_tout()
when the last active subflow closes while a re-created one is still
connecting.

When the SYN-ACK arrives, subflow_finish_connect()->mptcp_finish_join()
takes the active subflow branch, because the subflow is already on
conn_list:

	if (!list_empty(&subflow->node)) {
		spin_lock_bh(&msk->fallback_lock);
		...
		mptcp_subflow_joined(msk, ssk);
		spin_unlock_bh(&msk->fallback_lock);
		mptcp_propagate_sndbuf(parent, ssk);
		return true;
	}

This branch never reaches __mptcp_finish_join(), which is the only place a
join calls mptcp_stop_tout_timer().

Does probe_timestamp then stay set after the re-created subflow is
established? mptcp_close_tout_expired() only checks probe_timestamp,
sk_state and the elapsed time. So after close_timeout, mptcp_worker() would
do:

	mptcp_do_fastclose(sk);
	mptcp_for_each_subflow_safe(msk, subflow, tmp)
		__mptcp_close_ssk(sk, subflow->tcp_sock, subflow, 0);

Would this fast-close a connection that has just recovered through the
re-created subflow? One example is a single-path client after an outage
longer than tcp_retries2.

That seems to contradict the commit message, and mptcp.rst says the same
thing:

  If no other subflow can send data, the connection is still closed after
  the close timeout, as when all the subflows are closed, unless the new
  subflow connects before.

There is also a race to consider in a fix. mptcp_retry_check_tout() reads
fully_established holding only the msk socket lock, while the receive path
can set it at the same time. If a stop is added only when the subflow gets
established, could it run before the timer is armed from a stale
fully_established value? Should the expiry path also check whether a
subflow can send again?

The later patches in the series do not change net/. The selftests in
"selftests: mptcp: join: validate subflow retry after link failure" appear
to cover only two cases: another subflow stays alive, or the re-created
subflow never connects.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261025134909.2794368-1-anilkaushikwireless%40gmail.com
