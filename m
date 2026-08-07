Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14DEBA3D
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786125308; cv=none; b=tMvymz9YHgDYlSZIijALGCzT+tVJy/UK6E5aZg4g0Xk+6Ih/RQBVW+kUGf8xSDl0iVDexPZbthPDsPQXU7rer/eTXs+ot06Nwg7Vg+945XA0OptflXCgKImx1ZTFiu3Lnnp13/EEkPEYu46lfliYWYQF2zdeJp0tzGM8TO2OqNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786125308; c=relaxed/simple;
	bh=1jLoZ8IK+3MWdxkQ53fq+cT95o82SGFIAK2CPB33swc=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=pVtxWITQsTdlfZMBEzJuL2dCuUA+RyLlZimFju0aDsTljC+FaE7JVYW9poEdhxTCh6Z/Nw4SzWGnnyJ31+yiNA+c3dLeVK8bQ/IP8H1tWSIYLjk3ZSuWEfByyB8VVIXY3/FcerT/eANbK7SLAOsOASqSBV6t9Oz/2g8wbEAj4LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fz5erTLU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fz5erTLU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA381F000E9
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 17:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786125305;
	bh=j+LR7csjKW2laMoNANdfD0xlWdhCYZzSJI2rMMEdO/A=;
	h=Date:From:To:Subject;
	b=Fz5erTLU+lvZeO8hPWMcvyEvP8iWP2iTlorO6bTfyLwmr7jYsbmCUz0ENkJScDQve
	 UrscdFF7JscEy8iUlFtr90RBBfTkNiJ0joqAWZBZ3JUn5LxL3ejm3zgaHtXOCUctdF
	 bVJyMBn1x45PSTwU9MYbnV8UE1ahkGMLOgX9ASZ5cQMiIoMD/kxQp56NGkET0RNq77
	 36YNJ1Z+bsmNN+20knZm+mynmN+0odNwMiXlkQjTz3IS5XijrrG4TejAE6a+NA/5PT
	 XHzsJasLzSz/EOXz7n54y/1jIidkkjrv7ivsbEhA58zfrZJnN09gTXK2JTwkaQxIH1
	 tQdHwiWzBiTlw==
Message-ID: <a3c7bdc8-7884-4dfe-b7f4-1a97fea57f59@kernel.org>
Date: Fri, 7 Aug 2026 19:55:03 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: fr
To: MPTCP Linux <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 22nd of April 2026
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

A few weeks ago, we had a meeting with Mat (Cruise), and myself
(NGI0 Core).


Thanks again for this new good meeting!


Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: David CARLIER, Jiayuan Chen, Matthieu Baerts):

14512596: [net,v2] mptcp: fix slab-use-after-free in __inet_lookup_established:
    - Submitter: Jiayuan Chen
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260406031512.189159-1-jiayuan.chen@linux.dev/

14513952: [net,v2] Revert "mptcp: add needs_id for netlink appending addr":
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260407-net-mptcp-revert-pm-needs-id-v2-1-7a25cbc324f8@kernel.org/

14513956: [net-next,v2,1/2] mptcp: better mptcp-level RTT estimator
14513957: [net-next,v2,2/2] mptcp: add receive queue awareness in tcp_rcv_space_adjust():
    - Series: mptcp: autotune related improvement
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1078013&state=*&archive=both

14514689: [v4,net-next] net: use get_random_u{16,32,64}() where appropriate:
    - Submitter: David CARLIER
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260407150758.5889-1-devnexen@gmail.com/


    our repo (by: Gang Yan):

14521024: [mptcp-net,v4,1/2] mptcp: sync the msk->sndbuf at accept() time
14521025: [mptcp-net,v4,2/2] selftests: mptcp: add a check for sndbuf of S/C:
    - Series: mptcp: sync the msk->sndbuf at accept() time
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1080031&state=*&archive=both

14530420: [mptcp-net] mptcp: sockopt: set timestamp flags on subflow socket, not msk:
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260420093343.16443-1-gang.yan@linux.dev/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Matthieu Baerts, Ren Wei, Shardul Bankar, Li Xiasong):

14509844: [5.15.y] MPTCP: fix lock class name family in pm_nl_create_listen_socket:
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260402174200.3474039-2-matttbe@kernel.org/

