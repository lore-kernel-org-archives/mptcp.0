Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682A51CC160
	for <mptcp@lists.linux.dev>; Thu, 22 Aug 2024 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341257; cv=none; b=lSRpHov+XULtK4l0VGF7rDvfF4B4FY4AgPBkkeBQEcyxRj2cRE29MlUATWyMFCTLt3Nnpnb3hyIhrJu/U3m0oYpPWcgXtfUtWbscKpTVLnpgx1MsGcuSAuT827wwgmiDFfMgED0BXyOsdHbWJ2xCVE7qVdHD+2XXdqMGgtpQ35c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341257; c=relaxed/simple;
	bh=q9taCk0GYkBxtl5r/c1hISv3lC5bEHkCUiBe64bikDo=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=E55pZ2xVMXjLgKxuQYT/wZHIrl8YjLtGxUfhRY7a+PpP0cBuWGTWbn9It14RPfTwNWfhoh09moxr0KYottShC9rZaSVouGYMVlsfgj8Ajww5vRq2eUW1o5Las7Fh9nmVAtgdZjpiK+LYDoLsMe856HNz5g3IFCs7djpkcVACVeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hu/tO7nF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hu/tO7nF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF144C32782
	for <mptcp@lists.linux.dev>; Thu, 22 Aug 2024 15:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724341257;
	bh=q9taCk0GYkBxtl5r/c1hISv3lC5bEHkCUiBe64bikDo=;
	h=Date:From:To:Subject:From;
	b=Hu/tO7nFQttMtwiT7Z7fjbcf0L5DIW2mfRCmpWtV0EwQsZa++U7l3wLt856LmO3ek
	 Vmor8ol9v2rOOckhzppU8QjF2CYTraMQBQcs6oGRx8jCK43+ia0XGIejjLhJEx0n+4
	 e5r0OtDepmG8ZpuqzRi+wdVCzVesEqP/SDRM9RAaKEufLHECIx4xPKC4yUDwegPSsQ
	 jGb6tR59SRpgHVCE1I5qYfKPQBYlXM/qLAbHJv1Z/Vz59fMPPwqbG1zuULq2bgcTO4
	 7ijePBdmaDrfOhFECdJ4c3Z2fc5W2e3pko0qbV1w9mYqmemnkwpRyjJIkZpqEMy/ok
	 CYQxZHbcpUpmg==
Message-ID: <4af7cb9f-7b30-45be-8e82-6427bd8b7d21@kernel.org>
Date: Thu, 22 Aug 2024 17:40:54 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
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
To: MPTCP Linux <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 21st of August 2024
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Yesterday, we had our new meeting with Mat (Cruise), Christoph (Apple),
and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Eugene Syromiatnikov, Matthieu
Baerts (NGI0)):

Lot of backports:

13756638: [6.6.y] mptcp: pm: fix backup support in signal endpoints:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240807185702.1871002-2-matttbe@kernel.org/

13756639: [6.6.y] selftests: mptcp: fix error path:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240807185804.1872347-2-matttbe@kernel.org/

13757868: [6.1.y] mptcp: mib: count MPJ with backup flag:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240808153004.2308809-2-matttbe@kernel.org/

13757869: [6.1.y,1/2] mptcp: export local_address
13757870: [6.1.y,2/2] mptcp: pm: fix backup support in signal endpoints:
    - Series: [6.1.y,1/2] mptcp: export local_address
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=877879&state=*&archive=both

13757871: [6.1.y] selftests: mptcp: join: validate backup in MPJ:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240808153657.2317378-2-matttbe@kernel.org/

13757872: [6.1.y] selftests: mptcp: join: check backup support in signal
endp:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240808153829.2319257-2-matttbe@kernel.org/

13758566: [5.15.y] mptcp: sched: check both directions for backup:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240809090530.2696742-2-matttbe@kernel.org/

13758567: [5.15.y] mptcp: distinguish rcv vs sent backup flag in requests:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240809090607.2697543-2-matttbe@kernel.org/

13758568: [5.15.y] mptcp: fix NL PM announced address accounting:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240809090721.2699120-2-matttbe@kernel.org/

