Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB45F1C32
	for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737073612; cv=none; b=OlCXqZj3UkrnA4WGz16f21NrH9WNbidErtuf8/4ujyots3qc9dXWHj0PaqDo1uMlbse47DmLBM/Uj2ySoXJpbe2yGHQ9SoPJI/E19T5z9E5xSFcAj35Pbo8c1Dzly4VTa6ziKQ/cAw0b62bs2huOQCeyRHRcvydokKuQsh/UCMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737073612; c=relaxed/simple;
	bh=G8BWldJgu7xyKI5dQJaqUtOA6oFCXDJJcjIX94rMBXc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ssqS+R/BkjqSDOA8u4EjGG+yjqqg1gLcBwjyh0enHlbuQzSq6KMfTfB1uUdV3Z08S7j8V6uQ4YdgHprdlQGOgk4lPZg6vaqC+IKBbeH170rNHeVCO/yKygejrkvYdpgyRC3bcOQ2urcZcMLnNsP3Tw3ybw5iy8+0tk4wtB6NvwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKfOvPb9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKfOvPb9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E915C4CED6;
	Fri, 17 Jan 2025 00:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737073612;
	bh=G8BWldJgu7xyKI5dQJaqUtOA6oFCXDJJcjIX94rMBXc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=YKfOvPb9+RD6ga9YVLCg5vp42j4Lwd+27iajbttIgXvPhjVrgGL0sY1O0Dl83BRPh
	 6lsfYlj1syQvcrtnI68fQD6ya7PP26z8zLsiJpvIqCkA401+5x3vunTCBcUF6UELaZ
	 sbGI3ZQeBBWDEz+8v4fhbVIYP8fO4PhSmN7FrnMQOdqiFvgfWl+7fi+gy1WRi1ncsE
	 PfUPml5/cz5i/ss3hMaj+Bobl2Bk32Oi6TrMr4FnwgcyW7D+03jKklzFycf2eubijp
	 1dhAh26sV9aU055T8rQipjtB9BDpOgbSeMYWfypNU5/GnxgRx+VIC8BIhK3CToA9kJ
	 MSGgxK86SXsoA==
Date: Thu, 16 Jan 2025 16:26:51 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/3] mptcp: blackhole only if 1st SYN retrans
 w/o MPC is accepted
In-Reply-To: <20250114-mpc-no-blackhole-v1-3-994bd2a357fb@kernel.org>
Message-ID: <91ff8079-cb49-0b23-57bd-c18f6dc1ff87@kernel.org>
References: <20250114-mpc-no-blackhole-v1-0-994bd2a357fb@kernel.org> <20250114-mpc-no-blackhole-v1-3-994bd2a357fb@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 14 Jan 2025, Matthieu Baerts (NGI0) wrote:

> The Fixes commit mentioned this:
>
>> An MPTCP firewall blackhole can be detected if the following SYN
>> retransmission after a fallback to "plain" TCP is accepted.
>
> But in fact, this blackhole was detected if any following SYN
> retransmissions after a fallback to TCP was accepted.
>
> That's because 'mptcp_subflow_early_fallback()' will set 'request_mptcp'
> to 0, and 'mpc_drop' will never be reset to 0 after.
>
> This is an issue, because some not so unusual situations might cause the
> kernel to detect a false-positive blackhole, e.g. a client trying to
> connect to a server while the network is not ready yet, causing a few
> SYN retransmissions, before reaching the end server.
>
> Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/ctrl.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 3999e0ba2c35b50c36ce32277e0b8bfb24197946..2dd81e6c26bdb5220abed68e26d70d2dc3ab14fb 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c

Some more context before the diff hunk:

> 	if (subflow->request_mptcp && ssk->sk_state == TCP_SYN_SENT) {
> 		struct net *net = sock_net(ssk);
> 		u8 timeouts, to_max;
>
> 		timeouts = inet_csk(ssk)->icsk_retransmits;
> 		to_max = mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback;
>
> 		if (timeouts == to_max || (timeouts < to_max && expired)) {

I think it would help to change the above code to:

> 	if (ssk->sk_state == TCP_SYN_SENT) {
> 		struct net *net = sock_net(ssk);
> 		u8 timeouts, to_max;
>
>		if (!subflow->request_mptcp) {
> 			subflow->mptcp_drop = 0;
> 			return;
> 		}
>
> 		timeouts = inet_csk(ssk)->icsk_retransmits;
> 		to_max = mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback;
>
> 		if (timeouts == to_max || (timeouts < to_max && expired)) {

(end of added hunk)

> @@ -418,9 +418,9 @@ void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
> 			MPTCP_INC_STATS(net, MPTCP_MIB_MPCAPABLEACTIVEDROP);
> 			subflow->mpc_drop = 1;
> 			mptcp_subflow_early_fallback(mptcp_sk(subflow->conn), subflow);
> -		} else {
> -			subflow->mpc_drop = 0;
> 		}

And drop this from the patch:

> +	} else if (ssk->sk_state == TCP_SYN_SENT) {
> +		subflow->mpc_drop = 0;

That way ssk->sk_state is only checked once.

- Mat