14525200: [net,1/1] mptcp: hold subflow request owners when cloning reqsk:
    - Series: [net,1/1] mptcp: hold subflow request owners when cloning reqsk
    - Submitter: Ren Wei
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1081484&state=*&archive=both
    - v2 expected

14530439: [v2] selftests: harness: fix pidfd leak in __wait_for_test:
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/a82e275ccfb2609a1984d90ab559fa3af78f1e81.1776678050.git.tanggeliang@kylinos.cn/

14531150: [net,1/2] mptcp: sync the msk->sndbuf at accept() time
14531151: [net,2/2] selftests: mptcp: add a check for sndbuf of S/C:
    - Series: mptcp: sync the msk->sndbuf at accept() time
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1083422&state=*&archive=both

14533993: [v2] mptcp: do not drop partial packets:
    - Submitter: Shardul Bankar
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260422143931.43281-1-shardul.b@mpiricsoftware.com/
    - v2 sent to netdev, too quickly + commit sha are not in net trees → TODO Matth: reply → done

14529269: [RFC,net] mptcp: pm: fix ADD_ADDR timer infinite retry on option space insufficient:
    - State: New
    - Submitter: Li Xiasong
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260418100018.2219500-1-lixiasong1@huawei.com/
    - reviewed, looks good, but v2 needed


    our repo (by: Christoph Paasch, David CARLIER, Gang Yan, Geliang Tang, Gregory Detal, Matthieu Baerts, Paolo Abeni, Shardul Bankar):

12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
    - State: Changes requested
    - Series: BPF redundant scheduler, part 3
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
    - Status: same as last time

13305089: [mptcp-next,1/6] mptcp: sockopt: move tcp_inq code to a dedicated function
13305091: [mptcp-next,2/6] mptcp: sockopt: update supported list
13305093: [mptcp-next,3/6] mptcp: sockopt: get val in a generic way
13305090: [mptcp-next,4/6] mptcp: sockopt: add missing getsockopt() options
13305094: [mptcp-next,5/6] mptcp: sockopt: set val in a generic way
13305092: [mptcp-next,6/6] mptcp: sockopt: support IP_TTL & IPV6_UNICAST_HOPS:
    - State: Changes requested
    - Series: mptcp: sockopt: uniform code to get/set values
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=763505&state=*&archive=both
    - Status: same as last time

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
    - Status: same as last time

13675217: [mptcp-next,RFC,1/4] mptcp: add push sched callback
13675218: [mptcp-next,RFC,2/4] mptcp: use new push callback to schedule chunks
13675219: [mptcp-next,RFC,3/4] mptcp: bpf: allow to write to mptcp_sched_chunk
13675220: [mptcp-next,RFC,4/4] selftests/bpf: mptcp RR: send 1 MSS on each subflow:
    - State: RFC
    - Series: mptcp: update scheduler API
    - Submitter: Gregory Detal
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=856158&state=*&archive=both
    - Status: same as last time

13932555: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
13932556: [2/3] selftests: mptcp: relax conditions in SYN_TX validation
13932546: [3/3] selftests: mptcp: add a testcase for invalid addr timeout:
    - State: Changes requested
    - Series: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=923771&state=*&archive=both
    - Status: same as last time

14024767: [mptcp-next,v1,1/4] bpf: Add mptcp path manager struct_ops
14024768: [mptcp-next,v1,2/4] bpf: Export mptcp path manager kfuncs
14024769: [mptcp-next,v1,3/4] selftests/bpf: Add mptcp netlink pm subtest
14024770: [mptcp-next,v1,4/4] selftests/bpf: Add mptcp bpf_netlink pm subtest:
    - State: Changes requested
    - Series: BPF path manager, part 7
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=946095&state=*&archive=both
    - Status: same as last time

14167004: [mptcp-next] mptcp: remove redundant orig_offset in carve_data_frag:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/patch/9c663fc37767d9036379afdbc83cd8874a7b2fc9.1753337130.git.tanggeliang@kylinos.cn/
    - Status: same as last time

14175678: [mptcp-next,1/2] mptcp: Add support for SO_MAX_PACING_RATE
14175679: [mptcp-next,2/2] selftests: Add tests for SO_MAX_PACING_RATE:
    - State: Changes requested
    - Series: mptcp: Add support for SO_MAX_PACING_RATE
    - Submitter: Christoph Paasch
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=987909&state=*&archive=both
    - Status: same as last time

