Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795569401;
	b=0p/A5XAbFXXt5sWK1YLtdi9CbxKDUGYXSBs8DIaTnTtvI8DcS8dkyuQZeFcnPxN4EF/K
	 zk+zCgQzUDoGQyqSmtXzuGhIwzHQVKK13jr8jnKBXzmFVpSZKK15+zuOlCAQ0KmtNUBYn
	 YWSrqyRBzsAaaXdL+6eIiKAwojzfotDfkza1Lw4F8ikIKgn1zfwpltEZy//H7AkJ1qi7+
	 7E5LnQJKdaQcf6I+W9PW3qU+zLmIA2ehOCOKTE1sxglamOkvSIALAV7owtk/X3wMElqB0
	 xPOPo8FPeRaAUtWCdFpDOm5HB7k698WKopAsZrve3wvSEZGERUYmIuIVHrzMKiFeEZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795569401;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=mPeUKVrby5s/00oAftRiuhUntjSJr3dyrU8f5MuDaoY=;
	b=XEZSf+0ONhPdKTwykRi8efnkv47urytm49cv/TYl4TInJLVz6Im0nGzGU2TOn9PlaFsr
	 724YPAxn/FwE1GBAqFO8GHL0xQlZfSsHxhit9ZBWuLTsm9nnXcagHgedlw6nkA6vGlwQj
	 Pqaj3l2X9LhlXdoCKaC1Jxu/aW9Reb4sWHeKjGFA6BPnyINo82Vo9/NOIMF0HCrJeQLg/
	 sPHDdhDIO8rMzt5YtRohqbldFHD9J+h+lApbDcpNoHZZbhRA4dew0lTklNYs3AAuGdAiK
	 S+MXOdg7GplJymW28VY6BEtkzsTYNp+3qtBssaWhp0CoVK5sfA7Ga+WlfzmR1gVAidg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mI48Sa6f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C16D606A31E
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mI48Sa6f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2F61F000CA;
	Wed, 25 Nov 2026 01:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795569400;
	bh=mPeUKVrby5s/00oAftRiuhUntjSJr3dyrU8f5MuDaoY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=mI48Sa6fvhWqssFGXIRU04RQmsqaI0w7PX0iMcoPfntd24EjqP6haRv7MIZHxX3M8
	 5ZznwTx/U2FFA8gN7H6AcE9caR+jzilgSJXGNQ6IowDeuLtdjdAbdJkdCHWzzit+SP
	 qT0Bd1HDF1YNPEEe2Jh+zcg4fUmbJLKr1td3qSy0aSgTVoaEq7q9uaKcSZUnwT7T41
	 4THk2FBtQ86TMmCsI4e6tnTEOfN6FUwXFqgIyU5fcLt+Le9/Do1FhvoQHeXDFislBv
	 KmJMQy3+XH2ucA6yoDqgifRa44kd/GyCkb459C1kb6k99v9yuk1YlAqSV0pNLKnnSb
	 2vJnlroA3LP9g==
Date: Tue, 24 Nov 2026 17:16:40 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net v3 01/50] mptcp: keep an orphan while it can
 send its data
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-1-416c0920c73f@kernel.org>
Message-ID: <61bfa741-5112-5709-c5ab-95e609fcdd7b@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org> <20261124-mptcp-cmason-fixes-v3-1-416c0920c73f@kernel.org>
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

> The close timeout of an orphaned MPTCP socket started at close(), and
> its expiry reset the connection, while some data could still be waiting
> for the peer to open its window: a peer reading slowly or pausing got a
> reset 60 seconds after close(), and lost the end of the data, while TCP
> delivers it.
>
> This timeout is there for the DATA_FIN exchange, see commit d866ae9aaa43
> ("mptcp: add a new sysctl for make after break timeout"), and for an
> orphan that can no longer send anything. So restart it when the DATA_FIN
> is sent, and when it expires before, as long as a subflow can still send
> the data, which is then pushed again: an established subflow, on which
> the peer acked something recently, at least the window probes. Until
> then, as for a TCP socket that is not orphaned, nothing limits how long
> the peer can keep its window closed, while it acks the window probes.
> The timeout still starts at close(): the subflows are not TCP orphans,
> so its expiry is the only check that the orphan can still send.
>
> This was reported on GitHub, with a reproducer: a server writes 2 MB,
> then calls close(), while the client pauses before reading the rest.
> After a pause of 90 seconds, the client got ECONNRESET, while TCP
> delivered everything, as MPTCP now does. If the client vanishes instead,
> the orphan is now reset as TCP does.
>
> Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/647
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

v2 LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> v2: new, for issue #647 reported on GitHub
>
> Note (Clashiko on v2): when the last subflow is closed in the same
> worker run, before the DATA_FIN is sent, the destruction of the orphan
> is delayed once, by the close timeout. Not restarting the timeout once
> expired would reset an orphan sending its DATA_FIN after a long probing.
> ---
> net/mptcp/protocol.c | 31 +++++++++++++++++++++++++++++++
> 1 file changed, 31 insertions(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d64e04245963..944c9d11d211 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2871,6 +2871,28 @@ static bool mptcp_close_tout_expired(const struct sock *sk)
> 		  inet_csk(sk)->icsk_mtup.probe_timestamp + mptcp_close_timeout(sk));
> }
>
> +/* Before its DATA_FIN, keep an orphan while a subflow can send its data */
> +static bool mptcp_orphan_keep(struct sock *sk)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> +
> +	if (!sock_flag(sk, SOCK_DEAD) || msk->snd_nxt == msk->write_seq)
> +		return false;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +		/* a live peer acks at least the probes, every TCP_RTO_MAX */
> +		if (__mptcp_subflow_active(subflow) &&
> +		    tcp_jiffies32 - READ_ONCE(tcp_sk(ssk)->rcv_tstamp) <
> +		    2 * TCP_RTO_MAX)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> static void mptcp_check_fastclose(struct mptcp_sock *msk)
> {
> 	struct mptcp_subflow_context *subflow, *tmp;
> @@ -3208,6 +3230,11 @@ static void mptcp_worker(struct work_struct *work)
> 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
> 		__mptcp_close_subflow(sk);
>
> +	if (mptcp_close_tout_expired(sk) && mptcp_orphan_keep(sk)) {
> +		mptcp_start_tout_timer(sk);
> +		__mptcp_push_pending(sk, 0);
> +	}
> +
> 	if (mptcp_close_tout_expired(sk)) {
> 		struct mptcp_subflow_context *subflow, *tmp;
>
> @@ -3449,6 +3476,10 @@ static void mptcp_check_send_data_fin(struct sock *sk)
>
> 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
>
> +	/* an orphan's close timeout is for the DATA_FIN exchange */
> +	if (sock_flag(sk, SOCK_DEAD))
> +		mptcp_start_tout_timer(sk);
> +
> 	mptcp_for_each_subflow(msk, subflow) {
> 		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
>
>
> -- 
> 2.55.0
>
>
>
