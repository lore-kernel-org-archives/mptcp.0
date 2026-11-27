Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795741252;
	b=J3PfNcirFFkZUQR9zWm16uoRXY8VgZ/puBk91amW6QMkEcwvTcWtyHTxO/yDBtUVaxfc
	 PHKo8oGWwME6/6fYHlCuhlff8LPZLN9F2aqWUaE9Cq/7DlORPHutl0JtTm5AQc0Jw85bi
	 6QUrz1MZFwL5DIT//gYegkewTy7qe4gYYB2ihjoYFqwSELnYnzglhwYLnaAf5HP7UYYZa
	 BtXkfTcKJFh8VpBalFxPzT4cxvzasnpSQ74iXs4kHmrwLtndWz4njDegHwDZR/nnOkP77
	 ZJHa3oEy5l9ftRrhDckTjdAxinubIfY7M/9h+rteuJA/+m4Lk+ljjLXiPA1+zuhIOqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795741252;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xhnWkhQ/u/hE+v2p9kK0TLtztvPtZiRlajvfeyQhhWE=;
	b=404f9vmgM5PezkUEX2wvLmc4aIfsI5VQwSAbkchA/mVYazqeh1scEylj0r4K1FaD3bA9
	 qZPZQvDOh5675p+vw4lJSoddS/CiQrQoKC8WrRQsDpEDqXkoL+VQcMev6u35nshgeYy/5
	 kxLkh293pA2fPBeiIkkxWmGvSMj17lx8BszLfp0+eXKssi8QuYwrTtxQVmgzk4PLvjSiP
	 oKbu+8bo2aetCxA+6qqf9NEfjEitJG8gAZXibZY2RC+ijkw4+zpt1o+WdJ6fhFgMCvx9v
	 qwETEjccsNpKx1fgTgF4fxcR5+1R7fT0sb0BW0boZJkCSEN87OAy1vO1dneiwEOTu5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXehlAat;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C5C606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXehlAat
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807B21F000C1;
	Fri, 27 Nov 2026 01:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795741251;
	bh=xhnWkhQ/u/hE+v2p9kK0TLtztvPtZiRlajvfeyQhhWE=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=PXehlAatHmjchHBwqofSUou7c+NSLi7U6kLaWygO5NxXfeZCqZcPg8FOwvllSUXrv
	 DMu/qhnv6yxU93/guv0EAj8M2Nt3D5tNxx4ePeonmNKGcWDJNQ1UykiVo00cUOU4Tt
	 6Vye7UFNCuac3rH5E3WH5UrOauuf/Ofnz3/pct5jdW6lkJLvV+moLT19h/dBqfTI1w
	 Egl0o1GPvNX/ok2piuE68LHhuwDk16PBX8sGPVuJHQgIzC6n6KHuA7bIZksplWLaCQ
	 GnCBCRnWZkeLdUjJKQwsTOMF7Y2jJR485mSB/JW92AwbZEMbWB7TgkmEiAaiB2HGRg
	 lnxxcaxILgU6g==
Message-ID: <3363a6547aa50f3f8ceaf2aced847bca39e3c2e1.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v3 17/50] mptcp: report sf aborts during
 deferred connect
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Fri, 27 Nov 2026 09:00:47 +0800
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-17-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
	 <20261124-mptcp-cmason-fixes-v3-17-416c0920c73f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10build1 
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