14185125: [mptcp-next,1/6] mptcp: add helper for setsockopt on first subflow only
14185126: [mptcp-next,2/6] mptcp: handle SOL_SOCKET options on first subflow only
14185128: [mptcp-next,3/6] mptcp: refactor IP socket option handling for first subflow
14185127: [mptcp-next,4/6] mptcp: extract IPv6 socket option handling for first subflow
14185129: [mptcp-next,5/6] mptcp: handle SOL_TCP options on all subflows
14185130: [mptcp-next,6/6] mptcp: handle IP socket options on all subflows:
    - State: Needs ack
    - Series: refactor MPTCP socket option handling
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=990414&state=*&archive=both
    - Status: same as last time

14185142: [mptcp-next,v2,1/3] mptcp: add IPV6_TCLASS socket option support
14185143: [mptcp-next,v2,2/3] mptcp: add IP_TTL socket option support
14185144: [mptcp-next,v2,3/3] mptcp: add IPV6_UNICAST_HOPS socket option support:
    - State: Needs ack
    - Series: mptcp: add more sockopts
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=990418&state=*&archive=both
    - Status: same as last time

14197780: [mptcp-next,v2,01/10] selftests: mptcp: sockopt: improve test output clarity
14197781: [mptcp-next,v2,02/10] selftests: mptcp: sockopt: add SO_REUSEADDR test helper
14197782: [mptcp-next,v2,03/10] selftests: mptcp: sockopt: add SO_REUSEPORT test
14197783: [mptcp-next,v2,04/10] selftests: mptcp: sockopt: add SO_BINDTODEVICE test
14197784: [mptcp-next,v2,05/10] selftests: mptcp: sockopt: add SO_BINDTOIFINDEX test
14197785: [mptcp-next,v2,06/10] selftests: mptcp: sockopt: add IP_FREEBIND tests
14197786: [mptcp-next,v2,07/10] selftests: mptcp: sockopt: add IP_TRANSPARENT tests
14197787: [mptcp-next,v2,08/10] selftests: mptcp: sockopt: add IP_BIND_ADDRESS_NO_PORT test
14197788: [mptcp-next,v2,09/10] selftests: mptcp: sockopt: add IP_LOCAL_PORT_RANGE test
14197789: [mptcp-next,v2,10/10] selftests: mptcp: sockopt: add IPV6_V6ONLY test:


14529269: [RFC,net] mptcp: pm: fix ADD_ADDR timer infinite retry on option space insufficient:
    - State: New
    - Submitter: Li Xiasong
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260418100018.2219500-1-lixiasong1@huawei.com/
    - reviewed, looks good, but v2 needed
    - State: Changes requested
    - Series: selftests: cover more MPTCP socket options
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=993905&state=*&archive=both
    - Status: same as last time

14215849: [mptcp-net,v2,1/3] selftests: mptcp: close server file descriptor
14215850: [mptcp-net,v2,2/3] selftests: mptcp: close IPC descriptor on server side
14229120: [mptcp-next,v4,1/9] selftests: mptcp: sockopt: replace /dev/urandom with getrandom
14229121: [mptcp-next,v4,2/9] selftests: mptcp: sockopt: add protocol arguments
14229122: [mptcp-next,v4,3/9] selftests: mptcp: sockopt: add inq argument
14229123: [mptcp-next,v4,4/9] selftests: mptcp: sockopt: rename pipefd to ipcfd
14229124: [mptcp-next,v4,5/9] selftests: mptcp: sockopt: set TCP_INQ sockopt
14229125: [mptcp-next,v4,6/9] selftests: mptcp: sockopt: handle INQ on server side
14229126: [mptcp-next,v4,7/9] selftests: mptcp: sockopt: handle INQ on client side
14229127: [mptcp-next,v4,8/9] selftests: mptcp: sockopt: replace mptcp_inq with sockopt
14229128: [mptcp-next,v4,9/9] selftests: mptcp: sockopt: remove obsolete mptcp_inq:
    - State: Changes requested
    - Series: selftests: consolidate TCP_INQ testing into sockopt
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1001827&state=*&archive=both
    - Status: same as last time

14332026: [RFC,mptcp-next] mptcp: support net.ipv4.tcp_rcvbuf_low_rtt:
    - State: Changes requested
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20251127-mptcp-tcp_rcvbuf_low_rtt-v1-1-fa080d67f2e5@kernel.org/
    - Status: same as last time

