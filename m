Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47478F66
	for <mptcp@lists.linux.dev>; Thu, 16 May 2024 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874887; cv=none; b=aG/l6zknNds+YCEtKfv+dsrLOVhiitjRIZrBGHHSc5n5NGkAHGxbo8nDZ+LGOYs+AD3Dbc7hiMac6RjnAdfyAw1iUNvPSqQciQroRDsOeU6p+D/oTEhv9qj6hm2kQiv9/iTv25jq11ROunblIXD9xRK6X6VmknX233lwP0SlxQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874887; c=relaxed/simple;
	bh=Bhv8g6CekkztCk68cVjQy9MzZWGBGLOpxfdsUKhX/zQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=lSn2hmRxHLERTdnzNm4dcW8e5nlYKw00ayTOgoVoVdbmoAYz6sM0JA08VwHehWOaU+bA5vJTOODY4zO/GqsH670RQi2pI0Vtb2TcSg0IwmtFKu1mA1T6HipEgpuiOewYDi+UukxoNjWQuapNinSOf/9nVVVmnww7zSt3UzF2KVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsiadQuf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsiadQuf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F8DC113CC
	for <mptcp@lists.linux.dev>; Thu, 16 May 2024 15:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715874887;
	bh=Bhv8g6CekkztCk68cVjQy9MzZWGBGLOpxfdsUKhX/zQ=;
	h=Date:To:From:Subject:From;
	b=rsiadQuf4eCHnCCEl34ZLX8LtYFgR+GU0rgCJau7nNBlWmZhKXAdRanjnW7cW5ZjN
	 gKZjnxd01g/Dvl+Q7jfJ5KHnNaQ5ke2nX4WE7BoC9zNaXWT3ugwk+uuthANaVf/SpH
	 hIZU2C8Zc5zaITrUZM90W1qYj8pZJiOstT1O/YVHl6uEkgkIRHw9QbLA9opIqGmWC3
	 AqnQJPvBdrrl6lBBnTao1HpolScO4nO9YnEBI2r26nVQalqCwyJWc8haiYQl4TB2Se
	 nTE+Iu3hi95gUy5PxhAxtGwN1OsfoX7TE5iIzamWRKiih4ZpJ3dfHq8ScR8dffNP5k
	 OZ+JJ6JFtEq9A==
Message-ID: <a5c26b92-b741-42dc-8a0b-bcb8bd35ed11@kernel.org>
Date: Thu, 16 May 2024 17:54:44 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 15th of May 2024
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

This week, we had our new meeting with Mat (Cruise), Christoph (Apple),
and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau, Matthieu Baerts):

13660030: [net-next] tcp: socket option to check for MPTCP fallback to TCP:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240509-upstream-net-next-20240509-mptcp-tcp_is_mptcp-v1-1-f846df999202@kernel.org/

13663746: [net-next,v2,1/8] mptcp: SO_KEEPALIVE: fix getsockopt support
13663747: [net-next,v2,2/8] mptcp: fix full TCP keep-alive support
13663748: [net-next,v2,3/8] mptcp: sockopt: info: stop early if no buffer
13663749: [net-next,v2,4/8] mptcp: add net.mptcp.available_schedulers
13663750: [net-next,v2,5/8] mptcp: prefer strscpy over strcpy
13663751: [net-next,v2,6/8] mptcp: remove unnecessary else statements
13663752: [net-next,v2,7/8] mptcp: move mptcp_pm_gen.h's include
13663753: [net-next,v2,8/8] mptcp: include inet_common in mib.h:
      - Series: mptcp: small improvements, fix and clean-ups
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=852947&state=*&archive=both


    our repo (by: Matthieu Baerts):

13655427: [mptcp-next,RFC] mptcp: socket option to check for fallback:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240506-getsockopt-tcp_is_mptcp-v1-1-4f044660f7c3@kernel.org/

13659633: [mptcp-net,v2,1/2] mptcp: SO_KEEPALIVE: fix getsockopt support
13659634: [mptcp-net,v2,2/2] mptcp: fix full TCP keep-alive support:
      - Series: mptcp: getsockopt(SO_KEEPALIVE) and TCP_KEEP* sockopts
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=851859&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Edward Liaw, Geliang Tang,
Matthieu Baerts, Yunsheng Lin):

