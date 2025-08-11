Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC592459EA
	for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923865; cv=none; b=MsFGFz0wHtsHh9Pi4Rx+4fbcVQ0Sfd1ZN+qldZAdAs+cxUVopmtKF6uPO3XQCmwSH8WhuJezJPW86IAbaSTDvunIMA6gG/8fcxwr4tfyVUlGwR9ycGMsCgiNfbdKxaDbGb5IKDSSttBk8/0qOG/OmhETFq36cgA3TzAs53P/YXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923865; c=relaxed/simple;
	bh=b34WxAJEchLqpEB++mqxJ9gtpTtVJ++knlUZCP0J8QY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSJHHE2MFXVYqTcIXMJn1JMNmdev+DW37TU+NYyB/iiLQhCMkPcKzQ8THx+d6+bzWveMsvV8AipNiAcjJ0YmnsOOttPuC0FtlsXbm9otr5jd4OK5Jp04EAW9wIshIMYEa2D4CVq4xXcaIKjywXalcqnVG+5idCr/56MVXClUXO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Igy7Ik1C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Igy7Ik1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6302EC4CEED;
	Mon, 11 Aug 2025 14:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754923865;
	bh=b34WxAJEchLqpEB++mqxJ9gtpTtVJ++knlUZCP0J8QY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Igy7Ik1CpQ+k6v7mLd0Bm89D3UoTz1jWXC/TqBV88Z0qC6FuMyKMF8TB1XSlLw8Jd
	 cSTqbPisTiNIx/sk7EJkHvv3ns3TX7jpYOaijUagHDVhqm6BinIRFr6ncW3RPY+ksJ
	 LgrO8tgrOaFqd7oo647qFaFDDqFthGjQKmT6NlGU82qgED0WxWJOBQWtumgcUkvR63
	 rTlAqPjmG9V4UMDFUKiG9FngShTWxYD2wEV7MbjwMQkoN0IZKjDGCMzaacXDTFdg3t
	 W/mTRn+VeY+v3IGInPsdriUufBfB3PCdPIuFzMULl14dOyDWnn2oMRX+oGPMPdVsTN
	 UOUutyp+eyRew==
Message-ID: <5d4dfa60-7604-4b45-becf-8df8bd0667ed@kernel.org>
Date: Mon, 11 Aug 2025 16:51:02 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 2/3] mptcp: make ADD_ADDR retransmission
 timeout adaptive
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
 Christoph Paasch <cpaasch@openai.com>
