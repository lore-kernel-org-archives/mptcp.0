Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467881C01
	for <mptcp@lists.linux.dev>; Sat, 20 Sep 2025 00:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758326496; cv=none; b=YunvuC2QCdbUvTdd6Alydid2DWABxxdqFxJUFnkyH/zOT9HK1JzMF61kYFvw5JzaW/P3ZYC7G9rUM5wxXQibiNz0RSKCyTNBRkT6V9c5sO56ACVJzQTL5PP+tZDgBb1/Mow8BTw/Bg23HPH5p99nuwF47xRoeP8Z+kSi1qzCwzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758326496; c=relaxed/simple;
	bh=oMXVmI0D+4xefl62sjoC97bTwWsXlFbK6YoOotkKPIc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V4EQ8b426VLmhFiMRR8MKpipmRkx2kfVqvo2V+ML9xOaRIQOWx/aWNlVLDmchTyBfOMmjAOvXeULwiAgQqt8gAZ63NuYIawrFAhPrIlGzklZd0yyiLbMYhg9nVudy603x8na8KDGenGCSBQ9OWUuGWieWG6QxDedFbYw22eRD/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0Z4uT8N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0Z4uT8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E941C4CEF0;
	Sat, 20 Sep 2025 00:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758326495;
	bh=oMXVmI0D+4xefl62sjoC97bTwWsXlFbK6YoOotkKPIc=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=s0Z4uT8NA6PdlFN+WzoB+Ygb9kmI0XCT7IP7MDhi8kKZGR4PSv/3bDPdbT/utQRM0
	 2oqmaxiQbi/Gw52db+ER5yuVNpIhCXAh1fPNXcZVyOCLXs+/JEul4Q/xEpzl38RxUN
	 jslYsGn2/eaLf/kAOK2fUm/+MEcm24QaaMhFfelEQtIggvQsEVlMHnT/4FjzZvi+0r
	 9sQYhGfTAc14YUmMwyS5pdfOqh+RJ2qHcDCbl5ZV0w9hKevnEWA4ex1SiFPQApPOMd
	 zOk2JL1cXCKO5MS03mCZ8Df0dhzfWkI1a7rzh3xuIvrB9A9R7KePPjQ5B4NMB9EMoP
	 oUeSeOd+acyFw==
Message-ID: <15dd99fe568a6a00da55ef5b95b3e41c9e6b6604.camel@kernel.org>
Subject: Re: [MPTCP next v3 04/12] mptcp: introduce the mptcp_init_skb
 helper.
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Sat, 20 Sep 2025 08:01:29 +0800
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