14413156: [mptcp-net,1/3] mptcp: add backlog_list bug reproducer test
14413157: [mptcp-net,2/3] mptcp: fix receive stalls when 'ack_seq' in backlog_list
14478733: [RESEND,mptcp-next,v2,1/3] tcp: export do_tcp_splice_eof
14478734: [RESEND,mptcp-next,v2,2/3] mptcp: implement .splice_eof
14478735: [RESEND,mptcp-next,v2,3/3] selftests: mptcp: connect: trigger splice_eof:
    - State: Changes requested
    - Series: implement .splice_eof
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1067870&state=*&archive=both
    - Status: same as last time

14478884: [mptcp-net,v2] mptcp: fix data-race in __mptcp_retrans / mptcp_incoming_options:
    - State: Queued
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260317-mptcp-data-race-snd_una-v2-1-2caac60de92a@kernel.org/
    - Status: same as last time

14481348: [mptcp-next,v3,1/2] mptcp: implement psock_update_sk_prot
14481349: [mptcp-next,v3,2/2] selftests/bpf: Update sockmap tests for MPTCP:
    - State: Changes requested
    - Series: implement psock_update_sk_prot
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1068551&state=*&archive=both
    - Status: same as last time

14506449: [mptcp-net,v5,1/5] mptcp: replace backlog_list with backlog_queue
14506450: [mptcp-net,v5,2/5] mptcp: fix the stall problems using backlog_queue
14506451: [mptcp-net,v5,3/5] mptcp: fix the stall problems with data_ready
14506452: [mptcp-net,v5,4/5] mptcp: fix the dead_lock in mptcp_data_ready
14506453: [mptcp-net,v5,5/5] selftests: mptcp: test transmission with small rcvbuf:
    - State: Needs ack
    - Series: mptcp: fix stall because of data_ready
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1075676&state=*&archive=both
    - Replaced by Paolo's series

14507171: [RFC,mptcp-next,v8,1/7] nvmet-tcp: define target tcp_proto struct
14507172: [RFC,mptcp-next,v8,2/7] nvmet-tcp: register target mptcp transport
14507173: [RFC,mptcp-next,v8,3/7] nvmet-tcp: implement target mptcp proto
14507174: [RFC,mptcp-next,v8,4/7] nvme-tcp: define host tcp_proto struct
14507175: [RFC,mptcp-next,v8,5/7] nvme-tcp: register host mptcp transport
14507176: [RFC,mptcp-next,v8,6/7] nvme-tcp: implement host mptcp proto
14507177: [RFC,mptcp-next,v8,7/7] selftests: mptcp: add NVMe over MPTCP test:
    - State: Needs ack
    - Series: NVME over MPTCP
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1075844&state=*&archive=both
    - Status: same as last time

14525252: [mptcp-net,v5,01/20] mptcp: pm: kernel: correctly retransmit ADD_ADDR ID 0
14525253: [mptcp-net,v5,02/20] mptcp: pm: ADD_ADDR rtx: fix potential data-race
14525254: [mptcp-net,v5,03/20] mptcp: pm: ADD_ADDR rtx: allow ID 0
14525255: [mptcp-net,v5,04/20] mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
14525256: [mptcp-net,v5,05/20] mptcp: pm: ADD_ADDR rtx: free sk if last
14525257: [mptcp-net,v5,06/20] mptcp: pm: ADD_ADDR rtx: resched blocked ADD_ADDR quicker
14525258: [mptcp-net,v5,07/20] mptcp: pm: ADD_ADDR rtx: skip inactive subflows
14525259: [mptcp-net,v5,08/20] mptcp: pm: retrans ADD_ADDR: return early if no retrans
14525260: [mptcp-net,v5,09/20] mptcp: pm: prio: skip closed subflows
14525261: [mptcp-net,v5,10/20] selftests: mptcp: check output: catch cmd errors
14525262: [mptcp-net,v5,11/20] selftests: mptcp: pm: restrict 'unknown' check to pm_nl_ctl
14525263: [mptcp-net,v5,12/20] mptcp: pm: in-kernel: explicitly limit batches to array size
14525264: [mptcp-net,v5,13/20] mptcp: pm: in-kernel: increase all limits to 64
14525265: [mptcp-net,v5,14/20] mptcp: pm: kernel: allow flushing more than 8 endpoints
14525266: [mptcp-net,v5,15/20] mptcp: pm: in-kernel: increase endpoints limit
14525267: [mptcp-net,v5,16/20] selftests: mptcp: join: allow changing ifaces nr per test
14525268: [mptcp-net,v5,17/20] selftests: mptcp: join: validate 8x8 subflows
14525269: [mptcp-net,v5,18/20] selftests: mptcp: pm: validate new limits
14525270: [mptcp-net,v5,19/20] selftests: mptcp: pm: use simpler send/recv forms
14525271: [mptcp-net,v5,20/20] mptcp: pm: clearer ADD_ADDR related helpers names:
    - State: Changes requested
    - Series: mptcp: pm: increase limits, and related fixes and cleanup
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1081499&state=*&archive=both
    - TODO: Matth: send v6 with all patches but the refactoring and new ones → done

