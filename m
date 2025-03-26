Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE0E1A5B9C
	for <mptcp@lists.linux.dev>; Wed, 26 Mar 2025 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984262; cv=none; b=Za9IgES7pFg1ByLRudxQAxStqvrOMAnRn/368cZmU2W22FdT09qyHP8w/1ZmDdSwpAnHBC44ay2I2hPnKhAkQ8lmc0/pbYxXnl5GnH86tYrbvJerj+iFmAx9OVrdq8pdr7Es8DJhnNRGJfGE05RTTnXV1ddajKz2VaG4KG3OlRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984262; c=relaxed/simple;
	bh=NukYLm64Nj1dpdLBNvJ1SPaj7tabhhuy1pqJv7GOqgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIyB4T4VIuONlospoWg9HTZ49v4OwiGTPHXzvAeSRFq0EuCdhr6aa2fu87YwzPZO5v/4aX5HPK3tNZBBO/Ir4mYKVJwV8ckPcFuwn/ljLTkbAbGnXTYK5ZQxCQvLHNYZaCa3Jq8xXNhuAwKzAEO8oqMRYd3R7pyVYLrFSYoLpzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C90ihROT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C90ihROT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BF5C4CEE2;
	Wed, 26 Mar 2025 10:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742984262;
	bh=NukYLm64Nj1dpdLBNvJ1SPaj7tabhhuy1pqJv7GOqgo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C90ihROTXexTW0SP+UGxCKrH1pvyfmhaWnnALTnx+1KO9Tvb2BJgodbvSoX+BJ2LL
	 u6bGiZfY/8ZUcGt2MAaV/XI/swp1TY+i06blwStbg+YUz6rzjca6zP2JaYwyestXSL
	 IOpXOLWMKllaZ+zjGtz91HwiAnRzJUU4cY0Hunp0WCp1nPZFwKmym+JWeiqkdBhON8
	 T/N+10hGgEUAEhXcOXoa3oFampvWZ6hx1dyImm3Wq4gs/hXDZuZSLD6oeRQfSQuBOv
	 OJiBqLZjjfFal1HJo2AiYJVTcvLgbQQ0SyVoQBbVBEtk1E9i8WUO6mfI+Y11UNp5Xg
	 SRH6R2meekQ0A==
Message-ID: <a36555d6-8c71-4a5b-949c-c535919df510@kernel.org>
Date: Wed, 26 Mar 2025 11:17:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v1] mptcp: fix cast type of
 is_fully_established
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <27b15c2de6fe36088ef95c4823d9e4a6d7bc9ec6.1742898970.git.tanggeliang@kylinos.cn>
 <90ea00cb-d57e-411e-9108-624aad2194b9@kernel.org>
 <a68756790c7f4a698dfea5e5b5adb3531fdd2a96.camel@kernel.org>
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
In-Reply-To: <a68756790c7f4a698dfea5e5b5adb3531fdd2a96.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 26/03/2025 02:08, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for the review.
> 
> On Tue, 2025-03-25 at 11:49 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 25/03/2025 11:36, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> The parameter type of mptcp_is_fully_established() is 'struct sock
>>> *',
>>> not 'void *', so this patch casts 'msk' as 'struct sock *' instead
>>> of
>>> 'void *' in mptcp_can_accept_new_subflow().
>>
>> Indeed, but it is not really wrong to use 'void *'. Also, it looks
>> like
>> we are doing that in most other files from the net/mptcp directory.
> 
> I just checked, and there're indeed 6 other places that use '(void
> *)msk' too, but more places (98) use '(struct sock *)msk'.
> 
> $ grep -r "(void \*)msk" net/mptcp/ | wc -l
> 7
> $ grep -r "(struct sock \*)msk" net/mptcp/ | wc -l
> 98
> 
> I'm wondering if we should change all 7 '(void *)msk' to '(struct sock
> *)msk' in v2 to be consistent.

Maybe, I don't know to be honest. There are other (void *) usages, and
they are "fine" for the moment. Changing them might be good for the
consistency, but annoying in case of backports :-/

>> If you have to modify this line for another commit, feel free to
>> include
>> the modification in this commit if it bothers you ("While at it, use
>> the
>> proper cast instead of the generic 'void *'"), but it can also be
>> left
>> unchanged I think.
> 
> Or simply drop this patch. Both are OK to me.

Yes, maybe. I will ask Mat what he thinks about that.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

