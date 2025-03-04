Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D923137923
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 01:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052393; cv=none; b=CXiqbWsBP5OkjDJqg2d/LAxW5vWfDHpVVSUoTykAaofjVXxYSVJzJQl3FVPzVOBqVmX5FkBgtScQ84YoU2G8RwYzI/PHkGnvN7aoIpWPCIGhrwjLBaJYzwCEw2K+8xtdkCynIjXRmzpWhGrVEf4wwsk6UQ5XK94Y9/Fy7qM9ikI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052393; c=relaxed/simple;
	bh=dykUrqV1az9bKrxMcpig54YNrvGsqZTVVYzaJYa4nIU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iZjdpxRs/3vBJVEw+TVdYGxk0bGkF+VhhXckj59447eY0zPadi1toEcRoehoEEnNbaYLwGQ0CW8sPz1i8N+ijlQwKQwiXNs7PM1K8WvFpowKfY9gZ6YtkZRqpQda2OVXC+PdhTQaAkDPOlYpCL6+IBXa+eWrVyFjituzDp+O9Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwNYbh80; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwNYbh80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D132C4CEE4;
	Tue,  4 Mar 2025 01:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741052393;
	bh=dykUrqV1az9bKrxMcpig54YNrvGsqZTVVYzaJYa4nIU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=JwNYbh80K+3WwNOXFWi5IqhfkH3UmYVzcBqDTzaask+DvguGWUQevEho4COJLdw1P
	 DRgnWycdifJargnvZjBLfjyfZnT3dVjRoqnDBbeaGKyR7T8rrkcN/EZR4OwRTZ/dPc
	 6UapwFllWD9O/x6C+p7qCefxhnZ3VaLaXEXV43BbHYYW8KPNh6IL5T8E/E9XTi3PcK
	 B18X9UR0d20B05PslJSWf6d53a8Ps6txELkKRUmQY1/55awCTsUglR0pK2XfThiCkq
	 NFmp9jqMgWlxs297nNsiMo+S60itJCcGU6kd5eEIR2vllN2yXewJUKXGqYn5O1mG6y
	 M6NpvluwoUZBA==
Date: Mon, 3 Mar 2025 17:39:52 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 3/5] Squash to "bpf: Add mptcp_subflow
 bpf_iter"
In-Reply-To: <f8d59dcb8391483787f832ddb43035846055aafb.1740997925.git.tanggeliang@kylinos.cn>
Message-ID: <c15a5390-a721-0d65-9b00-e9d1d02367de@kernel.org>
References: <cover.1740997925.git.tanggeliang@kylinos.cn> <f8d59dcb8391483787f832ddb43035846055aafb.1740997925.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 3 Mar 2025, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Drop the NULL check for 'msk' as Martin suggested, add more checks
> for 'sk'.
>
> Use the "struct sock *sk" instead of "struct mptcp-sock *msk" as the
> argument in the bpf_iter_mptcp_subflow_new as Martin suggested.
>
> v5:
> - check bpf_iter_task in mptcp_subflow_new()
>
> v4:
> - drop sock_owned_by_user_nocheck and spin_is_locked. According to
>   comments from Mat [2] and Martin [1], in this set mptcp_subflow
>   bpf_iter only used from a cg sockopt bpf prog, no need to add these
>   check at this moment.
>
> [1]
> https://lore.kernel.org/all/fdf0ddbe-e007-4a5f-bbdf-9a144e8fbe35@linux.dev/
> [2]
> https://patchwork.kernel.org/project/mptcp/patch/f6469225598beecbf0bda12a4c33fafa86c0ff15.1739787744.git.tanggeliang@kylinos.cn/
>
> v3:
> - continue to use sock_owned_by_user_nocheck and spin_is_locked
> checks instead of using msk_owned_by_me().
>
> v2:
> - check the owner before assigning the msk as Mat suggested.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> net/mptcp/bpf.c | 21 +++++++++++++++------
> 1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index aff92f458e7f..a307490bb20e 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -249,24 +249,33 @@ bpf_mptcp_subflow_ctx(const struct sock *sk)
>
> __bpf_kfunc static int
> bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
> -			   struct mptcp_sock *msk)
> +			   struct sock *sk)
> {
> 	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
> -	struct sock *sk = (struct sock *)msk;
> +	struct task_struct *task;
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
> +	task = mptcp_get_bpf_iter_task(msk);
> +	if (!task || task != current)
> +		return -EINVAL;

Hi Geliang -

The task checking logic would fit better inside the helper, since every 
caller will be checking to see if it matches 'current'.

I also think it would read better as (task && task == current)


> +
> +	mptcp_clear_bpf_iter_task(msk);

This needs to be cleared where the lock is released, not where the task is 
checked.

- Mat

> +
> +	msk_owned_by_me(msk);
> +
> +	kit->msk = msk;
> 	kit->pos = &msk->conn_list;
> 	return 0;
> }
> -- 
> 2.43.0
>
>
>
