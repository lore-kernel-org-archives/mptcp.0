Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C1F1859
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 00:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721954534; cv=none; b=QMEcNkQ5nsGHvniwPF97j9KWuujfZX8iCzSm/1+1t6jfuuglDX4O7yGzFMhS/lqNHAbMwT7k2nXGoZwZcCIdK/CxisPE1/Ij/rft6uc76BvsBcDOb9mDMbFOD7dF5AN8IMtLBVENlZUm1xh1uIlGCPc3ELnJyBxPXZbWZO0eCp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721954534; c=relaxed/simple;
	bh=BasLSwYXBOHFqu6MWlaltQquBTTIA8on8e8EnZbLpYc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VXVmBhAdqjHJZ6+/LG16q4UUJrmFWaM18h7wWEimJnK5uWS0iYtqlqscwZp9mFugPNNiB1q0CBbyGcCS0Imnh8aidKBwuKC1bxGJFlHxBjVWghnLquWJXI5zXb1VnXwkVAQqa879+9RR+q7WwntxpsFG9+WbzI5DnzsQFo+kHHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFDyM+q3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFDyM+q3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EE8C116B1;
	Fri, 26 Jul 2024 00:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721954534;
	bh=BasLSwYXBOHFqu6MWlaltQquBTTIA8on8e8EnZbLpYc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=UFDyM+q3cVoUgWlRFVvDtokDg+CGYubceLyGKR4wozwRzjWe3LjguI79I3zE+/B8o
	 cSSryYOUFpeSxIMjC/2lRpp1o9WKokJgE95omIBeSaZfHHQ/a25DoVrNKv13dplzR/
	 sJAYmoQeNpb6TX7ZLS2WFWpYlTOygEl6lv9aDlppQqYqRSfgNSrDM6FHsyOyMtbrGb
	 kEX5GC7WQ98CGJh1JiyGoFfver5bKBSofLcRjQzMRp8kuLv9HA7y7sQyBqy59nkFPP
	 35KpHBSK9z0T/IYw+UVxVpMnpREc1tHeSMZAoinuJSygl+hNkF0n7Ef6HRP5Pp0EkF
	 BZ8RqSwWLpHvQ==
Date: Thu, 25 Jul 2024 17:42:13 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 2/2] mptcp: fix duplicate data handling
In-Reply-To: <1ca08110195a81b95a38449f1a12b5593dfad864.1721921695.git.pabeni@redhat.com>
Message-ID: <415224da-e982-2d69-d1de-f234abdc09fb@kernel.org>
References: <51cd83cb7690d756e9a71797b133bdd9f286de76.1721921695.git.pabeni@redhat.com> <1ca08110195a81b95a38449f1a12b5593dfad864.1721921695.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 25 Jul 2024, Paolo Abeni wrote:

> When a subflow receives and discards duplicate data, the mptcp
> stack assumes that the consumed offset inside the current skb is
> zero.
>
> With multiple subflows receiving data simultaneously such assertion
> does not held true. As a result the subflow-level copied_seq will
> be incorrectly increased and later on the same subflow will observe
> a bad mapping, leading to subflow reset.
>
> Address the issue tacking in account the skb consumed offset in

Just one fix but Matthieu can adjust: "Address the issue taking into 
account..."

Reviewed-by: Mat Martineau <martineau@kernel.org>

> mptcp_subflow_discard_data().
>
> Fixes: 04e4cd4f7ca4 ("mptcp: cleanup mptcp_subflow_discard_data()")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/subflow.c | 16 ++++++++++++----
> 1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 0e4b5bfbeaa1..a21c712350c3 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1230,14 +1230,22 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> 	bool fin = TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
> -	u32 incr;
> +	struct tcp_sock *tp = tcp_sk(ssk);
> +	u32 offset, incr, avail_len;
>
> -	incr = limit >= skb->len ? skb->len + fin : limit;
> +	offset = tp->copied_seq - TCP_SKB_CB(skb)->seq;
> +	if (WARN_ON_ONCE(offset > skb->len))
> +		goto out;
> +
> +	avail_len = skb->len - offset;
> +	incr = limit >= avail_len ? avail_len + fin : limit;
>
> -	pr_debug("discarding=%d len=%d seq=%d", incr, skb->len,
> -		 subflow->map_subflow_seq);
> +	pr_debug("discarding=%d len=%d offset=%d seq=%d", incr, skb->len,
> +		 offset, subflow->map_subflow_seq);
> 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DUPDATA);
> 	tcp_sk(ssk)->copied_seq += incr;
> +
> +out:
> 	if (!before(tcp_sk(ssk)->copied_seq, TCP_SKB_CB(skb)->end_seq))
> 		sk_eat_skb(ssk, skb);
> 	if (mptcp_subflow_get_map_offset(subflow) >= subflow->map_data_len)
> --

