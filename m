Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C2F21D58D
	for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586771; cv=none; b=mVqXbuXZxdqAbirnC55MGOV3piUGHJFALB9ka0yGhjMZfgBSUrWeohc56CkF1z44B04/EKk4sVXZcxyI48h1LuFPV7KXoyCIV6cJPGvBNwCg6Qsnj9VtnLYK1MOkmca8X6MsJ18FfL4rXBWYVkP9Et32NEXP29ozde5mpNqKcaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586771; c=relaxed/simple;
	bh=YNaiX4VXd8TWLGZnLuYsxk362axRJjIC2bSV0cMOxUg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=hgIKqTXkWqv8+3l816/C8frhlUMXbzd7VTnCeYcRdsfr/zHfejMJ8CZIV/Mc07UE1cFZMe8WSGkyI28ikI4ZAarlxcHtgRVpWb0zwWqydTFUaSHI86LfcYbsMwyP0DnrvBNMrolsiKJSJ+euUDh2BVn5Ef2Nn8gQsnr525E4dgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzzkJtH9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzzkJtH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23612C4CED6
	for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 16:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740586771;
	bh=YNaiX4VXd8TWLGZnLuYsxk362axRJjIC2bSV0cMOxUg=;
	h=Date:To:From:Subject:From;
	b=ZzzkJtH9NoRcwoLt6vnDLhrfZJ+kCBaQB4v4su7w/3qn3FowJQPPQu9lrGY4z0faH
	 003EBkxOihDNcI0JXvs/TwpHGjWQoTLD79Bf6Y8HQICh+pRz5c92deLdfIcxxKXYeg
	 LLWuHk8VoDncqvGGLYeaJSsMYeymBQDaKJ/LjbdlkPP6Kd4r3GEqa9ObPTJftZ8vBu
	 /gLgO0HGY6fl5Z5Dze+/3n1B7THIixuLCYOZIf/BV0bNSAGteXyo19P+CYTBHoyoc/
	 LeWuAIatON8T3qMF9ZFoEA/kJD5tLmIOq0PdUbTb7Arglm5mrPaSrmiIwWJwDok7k/
	 mS4EVCcofw+fw==
Message-ID: <aa05375b-148b-4f85-90bd-8b4f89d79200@kernel.org>
Date: Wed, 26 Feb 2025 17:19:26 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
To: MPTCP Linux <mptcp@lists.linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 12th of February 2025
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

Two weeks ago, we had our last meeting with Mat (Cruise), Paolo (Redhat)
and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:


Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13947152: [5.15.y] mptcp: don't always assume copied data in
mptcp_cleanup_rbuf():
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250122111517.3284651-2-matttbe@kernel.org/

13953714: [net,1/2] mptcp: blackhole only if 1st SYN retrans w/o MPC is
accepted
13953715: [net,2/2] doc: mptcp: sysctl: blackhole_timeout is per-netns:
    - Series: mptcp: blackhole only if 1st SYN retrans w/o MPC is accepted
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=929059&state=*&archive=both

13960018: [net] selftests: mptcp: connect: -f: no reconnect:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250204-net-mptcp-sft-conn-f-v1-1-6b470c72fffa@kernel.org/

13965043: [net-next,v3,01/15] mptcp: pm: drop info of
userspace_pm_remove_id_zero_address
13965044: [net-next,v3,02/15] mptcp: pm: userspace: flags: clearer msg
if no remote addr
13965045: [net-next,v3,03/15] mptcp: pm: more precise error messages
13965046: [net-next,v3,04/15] mptcp: pm: improve error messages
13965047: [net-next,v3,05/15] mptcp: pm: userspace: use GENL_REQ_ATTR_CHECK
13965048: [net-next,v3,06/15] mptcp: pm: remove duplicated error messages
13965049: [net-next,v3,07/15] mptcp: pm: mark missing address attributes
13965050: [net-next,v3,08/15] mptcp: pm: use NL_SET_ERR_MSG_ATTR when
possible
13965051: [net-next,v3,09/15] mptcp: pm: make three pm wrappers static
13965052: [net-next,v3,10/15] mptcp: pm: drop skb parameter of get_addr
13965053: [net-next,v3,11/15] mptcp: pm: add id parameter for get_addr
13965054: [net-next,v3,12/15] mptcp: pm: reuse sending nlmsg code in
get_addr
13965055: [net-next,v3,13/15] mptcp: pm: drop skb parameter of set_flags
13965056: [net-next,v3,14/15] mptcp: pm: change rem type of set_flags
13965057: [net-next,v3,15/15] mptcp: pm: add local parameter for set_flags:
    - Series: mptcp: pm: misc cleanups, part 2
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=931607&state=*&archive=both


    our repo (by: Geliang Tang):

