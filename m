Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7BA179A7
	for <mptcp@lists.linux.dev>; Wed, 31 Jul 2024 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722438166; cv=none; b=tPGTacKuaRCD7u2FsllDXu6onvb5po9X6HYErc6ms+kkdfN68zSTUvoxBCwJH8MbHhMxV/W9DhmMxpJuij8gHqsLwpMsmVgV9l35SL65xx0yq83kEA4AS2N1XrPrOiWQ2IewxkwwDK1YY/ZRf9lXjyG/APCLjecDJzwhm87Jpco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722438166; c=relaxed/simple;
	bh=j0xcyuWtzrX1MuKeyJZr7lEkJ59rjJarmfZobzJUCio=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TP0YZgR0Jgde+lUy5o/Kb/CNKXpPlbB7bQBPr8UmMwQ4h2IWtXcu8AJJn1PbOdMZKQ0Rt/O8Ybi742iX7+WQXJuFzXXwvgs50lOKnpLXPVgePPpDE5Nt+8K/qrDY0dz3xpgfWtF897pKEJR4hdxdH88dNXjBruUDUPaM5EeJ4eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpRgfAur; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpRgfAur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D123C4AF0B;
	Wed, 31 Jul 2024 15:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722438165;
	bh=j0xcyuWtzrX1MuKeyJZr7lEkJ59rjJarmfZobzJUCio=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=BpRgfAurTZlNxe+SLGeQ38zj92KPtjRCKZZHkh8SJ4NIe9IGLrMdk2Bu4SG5Q23cV
	 ztyky8aVxqEkPnN/33eKZxSimcSMH/mqokZrezqy6wUoBdMgpihMucbvxPCnWbtOIP
	 qcTunxZutQT57ONJYmWH4k8Y04nSjOdQ5A4U52dVWYQnNzN5MWjuO0myaJ6z6DWLGh
	 Y7elj4LuX0loMQ/Gy7wNGdHVWzCc91rLjzjs/tWj1gnEyHLaNYQ38qsddth23KrUKo
	 /5cnwa8+m1e1KV7mJq1Bsvay2Lbw6jf9yaNZ7tJi+mFtCrloT8wO0hTZ6iHuIV0DAL
	 UegqIr5H76wQg==
Message-ID: <9a05b63f-5f09-4a46-9c41-5d9c0a0d5318@kernel.org>
Date: Wed, 31 Jul 2024 17:02:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 2/2] selftests: mptcp: join: validate MPJ
 SYN TX MIB counters
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20240729-mptcp-join-tx-mib-v2-0-8ace70fd407a@kernel.org>
 <20240729-mptcp-join-tx-mib-v2-2-8ace70fd407a@kernel.org>
 <54fe0a426f00ad7c6d4b2c639da7bb5925b408f7.camel@kernel.org>
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
In-Reply-To: <54fe0a426f00ad7c6d4b2c639da7bb5925b408f7.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for the review!

