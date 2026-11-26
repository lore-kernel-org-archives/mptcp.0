Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658251;
	b=ZTro0JbdhIkb/N5G5GR4nsFy0Dk1KvKxny56AP8CUNZ7H0uojWlh0Y18Yk52zK4RPutV
	 Ogv+w9d/DQ5JYwGTsVBD6Ip5qZQ0wiXmMA9R4tcDqA5ZUmqcAjVzVbK7xoztnyNgePEr/
	 xklQ45AMp9lOebELUMtNbgu+cLMj1KDeFYQIu/4bBBLxXWlRO2t777l29SLHNs7DCDCdU
	 M+E80aD7w5uTCF9Lf9Gp13pW8VYceephDkvQU991sYk492bv0b6tUNVqTyDF3CdlXF57p
	 HieU8YYSU8FadXA5C/aJ8wEceW48HCeyITGDKXT2V8ld5CQ+NWm+ifySSykRTB5UK8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658251;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=k3eyClEgY/2ihcpUbppSkoJp770WTfbu0WxrcjvIXYU=;
	b=erXVEdvijU2+WJ0rs4xA6GV26au8xT+KngGU8RNFPcZyJYqtAeoHK3cD3Bj7SPiLfSwb
	 jk7maE9oRdSL8Tb5MGV8GiDmyCmP3Gtr8BE36H/0IVJfwe1Gy9AzQhj9ONo9wXbCwAYdU
	 CbtxQf9UKhV7Q+Gzn9+ce+hT8DDNLBeRe/8O49vIMOg8Wh9xSAZGhb3yM9CgtDh/4pfPq
	 wiRt5vfgXXXlUOb8wUEITOrjlRZLWF/tdAg5sTPnwIPazqlzb+ifW31CV5B6bDpUN8Jx/
	 Bi6W52dPqZ7A2Q62D/kv0opvhc1Gat/h/cBCeQaFbFp9Tgt0zXOs4nmZDQ7RvRn76pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8wM0FHN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BF7606A68B
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 01:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8wM0FHN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7491F00A36;
	Thu, 26 Nov 2026 01:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658251;
	bh=k3eyClEgY/2ihcpUbppSkoJp770WTfbu0WxrcjvIXYU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=J8wM0FHN9xdqgEcCYHrELQfwRvoBy11qBfsJ/U7cH+D6dobvZQg0K8+0Aut8wW+qI
	 idiUAQFUbtDEw6WFv00bP6R6N2hCO4r9BoLRsajvTbRc5h610VhZn6H6T6feMyPrc0
	 KxCmQy7dnJWMy2h4LSl1rUZNzVq09kRjPUSioTZm6AzHDja+TO2hns60lZ1bIL+oHg
	 Gf3tkkopa/Qyhl3OvaA/HFbE3JM/MzgOLxHtsNVeJ4JM+GWqQRcqoJEkperUqOK4MK
	 WTSVIAoCfLwIRJgdOQofle5tr1EC09tVEYUE7yGQswZCw4wQvZ308POM8ZrkNyWeDq
	 zkmqkymv027Hw==
Date: Wed, 25 Nov 2026 17:57:29 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net v3 04/50] mptcp: return EOF after a DATA_FIN,
 as TCP does
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-4-416c0920c73f@kernel.org>
Message-ID: <39c8abe7-1af4-7e26-a394-f7cf0b5d86d8@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org> <20261124-mptcp-cmason-fixes-v3-4-416c0920c73f@kernel.org>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 24 Nov 2026, Matthieu Baerts (NGI0) wrote:

