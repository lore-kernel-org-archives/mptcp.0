Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8087814E2CC
	for <mptcp@lists.linux.dev>; Tue,  7 May 2024 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715076024; cv=none; b=sptrZKp/KVfuf+APqxeT32R2JAJMDpMA1SwdNp/PXhGs/YbmlWRX5Tmg894RlXrYIBwVBCpvmVoDwMeGYkvk5UOLt6uPzSIOGFVHUa/+3ei+0ri3Q/vN+m/U9gr7aAywtxoB8n/7D7lGdEUMRlWFU47Uhcu1D6FNvP5dSC/1oYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715076024; c=relaxed/simple;
	bh=ZvcMTBsfgHX+stTQFrOmcHZhoMLFogCJxflmKSkKX7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t32SHoZuetMBkcl9eQzRaWwo2qg9xrNBOeQQdPqgSGWQbArHlPDVR9C4qhdWS57Rho0OLaPJZg7Nl2dbdBzPE8YsjhY9gKpaQjR9lWP3T+bZLlInlMVoYIvk05DgnuXuqGQmZ9Txxr7G87wLPNGzh7hWZY6+cq2S+MNlOyRIXeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVtiF/M0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVtiF/M0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB39C2BBFC;
	Tue,  7 May 2024 10:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715076024;
	bh=ZvcMTBsfgHX+stTQFrOmcHZhoMLFogCJxflmKSkKX7U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pVtiF/M0KCkXy96LyAGgNitsB5W+tSrYLLD8j/sTBE0m7KEiFN6Xp72rXHO+dXV47
	 9Q5zcjrWZswCQnh45KN8bny1dNi+4fOY1+bOp28vrGhd1Rzrak7v5Pwz/yGy9rk2MD
	 WGwvRsK1bGbSmh1QG2fpHFUUDHY0Vj2UKrDtoCb3ekLzm/VVYLWJ1ZD0O/IUDRummP
	 X9RTnnbubSL9PWdgFoamlbh50WA6RylEs3A9B7fqEsHRS9eW2BhZ2zMjwhShqwlpp7
	 URaImLnFvMptRkJraoKSzSySJXpPTpIeyiMcVBd+PiQte/OYVNnmzfAod1+opnDb8q
	 aZM34AcPRKEYw==