13758569: [5.15.y] mptcp: mib: count MPJ with backup flag:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240809090753.2699805-2-matttbe@kernel.org/

13758570: [5.15.y] mptcp: fix bad RCVPRUNED mib accounting:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240809090813.2700287-2-matttbe@kernel.org/

13758571: [5.15.y] mptcp: pm: only set request_bkup flag when sending
MP_PRIO:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240809090845.2700989-2-matttbe@kernel.org/

13758572: [5.15.y,1/2] mptcp: export local_address
13758573: [5.15.y,2/2] mptcp: pm: fix backup support in signal endpoints:
    - Series: [5.15.y,1/2] mptcp: export local_address
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=878134&state=*&archive=both

13758574: [5.15.y] selftests: mptcp: join: validate backup in MPJ:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240809091002.2702612-2-matttbe@kernel.org/

13758575: [5.15.y] selftests: mptcp: join: check backup support in
signal endp:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240809091031.2703339-2-matttbe@kernel.org/

13758691: [5.10.y] mptcp: sched: check both directions for backup:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240809105412.2901173-2-matttbe@kernel.org/

13758692: [5.10.y] mptcp: distinguish rcv vs sent backup flag in requests:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240809105430.2901613-2-matttbe@kernel.org/

13758693: [5.10.y] mptcp: fix NL PM announced address accounting:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240809105449.2902071-2-matttbe@kernel.org/

13758694: [5.10.y] mptcp: mib: count MPJ with backup flag:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240809105514.2902623-2-matttbe@kernel.org/

13758695: [5.10.y,1/2] mptcp: export local_address
13758696: [5.10.y,2/2] mptcp: pm: fix backup support in signal endpoints:
    - Series: [5.10.y,1/2] mptcp: export local_address
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=878173&state=*&archive=both

13760209: [net-next,v2] mptcp: correct MPTCP_SUBFLOW_ATTR_SSN_OFFSET
reserved size:
    - Submitter: Eugene Syromiatnikov
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240812065024.GA19719@asgard.redhat.com/

13760786: [6.10.y,1/5] mptcp: pm: reduce indentation blocks
13760787: [6.10.y,2/5] mptcp: pm: don't try to create sf if alloc failed
13760788: [6.10.y,3/5] mptcp: pm: do not ignore 'subflow' if 'signal'
flag is also set
13760789: [6.10.y,4/5] selftests: mptcp: join: ability to invert
ADD_ADDR check
13760790: [6.10.y,5/5] selftests: mptcp: join: test both signal & subflow:
    - Series: Backport of "mptcp: pm: don't try to create sf if alloc
failed" and more
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=878856&state=*&archive=both

13760792: [6.6.y,1/5] mptcp: pm: reduce indentation blocks
13760793: [6.6.y,2/5] mptcp: pm: don't try to create sf if alloc failed
13760794: [6.6.y,3/5] mptcp: pm: do not ignore 'subflow' if 'signal'
flag is also set
13760795: [6.6.y,4/5] selftests: mptcp: join: ability to invert ADD_ADDR
check
13760796: [6.6.y,5/5] selftests: mptcp: join: test both signal & subflow:
    - Series: Backport of "mptcp: pm: don't try to create sf if alloc
failed" and more
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=878857&state=*&archive=both

13760797: [6.6.y] Revert "selftests: mptcp: simult flows: mark
'unbalanced' tests as flaky":
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240812153133.574382-2-matttbe@kernel.org/

13761590: [6.1.y] mptcp: fully established after ADD_ADDR echo on MPJ:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240813090606.939542-2-matttbe@kernel.org/

13761640: [6.1.y,1/5] mptcp: pass addr to mptcp_pm_alloc_anno_list
13761641: [6.1.y,2/5] mptcp: pm: reduce indentation blocks
13761642: [6.1.y,3/5] mptcp: pm: don't try to create sf if alloc failed
13761643: [6.1.y,4/5] mptcp: pm: do not ignore 'subflow' if 'signal'
flag is also set
13761644: [6.1.y,5/5] selftests: mptcp: join: test both signal & subflow:
    - Series: Backport of "mptcp: pm: don't try to create sf if alloc