On 31/07/2024 04:59, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for these patches.
> 
> On Mon, 2024-07-29 at 12:18 +0200, Matthieu Baerts (NGI0) wrote:
>> A few new MIB counters have been added. They are being validated
>> here.
>>
>> Most of the time, there are no errors, but sometimes, more MPJ SYN
>> are
>> queued compared to the numbers that are received.
>>
>> Only one test has an error, the one to connect to a broadcast IP
>> address.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 63
>> +++++++++++++++++++++++++
>>  1 file changed, 63 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index fbb0174145ad..c1f1ebd2340c 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -1372,6 +1372,66 @@ chk_join_nr()
>>  	fi
>>  }
>>  
>> +chk_join_tx_nr()
>> +{
>> +	local syn_nr=$1
>> +	local festab=$2
>> +	local create=$3
>> +	local bind=$4
>> +	local connect=$5
>> +	local count
>> +
>> +	print_check "syn TX"
>> +	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTx")
>> +	if [ -z "$count" ]; then
>> +		print_skip
>> +	elif [ "$count" != "$syn_nr" ]; then
>> +		fail_test "got $count JOIN[s] syn TX expected
>> $syn_nr"
>> +	else
>> +		print_ok
>> +	fi
> 
> Do you think it is necessary to check MPTcpExtMPJoinSynTx in
> chk_join_nr()?

I thought about that, then I realised some tests were sending more
MP_JOIN than the received ones (e.g. when using "invalid addresses"). We
would then need to change the default counters, but chk_join_nr() can
already optionally check the checksum, making it difficult to read when
we have to pass 14 parameters:

  chk_join_nr 1 1 1 0 0 0 0 0 0 2 0 0 0 1

It looks simpler with a dedicated helper, and checking this only in some
places. WDYT?

>> +
>> +	print_check "syn TX Fully Estab Error"
>> +	count=$(mptcp_lib_get_counter ${ns2}
>> "MPTcpExtMPJoinSynTxFEstabErr")
>> +	if [ -z "$count" ]; then
>> +		print_skip
>> +	elif [ "$count" != "$festab" ]; then
>> +		fail_test "got $count JOIN[s] syn TX Fully Estab
>> Error expected $festab"
>> +	else
>> +		print_ok
>> +	fi
>> +
>> +	print_check "syn TX Create Socket Error"
>> +	count=$(mptcp_lib_get_counter ${ns2}
>> "MPTcpExtMPJoinSynTxCreatSkErr")
>> +	if [ -z "$count" ]; then
>> +		print_skip
>> +	elif [ "$count" != "$create" ]; then
>> +		fail_test "got $count JOIN[s] syn TX Create Socket
>> Error expected $create"
>> +	else
>> +		print_ok
>> +	fi
> 
> There is no test that can trigger MPTcpExtMPJoinSynTxFEstabErr and
> MPTcpExtMPJoinSynTxCreatSkErr. Does this mean that there is no need to
> add these two MIBs? Maybe adding pr_debug logs is enough? WDYT?

MPTcpExtMPJoinSynTxFEstabErr can be easily triggered by the userspace
PM. Maybe we don't need the counter for this case then? We could also do
the check in the userspace PM side, and return a netlink message
instead, but I don't think it is needed. Not sure what's best here. I
can remove it or leave it.

For MPTcpExtMPJoinSynTxCreatSkErr, it can be triggered if it cannot
allocate memory, if the socket limit has been reached out, if a security
module blocked it, etc. I think we should keep it, and we don't need to
validate it in the tests.

>> +
>> +	print_check "syn TX Bind Error"
>> +	count=$(mptcp_lib_get_counter ${ns2}
>> "MPTcpExtMPJoinSynTxBindErr")
>> +	if [ -z "$count" ]; then
>> +		print_skip
>> +	elif [ "$count" != "$bind" ]; then
>> +		fail_test "got $count JOIN[s] syn TX Bind Error
>> expected $bind"
>> +	else
>> +		print_ok
>> +	fi
>> +
>> +	print_check "syn TX Connect Error"
>> +	count=$(mptcp_lib_get_counter ${ns2}
>> "MPTcpExtMPJoinSynTxConnectErr")
>> +	if [ -z "$count" ]; then
>> +		print_skip
>> +	elif [ "$count" != "$connect" ]; then
>> +		fail_test "got $count JOIN[s] syn TX Connect Error
>> expected $connect"
>> +	else
>> +		print_ok
>> +	fi
>> +}
>> +
>>  # a negative value for 'stale_max' means no upper bound:
>>  # for bidirectional transfer, if one peer sleep for a while
>>  # - as these tests do - we can have a quite high number of
>> @@ -1907,6 +1967,7 @@ subflows_error_tests()
> 
> Add an invalid address here in this test:
> 
> 	pm_nl_add_endpoint $ns2 10.0.5.2 flags subflow
> 
>>  		speed=slow \
>>  			run_tests $ns1 $ns2 10.0.1.1
>>  		chk_join_nr 0 0 0
>> +		chk_join_tx_nr 0 0 0 0 0
> 
> It will trigger a "syn TX Bind Error":
> 
> 		chk_join_tx_nr 0 0 0 1 0

Good idea! I will do that in the v3.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

