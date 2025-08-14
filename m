Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3211F473A
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183130; cv=none; b=NTljZuSMffUAkz0ZN3+pzhWirUY82yIeUZKgML8GVc/KvWSM2jpZBypiWDvbs3g8xLzZ84PpAY94/YIRylGjQH6B5qOeJnilhjt7J6+L0uiE8W7AOgOz8lMzm43XTH3bpXo3SUEucFrZmcRHAVdxnXV+dp/MR1NA4SXNZUQNEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183130; c=relaxed/simple;
	bh=/95gaSnGER94Z6J9GU8lcHW1j4v9HLpNNIbCN0yYQ50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uAIuKiauofNXopfju6T5O3aU3C8OkWoWSUCfFW26B+tzSdinifgBRrm2nkHwLTCYx7zXJt9H9sA2h/LvUXNf7U7pR9qRiXNBEvspjuHRLvvd4+ypfP1jyNnucA8ilONgpemzVC7vA+C+MmeitXUzOaSpD4xF0/75Lz23atLeFio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNYCaYox; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNYCaYox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C3CC4CEED;
	Thu, 14 Aug 2025 14:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755183130;
	bh=/95gaSnGER94Z6J9GU8lcHW1j4v9HLpNNIbCN0yYQ50=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rNYCaYoxlaaXqV8d4Zczfolae8CCVL5MC4SXp9Vq6LskX9c2j/BXl6P3Wf04x5KFG
	 Usg2Nrd4iVOTldozw9+LEQbJ4CtWEQ/kSsqoSIRoBTGgmkAB9Ds9XaOXhDXtQKRaAF
	 A02CiBy/DWt6JHg0KUVfklAzAY1liRGsDWMrz3w7pybWC9nr9/BD2j4tggc+xiDVU7
	 GDjwBQCum1J7bFOSKPBjOjZwLc5Mnu5ViGbQR8CTisWDc7QnROdB/PoEIs5Isun5R/
	 mLS4Oo8aO/ZrLvKPNR4NXGhy5/WKaj+3JhEyKyDFty5qJDtjUDnpBws0l99zqnRDYD
	 oS814bof7sJwg==
Message-ID: <e071000a-5ca7-45c3-b347-c0896c4f6ff5@kernel.org>
Date: Thu, 14 Aug 2025 16:52:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: drop skb if MPTCP skb extension
 allocation fails
Content-Language: en-GB, fr-BE
To: Christoph Paasch <cpaasch@openai.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Geliang Tang
 <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>
References: <20250807-mptcp_fixes-v1-1-adfd79a88b5e@openai.com>
 <cc200e35-8509-43d2-b3ff-49c959dbc557@kernel.org>
 <CADg4-L81YEkKZpsVyy4sEX5_eKXUxqT4rEjgi5CfSKZ=HDk-0A@mail.gmail.com>
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
In-Reply-To: <CADg4-L81YEkKZpsVyy4sEX5_eKXUxqT4rEjgi5CfSKZ=HDk-0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Christoph,

On 14/08/2025 16:48, Christoph Paasch wrote:
> 
> 
> On Thu, Aug 14, 2025 at 3:36 AM Matthieu Baerts <matttbe@kernel.org
> <mailto:matttbe@kernel.org>> wrote:
> 
>     Hi Christoph,
> 
>     On 07/08/2025 20:00, Christoph Paasch via B4 Relay wrote:
>     > From: Christoph Paasch <cpaasch@openai.com
>     <mailto:cpaasch@openai.com>>
>     >
>     > When skb_ext_add(skb, SKB_EXT_MPTCP) fails in
>     mptcp_incoming_options(),
>     > we used to return true, letting the segment proceed through the TCP
>     > receive path without a DSS mapping. Such segments can leave
>     inconsistent
>     > mapping state and trigger a mid-stream fallback to TCP, which in
>     testing
>     > collapsed (by artificially forcing failures in skb_ext_add) throughput
>     > to zero.
>     >
>     > Return false instead so the TCP input path drops the skb (see
>     > tcp_data_queue() and step-7 processing). This is the safer choice
>     > under memory pressure: it preserves MPTCP correctness and provides
>     > backpressure to the sender.
>     >
>     > Control packets remain unaffected: ACK updates and DATA_FIN handling
>     > happen before attempting the extension allocation, and tcp_reset()
>     > continues to ignore the return value.
>     >
>     > With this change, MPTCP continues to work at high throughput if we
>     > artificially inject failures into skb_ext_add.
> 
>     Good catch!
> 
>     Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org
>     <mailto:matttbe@kernel.org>>
> 
>     BTW, how did you detect this error?
> 
> 
> Mostly code-reading. But, I was testing my locking re-architecture and
> was seeing fallbacks to infinite and thus was deep-diving into the code.
> 
> So, I saw this and tried it out.

Nice! Then I think it might be too hard to add yourself in the automated
tests executed by the CI :-/

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

