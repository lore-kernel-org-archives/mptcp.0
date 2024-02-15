Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F161DFFE
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708036396; cv=none; b=kISwARlRVVW+FO8pSWcgGOTMpHTtwqlHHsm5U6un8Wy2gobazUtiRwN9+6850BXGfMCzHT4VM7hHNldlFFGXKZy4JqIxDLFsmWoNsmeqimKsk+/DYLmAq/l4bm95E0CehSRwsq6a9Y7Izqo+uPou6A8Lk+XvKem+9bEox1h9C+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708036396; c=relaxed/simple;
	bh=025es6460M3LY9hgciAHicDDYBefZaLE+xGYVcczaU4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=I9e9wPkU1yZCCBT2rA+0hPI12zbXbfAmoYQLQwN/8u5S8irirYinVABqWceSe20K/iX0VHifMmuYtuP0icc510L1DBO3XO1OPqxznn+/DoBIuaRbL5id/EyC1mn5myWRatcX0Huqdenyzuad9v65xatTZBAkA4Lw50x13zlIRvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vka2SBFG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vka2SBFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A792C433F1;
	Thu, 15 Feb 2024 22:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708036395;
	bh=025es6460M3LY9hgciAHicDDYBefZaLE+xGYVcczaU4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Vka2SBFGqpG5YS5F96nt3pULngsExkXn565ArF8AtZfyLa6ls4ED2LX8h/WkTMkCf
	 EVLgjHJDTzJCHwvqlB8VA645OX54RUVccFV8lK9SRCdUEi8qq23mPmJyLe71mYzl7V
	 iXsxtkLR6TcbaNu4AkmVZrce24i3ZHjiPVZHzwvtOWQTn5KqFGv9iRlywNVYy0HF7y
	 s4FbZMch4CKXih3vVMt313aZs/C/T9kBC/TGu1s14uyFSWlVfJGE0GGbGTfwBmSUPC
	 mj2PnWzg2OIwaaTyOkLs0YqqmKE2zXbWmoDy58xjBLGXDJ1Q45jveYSsALU6aHiPVY
	 VqI3EZHP5A+lg==
Date: Thu, 15 Feb 2024 14:33:14 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [mptcp-next v2 1/7] mptcp: push ad DSS boundaries
In-Reply-To: <50740f793884616dd10374327029408dcd25dacc.1707739536.git.pabeni@redhat.com>
Message-ID: <079c48a0-e707-0210-17ba-54a93352be69@kernel.org>
References: <cover.1707739536.git.pabeni@redhat.com> <50740f793884616dd10374327029408dcd25dacc.1707739536.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 12 Feb 2024, Paolo Abeni wrote:

> when inserting not contiguous data in the subflow write queue,
> the protocol creates a new skb and prevent the TCP stack from
> merging it later with already queued skbs by setting the EOR marker.
>
> Still no push flag is explicitly set at the end of previous GSO
> packet, making the aggregation on the receiver side sub-optimal -
> and packetdrill self-tests less predictable.
>
> Explicitly mark the end of not contiguous DSS with the push flag.
>
> Fixes: 6d0060f600ad ("mptcp: Write MPTCP DSS headers to outgoing data packets")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---

As long as I'm asking for other changes that require a v3 spin, please 
also change this commit title to "push at..."

Thanks!

Mat


> net/mptcp/protocol.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3017b01ac488..21b3729c65ac 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1265,6 +1265,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
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
