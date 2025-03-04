Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9DE1754B
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 01:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052226; cv=none; b=g8tr+ve3FcIanY2RWdFzhB5bFSFW61HYMNjFDprW543c3TbC+8wZqyOpcdu4HrMcAxAMBm+KxLJA13jjSfBMr7p9NZxYPfSNwn93B0FpN5RHyZ2TDiaKNtBmYriN6zKxukEPRHARez1K3fh3NvbCz4hKta6E6X2gx20MThDPnVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052226; c=relaxed/simple;
	bh=qxi4CKAn5wON90giUFLCMmXLBDC9fmN1tOivDPE/V7w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hbrS70YobMi0YyvLwxnCaKDZhp0xv/XcryyVIKQSWKkWNENnwXGv/pe7cWpYfTRxPb3bW+DjhfdVykcgwZGhbg0QsMHCE3/BTNyfK1U7HFxqm93b5HDPB0s20d/882rQxCMqi2iaeL454/xCQiUGoghH9tmUAZMCCupQN43Yr24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4ZQv9s1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4ZQv9s1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E324C4CEE4;
	Tue,  4 Mar 2025 01:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741052225;
	bh=qxi4CKAn5wON90giUFLCMmXLBDC9fmN1tOivDPE/V7w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=H4ZQv9s19tSMX1LAr2Z8ts4HpSHfb7xnyqCl4TGZg0o/W4DIf7nPy+LGlXpYGNFIT
	 8kMO6JAfjkeop7D3iqh/IChbz9oC+nTGYhRI0qqZm6NffIwehYvdfQGmOx55QHsqgV
	 QuolRZwA3diBG6eEBABV27E9lrrzyDF2vcYtNG8B5DN6TITUaSiXVnkiLK5pFYKbjP
	 1PO7b5I2ZZZGQBeGIeDBYOlAMq3qlOk3Kl4Iis77L62nesMuhdYJyXxnMM+Tj6nSfR
	 nFVXV/lN2WFqKuR8OxTa89151zPQkmKIdUw2pmHTJdmenjBk4b1Coq3BGkLnq66oxB
	 vnEhFv6jHSkgg==
Date: Mon, 3 Mar 2025 17:37:04 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 2/5] Squash to "bpf: Extend bpf_skc_to_mptcp_sock
 to MPTCP sock"
In-Reply-To: <c43f5e1fe8da4db01749ede9d18af1a3a2134fd4.1740997925.git.tanggeliang@kylinos.cn>
Message-ID: <b45a0591-597a-46cf-7315-cf4dce7dbd7a@kernel.org>
References: <cover.1740997925.git.tanggeliang@kylinos.cn> <c43f5e1fe8da4db01749ede9d18af1a3a2134fd4.1740997925.git.tanggeliang@kylinos.cn>
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
> Set msk->bpf_iter_task in bpf_mptcp_sock_from_sock() to allow
> mptcp_subflow bpt_iter can be used in cgroup/getsockopt,
> otherwise, the selftest in this set fails.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> net/mptcp/bpf.c | 16 ++++++++++++----
> 1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index be222fa5f308..aff92f458e7f 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -197,14 +197,22 @@ static struct bpf_struct_ops bpf_mptcp_sched_ops = {
>
> struct mptcp_sock *bpf_mptcp_sock_from_sock(struct sock *sk)
> {
> +	struct mptcp_sock *msk;
> +
> 	if (unlikely(!sk || !sk_fullsock(sk)))
> 		return NULL;
>
> -	if (sk->sk_protocol == IPPROTO_MPTCP)
> -		return mptcp_sk(sk);
> +	if (sk->sk_protocol == IPPROTO_MPTCP) {
> +		msk = mptcp_sk(sk);
> +		mptcp_set_bpf_iter_task(msk);

Hi Geliang -

The important part of the bpf_iter_task approach is to only set the 
task_struct pointer when the msk lock is already held, and to clear it 
before the msk lock is released. When used this way, the check ensures 
that the iterator code is both *running with the socket locked* and *in 
the same context where the lock is held*.

The code above will set msk->bpf_iter_task even when the lock is not held, 
and then it is never cleared.

To set/clear as expected for get/setsockopt I think the task pointer would 
have to be set in places where the locks are acquired and released, like 
these:

https://elixir.bootlin.com/linux/v6.14-rc5/source/kernel/bpf/cgroup.c#L1955
https://elixir.bootlin.com/linux/v6.14-rc5/source/kernel/bpf/cgroup.c#L1846


- Mat

> +		return msk;
> +	}
>
> -	if (sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
> -		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
> +	if (sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk)) {
> +		msk = mptcp_sk(mptcp_subflow_ctx(sk)->conn);
> +		mptcp_set_bpf_iter_task(msk);
> +		return msk;
> +	}
>
> 	return NULL;
> }
> -- 
> 2.43.0
>
>
>
