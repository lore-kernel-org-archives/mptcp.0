Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4F21917F4
	for <mptcp@lists.linux.dev>; Sun, 15 Jun 2025 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750022991; cv=none; b=tRXtYGSYCDUjwqKmb0Q+X0xCa08No4Y/s7iKlh+BuklJn6n7RyE3lNilfJmQBOOxeMc0aPYS6ninZFs7qh/KD3rk1l6HxKsvpzyO1CCc0YWp1yhPcezFz+05H5fCV25H0FyGaQcD2JHdiVrUjvx8yzMxzOFuVyC8biOlNwZM8q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750022991; c=relaxed/simple;
	bh=NBk2SggHtqUnItBtE5c4/+AJ67vh/JJ50i+ZV+Iv+A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvMu3FhRPkjn24Ac5B2uOWE44xTeT230xFTJZozis9e3AzFB9dtZ6ZiFLWe/m+QdEWjB0SLVNv51g8uuwltLidp/ZZVaw7lEm7DdlXd8HLST63trhW75MdJD3AmI/MXOjPuMH6qWH/Pj/ga7TT+1Jy+MuhZxuhCOTMqy5088ZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nelwp51+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nelwp51+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C385AC4CEE3;
	Sun, 15 Jun 2025 21:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750022990;
	bh=NBk2SggHtqUnItBtE5c4/+AJ67vh/JJ50i+ZV+Iv+A0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nelwp51+YOhN8keTCUnj+H+Oc0jNX2W4VF9vZ5yaSsGgtP4gVzifIqc0VqTzrG0es
	 PyvYQRpOpC4KboSyUgSYzUnTL4/10lbWLkcXJLFVYUiee1GRRDZzX+sl3xWkzUIc83
	 tC6Vs2BbnbTFLmRckmfjaSpyRdneHCF2HS9Z4Sa+YtN8R2ROiGCoP5xvUVuS6WkFWo
	 Ykt6/tkiwc6Lit0oMoUbgGt9QVzVWV4XGgr2FYGyAqsqmY0Dz3ruPHy5bcbo+xUUWv
	 zZC4szR6GMlWHfG52Cadb+BteXZX4nhw2hgLC9YTXcmzDPZTRtGFYrM17cFN3Fvhb0
	 4s9wi+LQvKJLQ==
Message-ID: <23fd5569-f383-441e-9be4-48a8430954d9@kernel.org>
Date: Sun, 15 Jun 2025 23:29:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 0/3] send() fails with EAGAIN in blocking IO
 mode #487
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1748484770.git.tanggeliang@kylinos.cn>
 <a5c20f9f-3038-ed11-b78c-522ef40f9031@kernel.org>
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
In-Reply-To: <a5c20f9f-3038-ed11-b78c-522ef40f9031@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat, Geliang,

On 14/06/2025 01:11, Mat Martineau wrote:
> On Thu, 29 May 2025, Geliang Tang wrote:
> 
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> Good news! I finally solved the unstable issue of MPTCP BPF sched
>> selftests
>> I reported a year ago, #487 "send() fails with EAGAIN in blocking IO
>> mode".
>>
>> The fix is simple, it can be solved by explicitly setting SO_SNDBUF
>> sockopt, but be sure not to set SO_RCVBUF at the same time
>> (see sk->sk_userlocks & SOCK_RCVBUF_LOCK in mptcp_rcv_space_adjust()).
>>
>> With this fix, BPF sched selftests are now very stable, I run loop
>> testing
>> using mptcp-upstream-virtme-docker (run_loop run_bpftest_all), and can
>> run
>> it normally for hundreds of times without error:
>>
> 
> Hi Geliang -
> 
> I can see how changing SO_SNDBUF on the sending socket side would shift
> timing behavior in a way that affect the test outcome, but it doesn't
> address the root issue with bug #487:
> 
> It is either OK to get an EAGAIN from a blocking send(), or it's not OK.
> 
> 
> If it's not ok to ever return EAGAIN from a blocking send, the existing
> test code is a reproducer for a bug, and changing the test is hiding
> that bug.
> 
> If EAGAIN is ok, then we should change the code in send_recv_server() to
> allow it.

It is now a bit hidden in the middle of #487, but if I'm not mistaken,
it is OK to get EAGAIN with a blocking send() **if** SO_SNDTIMEO is
used, and in case of timeout.

See:
https://github.com/multipath-tcp/mptcp_net-next/issues/487#issuecomment-2485577676

So I think the question should be: is it normal to block for longer than
the timeout period (which is a "long" period, no?)? If yes, then
limiting the send buffer might be a solution, but as Mat said, it looks
better to understand the root cause than hiding a bug :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