13918597: [mptcp-next,v2,1/9] mptcp: split get_subflow interface into two
13918598: [mptcp-next,v2,2/9] Squash to "bpf: Add bpf_mptcp_sched_ops"
13918599: [mptcp-next,v2,3/9] Squash to "selftests/bpf: Add bpf_first
scheduler & test"
13918600: [mptcp-next,v2,4/9] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
13918601: [mptcp-next,v2,5/9] Squash to "selftests/bpf: Add bpf_rr
scheduler & test"
13918602: [mptcp-next,v2,6/9] Squash to "selftests/bpf: Add bpf_red
scheduler & test"
13918603: [mptcp-next,v2,7/9] Squash to "selftests/bpf: Add bpf_burst
scheduler & test"
13918604: [mptcp-next,v2,8/9] Squash to "bpf: Export mptcp packet
scheduler helpers"
13918605: [mptcp-next,v2,9/9] Squash to "selftests/bpf: Add bpf_burst
scheduler & test":
    - Series: split get_subflow interface into two
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=920351&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts, Yunsheng Lin):

13897129: [net-next,v2,09/10] net: replace page_frag with page_frag_cache
13915179: [bpf-next/net,v2,1/7] bpf: Extend bpf_skc_to_mptcp_sock to
MPTCP sock
13915180: [bpf-next/net,v2,2/7] bpf: Allow use of skc_to_mptcp_sock in
cg_sockopt
13915181: [bpf-next/net,v2,3/7] bpf: Register mptcp common kfunc set
13915182: [bpf-next/net,v2,4/7] bpf: Add mptcp_subflow bpf_iter
13915183: [bpf-next/net,v2,5/7] bpf: Acquire and release mptcp socket
13915184: [bpf-next/net,v2,6/7] selftests/bpf: More endpoints for
endpoint_init
13915185: [bpf-next/net,v2,7/7] selftests/bpf: Add mptcp_subflow
bpf_iter subtest:
    - Series: bpf: Add mptcp_subflow bpf_iter support
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=919529&state=*&archive=both

13967020: [6.6.y,1/3] mptcp: pm: only set fullmesh for subflow endp
13967021: [6.6.y,2/3] mptcp: prevent excessive coalescing on receive
13967022: [6.6.y,3/3] selftests: mptcp: join: fix AF_INET6 variable:
    - Series: mptcp: pm: only set fullmesh for subflow endp (and more)
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=932037&state=*&archive=both

13967026: [6.1.y,1/2] mptcp: pm: only set fullmesh for subflow endp
13967027: [6.1.y,2/2] mptcp: prevent excessive coalescing on receive:
    - Series: mptcp: pm: only set fullmesh for subflow endp (and more)
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=932040&state=*&archive=both

13967029: [5.15.y] mptcp: prevent excessive coalescing on receive:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250209175504.3405385-2-matttbe@kernel.org/

13967030: [5.10.y] mptcp: prevent excessive coalescing on receive:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250209175555.3406593-2-matttbe@kernel.org/

13967031: [6.12.y] mptcp: prevent excessive coalescing on receive:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250209175711.3408345-2-matttbe@kernel.org/


    our repo (by: Cong Liu, Gang Yan, Geliang Tang, Gregory Detal,
Matthieu Baerts):

12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
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

13932555: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
13932556: [2/3] selftests: mptcp: relax conditions in SYN_TX validation
13932546: [3/3] selftests: mptcp: add a testcase for invalid addr timeout:
    - State: Changes requested
    - Series: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
    - Submitter: Gang Yan
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=923771&state=*&archive=both
    - status: same

13936935: [1/3] selftests: mptcp: Fix incorrect file descriptor check in
main_loop
13936934: [2/3] selftests: mptcp: Fix input fd lifecycle in reconnection
loop
13936936: [3/3] selftests: mptcp: Clean up resources properly in main_loop:
    - State: Changes requested
    - Series: selftests: mptcp: Fix various issues in main_loop
    - Submitter: Cong Liu
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=924794&state=*&archive=both
    - status: same

13941483: [v2] selftests: mptcp: Fix incorrect file descriptor check in
main_loop:
    - State: Changes requested
    - Submitter: Cong Liu
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250116085459.31419-1-liucong2@kylinos.cn/
    - status: same