14529011: [mptcp-next,v4,1/3] mptcp: pm: userspace: drop delete_local_addr helper
14529012: [mptcp-next,v4,2/3] selftests: mptcp: join: update userspace dump_addr outputs
14529013: [mptcp-next,v4,3/3] selftests: mptcp: userspace: send RM_ADDR between server and client:
    - State: New
    - Series: only remove entry from local_addr_list when sending a REMOVE_ADDR
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1082700&state=*&archive=both
    - TODO: review → done

14529050: [RFC,mptcp-next,v15,01/15] tls: add per-protocol cache to support mptcp
14529051: [RFC,mptcp-next,v15,02/15] tls: introduce struct tls_prot_ops
14529052: [RFC,mptcp-next,v15,03/15] tls: add tls_prot_ops pointer to tls_proto
14529053: [RFC,mptcp-next,v15,04/15] mptcp: update mptcp_check_readable
14529054: [RFC,mptcp-next,v15,05/15] mptcp: implement tls_mptcp_ops
14529055: [RFC,mptcp-next,v15,06/15] tls: disable device offload for mptcp sockets
14529056: [RFC,mptcp-next,v15,07/15] mptcp: update ulp getsockopt for tls support
14529057: [RFC,mptcp-next,v15,08/15] mptcp: enable ulp setsockopt for tls support
14529058: [RFC,mptcp-next,v15,09/15] selftests: mptcp: connect: use espintcp for ulp test
14529059: [RFC,mptcp-next,v15,10/15] selftests: tls: add mptcp variant for testing
14529060: [RFC,mptcp-next,v15,11/15] selftests: tls: increase pollin timeouts for mptcp
14529061: [RFC,mptcp-next,v15,12/15] selftests: tls: increase nonblocking data size for mptcp
14529062: [RFC,mptcp-next,v15,13/15] selftests: tls: wait close in shutdown_reuse for mptcp
14529063: [RFC,mptcp-next,v15,14/15] selftests: tls: add mptcp test cases
14529064: [RFC,mptcp-next,v15,15/15] selftests: mptcp: cover mptcp tls tests:
    - State: New
    - Series: MPTCP KTLS support
    - Submitter: Geliang Tang
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1082710&state=*&archive=both
    - To be reviewed
    - Is it still a RFC type series?

14530390: [RESEDN,mptcp-net] mptcp: update window_clamp on subflows when SO_RCVBUF is set:
    - State: New
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260420085613.4650-1-gang.yan@linux.dev/
    - TODO: Matth: review → done

14530482: [RFC,1/6] mptcp: move checks vs rcvbuf size earlier in the RX path
14530486: [RFC,2/6] mptcp: sync mptcp skb cb layout with tcp one
14530483: [RFC,3/6] tcp: expose the tcp_collapse_ofo_queue() helper to mptcp usage, too
14530484: [RFC,4/6] mptcp: implemented OoO queue pruning
14530485: [RFC,5/6] mptcp: refine coalescing conditions
14530487: [RFC,6/6] mptcp: unclone skbs before coalescing them, when needed:
    - State: New
    - Series: mptcp: address stall under memory pressure
    - Submitter: Paolo Abeni
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1083242&state=*&archive=both
    - replacing "mptcp: fix stall because of data_ready", Gang will take over
    - looks important when we are in memory pressure and packets in the OoO queue
    - Selftest from Gang series needed here
    - and/or ideally a packetdrill test

