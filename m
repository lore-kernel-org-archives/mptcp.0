Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631190;
	b=dl+lefzsrO0wg2LsFfgisncCsdJtaq1OU7ClMcQL6l87ZMyzPwg/m2gMNO0sFdTuRyuy
	 lt0X6Gp5BHsttjjiAYAiKfc2BrkH9Q+iEaU5hwAJ6z+bBHYttV5416GnrsAIwJIc3WhD5
	 uANDdRB88CUOaLaPSnx4RDH0AMuU72aCv0OOcmasrfu8qLe+N/AoqbNekuw8EDfHEtbyI
	 P6hTIRLH5J93/cMVFkfwIN7bNUnCyxZnbqH1himCXolrRd5XfeBZqKaVziZDvN4uSUD1C
	 bZyJ2/hPPVCI1BU9vnDD1tc4H4TgSjtvLsqDC5ZLtZa0OfdlJPlEl01WqksOId50k2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631190;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:From:To:Cc:References:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=qM1YySooHoHm1gj23kEOsBOeRg2NG9r9DRyC2BeZWks=;
	b=20A6yjnkE+89tkJe32g8bKkvyfeOK6W8vHZBq384Taj4SZ5cepMegY8eYYJlOvoC+DWO
	 Hg4L3rDtYSe+5zBj4w8ED/vMeet+wVeWAJco/dZlcwwn56aTS8HmfjK6qAkzI7lpxNoPm
	 pI6AOjMlHSi14AiOLzTD5nngUzOqWy86lGt8ews4UbRoxEQtnBWx56jKP8g1R+L9C9xlA
	 IvhNai2yvm5Ldvwi1JC26os1UB8ALZU/L/zwv3Lec3GN/xnFSNAp2cWtA0hAw2c8+BP78
	 NDeCapRmsHyyMUnPSVmellgtiO3a+3KgEkf0HoA4wtjPMMAQRgvmFfBcf8H8TWO49RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SUOUCdu4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B36606A327
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SUOUCdu4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A02E1F000C0;
	Wed, 25 Nov 2026 18:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795631190;
	bh=qM1YySooHoHm1gj23kEOsBOeRg2NG9r9DRyC2BeZWks=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=SUOUCdu4e+/a/HWSC8c9BGZu01AjyoIXQ4BtniNpFzyLY3G5ELAs8Apvx5nDiZw25
	 uYf4aNalq+Ci4utPyRdX6XHFXBSfWywIWOltNR6el23uAOrNrDj7iGXLZIJgVrM385
	 ADLK6bfpdyHv5p+yBzRYECziDg/IAGkKL1EcwZGYIFVYXjpGXKlUQELs1/xEy8iSqD
	 jRK9ZLcC8AYVJpfi9ronnTLVfcNoK8iUhJMYxJEHSg3q5r5XnKpgYcSxwH/HrKtw6H
	 COGdi/iPPnZvLmeqCnnabOAz7qDP6aj6XUkXV1zNlpBxIxo18qaTilYhzJlOS1LA/h
	 ZZVD2H8BJCD1Q==
Message-ID: <4bb59be0-1b1a-4bd8-ba71-5f5e01e48482@kernel.org>
Date: Wed, 25 Nov 2026 19:26:27 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v8 2/2] selftests: mptcp: join: re-add the
 initial subflow endp with fullmesh
Content-Language: fr
From: Matthieu Baerts <matttbe@kernel.org>
To: Abdul Wasey <w453y.me@gmail.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20261024111842.1069878-1-w453y.me@gmail.com>
 <20261024111842.1069878-3-w453y.me@gmail.com>
 <28a5ce9c-900b-4145-bc99-f6842f19572e@kernel.org>
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
In-Reply-To: <28a5ce9c-900b-4145-bc99-f6842f19572e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/11/2026 19:21, Matthieu Baerts wrote:> Hi Abdul,
> 
> On 24/10/2026 13:18, Abdul Wasey wrote:
>> The "delete and re-add" test validates the removal and the re-addition
>> of the endpoint used by the initial subflow, but without the fullmesh
>> flag.
>>
>> Do the same with the fullmesh flag: with a second subflow, after a reset
>> of the initial subflow, and with the initial subflow only, then re-adding
>> its endpoint or adding another one. Without the previous patch, no new
>> subflow is created, except when adding another endpoint.
> 
> Thank you for these patches, and for your patience.
> 
> Regarding the new tests, I think we should only add the minimum and
> avoid overlapping. Currently, these patches add 2 minutes in a debug
> build on the CI.
> 
> I think it would be better to drop the 4th subtest because it is
> redundant (and already passing before the previous patch). I would also
> combine 1st and 3rd ones to save time with the setup: at the end of the
> 1st one, so after the re-add, delete both endpoints and check there are
> 0 subflows ; re-add the ID 0 endpoint alone and check there is 1 subflow
> ; update the checks (wait_mpj 3, chk_join_nr 3 3 3, and the RM counters
> I suppose).
> 
> Because you might not remember all that from one month ago, please tell
> me if it is not clear or if you prefer me to edit the patch.

Just in case, something like that? (untested, just moving lines from the
3rd to the 1st and adapting some)

----------------------------- 8< -----------------------------
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4447,11 +4447,21 @@ endpoint_tests()
                wait_mpj 2
                chk_subflow_nr "after re-add id 0" 2

+               pm_nl_del_endpoint $ns2 1 10.0.1.2
+               wait_rm_addr $ns1 1
+               pm_nl_del_endpoint $ns2 2 10.0.2.2
+               sleep 0.5
+               chk_subflow_nr "after delete all" 0
+
+               pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+               wait_mpj 3
+               chk_subflow_nr "after re-add id 0 alone" 1
+
                mptcp_lib_kill_group_wait $tests_pid
                kill_events_pids

-               chk_join_nr 2 2 2
-               chk_rm_nr 1 1
+               chk_join_nr 3 3 3
+               chk_rm_nr 3 3
        fi

        # same, but the initial subflow is reset before removing its endpoint
----------------------------- 8< -----------------------------

(+ removing the 4th one)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

