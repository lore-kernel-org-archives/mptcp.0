Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E344921D58D
	for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594562; cv=none; b=q7Hg8yNs+1g4sbIScVwH0m34Lm7J18/XIJrYyCBNkgeg9sgjps78GiIL2jR2IyfZZcItcLtJfAN99k4+rF580uHjULu6isb20CknoMWY+pdl0UqKDBBaHp+bmQb2PD+VreTShi55U0nL4WGQqvE2pUGk/aUnldY9cOkSZyr83Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594562; c=relaxed/simple;
	bh=4zMWhTg8W+EwB4v65atofY9z4NPYz09cDMEOSj8jNHI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=DwuWhk/ge59EkwwVaMtFaVbgBpSHNYmXGHr9qwJnb7fZpvosDASBPBz8oxZClXWaIcun3PI4qM6nw5bSAmKGQjoROtJpzZzunBRmGtTi9pyRKyp+Vo/FbX3SBrS0lV69nmqb+5RQMxgIPBQh+kSUtaGPG2JdZYgGXjVXiJwK6RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUSmUg++; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUSmUg++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7670AC4CED6
	for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 18:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740594561;
	bh=4zMWhTg8W+EwB4v65atofY9z4NPYz09cDMEOSj8jNHI=;
	h=Date:To:From:Subject:From;
	b=nUSmUg++mZfHhNAFzZGL9tWXpK1msWy/W27hJR8ZVSDB2i7+Rx+gtg4nhR1djF/DI
	 s0ArhwMyXG+5WIeFKfMrJgF4jrhE2B7xuUGVRkSDBIDt2YmI/Lbqxj624A3DUcBbpp
	 ozozGtNmT4LZThiRVRKMcRe3zr/ubv4saiswPUXXKlUqJuKrtzZopFOgT4txLlji5n
	 ZUxvIk/b+iXkX8cB6zpj7T5AIjkUqgBhe2dVEIcL12Vu686fqivLS7kzR9jxemblFi
	 j7Cs+ByCffNZR5tzNGeK1mXt/WaP4s1yB3UgDG6jhQ2RG3CbxmSYCGVdqZrTw/b7xY
	 /RWb+uwfcYpuA==
Message-ID: <77f20bc3-11cf-4774-94c5-5e9f05bc5b48@kernel.org>
Date: Wed, 26 Feb 2025 19:29:17 +0100
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
Subject: [Weekly meetings] MoM - 26th of February 2025
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Today, we just had our new meeting with Mat (Cruise) and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

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

13980490: [net-next,1/7] mptcp: consolidate subflow cleanup
13980491: [net-next,2/7] mptcp: drop __mptcp_fastopen_gen_msk_ackseq()
13980492: [net-next,3/7] mptcp: move the whole rx path under msk socket
lock protection
13980493: [net-next,4/7] mptcp: cleanup mem accounting
13980494: [net-next,5/7] net: dismiss sk_forward_alloc_get()
13980495: [net-next,6/7] mptcp: dismiss __mptcp_rmem()
13980496: [net-next,7/7] mptcp: micro-optimize __mptcp_move_skb():
    - Series: mptcp: rx path refactor
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=935218&state=*&archive=both

13985713: [net-next,01/10] mptcp: pm: remove unused ret value to set flags
13985714: [net-next,02/10] mptcp: pm: change to fullmesh only for 'subflow'
13985715: [net-next,03/10] mptcp: pm: add a build check for
userspace_pm_dump_addr
13985716: [net-next,04/10] mptcp: pm: add mptcp_pm_genl_fill_addr helper
13985717: [net-next,05/10] mptcp: pm: drop match in
userspace_pm_append_new_local_addr
13985718: [net-next,06/10] mptcp: pm: drop inet6_sk after inet_sk
13985719: [net-next,07/10] mptcp: pm: use ipv6_addr_equal in addresses_equal
13985720: [net-next,08/10] mptcp: sched: split get_subflow interface
into two
13985721: [net-next,09/10] mptcp: sched: reduce size for unused data
13985722: [net-next,10/10] mptcp: blackhole: avoid checking the state twice:
    - Series: mptcp: pm: misc cleanups, part 3
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=936478&state=*&archive=both

