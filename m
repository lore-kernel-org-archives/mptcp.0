Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAA61DB372
	for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737710030; cv=none; b=pvNNefn4FnK3cQGb837kq6Pczvu2hw2chi4gftscveozWepBFkxnaskm/lHeMZRpmzJp3T6oY1d9ESbvQ7HBrMFjZILrYmYc37bsExD0Tqiju6oBDO/bCa0uF3a6MK/5/aPf1bCwdKdWrWg3B1CfKpc8nT7Um65fcBazsiSaugg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737710030; c=relaxed/simple;
	bh=fVLO9aormhJjhAX7lZ+p/7kSWPi49dhv0FYYrIk7gnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=hdt+7eDnzaWI/hE7jaZEh06GfvvN011AuAbTg+wnaYZVjrPYSvDVoAevA+6BXTVN7ronicOw797+DswvQjC2vXwDAVZB5V2Twz8HpXPEWGgOZIYmbxBLhu7QtukeuwiQGhzV3eyAD+RZzRmjpYid78/G85OGDh2obEjYiW+11YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWLj9AvZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWLj9AvZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8C9C4CED2;
	Fri, 24 Jan 2025 09:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737710029;
	bh=fVLO9aormhJjhAX7lZ+p/7kSWPi49dhv0FYYrIk7gnQ=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=GWLj9AvZrLuqN4HopbtIlwhqBove2DALEh36gSlWLyNsk3DD+35Xf78CM+Q061fQT
	 sVWROv8dBu0WPTXmtNp9Esw0gQTux4hUKJlGLDjIG4sKU+JhSriHr2cM1eMsq1Hw81
	 4m/qxgOwSPev/oUIzEriCq93jfjOf+gyIdfwlpxcEUIuLRuAI/WclIJPT3RNqWSiqy
	 kHRaXoRPraRC1glb+ha4tf7CSacs+4ZtOJVhUfI+bt7mfAKAnt9JooDqadEup83ZuM
	 d9AWBApjR7/aTK+q9H3tYJvcOLlcYvq/Iq7Q7sc1oR8lye7QXNsnGDtlP5MsFOwjwL
	 +y0AaB3pWgmTQ==
Message-ID: <71409ffc-ef6c-4520-941c-ec048c7e4ac0@kernel.org>
Date: Fri, 24 Jan 2025 10:13:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next/net v2 7/7] selftests/bpf: Add mptcp_subflow
 bpf_iter subtest
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>
References: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-0-ae244d3cdbbc@kernel.org>
 <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-7-ae244d3cdbbc@kernel.org>
 <5313b129-72b1-4fdc-954e-e2d0a141a99c@linux.dev>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
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
In-Reply-To: <5313b129-72b1-4fdc-954e-e2d0a141a99c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

(only with the MPTCP list)

On 24/01/2025 02:38, Martin KaFai Lau wrote:
> On 12/19/24 7:46 AM, Matthieu Baerts (NGI0) wrote:
>> +SEC("cgroup/getsockopt")
>> +int iters_subflow(struct bpf_sockopt *ctx)
>> +{
>> +    struct mptcp_subflow_context *subflow;
>> +    struct bpf_sock *sk = ctx->sk;
>> +    struct sock *ssk = NULL;
>> +    struct mptcp_sock *msk;
>> +    int local_ids = 0;
>> +
>> +    if (ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
>> +        return 1;
>> +
>> +    msk = bpf_skc_to_mptcp_sock(sk);
>> +    if (!msk || msk->pm.server_side || !msk->pm.subflows)
>> +        return 1;
>> +
>> +    msk = bpf_mptcp_sock_acquire(msk);
>> +    if (!msk)
>> +        return 1;
>> +    bpf_for_each(mptcp_subflow, subflow, msk) {
>> +        /* Here MPTCP-specific packet scheduler kfunc can be called:
>> +         * this test is not doing anything really useful, only to
>> +         * verify the iteration works.
>> +         */
>> +
>> +        local_ids += subflow->subflow_id;
>> +
>> +        /* only to check the following kfunc works */
>> +        ssk = mptcp_subflow_tcp_sock(subflow);
> 
> It is good to have test cases to exercise the new iter and kfunc. Thanks.
> 
> However, it seems not useful to show how it will be used in the future
> packet/subflow scheduler. iiuc, the core piece is in bpf_struct_ops.
> Without it, it is hard to comment. Any RFC patches ready to be posted?

If it is easier, we can probably share a link to your git repo
containing the WIP patches.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

