Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795569686;
	b=zOCT01kG1/vVBpH8c5fNvqjUufsRnrr9dtVz/WQI3Zv3jsbELaN49Q70vY9Jm9+c1ToL
	 fzUfTKyimixR/6upwNLpnZXmAodOlrYqR9wsXEOBcx8Y/QcwwOpKY3+nvkJA3gkwH6JFU
	 EiGf2TUlwNQ+sik/ANDtTaXJf9JqehjHvmctk4Y3IFjo2yDEge/vah2mqSj3FFxs5SW7Z
	 0UjQyzxUVHVv2TYYqas4dCcGrmlpFGpJjnYWYQGs/0Uftox5S+SVymwwsOLfWuTVPmHIo
	 gYKSH9ONBLqjOaX/ZCmEtfmEcoPv2hKq5lxogWHIaeuthjNlcz3+I/NMhzxLpbUEwAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795569686;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=GXi1aaTtmSj7TVSgPnBO8IcgHLEk08kh+UlOmbAaeW8=;
	b=GCjT3uDdLKVw4J6VzFMsT8syz7jsAknQ+9ebDhURoCyzRRMlo78mFT7dpDKLuz+zHhi7
	 3+534AgIwUXfcFm5aGZo/cDcTTiMcyoTTZopYj6sujX5wXDAAN3kpfyjlGjw0HGoegOFV
	 ar38KeUShiVIM4ffOSYqm5KRHJSNK3EJMTiYaifFlCswnlFrF7i6sz6IgHoHff/Tx8EEr
	 Af+RCEJGk9nFJTIXxrkspZoN2rEanxn3aq+8cPiHL/JDfJvgVtzCD+DeD969QiL+epSeU
	 GihrLKTWttTdGUnQpUMKTZg/ozI3jdl9Mw07bB3OB2RwJQrbgCa7U7TpS4zwiPamutQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIhfTrua;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F58C606A31E
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 01:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIhfTrua
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433671F000CA;
	Wed, 25 Nov 2026 01:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795569686;
	bh=GXi1aaTtmSj7TVSgPnBO8IcgHLEk08kh+UlOmbAaeW8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=LIhfTruak7Q3eRWZWT0vpiKuJj7JvUTyQcWYnKDOcbiHFEc+Y8pRStMC5z6gIGNex
	 QbR1rqWnDyZ3s6DjDp03WrCsYfWaBMkLnVCTa82iY6aIGEKPhQRQ7Yv1hc8VpDN1Vy
	 KmI5R99hZoIyF8ZfX0p6m0pQQn6jcfyYwpC96p28L+WpLuxlB4UlnQMV/G/Hh8l2Rk
	 2t+L/q0ooyhVBkHUo5w1gSnFm3t0KCZdGLK7u1ST6FcJmNUaYkofaVSmF0nO85EVIP
	 dT4D8jR0txG+rySYIm3TCSAixf3TMkd/ilchKIraMCr1ZEpsUBxfJH/EVquxlUGTWR
	 86gw7LTSwt/UQ==
Date: Tue, 24 Nov 2026 17:21:25 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net v3 03/50] mptcp: count orphans as TCP does
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-3-416c0920c73f@kernel.org>
Message-ID: <3c2617a1-5fa9-eb64-65f1-4be239d29c7e@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org> <20261124-mptcp-cmason-fixes-v3-3-416c0920c73f@kernel.org>
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

