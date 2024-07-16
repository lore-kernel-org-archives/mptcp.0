Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4845101F2
	for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721126694; cv=none; b=K4B7wCF8u35/6iU+7Kcn0vx4qZ61M34XNZH9OiVwBLxmH+ODG4XJQZ6GPPk6ecLBZXyPreGIzKJcsh7rkq6p/4vcEu8N5u6yEYH679jMuyvMhkbRUf45lpvGU0/R2bJwlQ/tRef0KHliC7KgAJjeTzeSueQKjXJcYzQUF7QK7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721126694; c=relaxed/simple;
	bh=EMRTrZMgca9GqHSrDHC8tkXTsI7s6GcGH3vcUn23xZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sS92u3f/8lBZE3X9sPUwa6/hG0hMrmLTeLrfSJPXSTYcI1fM9l6ovm8HfidiGROSjpU2z2FOCOITeg5Q3Lbjnoy1X2nzWS/1nkF9rhtD2xzol/qiDZ5ge1jAZM+ybgCipW5ZJKkKHKdDZIwWaYpv5DHh+qNbkbi1xvZsPI/pECw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8t+R652; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8t+R652"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04CBC116B1;
	Tue, 16 Jul 2024 10:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721126693;
	bh=EMRTrZMgca9GqHSrDHC8tkXTsI7s6GcGH3vcUn23xZA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=g8t+R652cfdVx4AEjt8jg+qw8u/9eQImfJ8FTZO8rnTjo3UAPygHVrcPEdpDOh4V2
	 znICpMp4reuNMex1HY0Zuj7pLywFA5zlbjpXrZx+uUzF1AstgLUspK2/oybKwlF7ao
	 aFQGzHR6RRocrG4+5rfGuiuqSyr/pXKvPxympTiCxR8rb/CVPkUIg+nsLqpMyyMKmB
	 DKCW+2aPSRQQ9njFX2RkeIVf6glWKJcDQzoryyN1YVkwe+faxAaDwH0Q7yZ1G5+lTl
	 mqnPjhV3pDckhw5EI4K4FJ0mrJBXsL3I5O4iEz1sxAmkl+K8/dwWabF0LGj+2iMvLp
	 V4K8pZMZaxIhw==
Message-ID: <29d1c09f-f082-4740-91e3-91b9b585e30c@kernel.org>
Date: Tue, 16 Jul 2024 12:44:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH RFC mptcp-next fixes] mptcp: process MP_JOIN's 4th ACK
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20240715-mptcp-process-4th-ack-mpj-v1-1-d44fc90245e2@kernel.org>
 <504957bf-8de8-4ea4-aadf-b84b62d267ea@redhat.com>
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
In-Reply-To: <504957bf-8de8-4ea4-aadf-b84b62d267ea@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 16/07/2024 12:35, Paolo Abeni wrote:
> 
> 
> On 7/15/24 21:09, Matthieu Baerts (NGI0) wrote:
>> The 'Fixes' commit recently changed the behaviour for MPTCP Join
>> requests for listening sockets: when receiving the 3rd ACK of a request
>> adding a new path (MP_JOIN), sk->sk_socket will be set, and point to the
>> MPTCP sock that has been created when the MPTCP connection got created
>> before with the first path. The newly added 'goto' will then skip the
>> process of the segment text (step 7) and not go through tcp_data_queue()
>> where the MPTCP options are validated, and some actions are triggered,
>> e.g. sending the MPJ 4th ACK [1].
>>
>> This doesn't fully break MPTCP, mainly the 4th MPJ ACK that will be
>> delayed, but it looks like it affects the MPTFO feature as well --
>> probably in case of retransmissions I suppose -- and being the reason
>> why the selftests started to be unstable the last few days [2].
>>
>> TODO: it is not clear to me if we need to fix something for MPTCP. The
>> following packetdrill test doesn't seem to be failing with the following
>> patch, we can see a fallback to TCP, which seems OK in this case, no?
>>
>>    `../common/defaults.sh`
>>
>>     0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_MPTCP) = 3
>>    +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
>>
>>    +0 > S  0:0(0)                 <mss 1460, sackOK, TS val 100 ecr
>> 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
>>    +0 < S  0:0(0) win 1000        <mss 1460, sackOK, TS val 407 ecr
>> 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
>>    +0 > S. 0:0(0) ack 1           <mss 1460, sackOK, TS val 330 ecr
>> 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
>>    +0 < S. 0:0(0) ack 1 win 65535 <mss 1460, sackOK, TS val 700 ecr
>> 100, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey=2]>
>>
>>    +0 write(3, ..., 100) = 100
>>    +0 >  . 1:1(0)     ack 1 <nop, nop, TS val 845707014 ecr 700, nop,
>> nop, sack 0:1>
>>    +0 > P. 1:101(100) ack 1 <nop, nop, TS val 845958933 ecr 700>
>>
>> Link: https://datatracker.ietf.org/doc/html/rfc8684#fig_tokens [1]
>> Link: https://netdev.bots.linux.dev/contest.html?executor=vmksft-
>> mptcp-dbg&test=mptcp-connect-sh [2]
>> Fixes: 23e89e8ee7be ("tcp: Don't drop SYN+ACK for simultaneous
>> connect().")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>   net/ipv4/tcp_input.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index ff9ab3d01ced..ff981d7776c3 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -6820,7 +6820,7 @@ tcp_rcv_state_process(struct sock *sk, struct
>> sk_buff *skb)
>>           if (sk->sk_shutdown & SEND_SHUTDOWN)
>>               tcp_shutdown(sk, SEND_SHUTDOWN);
>>   -        if (sk->sk_socket)
>> +        if (sk->sk_socket && !sk_is_mptcp(sk))
>>               goto consume;
>>           break;
>>  
>> ---
> 
> patch LGTM

Thank you for having looked!

Should I already send the patch -- without the TODO, but mentioning the
fallback to TCP instead -- to have it accepted before sending the pull
request to Linus if we still have time?

> but I'm wondering if a similar problem can be reproduced
> with plain TCP and  TFO?
> 
> 
> syn + TFO    ->
>         <- syn ack
>             [accept]
> ack        ->
>         NO 3rd ack????
> 
> If so possibly the 'if (sk->sk_socket ...' check should be refined even
> more?!??

Good point!

I can mention that in the comment of my patch, and try to reproduce that
locally. WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

