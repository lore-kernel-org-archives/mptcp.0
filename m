Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7F912FF88
	for <mptcp@lists.linux.dev>; Wed,  6 Mar 2024 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738911; cv=none; b=XhPE6IiaAoFjTU/1AduQCVpReIc5/cQEbZVeQI2lrN99kKQsgdpkrSm/26CxumtA3W+cdmBVMyz0AmFUh32CrTXe1aBxIwS6gbfXhRyCYrjWwyaJ1Wo1AxV5GHqM1kUKBpqryOyuX/rrEGYSriRk31No+GlfA+yNxMEN0+WyLZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738911; c=relaxed/simple;
	bh=k4Gb92FV7/9GDwNfV44aLyxueJpwEOVREjs4dK9j8Cc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ch+IN4jehrGrAuySJQjYk4Z5Rbhw+BpjtrQB9LfFUpLyYkopVsPjXQj56ftM06zke6+rKmY20sH9abAayk5RPX4xzEwckmxM2VdiaY3IaKUQSnTNL87U1Huz9WnnFBwyV9U+o87nosv5b0PONe8nU/BMXCSr67xc+RI6C1yyM5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aToU/V79; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aToU/V79"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DE9C433C7;
	Wed,  6 Mar 2024 15:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709738911;
	bh=k4Gb92FV7/9GDwNfV44aLyxueJpwEOVREjs4dK9j8Cc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=aToU/V79fPgYXRwCoqMEQ/mZgVfuP9KagNlYIJ13KbV1jCLc6yoxYV99r1qDR+Qbq
	 1omtubNqCiRRbjdU0Sy5DRC3vc40X7lwYgOyypKERHDfp7C9YxsLFikaSipiv5BWhc
	 cIrIfIaa8eRW1mb4GbZtB7qyG8c1Lfia1KkMlYlNggSOELQdkP0OB+pQIHc+exegRF
	 rTbV8j/Fpc25iWWOcNkbGiWb4zKCvcud4AcdOzBfEc62f0foKkPzOMZMJkpENlfheH
	 air7wE9vUacFRpBclegRActn5eCKIr21SRKfJ/+BvBsggoC+UHVFI9tlFUZFfiQyvs
	 qTdIj5naPZpjg==
Message-ID: <55dbc24f-c3ad-4761-a785-5f6c4b0ebd5c@kernel.org>
Date: Wed, 6 Mar 2024 16:28:28 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v13 0/9] add helpers and vars in mptcp_lib.sh,
 part 3
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1709688778.git.tanggeliang@kylinos.cn>
 <46b9be01-3fce-49a2-b9f9-e936405712c1@kernel.org>
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
In-Reply-To: <46b9be01-3fce-49a2-b9f9-e936405712c1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 06/03/2024 13:01, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 06/03/2024 02:40, Geliang Tang wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> v13:
>>  - fix the shellcheck error reported by CI in patch 8
>>  - rebased
>>
>> v12:
>>  - patch 1 Drop one more 1>&2, and update commit log
>>  - patch 2 use port_base=10000 instead of PORT=0
>>  - patch 4 fix the TAP output
>>  - patch 8 a new patch
>>  - patch 9 drop _printf in userspace_pm.sh
> 
> Thank you for the new version and the changelog. This v13 looks good to me.
> 
> Before applying the series, I have 3 suggestions (see my comments on
> patches 2, 3, 9), and one important question (from v11):
> 
> Did you check the output when you force failure (e.g. by modifying the
> code to force and issue, e.g. changing counters, set ret values, etc.)?
> Just to make sure they are still presented correctly, and if we still
> catch them!

I just applied the patches in our tree (with the modifications I
suggested), so we can discuss them at the meeting today to check if we
send them before the end of the merge window.

Please tell me if the modifications I did were OK or not, and more
importantly, if you checked we are still catching and printing errors
correctly.

New patches for t/upstream:
- 1078cbfbcaca: selftests: mptcp: print all error messages to stdout
- 41d8173fc08e: selftests: mptcp: connect: add dedicated port counter
- 2f5133832972: selftests: mptcp: connect: fix misaligned output
- 675afbc67f16: selftests: mptcp: sockopt: print every test result
- ea343f146c45: selftests: mptcp: export TEST_COUNTER variable
- 7f8d83dedeec: selftests: mptcp: add print_title in mptcp_lib
- a7107253146f: selftests: mptcp: print test results with counters
- 4d5fa38b0feb: selftests: mptcp: connect: use += operator to append strings
- eb2df7f20113: selftests: mptcp: print test results with colors
- Results: 22573260e303..f5104afeca7c (export)

My modifications:
- 24a6ed34b014: Squash to "selftests: mptcp: connect: add dedicated port
counter"
- d1395cdf78c9: tg:msg: 'prot_base' (typo) -> 'port'
- 29f333cf764b: conflict in t/selftests-mptcp-export-TEST_COUNTER-variable
- a7d331066c9a: conflict in
t/selftests-mptcp-print-test-results-with-counters
- f6a25c3bc6f2: Squash to "selftests: mptcp: print test results with
counters"
- 8664917a10d3: Squash to "selftests: mptcp: print test results with colors"
- Results: f5104afeca7c..03439b759bbc (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20240306T152450

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
