Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DDA19413B
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530204; cv=none; b=p0yVu5sTBV9OXao9VK8r/SmrT+DBBDMIVYchhZoxBF5cAKST/ZYEawbwy/T7Dp5UtbCQdSl8G4ljcrfkpO8RQL+fGuJsVDoP/SfgdKIIGtAfM9AADuhCgPm9P+zhoMnmSpd5e7flWWlyZUy3nWfTkLfwUB1secgBMNMgemBIVi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530204; c=relaxed/simple;
	bh=V1ytBw4q0zHkZB7c6rgUde+lzPtqjQPnRH/Ct4gq/y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ps0/weIQ+2+df4XphmYIEzcb3Yg/Hlj5MfRwi/xERZrKNQU7+mc6fNKgiteBCdbK812JOJz6+0/OguJEGgjVIS27iPpFS8zILTF3QRReogz/8GOS6hREWS46EbAwOLUOmXbLecCv09RzyxcPkj8dDtBG/6KZin8v+XgteRmzbJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqWnUTun; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqWnUTun"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890A6C4CEC3;
	Thu,  5 Sep 2024 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725530204;
	bh=V1ytBw4q0zHkZB7c6rgUde+lzPtqjQPnRH/Ct4gq/y8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JqWnUTun73++bee3fTuUZR3HR6Iepv8OY/3AQ6kOwtj5B/WXxiV4eVXMZyCKUnSFX
	 zPTUI34qeNyC0uadhop8K/Fe2jw7Q7GtXKEgvd3DqHzrdU9qLkToQrEhO+x13UZtK2
	 BetW6yjI7MJnQz3dF9fYPL6u3hqWo4AR+j0EZnEHG9tml7mfj2a82BN6NoJ+HiwRXa
	 2eini2nDiryMZIlyelKqlX1bThNtZzc1kmnjkjPV/kjo+BB602ocl8j0dLhnr2BCOX
	 Btix6UkegKtq/mTV95Go/6gMYt+VDMUtKVcRXIndzzeziTNxsjSnkjOw7v5MwcnV4G
	 rc9+CfF5vdMfQ==
Message-ID: <3cbf903b-92d3-4bc5-9eae-7d86536c8551@kernel.org>
Date: Thu, 5 Sep 2024 11:56:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v8 2/4] selftests/bpf: Add getsockopt to
 inspect mptcp subflow
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1725502822.git.tanggeliang@kylinos.cn>
 <44ef8e395feddc3fe83c1ea043c3bc07f98c1042.1725502822.git.tanggeliang@kylinos.cn>
 <3d0b6acfa9753162380c640bcb13c54bf00af544.camel@kernel.org>
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
In-Reply-To: <3d0b6acfa9753162380c640bcb13c54bf00af544.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 05/09/2024 10:06, Geliang Tang wrote:
> Hi Matt,
> 
> On Thu, 2024-09-05 at 10:26 +0800, Geliang Tang wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> This patch adds a "cgroup/getsockopt" way to inspect the subflows of
>> a
>> mptcp socket.
>>
>> mptcp_for_each_stubflow() and other helpers related to list_dentry
>> are
>> added into progs/mptcp_bpf.h.
>>
>> Add an extra "cgroup/getsockopt" prog to walk the msk->conn_list and
>> use
>> bpf_core_cast to cast a pointer to tcp_sock for readonly. It will
>> allow
>> to inspect all the fields in a tcp_sock.
>>
>> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>> ---
>>  tools/testing/selftests/bpf/progs/mptcp_bpf.h | 27 ++++++++
>>  .../selftests/bpf/progs/mptcp_subflow.c       | 69
>> +++++++++++++++++++
>>  2 files changed, 96 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
>> b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
>> index 782f36ed027e..92d5deed0214 100644
>> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
>> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
>> @@ -4,9 +4,36 @@
>>  
>>  #include <vmlinux.h>
>>  #include <bpf/bpf_core_read.h>
>> +#include "bpf_experimental.h"
>>  
>>  #define MPTCP_SUBFLOWS_MAX 8
>>  
>> +static inline int list_is_head(const struct list_head *list,
>> +			       const struct list_head *head)
>> +{
>> +	return list == head;
>> +}
>> +
>> +#define list_entry(ptr, type,
>> member)					\
>> +	container_of(ptr, type, member)
>> +
>> +#define list_first_entry(ptr, type,
>> member)				\
>> +	list_entry((ptr)->next, type, member)
>> +
>> +#define list_next_entry(pos,
>> member)					\
>> +	list_entry((pos)->member.next, typeof(*(pos)), member)
>> +
>> +#define list_entry_is_head(pos, head,
>> member)				\
>> +	list_is_head(&pos->member, (head))
>> +
>> +#define list_for_each_entry(pos, head,
>> member)				\
>> +	for (pos = list_first_entry(head, typeof(*pos),
>> member);	\
>> +	     cond_break, !list_entry_is_head(pos, head,
>> member);	\
>> +	     pos = list_next_entry(pos, member))
>> +
>> +#define mptcp_for_each_subflow(__msk,
>> __subflow)			\
>> +	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
>> +
> 
> The helper mptcp_subflow_tcp_sock() added by the commit "selftests/bpf:
> Add bpf_rr scheduler & test" needs be added into this commit:
> 
> static __always_inline struct sock *
> mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
> {
>         return subflow->tcp_sock;
> }
> 
> Otherwise, compiling errors occur.

Thank you for the heads-up. Please note that the file doesn't exist in
net-next, so we need to add it, and update the MAINTAINERS file. I'm
fixing that. While at it, I'm also adding comments about where the
helpers are coming from this in mptcp_bpf.h file, and the modifications
you did on top. That should help for the maintenance.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

