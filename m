Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D153F32F775
	for <mptcp@lists.linux.dev>; Wed,  3 Sep 2025 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896563; cv=none; b=kSbRjcekvOshAuTkG84bH0zv7Evc5AHPI049Xv9+UBjRbRIPNftsPpxLPOSM58+iCmj/GkGGePKFIjUbhi5Oi4fi5SEU2mwKSZhtpOg1s5U7+LPlszh+q88bsanaKhIv3bY/z0PWX2NM8LMbtGbvLPzXMAAUCYw/BoYbPaFeFMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896563; c=relaxed/simple;
	bh=e8Ihvjc9MaqyOudc40bYIM4+n2fMWFBA5nUtxbnhMtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a1mbVMlsjJthre7lsmU1OpqQZLrjuPottAg/t+rcxa2SJn7Ro033whvAZDlhxGyHvdxyRNrCIiBtzTe1dxqFeXn1dXDg3l8Jubul3lRuCfKJ1wkqO+QbMpGrC/5aGd3N4KCSS9YvBUAWevIPbshDu7xrXtGVD5rx4t8t3NdBt80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1uFOlVE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1uFOlVE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C28C4CEF0;
	Wed,  3 Sep 2025 10:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756896563;
	bh=e8Ihvjc9MaqyOudc40bYIM4+n2fMWFBA5nUtxbnhMtw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=q1uFOlVESh+yD/daXm5ydJz5BAQk1aTkIwlR9sZDiyA+INuyx9QnwoYKg24i9FHg0
	 l/Yp7MZT8MluPtIyQBSGG+1lzF12xHHcgq0TctU+JLf9wg4fs7ym6IjVKVSUlQa22C
	 +Xpac+3iX0vSV5ymm0vz7m91JsSmOS04Clo62TkLV4gAYjj1PO92z8lzwOMOlXiew4
	 Uv7rVKdeCVjCLnyhtrJHTJ5zOXwaSIVH+oMuapYoUreM0rTBLi3yXsit8oALrMf3XJ
	 4Z/4hKDFgfnN4j3ZM6vK3SLykD68zAUHuBYLrw4ZI5u7DZrk6k1dCyasClvza9kjnF
	 fy220WioePiug==
Message-ID: <cd0b8546-902e-4d68-bcbe-01b31e370034@kernel.org>
Date: Wed, 3 Sep 2025 12:49:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 0/3] Add MPTCP support to Java Networking
 API
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <cover.1756369940.git.tanggeliang@kylinos.cn>
 <3a401acb-bcc6-4885-a1a4-7aa88ed55cb5@kernel.org>
 <2dc597d59d3aff65b2955f5accf0a14e2c788cf5.camel@kernel.org>
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
In-Reply-To: <2dc597d59d3aff65b2955f5accf0a14e2c788cf5.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 03/09/2025 08:16, Geliang Tang wrote:
> Hi Matt,
> 
> On Thu, 2025-08-28 at 11:57 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 28/08/2025 10:47, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> v2:
>>>  - drop redundant helpers as Matt suggested.
>>>  - squash into fewer patches.
>>>  - use "JNI_TRUE" and "(void)mptcp" in Java_sun_nio_ch_Net_socket0
>>> as
>>>    Xiang Gao suggested.
>>>
>>> The Multipath TCP (MPTCP) protocol (v1 / RFC 8684) has been added
>>> in
>>> the upstream Linux kernel since v5.6. See https://mptcp.dev.
>>>
>>> This patch series introduces comprehensive Multipath TCP (MPTCP)
>>> support to the Java Networking API, enabling applications to
>>> leverage
>>> MPTCP's capabilities for improved reliability and throughput.
>>
>> Thank you for the new version! Feel free to start the process to
>> upstream these patches [1]. Don't hesitate to share here the link to
>> the
>> new ticket.
>>
>> [1] https://openjdk.org/guide/#i-have-a-patch-what-do-i-do
>>
> 
> I followed the instructions and "Signed the OCA" on August 1st, but it
> is still in the "Under Review" status.

