Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415543;
	b=QSP3gdsbKUTnPFceZeMETXNSGRm10c+WggTJd1IMiQYviWDpiVN2rwfmmfyxHqJ4rE9E
	 XvB83MQM69vGoj0YEJl5E4rF1UgoPkx1fOXu/GQnEmPT92koOtL3BkHffniYlxZ9FvP8a
	 QTXw5TjrdR0ilD9UJBwgtslFwz9024h07b3nX8PF1EqBL66AyAKLnW8i+n7E/63DxBfCv
	 JigEzLmF44xC7pgCBsxtaIPizNXEzzHIuGFKZARlG2Mx/mXzWUCcP/v3tI8uyogkeZ0pi
	 PwJ1lJ67rEcGbVPYCRb0+nzMc1cC9UID3vMSMkO51tXR9VO/opcN0Pd7Lmu+bGxrqYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415543;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YSsPe+LBQ5F7KUn6HqrcWeyU/FJahAnloY45d49k1lU=;
	b=FPeBcuYMYXYNH9fJ7oK490SLCWqQvpArevEzA9Acf1qqTucHyN0L/ZmiMh1sc4xAb4iH
	 GvZMAOFqc1BMtYG+k0DBORFbdn7u5qP4aMXE9fuRUM1DL1N2oKHa1ONcbBf9dQJ69rqDa
	 SpQLK9NtkB9hR8OFhXrC5luvalgkWnusroKb0FL4LS+mcCqTLGb0pu0Op/bqI8ZD5m7DW
	 BdpIUsmfeLTNej4EJYZMRVswtDnzS/rCps2/+iNtTRwuYPTscQ7aIu2MKdIizwjECAdYA
	 JV/8A0VfkUif3zwLQH/4u1x3X5FK8P1fleAVmefvwosIXHQeWC9kTSCOaolCzij+d/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OvJIZVVs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49451606A321
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OvJIZVVs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78961F000D4;
	Mon, 23 Nov 2026 06:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415542;
	bh=YSsPe+LBQ5F7KUn6HqrcWeyU/FJahAnloY45d49k1lU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OvJIZVVs4v8/7s87XhRBh4bi59MTF2/OGkahM6pMwy21WYXFJ1tn1pPLIpxe49uuJ
	 ZPdYG9HSvcHQ3CpoatuWI0KgMap/cDP6Q1zRlr2dlZcvcTOMWUmUC58AZF0bmM+9LP
	 C0XnHlymwJSdm/f8MKnLYzVQuiIPJO/vjvVA69aR5iDz23+UpcXRXsqaIHfOUbLcFI
	 9mLIrLPFtIKcC0571wwHa9dxrGz6UPM6t+6ncFvjKtF0AUgxs+lO2KBHf888m8xPAU
	 nDYRmwuu/Xf5WstSoYZBwGCR0Ui53dAi9gQacUNtkNPmSGwaTqEXjR0zDDxzsDB9YF
	 siDiWYl+9uJfg==
Subject:
 Re: [PATCH mptcp-net v2 13/62] mptcp: limit an orphan probing a zero window
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 06:32:22 +0000
Message-ID: <179541554231.3133.10776173874685565@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-13-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-13-00327fd1de1f@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mptcp_subflow_probe_timed_out()
  (net/mptcp/protocol.c:2875-2898) can only report a timeout while the…

--

mptcp: limit an orphan probing a zero window

This patch adds mptcp_subflow_probe_timed_out(). It reports whether TCP
would have aborted a subflow that is probing a zero window, or that has
data in flight after the peer shrank its window to zero. mptcp_orphan_keep()
uses the new helper so that such an orphan is no longer kept once its close
timeout expires.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 944c9d11d2116..ff71f19540771 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2871,6 +2871,32 @@ static bool mptcp_close_tout_expired(const struct sock *sk)
>  		  inet_csk(sk)->icsk_mtup.probe_timestamp + mptcp_close_timeout(sk));
>  }
>  
> +/* Would TCP abort this subflow if it were an orphan probing a zero window? */
> +static bool mptcp_subflow_probe_timed_out(struct sock *ssk)
> +{

[ ... ]

> +	slow = lock_sock_fast_nested(ssk);
> +	limit = tcp_rto_max(ssk);
> +	if (tp->packets_out) {
> +		ret = !tp->snd_wnd && icsk->icsk_rto >= limit;
> +	} else {
> +		if (icsk->icsk_backoff < retries2)
> +			limit *= 2;
> +		/* a shift of 32 already exceeds the limit */
> +		when = (u64)icsk->icsk_rto << min_t(u8, icsk->icsk_backoff, 32);
> +		ret = tcp_send_head(ssk) && when >= limit;
> +	}
> +	unlock_sock_fast(ssk, slow);
> +
> +	return ret;
> +}
> +

