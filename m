Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E3139B952;
	Tue,  5 May 2026 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777994053; cv=none; b=L0O5NtIQ4pgvMm7c+Idtb4sL5+B0OTS5x0nK25zYVtzv8jRM/SUxdiue/cnyIGYs/MGnNYsX96XLjVvQ52Wb61+qbNfk+ZrQ5AXcJej6jxEoCwBzIl7AGGGjjp4vzecR8AeIETZevAOitmDk0sdxnCkkOvqd4zBOURzMnUIbcOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777994053; c=relaxed/simple;
	bh=yJ/mQCKDNyWieksngGmTrHElKRuZ0mOGGcnfFjZfoqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2T+JgacibGB6y1EKnDcgzTz94XO6KrQhZSIilU4MxP0J2rLhXn9XZlGqn0GhVfktKwu9evANrAmWR336A+aVSqDiTweEjg62+zBVqRZ34mHwRDPxF0d+s+yB5X+3CTVQFQ3bR5zMumPGX/pHXoRJLdGOV8qeScudZCBhqtmNXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqMQr+8E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqMQr+8E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87951C2BCB4;
	Tue,  5 May 2026 15:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777994053;
	bh=yJ/mQCKDNyWieksngGmTrHElKRuZ0mOGGcnfFjZfoqk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eqMQr+8EBUJ65SoEkkHVJK8O4j3mVUGSiFlBXcji5jIKi+gn7xoGcTfrt4UF7m9h5
	 1xTyCxkWlU2Qlr+INPcwtfdEA0Wuqfmi50hFZgdN5FeCe+6+Q/jmz86p5YrjHMpRT5
	 pOzGG2HwqocyR8wIzTEBJEAp4mp/18pUPAEe77F47mCJ0LOAcxP/1H385YJd160Qul
	 DfboSff+xTkwSR6ucKFpr5yHv7+FlASzLzGfXMecYe0tyNO8lry9sF+yUqyfCwxz8+
	 LLVa4TBrDWB0e0cTs+HiMWMQZ5m6QkAeHuZHgvmFLvU7SO/4QDgTqzj3JWeTjqmGl1
	 1k2ulheBiDS/g==
Message-ID: <64a691f2-4104-4538-9aa6-6feadc756c56@kernel.org>
Date: Tue, 5 May 2026 17:14:08 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 bpf 3/6] mptcp: bpf: fix type confusion in
 bpf_mptcp_sock_from_subflow()
Content-Language: fr
To: Kuniyuki Iwashima <kuniyu@google.com>, sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org, MPTCP Linux <mptcp@lists.linux.dev>
References: <20260504210610.180150-4-kuniyu@google.com>
 <20260505041435.187D0C2BCB4@smtp.kernel.org>
 <CAAVpQUB-K4YBE5Em4xg5wWsjtK=7xZwwXFynX2vUN4DQDx2tRw@mail.gmail.com>
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
In-Reply-To: <CAAVpQUB-K4YBE5Em4xg5wWsjtK=7xZwwXFynX2vUN4DQDx2tRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kuniyuki,

(+cc MPTCP ML)

On 05/05/2026 07:43, Kuniyuki Iwashima wrote:
> Could you follow up on the comments by Sashiko ?

Thank you for having forwarded this!

> On Mon, May 4, 2026 at 9:14 PM <sashiko-bot@kernel.org> wrote:

(...)

>>> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
>>> index 8a16672b94e2..4cc16cbeb328 100644
>>> --- a/net/mptcp/bpf.c
>>> +++ b/net/mptcp/bpf.c
>>> @@ -14,7 +14,7 @@
>>>
>>>  struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
>>>  {
>>> -     if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
>>> +     if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk))
>>>               return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
>>
>> Could this cause a regression by dereferencing a NULL pointer when accessed
>> concurrently?
>>
>> In subflow_ulp_fallback(), icsk->icsk_ulp_data is set to NULL prior to
>> clearing tcp_sk(sk)->is_mptcp. If a BPF program triggers in this window,
>> sk_is_mptcp() would return true but mptcp_subflow_ctx(sk) would return NULL,
>> leading to a NULL pointer dereference.

This would need to be confirmed, but from what I see, that's not a new
bug introduced by the patch here.

>> Additionally, could ctx->conn be NULL when read here?
>>
>> During subflow_ulp_init(), the context is allocated and is_mptcp is set to 1,
>> but ctx->conn is initially NULL. Passing NULL to mptcp_sk(ctx->conn) triggers
>> a kernel panic on CONFIG_DEBUG_NET builds. On non-debug builds, it returns a
>> non-NULL offset pointer, which bypasses BPF verifier NULL checks and causes
>> invalid memory accesses.

Same here: not a new bug.

>> Could this introduce a regression with a use-after-free of the mptcp_sock
>> during teardown?
>>
>> During subflow_ulp_release(), sock_put(ctx->conn) drops the reference to the
>> parent mptcp_sock and may free it. However, ctx->conn is not cleared, and the
>> subflow context remains valid until the RCU grace period ends.
>>
>> If a BPF tracing program triggers after sock_put(), could this retrieve
>> and return the dangling ctx->conn pointer, enabling the BPF program to read
>> from freed kernel slab memory?
Same here: not a new bug.

Sashiko is good at finding potential existing bugs that predate a patch,
which is good, but someone has to fix them :)

Because the issues raised here are not new, I suggest not blocking this
patch. I will check if someone can look at it quickly.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

