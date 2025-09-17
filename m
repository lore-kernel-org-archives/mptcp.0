Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1470A27A468
	for <mptcp@lists.linux.dev>; Wed, 17 Sep 2025 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095288; cv=none; b=kGPMhEAwR/92ymoe4HPRpTER0Shy0KCZSonCvba/Jc+ldZAOSWlTFY06679+QGNfWauT2xZ4S3Hl2Tmj3WfJr9b75tXMMBYNG9tCMV5bMDojyqn+xmSO3qvnFYNG31jX0hmdH0jF+M66B4pcgYma1mpmyhw+6pjrtvIre5ilp0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095288; c=relaxed/simple;
	bh=CL15JSOc0vsTUOtal7E9pW2Co6n2AMP8dngk0Dnol+o=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E/u2fJ3Evv5Txhp5jbIsnEXPX36gGC7n4rYzNQSHgTIQzQq+/sF1t+jLp0fmI92/hVOKeEY5RoFZv/FXTUUpjsLOm8pEDc/Hcwz5oJx7J6KRGKEPrQr0C2ODcaEup1kdWhgLqZWeUAoGW+B3aEU3j1VCKy1nS+mP9+IQI2rIqus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFd2eELk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFd2eELk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFABEC4CEF0;
	Wed, 17 Sep 2025 07:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758095287;
	bh=CL15JSOc0vsTUOtal7E9pW2Co6n2AMP8dngk0Dnol+o=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=kFd2eELk/qwqmUny0kq7/ej5eShmnfVkZ3r+rJ/gxe0EX1J3+w7fxPLBZFCLWN+HI
	 VEYg3DdHRn4WOgq1/xwen/SB6IhhqeDDBpMX0zp5SJrVf1jra2GxQkT3xDNH4Vrh8y
	 V/OBwsFdNnjS3SMNcc/c0Adm5KQd31tnGd/mN1StYtQQaj004trOgZNT4A1lOdZuIj
	 cZFqDS/F3S0rdfrAvfFN45hambDLttVWcE/J0q3UiRHImSTGTRVH7lHxF0aOViRLGK
	 1PbKf3wo4YjQXgr68jOyYh+OarMt7bs6bfIXK1OJ8oUbo4G7whg4lNBp6zcc05E0gD
	 1bFt/7OT0mLpg==
Message-ID: <bb6f1b55c71e6af09b363d27990e14640436dcfc.camel@kernel.org>
Subject: Re: [MPTCP next 04/12] mptcp: introduce the mptcp_init_skb helper.
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Wed, 17 Sep 2025 15:48:04 +0800
In-Reply-To: <e070cc84b7d00a3b0ec31f95c810fe2e7bf85059.1758039775.git.pabeni@redhat.com>
References: <cover.1758039775.git.pabeni@redhat.com>
	 <e070cc84b7d00a3b0ec31f95c810fe2e7bf85059.1758039775.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

Thanks for this patch. I've left some minor cleanup comments below.

On Tue, 2025-09-16 at 18:27 +0200, Paolo Abeni wrote:
> Factor out all the skb initialization step in a new helper and
> use it. Note that this change moves the MPTCP CB initialization
> earlier: we can do such step as soon as the skb leaves the
> subflow socket receive queues.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 46 ++++++++++++++++++++++++------------------
> --
>  1 file changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 671c51cb9539c..879157a1f4fb1 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -323,27 +323,11 @@ static void mptcp_data_queue_ofo(struct
> mptcp_sock *msk, struct sk_buff *skb)
>  		mptcp_rcvbuf_grow(sk);
>  }
>  
> -static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock
> *ssk,
> -			     struct sk_buff *skb, unsigned int
> offset,
> -			     size_t copy_len)
> +static void mptcp_init_skb(struct sock *ssk,
> +			   struct mptcp_subflow_context *subflow,

subflow and ssk parameters are redundant, we can just use ssk.

> +			   struct sk_buff *skb, int offset, int
> copy_len)
>  {
> -	struct mptcp_subflow_context *subflow =
> mptcp_subflow_ctx(ssk);
> -	struct sock *sk = (struct sock *)msk;
> -	struct sk_buff *tail;
> -	bool has_rxtstamp;
> -
> -	__skb_unlink(skb, &ssk->sk_receive_queue);
> -
> -	skb_ext_reset(skb);
> -	skb_orphan(skb);
> -
> -	/* try to fetch required memory from subflow */
> -	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
> -		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
> -		goto drop;
> -	}
> -
> -	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
> +	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
>  
>  	/* the skb map_seq accounts for the skb offset:
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current
> tp->copied_seq
> @@ -355,6 +339,24 @@ static bool __mptcp_move_skb(struct mptcp_sock
> *msk, struct sock *ssk,
>  	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
>  	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
>  
> +	__skb_unlink(skb, &ssk->sk_receive_queue);
> +
> +	skb_ext_reset(skb);

skb_orphan(skb) call was moved from here to after mptcp_init_skb(), but
was then completely removed in patch 11. I'm a bit confused by this. I
think it might be better to retain skb_orphan(skb) call here. Or
perhaps the addition of skb_dst_drop(skb) has made skb_orphan(skb)
unnecessary. I'd like to consult on this point.

> +	skb_dst_drop(skb);
> +}
> +
> +static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sk_buff
> *skb)

The parameter 'msk' was changed to 'struct sock *sk' in patch 9. We can
directly adopt 'struct sock *sk' here as well.

Thanks,
-Geliang

> +{
> +	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq -
> MPTCP_SKB_CB(skb)->map_seq;
> +	struct sock *sk = (struct sock *)msk;
> +	struct sk_buff *tail;
> +
> +	/* try to fetch required memory from subflow */
> +	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
> +		goto drop;
> +	}
> +
>  	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
>  		/* in sequence */
>  		msk->bytes_received += copy_len;
> @@ -662,7 +664,9 @@ static bool __mptcp_move_skbs_from_subflow(struct
> mptcp_sock *msk,
>  		if (offset < skb->len) {
>  			size_t len = skb->len - offset;
>  
> -			ret = __mptcp_move_skb(msk, ssk, skb,
> offset, len) || ret;
> +			mptcp_init_skb(ssk, subflow, skb, offset,
> len);
> +			skb_orphan(skb);
> +			ret = __mptcp_move_skb(msk, skb) || ret;
>  			seq += len;
>  
>  			if (unlikely(map_remaining < len)) {