On Tue, 2026-11-24 at 22:59 +0100, Matthieu Baerts (NGI0) wrote:
> With TCP_FASTOPEN_CONNECT, connect() on an MPTCP socket only sets
> DEFER_CONNECT on the first subflow and on the msk, and the first write()
> sends the SYN with data via mptcp_sendmsg_fastopen().
> 
> If the first subflow is aborted by tcp_abort(), e.g. via a sock_diag
> destroy request or the bpf_sock_destroy() kfunc, while mptcp_sendmsg()
> already owns the msk socket and is waiting for the subflow lock:
> 
> - tcp_abort() clears DEFER_CONNECT on the subflow, and moves it to
>   TCP_CLOSE;
> - subflow_error_report() can only set MPTCP_ERROR_REPORT, because the
>   msk is owned by the user: the msk stays in SYN_SENT, with
>   DEFER_CONNECT still set.
> 
> tcp_sendmsg_fastopen() then skips tcp_connect(), and calls
> __inet_stream_connect() with the msk socket, the first subflow being
> grafted to it. Because DEFER_CONNECT is set on the msk, -EISCONN is
> returned to userspace, on a connection that has just been aborted.
> 
> Detect this case once the subflow lock is held: if DEFER_CONNECT is set
> on the msk, but no longer on the subflow, the subflow has been aborted,
> or disconnected. Propagate the subflow error to the msk directly,
> instead of waiting for the msk release callback. mptcp_sendmsg() will
> then report this error via sk_stream_wait_connect(), like plain TCP
> after tcp_abort(), e.g. -ECONNABORTED. The deferred error report is then
> a no-op, so the error is not reported twice.
> 
> Without the race, the msk is already in TCP_CLOSE with the error set:
> the same check also avoids going through tcp_sendmsg_fastopen() and
> __inet_stream_connect() in this case, except with MSG_FASTOPEN. As TCP
> does, write() then reports the error without disconnecting the socket.
> With MSG_FASTOPEN, the socket has to be disconnected, as with TCP, for
> the next sendto() to connect again, and the race cannot happen:
> __mptcp_nmpc_sk() requires an msk in TCP_CLOSE.
> 
> Clearing DEFER_CONNECT on the msk from tcp_abort_override() instead
> would not be enough: tcp_abort() is called on the subflow without the
> msk lock, and mptcp_sendmsg() checks the msk bit before taking the
> subflow lock. The abort can then happen in between, and write() would
> return -EALREADY, followed by a disconnect of the msk dropping the
> deferred error. In this path, only mptcp_sendmsg_fastopen() holds both
> the msk and the subflow locks, and sees a consistent state.
> 
> This issue has been reported by Sashiko, while reviewing the commit
> below. It has not been reproduced: the abort has to happen while write()
> owns the msk socket, and waits for the subflow lock.
> 
> Fixes: 93723db43e51 ("tcp: Clear DEFER_CONNECT before tcp_connect() and in tcp_abort().")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

It took me a bit of time to understand this patch. Looks good to me!

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
> v2: new, for an issue spotted by Sashiko
> v3: comment and msg: also after a disconnect, and what write() does
>     without the race (Clashiko)
> ---
>  net/mptcp/protocol.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 257c851c8a76..87f6da0f6cab 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1960,8 +1960,6 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>  	/* on flags based fastopen the mptcp is supposed to create the
>  	 * first subflow right now. Otherwise we are in the defer_connect
>  	 * path, and the first subflow must be already present.
> -	 * Since the defer_connect flag is cleared after the first succsful
> -	 * fastopen attempt, no need to check for additional subflow status.
>  	 */
>  	if (msg->msg_flags & MSG_FASTOPEN) {
>  		ssk = __mptcp_nmpc_sk(msk);
> @@ -1974,6 +1972,19 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>  	ssk = msk->first;
>  
>  	lock_sock(ssk);
> +
> +	/* subflow aborted or disconnected: its error report may be deferred.
> +	 * With MSG_FASTOPEN, the socket is disconnected below, as with TCP.
> +	 */
> +	if (unlikely(!(msg->msg_flags & MSG_FASTOPEN) &&
> +		     inet_test_bit(DEFER_CONNECT, sk) &&
> +		     !inet_test_bit(DEFER_CONNECT, ssk))) {
> +		inet_clear_bit(DEFER_CONNECT, sk);
> +		__mptcp_subflow_error_report(sk, ssk);
> +		release_sock(ssk);
> +		return 0;
> +	}
> +
>  	msg->msg_flags |= MSG_DONTWAIT;
>  	msk->fastopening = 1;
>  	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
