Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25CB1E51EF
	for <mptcp@lists.linux.dev>; Mon,  4 Aug 2025 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754329458; cv=none; b=c/Ap+E4WKC4QnwGNyda+wKLNxFCFg6hUb1pc/8mC7A6imD+AcVCnWLEfTxGKH2J4f4D9EkdiEz2QP4WC3D4TUvK4nynlkrl09BFs7SD+mKdFeBVp3i1ouKjTKRDF9Oex3Wo2NXnPtU02ZKbQ3VOGa1vz6d/ncSpNlHxD79uT5Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754329458; c=relaxed/simple;
	bh=/PWDJeqgjAUp7WJyMgTeKhkUOpE2sPCfXxrSUwrXRHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEcTPad5O1oLNYU47WxDIkt+7cUnzg0i9ZGIEE9ALO7yfK6LOhiTgaknsnFqJc0Rawwy6BS9+/ka5W03LIoJsAK1KHkfIcxLc048512m9UGx+Alc3RC5Ea3T4Jqp1Y+Q50INptE47e78vg/I3kPVslFFZGtKBUjrWyT2cb0dv44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxcmRw8u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxcmRw8u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40355C4CEE7;
	Mon,  4 Aug 2025 17:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754329457;
	bh=/PWDJeqgjAUp7WJyMgTeKhkUOpE2sPCfXxrSUwrXRHc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KxcmRw8uJsCItBi4FsbqeB3gTek+amreIAW+0ne62X8drTdZPuwhH4xJxhi7FMXwB
	 ov+Noqs8FnYfJnRwcs08toe0Km2f0dvP+QPE0h0wrAaVbn70+j0AzP41waBUCfvneF
	 7Izs1BdOrZxhBMlg/WblnFMuO2EAHOHxgcPQWvr8jpfpAwzMxv3ZOMjr03jb2ELW+L
	 nm8vw30iooE5zdclF3m0aL4EPsarFFsjnsSRj9+5/0mIAVZnrooqr9CAI7agHb9VRK
	 0j99cw9qcInt6b0wQgiwH9HnVNBlR6rXXW/g57YEeBiNGyrmvlFNVnHmePsb0e6pb/
	 1kc6h/2gM0+4w==
Message-ID: <aeab55b9-8830-4192-9524-38298e3c44c8@kernel.org>
Date: Mon, 4 Aug 2025 19:44:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/2] selftests: Add tests for
 SO_MAX_PACING_RATE
Content-Language: en-GB, fr-BE
To: Christoph Paasch <cpaasch@openai.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
References: <20250802-b4-mptcp_setsockopt-v1-0-50d4905a4c2b@openai.com>
 <20250802-b4-mptcp_setsockopt-v1-2-50d4905a4c2b@openai.com>
 <fec77e23-020c-4bdb-b937-df11685dd6ca@kernel.org>
 <CADg4-L-nk1-WZjBZ0iQ_ZNvrjttELypJ=4YvQx3AG9wtmjUYBw@mail.gmail.com>
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
In-Reply-To: <CADg4-L-nk1-WZjBZ0iQ_ZNvrjttELypJ=4YvQx3AG9wtmjUYBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Christoph,

On 04/08/2025 19:09, Christoph Paasch wrote:
> On Sun, Aug 3, 2025 at 5:04 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi Christoph,
>>
>> On 03/08/2025 01:52, Christoph Paasch via B4 Relay wrote:
>>> From: Christoph Paasch <cpaasch@openai.com>
>>>
>>> Add a test to check the API for SO_MAX_PACING_RATE in MPTCP.
>>
>> This test only checks if some values can be set or not, but most of that
>> is checked by the code in net/core/sock.c, not really related to MPTCP.
>> Do you think it is worth it?
> 
> I think it's useful :-)

OK to keep it there then.

>> Could we eventually have a test checking the expected rate when using
>> multiple subflows? Or would it be too complex? I guess not something
>> easy to do with Packetdrill, right?
> 
> In a past life I have implemented packetdrill tests for
> SO_MAX_PACING_RATE. It's possible, but means that we have to run
> packetdrill with minimal `--tolerance_usecs`. We have to agree that we
> want to go down this route. IMO getting rid of --tolerance_usecs is
> possible and it is a good thing to do. You can get tests stable that
> way. It does take some time though.

That would be great! I don't know if it would be OK for the public CI
with a debug kernel, but also OK to ignore them there.

> Another approach to test this with selftests is to set the pacing-rate
> and do some simple bulk-data transfer and measure how much data
> reached the receiver.

Do you think the "simult_flows" MPTCP selftest could be easily extended
to do that? That's maybe an easier solution. Could it not even help to
stabilise these tests?

I guess we don't need extensive / advanced tests to check a pacing limit
per subflow. But it would be good to check that it works, and to catch
regressions :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

