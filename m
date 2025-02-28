Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7568A23F38A
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740778761; cv=none; b=lIk1Ebld44Y0IbVR69/OADEOnwNJEuQhJIOl0S2qSVDFWV0gbj/DYn6jxF+aA5hqXcaxLupNiHOkFKTJ4dzrSyHUqjNv7fTtdbQGN1LMBMg4GXgNzcRUGTdvLEthKCYoPI1ep3wgcoozAws4NzkKZ6oGgguAhltIwK03peHp4jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740778761; c=relaxed/simple;
	bh=iGrID9w7X5gL2P/EAL/bNKa+56pg23Rp3DlcxMXoPM8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ldij49HoowuL7xPRmBirxAmYrEacwrM4ykFChlALLIm5sfLG4CqbBXwslsiS5I/449Dkg2OoktrsuV+buo+BbY3jXE8OSwLg58PXRMxgC2ac8/i8d2sqcyPSA1PAfMd41kTYCffGzKdYZgMs+iLijnJS1Pyn6LbNfCp7fmIAUYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6DpW2AU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6DpW2AU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B272C4CED6;
	Fri, 28 Feb 2025 21:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740778761;
	bh=iGrID9w7X5gL2P/EAL/bNKa+56pg23Rp3DlcxMXoPM8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Q6DpW2AU0tIuWO/Pe8uIyFDH+N0nBADucyAlg5C7ZVoo5cVPfs2780r7BlBUojVMZ
	 bI73xENu7ncaY0qzgeGrYsJjSXlUDWTE2H+/rN0oV5o460LGRtdQVPdkuFAImdfrcH
	 NO94A51L9R7m1giodolNZwlFEnxqFgAw3hH45tD6fY6METCGO3iVvZZu7TCEflW9li
	 TnE6/6em3GYKUCyL/7rP2YyRLsQmL/2X6ESbiZaDdn5Rx5n57JHwvZKb+qdC9TL4Rn
	 tSEbFzX/RLRm8rdtN9u1IwbmIiTwNZRbiaRDuwjwZS9u70fwRppQK7xvG23EZFObVZ
	 /upRxwTimgc8g==
Date: Fri, 28 Feb 2025 13:39:20 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH mptcp-next] tcp: ulp: diag: remove net admin
 restriction
In-Reply-To: <20250226-mptcp-tcp-ulp-diag-cap-v1-1-e1a003ad0606@kernel.org>
Message-ID: <42c413ff-744d-8b1f-e1ee-31edf0263646@kernel.org>
References: <20250226-mptcp-tcp-ulp-diag-cap-v1-1-e1a003ad0606@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 26 Feb 2025, Matthieu Baerts (NGI0) wrote:

> Since its introduction in commit 61723b393292 ("tcp: ulp: add functions
> to dump ulp-specific information"), the ULP diag info have been exported
> only if the requester had CAP_NET_ADMIN.
>
> It looks like there is nothing sensitive being exported here by the
> MPTCP and KTLS layers. So it seems safe to remove this restriction in
> order to ease the debugging from the userspace side without requiring
> additional capabilities.
>

Hi Matthieu -

I agree the token values aren't sensitive (we definitely wouldn't want to 
expose the keys exchanged with MP_CAPABLE, for example). Token values are 
like port numbers in terms of what's exposed.

The DSS mapping and ssn_offset do give all users on the system access to 
narrow ranges of values for the subflow TCP sequence numbers and 
MPTCP-level DSNs. The diag interface doesn't expose TCP sequence numbers 
for TCP sockets, it doesn't seem like a good idea to leak those through 
the mapping values either. WDYT?

- Mat

> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/ipv4/tcp_diag.c | 15 +++++++--------
> 1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
> index f428ecf9120f2f596e1d67db2b2a0d0d0e211905..8257bd85e067ee862034c95745216c443113bdb0 100644
> --- a/net/ipv4/tcp_diag.c
> +++ b/net/ipv4/tcp_diag.c
> @@ -113,6 +113,7 @@ static int tcp_diag_get_aux(struct sock *sk, bool net_admin,
> 			    struct sk_buff *skb)
> {
> 	struct inet_connection_sock *icsk = inet_csk(sk);
> +	const struct tcp_ulp_ops *ulp_ops;
> 	int err = 0;
>
> #ifdef CONFIG_TCP_MD5SIG
> @@ -129,15 +130,13 @@ static int tcp_diag_get_aux(struct sock *sk, bool net_admin,
> 	}
> #endif
>
> -	if (net_admin) {
> -		const struct tcp_ulp_ops *ulp_ops;
> -
> -		ulp_ops = icsk->icsk_ulp_ops;
> -		if (ulp_ops)
> -			err = tcp_diag_put_ulp(skb, sk, ulp_ops);
> -		if (err)
> +	ulp_ops = icsk->icsk_ulp_ops;
> +	if (ulp_ops) {
> +		err = tcp_diag_put_ulp(skb, sk, ulp_ops);
> +		if (err < 0)
> 			return err;
> 	}
> +
> 	return 0;
> }
>
> @@ -164,7 +163,7 @@ static size_t tcp_diag_get_aux_size(struct sock *sk, bool net_admin)
> 	}
> #endif
>
> -	if (net_admin && sk_fullsock(sk)) {
> +	if (sk_fullsock(sk)) {
> 		const struct tcp_ulp_ops *ulp_ops;
>
> 		ulp_ops = icsk->icsk_ulp_ops;
>
> ---
> base-commit: 1238896935ea03f333a183a32fab666cc0c20e3b
> change-id: 20250226-mptcp-tcp-ulp-diag-cap-a4d9b7cd91ec
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
