Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4692376E6
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658254; cv=none; b=uKKqvOhbOMIRpXXHoIc/T7m033krdcrexv2aSGGvRYKONz9YZRjJlajL4AixjZHqKTjzXJuI59qjgBkSxfsTcvjDOz6QaW+g7BDD2RuOzBGz+QYnhNHiQ5+ZsjZZbndyHe/eno0rpUjK0yPVdTCcoYZ52dlqF20ipjtJC8qMvnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658254; c=relaxed/simple;
	bh=YxoOXh3xyf9gfSrx5GV2jl8xzG1Yci5o9gX8siy/QTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2lMT9Pufz2yf5DNctDRHqg3feccBVNULu0UysZa/5m+aE/bawHJsT7/ONVJsZ/7g0J7jjlr/xummkykrsJTDzjlibicKQUJm6KNS7Zjy7RDA64EDLp6Nqcrm/MME0YVp3vDjcdt2nTUaRgN2g8wXjTQSqtidiZRoIVGbXo/vOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/fO8xMl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/fO8xMl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E380BC4CEE7;
	Thu, 27 Feb 2025 12:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740658253;
	bh=YxoOXh3xyf9gfSrx5GV2jl8xzG1Yci5o9gX8siy/QTA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A/fO8xMl5+kdyXu3cBCkcO8ZUI6FMt9i0A+XWV4Ae+1ygmn1yTDGhz1SLL6GWy3/O
	 xY+w6WCYP/iCPxhlp/h9ICLy4GuYtPpQtjlnYOcH7QrXrUoBAQHd6Ey+t6qeYb/jBB
	 uNkRsKhKZtNCYG/NXlFi3BoAO+n4Qgmk6FyeYpnUM7tvFj5jbfmxvwomfqg+5LIfV/
	 rEyh3suRzYrDWsK8qvmke79MvSIYl/fukwIJ3F5PBQqKZk1dCmyoayG6X+jj+Wv3ML
	 DUSI0ZicSeh/a3kdrZ2/tpPLia9+1tit0JgDrWv8XR0V1K1WcBY2JuVussIdNaGJmL
	 RtOBVU6YqUt/A==
Message-ID: <ddb71ab4-145f-429c-9cc0-aba2e8c04c91@kernel.org>
Date: Thu, 27 Feb 2025 13:10:50 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v1 4/6] mptcp: pm: in-kernel: drop is_userspace
 in remove_id_zero
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1740638334.git.tanggeliang@kylinos.cn>
 <d9e2fc66a1207673f07510b7b34f08edd9828220.1740638334.git.tanggeliang@kylinos.cn>
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
In-Reply-To: <d9e2fc66a1207673f07510b7b34f08edd9828220.1740638334.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 27/02/2025 07:43, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> There're duplicate operations in mptcp_nl_remove_subflow_and_signal_addr()
> and mptcp_nl_remove_id_zero_address(), both of which traverse all mptcp
> sockets in the net namespace. This patch drops the traversal operation in
> the latter and reuse the traversal loop of the former to do the removal of
> id zero address.

I'm hesitating here. It "feels" wrong to deal with an endpoint having 0
for the ID in the in-kernel manager code. Currently, the code is
separated from the beginning, and even if there is bit of duplication,
it looks clearer to deal with this special case.

(Also, I don't really see a use-case to delete only the first subflows
of all connections, but that's a different topic).

> An additional benefit is that the check for mptcp_pm_is_userspace() in
> mptcp_nl_remove_id_zero_address() is dropped, which reduces the path
> manager's reliance on mptcp_pm_is_userspace() and mptcp_pm_is_kernel()
> helpers.

I think these checks here make sense: we are iterating over all
connections, but we just need the ones handled by the in-kernel PM.

When the pm->ops will be there, can you not simply replace all these
checks under a mptcp_token_iter_next() by something like:

  if (&msk->pm.ops != &mptcp_pm_netlink)
      continue;

or:

  if (mptcp_pm_ops(msk) != mptcp_pm_netlink)

or with a macro for the iterator:

  mptcp_pm_for_each_msk(net, &s_slot, &s_num, &mptcp_pm_netlink) {

WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

