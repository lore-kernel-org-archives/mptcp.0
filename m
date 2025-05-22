Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A360028FFE1
	for <mptcp@lists.linux.dev>; Thu, 22 May 2025 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747926827; cv=none; b=GNe6Qf9BQZR090FHVme2iTbvAIfcUSsG4jjQprb/pabDmsIFq3nad7MFZTG2a5i62yWR6pSbrj7bbKm0P7OYdt9TBzTNwh45dyGXVxcPle+M8rtxLXv4Rthwdac+UEhXfpeXKNDZbYOdsnsBxXfaCsCWLxPUPOQ9pL0vFC+8HmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747926827; c=relaxed/simple;
	bh=SjcSD1h+kF3q9d8Dr3o9P19SLWr+dhShD/qdtFKEz6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+IPZQAP4+o4NirHZou/0xJ0EwFSD1PqKMJmo09yi6n1yhsfOcVhXkLp8/X7+lZWPoXi9r+HXKFwQ73ZR+/pzSiE8Qi1s20AEmLkuzrHFo0tD6lQwBYr1fh1Zm+HS/Be7hBVtmBlLp77KZ+QRuVZlUXdGP5+JacukIE9tX0d880=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpvHUM1+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpvHUM1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AE1C4CEE4;
	Thu, 22 May 2025 15:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747926827;
	bh=SjcSD1h+kF3q9d8Dr3o9P19SLWr+dhShD/qdtFKEz6M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jpvHUM1+COBQY7F9W4KIYf57aLxa487Pv0AEB/c7RfbLhWwRSyJNZtQcBiWo+pGfP
	 xJsyFcL4thS1ya+kuTnGvM1RXw0aqQKvcSEsSeCUiHTFLu/zuO6O57MUxS8+sRkIyu
	 qVupNYTZE80AvBQk68OF4fIGAppqE8N4a0VSvgcNKmapwL7vX0p31iGUgq19EbVkzs
	 /6N2cUzuUZJPL7kp6FaDNBnU2K0DP1CVAXLWDGQ9RCY+6w5qM+5tNSJNmgxtyJLOwa
	 JRsbVGArxD4seh4B7UA2GluRSiGpRBDuX77sTRnxjZQ8HJ25MfIo5IbBv9eEOSVqrb
	 3x9PZ5BrwhD3g==
Message-ID: <5f87dca1-e02b-4d66-9cb4-89d104ca5c39@kernel.org>
Date: Thu, 22 May 2025 17:13:44 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 2/2] Squash to "bpf: Export mptcp packet
 scheduler helpers"
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1747897261.git.tanggeliang@kylinos.cn>
 <dfd9d56e608ea3f68297092c9e90134e4807d3d6.1747897261.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <dfd9d56e608ea3f68297092c9e90134e4807d3d6.1747897261.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/05/2025 09:05, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Define .filter as Martin suggested.

Thank you for the v2.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/bpf.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 2b0cfb57df8c..c7a9d1393786 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -317,9 +317,30 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
>  BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
>  BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
>  
> +static int bpf_mptcp_common_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
> +{
> +	if (!btf_id_set8_contains(&bpf_mptcp_common_kfunc_ids, kfunc_id))
> +		return 0;
> +
> +	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
> +		return -EACCES;
> +
> +	/* .filter is called sometimes before prog->aux->st_ops is set,
> +	 * then prog->aux->st_ops is NULL. If return -EACCES in this case,
> +	 * an error occur:
> +	 * 	bug: bad parent state for iter next call
That's interesting. Did you have this after having removed the register
for BPF_PROG_TYPE_CGROUP_SOCKOPT?

With this extra "prog->aux->st_ops != NULL" check, it sounds like the
filter could allow other ops to use these KFunc, and thus that's an issue.

Do you have more details about the error, and what exactly caused this?
Maybe we should report this issue to BPF maintainers, because what you
did sounds incorrect for a filter, and they didn't have to do that in QDisc.

> +	 */
> +	if (prog->aux->st_ops &&
> +	    prog->aux->st_ops != &bpf_mptcp_sched_ops)
> +		return -EACCES;
> +
> +	return 0;
> +}
> +
>  static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
>  	.owner	= THIS_MODULE,
>  	.set	= &bpf_mptcp_common_kfunc_ids,
> +	.filter	= bpf_mptcp_common_kfunc_filter,
>  };
>  
>  static int __init bpf_mptcp_kfunc_init(void)
> @@ -327,8 +348,6 @@ static int __init bpf_mptcp_kfunc_init(void)
>  	int ret;
>  
>  	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
> -	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT,
> -					       &bpf_mptcp_common_kfunc_set);
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>  					       &bpf_mptcp_common_kfunc_set);
>  #ifdef CONFIG_BPF_JIT

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