failed" and more
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=879125&state=*&archive=both

13761763: [5.15.y] mptcp: fully established after ADD_ADDR echo on MPJ:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240813104642.1210553-2-matttbe@kernel.org/


13762070: [net] selftests: net: lib: kill PIDs before del netns:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240813-upstream-net-20240813-selftests-net-lib-kill-v1-1-27b689b248b8@kernel.org/

13768913: [net,01/14] mptcp: pm: re-using ID of unused removed ADD_ADDR
13768914: [net,02/14] selftests: mptcp: join: check re-using ID of
unused ADD_ADDR
13768915: [net,03/14] mptcp: pm: re-using ID of unused removed subflows
13768916: [net,04/14] selftests: mptcp: join: check re-using ID of
closed subflow
13768917: [net,05/14] mptcp: pm: re-using ID of unused flushed subflows
13768918: [net,06/14] selftests: mptcp: join: test for flush/re-add
endpoints
13768919: [net,07/14] mptcp: pm: remove mptcp_pm_remove_subflow()
13768920: [net,08/14] mptcp: pm: only mark 'subflow' endp as available
13768921: [net,09/14] mptcp: pm: only decrement add_addr_accepted for
MPJ req
13768922: [net,10/14] mptcp: pm: check add_addr_accept_max before
accepting new ADD_ADDR
13768923: [net,11/14] mptcp: pm: only in-kernel cannot have entries with
ID 0
13768924: [net,12/14] mptcp: pm: fullmesh: select the right ID later
13768925: [net,13/14] selftests: mptcp: join: validate fullmesh endp on
1st sf
13768926: [net,14/14] mptcp: pm: avoid possible UaF when selecting endp:
    - Series: mptcp: pm: fix IDs not being reusable
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=881036&state=*&archive=both


    our repo (by: Geliang Tang, Matthieu Baerts (NGI0)):

13751831: [mptcp-net,v6,01/11] Squash to "mptcp: pm: re-using ID of
unused removed ADD_ADDR"
13751832: [mptcp-net,v6,02/11] Squash to "mptcp: pm: fullmesh: select
the right ID later"
13751833: [mptcp-net,v6,03/11] mptcp: pm: fix RM_ADDR ID for the initial
subflow
13751834: [mptcp-net,v6,04/11] selftests: mptcp: join: check removing ID
0 endpoint
13751835: [mptcp-net,v6,05/11] mptcp: pm: send ACK on an active subflow
13751836: [mptcp-net,v6,06/11] mptcp: pm: skip connecting to already
established sf
13751837: [mptcp-net,v6,07/11] mptcp: pm: reset MPC endp ID when re-added
13751838: [mptcp-net,v6,08/11] selftests: mptcp: join: check re-adding
init endp with != id:
    - More fixes for the PM

13758713: [mptcp-next,v4,1/8] selftests: mptcp: join: no extra msg if no
counter
13758714: [mptcp-next,v4,2/8] mptcp: MIB counters for sent MP_JOIN
13758715: [mptcp-next,v4,3/8] selftests: mptcp: join: reduce join_nr params
13758716: [mptcp-next,v4,4/8] selftests: mptcp: join: one line for join
check
13758717: [mptcp-next,v4,5/8] selftests: mptcp: join: validate MPJ SYN
TX MIB counters
13758718: [mptcp-next,v4,6/8] selftests: mptcp: join: more explicit
check name
13758719: [mptcp-next,v4,7/8] selftests: mptcp: join: specify host being
checked
13758720: [mptcp-next,v4,8/8] selftests: mptcp: join: mute errors when
ran in the background:
    - Series: mptcp: MIB counters for sent MP_JOIN
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=878183&state=*&archive=both

13758755: [mptcp-net,v7,1/3] mptcp: close subflow when receiving TCP+FIN
13758756: [mptcp-net,v7,2/3] selftests: mptcp: join: cannot rm sf if closed
13758757: [mptcp-net,v7,3/3] mptcp: pm: send ACK on non stale subflows:
    - Series: mptcp: pm: more fixes around the ID 0
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=878199&state=*&archive=both