13988696: [net,1/3] mptcp: always handle address removal under msk
socket lock
13988697: [net,2/3] mptcp: reset when MPTCP opts are dropped after join
13988698: [net,3/3] mptcp: safety check before fallback:
    - Series: mptcp: misc. fixes
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=937199&state=*&archive=both


    our repo (by: Gang Yan, Geliang Tang, Krister Johansen, Matthieu
Baerts, Paolo Abeni):

13979650: [mptcp-net,v2,1/2] mptcp: reset when MPTCP opts are dropped
after join
13979651: [mptcp-net,v2,2/2] mptcp: safety check before fallback:
    - Series: mptcp: reset when MPTCP opts are dropped after MPJ
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=935069&state=*&archive=both

13982085: [mptcp-net] mptcp: always handle address removal under msk
socket lock:
    - Submitter: Paolo Abeni
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/61cded134e753976259b48a4269f203dcae6c8fa.1739969092.git.pabeni@redhat.com/

13985652: [mptcp-next,1/2] mptcp: sched: reduce size for unused data
13985653: [mptcp-next,2/2] Squash to "mptcp: add sched_data helpers":
    - Series: mptcp: sched: reduce size for unused data
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=936464&state=*&archive=both

13987537: [mptcp-next,v1,1/6] mptcp: pm: in-kernel: avoid access entry
without lock
13987538: [mptcp-next,v1,2/6] mptcp: pm: in-kernel: reduce parameters of
set_flags
13987539: [mptcp-next,v1,3/6] mptcp: pm: use addr entry for get_local_id:
    - Series: BPF path manager, part 4
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=936935&state=*&archive=both

13987618: [mptcp-next,v4,1/2] selftests: mptcp: Add a tool to get
specific msk_info
13987617: [mptcp-next,v4,2/2] selftests: mptcp: add a test for
mptcp_diag_dump_one:
    - Series: selftests: mptcp: add tests for increasing
    - Submitter: Gang Yan
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=936949&state=*&archive=both

13988817: [mptcp-next] Squash to "selftests: mptcp: add a test for
mptcp_diag_dump_one":
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250224-mptcp-sft-diag-squash-v1-1-81eb3843fa53@kernel.org/

13989045: [v2] mptcp: fix 'scheduling while atomic' in
mptcp_pm_nl_append_new_local_addr:
    - Submitter: Krister Johansen
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250224232012.GA7359@templeofstupid.com/



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
    - hopefully, almost ready for a v3.

13992062: [iproute2-net] ss: mptcp: subflow: display seq counters as
decimal:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250226-iproute2-net-ss-ulp-mptcp-dec-v1-1-4f4177cff217@kernel.org/


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
    - can be archived?

13932555: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
13932556: [2/3] selftests: mptcp: relax conditions in SYN_TX validation
13932546: [3/3] selftests: mptcp: add a testcase for invalid addr timeout:
    - State: Changes requested
    - Series: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
    - Submitter: Gang Yan
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=923771&state=*&archive=both
    - status: same
    - can be archived?

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
    - archived

13941483: [v2] selftests: mptcp: Fix incorrect file descriptor check in
main_loop:
    - State: Changes requested
    - Submitter: Cong Liu
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250116085459.31419-1-liucong2@kylinos.cn/
    - status: same
    - can be archived?

13964764: [mptcp-next,v5,1/5] selftests/bpf: Add mptcp pm_nl_ctl link
13964765: [mptcp-next,v5,2/5] selftests/bpf: Use pm_nl_ctl if ip mptcp
not supported
13964766: [mptcp-next,v5,3/5] bpf: Add mptcp_userspace_pm_addr bpf_iter
13964767: [mptcp-next,v5,4/5] bpf: Export more helpers for
mptcp_userspace_pm_addr test
13964768: [mptcp-next,v5,5/5] selftests/bpf: Add mptcp_userspace_pm_addr
bpf_iter subtest:
    - State: Needs ack
    - Series: add mptcp_address bpf_iter
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=931534&state=*&archive=both
    - status: same