13665243: [RFC,v4,11/13] net: replace page_frag with page_frag_cache:
    - v4 is applying comments from Mat

13659842: [bpf-next,v2,1/2] selftests/bpf: Add mptcp subflow example
13659843: [bpf-next,v2,2/2] selftests/bpf: Add mptcp subflow subtest:
      - Series: selftests/bpf: new MPTCP subflow subtest
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=851945&state=*&archive=both
      - Not OK because BPF CI is using IPRoute 5.5 from 2020, not
supporting 'ip mptcp'

13660747: [v4,35/66] selftests/net: Drop define _GNU_SOURCE:
    - looks OK, no need to comment

13664612: [bpf-next,1/9] selftests/bpf: Add unshare_netns helper
13664613: [bpf-next,2/9] selftests/bpf: Use unshare_netns helper
13664614: [bpf-next,3/9] selftests/bpf: Drop duplicate create_netns
13664615: [bpf-next,4/9] selftests/bpf: Export create_netns helper
13664616: [bpf-next,5/9] selftests/bpf: Use create_netns helper
13664617: [bpf-next,6/9] selftests/bpf: Export cleanup_netns helper
13664618: [bpf-next,7/9] selftests/bpf: Use cleanup_netns helper
13664619: [bpf-next,8/9] selftests/bpf: Use netns helpers in lwt tests
13664620: [bpf-next,9/9] selftests/bpf: Use netns helpers in test_tunnel:
      - Series: add netns helpers
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=853288&state=*&archive=both
      - For BPF tree: not directly related to MPTCP but (slighly)
impacting our selftests

13663515: [5.10.y] mptcp: ensure snd_nxt is properly initialized on connect:
      - State: New
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240513151717.2733290-2-matttbe@kernel.org/


    our repo (by: Geliang Tang, Matthieu Baerts, Yunsheng Lin):

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
      - Skip: status is the same

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
      - Skip: status is the same

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
      - Skip: status is the same

13656189: [mptcp-net,v2] mptcp: fix the default value of scaling_ratio:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn/
      - Skip: status is the same
      - Geliang didn't reply to Matth's questions: not sure what are the
next steps

13662294: [mptcp-next,1/2] mptcp: use mptcp_win_from_space helper
13662295: [mptcp-next,2/2] mptcp: add mptcp_space_from_win helper:
      - State: Queued
      - Series: convert helpers for win and space
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=852503&state=*&archive=both
      - TODO: can be applied → done

13662636: [mptcp-next,v4,3/3] checkpatch: skip warnings for symbol links:
      - State: Changes requested
      - Series: patches for new MPTCP subflow subtest
      - Submitter: Geliang Tang
      - Can be sent directly to CheckPatch maintainers

13664690: [mptcp-next,1/3] selftests/bpf: Handle SIGINT when creating netns
13664691: [mptcp-next,2/3] Squash to "selftests/bpf: Add mptcp subflow
subtest"
13664692: [mptcp-next,3/3] Squash to "selftests/bpf: Add bpf scheduler
test":
      - State: Changes Requested
      - Series: fixes for create_netns
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=853304&state=*&archive=both
      - Patch 1/3 can be sent to BPF tree as well
      - Matth did a review

13665066: [mptcp-next,v6,1/2] selftests/bpf: Add mptcp pm_nl_ctl link
13665067: [mptcp-next,v6,2/2] Squash to "selftests/bpf: Add mptcp
subflow subtest":
      - State: New
      - Series: patches for new MPTCP subflow subtest
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=853374&state=*&archive=both
      - TODO: Matth: can be applied → done



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from the last meeting: 488):

None.


    Bugs (opened, flagged as "bug" and assigned)

  487  BPF selftests fails with EAGAIN [bug] [selftests] [bpf] @geliangtang
  477  Client: fallback to TCP after X MPC [bug] @matttbe
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf]
  483  [6.1] selftests: `mptcp_connect.sh` failures with
`copyfd_io_poll: poll timed out` errors [bug] [selftests]
  476  packetdrill: coalescing feature doesn't take into account MPTCP
