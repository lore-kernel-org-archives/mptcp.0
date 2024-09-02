Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25F41AB6F1
	for <mptcp@lists.linux.dev>; Mon,  2 Sep 2024 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725295632; cv=none; b=hTDepjazqbGdIoy5x8xDj0pR0+Bxyi49Pe2k9iAVNlsuXgQ8BZ1sUEpX4qcY0rOMRxWpm8jUwldin4sL1m7OfBnd77/NK7eVv0Ve/9bMwR3Sf17wzfvmF0ze49EjAKfubz9Wx/q/u0EWSeqjZMcdJHoK7kgK3yphI9ClIzc93aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725295632; c=relaxed/simple;
	bh=mH0PUAaC4SX/dpG9A/cgoEIR5yVL/GoCKchMW9Aqcak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDMuKLOH6M8ahMqgksTWTJJaLOBH9QH1Ctm5aq735aci2IjkJBIrSYQZTKgSAXy766qnLkLyOe0vrGmIsSoWQHRRakuHW2CqbM/4/BCdkiceOP34NgpiC2Bk50fIh0jieULNE9zeUWHrY6Nt9h3B4a3StjueY1obCaUCvrX9+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHf1FiSl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHf1FiSl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BFAC4CECA;
	Mon,  2 Sep 2024 16:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725295631;
	bh=mH0PUAaC4SX/dpG9A/cgoEIR5yVL/GoCKchMW9Aqcak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vHf1FiSl37F1BOYKFUyCaenM0fCCu6HgeSvi2eOOv9o4lLqNbidnfAG4YdcW4l2nv
	 xQD6eEKI8MPIX2L/4rSPg4KsbQxI2tB6oh51HN5/llvpT9pTpVfGk4pRV8IAuOJ9oR
	 O0rGAHzhTw3W9nPylZfIlAiGRuzW72Bses1TpihwdXJu9iSc3m4yXOyzLmu8momona
	 m3HXDCtd8ctWtL4mh7bsucvZ9xJGS1J1mHikVhONZe8G24VFPc1hJM8y7ZS1nK2o65
	 CcIXnjWSYrL6iaabQizEgTeNkQOwxIfImr05VTirpKWXuTiJUy8GPFRQJ9CIC5xHO5
	 nZxSzHyf5SuUg==
Message-ID: <6d54b731-b8a5-4d2c-8569-82ae84fb4b75@kernel.org>
Date: Mon, 2 Sep 2024 18:47:08 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v6 2/4] selftests/bpf: Add getsockopt to
 inspect mptcp subflow
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1725000687.git.tanggeliang@kylinos.cn>
 <0ce049060df256e7376516e4d94af71264a69da0.1725000687.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0ce049060df256e7376516e4d94af71264a69da0.1725000687.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the new version. I still have one opened question about
what is printed in case of error: do we have enough info to debug
issues? Please see below.

On 30/08/2024 08:55, Geliang Tang wrote:
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
> index 2e28f4a215b5..18396532f016 100644
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
> @@ -57,3 +58,71 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
>  
>  	return 1;
>  }
> +
> +static int _check_getsockopt_subflow_mark(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	int i = 0;
> +
> +	if (msk->pm.subflows != 1) {
> +		bpf_printk("subflows=%u", msk->pm.subflows);

I think the message should be a bit longer, e.g.

  "MPTCP Subflow: expected 1 extra subflows, got %u"

It looks like you didn't reply to my question from v5: if there is an
issue with the verifications that are done in BPF, are these bpf_printk
printed somewhere? e.g. if you force it to fail here, do you see the new
message in the logs of the BPF selftests?

If the test is unstable, we need to have a way understand where is the
issue exactly, not somewhere where we set 'ctx->retval = -1'. The best
would be to have a comprehensive message like what I'm suggesting here.
If not, we should at least have a unique retval or errno somehow.

> +		ctx->retval = -1;
> +	}
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk;
> +
> +		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
> +							   struct mptcp_subflow_context));
> +
> +		if (ssk->sk_mark != ++i)
> +			ctx->retval = -1;

Please add an error message here, e.g.

  MPTCP Subflow: expected %d mark, got %d

> +	}
> +
> +	return 1;

(no need to change if you prefer, but your helper is always returning
-1, maybe it doesn't need to return anything?)

> +}
> +
> +static int _check_getsockopt_subflow_cc(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
> +{
> +	struct mptcp_subflow_context *subflow;
> +
> +	if (msk->pm.subflows != 1) {
> +		bpf_printk("subflows=%u", msk->pm.subflows);

Same here.

> +		ctx->retval = -1;
> +	}
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct inet_connection_sock *icsk;
> +		struct sock *ssk;
> +
> +		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
> +							   struct mptcp_subflow_context));
> +		icsk = bpf_core_cast(ssk, struct inet_connection_sock);
> +
> +		if (ssk->sk_mark == 2 &&
> +		    __builtin_memcmp(icsk->icsk_ca_ops->name, cc, TCP_CA_NAME_MAX))
> +			ctx->retval = -1;

Same here.

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
> +	if (!sk || sk->protocol != IPPROTO_MPTCP) {
> +		ctx->retval = -1;

Same here.

> +		return 1;
> +	}
> +
> +	msk = bpf_core_cast(sk, struct mptcp_sock);

Just to be sure: this cast can never fail, and no need to check if 'msk'
is NULL, right?

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