13977532: [mptcp-next,v15,1/8] Squash to "mptcp: add sched_data helpers"
13977533: [mptcp-next,v15,2/8] Squash to "bpf: Export mptcp packet
scheduler helpers"
13977534: [mptcp-next,v15,3/8] Squash to "selftests/bpf: Add bpf_first
scheduler & test"
13977535: [mptcp-next,v15,4/8] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
13977536: [mptcp-next,v15,5/8] Squash to "selftests/bpf: Add bpf_rr
scheduler & test"
13977537: [mptcp-next,v15,6/8] Squash to "selftests/bpf: Add bpf_red
scheduler & test"
13977538: [mptcp-next,v15,7/8] Squash to "selftests/bpf: Add bpf_burst
scheduler & test"
13977539: [mptcp-next,v15,8/8] mptcp: drop subflow contexts in
mptcp_sched_data:
    - State: New
    - Series: use bpf_iter in bpf schedulers
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=934636&state=*&archive=both
    - Looks OK, but depends on "Squash to "Add mptcp_subflow bpf_iter
support""

13983682: [mptcp-next,v1,1/9] mptcp: pm: in-kernel: add
address_removed/subflow_closed
13983683: [mptcp-next,v1,2/9] mptcp: pm: in-kernel: address_announced
interface
13983684: [mptcp-next,v1,3/9] mptcp: pm: in-kernel: address_removed
interface
13983685: [mptcp-next,v1,4/9] mptcp: pm: in-kernel: subflow_established
interface
13983686: [mptcp-next,v1,5/9] mptcp: pm: in-kernel: subflow_closed interface
13983687: [mptcp-next,v1,6/9] mptcp: pm: userspace: address_announced
interface
13983688: [mptcp-next,v1,7/9] mptcp: pm: userspace: address_removed
interface
13983689: [mptcp-next,v1,8/9] mptcp: pm: userspace: subflow_established
interface
13983690: [mptcp-next,v1,9/9] mptcp: pm: userspace: subflow_closed
interface:
    - State: Changes requested
    - Series: BPF path manager, part 5
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=935957&state=*&archive=both

13987046: [mptcp-next,v6,01/13] mptcp: sysctl: use index for sysctl table
13987047: [mptcp-next,v6,02/13] mptcp: sysctl: add path_manager to set
pm name
13987049: [mptcp-next,v6,04/13] mptcp: pm: define struct mptcp_pm_ops
13987050: [mptcp-next,v6,05/13] mptcp: pm: in-kernel: register
mptcp_in_kernel_pm
13987051: [mptcp-next,v6,06/13] mptcp: pm: userspace: register
mptcp_userspace_pm
13987052: [mptcp-next,v6,07/13] mptcp: pm: initialize and release
mptcp_pm_ops
13987053: [mptcp-next,v6,08/13] mptcp: pm: drop pm_type in mptcp_pm_data
13987055: [mptcp-next,v6,09/13] mptcp: sysctl: drop old pm_type sysctl
13987054: [mptcp-next,v6,10/13] mptcp: sysctl: add available_path_managers
13987056: [mptcp-next,v6,11/13] mptcp: pm: drop get_local_id helpers
13987057: [mptcp-next,v6,12/13] mptcp: pm: drop is_backup helpers
13987058: [mptcp-next,v6,13/13] selftests/mptcp: use path_manager
instead of pm_type:
    - State: Changes requested
    - Series: BPF path manager, part 4
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=936802&state=*&archive=both
    - getting there with a new PM ops, should replace the if
userspace/in-kernel in many places, should make things clearer
    - maybe later, we should also move code that is common to different
PMs out of pm_netlink.c (should be specific to the in-kernel PM), to
pm.c (common code) → might be annoying for the backports, but would help
with the new code / reviews