13942922: [mptcp-next] selftests: mptcp: cover 'mptcp_diag_dump_one' in
mptcp_sockopt:
    - State: Changes requested
    - Submitter: Gang Yan
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/tencent_EE06C3EF8440C6905D8EC0B94E3E4A589905@qq.com/
    - status: same

13956416: [mptcp-next,v2,1/5] Revert "bpf: Extend bpf_skc_to_mptcp_sock
to MPTCP sock"
13956417: [mptcp-next,v2,2/5] Revert "bpf: Allow use of
skc_to_mptcp_sock in cg_sockopt"
13956418: [mptcp-next,v2,3/5] Squash to "bpf: Add mptcp_subflow bpf_iter"
13956419: [mptcp-next,v2,4/5] Revert "bpf: Acquire and release mptcp socket"
13956420: [mptcp-next,v2,5/5] Squash to "selftests/bpf: Add
mptcp_subflow bpf_iter subtest":
    - State: New
    - Series: Squash to "Add mptcp_subflow bpf_iter support"
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=929774&state=*&archive=both

13964674: [mptcp-next,v4,1/4] mptcp: define struct mptcp_pm_ops
13964675: [mptcp-next,v4,2/4] mptcp: define BPF path manager type
13964676: [mptcp-next,v4,3/4] mptcp: register default userspace pm
13964677: [mptcp-next,v4,4/4] mptcp: initialize and release mptcp_pm_ops:
    - State: New
    - Series: BPF path manager, part 4
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=931513&state=*&archive=both
    - Matth will look at them

13964764: [mptcp-next,v5,1/5] selftests/bpf: Add mptcp pm_nl_ctl link
13964765: [mptcp-next,v5,2/5] selftests/bpf: Use pm_nl_ctl if ip mptcp
not supported
13964766: [mptcp-next,v5,3/5] bpf: Add mptcp_userspace_pm_addr bpf_iter
13964767: [mptcp-next,v5,4/5] bpf: Export more helpers for
mptcp_userspace_pm_addr test
13964768: [mptcp-next,v5,5/5] selftests/bpf: Add mptcp_userspace_pm_addr
bpf_iter subtest:
    - State: New
    - Series: add mptcp_address bpf_iter
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=931534&state=*&archive=both
    - Mat will look at them

13964784: [mptcp-next,v1,1/5] bpf: Add mptcp path manager struct_ops
13964785: [mptcp-next,v1,2/5] bpf: Register mptcp struct_ops kfunc set
13964786: [mptcp-next,v1,3/5] selftests/bpf: Add mptcp userspace pm subtest
13964787: [mptcp-next,v1,4/5] selftests/bpf: Implement mptcp pm helpers
in BPF
13964788: [mptcp-next,v1,5/5] selftests/bpf: Add mptcp bpf path manager
subtest:
    - State: New
    - Series: BPF path manager, part 5
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=931539&state=*&archive=both
    - Matth will look at them

13966703: [mptcp-next,v14,1/8] Squash to "mptcp: add sched_data helpers"
13966704: [mptcp-next,v14,2/8] Squash to "bpf: Export mptcp packet
scheduler helpers"
13966705: [mptcp-next,v14,3/8] Squash to "selftests/bpf: Add bpf_first
scheduler & test"
13966706: [mptcp-next,v14,4/8] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
13966707: [mptcp-next,v14,5/8] Squash to "selftests/bpf: Add bpf_rr
scheduler & test"
13966708: [mptcp-next,v14,6/8] Squash to "selftests/bpf: Add bpf_red
scheduler & test"
13966709: [mptcp-next,v14,7/8] Squash to "selftests/bpf: Add bpf_burst
scheduler & test"
13966710: [mptcp-next,v14,8/8] mptcp: drop subflow contexts in
mptcp_sched_data:
    - State: New
    - Series: use bpf_iter in bpf schedulers
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=931980&state=*&archive=both




Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 541):

  544  Additional subflows are not reset when MPTCP options are
dropped/invalid after the 3WHS [bug] @matttbe:
      - So we should reset the subflow if we receive data without DSS
(except if covered by a longer mapping before)
      - But it looks like it is fine to receive an ACK without DACK.
      - TODO: Matth: Check RFC / Christoph → Done

  543  TCPDump: display `MP_TCPRST` info [enhancement]:
      - TODO: Matth: check with Davide

  542  in-kernel PM: limit to one subflow per network interface for each
