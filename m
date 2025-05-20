Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB861EB5DA
	for <mptcp@lists.linux.dev>; Tue, 20 May 2025 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740211; cv=none; b=rMG89AVS8rbyONeOlGVay0JygIMizCVrRoTxRmBYdjU3cUeAR3IxbT4eS07Og2NTn5as2N0D+HGXLW6dGayuzlmUvPklf5sSgeHxukWSWO9BzHY5Kv1Rutq/MMsMtrbWqE3Yu0/PIl2qvwy2Vf4sJbWEe64Hs6Vv0J5fwrpZ0iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740211; c=relaxed/simple;
	bh=nP/BMI/71QSc/5LGgX27pQeBo2KxBX8gSRsxyOTKAlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJECymkr5wuXKez4hg1fBvkN738dWX1iAzRSTIS3GYgeAxMzHiZowisKFLacmR4PHZWe1XvZt9jicpPVl53+dcLqQGO37AdFe/UP/ctVBSZAJqGNK9ak5x0vTZZhL3CsmRlLpvStaZGvMaiR92wUoFg9j+xTHEzpze7n15Vf4VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDBAuOA9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDBAuOA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF45C4CEE9;
	Tue, 20 May 2025 11:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747740211;
	bh=nP/BMI/71QSc/5LGgX27pQeBo2KxBX8gSRsxyOTKAlE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WDBAuOA9U5r7yozWpcsySENa2SRIbtIMZrcH9kMbi2qLxFUFON37b4m8ObE5CAPWL
	 +c837RDMhZS9eSEubNkZHssxQmFEFgazt+cPwVoLpOnZDlkqZP/rryL6ribZLvBeQY
	 S+rXmQpGm8mQ5xMaF0X3VXT3UNtTdjm3QAvUAJbaWNVp5RdezmEVxJmOnaeoZx1qwX
	 UrFTo/CCmzjftP3abYu/ogn3Aq8OuH0ORLPFkluxr72y3nrzkvO7gAdO2ADwkEhy18
	 7Po7qGSvXRN12kf4JQIxiJz91D7/lCVNxGT/1TvzjkIh7fJzixpHHQE7OFuGd6dt+h
	 n2a4dxkU6juEQ==
Message-ID: <43df7eab-598a-4c92-9422-212812b45301@kernel.org>
Date: Tue, 20 May 2025 13:23:27 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 1/2] Squash to "selftests/bpf: Add
 mptcp_subflow bpf_iter subtest"
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1747730598.git.tanggeliang@kylinos.cn>
 <3f054bc9184c55420faf7904c8c04bd2d92dab81.1747730598.git.tanggeliang@kylinos.cn>
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
In-Reply-To: <3f054bc9184c55420faf7904c8c04bd2d92dab81.1747730598.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for this follow-up!

On 20/05/2025 10:48, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Define mptcp_subflow_ctx() using bpf_core_cast as Martin suggested.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/progs/mptcp_bpf.h       | 10 ++++++++++
>  tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c |  2 +-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> index 4e901941d5dd..815bbf865ee4 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> @@ -39,6 +39,16 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
>  	return subflow->tcp_sock;
>  }
>  
> +static __always_inline struct mptcp_subflow_context *
> +mptcp_subflow_ctx(const struct sock *sk)
> +{
> +	const struct inet_connection_sock *
> +		icsk = bpf_core_cast(sk, struct inet_connection_sock);
> +
> +	/* Use RCU on icsk_ulp_data only for sock diag code */
> +	return bpf_core_cast(icsk->icsk_ulp_data, struct mptcp_subflow_context);
> +}
> +
>  /* ksym */
>  extern struct mptcp_subflow_context *
>  bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
> index a1d8f9b20259..88a3100dfdc2 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
> @@ -48,7 +48,7 @@ int iters_subflow(struct bpf_sockopt *ctx)
>  		goto out;
>  
>  	/* only to check the following kfunc works */

Then we can remove this comment.

> -	subflow = bpf_mptcp_subflow_ctx(ssk);
> +	subflow = mptcp_subflow_ctx(ssk);
>  	if (!subflow || subflow->token != msk->token)
>  		goto out;
>  

Note that when reading Martin's review again, it looks like this
selftest is not really useful. Maybe we should drop it? WDYT?

If we do, the "common" kfunc should no longer be registered for
BPF_PROG_TYPE_CGROUP_SOCKOPT, right? I think it makes sense anyway. I
don't think we need that, at least not for the moment. Then, better to
restrict to struct_ops to help with the maintenance ; except if you see
useful use-cases for this CGroup SockOpt program type?

What we did in the selftest could be done without the kfunc, and we
didn't find anything really useful to do with the kfunc, right?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

