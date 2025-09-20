Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746531C01
	for <mptcp@lists.linux.dev>; Sat, 20 Sep 2025 00:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758326598; cv=none; b=uv5YGQnOug3NdSlV4Lp289GmZBES3krzgZMa3Gs5S+rLPragCkXShN/eKac9kmlPQRqkHz8sXb+LkRBtpxzITDDbv1Yx+2WrX0yqyElCwYZJRjhxU0xeWGaCX6Dkxce8sI68q7/R/fb+wyfKBJzflwHnyf19/YEy/oSkaHuzBB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758326598; c=relaxed/simple;
	bh=oMXVmI0D+4xefl62sjoC97bTwWsXlFbK6YoOotkKPIc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k/d5ZUes/M5Crprcdm116I2aUVZE0cK2ZfaACg8o1+6vW7S2KZZ38gHVX81NKJ0oK+Smqzk6UfQem5Ai0sXA0Q/4YiVcz0nkE3LIbuNFaIXhM2lavCGNwKm03/Eu9CSxEzbpjBNohFevljwAqx6cdjbSaFw7ow7kYnk4RLZEzZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fndvMg/4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fndvMg/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644C8C4CEF0;
	Sat, 20 Sep 2025 00:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758326598;
	bh=oMXVmI0D+4xefl62sjoC97bTwWsXlFbK6YoOotkKPIc=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=fndvMg/4JZ+BBfwIm1aJfFFg8EsgOKFpGtGYpLUUe5UNYOFKMiKeUF5JIa0Ka8h0R
	 WADiKC2kIIK3JYsYDUxrxSy14ej71TejRn8KUP/daXpaTQAZAONSK9o+lI3cEwxWnU
	 P8MXmLP/8etaCCJ2Gmcsjf+SIYuCDLJW3hknHHDe/gu1SlkcZ4XiO9+1PkgwKMn3sQ
	 TxGiyCRENQbDRH0022YMQYB4NKOk7bCpBL0rwr245WYDvZ7GRjM5Dvcmu5TZsEiB1A
	 eYc5K0AQyjW2Kf5MzbqfktrZ2NXcqJ24QyIMdX0ytn6AjLgDcy8+yyvFGUJfDefSt9
	 pg1G561yfEIog==
Message-ID: <c5efa8750011a88d9945b6d81c36d4d00fe6b1e2.camel@kernel.org>
Subject: Re: [MPTCP next v3 04/12] mptcp: introduce the mptcp_init_skb
 helper.
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Sat, 20 Sep 2025 08:03:15 +0800
In-Reply-To: <df18a15a52a3884f05ad97cb53716d92bb7c8d88.1758296923.git.pabeni@redhat.com>
References: <cover.1758296923.git.pabeni@redhat.com>
	 <df18a15a52a3884f05ad97cb53716d92bb7c8d88.1758296923.git.pabeni@redhat.com>
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

Thank you for the v3. All tests pass on my end, including my "implement
mptcp read_sock v11" test case.

I have a few minor cleanup comments to make the patch clean. There is
no need to send a v4 or block the merging of this series. Matt can make
the changes when he merges it, or I can send some squash-to patches to
address these after merging. Either approach would be fine.

On Fri, 2025-09-19 at 17:53 +0200, Paolo Abeni wrote:
> Factor out all the skb initialization step in a new helper and
> use it. Note that this change moves the MPTCP CB initialization
> earlier: we can do such step as soon as the skb leaves the
> subflow socket receive queues.
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>   - drop subflow argument from mptcp_init_skb()
>   - change msk args to sock arg in __mptcp_move_skb()
> ---
>  net/mptcp/protocol.c | 46 ++++++++++++++++++++++++------------------
> --
>  1 file changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c9fcdbaf50874..3aa03da781ba3 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -326,27 +326,11 @@ static void mptcp_data_queue_ofo(struct
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
> +			   struct sk_buff *skb, int offset, int
> copy_len)

nit:

static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb,
                           int offset, int copy_len)

is better.

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
> +	const struct mptcp_subflow_context *subflow =
> mptcp_subflow_ctx(ssk);
> +	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;

nit, how about keeping it as the original code to make this patch
smaller:

-	struct mptcp_subflow_context *subflow =
mptcp_subflow_ctx(ssk);
-	bool has_rxtstamp;
-
-	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

>  
>  	/* the skb map_seq accounts for the skb offset:
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current
> tp->copied_seq
> @@ -358,6 +342,24 @@ static bool __mptcp_move_skb(struct mptcp_sock
> *msk, struct sock *ssk,
>  	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
>  	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
>  
> +	__skb_unlink(skb, &ssk->sk_receive_queue);
> +
> +	skb_ext_reset(skb);
> +	skb_dst_drop(skb);
> +}
> +
> +static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
> +{
> +	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq -
> MPTCP_SKB_CB(skb)->map_seq;
> +	struct mptcp_sock *msk = mptcp_sk(sk);
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
> @@ -678,7 +680,9 @@ static bool __mptcp_move_skbs_from_subflow(struct
> mptcp_sock *msk,
>  		if (offset < skb->len) {
>  			size_t len = skb->len - offset;
>  
> -			ret = __mptcp_move_skb(msk, ssk, skb,
> offset, len) || ret;
> +			mptcp_init_skb(ssk, skb, offset, len);
> +			skb_orphan(skb);
> +			ret = __mptcp_move_skb(sk, skb) || ret;
>  			seq += len;
>  
>  			if (unlikely(map_remaining < len)) {
