Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DECD305E1F
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339386; cv=none; b=Ux4COzLc7gD3DHHCsru1JwZuNf6oB+z7zNoVV2lubIW9y1wbxfIWu06ekKoRAOfjgLH1i7nSJwIlfSIrx+btBRiSmGkEG/gixe7FnQlynJ2dsQLzx5auabpZYtHj9ZYfOceMWHmGmF2C9+fnr3yTRP1DKHdgr8ypNR5fwv08gw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339386; c=relaxed/simple;
	bh=/fVRD1hKJrWxtwAWe7sJaCBIT7RwsaowkRAG7e3Cma0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQVwtCAQMYXplJ+Bmi9GgQySBNIHCWJqz9RU4jYaDEUpiXTJG4Wz42+zdBLWAjP6uwXfuFeTsCM/XOxYpltUJGjLeTWedzA8kgPGcnRwOrssNSFGK0F+cRmpnUd6JFXIJ3BiC7FB3Nk5yM248XREuARIX2mM7J0AfjlemNkC0MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGihPKLD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGihPKLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0762C116D0;
	Wed,  5 Nov 2025 10:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762339385;
	bh=/fVRD1hKJrWxtwAWe7sJaCBIT7RwsaowkRAG7e3Cma0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CGihPKLDKS4anBFWcyZWFewwt6XQPIBLpEQUggY67f6K0ck7I8sh6G9j4RySXI0lT
	 I7taq3aFOvr2DjEQoWEovlI69fKbxfzsuXzp/kIGZs4BjEP1wbJbZ0S0jK1rrtVrW1
	 pVLHFnT97z5ETByinKvA+GbngBUssFq7jBZeOi7yqiOo0B4TZkRE1UkdnPSOqSDIv0
	 HNdtxLQ5knIjsjyY8NO5gl72bdsCbZ+5gAtS6gXrasv2BuOOIv+kmjDpYsj/WW0neG
	 OMJpEG9hLvKbdgxH8UYh1YJD1Yk5mR4q35KCmhGLDkpr+mA9yEnQWckxKpfZXc7x8c
	 QIvsB+onWL+ow==
Message-ID: <5da6be8c-76b6-4d65-88e7-f74a95557b65@kernel.org>
Date: Wed, 5 Nov 2025 11:43:02 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v8 4/4] mptcp: leverage the backlog for RX
 packet processing
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
References: <cover.1762271864.git.pabeni@redhat.com>
 <44e2efcff50d5c45c9a72b1efa15528e81166d34.1762271864.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <44e2efcff50d5c45c9a72b1efa15528e81166d34.1762271864.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 04/11/2025 16:59, Paolo Abeni wrote:
> When the msk socket is owned or the msk receive buffer is full,
> move the incoming skbs in a msk level backlog list. This avoid
> traversing the joined subflows and acquiring the subflow level
> socket lock at reception time, improving the RX performances.
> 
> When processing the backlog, use the fwd alloc memory borrowed from
> the incoming subflow. skbs exceeding the msk receive space are
> not dropped; instead they are kept into the backlog until the receive
> buffer is freed. Dropping packets already acked at the TCP level is
> explicitly discouraged by the RFC and would corrupt the data stream
> for fallback sockets.
> 
> Special care is needed to avoid adding skbs to the backlog of a closed
> msk and to avoid leaving dangling references into the backlog
> at subflow closing time.

Thank you for the patches!

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d075db13bb72..01114456dec6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -684,7 +684,7 @@ static void __mptcp_add_backlog(struct sock *sk,
>  }
>  
>  static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> -					   struct sock *ssk)
> +					   struct sock *ssk, bool own_msk)
>  {
>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
>  	struct sock *sk = (struct sock *)msk;
> @@ -700,9 +700,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>  		struct sk_buff *skb;
>  		bool fin;
>  
> -		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)

I don't think that's important, but I prefer to report it just in case:

I see that you moved this condition from here ...

> -			break;
> -
>  		/* try to move as much data as available */
>  		map_remaining = subflow->map_data_len -
>  				mptcp_subflow_get_map_offset(subflow);
> @@ -730,7 +727,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>  
>  			mptcp_init_skb(ssk, skb, offset, len);
>  
> -			if (true) {
> +			if (own_msk && sk_rmem_alloc_get(sk) < sk->sk_rcvbuf) {

... to here, but almost the opposite: '>' → '<'. Fine with '<', or
should it be '<='?

But I guess we will not often hit just the exact number.

>  				mptcp_subflow_lend_fwdmem(subflow, skb);
>  				ret |= __mptcp_move_skb(sk, skb);
>  			} else {

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