Message-ID: <70899a25-80ff-4456-bc85-5bba1240bc27@kernel.org>
Date: Tue, 7 May 2024 12:00:20 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2] mptcp: fix the default value of
 scaling_ratio
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>
Cc: martin.lau@kernel.org, Geliang Tang <tanggeliang@kylinos.cn>,
 Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn>
 <7f9f2b7f-9bb5-4c17-bdef-c96fe2707d27@kernel.org> <Zjn1hZVgE9QHwn8X@T480>
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
In-Reply-To: <Zjn1hZVgE9QHwn8X@T480>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 07/05/2024 11:34, Geliang Tang wrote:
> Hi Matt,
> 
> On Tue, May 07, 2024 at 10:12:41AM +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> (+cc Paolo who wrote the commit mentioned by the "Fixes" tag)
>>
>> On 07/05/2024 05:46, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> BPF tests fail sometimes with "bytes != total_bytes" errors:
>>>
>>>  test_default:PASS:sched_init:default 0 nsec
>>>  send_data:PASS:pthread_create 0 nsec
>>>  send_data:FAIL:recv 936000 != 10485760 nr_recv:-1 errno:11
>>>  default: 3041 ms
>>>  server:FAIL:send 7579500 != 10485760 nr_sent:-1 errno:11
>>>  send_data:FAIL:pthread_join thread_ret:-11 test_default:PASS: \
>>> 				has_bytes_sent addr_1 0 nsec
>>>  test_default:PASS:has_bytes_sent addr_2 0 nsec
>>>  close_netns:PASS:setns 0 nsec
>>>
>>> In this case mptcp_recvmsg() gets EAGAIN errors. This issue introduces
>>> by commit b8dc6d6ce931 ("mptcp: fix rcv buffer auto-tuning"). The default
>>> value of scaling_ratio should be TCP_DEFAULT_SCALING_RATIO, not U8_MAX.
>>
>> It looks like you are modifying the max value, not the default one.
>>
>> Also, please always explain the reason: why should it be X, not Y?
>>
>>>
>>> Fixes: b8dc6d6ce931 ("mptcp: fix rcv buffer auto-tuning")
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/487
>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>> ---
>>> v2:
>>>  - I finally found the root cause of this issue.
>>>  - cc Martin too.
>>> ---
>>>  net/mptcp/protocol.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 579031c60937..d00cd21e8d3f 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -1981,9 +1981,9 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
>>>   */
>>>  static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
>>>  {
>>> +	u8 scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
>>
>> With this modification, you are limiting msk->scaling_ratio to
>> TCP_DEFAULT_SCALING_RATIO. That's probably not what you want. See below:
>>
>>   (...)
>>   mptcp_for_each_subflow(msk, subflow)
>>       (...)
>>       scaling_ratio = min(tp->scaling_ratio, scaling_ratio);
>>
>>   (...)
>>   msk->scaling_ratio = scaling_ratio;
>>
>>
>> Do you mean that in your case, msk->scaling_ratio was assigned to
>> U8_MAX? Or it was assigned to a too high value (>TCP_DEFAULT_SCALING_RATIO)?
>>
>> Please add such info in the commit message as well.
> 
> Sure. Here's the new subject and commit log:
> 
> '''
> Subject: mptcp: fix the max value of scaling_ratio
> 
> BPF tests fail sometimes (a probability of approximately 1%) with
> "bytes != total_bytes" errors:
> 
>  test_burst:PASS:open_and_load:burst 0 nsec
>  test_bpf_sched:PASS:Scheduler name too long 0 nsec
>  test_bpf_sched:PASS:burst 0 nsec
>  create_netns:PASS:ip netns add mptcp_ns 0 nsec
>  create_netns:PASS:ip -net mptcp_ns link set dev lo up 0 nsec
>  sched_init:PASS:create_netns 0 nsec
>  endpoint_init:PASS:ip -net mptcp_ns link add veth1 type veth peer name
>  endpoint_init:PASS:ip -net mptcp_ns addr add 10.0.1.1/24 dev veth1 0 nsec
>  endpoint_init:PASS:ip -net mptcp_ns link set dev veth1 up 0 nsec
>  endpoint_init:PASS:ip -net mptcp_ns addr add 10.0.1.2/24 dev veth2 0 nsec
>  endpoint_init:PASS:ip -net mptcp_ns link set dev veth2 up 0 nsec
>  endpoint_init:PASS:ip -net mptcp_ns mptcp endpoint add 10.0.1.2 subflow
>  sched_init:PASS:endpoint_init 0 nsec
>  test_bpf_sched:PASS:burst 0 nsec
>  send_data_and_verify:PASS:burst 0 nsec
>  send_data_and_verify:PASS:burst 0 nsec
>  (network_helpers.c:613: errno: Resource temporarily unavailable) \
>                                         send 5608500 expected 10485760
>  (network_helpers.c:661: errno: None) recv 2755984 expected 10485760
>  (network_helpers.c:669: errno: None) Failed in thread_ret -11
>  send_data_and_verify:FAIL:send_recv_data unexpected error: -4 (errno 0)
>  #162/9   mptcp/burst:FAIL
>  #162     mptcp:FAIL
> 
> In this case, mptcp_recvmsg() gets EAGAIN errors. This issue introduces
> by commit b8dc6d6ce931 ("mptcp: fix rcv buffer auto-tuning"). The max
> value of scaling_ratio should be TCP_DEFAULT_SCALING_RATIO (128), not
> U8_MAX (255). Otherwise, scaling_ratio is assigned to a too high value.
> '''

Sorry, I'm still not sure whether I understand the issue:

- Why limiting to the default value?

- Here, we want the higher scaling_ratio from all the available
subflows: is this value too high? What "too high value" you got that was
causing the issue you mentioned?

- What is a "too high value" for you and why?

- Or is it because scaling_ratio was assigned to U8_MAX and not changed
to the max value of the subflows by accident because there was a bypass
somehow?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