options [bug] [packetdrill]
  475  `simult_flows`: unbalanced bwidth tests are unstable [bug]
[selftests]
  439  mptcp vs net.ipv4.tcp_shrink_window [bug]
  416  No new subflow when removing an endpoint and adding a new one [bug]
  336  Issues with BPF packet scheduler [bug] [sched] [bpf]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose
server test` are sometimes failing [bug] [selftests]
  315  Issues with backup flow [bug]


    In Progress (opened, new feature and assigned)

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

  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned)

  481  remove refcount on TCP sockets for the timers [enhancement]
  480  MPTCP and KTLS support [enhancement]
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
  334  PM: in-kernel: send >1 ADD_ADDR before the establishment of a new
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


    Recently closed (since 2024-05-08)

  479  when using openvpn in tcp with dco, we have a bug [question]
  383  TCP_KEEPIDLE, TCP_KEEPINTVL, TCP_KEEPCNT are not implemented in
mptcp_setsockopt_sol_tcp [bug] @matttbe



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.11):
https://github.com/orgs/multipath-tcp/projects/9
    - For later: https://github.com/orgs/multipath-tcp/projects/1
    - TODO: Matth: update ChangeLog → done:
https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog



Patches to send to NetDev:

    - Fixes for other trees:


    - Fixes for -net:

        - [f57237cb8093] selftests: mptcp: simult flows: re-adapt BW
(Matthieu Baerts (NGI0))

    - Fixes for net-next:


    - Features for net-next:


    - Features for net-next (next):


    - Features for other trees:

        - [b0a5668ee5ef] mptcp: add sched_data helpers (Geliang Tang)
        - [2058b8b864a9] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [d48290ef8995] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)

        - [bc7329cf1a91] selftests/bpf: Add mptcp subflow example
(Nicolas Rybowski)
        - [105d1eb0262b] selftests/bpf: Add mptcp subflow subtest
(Geliang Tang):
            - Can be sent when the fixes for the BPF CI will be applied:
TODO Matth → no
            - Note: conflicting with the BPF series sent by Geliang: wait

        - [d36c9f5cb7f6] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [069856100234] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [a9084c26c9c8] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [9e9f85244ec8] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [9b89a4eda08f] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [b2e56dc64103] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [d38a40cf7d7c] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang)



Extra tests:
    - news about Syzkaller? (Christoph):
        - Christoph is trying to fix the setup

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - Packetdrill (Davide):
        - 3 PRs have been opened:
            - packetdrill: mptcp: fix CLang errors
            - mptcp: validate getsockopt(TCP_IS_MPTCP)
            - mptcp: validate TCP_KEEP* sockopts → Done

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - Looks OK so far


Flaky tests on the netdev CI:
    - https://netdev.bots.linux.dev/status.html
    - https://netdev.bots.linux.dev/flakes.html?br-cnt=88&tn-needle=mptcp
    - Mainly with simult flows:
        - skip it (except on our CI) to avoid the noise while working on
a solution?:
            - TODO: Matth: skip unstable subtests on other CI but NOT on
our CI!
            - we have GH tickets to track them
            - and we will still look at the results on our side
        - Should we do that for any known unstable subtest?:
            - yes, for simult flows and mptcp_join


SSH:
    - no public replies to Matt's email:
        -
https://lore.kernel.org/mptcp/7b052697-15e1-425c-8127-7adfaca28c4b@kernel.org/
    - https://github.com/rapier1/hpn-ssh:
        - a fork of OpenSSH, designed for high performance network
        - https://www.psc.edu/hpn-ssh-home/
        - they might look for adding MPTCP support: see the
"feature_mptcp_test" branch
    - on Debian distribution, it is systemd which is creating the socket:
        - would be good to add MPTCP support there:

https://www.freedesktop.org/software/systemd/man/latest/systemd.socket.html
    - Idea from Christoph:
        - use a "protocol" option to set any protocol: that's not Linux
specific.
        - a bit sneaky, but maybe it could work.



Next meeting:
    - Next one on *Wednesday*, the 22nd of May.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240522



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.

