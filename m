Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0B71DC198
	for <mptcp@lists.linux.dev>; Tue, 21 Oct 2025 00:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761005579; cv=none; b=oMxrsc+MpmewJP2ccu4l1r4Rh7gZuCAB1BQwn5T+As0toI+Rk4mw2okBCG21UYpWQUGn16iI0M6g6/3Z6vy4z/lD7beWQNJT3ozg9Lo5r8xEo0MX5Docg+Wn+2X8F6Ahi0Vx9/4fBWoJwNpYbgyRKm/JBkema+WaZWsvsUjnPtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761005579; c=relaxed/simple;
	bh=iNrktdgxIHLAw56poJQgxj8NNQ2/4ObZUvgceLa1EpI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KxPcCZXhRsSgDRkFtCtHRtnhaIxIQSJbLdHpLFgDOCZS1wgAvePXK8/PHRYfEi4n1HTeUPv++ysvNW2eBF0hwVprKk7oEX4iylwc9TpMMKHWKacXUSmyZG8Y/dM+iVN6fQB87EFGfu7CGqhD2pPF3m4xHvGtvmgqA3JmCB418Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QudkXVlK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QudkXVlK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDF2C4CEFB;
	Tue, 21 Oct 2025 00:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761005578;
	bh=iNrktdgxIHLAw56poJQgxj8NNQ2/4ObZUvgceLa1EpI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=QudkXVlKBKw7Y5VgFldqTIPHfmtvAwbaMg+vvT3uvp+wesjkj796vcNzoe9qg4U3U
	 yUs5w0ZJP48EEbdiCRPqioW3IUTzSv+hfkUrjCLP+ZtSulWFh42CrQkzNk2sv+mido
	 XAYlaOuWcDC2PS/gRSmHh75sdCTzreN3/DNPqg6jyILE+wM/ZGFpbXV2bNNzXFoAGV
	 5+kxQh48EoBYL31JYYGXB30V0MAqBx/hMO2N9gj3XVtM7bHIN0fUkkxU+rGByjgk76
	 TzzlJaJDet5DbFNnWC/xkDU900bxilV7WbBudhMxIxz96pXrW5lQVuZwmV/SP5AWu1
	 OppGkSdgnGsEA==
Date: Mon, 20 Oct 2025 17:12:57 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, geliang@kernel.org
Subject: Re: [PATCH mptcp-net 1/2] mptcp: restore window probe
In-Reply-To: <59d900cbb2c2ff8e742d55a78e22727d1951bb51.1760976334.git.pabeni@redhat.com>
Message-ID: <f473dab8-e461-3bdf-d118-2022aacb96bf@kernel.org>
References: <cover.1760976334.git.pabeni@redhat.com> <59d900cbb2c2ff8e742d55a78e22727d1951bb51.1760976334.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 20 Oct 2025, Paolo Abeni wrote:

> Since commit 72377ab2d671 ("mptcp: more conservative check for zero
> probes") the MPTCP-level zero window probe check is always disabled, as
> the TCP-level write queue always contains at least the newly allocated
> skb.
>
> Refine the relevant check tacking in account that the above condition
> and that such skb can have zero length.
>
> Fixes: 72377ab2d671 ("mptcp: more conservative check for zero probes")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 14 ++++++++++----
> 1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index bde76b7311f986..fe029359b7d7a2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1276,6 +1276,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> 	u64 data_seq = dfrag->data_seq + info->sent;
> 	int offset = dfrag->offset + info->sent;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct tcp_sock *tp = tcp_sk(ssk);

Hi Paolo -

I appreciate the urge to tidy up the tcp_sk(ssk)s in this function, but it 
does distract from the meaningful code change - and the updated zero probe 
logic doesn't use the new tp variable...

Then again, if a netdev maintainer wants this in a -net patch, that 
opinion does carry some weight :)

> 	bool zero_window_probe = false;
> 	struct mptcp_ext *mpext = NULL;
> 	bool can_coalesce = false;
> @@ -1311,14 +1312,14 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> 		mpext = mptcp_get_ext(skb);
> 		if (!mptcp_skb_can_collapse_to(data_seq, skb, mpext)) {
> 			TCP_SKB_CB(skb)->eor = 1;
> -			tcp_mark_push(tcp_sk(ssk), skb);
> +			tcp_mark_push(tp, skb);
> 			goto alloc_skb;
> 		}
>
> 		i = skb_shinfo(skb)->nr_frags;
> 		can_coalesce = skb_can_coalesce(skb, i, dfrag->page, offset);
> 		if (!can_coalesce && i >= READ_ONCE(net_hotdata.sysctl_max_skb_frags)) {
> -			tcp_mark_push(tcp_sk(ssk), skb);
> +			tcp_mark_push(tp, skb);
> 			goto alloc_skb;
> 		}
>
> @@ -1339,7 +1340,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> 	if (copy == 0) {
> 		u64 snd_una = READ_ONCE(msk->snd_una);
>
> -		if (snd_una != msk->snd_nxt || tcp_write_queue_tail(ssk)) {
> +		/* No need for zero probe if there are any data pending
> +		 * either at the msk or ssk level; skb is the current write
> +		 * queue tail and can be empty at this point.
> +		 */
> +		if (snd_una != msk->snd_nxt || skb->len ||
> +		    skb != tcp_send_head(ssk)) {

LGTM

Reviewed-by: Mat Martineau <martineau@kernel.org>

> 			tcp_remove_empty_skb(ssk);
> 			return 0;
> 		}
> @@ -1367,7 +1373,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> 	skb->truesize += copy;
> 	sk_wmem_queued_add(ssk, copy);
> 	sk_mem_charge(ssk, copy);
> -	WRITE_ONCE(tcp_sk(ssk)->write_seq, tcp_sk(ssk)->write_seq + copy);
> +	WRITE_ONCE(tp->write_seq, tp->write_seq + copy);
> 	TCP_SKB_CB(skb)->end_seq += copy;
> 	tcp_skb_pcount_set(skb, 0);
>
> -- 
> 2.51.0
>
>
>