14532336: mptcp: add per-reason MIB counters for MPTCP_RST_EMPTCP resets:
    - State: New
    - Series: mptcp: add per-reason MIB counters for MPTCP_RST_EMPTCP resets
    - Submitter: Shardul Bankar
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1083751&state=*&archive=both
    - TODO: Matth: review: → done
        - selftests
        - one case not set
        - Mat: maybe a helper to set the reason and the MIB counter?

14532727: [mptcp-net] mptcp: fastclose msk when linger time is 0:
    - State: New
    - Submitter: Matthieu Baerts
    - URL: https://patchwork.kernel.org/project/mptcp/patch/20260421-mptcp-fastclose-linger-v1-1-de94d7bffc0a@kernel.org/
    - Reviewed, can be applied

14533173: [mptcp-next,v3,1/3] mptcp: propagate RECVERR sockopts to subflows
14533174: [mptcp-next,v3,2/3] mptcp: support MSG_ERRQUEUE on the parent socket
14533175: [mptcp-next,v3,3/3] selftests: mptcp: cover IP_RECVERR sockopt propagation:
    - State: New
    - Series: mptcp: MSG_ERRQUEUE support on the parent socket
    - Submitter: David CARLIER
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1084059&state=*&archive=both
    - probably some messages needs to be filtered, not to tell the app that there is an issue just because one subflow has been disconnected. Maybe more MPTCP specific messages could be passed somehow (+ new subflows, etc.).

14533469: [mptcp-net,1/2] mptcp: fix scheduling with atomic in timestamp sockopt
14533470: [mptcp-next,2/2] mptcp: use sockopt_lock(release)_sock in sockopt:
    - State: New
    - Series: mptcp: replace lock_sock_fast with sleepable lock
    - Submitter: Gang Yan
    - URL: https://patchwork.kernel.org/project/mptcp/list/?series=1084186&state=*&archive=both
    - maybe the patch 2/2 is also for net? → Needs to check when this helper has been introduced, but likely it should be covered the MPTCP case




