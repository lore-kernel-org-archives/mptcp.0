Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8531917C6
	for <mptcp@lists.linux.dev>; Thu, 29 Aug 2024 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941523; cv=none; b=TE2B1r96ziP/xzhjAxP62xpo5m6For2C7oa4JgT0G9bmwkz1r50AaorGgq1pxc+nL3S8B3Eaq48zwTsb3ERFkbThffom0l8XqMKZw4dkp7J93u7P+d7vGfexg8gSThhluWbonMwv8OsveFNn+p+D6sOdlkpxlKQek0mRSVHlInw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941523; c=relaxed/simple;
	bh=/hEtjd8gvdT7OgX03UbFKsTi0FiJb4eMN4TrELCAv5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQeF7Fu4PHo6ctOAEcwC3bej0vuq26pkWmXlai2eMGf5DB+8tKh4J/IXbAVK/rGiO/b6SWyI/Na47GyuQgIn2FnbhgBQJC0497RKUim4kHRxFjJJdm/GirPFBfm/2DT2M8mddttgJXCplQ5iqadYCJDxws2fmAnsp6eprbzkaKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDRBCyMb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDRBCyMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAC5C4CEC1;
	Thu, 29 Aug 2024 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724941522;
	bh=/hEtjd8gvdT7OgX03UbFKsTi0FiJb4eMN4TrELCAv5Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tDRBCyMbJA2dZZw2Rh9rQfNl85FHKMg3TvwCCQVbR5UvzsE9u23/lKfEb3UB9rZOZ
	 e83BmCL0X2McmKhQkLYJujiX6bhZIK4o6wx1Q52LwaBfNXEtKi9cciUWeHuNGxEKWI
	 m2xngW2+g+EWyHhwZfEMJfr4bEZqAURRraRli5wVe6QShCbT+3hls5bS78ZeqPEbf4
	 fbWozyZMmcmDJGxp6n4GnGFSPlY3fwfuPZoafG7TwjG3tRLkFyQUGifvdl7UcymD6p
	 7j/XfE8QbtW3aLMTpIOnI4CDVhRHhbHk/qLnGx6YT1cHV+my2lnb2fJ1jTMhAVm+Vs
	 CdE58P0hH2bpw==
Message-ID: <7a04e174-a468-4e8d-9dae-013ca55066cb@kernel.org>
Date: Thu, 29 Aug 2024 16:25:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v5 1/3] selftests/bpf: Add getsockopt to
 inspect mptcp subflow
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1724899785.git.tanggeliang@kylinos.cn>
 <bd9b737530f156c6741d158300e7cb625f39dca2.1724899785.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <bd9b737530f156c6741d158300e7cb625f39dca2.1724899785.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

cc: -Martin (not to annoy him with MPTCP specific stuff)

On 29/08/2024 04:53, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a "cgroup/getsockopt" way to inspect the subflows of a
> mptcp socket.
> 
> mptcp_for_each_stubflow() and other helpers related to list_dentry are
> added into progs/mptcp_bpf.h.
> 
> Add an extra "cgroup/getsockopt" prog to walk the msk->conn_list and use
> bpf_core_cast to cast a pointer to tcp_sock for readonly. It will allow
> to inspect all the fields in a tcp_sock.

(...)

> diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> index bc572e1d6df8..6a7cf71c2795 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> @@ -4,6 +4,7 @@
>  
>  /* vmlinux.h, bpf_helpers.h and other 'define' */
>  #include "bpf_tracing_net.h"
> +#include "mptcp_bpf.h"
>  
>  char _license[] SEC("license") = "GPL";
>  
> @@ -57,3 +58,64 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
>  
>  	return 1;
>  }
> +
> +static int _check_getsockopt_subflow_mark(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	int i = 0;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk;
> +
> +		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
> +							   struct mptcp_subflow_context));
> +
> +		if (ssk->sk_mark != ++i)
> +			ctx->retval = -1;
> +	}
> +
> +	return 1;
> +}
> +
> +static int _check_getsockopt_subflow_cc(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
> +{
> +	struct mptcp_subflow_context *subflow, *tmp;
> +
> +	mptcp_for_each_subflow_safe(msk, subflow, tmp) {

Out of curiosity, why do you need the '_safe()' helper here? Just to
check it works?

> +		struct inet_connection_sock *icsk;
> +		struct sock *ssk;
> +
> +		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
> +							   struct mptcp_subflow_context));
> +		icsk = bpf_core_cast(ssk, struct inet_connection_sock);
> +
> +		if ((ssk->sk_mark == 1 &&
> +		     __builtin_memcmp(icsk->icsk_ca_ops->name, cc, TCP_CA_NAME_MAX)) ||

In your previous version, you had a patch to set the cc on the other
subflow, not to change the value of 'getsockopt(TCP_CONGESTION)' seen by
the userspace. Why did you drop it?

> +		    (ssk->sk_mark == 2 &&
> +		     __builtin_memcmp(icsk->icsk_ca_ops->name, "cubic", TCP_CA_NAME_MAX)))

You cannot check this one (or at least not like that): the default TCP
CC can be changed with a kernel config, it is not necessarily cubic.

I think it is fine to only check the other subflow.

> +			ctx->retval = -1;

Should you not mark it as an error if the mark is different from 1 or 2?
(Or maybe not, because that's covered by _check_getsockopt_subflow_mark)

> +	}
> +
> +	return 1;
> +}
> +
> +SEC("cgroup/getsockopt")
> +int _getsockopt_subflow(struct bpf_sockopt *ctx)
> +{
> +	struct bpf_sock *sk = ctx->sk;
> +	struct mptcp_sock *msk;
> +
> +	if (!sk || sk->protocol != IPPROTO_MPTCP)
> +		return 1;

If this test fails, the check will not be done.

> +
> +	msk = bpf_core_cast(sk, struct mptcp_sock);
> +	if (msk->pm.subflows != 1)
> +		return 1;

Same here: if there is no extra subflow, the test is silently not done.
You change 'ctx->retval'.

Also, it might be good to print something somewhere everywhere you set
this 'ctx->retval' to -1, to be able to easily understand what went
wrong, no? Can we use bpf_printk() or something similar?

> +
> +	if (ctx->level == SOL_SOCKET && ctx->optname == SO_MARK)
> +		return _check_getsockopt_subflow_mark(msk, ctx);
> +	if (ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION)
> +		return _check_getsockopt_subflow_cc(msk, ctx);
> +
> +	return 1;
> +}

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

