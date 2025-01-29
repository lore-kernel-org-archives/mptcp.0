Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BBC187325
	for <mptcp@lists.linux.dev>; Wed, 29 Jan 2025 20:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738183757; cv=none; b=rtAXceZiVCpbO2ZgcOonNOqzVYy05hR/y/BrI5PHSm6SDGMmVxGUpckq8KUklYG8DEEg3wrYFzCJl1Gb5hptOABpbBZ12WMQbrK4atKv3PXIGRC+0YvltagW3DYNm4WBMMgTwlqSi2ib80HZV4nVqSwMdnW3z7I+G6hbizVOrLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738183757; c=relaxed/simple;
	bh=8+aDlx5aw2K2cV5iANN6aG2maHQjkROMSx1/kBSiJ6k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=krBWRvfDX54dT+zR1jBE8k4ygygge48hUiKN3HanTQoX+E7q94G8W6ZaLtRi/q7F2ANRLH4ceADXGjcgXKH8NQjtKak6i3UzZSOgfUeX5FT3eyxgD7XM/O1mTy4mKMB/YsUVUlOQAdqiUc2C4stcCy8YJLHPjPal8rtYcG20E98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1ba5Nbu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1ba5Nbu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D045C4CED1;
	Wed, 29 Jan 2025 20:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738183755;
	bh=8+aDlx5aw2K2cV5iANN6aG2maHQjkROMSx1/kBSiJ6k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=L1ba5NbuCEKgOfDlReN3kdFbw423D0CiryuzfaOFKGdweyd+4fHIeviBGxGStHTJ4
	 XTJJ2GMK4dQ24eI0pxwbVEEKGi1glHneVJ5nFRcIUFZX173L3cO6uWFDTVQD3a5tG3
	 vHd5ZR26CxRi3ODaprJqBJ0GlpcqI3VQFTM8vUY+vVMMrqRqmY+BN1JSkQHDTRbGb7
	 17XATEBQvDLxVT+s92sKKCsjw+Cf3UJmenH9UM3rxfnQ9ROFeEs1cpSAuewWlTxeuW
	 fmn9dOhupble0rR0VmLmS98l2BnYJIkaNtJ/vcxyd60Rwliisw/cL7gSsobG4RmNhD
	 c1YIPrsfSrpfw==
Date: Wed, 29 Jan 2025 12:49:14 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 1/3] Squash to "bpf: Add mptcp_subflow
 bpf_iter"
In-Reply-To: <af7dca496d83aaf6fd7163f767ef1bd1abbab59a.1737714424.git.tanggeliang@kylinos.cn>
Message-ID: <a3547871-55f1-a9d5-cc63-c25a103ef63a@kernel.org>
References: <cover.1737714424.git.tanggeliang@kylinos.cn> <af7dca496d83aaf6fd7163f767ef1bd1abbab59a.1737714424.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 24 Jan 2025, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Drop the NULL check as Martin suggested.
>
> Use the "struct sock *sk" instead of "struct mptcp-sock *msk" as the
> argument in the bpf_iter_mptcp_subflow_new as Martin suggested.
>
> Use msk_owned_by_me().
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> net/mptcp/bpf.c | 15 +++++++++------
> 1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 923895322b2c..def4de34666d 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -234,24 +234,27 @@ bpf_mptcp_subflow_ctx(const struct sock *sk)
>
> __bpf_kfunc static int
> bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
> -			   struct mptcp_sock *msk)
> +			   struct sock *sk)
> {
> 	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
> -	struct sock *sk = (struct sock *)msk;
> +	struct mptcp_sock *msk;
>
> 	BUILD_BUG_ON(sizeof(struct bpf_iter_mptcp_subflow_kern) >
> 		     sizeof(struct bpf_iter_mptcp_subflow));
> 	BUILD_BUG_ON(__alignof__(struct bpf_iter_mptcp_subflow_kern) !=
> 		     __alignof__(struct bpf_iter_mptcp_subflow));
>
> -	kit->msk = msk;
> -	if (!msk)
> +	if (unlikely(!sk || !sk_fullsock(sk)))
> 		return -EINVAL;
>
> -	if (!sock_owned_by_user_nocheck(sk) &&
> -	    !spin_is_locked(&sk->sk_lock.slock))
> +	if (sk->sk_protocol != IPPROTO_MPTCP)
> 		return -EINVAL;
>
> +	msk = mptcp_sk(sk);
> +	kit->msk = msk;
> +
> +	msk_owned_by_me(msk);

Hi Geliang -

The convention is to check the owner before assigning the msk.

I also noticed in the reply to patch 5 that Martin mentioned adding a 
"bpf_mptcp_sock_from_sock check" to bpf_iter_mptcp_subflow_new 
(https://lore.kernel.org/netdev/9b373a23-c093-42d8-b4ae-99f2e62e7681@linux.dev/)

- Mat

> +
> 	kit->pos = &msk->conn_list;
> 	return 0;
> }
> -- 
> 2.43.0
>
>
>
