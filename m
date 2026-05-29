Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CAD14A8B
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 01:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019766; cv=none; b=gfSymgBnjNpznALlUHRtqgbIdQiO8g1zj5CO7ZGH+alG8bR1Rsds/kxZXsPnUiXr+Uf48U7b+Y43K3FIZDrwCfA6keHM1ln2aFrwozKmw6u0VB9GXdM/mkEMwE1W/JkPv4/ILDNyQL08/bMxYi+e7Mr6LYUI1sj8B5rS0oGrEws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019766; c=relaxed/simple;
	bh=mex4Xx6gkoyrhM5YmEe7aFsbxRovHxZFXfLGRSXSyUI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fDF7XqQCIZk6voVZzGbzVvIa4ztneNQ4INOiq140WnWnpMpYbkzNkceIioV0zW6HHbBCk8Y/365wP3WLj/30lC5cmlEeI2W0/kLGiIwfrvTu4LYK0K+SOaYluiqk3sa6l3Ofv4w7Qh7FQfmF5simnkYKHMi1LDjQMAqYyatANl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ox9C1gj+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ox9C1gj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233941F000E9;
	Fri, 29 May 2026 01:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780019765;
	bh=SoX2TCXEnIzt/3yANOi54pSQ03Pqd2D6RdE8lzI5aRU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ox9C1gj+YeBB6H7Bzz1kRgQtNGwNro8la/UBTo5ospMiwYxLBpKFywn6AxwW9nj+S
	 tY89Dk+BAsYcU/pXN++DHjqGBW8FQXMeBfX94wirTR520WebLivL8MVdCHN/4usAFx
	 /5wiR12iw+ZKeDlej8BqfzkyOu1bpDgSQAs8+De1y6ItGWHCCJgoCBQ+e0CYm7fcLO
	 B6+ksZp1wXjy3mdMajBwKagPgCX6jOpjRyjq7Qe6TuUpJ1ArhV2fQjBQIGAYHLQ6fy
	 kpZ9F+mxcILN33+2ae6rXP14DQNKFj+1msiFocuw7NDWJCS/vl5UHdLR5ZQCJyrLga
	 zE//ugSPlS8mw==
Date: Thu, 28 May 2026 18:56:04 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next v3 02/16] mptcp: options: ADD_ADDR size can
 be negative
In-Reply-To: <20260520-mptcp-add-addr6-port-ts-v3-2-bffa658a7678@kernel.org>
Message-ID: <8df0d9e6-7428-9fe5-72f9-da5350053415@kernel.org>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org> <20260520-mptcp-add-addr6-port-ts-v3-2-bffa658a7678@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 20 May 2026, Matthieu Baerts (NGI0) wrote:

> Use a signed int for the returned size, because if other options are
> dropped, the size can be negative, e.g. to send an echo ADD_ADDR with a
> v4 address, and no port.
>
> The behaviour is not changed, because it was working as expected with an
> overflow. But it is clearer like this, and it will help later on.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/options.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 4cc583fdc7a9..966f6a867287 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -651,8 +651,8 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key2,
> 	return get_unaligned_be64(&hmac[SHA256_DIGEST_SIZE - sizeof(u64)]);
> }
>
> -static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *skb,
> -					       unsigned int *size,
> +static bool mptcp_established_options_add_addr(struct sock *sk,
> +					       struct sk_buff *skb, int *size,
> 					       unsigned int remaining,
> 					       struct mptcp_out_options *opts)

There are several other static mptcp_established_*() functions in this 
file that have an unsigned int *size parameter - should update those as 
well.

- Mat

> {
> @@ -842,9 +842,9 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> -	unsigned int opt_size = 0;
> 	bool snd_data_fin;
> 	bool ret = false;
> +	int opt_size = 0;
>
> 	opts->suboptions = 0;
>
>
> -- 
> 2.53.0
>
>
>