13761837: [mptcp-net] mptcp: sched: check both backup in retrans:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240813-mptcp-sched-retrans-bkp-v1-1-78914a88c2c6@kernel.org/

13765951: [mptcp-net,v2,01/12] Squash to "mptcp: pm: re-using ID of
unused removed ADD_ADDR"
13765953: [mptcp-net,v2,03/12] Squash to "mptcp: pm: only mark 'subflow'
endp as available"
13765955: [mptcp-net,v2,05/12] Squash to "mptcp: pm: fix RM_ADDR ID for
the initial subflow"

13768044: [mptcp-net,v2] mptcp: pr_debug: add missing \n at the end:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240819-mptcp-pr_debug_n-v2-1-97cbe3f7d975@kernel.org/

13768342: [mptcp-next] selftests: mptcp: pm_nl_ctl: remove re-definition:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240819-mptcp-pm-events-v1-1-c31d472471be@kernel.org/

13769648: [mptcp-next,v2] Squash to "selftests/bpf: Add mptcp subflow
subtest":
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/d3b644bf82543591f2f59b37d1c1b26a2b9f88e0.1724145512.git.tanggeliang@kylinos.cn/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Matthieu Baerts
(NGI0), Yue Haibing):

13665648: [bpf-next,v2,1/8] selftests/bpf: Add unshare_netns helper
13665649: [bpf-next,v2,2/8] selftests/bpf: Use unshare_netns helper
13665650: [bpf-next,v2,3/8] selftests/bpf: Drop duplicate create_netns
13665651: [bpf-next,v2,4/8] selftests/bpf: Export create_netns helper
13665652: [bpf-next,v2,5/8] selftests/bpf: Use create_netns helper
13665653: [bpf-next,v2,6/8] selftests/bpf: Export cleanup_netns helper
13665654: [bpf-next,v2,7/8] selftests/bpf: Use cleanup_netns helper
13665655: [bpf-next,v2,8/8] selftests/bpf: Use netns helpers in lwt tests:
    - Series: add netns helpers
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=853539&state=*&archive=both
    - Geliang is currently not allowed to send patches to the BPF ML for
the moment despite all the fixes he recently sent... This series can wait.

13689188: [RESEND,v2] checkpatch: skip warnings for symbol links:
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/dc502b1b45cb27fda48d72d73e3267a32db023d8.1717722648.git.tanggeliang@kylinos.cn/

13753375: [bpf-next,v4,1/2] selftests/bpf: Add mptcp subflow example
13753376: [bpf-next,v4,2/2] selftests/bpf: Add mptcp subflow subtest:
    - Series: selftests/bpf: new MPTCP subflow subtest
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=876648&state=*&archive=both

13765873: [-next] mptcp: Remove unused declaration mptcp_sockopt_sync():
    - Submitter: Yue Haibing
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240816100404.879598-1-yuehaibing@huawei.com/


    our repo (by: Gang Yan, Geliang Tang, Gregory Detal, Matthieu
Baerts, Matthieu Baerts (NGI0)):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
    - State: Changes requested
    - Series: BPF redundant scheduler, part 3
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
    - status: same

13305089: [mptcp-next,1/6] mptcp: sockopt: move tcp_inq code to a
dedicated function
13305091: [mptcp-next,2/6] mptcp: sockopt: update supported list
13305093: [mptcp-next,3/6] mptcp: sockopt: get val in a generic way
13305090: [mptcp-next,4/6] mptcp: sockopt: add missing getsockopt() options
13305094: [mptcp-next,5/6] mptcp: sockopt: set val in a generic way
13305092: [mptcp-next,6/6] mptcp: sockopt: support IP_TTL &
IPV6_UNICAST_HOPS:
    - State: Changes requested
    - Series: mptcp: sockopt: uniform code to get/set values
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=763505&state=*&archive=both
    - status: same

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
    - status: same

13656189: [mptcp-net,v2] mptcp: fix the default value of scaling_ratio:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn/
    - status: same

