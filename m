Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5283A34F279
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957936; cv=none; b=Quix+pN8Xg1uKarvk89Unoy3bFQ1fk42nyCOAGe4dw8/87XGi3dgwqGX+LihmzIBcAOjAbfcWr0P9AlF4bIj4eMpPa4+88CK4g9XnAzkBLhNIqlFosX4sh6Oe66YE87aL9neZPeozN4ABqO5qbXK7uk3nhbiGkzW4RkLgIJK9No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957936; c=relaxed/simple;
	bh=udiw3j2R/AD3L1TOdE2YnE/CqYcDtzb9zWwi4tjzCsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zt7c4r5jbdMQxyQ2xkgnMorACJ6BIVjazp0yJ/1+XwNIhfm2UlLl4jQv+3ziFsTl9Lkj6y5hT4UtzKPkbSm7IArrYo2oNPqamCly/pijazdoKEk6C1YJRrdtnYFEFEB85GMOT8d8oBXUu7JOoEVhCS+b4FAj1l0bSVPNrpL84x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQ8AQsjn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQ8AQsjn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0746C1F000E9;
	Thu, 28 May 2026 08:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779957934;
	bh=VuhOK2mhbqMddkmMlL1yf09u6v0rTbag7S7AA2rZOgg=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=cQ8AQsjnbtfOr8UBq1ygXyNbtIVvweB8dL7PlSb+V30jDPuaFfdTiKT+1XLzOjITK
	 fLsom/80hvrkAUCWVkA0ELJa+KIcpQr3jMLA805cP/SKP9RTiX+AlIRozabgNq07ST
	 X6Ogvkel+HTOOP3ZKzYPGBSjRMyKEIlZV5fOEWhQllHJPlEosawNiNEAzcJvzPw+a1
	 ZPykvEJJ/lEpCl9XklcXgQLhxyPpkmMKsjLKhBAcIkWPy9DRr1J9w0KmgT8nkBkLsg
	 eqi4W/45caiK8xP51V8RFSYUYU6Z8S089GevF9enYxY4nYakA7BQ4P7dw5aX9JcmbJ
	 w0rlGdunDG4FA==
Message-ID: <f583b390-b5d3-4a4f-82a0-ecfb3bf71f9e@kernel.org>
Date: Thu, 28 May 2026 18:45:31 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v9 mptcp-next 4/6] mptcp: implemented OoO queue pruning
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1779876523.git.pabeni@redhat.com>
 <94af7b55233828311a361cdd70b837805448218a.1779876523.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <94af7b55233828311a361cdd70b837805448218a.1779876523.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 27/05/2026 20:45, Paolo Abeni wrote:
> When moving incoming skbs in the msk receive queue and the latter
> is above limits, prune it as needed quite alike what TCP is doing
> at the subflow level. The main difference relies in the stop condition:
> since MPTCP does not perform collapsing, it's better off dropping the
> bare minimum to fit the (newer) incoming packet.

Thank you for the patch!

I have two small ideas below, but they are not blocking. If you think
they are valid, feel free to add a Squash-to patch in the v10, or ask me
to do the modifications.

I will apply the first 4 patches, adding this tag:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Plus this one only on this patch:

Tested-by: Gang Yan <yangang@kylinos.cn>

(...)

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b0a0c51e0a13..29cb10c02ed8 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -373,6 +373,45 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
>  	skb_dst_drop(skb);
>  }
>  
> +/* "Inspired" from the TCP version; main difference: stop as soon as the MPTCP
> + * socket is under memory limit.
> + */
> +static void mptcp_prune_ofo_queue(struct sock *sk, u64 seq)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct rb_node *node, *prev;
> +	bool pruned = false;
> +	u64 mem;
> +
> +	if (RB_EMPTY_ROOT(&msk->out_of_order_queue))
> +		return;
> +
> +	node = &msk->ooo_last_skb->rbnode;
> +
> +	do {
> +		struct sk_buff *skb = rb_to_skb(node);
> +
> +		/* Stop pruning if the incoming skb would land in OoO tail. */
> +		if (after64(seq, MPTCP_SKB_CB(skb)->map_seq))
> +			break;
> +
> +		pruned = true;
> +		prev = rb_prev(node);
> +		rb_erase(node, &msk->out_of_order_queue);
> +		mptcp_drop(sk, skb);
> +		msk->ooo_last_skb = rb_to_skb(prev);
> +
> +		mem = (unsigned int)atomic_read(&sk->sk_rmem_alloc);

Detail: why not using sk_rmem_alloc_get() here, like you did in
__mptcp_move_skb(). Also there, sk->sk_rcvbuf is used with READ_ONCE(),
but not here. Is it on purpose?

> +		if (mem < sk->sk_rcvbuf)
> +			break;
> +
> +		node = prev;
> +	} while (node);
> +
> +	if (pruned)
> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFO_PRUNED);

Here, why not returning sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)
...

> +}
> +
>  static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  {
>  	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
> @@ -386,9 +425,12 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  	 */
>  	if (unlikely(sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) &&
>  	    !__mptcp_check_fallback(msk)) {

... so here you can simply add mptcp_prune_ofo_queue(...) and not change
what is below?

> -		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
> -		mptcp_drop(sk, skb);
> -		return false;
> +		mptcp_prune_ofo_queue(sk, MPTCP_SKB_CB(skb)->map_seq);
> +		if (sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) {
> +			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
> +			mptcp_drop(sk, skb);
> +			return false;
> +		}
>  	}
>  
>  	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

