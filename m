Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415541;
	b=En7TaF4H68O8MYj0gDNifQ/7UV5nseMRfbc0MNCPCSjhRLqbkifowEXfAoKqd4YFyy/H
	 8fREpsXmBlZ1P5u0B/8Eg84xgKUYRpl98/wXBj/4IEsS43vW+7nYMxDSuf6pD6mYGkJ/F
	 cGUX6xexnKe30f9RWLK9IWNRBaL1elq0EASbk9GHi96TlBlB5QTuWrwBt88FDhvid7qbl
	 zB+UAD7M7JKXnivBGSgqB3F7sq666NAxf1y+rPrxVIYXv9pRJ4jodNh6IEKDoskLxCWj3
	 mvdZ0/JBOFsRTmS5dzE9yp7n3RmgHPFiUYWMjLIVhP97RpIYNwaTIHmNqn9B99F9OeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415541;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TYglbUN6uIaZovIVLIQw1cNaiPlcrsvWmUmnrLfoMTY=;
	b=d0fsKvH+NaM1gUf/r4qoBT2MF3M5pX1Q+hD+nOrKwypuRC1y8RP0US7VUrY51xkYbdcR
	 BEyk2kEl1D8I5/RrruDzM4cNVTs0YdrYRTzHgCeAoamVxw2j+C67tZ9iMP0jKAghvKED2
	 fSVpxqiieArkiPx9XlZVwpdFHIlxV/ipPJnlnGCMVoq4N0/ug+GxHKgaWwG/dXcJRC5j9
	 ZNFBf84xjbF0qtB0cWoO7AJWtDUJBWQf7ZRtiAMx/EjGSR+Vrn6zY9+GJch4nZI8eedaS
	 oS5yIjlGgA70ud5YRqPQ2mP8zAr2lykt+3yO4na/OqqpmxEF7oSay1K8Wl3Nv1zgJZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQdWC37P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2B1606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQdWC37P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8831F000C6;
	Mon, 23 Nov 2026 06:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415540;
	bh=TYglbUN6uIaZovIVLIQw1cNaiPlcrsvWmUmnrLfoMTY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iQdWC37PzcnaB8QSrt6iyUpi5nNMKumjYS5NmlxuJ8I2zmZtT6ZzxF6xgMu7bBfX1
	 Hq5BV6/Ym0xgnC47fnIBvy+OUwXiDRBX0ildkSgTxVreZXCf8YCfvZszIVxQg375Gq
	 EPrkX4oc+v0OF96WPxxNzQvbHEjl9RJWv82mfMKocNUViYuT6ETu2nEADJ3itSvxES
	 YWW2+8iGDn8iWoOH+gc77uQdrtSuhi1m0LNWc78mgBtSaiI2N0h3e4CJwtG93ajZtE
	 TLa7RT//xidKQfKGVfitrS0Sr/hncmK3yI0zMTo6RJxwWeTCcx1nY7wMWLv8wQ7DY6
	 FSx39ea5Vxn3g==
Subject: Re: [PATCH mptcp-net v2 06/62] mptcp: pm: don't drop an RM_ADDR
 because of an ADD_ADDR
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 06:32:19 +0000
Message-ID: <179541553975.3133.677293475472069830@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-6-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-6-00327fd1de1f@kernel.org>
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

- [Medium] In mptcp_pm_remove_addr() (net/mptcp/pm.c:543-551), the new
  loop decides that an ACK carried no signal by comparing the whole…

--

mptcp: pm: don't drop an RM_ADDR because of an ADD_ADDR

With this patch, mptcp_pm_remove_addr() only refuses an RM_ADDR when
another RM_ADDR is already pending. A pending ADD_ADDR or echo no longer
blocks it. Up to three pure ACKs are then sent right away so that the
RM_ADDR goes out after any pending ADD_ADDR or echo, preferably on a
subflow that is not being removed.

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index f1f4b13c54590..cdd62433e0a6d 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c

[ ... ]

> @@ -538,7 +539,16 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
>  	msk->pm.rm_list_tx = *rm_list;
>  	rm_addr |= BIT(MPTCP_RM_ADDR_SIGNAL);
>  	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
> -	mptcp_pm_addr_send_ack_avoid_list(msk, rm_list);
> +
> +	/* pending ADD_ADDR and echo take the first ACKs: one more each */
> +	for (i = 0; i < 3 && mptcp_pm_should_rm_signal(msk); i++) {
> +		u8 signal = READ_ONCE(msk->pm.addr_signal);
> +
> +		mptcp_pm_addr_send_ack_avoid_list(msk, rm_list);
> +		/* no signal sent, e.g. after a fallback: no more ACKs */
> +		if (READ_ONCE(msk->pm.addr_signal) == signal)
> +			break;

[Severity: Medium]
Can this comparison see an ABA on the echo bit and stop after an ACK
that did carry a signal?

mptcp_pm_addr_send_ack_avoid_list() ends up in mptcp_pm_send_ack(), and
that function drops pm.lock while the ACK is sent:

net/mptcp/pm.c:mptcp_pm_send_ack() {
	spin_unlock_bh(&msk->pm.lock);
	__mptcp_pm_send_ack(msk, subflow, prio, backup);
	spin_lock_bh(&msk->pm.lock);
}

Say the loop starts with signal == ECHO|RM. The pure ACK carries the echo
first, and mptcp_pm_add_addr_signal() clears ECHO. While pm.lock is
dropped, another HMAC-valid ADD_ADDR from the peer could arrive on a
different CPU, for example a retransmission because our echo was late.
mptcp_pm_add_addr_received() handles it in softirq under pm.lock. On the
userspace PM path or the in-kernel reject path it calls:

	mptcp_pm_announce_addr(msk, addr, true);
	mptcp_pm_add_addr_send_ack(msk);

mptcp_pm_announce_addr() only checks BIT(MPTCP_ADD_ADDR_ECHO), so this
succeeds and ECHO is set again.

Once the loop takes the lock back, addr_signal is again ECHO|RM, which
is equal to signal. The loop then breaks on the "no signal sent" path
while the RM_ADDR is still pending. The same thing can happen with
SIG|ECHO|RM pending.

In mptcp_nl_remove_subflow_and_signal_addr(), mptcp_pm_rm_subflow() runs
right after this. mptcp_subflow_shutdown() then sends a pure ACK on the
subflow being removed. That ACK takes the re-set echo, so the RM_ADDR is
left for the next packet on that subflow, such as its FIN.

The commit message describes the v2 loop as avoiding exactly this:

  Otherwise, the RM_ADDR would go with the next packet, which could be
  sent on a subflow being removed

If that path is dead, which is a common reason to remove an endpoint,
the peer would never learn about the RM_ADDR. TCP retransmissions would
not resend it, because the signal bit has already been cleared.

Would it be more robust to check whether progress was made, for example
with a counter of sent signals, or by checking the RM bit itself, instead
of comparing the whole byte? Even with such a check, the fixed limit of
three ACKs could still run out if new signals keep being set.

> +	}
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f%40kernel.org