13675217: [mptcp-next,RFC,1/4] mptcp: add push sched callback
13675218: [mptcp-next,RFC,2/4] mptcp: use new push callback to schedule
chunks
13675219: [mptcp-next,RFC,3/4] mptcp: bpf: allow to write to
mptcp_sched_chunk
13675220: [mptcp-next,RFC,4/4] selftests/bpf: mptcp RR: send 1 MSS on
each subflow:
    - State: RFC
    - Series: mptcp: update scheduler API
    - Submitter: Gregory Detal
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=856158&state=*&archive=both
    - TODO: Matth: check with Gregory

13729347: [mptcp-next,1/3] mptcp: add mptcp_snd_nxt helper
13729348: [mptcp-next,2/3] Squash to "bpf: Export more bpf_burst related
functions"
13729349: [mptcp-next,3/3] Squash to "selftests/bpf: Add bpf_burst
scheduler":
    - State: Changes requested
    - Series: get msk->snd_nxt with READ_ONCE
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=870130&state=*&archive=both
    - status: same

13750069: [mptcp-next,1/4] selftests: mptcp: add cfg_timeo for mptcp_connect
13750070: [mptcp-next,2/4] selftests: mptcp: add io thread mode for
mptcp_connect
13750071: [mptcp-next,3/4] selftests: mptcp: enable io thread mode
13750072: [mptcp-next,4/4] selftests: mptcp: join: add io thread tests:
    - State: Changes requested
    - Series: add io thread mode tests
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=875830&state=*&archive=both
    - status: same

13750754: [net-next] tcp: limit wake-up for crossed SYN cases with SYN-ACK:
    - State: Rejected
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240801-upstream-net-next-20240801-tcp-limit-wake-up-x-syn-v1-1-3a87f977ad5f@kernel.org/
    - this part is not tested, best not to break stuff (if it is not
already broken)

13765952: [mptcp-net,v2,02/12] Squash to "selftests: mptcp: join: check
removing ID 0 endpoint"
13765954: [mptcp-net,v2,04/12] Squash to "mptcp: pm: reuse ID 0 after
delete and re-add"
13765956: [mptcp-net,v2,06/12] mptcp: pm: do not remove already closed
subflows
13765957: [mptcp-net,v2,07/12] mptcp: pm: fix ID 0 endp usage after
multiple re-creations
13765958: [mptcp-net,v2,08/12] selftests: mptcp: join: check
re-re-adding ID 0 endp
13765959: [mptcp-net,v2,09/12] mptcp: avoid duplicated SUB_CLOSED events
13765960: [mptcp-net,v2,10/12] selftests: mptcp: join: validate event
numbers
13765961: [mptcp-net,v2,11/12] mptcp: pm: ADD_ADDR 0 is not a new address
13765962: [mptcp-net,v2,12/12] selftests: mptcp: join: check
re-re-adding ID 0 signal:
    - State: New
    - Series: mptcp: pm: fix re-re-create the ID 0 endpoint
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=880310&state=*&archive=both
    - hopefully the last big batch. Mat will look at that.

13766743: [bpf-next,1/2] selftests: bpf: use KHDR_INCLUDES for the UAPI
headers
13766744: [bpf-next,2/2] selftests: bpf: remove duplicated UAPI if_xdp
headers:
    - State: Changes requested
    - Series: selftests: bpf: avoid duplicated UAPI headers
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=880440&state=*&archive=both
    - initially rejected by Alexei, but probably because of misunderstanding
    - Matth replied, and fix their BPF CI, no news so far

13770733: [mptcp-next] bpf: Allow error injection for
update_socket_protocol:
    - State: Awaiting upstream
    - Submitter: Gang Yan
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/tencent_48C13AF02833651C8CEA9329191D76628207@qq.com/
    - looks good, but more up to the netdev / bpf maintainers to state
on that

13770975: [mptcp-next,v2] selftests/bpf: Add getsockopt to inspect mptcp
subflow:
    - State: New
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/b408bd6c62d50c91e02b995c1a09aae9d2fc619e.1724226530.git.tanggeliang@kylinos.cn/
    - we probably need to remove the 'ss' part. Not sure if Martin will
review it before we send it upstream.