Thank you for having started this! This is a shame it takes time, that's
not helping to get new contributors.
> For the second step, "Socialize your change", I would like to send the
> following letter to net-dev@openjdk.org:

Good idea, thank you for sharing this.

> '''
> Hi OpenJDK maintainers,
> 
> I hope this message finds you well. The purpose of this letter is to
> propose the integration of Multipath TCP (MPTCP) support into OpenJDK.
> We have developed a set of patches to enable this functionality and are
> eager to submit it for upstream inclusion. We would greatly appreciate
> your feedback and opinions on this contribution.
> 
> 1. Introduction
> 
> Multipath TCP (MPTCP), as standardized in RFC 8684, is a major
> evolution of the TCP protocol. It enables a transport connection to use
> multiple network paths simultaneously for redundancy, resilience, and
> bandwidth aggregation. Since its introduction in Linux kernel v5.6, it
> has become a key technology for modern networking, particularly on
> mobile devices with multiple interfaces (e.g., Wi-Fi and cellular).
> 
> Key benefits include:
> 
>     Bandwidth Aggregation: Combine the bandwidth of multiple network
> links.
> 
>     Seamless Handover: Maintain connections when switching networks
> without dropping the session.
> 
>     Improved Resilience: Traffic is automatically rerouted if one path
> fails.
> 
> For more details, see the project website: https://mptcp.dev.
> 
> 2. Technical Background
> 
> On a supporting system like Linux, an MPTCP socket is created by
> specifying the IPPROTO_MPTCP protocol in the socket() system call:

Maybe add something like: "instead of IPPROTO_TCP (or 0)"
> 
>     int fd = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
> 
> This creates a socket that looks like a standard TCP socket to the
> application but uses the MPTCP protocol stack underneath.

It might be interesting to add something here to say that with the Java
API, it is possible to create "stream" sockets, but it is not possible
to change the last argument, which blocks apps to ask to use MPTCP.

> 3. Proposed Java API Changes
> 
> The goal is to allow Java applications to opt-in to using MPTCP when
> creating sockets, without breaking existing code. The proposed changes
> are additive and backward-compatible.
> 
> The core idea is to add a boolean mptcp parameter through the API
> layers, from the public Socket class down to the native system call.
> 
> 4. Implementation Plan
> 
> The implementation involves changes across four layers of the JDK:
> 
> JNI Layer (sun.nio.ch.Net):
> 
> Modify Java_sun_nio_ch_Net_socket0 to accept a new jboolean mptcp
> parameter.
> 
>     The native implementation will be updated to use this parameter:
> 
>     int protocol = mptcp == JNI_TRUE ? IPPROTO_MPTCP : 0;
>     fd = socket(domain, type, protocol);
> 
> NIO Layer (sun.nio.ch):
> 
>     Add the mptcp parameter to the Net.socket() and Net.serverSocket()
> methods.
> 
>     Propagate the parameter down to the JNI call.
> 
> Socket Implementation Layer (java.net):
> 
>     Add the mptcp parameter to the constructor of NioSocketImpl.
> 
>     Within NioSocketImpl, pass the parameter to the Net.socket() or
> Net.serverSocket() calls.
> 
> Public API Layer (java.net.Socket & java.net.ServerSocket):
> 
>     Add new constructors that accept the mptcp parameter.
> 
>     Example:
> 
>         // Proposed new constructor
>         public Socket(String host, int port, boolean stream, boolean
> mptcp) throws IOException {
>             // ... implementation that passes 'mptcp' to NioSocketImpl
>         }
> 
> 5. Full Implementation
> 
> The complete working implementation for this proposal is available for
> review:
> 
> https://github.com/openjdk/jdk/compare/master...geliangtang:jdk:master
> 
> We look forward to your valuable feedback and suggestions on this
> proposal.

Maybe good to add something like: we can create a new issue for this
feature, and submit a proper pull request after if that's OK for you. We
didn't do that yet because we noticed that it is recommended to send
more explanations to this list first.

Thanks, it looks good!

> Best regards,
> The MPTCP Upstream Developers
> '''
> 
> Please review this letter for me.
> 
> Thanks,
> -Geliang
> 
>> Cheers,
>> Matt

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