References: <cover.1754449947.git.tanggeliang@kylinos.cn>
 <c559f29eea1e019b6d25a35f05bbeb85fdd578e1.1754449947.git.tanggeliang@kylinos.cn>
 <eb6c0e4d-938c-4712-83b2-ee12bd70aa12@kernel.org>
 <f42defcb7fe7db02283fed5def29623cbc6a24d7.camel@kernel.org>
 <b0a4ebe8-0dfd-4c15-89bf-98c4f7cfebc0@kernel.org>
 <78799855faff1bb19cdec5210ca5edf302d39974.camel@kernel.org>
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
In-Reply-To: <78799855faff1bb19cdec5210ca5edf302d39974.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 10/08/2025 03:13, Geliang Tang wrote:
> Hi Matt,
> 
> On Thu, 2025-08-07 at 13:56 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 07/08/2025 05:25, Geliang Tang wrote:
>>> Hi Matt,
>>>
>>> On Wed, 2025-08-06 at 17:34 +0200, Matthieu Baerts wrote:
>>>> Hi Geliang,
>>>>
>>>> On 06/08/2025 05:17, Geliang Tang wrote:
>>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>>
>>>>> Replace the fixed ADD_ADDR retransmission timeout with an
>>>>> adaptive
>>>>> mechanism that uses the maximum RTO among existing subflows.
>>>>> This
>>>>> improves responsiveness when establishing new subflows while
>>>>> maintaining
>>>>> an upper bound through the configured add_addr_timeout value.
>>>>>
>>>>> Key changes:
>>>>> 1. Compute timeout as min(max_subflow_RTO,
>>>>> configured_max_timeout)
>>>>> 2. Apply exponential backoff based on retransmission count
>>>>> 3. Maintain fallback to configured max timeout when no subflows
>>>>> exist
>>>>> 4. Update documentation to clarify add_addr_timeout is now the
>>>>> maximum
>>>>> value
>>>>>
>>>>> Closes:
>>>>> https://github.com/multipath-tcp/mptcp_net-next/issues/576
>>>>> Reviewed-by: Christoph Paasch <cpaasch@openai.com>
>>>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>>>> ---
>>>>>  Documentation/networking/mptcp-sysctl.rst |  4 +--
>>>>>  net/mptcp/pm.c                            | 30
>>>>> ++++++++++++++++++++---
>>>>>  2 files changed, 29 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/networking/mptcp-sysctl.rst
>>>>> b/Documentation/networking/mptcp-sysctl.rst
>>>>> index 1683c139821e..2b8e8fb99ee2 100644
>>>>> --- a/Documentation/networking/mptcp-sysctl.rst
>>>>> +++ b/Documentation/networking/mptcp-sysctl.rst
>>>>> @@ -8,8 +8,8 @@ MPTCP Sysfs variables
>>>>>  ===============================
>>>>>  
>>>>>  add_addr_timeout - INTEGER (seconds)
>>>>> -	Set the timeout after which an ADD_ADDR control
>>>>> message
>>>>> will be
>>>>> -	resent to an MPTCP peer that has not acknowledged a
>>>>> previous
>>>>> +	Set the maximum value of timeout after which an
>>>>> ADD_ADDR
>>>>> control message
>>>>> +	will be resent to an MPTCP peer that has not
>>>>> acknowledged
>>>>> a previous
>>>>>  	ADD_ADDR message.
>>>>>  
>>>>>  	Do not retransmit if set to 0.
>>>>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>>>>> index 1330af6a2154..34cc4f45bc7d 100644
>>>>> --- a/net/mptcp/pm.c
>>>>> +++ b/net/mptcp/pm.c
>>>>> @@ -268,6 +268,30 @@ int mptcp_pm_mp_prio_send_ack(struct
>>>>> mptcp_sock *msk,
>>>>>  	return -EINVAL;
>>>>>  }
>>>>>  
>>>>> +static unsigned int mptcp_adjust_add_addr_timeout(struct
>>>>> mptcp_sock *msk)
>>>>> +{
>>>>> +	struct mptcp_subflow_context *subflow;
>>>>> +	struct sock *sk = (struct sock *)msk;
>>>>> +	unsigned int max_rto = 0;
>>>>> +	unsigned int timeout;
>>>>> +
>>>>> +	timeout = mptcp_get_add_addr_timeout(sock_net(sk));
>>>>> +
>>>>> +	mptcp_for_each_subflow(msk, subflow) {
>>>>> +		struct sock *ssk =
>>>>> mptcp_subflow_tcp_sock(subflow);
>>>>> +		unsigned int subflow_rto;
>>>>> +
>>>>> +		subflow_rto = __tcp_set_rto(tcp_sk(ssk)) * 2;
>>>>
>>>> Why "* 2"? Is it what TCP is doing?
>>>>
>>>> (Probably best to add a comment here above, and in the commit
>>>> message.)
>>>>
>>>> (Also, I guess the compiler will do the optimisation, but you
>>>> could
>>>> write: ">> 1" instead of "* 2".
>>>
>>> Yes, "<< 1" is much better. I added a comment here:
>>>
>>> +               /*
>>> +                * icsk->icsk_rto is not used directly since
>>> +                * it's not updated frequently enough.
>>> +                *
>>> +                * subflow_rto is twice of rto, and allow
>>> +                * some tolerance for add_addr echo.
>>> +                */
>>> +               subflow_rto = __tcp_set_rto(tcp_sk(ssk)) << 1;
>>>
>>> Is this okay?
>>
>> No :)
>>
>> I don't think the comment explain why it is twice the default TCP
>> RTO.
>> Why having an exception here for the ADD_ADDR? I mean: I'm OK with
>> the
>> idea of doubling the RTO, but only if there is a reason behind that
>> :)
> 
> How about this one (answered by DeepSeek, an AI from China):
> 
>         /*   
>          * icsk->icsk_rto is not used directly since it's not
>          * updated frequently enough.

What about: (...) since it might not have been updated recently.

>          * Setting subflow_rto to twice of RTO provides a safety
>          * buffer for RTT estimation variance, kernel RTO update
>          * delays, and a full transmission retry cycle while
>          * minimizing false failures.

A bit long and not clear (typical AI, making commit messages too
verbose, it almost force me to use one to give me the summary :) )

What about:

  Setting this RTO to twice of TCP one, not to be too agressive for this
  notification that might take longer to process than "simple" data.

Still, is icsk_rto not already "long" enough by default? I mean: when I
see your description in the related packetdrill PR [1] where the delay
is supposed to be 0.01 sec, but "subflow_rto" (or was it isck_rto?) is
0.65 sec, that's quite different, and half of it would be more than
enough :)

But maybe that's different when it happens later during the connection?

[1] https://github.com/multipath-tcp/packetdrill/pull/166

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