Extra, just in case




Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 618):

  621  [syzkaller] WARNING in `inet_sock_destruct`: `atomic_read(&sk->sk_rmem_alloc)` [bug] [syzkaller]:
      - Also happening with TCP, maybe not due to MPTCP?
      - (but some code has been "recently" modified on that side)

  620  [syzkaller] WARNING in `mptcp_pm_alloc_anno_list` [bug] [syzkaller]:
      - Doesn't look like an urgent bug: probably an ADD_ADDR got removed at re-added in //

  619  mptcp: update window_clamp when `SO_RCVBUF` is set [bug]:
      - see patches from Gang ↑


    Recently discussed:

  599  [syzbot] possible deadlock in `mptcp_subflow_create_socket`: `nbd` has a lockdep dependency between `reclaim` and `af_socket` [bug] [syzkaller]:
      - forbid nbd to create MPTCP in-kernel sockets?

  448  Allow sending ADD_ADDR IPv6 with port-number if TCP-timestamps are enabled [enhancement] @matttbe


    Bugs (opened, flagged as "bug" and assigned)

  575  sockopt: support `TCP_MD5SIG` and `TCP_MD5SIG_EXT` for transparent integrations [bug] @geliangtang
  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement `add_addr_accepted` [bug] [pm] @geliangtang
  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf] @geliangtang
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug] [sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  621  [syzkaller] WARNING in `inet_sock_destruct`: `atomic_read(&sk->sk_rmem_alloc)` [bug] [syzkaller]
  620  [syzkaller] WARNING in `mptcp_pm_alloc_anno_list` [bug] [syzkaller]
  619  mptcp: update window_clamp when `SO_RCVBUF` is set [bug]
  600  mptcp: avoid dropping partial packets [bug]
  599  [syzbot] possible deadlock in `mptcp_subflow_create_socket`: `nbd` has a lockdep dependency between `reclaim` and `af_socket` [bug] [syzkaller]
  592  Lower throughput with MPTCP vs TCP [bug]
  587  in-kernel PM: Server is only using single IP to establish subflows [bug]
  583  KMemLeak: from `mptcp_sk_clone_init()` [bug] [selftests]
  581  Default scheduler under-utilizes newly restored subflows on long-lived flows after WAN failback [bug]
  572  [syzkaller] WARNING in `skb_try_coalesce` [bug] [syzkaller]
  549  pm: in-kernel: set `msk->pm.work_pending` back to `true` [bug] [pm]
  492  userspace pm: subflows counter: not updated when a subflows is removed from the other end [bug]
  491  selftests: `mptcp_join`: tests `Infinite map` & `MP_FAIL MP_RST` are unstable [bug] [selftests]
  483  [6.1] selftests: `mptcp_connect.sh` failures with `copyfd_io_poll: poll timed out` errors [bug] [selftests]
  475  `simult_flows`: unbalanced bwidth tests are unstable [bug] [selftests]
  439  mptcp vs net.ipv4.tcp_shrink_window [bug]
  336  Issues with BPF packet scheduler [bug] [sched] [bpf]


    In Progress (opened, new feature and assigned)

  568  socket option: support `IPV6_TCLASS` [enhancement] @geliangtang
  521  Implement psock_update_sk_prot, for eBPF SOCKMAP support [enhancement] [bpf] @geliangtang
  480  MPTCP and KTLS support [enhancement] @geliangtang
  448  Allow sending ADD_ADDR IPv6 with port-number if TCP-timestamps are enabled [enhancement] @matttbe
  434  in-kernel PM: increase subflows limit [enhancement] [pm] @matttbe
  353  sockopt: uniform code to get/set values [enhancement] @matttbe
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched] @geliangtang
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill] @dcaratti
   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang
   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang


    Assigned Questions (opened, questions and assigned)

  548  disable mptcp for an interface [question] @matttbe


    Open questions (opened, questions and not assigned)

  562  [performance] How much is the overhead of MPTCP？ [question]


    For later (opened and not assigned)

  618  `TCP_RTO_MIN`/`MAX`: used configured values if any [enhancement]
  610  MPTCP tree in `linux-next` [enhancement]
  590  in-kernel PM: use either `subflow` or `signal` depending on connector/listener app [enhancement]
  588  in-kernel PM: support NUMA awareness [enhancement] [feedback-needed]
  584  [syzkaller] improve coverage [syzkaller]
  578  sockopt: support `SO_MAX_PACING_RATE` to limit the whole MPTCP connection [enhancement]
  566  pm: use `signal` + `subflow` + `fullmesh` [enhancement] [pm]
  556  Implement all required bits to C/R MPTCP connections from user-space (CRIU) [enhancement]
  552  pm: in-kernel: delay before creating new subflows [enhancement]
  545  Deal with multiple pure TCP ACK without MPTCP options [enhancement]
  543  TCPDump: display `MP_TCPRST` info [enhancement]
  542  in-kernel PM: limit to one subflow per network interface for each connection [enhancement] [pm]
  535  TCPDump: display `MP_CAPABLE` C flag [enhancement]
  525  tests: cover more MPTCP socket options [enhancement] [packetdrill] [selftests]
  519  Reset the connection once "MPTCP has been verified" instead of a fallback [enhancement]
  511  Add MIB counters for sent `MPTCP_RST_EMPTCP` [enhancement]
  497  in-kernel PM: check to create new subflows when some are destroyed [enhancement] [pm]
  496  in-kernel PM: store received `ADD_ADDR` [enhancement] [pm]
  481  remove refcount on TCP sockets for the timers [enhancement]
  467  Scheduler: add redundant scheduler support in BPF [enhancement] [sched]
  462  selftests: print (and set?) random seed [enhancement] [selftests]
  461  Protocol: extend Data-Level Length field [enhancement] [protocol]
  441  optimize established options generation [enhancement]
  440  in-kernel PM: re-establish subflows after "network" errors [enhancement] [pm]
  426  selftests: validate listener sockets with multiple accepts [enhancement] [selftests]
  389  packetdrill: increase coverage for "early `close()`" cases [enhancement] [packetdrill]
  350  scheduler: API changes (tasks) [enhancement] [sched]
  348  scheduler: frequently probe "stale" subflow with reinjected data [enhancement] [sched]
  345  scheduler: "penalise" some subflows by sending less than their cwnd [enhancement] [sched]
  344  scheduler: new callback to initiate optimisations [enhancement] [sched]
  337  in-kernel PM: listen socket: support "behind a NAT" use case  [enhancement] [pm]
  335  Server to Client subflows: option to allow joining the initial address and port [enhancement] [pm]
  334  in-kernel PM: send >1 ADD_ADDR before the establishment of a new subflow [enhancement] [pm]
  332  scheduler: implement a "opportunistic retransmission" [enhancement] [sched]
  289  mptcp: audit comments for non inclusive language [enhancement]
  273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement] [packetdrill]
  266  Packetdrill: add MP_FAIL coverage [packetdrill]
  236  Review supported sockopts list [enhancement]
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement] [packetdrill]
  222  Netlink event API: add SUBFLOW_CREATED event [enhancement]
  215  TCP Urgent pointer and MPTCP [enhancement]
  213  add MPTCP man page [enhancement]
  208  better handing of ssk memory pressure in the TX path [enhancement]
  202  Add sendmsg support for ancillary data [enhancement]
  180  Get an update when MPTCP fall back to TCP [enhancement]
  177  improve retransmit subflow selection [enhancement]
  169  packetdrill: add coverage for ADD_ADDR and MP_JOIN on a different port [enhancement] [packetdrill]
  150  remove completely workqueue usage [enhancement]
  141  avoid acquiring mptcp_data_lock() twice in the receive path [enhancement]
   78  notify the application (userspace) when a subflow is added/removed [enhancement]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 2026-04-08)

  602  A query about the update of 'msk->sk_sndbuf' [bug]


    Packetdrill PRs

  194  6 days ago    Dwyane-Yan   packetdrill: mptcp: add SO_RCVBUF window_clamp test:
      - Matth will look at that

  162  2 months ago  geliangtang  mptcp: add splice test
  52   1 year ago    dcaratti     Add initial coverage for RM_ADDR


    mptcp.dev PRs: /



    mptcp-upstream-virtme-docker PRs: /



    mptcpd PRs: /





FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (7.2): https://github.com/orgs/multipath-tcp/projects/20
    - For later: https://github.com/orgs/multipath-tcp/projects/1
    - ChangeLog has been updated: https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog



Patches to send to NetDev:

    - Fixes for other trees: /


    - Fixes for -net:

        - [e514cf82e760] mptcp: sync the msk->sndbuf at accept() time (Gang Yan)
        - [571d5ec7d37d] selftests: mptcp: add a check for sndbuf of S/C (Gang Yan):
            - sent

        - [7b3128255ae2] mptcp: sockopt: set timestamp flags on subflow socket, not msk (Gang Yan):
            - to be sent on Monday, probably with other ones

    - Fixes for net-next: /


    - Features for net-next:

        - [500ce5b4370b] mptcp: pm: init and release mptcp_pm_ops (Geliang Tang)
        - [c332486b930b] mptcp: pm: add get_local_id() interface (Geliang Tang)
        - [120682a0b8b3] mptcp: pm: add get_priority() interface (Geliang Tang):
            - closed + waiting for pm->lock refatoring

    - Features for net-next (next):


    - Features for other trees:

        - [0e84bd9b1465] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [c5756629a523] selftests/bpf: More endpoints for endpoint_init (Geliang Tang)
        - [49912a0ca539] selftests/bpf: Drop cgroup_fd of run_mptcpify (Geliang Tang)
        - [210b864f5c12] bpf: Add mptcp packet scheduler struct_ops (Geliang Tang)
        - [25c4205ffad6] bpf: Export mptcp packet scheduler helpers (Geliang Tang)
        - [d5aec14c08b5] selftests/bpf: Add bpf scheduler test (Geliang Tang)
        - [6451b3b1c444] selftests/bpf: Add bpf_first scheduler & test (Geliang Tang)
        - [1e67e3ff965d] selftests/bpf: Add bpf_bkup scheduler & test (Geliang Tang)
        - [8f34aa06e34f] selftests/bpf: Add bpf_rr scheduler & test (Geliang Tang)
        - [ef3c03279978] selftests/bpf: Add bpf_red scheduler & test (Geliang Tang)
        - [6abfb48b79aa] selftests/bpf: Add bpf_burst scheduler & test (Geliang Tang):
            - waiting for sched API refactoring




Extra tests:
    - news about Syzkaller? (Matth):
        - found some issues, now the UI is showing to which subsystems an issue is linked to

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp
        - some issues with packetdrill, especially with the debug mode
        - some tests stall, probably a bug in the CPU sched or related, due to Linus' merge window



Next meeting:
    - Every two weeks, on Wednesday.
    - 15:30 UTC (8.30am PST, 5.30pm CEST, 12.30am CST)
    - Still open to everyone!
    - https://github.com/multipath-tcp/mptcp_net-next/wiki/Meetings


Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you soon,
Matt
-- 
Sponsored by the NGI0 Core fund.

