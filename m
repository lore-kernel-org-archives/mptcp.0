Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CD630F55F
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 02:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780020331; cv=none; b=pxkeJPCG7dDgZU4aqkgHigp+FENfgZao7Xyi0eAuZdAzdVreV5ACGUWGTXgMMuT77EwFZiHAia/0JQqsqmDuFkjgvf6BHlCfaMsvOZFZuMgVj1HDHyRanFwYNbMlEPZqaLE7haE3eVf31NScAoMqFMQcj/pVaCH7gov/KEpI5iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780020331; c=relaxed/simple;
	bh=cCxNy+r9T2JUC30npBdrwHWUsfjtBMvmilhm11+bR8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIMHcTL3cs6Pxt9dxoxeccSn96rRV2eyj3snGX9zJ32OsA83Mapjcl0SRruxaUTedMKVx2VU+jDCkYxlXWzBpxn6d8syNGGCptwfuFAt2cdczNTy4to9ekjOdeZT0sX14xbea2Cjp0DdZhroFFEFGS3fkbSrMJDYc4drYJB8Oy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsYZ/Mnk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsYZ/Mnk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C5C1F000E9;
	Fri, 29 May 2026 02:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780020330;
	bh=Damk8nI0oxwvRigSuPkkWRkdGwybxJhMB6oA3dclObU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NsYZ/MnkyOECPZLlzGSG1a+xzz/SkyNcLUfh8Z8vTNt7x+fi+9o29BWcmwS2fONjJ
	 ce/P1hsj7AaEbupR4nlTJWDVY5oIC/NXZIEUTGjRKkG0rqFqRaKtXaFfHxYu4P3ROx
	 YUOU02dGqCPayBmfODpZFpJEamlozK0I4q7BQ1Ta5LxrNNNTe2Ya40KITYlVhPll1R
	 8eylsh3N+BJ3EqKIrF/wcpaG+gAq4+J6iJglb0/etYI1Mwo9GkxuK1kyxCrqLcnmWI
	 CFjdgV9d6yuBirXVks3Km/OxErgkuXSf80KFhM8OtslBq1VlNM7vii2yXRXL73NhFU
	 S64Vc+kB3Ssfw==
Message-ID: <67848e88-2377-42f2-b793-1114cb73c779@kernel.org>
Date: Fri, 29 May 2026 12:05:26 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 03/16] mptcp: pm: avoid computing rm_addr
 size twice
Content-Language: fr
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
 <20260520-mptcp-add-addr6-port-ts-v3-3-bffa658a7678@kernel.org>
 <0a8338e5-d688-ea0a-9d9e-622b8bc3f99c@kernel.org>
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
In-Reply-To: <0a8338e5-d688-ea0a-9d9e-622b8bc3f99c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 29/05/2026 12:02, Mat Martineau wrote:
> On Wed, 20 May 2026, Matthieu Baerts (NGI0) wrote:
> 
>> mptcp_rm_addr_len helper was called twice: in mptcp_pm_rm_addr_signal,
>> then just after in mptcp_established_options_rm_addr. Both to check the
>> remaining space.
>>
>> The second call is not needed: if there is not enough space,
>> mptcp_pm_rm_addr_signal will return false, and the caller,
>> mptcp_established_options_rm_addr, will do the same without re-checking
>> the size again. Instead, mptcp_pm_rm_addr_signal can directly set the
>> size.
>>
>> While at it, move mptcp_rm_addr_len to pm.c, as it is now only used
>> there, once.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> net/mptcp/options.c  | 11 ++---------
>> net/mptcp/pm.c       | 11 ++++++++++-
>> net/mptcp/protocol.h | 10 +---------
>> 3 files changed, 13 insertions(+), 19 deletions(-)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 966f6a867287..231010aaf163 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -723,19 +723,12 @@ static bool
>> mptcp_established_options_rm_addr(struct sock *sk,
>>     struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>>     struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>>     struct mptcp_rm_list rm_list;
>> -    int i, len;
>> +    int i;
>>
>>     if (!mptcp_pm_should_rm_signal(msk) ||
>> -        !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list)))
>> +        !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list, size)))
>>         return false;
>>
>> -    len = mptcp_rm_addr_len(&rm_list);
>> -    if (len < 0)
>> -        return false;
>> -    if (remaining < len)
>> -        return false;
>> -
>> -    *size = len;
>>     opts->suboptions |= OPTION_MPTCP_RM_ADDR;
>>     opts->rm_list = rm_list;
>>
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index 4fc7d648b672..e78a248414fb 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -960,8 +960,16 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock
>> *msk, const struct sk_buff *skb,
>>     return ret;
>> }
>>
>> +static int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
>> +{
>> +    if (rm_list->nr == 0 || rm_list->nr > MPTCP_RM_IDS_MAX)
>> +        return -EINVAL;
>> +
>> +    return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
>> +}
>> +
>> bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int
>> remaining,
>> -                 struct mptcp_rm_list *rm_list)
>> +                 struct mptcp_rm_list *rm_list, unsigned int *size)
> 
> The signed/unsigned comment from patch 2 affects the type of 'size' here
> too.

Good point, even if here, the size cannot be negative. If there are no
other comments, I can also do the modification when applying the series.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

