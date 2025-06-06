Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395682AD0D
	for <mptcp@lists.linux.dev>; Fri,  6 Jun 2025 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749211366; cv=none; b=K14LUFrX3EisNgkQB2WV9uE8kIXZag5l6sf2B4+5UnqQrROtFNb235NrqkjawAfv16v7CUpPDn7E05+hHWUykMa7iaydUWhEZmGD8lwA1IoDr4yYXQNqNL/MrwZ8lM+bSijPYnjgPta0kJ53vodMy4D8491jCGth6LYDVG3phHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749211366; c=relaxed/simple;
	bh=Xl1izAwoHPe47cjJDheZ0qKm01paYwLlFjIdD0B9bJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blfEVHnTAlq7QLf2p9fqvug3ZB1pYbZ2iUW+o/ItJIc3gRmpeyPmL8IdwxUrLf52VaWeherio9ziqY5zGkVWeSOzOKApvzGd1G24GDeYccqNERscrO7d9Qu2fDODNKk0SIxybH9+Z0D8Itp8s/bhNDgukZHuiYGDKuewC2KMQJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmBdvOCp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmBdvOCp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9273C4CEEB;
	Fri,  6 Jun 2025 12:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749211365;
	bh=Xl1izAwoHPe47cjJDheZ0qKm01paYwLlFjIdD0B9bJM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UmBdvOCp0AibKJ3CIdodZo0I6lmGpBcYdtl+fz523aWLJRW+wzvpEJD7tTcBjGIv9
	 QFmiHSMEvngqOMnVya6SKbp+G32nNx+JsFHE/M35asJxXIYVyuJRy6wDO69Mt3FVe7
	 4Yh11SUZ1/JJWljaNSAPwOJQTtK5auLd9pp5J2FISVcuZGpvVD4wW1zf/iEyPRbuBX
	 E9L394VxI1wzH6xZLKTlNzKzvB5BimVa31tpJDEjyVJGudzWFgdrA2UbQ9xx5UsrAQ
	 Erdsb2W6w9RIpWyjH/YMRz2Y/TvZa+pEr4Z3uZ7J61d+i+w8nLJmZq9JXij/gYD9u8
	 v0j/6fV50Dr4g==
Message-ID: <32fdb4b0-5378-4697-b87f-4341d25991ac@kernel.org>
Date: Fri, 6 Jun 2025 14:02:44 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 2/3] Squash to "bpf: Add mptcp_subflow
 bpf_iter"
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1748592117.git.tanggeliang@kylinos.cn>
 <844a8399d77722ad06eb11751c468c7f46d3f3cd.1748592117.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <844a8399d77722ad06eb11751c468c7f46d3f3cd.1748592117.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 30/05/2025 10:03, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Define .filter as Martin suggested.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/bpf.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 113aad086b37..e52821bae49c 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -305,9 +305,6 @@ __bpf_kfunc_end_defs();
>  BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
>  BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock, KF_RET_NULL)
> -BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
> -BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
>  BTF_ID_FLAGS(func, mptcp_subflow_active)
>  BTF_ID_FLAGS(func, mptcp_set_timeout)
> @@ -338,6 +335,31 @@ static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
>  	.filter	= bpf_mptcp_common_kfunc_filter,
>  };
>  
> +/* .filter is called sometimes before prog->aux->st_ops is set,
> + * then prog->aux->st_ops is NULL. If return -EACCES in this case,
> + * an error occur:
> + * 	bug: bad parent state for iter next call
> + */
> +BTF_KFUNCS_START(bpf_mptcp_iter_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
> +BTF_KFUNCS_END(bpf_mptcp_iter_kfunc_ids)
> +
> +static int bpf_mptcp_iter_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
> +{
> +	if (btf_id_set8_contains(&bpf_mptcp_iter_kfunc_ids, kfunc_id) &&
> +	    prog->type != BPF_PROG_TYPE_STRUCT_OPS)

Correct me if I'm wrong, but I think this filter is not needed: it
simply restricts to (any) BPF_PROG_TYPE_STRUCT_OPS, which is already the
case without this filter because this kfunc set is only registered for
this program type, no?

When applying the patches, I removed this function, the corresponding
.filter, and the comment explaining the error with .filter (at the end,
this iterator can be used elsewhere, and it is cleaner like that).
Please tell me if that was not correct.

> +		return -EACCES;
> +	return 0;
> +}
> +
> +static const struct btf_kfunc_id_set bpf_mptcp_iter_kfunc_set = {
> +	.owner	= THIS_MODULE,
> +	.set	= &bpf_mptcp_iter_kfunc_ids,
> +	.filter	= bpf_mptcp_iter_kfunc_filter,
> +};
> +
>  static int __init bpf_mptcp_kfunc_init(void)
>  {
>  	int ret;
> @@ -345,6 +367,8 @@ static int __init bpf_mptcp_kfunc_init(void)
>  	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>  					       &bpf_mptcp_common_kfunc_set);
> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> +					       &bpf_mptcp_iter_kfunc_set);
>  #ifdef CONFIG_BPF_JIT
>  	ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_sched_ops, mptcp_sched_ops);
>  #endif

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