> Once an MPTCP socket has received a DATA_FIN, recv() returns the
> remaining data, then EOF. But if the connection was then reset, e.g. by
> an MP_FASTCLOSE, recv() returned an error after the data, e.g. EPIPE,
> instead of EOF as TCP does. A proxy resetting the other connection on
> read errors then dropped the data it still had to forward.
>
> As TCP does with a FIN, set SOCK_DONE when processing the DATA_FIN, and
> check it before the socket error in recvmsg(). With an MP_FASTCLOSE, the
> data still in the backlog is moved first, not to miss the DATA_FIN.
> After a fallback, a DATA_FIN is also emulated after a reset: only set
> SOCK_DONE after a FIN, not to hide a reset behind an EOF. This FIN is
> cleared when the first subflow is disconnected: process this DATA_FIN
> before.
>
> This was reported on GitHub, and is validated with new Packetdrill
> tests: data and a DATA_FIN are received, then an MP_FASTCLOSE; and
> after a fallback, data, a FIN and a reset. Without this patch, the
> second read() returned EPIPE in both cases:
>
>  receive_fastclose_after_data_fin.pkt:27: runtime error in read call: Expected result 0 but got -1 with errno 32 (Broken pipe)
>  v1_connect_tcpfallback_fin_reset.pkt:19: runtime error in read call: Expected result 0 but got -1 with errno 32 (Broken pipe)
>
> Note for the backports: the issue with an MP_FASTCLOSE comes from commit
> 69800e516e96 ("mptcp: propagate fastclose error"), in v6.1. Before that,
> the modifications in mptcp_check_fastclose() and mptcp_disconnect() are
> not needed.
>
> Fixes: 15cc10453398 ("mptcp: deliver ssk errors to msk")
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/647
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> v2: new, for issue #647 reported on GitHub
> v3: process the DATA_FIN before disconnecting the first subflow, which
>    clears its FIN (Clashiko)
>
> Note (Clashiko on v2): with a DATA_FIN, then an MP_FASTCLOSE in
> FIN_WAIT2, the reset subflows are only released at close(): not a leak.
> A DATA_FIN mapped on another CPU while an MP_FASTCLOSE is processed can
> still lead to ECONNRESET: two subflows racing, and the connection reset
> by the peer anyway.
> ---
> net/mptcp/protocol.c | 31 +++++++++++++++++++++++++++++--
> 1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9e297fa08bfe..de6da0b6c4ca 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -714,6 +714,10 @@ static void mptcp_check_data_fin(struct sock *sk)
> 		WRITE_ONCE(msk->rcv_data_fin, 0);
>
> 		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
> +		/* on fallback, also emulated after a reset: check for a FIN */
> +		if (!__mptcp_check_fallback(msk) ||
> +		    (msk->first && sock_flag(msk->first, SOCK_DONE)))
> +			sock_set_flag(sk, SOCK_DONE);
> 		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
>
> 		switch (sk->sk_state) {
> @@ -972,6 +976,9 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
> 	 * destroy the msk as needed.
> 	 */
> 	ssk_state = inet_sk_state_load(ssk);
> +	/* a FIN received before still leads to EOF, as with TCP */
> +	if (sock_flag(ssk, SOCK_DONE) && mptcp_pending_data_fin(sk, NULL))
> +		sock_set_flag(sk, SOCK_DONE);
> 	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
> 		mptcp_set_state(sk, ssk_state);
> 	WRITE_ONCE(sk->sk_err, -err);
> @@ -2494,6 +2501,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> 			    !timeo)
> 				break;
> 		} else {
> +			if (sock_flag(sk, SOCK_DONE))
> +				break;
> +
> 			copied = sock_error(sk);
> 			if (copied)
> 				break;
> @@ -2813,6 +2823,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 		     struct mptcp_subflow_context *subflow)
> {
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +
> 	/* The first subflow can already be closed or disconnected */
> 	if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
> 		return;
> @@ -2820,12 +2832,21 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 	subflow->close_event_done = true;
>
> 	if (sk->sk_state == TCP_ESTABLISHED)
> -		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
> +		mptcp_event(MPTCP_EVENT_SUB_CLOSED, msk, ssk, GFP_KERNEL);
>
> 	/* subflow aborted before reaching the fully_established status
> 	 * attempt the creation of the next subflow
> 	 */
> -	mptcp_pm_subflow_check_next(mptcp_sk(sk), subflow);
> +	mptcp_pm_subflow_check_next(msk, subflow);
> +
> +	/* On fallback, the FIN of the first subflow is cleared when it is
> +	 * disconnected: process the DATA_FIN emulated from it before.
> +	 */
> +	if (ssk == msk->first && __mptcp_check_fallback(msk) &&
> +	    READ_ONCE(msk->rcv_data_fin) && !sock_flag(sk, SOCK_DEAD)) {
> +		mptcp_move_skbs(sk);
> +		mptcp_check_data_fin(sk);
> +	}
>
> 	__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_PUSH);
> }
> @@ -2938,6 +2959,11 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
> 	if (likely(!READ_ONCE(msk->rcv_fastclose)))
> 		return;
>
> +	/* a DATA_FIN received before still leads to EOF, as with TCP */
> +	if (READ_ONCE(msk->rcv_data_fin))
> +		mptcp_move_skbs(sk);
> +	mptcp_check_data_fin(sk);
> +
> 	mptcp_token_destroy(msk);
>
> 	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> @@ -3797,6 +3823,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
> 	atomic64_set(&msk->rcv_wnd_sent, 0);
>
> 	WRITE_ONCE(sk->sk_shutdown, 0);
> +	sock_reset_flag(sk, SOCK_DONE);
> 	sk_error_report(sk);
> 	return 0;
> }
>
> -- 
> 2.55.0
>
>
>