[ ... ]

> @@ -2886,7 +2912,8 @@ static bool mptcp_orphan_keep(struct sock *sk)
>  		/* a live peer acks at least the probes, every TCP_RTO_MAX */
>  		if (__mptcp_subflow_active(subflow) &&
>  		    tcp_jiffies32 - READ_ONCE(tcp_sk(ssk)->rcv_tstamp) <
> -		    2 * TCP_RTO_MAX)
> +		    2 * TCP_RTO_MAX &&
> +		    !mptcp_subflow_probe_timed_out(ssk))
>  			return true;
>  	}

[Severity: Medium]

Can a remote peer still keep this orphan forever if the subflow is idle
at TCP level?

mptcp_subflow_probe_timed_out() only returns true when the subflow has
data at TCP level. That means either data in flight with a zero snd_wnd,
or a send head. With packets_out == 0 and tcp_send_head() == NULL, ret is
always false.

Consider a peer that TCP-ACKs all subflow data with an open TCP window but
never moves its DATA_ACK. msk->snd_una stays fixed, so the msk fills up to
wnd_end and stops sending. mptcp_sendmsg_frag() then queues no MPTCP zero
window probe:

net/mptcp/protocol.c:mptcp_sendmsg_frag() {
    ...
		if (snd_una != msk->snd_nxt || skb->len ||
		    skb != tcp_send_head(ssk)) {
			tcp_remove_empty_skb(ssk);
			return 0;
		}
    ...
}

The subflow therefore stays idle at TCP level. Reinjections from
__mptcp_retrans() are TCP-ACKed as well, and __mptcp_retrans() never gives
up.

The peer can also pass the "live peer" check cheaply. tcp_ack() refreshes
tp->rcv_tstamp on any non-old ACK, including a pure duplicate ACK. One
segment sent more often than every 2 * TCP_RTO_MAX is enough.

mptcp_worker() then re-arms the close timeout each time it expires:

	if (mptcp_close_tout_expired(sk) && mptcp_orphan_keep(sk)) {
		mptcp_start_tout_timer(sk);
		__mptcp_push_pending(sk, 0);
	}

None of these checks look at progress at the MPTCP level (snd_una or
DATA_ACK).

There is a related case. mptcp_orphan_keep() returns true for the first
subflow that passes the checks. Could an idle MP_JOIN subflow kept fresh
this way keep the orphan alive after the probing subflow has timed out?

Before this series, these orphans were freed when the close timeout
(TCP_TIMEWAIT_LEN) expired. The later patch "mptcp: count orphans as TCP
does" caps the total through tcp_check_oom() (tcp_max_orphans and
tcp_mem[2]). Below those limits, each orphan can still be kept as long as
the peer wants, together with its subflows and queued send data.

The commit message also says:

  Two corner cases needing non-default settings are not covered, which is
  fine: an idle subflow refreshed by keepalives still keeps the orphan
  when the stale detection is disabled, and tcp_orphan_retries is ignored.

Is this accurate? mptcp_pm_chk_stale() in net/mptcp/pm.c skips idle
subflows:

		/* No data outstanding at TCP level? not stale */
		if (tcp_rtx_and_write_queues_empty(ssk))
			continue;

Also, mptcp_orphan_keep() uses __mptcp_subflow_active(), which does not
check subflow->stale. So the idle subflow case seems to happen with default
settings too.

The commit message also says "It is now reset as TCP does, respecting
tcp_retries2." TCP gives up through tcp_write_timeout() when its data is
never acknowledged. Here, MPTCP-level data that is never DATA_ACKed does
not lead to a reset. Should either the check or the commit message be
updated?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f%40kernel.org
