Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140A18BEA
	for <mptcp@lists.linux.dev>; Fri, 14 Feb 2025 01:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739497547; cv=none; b=GZtamkHR4oILZdmrJUuG7QYBdWMz4ao1+g9lNx1iag9U+ygtSTWkBYisK13l3IWyF3cxKOhK3S7qT0hAyXgMm5Ou1/Qmwz/UtQ0c82LxgIu9gWknnvLJrA2/YWz/8EGg07w3GXyVZqzqGxA98+mXRQe5rzmqhVDADvTAbS9xUfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739497547; c=relaxed/simple;
	bh=O0XwflrrBiTEB/H6PT+ujbAStRGJmiBRd9kPXx1+OYk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ptph9RI7iQ4ztqYmYCuyUVyYPJIW3Z8RUum9Fa5sZB60pPVWNX5JMNrz9kMon0hcdcrMZ0L7qmBKQqTEp4SHDhFD0qtjzpLe5tSQEEcsT+FAm/huvb95UUFlHsRiwDr8Ri07faA8lnZpjIxc9My0FFkhRVvZ7buno7k9BmoMhnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxaVUnkH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxaVUnkH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9C7C4CED1;
	Fri, 14 Feb 2025 01:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739497546;
	bh=O0XwflrrBiTEB/H6PT+ujbAStRGJmiBRd9kPXx1+OYk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=RxaVUnkHiZ7tHHXXUoMrtADrzminNzIKpFMM2Ikfze+xxJc+kAUfE8A/t3opJrJq3
	 8QwDgHEEfsIW9PXvji0OYkTXCg0Ww70OnVG6Mz40Y0kMp4gxZjbXn/mN1y/ktZS5JS
	 6ZpWUhmlOZoqp0IVU0wdoZeFBjUBScCnsMg/C5xvMu0MA1f+V2oir55G5YG/yxxyOv
	 g8WRGiASkrPc4U67f4U3cl/9qyj8FfuuKgVbHzXNMrGXgFzrCExo2pEjX4EQ3aKZ+L
	 xBGH/p3o1R4kJefdD9bFrRIbXGYw8lU8ArUOun72S8Mu4EAY94L4ZKRET3gDKfMHuv
	 fWGLKf6gRsoZQ==
Date: Thu, 13 Feb 2025 17:45:45 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 5/5] Squash to "selftests/bpf: Add
 mptcp_subflow bpf_iter subtest"
In-Reply-To: <b5fee152138c047d02911d31e12d7f5616ae56f2.1738470660.git.tanggeliang@kylinos.cn>
Message-ID: <193e629a-dde2-3d97-98ff-9a6735c0aa2f@kernel.org>
References: <cover.1738470660.git.tanggeliang@kylinos.cn> <b5fee152138c047d02911d31e12d7f5616ae56f2.1738470660.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sun, 2 Feb 2025, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Use bpf_core_cast() instead of bpf_skc_to_mptcp_sock().
> Change the 2nd parameter type of bpf_for_each() as 'struct sock'.
> Drop bpf_mptcp_sock_acquire/release.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> tools/testing/selftests/bpf/bpf_experimental.h      | 2 +-
> tools/testing/selftests/bpf/progs/mptcp_bpf.h       | 3 ---
> tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c | 8 ++------
> 3 files changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index 2ab3f0063c0f..6a96c56f0725 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -577,7 +577,7 @@ extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
>
> struct bpf_iter_mptcp_subflow;
> extern int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
> -				      struct mptcp_sock *msk) __weak __ksym;
> +				      struct sock *sk) __weak __ksym;
> extern struct mptcp_subflow_context *
> bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it) __weak __ksym;
> extern void
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> index b1f6e1fb467e..ede9111ee597 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> @@ -43,9 +43,6 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
> }
>
> /* ksym */
> -extern struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk) __ksym;
> -extern void bpf_mptcp_sock_release(struct mptcp_sock *msk) __ksym;
> -
> extern struct mptcp_subflow_context *
> bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
> extern struct sock *
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
> index fd5691a4073b..2c0d11cb9864 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
> @@ -24,14 +24,11 @@ int iters_subflow(struct bpf_sockopt *ctx)
> 	if (ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
> 		return 1;
>
> -	msk = bpf_skc_to_mptcp_sock(sk);
> +	msk = bpf_core_cast(sk, struct mptcp_sock);
> 	if (!msk || msk->pm.server_side || !msk->pm.subflows)
> 		return 1;
>
> -	msk = bpf_mptcp_sock_acquire(msk);

Hi Geliang -

Why is the locking removed? The squashed commit will still have a commit 
message referring to the acquire/release, so that isn't consistent with 
the modified code.

bpf_iter_mptcp_subflow_new() does have the msk_owned_by_me() check, but on 
a kernel without CONFIG_LOCKDEP it doesn't do anything.

- Mat

> -	if (!msk)
> -		return 1;
> -	bpf_for_each(mptcp_subflow, subflow, msk) {
> +	bpf_for_each(mptcp_subflow, subflow, (struct sock *)sk) {
> 		/* Here MPTCP-specific packet scheduler kfunc can be called:
> 		 * this test is not doing anything really useful, only to
> 		 * verify the iteration works.
> @@ -58,6 +55,5 @@ int iters_subflow(struct bpf_sockopt *ctx)
> 	ids = local_ids;
>
> out:
> -	bpf_mptcp_sock_release(msk);
> 	return 1;
> }
> -- 
> 2.43.0
>
>
>
