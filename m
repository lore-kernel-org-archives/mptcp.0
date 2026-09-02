Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEF84AC15D;
	Wed,  2 Sep 2026 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366752; cv=none; b=U6Zt1RKLkVNvITP6R9WbCh+jc5quQU+D62anR5zUg4D/83GssqHdq7I6TMhIgsiYhVXdiKKonw48IqdbGRIzTOgvVOdzFfnYiAMaTA4Kn/J9XVfQE3Y6v6VN8j5lLopBgBsnthr7zJUwTo8LJXxyrpDOyq2N7Mgkr/neJ889v0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366752; c=relaxed/simple;
	bh=76lrQqGxA+nAdCyTWcKBRUC0QSPzQSf+hQ/92DkbDHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrUXZPHF4TWjzllLi+OOMkKHdDNqR0RnoF20yBL2NTVC2+YEphbFMUwkboYlIf/tGPKwJen1JoCS360o5ec6yZHNQurp+JKWHXEawLz2TALAQoxkTbgab9VZ1leguLj0o9rrHf/1PCp8UscY1tuvhvTRll1N4FDPfItf8u9yCGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9eyANFM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9eyANFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739D71F00A3A;
	Wed,  2 Sep 2026 16:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788366751;
	bh=VcPQLz3YKdeK7G5UGjOBzeSMJfD2Cfb+ojpsx5soPDo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Z9eyANFMVSu0LBIVTOWaxs6pE/VZyFpxf/hGe/b9wsx0ajLwxvVTazYx3yihENmYL
	 MhUA82iiohqa7PY3reR+Ih7lvy7BIYV/0sbQB5VaYzlHIaBZoAJUgEBk2n0Crx6iDs
	 6qyWL1FdzswwX7zl2zAxEq9LLbZmxv4KMpznrN/X1ShHNLNmmzfKsF9bolcj0Z1tdy
	 pblwuL5HrWgL2R/tBjTcyfArEIecwRtSiK4jCzN3Y2y2Wc6SkcBjZItyfcwXVY5Cpi
	 b9xTpS3qJuDRfzq39moL0QV53rYNjPkOQ5gKiN+kQp4/Yh6EIpz91aGNwWNDqYHgro
	 u2I0pYj3w4lLQ==
Message-ID: <f6c30ebb-5c79-4998-bcf5-3b4d95aa0ab8@kernel.org>
Date: Wed, 2 Sep 2026 18:32:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/2] mptcp: pm: skip extra_subflows accounting
 on disconnected msk
Content-Language: fr
To: Tao Cui <cui.tao@linux.dev>, sashiko-reviews@lists.linux.dev
Cc: mptcp@lists.linux.dev
References: <20260831093206.689827-1-cui.tao@linux.dev>
 <20260831093206.689827-3-cui.tao@linux.dev>
 <20260831101129.203081F000E9@smtp.kernel.org>
 <739848e0-1d35-4ed7-afd7-4b0609ddb8d0@linux.dev>
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
In-Reply-To: <739848e0-1d35-4ed7-afd7-4b0609ddb8d0@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Tao,

On 31/08/2026 15:00, Tao Cui wrote:
> Hi,
> 
> Thanks for the review. 
> 
> 在 2026/8/31 18:11, sashiko-bot@kernel.org 写道:
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>
>> Pre-existing issues:
>> - [High] Subflows in `join_list` can be leaked due to unsynchronized zeroing of `cb_flags` in `mptcp_disconnect`.
>> - [High] Data race on `pm->reset` and `pm->rm_list_*` fields due to missing `pm->lock` in `mptcp_pm_data_reset()`.
> 
> Both findings are pre-existing issues rather
> than regressions from this series, but I had a look at them:
> 
> For the join_list leak, I agree it is real. When an MP_JOIN is
> processed while the parent socket is being disconnected, the subflow
> is queued in msk->join_list and MPTCP_FLUSH_JOIN_LIST is set under
> the data lock, but mptcp_disconnect() then clears msk->cb_flags with
> a plain write. The flag is lost, mptcp_release_cb() never flushes
> the list, and since mptcp_destroy_common() only iterates conn_list,
> those subflow sockets are leaked. The plain write also drops flags
> that were already pending before the disconnect, so taking the data
> lock around it is not enough. What I have in mind is to keep the
> flush-related bits across the disconnect and let release_sock()
> process the join list as originally intended, or to drain it
> explicitly in the disconnect path, checking the lock nesting
> commented in mptcp_destroy_common().
> 
> For the pm->reset data race, the lasting effect is the counter
> imbalance this series now clamps and traces, and the other fields
> are discarded on a closed socket anyway. The direct fix is to take
> pm->lock around the reset in mptcp_pm_data_reset(), after checking
> the lock ordering on all callers.
> 
> These are two separate bugs with separate Fixes: targets, so I plan
> to submit them as their own series rather than folding them into
> this one.
Thank you! Yes a different series is better.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

