Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6DD4A05
	for <mptcp@lists.linux.dev>; Sat, 24 Aug 2024 00:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724460263; cv=none; b=B92F2tQqGaV4eGI71JYEclidYTypU5aEpLQX9+4sYU30MDqXR3JTOpPCZHNqmBEvi0KuNTaXcEmOBx+itITndluPiA4zu9ZGj50kPDgP3dMTuU6jBZ2hrg/lIkn79+PP3zjGeYMEtdNajL9L/invDaQJOga10bgZX2T9df5HdoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724460263; c=relaxed/simple;
	bh=/WPzYD6Sg9+8nAt88zwpDV4P0hGDVqO8JpZdGXsi9/0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l1xFvem1RZBE8pgpwRbqCDL6tseuWVn9g7xaGeeb2sBTzmf8zma1CdRJL8WExJXv84lhIC9qVGusUSgSkhZRXyzM1V6OrOJx3QdXdi+YUnzKZARnRkxytdkUBE7fTpIDJ5LcLTgOycwdeX0kc/DD/L6lgkqzSR3E6S5cVAV6UZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SenMx2BM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SenMx2BM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346C7C32786;
	Sat, 24 Aug 2024 00:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724460263;
	bh=/WPzYD6Sg9+8nAt88zwpDV4P0hGDVqO8JpZdGXsi9/0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=SenMx2BMb3ac5Qm7kbR+qtR2Y0Sb4lL69frU6vjOyH3rk/nrSUTbBaS8zsGykhsxo
	 OWbQGDXdZGXUeAcx5hhEmMWQXdlvlHfvv1EmlrNxykhY0VloJSQ2WA3+iVDKV0r0eh
	 +w7630hxfrJ0WoCugnu9NVbQFSMPXkjkYTMZptAA+3z047ygUfZwqiCGzxucFxtbH8
	 RsjP6MyXehww8SE/heOo6O+xB7kI88L24Q5DZryf8Sd0FBSD+hvE8p4kVCtshP3AHG
	 i79a49q9fBfS4UoUFvIF5yXxbRAEjxCz5Y1tseSrl+heMXTkyokDscQMNM4o5KH8Zp
	 P51fvWxADLZ0w==
Date: Fri, 23 Aug 2024 17:44:22 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, 
    =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Subject: Re: [PATCH mptcp-net v2 09/12] mptcp: avoid duplicated SUB_CLOSED
 events
In-Reply-To: <20240816-mptcp-dup-close-evt-v2-9-8a33f6617f5c@kernel.org>
Message-ID: <35a841ef-ca3d-347f-43d1-fafd82639214@kernel.org>
References: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org> <20240816-mptcp-dup-close-evt-v2-9-8a33f6617f5c@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 16 Aug 2024, Matthieu Baerts (NGI0) wrote:

> The initial subflow might have already been closed, but still in the
> connection list. When the worker is instructed to close the subflows
> that have been marked as closed, it might then try to close the initial
> subflow again.
>
> A consequence of that is that the SUB_CLOSED event can be seen twice:
>
>  # ip mptcp endpoint
>  1.1.1.1 id 1 subflow dev eth0
>  2.2.2.2 id 2 subflow dev eth1
>
>  # ip mptcp monitor &
>  [         CREATED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
>  [     ESTABLISHED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
>  [  SF_ESTABLISHED] remid=0 locid=2 saddr4=2.2.2.2 daddr4=9.9.9.9
>
>  # ip mptcp endpoint delete id 1
>  [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
>  [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
>
> The first one is coming from mptcp_pm_nl_rm_subflow_received(), and the
> second one from __mptcp_close_subflow().
>
> To avoid doing the post-closed processing twice, the subflow is now
> marked as closed the first time.
>
> Note that it is not enough to check if we are dealing with the first
> subflow and check its sk_state: the subflow might have been reset or
> closed before calling mptcp_close_ssk().
>
> Fixes: b911c97c7dc7 ("mptcp: add netlink event support")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/protocol.c | 6 ++++++
> net/mptcp/protocol.h | 3 ++-
> 2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 13777c35496c..9d6ef94ca6ee 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2508,6 +2508,12 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 		     struct mptcp_subflow_context *subflow)
> {
> +	/* The first subflow can already be closed and still in the list */
> +	if (subflow->closed)
> +		return;
> +
> +	subflow->closed = true;
> +
> 	if (sk->sk_state == TCP_ESTABLISHED)
> 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 22b7eff311f5..ce15e7db464b 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -530,7 +530,8 @@ struct mptcp_subflow_context {
> 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
> 		valid_csum_seen : 1,        /* at least one csum validated */
> 		is_mptfo : 1,	    /* subflow is doing TFO */
> -		__unused : 10;
> +		closed : 1,	    /* has done the post-closed part */

Matthieu -

One small naming request, I think something like close_event_done would be 
better so this flag doesn't get misused in the future.

Thanks,

Mat


> +		__unused : 9;
> 	bool	data_avail;
> 	bool	scheduled;
> 	u32	remote_nonce;
>
> -- 
> 2.45.2
>
>
>