13771264: [mptcp-next,1/3] selftests: mptcp: lib: add time per subtests
in TAP output
13771265: [mptcp-next,2/3] sefltests: mptcp: connect: remote time in TAP
output
13771266: [mptcp-next,3/3] selftests: mptcp: reset the last TS before
the first test:
    - State: New
    - Series: selftests: mptcp: add time per subtests in TAP output
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=881720&state=*&archive=both
    - mainly to add the time there:
https://netdev.bots.linux.dev/contest.html



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 513):

  514  Add MIB counters for fallback to TCP in the middle of a
connection [enhancement]:
      - linked to a discussion we had at the last meeting

    Recently discussed:

  513  [syzbot] WARNING in `__mptcp_move_skbs_from_subflow` [bug]
[syzkaller]:
      - mainly fixed, but there still some cases where it is not an
issue, a MIB counter would be better than a warning

  512  Primary flow re-establishes as a subflow but immediately closes
[bug] @matttbe
  501  Why do endpoint tcp connections close? [bug] [feedback-needed]
  416  No new subflow when removing an endpoint and adding a new one
[bug] [feedback-needed]


    Bugs (opened, flagged as "bug" and assigned)

  512  Primary flow re-establishes as a subflow but immediately closes
[bug] @matttbe
  487  `send()` fails with `EAGAIN` in blocking IO mode [bug]
[selftests] [sched] @geliangtang
  477  Client: fallback to TCP after X MPC [bug] @matttbe
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  513  [syzbot] WARNING in `__mptcp_move_skbs_from_subflow` [bug]
[syzkaller]
  508  Divide error on device removal [bug] [feedback-needed]
  505  Subflows won't be used when the interface for the main flow is a
subinterface [bug] [feedback-needed]
  501  Why do endpoint tcp connections close? [bug] [feedback-needed]
  499  selftests: `mptcp_connect.sh`: disconnect test timed out [bug]
[selftests]
  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement
`add_addr_accepted` [bug] [pm]
  495  [syzkaller] KASAN: slab-use-after-free Read in
`__inet6_lookup_established` [bug] [syzkaller]
  494  [syzkaller] WARNING in `__skb_flow_dissect` [bug] [syzkaller]
  492  userspace pm: subflows counter: not updated when a subflows is
removed from the other end [bug]
  491  selftests: `mptcp_join`: tests `Infinite map` & `MP_FAIL MP_RST`
are unstable [bug] [selftests]
  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf]
  483  [6.1] selftests: `mptcp_connect.sh` failures with
`copyfd_io_poll: poll timed out` errors [bug] [selftests]
  476  packetdrill: coalescing feature doesn't take into account MPTCP
options [bug] [packetdrill]
  475  `simult_flows`: unbalanced bwidth tests are unstable [bug]
[selftests]
  439  mptcp vs net.ipv4.tcp_shrink_window [bug]
  416  No new subflow when removing an endpoint and adding a new one
[bug] [feedback-needed]
  336  Issues with BPF packet scheduler [bug] [sched] [bpf]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose
