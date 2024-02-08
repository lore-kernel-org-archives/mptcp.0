Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5908E1CD2E
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 01:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707357338; cv=none; b=ViXEboYwSVKH0+qLp+Caji6i/rQbm+uGmwINL3IBGV7HR8XrVfVcve/5TbDbWSOfsTTbsIM7XryHHdgOpuLUczGXyObsQ3KRi4eKDtSv5cGuDTr+7MB90rga0boBJTD7o02h/zvZ1F76qWZJ0o6WqwYdLKQHvLLTvIwS2vCImn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707357338; c=relaxed/simple;
	bh=R9TuBFhAiQWny8UntPfvtVxq/one/ErSeKNM8Hk64yQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FCADT8S9cFDnAWrTTfS1X+0s97O8q7XRKHq2NwMF1K0n2BHt7sf5JiRbw7WcjuOJOyKaU5QtL/TNXuGvnzj2KirUMPWMYtOjqLr5KU0r9OZFnmY6FereyrHN0fHT2wtTkKvzQntaVjBV7X4HTZoNpuvzQs4+ENWv/gGRJH2aP6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2uKZ9yT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2uKZ9yT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C765DC433F1;
	Thu,  8 Feb 2024 01:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707357337;
	bh=R9TuBFhAiQWny8UntPfvtVxq/one/ErSeKNM8Hk64yQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=L2uKZ9yTn5MgsFcuzPGjCWDWHJG9KbDZn6VYFDlea9yyVCdAgD3jnBsSZ6hO0WArG
	 2GS50JfaopeOt/2MnfK62GgituCGRyoWrn6m1m6+5JsMmDhRK1NrEwzsKOqSSkbwae
	 EM0PCQVTA8HOXyooVcyFgWR8XmArAZt9myHjHckQSwIj+cucjIgLG5zPuWhZnEciLo
	 ETvpd4E7n/wtkbERtEVMdp/7kWHbn5Esd64vAuHpZYzM5Y3VAbDwyxe7CBaL95O380
	 GW5K6WTP9b5Fi5Wh0vYfOjNapW0m6yNkH7aHqoWTd7err3w9zb1oDEgKGaVWNiitSU
	 F57LR1xX48s2w==
Date: Wed, 7 Feb 2024 17:55:37 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/7] mptcp: push ad DSS boundaries
In-Reply-To: <59d94e4297902d25829276df006615bbdd5f717f.1705836321.git.pabeni@redhat.com>
Message-ID: <7ab13c07-0d02-abc9-f190-fc6aae318bb1@kernel.org>
References: <cover.1705836321.git.pabeni@redhat.com> <59d94e4297902d25829276df006615bbdd5f717f.1705836321.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 22 Jan 2024, Paolo Abeni wrote:

> when inserting/creating skbs on the subflow write queue, if
> the to-be-appended data don't is not contiguous to the tail data,

Hi Paolo -

Looks like the "don't" here is extra, can you clarify this sentence?

> the protocol creates a new skb and prevent the TCP stack from
> merging it later by setting the EOR marker.
>
> Still no push flag is explicitly set at the end of previous GSO
> packet, making the aggregation on the receiver side sub-optimal -
> and packetdrill self-tests less predictable.
>
> Explicitly mark the end of not contiguous DSS with the push flag.
>

I agree with the approach, gro will never benefit from waiting around for 
the next packet as it will have a new DSS header and can never be 
combined.

- Mat

> Fixes: 6d0060f600ad ("mptcp: Write MPTCP DSS headers to outgoing data packets")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> This could also land on next, as needed, dropping the fixes tag
> ---
> net/mptcp/protocol.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 744b4d6f15f4..4d7131f96ebf 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1264,6 +1264,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> 		mpext = mptcp_get_ext(skb);
> 		if (!mptcp_skb_can_collapse_to(data_seq, skb, mpext)) {
> 			TCP_SKB_CB(skb)->eor = 1;
> +			tcp_mark_push(tcp_sk(ssk), skb);
> 			goto alloc_skb;
> 		}
>
> -- 
> 2.43.0
>
>
>