13987388: [mptcp-next,v4,1/5] Revert "bpf: Extend bpf_skc_to_mptcp_sock
to MPTCP sock"
13987389: [mptcp-next,v4,2/5] Revert "bpf: Allow use of
skc_to_mptcp_sock in cg_sockopt"
13987390: [mptcp-next,v4,3/5] Squash to "bpf: Add mptcp_subflow bpf_iter"
13987391: [mptcp-next,v4,4/5] Revert "bpf: Acquire and release mptcp socket"
13987392: [mptcp-next,v4,5/5] Squash to "selftests/bpf: Add
mptcp_subflow bpf_iter subtest":
    - State: New
    - Series: Squash to "Add mptcp_subflow bpf_iter support"
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=936873&state=*&archive=both
    - We need to make sure the MSK lock is held:
        - It looks like it is the case when looking at the code
        -
https://elixir.bootlin.com/linux/v6.13.4/source/net/core/sock.c#L1117
        -
https://elixir.bootlin.com/linux/v6.13.4/source/net/core/filter.c#L5504
        - Maybe the easier is to add msk_owned_by_me() and check if the
selftests are all OK
        - TODO: Matth: add a test patch to verify that → Done
        - Mat will check a bit more the BPF code to understand that.

13987540: [mptcp-next,v1,4/6] mptcp: pm: in-kernel: use kmemdup helper
13987541: [mptcp-next,v1,5/6] sock: add sock_kmemdup helper
13987542: [mptcp-next,v1,6/6] mptcp: pm: userspace: use sock_kmemdup helper:
    - State: Changes requested
    - Series: BPF path manager, part 4
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=936935&state=*&archive=both
    - Not directly linked to MPTCP, better if Geliang can suggest that
directly on netdev, but not sure whether there is an interest to do that
on existing code (cleanup vs new things).

13992091: [mptcp-next] tcp: ulp: diag: remove net admin restriction:
    - State: New
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250226-mptcp-tcp-ulp-diag-cap-v1-1-e1a003ad0606@kernel.org/
    - Can be sent to netdev alone, with the proper people in cc.

13992569: [mptcp-next,v2] mptcp: pm: exit early with ADD_ADDR echo if
possible:
    - State: New
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250226-mptcp-userspace-avoid-worker-v2-1-4b144f314353@kernel.org/
    - Small optimisation, similar to what is done elsewhere


Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 544):

  549  pm: in-kernel: set `msk->pm.work_pending` back to `true` [bug]:
      - Looks like it is not blocking, to be investigated

  548  disable mptcp for an interface [question] @matttbe:
      - with a VPN apps, and NM or mptcpd settings endpoints
automatically, it is possible to have new subflows not going through the
VPN interfaces.
      - doesn't look like something the kernel should solve, and not
specific to MPTCP
      - Workaround: nft / iptables? Or via BPF?

  545  Deal with multiple pure TCP ACK without MPTCP options [enhancement]:
      - No urgent at all, maybe not even needed.


    Recently discussed:

  530  about mptcp subflow creation question [question] [feedback-needed]
  524  tests: cover more Diag-related code [selftests] @geliangtang
   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang


    Bugs (opened, flagged as "bug" and assigned)

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

  549  pm: in-kernel: set `msk->pm.work_pending` back to `true` [bug]
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

  548  disable mptcp for an interface [question] @matttbe


    Open questions (opened, questions and not assigned)

  530  about mptcp subflow creation question [question] [feedback-needed]
  520  Question about proper MPTCP configuration over VPN. [question]
[feedback-needed]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question] [feedback-needed]


    For later (opened and not assigned)

  545  Deal with multiple pure TCP ACK without MPTCP options [enhancement]
  543  TCPDump: display `MP_TCPRST` info [enhancement]
  542  in-kernel PM: limit to one subflow per network interface for each
connection [enhancement] [pm]
  536  PM: new subflow: avoid selecting initial endpoint upon `ADD_ADDR`
reception if servers deny MPJ to initial address [enhancement] [pm]
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


    Recently closed (since 2025-02-12)

  547  Testing Your Recent "selftests/bpf" Commit [question]
  546  [syzbot] WARNING in mptcp_pm_nl_addr_send_ack [bug] [syzkaller]