server test` are sometimes failing [bug] [selftests]
  315  Issues with backup flow [bug]


    In Progress (opened, new feature and assigned)

  480  MPTCP and KTLS support [enhancement] @geliangtang
  434  in-kernel PM: increase subflows limit [enhancement] [pm] @matttbe
  353  sockopt: uniform code to get/set values [enhancement] @matttbe
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang
   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang


    Assigned Questions (opened, questions and assigned)

None.


    Open questions (opened, questions and not assigned)

  502  Question for ip-mptcp command [question]
  489  IPv6 Rejoin Subflow [question]
  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned)

  514  Add MIB counters for fallback to TCP in the middle of a
connection [enhancement]
  511  Add MIB counters for sent `MPTCP_RST_EMPTCP` [enhancement]
  503  in-kernel PM: use endpoints only to create subflows with received
`ADD_ADDR` [enhancement] [pm]
  497  in-kernel PM: check to create new subflows when some are
destroyed [enhancement] [pm]
  496  in-kernel PM: store received `ADD_ADDR` [enhancement] [pm]
  481  remove refcount on TCP sockets for the timers [enhancement]
  469  CI: add code coverage support [enhancement] [CI]
  467  Scheduler: add redundant scheduler support in BPF [enhancement]
[sched]
   462  selftests: print (and set?) random seed [enhancement] [selftests]
  461  Protocol: extend Data-Level Length field [enhancement] [protocol]
  448  Allow sending ADD_ADDR IPv6 with port-number if TCP-timestamps
are enabled [enhancement]
  441  optimize established options generation [enhancement]
  440  in-kernel PM: re-establish subflows after "network" errors
[enhancement] [pm]
  426  selftests: validate listener sockets with multiple accepts
[enhancement] [selftests]
  397  Doc and guidance for users [enhancement] [documentation]
  396  ci: periodically run selftests from the export branch on stable
kernels [enhancement] [selftests]
  389  packetdrill: increase coverage for "early `close()`" cases
[enhancement] [packetdrill]
  350  scheduler: API changes (tasks) [enhancement] [sched]
  348  scheduler: frequently probe "stale" subflow with reinjected data
[enhancement] [sched]
  345  scheduler: "penalise" some subflows by sending less than their
cwnd [enhancement] [sched]
  344  scheduler: new callback to initiate optimisations [enhancement]
[sched]
  337  in-kernel PM: listen socket: support "behind a NAT" use case
[enhancement] [pm]
  335  Server to Client subflows: option to allow joining the initial
address and port [enhancement] [pm]
  334  in-kernel PM: send >1 ADD_ADDR before the establishment of a new
subflow [enhancement] [pm]
  333  New MIBs to help understanding issues when PM cannot create new
subflows [enhancement] [pm]
  332  scheduler: implement a "opportunistic retransmission"
[enhancement] [sched]
  298  CG Memory accounting for passive MPTCP socket [enhancement]
  289  mptcp: audit comments for non inclusive language [enhancement]
  273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement] [packetdrill]
  266  Packetdrill: add MP_FAIL coverage [packetdrill]
  236  Review supported sockopts list [enhancement]
  222  Netlink event API: add SUBFLOW_CREATED event [enhancement]
  215  TCP Urgent pointer and MPTCP [enhancement]
  213  add MPTCP man page [enhancement]
  208  better handing of ssk memory pressure in the TX path [enhancement]
  202  Add sendmsg support for ancillary data [enhancement]
  197  more mibs needed [enhancement]
  180  Get an update when MPTCP fall back to TCP [enhancement]
  177  improve retransmit subflow selection [enhancement]
  169  packetdrill: add coverage for ADD_ADDR and MP_JOIN on a different
port [enhancement] [packetdrill]
  150  remove completely workqueue usage [enhancement]
  141  avoid acquiring mptcp_data_lock() twice in the receive path
[enhancement]
   78  notify the application (userspace) when a subflow is
added/removed [enhancement]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 20240807)

  509  Add MIB counters for sent MPJ [enhancement] @matttbe
  506  Cannot create backup subflows to remote endpoints? [bug]
[feedback-needed]


    Packetdrill PRs

  154  20 days ago  matttbe   mptcp: close one SF, expect a FIN back:
      - the fix has been applied on the kernel side, can be reviewed and
applied now

  153  20 days ago  matttbe   mptcp: tfo: inject DFIN without delay:
      - small fix

  52   2 years ago  dcaratti  Add initial coverage for RM_ADDR


    mptcp.dev PRs: /

    mptcpd PRs

  297  14 days ago   marco-a-itl    make listening socket creation
optional for userspace path manager plugins:
      - TODO: check with Ossama if he can have a quick look → request sent

  192  3 months ago  ossama-othman  Test mptcpize
  56   3 months ago  ossama-othman  Add standalone mptcpd plugin example



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.12):
https://github.com/orgs/multipath-tcp/projects/10
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees: /


    - Fixes for -net:

        - [818dda162d99] mptcp: pm: reuse ID 0 after delete and re-add
(Matthieu Baerts (NGI0))
        - [8a95261f6716] mptcp: pm: fix RM_ADDR ID for the initial
subflow (Matthieu Baerts (NGI0))
        - [f48da286dc99] selftests: mptcp: join: check removing ID 0
endpoint (Matthieu Baerts (NGI0))
        - [f9f07908ceca] mptcp: pm: send ACK on an active subflow
(Matthieu Baerts (NGI0))
        - [603df8b2b962] mptcp: pm: skip connecting to already
established sf (Matthieu Baerts (NGI0))
        - [2c785d0afb1c] mptcp: pm: reset MPC endp ID when re-added
(Matthieu Baerts (NGI0))
        - [46076a0dd578] selftests: mptcp: join: check re-adding init
endp with != id (Matthieu Baerts (NGI0))
        - [bba83ed0beee] selftests: mptcp: join: no extra msg if no
counter (Matthieu Baerts (NGI0))
        - [c5e0aac15075] mptcp: close subflow when receiving TCP+FIN
(Matthieu Baerts (NGI0))
        - [bb0d07bc49f2] selftests: mptcp: join: cannot rm sf if closed
(Matthieu Baerts (NGI0))
        - [5b28d5265732] mptcp: sched: check both backup in retrans
(Matthieu Baerts (NGI0)):
            - Can be sent when the two last squash-to patches will need
to be applied first

        - [a1b2e608db06] mptcp: pr_debug: add missing \n at the end
(Matthieu Baerts (NGI0)):
            - TODO: can be sent separately?

    - Fixes for net-next:


    - Features for net-next:

        - [33228552e8a9] selftests: mptcp: join: simplify checksum_tests
(Geliang Tang)
        - [3ddfdc390f8c] mptcp: pm: rename helpers linked to 'flush'
(Matthieu Baerts (NGI0))
        - [9eb17a8aa6b8] mptcp: pm: reduce entries iterations on connect
(Matthieu Baerts (NGI0))
        - [880900786a6c] mptcp: MIB counters for sent MP_JOIN (Matthieu
Baerts (NGI0))
        - [9211899b62b7] selftests: mptcp: join: reduce join_nr params
(Matthieu Baerts (NGI0))
        - [55b0806bc00c] selftests: mptcp: join: one line for join check
(Matthieu Baerts (NGI0))
        - [51f20af8dee2] selftests: mptcp: join: validate MPJ SYN TX MIB
counters (Matthieu Baerts (NGI0))
        - [4d8a523a7389] selftests: mptcp: join: more explicit check
name (Matthieu Baerts (NGI0))
        - [5a3b8f71e79d] selftests: mptcp: join: specify host being
checked (Matthieu Baerts (NGI0))
        - [4051b1279653] selftests: mptcp: join: mute errors when ran in
the background (Matthieu Baerts (NGI0))
        - [06c64a4c4a18] selftests: mptcp: pm_nl_ctl: remove
re-definition (Matthieu Baerts (NGI0))
        - [7dc2977c5342] mptcp: pm: send ACK on non stale subflows
(Matthieu Baerts (NGI0))

    - Features for net-next (next):


    - Features for other trees:

        - [09fcb3b6b287] mptcp: add sched_data helpers (Geliang Tang)
        - [c986adbd711d] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [4a76986d4f97] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [936731d3259a] selftests/bpf: Add mptcp subflow example
(Nicolas Rybowski)
        - [bc2940b49fc3] selftests/bpf: Add mptcp pm_nl_ctl link
(Geliang Tang)
        - [a5f4ccccc2da] selftests/bpf: Add mptcp subflow subtest
(Geliang Tang)
        - [021dae9678e8] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [78f9f18b5c58] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [67c0c94cd676] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [8aa7287d8634] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [6b0929fd0e14] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [095d64f96d92] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [94d057c95b6e] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang)



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - Packetdrill (Davide):
        - 2 PRs to review

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp
        - looks OK, some known issues



Middle boxes stripping MPTCP options in data segments:
     - Seen in some countries, e.g. Italy, Danemark
     - The server reset the connection instead of doing a fallback
     - *@Christoph* will provide more details (and packetdrill tests?)



More iOS apps with MPTCP:
     - by Anthony who did a demo app and opened a few PR
     - https://github.com/mptcp-apps/mptcp-ios-example



Next meeting:
    - Next one on Wednesday, the 28th of August.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240828



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.