> The MPTCP sockets orphaned by close() were not counted in
> tcp_orphan_count, contrary to TCP: tcp_max_orphans did not limit them,
> and they were not visible in /proc/net/sockstat.
>
> This is all the more needed since commit "mptcp: keep an orphan while it
> can send its data": an orphan can then be kept longer than its close
> timeout, e.g., as Sashiko noticed, by a peer acking the data at the TCP
> level only, without moving the DATA_ACK.
>
> Count them, and as TCP does, reset an orphan when there are too many
> orphans, or when TCP uses too much memory: at close(), and when its
> close timeout expires while it is kept to send its data. This is similar
> to what tcp_out_of_resources() does from the TCP timers, without the
> stricter limit for the stalled orphans. These resets are counted in
> TCPAbortOnMemory, not in a new MPTCP counter: the MPTCP orphans now
> share the TCP orphan count and limits.
>
> This has been found by a review agent, and validated with a script
> closing 8 connections whose peer doesn't read, with tcp_max_orphans set
> to 4: the MPTCP orphans were all kept, without being counted, while
> other orphans were reset. Now, only 5 or 6 are kept, vs 4 or 5 with TCP,
> which also checks the limit from the timers of its orphans.
>
> Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> v2: new, spotted by a review agent
>
> Note (Clashiko on v2): the reset reason stays TCP_ABORT_ON_CLOSE, as for
> the other fastclose resets: only the tracepoint is affected.
> ---
> net/mptcp/protocol.c | 24 ++++++++++++++++++++++--
> net/mptcp/protocol.h |  1 +
> 2 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ff71f1954077..9e297fa08bfe 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2897,6 +2897,16 @@ static bool mptcp_subflow_probe_timed_out(struct sock *ssk)
> 	return ret;
> }
>
> +/* As TCP orphans: limited in number and memory */
> +static bool mptcp_orphan_oom(struct sock *sk)
> +{
> +	if (!tcp_check_oom(sk, 0))
> +		return false;
> +
> +	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONMEMORY);
> +	return true;
> +}
> +
> /* Before its DATA_FIN, keep an orphan while a subflow can send its data */
> static bool mptcp_orphan_keep(struct sock *sk)
> {
> @@ -2914,7 +2924,7 @@ static bool mptcp_orphan_keep(struct sock *sk)
> 		    tcp_jiffies32 - READ_ONCE(tcp_sk(ssk)->rcv_tstamp) <
> 		    2 * TCP_RTO_MAX &&
> 		    !mptcp_subflow_probe_timed_out(ssk))
> -			return true;
> +			return !mptcp_orphan_oom(sk);
> 	}
>
> 	return false;
> @@ -3547,6 +3557,9 @@ static void __mptcp_destroy_sock(struct sock *sk)
> 	sk_stream_kill_queues(sk);
> 	xfrm_sk_free_policy(sk);
>
> +	if (test_and_clear_bit(MPTCP_ORPHAN_COUNTED, &msk->flags))
> +		tcp_orphan_count_dec();
> +
> 	sock_put(sk);
> }
>
> @@ -3636,8 +3649,15 @@ bool __mptcp_close(struct sock *sk, long timeout)
> 	/* all the subflows are closed, only timeout can change the msk
> 	 * state, let's not keep resources busy for no reasons
> 	 */
> -	if (subflows_alive == 0)
> +	if (subflows_alive == 0) {
> 		mptcp_set_state(sk, TCP_CLOSE);
> +	} else if (sk->sk_state != TCP_CLOSE) {
> +		/* as TCP orphans: counted, and limited */
> +		tcp_orphan_count_inc();
> +		set_bit(MPTCP_ORPHAN_COUNTED, &msk->flags);
> +		if (mptcp_orphan_oom(sk))
> +			mptcp_do_fastclose(sk);
> +	}
>
> 	sock_hold(sk);
> 	pr_debug("msk=%p state=%d\n", sk, sk->sk_state);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 2c9a442dacd6..888ee9d66967 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -117,6 +117,7 @@
> #define MPTCP_FALLBACK_DONE	2
> #define MPTCP_WORK_CLOSE_SUBFLOW 3
> #define MPTCP_RTX_ENABLED	4
> +#define MPTCP_ORPHAN_COUNTED	5
>
> /* MPTCP socket release cb flags */
> #define MPTCP_PUSH_PENDING	1
>
> -- 
> 2.55.0
>
>
>