@pabeni
  544  Additional subflows are not reset when MPTCP options are
dropped/invalid after the 3WHS [bug] @matttbe
  528  Can't Find Balia, Lia, Olia congestion control selection in
menuconfig . [question] [feedback-needed]
  510  Some newly added endpoints won't be used to create subflows on an
existing MPTCP connection [question]


    Packetdrill PRs

  52  1 month ago  dcaratti  Add initial coverage for RM_ADDR


    mptcp.dev PRs

/

    mptcpd PRs

  314  1 month ago  matttbe  musl compat



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.15):
https://github.com/orgs/multipath-tcp/projects/13
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees:


    - Fixes for -net:

        - [c96aec16d42e] mptcp: fix 'scheduling while atomic' in
mptcp_pm_nl_append_new_local_addr (Krister Johansen)
            - we will see if it will need to be re-sent

    - Fixes for net-next: /

    - Features for net-next:

        - [17291d026fb8] selftests: mptcp: Add a tool to get specific
msk_info (Gang Yan)
        - [8bb073c0a62b] selftests: mptcp: add a test for
mptcp_diag_dump_one (Gang Yan)
        - [d9d69063c510] mptcp: pm: in-kernel: avoid access entry
without lock (Geliang Tang)
        - [98714063fc0f] mptcp: pm: in-kernel: reduce parameters of
set_flags (Geliang Tang)
        - [698e6dfc559f] mptcp: pm: use addr entry for get_local_id
(Geliang Tang):
            - Could be sent next

    - Features for net-next (next): /

    - Features for other trees:

        - [77c4476d35cd] bpf: Extend bpf_skc_to_mptcp_sock to MPTCP sock
(Geliang Tang)
        - [ac5b51bdc88a] bpf: Allow use of skc_to_mptcp_sock in
cg_sockopt (Geliang Tang)
        - [9439c7429277] bpf: Register mptcp common kfunc set (Geliang Tang)
        - [5a463c20fed3] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [5d3fecdbf496] bpf: Acquire and release mptcp socket (Geliang
Tang)
        - [3ed0213b2765] selftests/bpf: More endpoints for endpoint_init
(Geliang Tang)
        - [e6e012bd431d] selftests/bpf: Add mptcp_subflow bpf_iter
subtest (Geliang Tang):
            - hopefully soon ↑


        - [3fbab48f82ce] selftests/bpf: Drop cgroup_fd of run_mptcpify
(Geliang Tang)
        - [93ca68b77241] mptcp: add sched_data helpers (Geliang Tang)
        - [54a048e9e1db] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [ff395d7fa386] bpf: Export mptcp packet scheduler helpers
(Geliang Tang)
        - [544b48b50536] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [026034fc1f51] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [900f13dfa7f5] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [25ec70206f2c] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [e9b96109479c] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [98ea4498ac12] selftests/bpf: Add bpf_burst scheduler & test
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
        - still OK
        - Had some issues on NIPA, but just because MPTCP validates more
stuff not directly linked to MPTCP (IPv6, etc.), not done by the other
net selftests.



Netdev 0x19:
    - Next week
    - With a BoF dedicated to MPTCP: come and join!
    -
https://netdevconf.info/0x19/sessions/bof/mptcp-present-future-and-its-development-workflow-ci.html



MPTCP in RHEL 10:
    - still disabled by default:
https://lore.kernel.org/netdev/b7bbe504-d6f3-4262-af19-1edad4129fa9@kernel.org/
    - → more and more apps enable MPTCP by default (e.g. Go apps on the
server side), but the MPTCP deployment is blocked by default on RHEL
because an extra step is needed, so likely not done :-/
    - Possible to change that?



Next meeting:
    - **NOT** on the 12th of March: Netdev 0x19
    - Next one on Wednesday, the 26th of March.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20250326



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you soon,
Matt
-- 
Sponsored by the NGI0 Core fund.