connection [enhancement] [pm]:
      - or a flag per endpoint? But then we need to set it on all of them
      - do we need to do a route lookup before the connect to know which
interface will be used if not specified?
      - if not: then the behaviour can be not consistent → issue?
      - or change the order to pick the second interface for the 1st
extra subflow? (or a modification in userspace?)

Recently discussed:

  535  TCPDump: display `MP_CAPABLE` C flag [enhancement]
  530  about mptcp subflow creation question [question]
[feedback-needed] [triage]

  524  tests: cover more Diag-related code [selftests] @geliangtang:
      - dump_one probably requires some userspace code to pass a
specific token

  520  Question about proper MPTCP configuration over VPN. [question]
[feedback-needed]
  508  Divide error on device removal [bug] [feedback-needed]
  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf]
@geliangtang
  416  No new subflow when removing an endpoint and adding a new one
[bug] [feedback-needed]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question] [feedback-needed]


    Bugs (opened, flagged as "bug" and assigned)

  544  Additional subflows are not reset when MPTCP options are
dropped/invalid after the 3WHS [bug] @matttbe
  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement
`add_addr_accepted` [bug] [pm] @geliangtang
  487  `send()` fails with `EAGAIN` in blocking IO mode [bug]
[selftests] [sched] @geliangtang
  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf]
@geliangtang
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  508  Divide error on device removal [bug] [feedback-needed]
  505  Subflows won't be used when the interface for the main flow is a
subinterface [bug] [feedback-needed]
  499  selftests: `mptcp_connect.sh`: disconnect test timed out [bug]
[selftests]
  495  [syzkaller] KASAN: slab-use-after-free Read in
`__inet6_lookup_established` [bug] [syzkaller]
  494  [syzkaller] WARNING in `__skb_flow_dissect` [bug] [syzkaller]
  492  userspace pm: subflows counter: not updated when a subflows is
removed from the other end [bug]
  491  selftests: `mptcp_join`: tests `Infinite map` & `MP_FAIL MP_RST`
are unstable [bug] [selftests]
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

  514  Add MIB counters for fallback to TCP [enhancement] @geliangtang
  480  MPTCP and KTLS support [enhancement] @geliangtang
  434  in-kernel PM: increase subflows limit [enhancement] [pm] @matttbe
  353  sockopt: uniform code to get/set values [enhancement] @matttbe
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang
   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang


    Assigned Questions (opened, questions and assigned)

None.


    Open questions (opened, questions and not assigned)

  530  about mptcp subflow creation question [question]
[feedback-needed] [triage]
  520  Question about proper MPTCP configuration over VPN. [question]
[feedback-needed]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question] [feedback-needed]


    For later (opened and not assigned)

  543  TCPDump: display `MP_TCPRST` info [enhancement]
  542  in-kernel PM: limit to one subflow per network interface for each
connection [enhancement] [pm]

  536  PM: new subflow: avoid selecting initial endpoint upon `ADD_ADDR`
reception if servers deny MPJ to initial address [enhancement] [pm]:
      - maybe a new bitmap will be needed here

  535  TCPDump: display `MP_CAPABLE` C flag [enhancement]
  532  Userspace PM doesn't have access to `allow_join_id0` /
`allow_join_initial_addr_port` bit from the SYN-ACK [enhancement]
  525  tests: cover more MPTCP socket options [enhancement]
[packetdrill] [selftests]
  521  Implement psock_update_sk_prot, for eBPF SOCKMAP support
[enhancement]
  519  Reset the connection once "MPTCP has been verified" instead of a
fallback [enhancement]
  515  Add `TCP_MAXSEG` socket option support [enhancement]
  511  Add MIB counters for sent `MPTCP_RST_EMPTCP` [enhancement]
  503  in-kernel PM: use endpoints only to create subflows with received
`ADD_ADDR` [enhancement] [pm]
  497  in-kernel PM: check to create new subflows when some are
destroyed [enhancement] [pm]
  496  in-kernel PM: store received `ADD_ADDR` [enhancement] [pm]
  481  remove refcount on TCP sockets for the timers [enhancement]
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
  332  scheduler: implement a "opportunistic retransmission"
[enhancement] [sched]
  298  CG Memory accounting for passive MPTCP socket [enhancement]
  289  mptcp: audit comments for non inclusive language [enhancement]
  273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement] [packetdrill]
  266  Packetdrill: add MP_FAIL coverage [packetdrill]
  236  Review supported sockopts list [enhancement]
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill]
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
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 2025-01-29)

  531  Issue creating subflow 2/ backup subflow to a remote endpoint
