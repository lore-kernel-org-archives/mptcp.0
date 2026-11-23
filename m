Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415553;
	b=g6sEsr43mV1Jk2zAb0xuYvq/PtKPTFKa1S1PQhQ+2hqFNiAnmyg1PrnOdP/XnaeUlxSJ
	 YHmn9Mvn3FxA7OU0gGvZmrigD8Xn5UZGHUga/RGxQOBeM99WD94N8SFm53DzvTxiNZQ97
	 LGSJAXn9Efa/ahqUc+RHlV8ACHlvQt0pqdOSx3jpKN3rY1Aj9rQO5k+4SooKJVGiiW4Zm
	 SBT0HfNb07gXnwz0Ef4+81t/8ZdiRtiiwvJgqXFlhHCqcprxgSNtJkA1V+JP+lMD+gJCE
	 RfYEtsKPFAIebm5IfXAqQrrtyOuht1LXLurCJvRkVER7JhKDcK4i74Hv2C35COXcAlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415553;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=O2GH125lrrTi2ClKuAiegv6/l8/lSoL88dGXNyInGE8=;
	b=hqnY2/xcZdbGexJLUvSHprLmZ0d3yiodJ3X2iXfSwRgBD2UB8vl1Rl9jwOgwjfRRZKSM
	 T3cRK4ZQnTg9MkH/Fr/WZwUN4yJel9vcjIo+9TxJ4zjeg1hkjCaGGOXS1vwofx4Vh1yH6
	 lkV6kw+LpKqaEiecB20OrqerAS2Oitg9uXDpIi3SM9UjJHKPzdjIKwdYnJQ8ELeA0MKo3
	 SQttVK227ZLKMdI84ObVHmSeUmEJfzEOXxPB0G4HzmHUQCOqoO5NPf8CwChf6xyns910l
	 0Z80zUcwUOMsbAJtnbSm3jebA6fzLh2hdFBVcq1xRRIjRi7oTOX4PlWe8qJLerzX8gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kvaBTftx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A7E606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kvaBTftx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD4F1F000E0;
	Mon, 23 Nov 2026 06:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415553;
	bh=O2GH125lrrTi2ClKuAiegv6/l8/lSoL88dGXNyInGE8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kvaBTftx10eAgkEdnYhjeSb+v5XDP6iISdwnny5s8uvCPM9vbHqRDJqixQxV2uHG1
	 P3iv3GyJIxTPs3GCSkJ9V3i8YI5AulYtRMqkqPZrmc3fTvndPIL/DXePvpCjo7ekPj
	 YSpCBS3t7eHl9o7V6NDKjaXKndhX/+E6jjW1xlm7039+z/o68llVaOtgXKUsqMhnar
	 O1al9fBKwSEUMQ+BCF/MS1dJ8K2PLV/BcamyVSsAW0eOEnGn+w1CuuqLCuTOygXzaI
	 MgLMu/tif8ozPoVTrvNQl2atd5sJ7m+yW3M16p6tpPUs1WhkBtWiqioJZsgZICjiwF
	 Q1k9f6z0EzlnQ==
Subject: Re: [PATCH mptcp-net v2 28/62] mptcp: no fastclose reset from
 SYN_SENT subflows
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 06:32:32 +0000
Message-ID: <179541555288.3133.1892545149485565462@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-28-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-28-00327fd1de1f@kernel.org>
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

- [Medium] After this patch, a SYN-ACK that arrives during a race window
  can complete the handshake, and the subflow is then closed without…

--

mptcp: no fastclose reset from SYN_SENT subflows

This patch makes mptcp_do_fastclose() skip sending a reset with
MP_FASTCLOSE on subflows that are still in SYN_SENT, which matches what
tcp_disconnect() does through tcp_need_reset(). The subflow keeps
send_fastclose set and is moved to TCP_CLOSE later.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f80fac0c22c06..55ff0298e5dd2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3297,6 +3297,10 @@ static void mptcp_do_fastclose(struct sock *sk)
>  
>  		subflow->send_fastclose = 1;
>  
> +		/* no reset in SYN_SENT, as TCP does */
> +		if (ssk->sk_state == TCP_SYN_SENT)
> +			goto unlock;
> +

[Severity: Medium]
The commit message says:

  "Skip them again in this state, as TCP does: the subflow is still
  moved to TCP_CLOSE, and a later SYN-ACK gets a reset from the stack."

With this branch, a SYN_SENT subflow leaves mptcp_do_fastclose() with only
send_fastclose set. It is still TCP_SYN_SENT and still hashed.

The move to TCP_CLOSE happens later, in __mptcp_close_ssk(), after it
takes the ssk lock again:

    if (subflow->send_fastclose && ssk->sk_state != TCP_CLOSE)
        tcp_set_state(ssk, TCP_CLOSE);

Can a SYN-ACK complete the handshake between these two points? There
are two ways it could reach the subflow in this window. It could already
be on the ssk backlog when release_sock(ssk) runs __release_sock(). It
could also arrive in softirq before __mptcp_close_ssk() takes the lock.
That second case can happen in mptcp_disconnect() -> mptcp_destroy_common(),
after sk_stream_wait_close() in __mptcp_close(), or in the close timeout
loop in mptcp_worker().

In either case the SYN-ACK would go through:

tcp_rcv_synsent_state_process()
  tcp_finish_connect()              /* ssk becomes ESTABLISHED */
    subflow_finish_connect()        /* icsk_af_ops->sk_rx_dst_set */
      mptcp_finish_connect()
        mptcp_pm_new_connection()   /* MPTCP_EVENT_CREATED */

subflow_finish_connect() does not check whether the msk is TCP_CLOSE or
whether msk->fastclosing is set. The third ACK with MP_CAPABLE would go
out and the peer would create an established connection. Userspace would
also get MPTCP_EVENT_CREATED after the connection was already reported
closed.

After that, __mptcp_close_ssk() moves the now-ESTABLISHED subflow straight
to TCP_CLOSE. The tcp_disconnect() called from __mptcp_subflow_disconnect()
then starts with old_state == TCP_CLOSE, so tcp_need_reset() is false and
no RST is sent. The __tcp_close() path for non-first subflows doesn't
send one either. Wouldn't the peer be left half-open?

Plain TCP has no such window. tcp_disconnect() sets TCP_CLOSE and
unhashes the socket while it holds the socket lock. A backlogged SYN-ACK
then hits the TCP_CLOSE case in tcp_rcv_state_process(), and a later one
finds an unhashed tuple and gets a reset from the stack.

The reset this patch removes probably didn't prevent the problem before
either. tcp_acceptable_seq() returns tcp_wnd_end(), which is the ISN in
SYN_SENT because snd_wnd is 0 and rx_opt.wscale_ok is not set yet. The
peer's tcp_check_req() expects ISN+1, so it would drop that reset as out
of window. The window therefore seems to date from ae155060247b, named in
the Fixes: tag. Even so, this patch doesn't fully deliver the "as TCP
does" behaviour described in the commit message.

Could this branch move the subflow to TCP_CLOSE, for example with
tcp_set_state(ssk, TCP_CLOSE), before jumping to release_sock(ssk)?

>  		/* Initialize rcv_mss to TCP_MIN_MSS to avoid division by 0
>  		 * issue in __tcp_select_window(), see tcp_disconnect().
>  		 */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f%40kernel.org