[question]
  529  BUG: sleeping function called from invalid context in BPF sched
selftests [bug] [selftests] [sched] [bpf] @geliangtang
  502  Question for ip-mptcp command [question] [feedback-needed]
  501  Why do endpoint tcp connections close? [bug] [feedback-needed]
  489  IPv6 Rejoin Subflow [question] [feedback-needed]
  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  411  Problem with IPROTO [question]
  397  Doc and guidance for users [enhancement] [documentation]
  333  New MIBs to help understanding issues when PM cannot create new
subflows [enhancement] [pm] @matttbe
  243  sockopt: support TCP_CORK and TCP_NODELAY [enhancement]


    Packetdrill PRs

  52  27 days ago  dcaratti  Add initial coverage for RM_ADDR


    mptcp.dev PRs /


    mptcpd PRs

  314  15 days ago  matttbe  musl compat



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.15):
https://github.com/orgs/multipath-tcp/projects/13
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees: /

    - Fixes for -net:

    - Fixes for net-next:

    - Features for net-next:

        - [ca30bdc5441d] mptcp: consolidate subflow cleanup (Paolo Abeni)
        - [467d80561a6f] mptcp: drop __mptcp_fastopen_gen_msk_ackseq()
(Paolo Abeni)
        - [ecb07e7b0e44] mptcp: move the whole rx path under msk socket
lock protection (Paolo Abeni)
        - [2406516d55f1] mptcp: cleanup mem accounting (Paolo Abeni)
        - [9988567d3cbb] net: dismiss sk_forward_alloc_get() (Paolo Abeni)
        - [0337a6b75700] mptcp: dismiss __mptcp_rmem() (Paolo Abeni)
        - [2736216b7091] mptcp: micro-optimize __mptcp_move_skb() (Paolo
Abeni):
            - TODO: Matth: send this next → done

        - [8c33578a7e7d] mptcp: pm: remove unused ret value to set flags
(Matthieu Baerts (NGI0))
        - [f33b086d2a98] mptcp: pm: change to fullmesh only for
'subflow' (Matthieu Baerts (NGI0))
        - [2b71ed4482bf] mptcp: blackhole: avoid checking the state
twice (Matthieu Baerts (NGI0))
        - [254081335fa6] mptcp: add a build check for
userspace_pm_dump_addr (Geliang Tang)
        - [f8aca93606d4] mptcp: add mptcp_pm_genl_fill_addr helper
(Geliang Tang)
        - [97a9d389f39a] mptcp: drop match in
userspace_pm_append_new_local_addr (Geliang Tang)
        - [31a89c0c8f32] mptcp: drop inet6_sk after inet_sk (Geliang Tang)
        - [ff5d015cbf6a] mptcp: use ipv6_addr_equal in addresses_equal
(Geliang Tang)
        - [359d3a964522] mptcp: split get_subflow interface into two
(Geliang Tang):
            - Can be sent after

    - Features for net-next (next):

    - Features for other trees:

        - [2337ff37157c] bpf: Extend bpf_skc_to_mptcp_sock to MPTCP sock
(Geliang Tang)
        - [d4480cfaaa96] bpf: Allow use of skc_to_mptcp_sock in
cg_sockopt (Geliang Tang)
        - [4278eb56e309] bpf: Register mptcp common kfunc set (Geliang Tang)
        - [9218abc621c3] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [1ea868e705df] bpf: Acquire and release mptcp socket (Geliang
Tang)
        - [a33581f027a9] selftests/bpf: More endpoints for endpoint_init
(Geliang Tang)
        - [b8c16e31768c] selftests/bpf: Add mptcp_subflow bpf_iter
subtest (Geliang Tang)
        - [e41eca7a0f99] selftests/bpf: Drop cgroup_fd of run_mptcpify
(Geliang Tang)
        - [fdd1ff47a077] mptcp: add sched_data helpers (Geliang Tang)
        - [780a606b9839] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [c23dffe22c64] bpf: Export mptcp packet scheduler helpers
(Geliang Tang)
        - [cd7798f03e9f] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [6b6ca2449d4a] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [c19cdef91033] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [24bcdbcbf9a4] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [1a941c18aea4] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [3422e9c2078d] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang)



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp



Next meeting:
    - Next one on Wednesday, the 26th of February.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20250226



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you soon,
Matt
-- 
Sponsored by the NGI0 Core fund.

