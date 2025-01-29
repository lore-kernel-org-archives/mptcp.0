Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897121E1C36
	for <mptcp@lists.linux.dev>; Wed, 29 Jan 2025 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174964; cv=none; b=eCBGuiDisX5CnpjmjcbT4dpmM/ZvRpCQCsr3I+buZ4+qVQpoOAChLpnvOjtK4h8aJR0mlGegfSQ8d3mqermaDmlNpI80iFw1wYv2bYp+gi+NITsvKr85McZK6YoTJhY7VIin/Kl2X+hJFHYWmxQ0xtmUmNIEoIplI8NeWlXa2hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174964; c=relaxed/simple;
	bh=GjZYhsta+JcMavjQ6d0ks6Dmpqwdn5utG1cbJlgXms4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=RWca5NuJHMdHbXIEGwcRuQ+2afH9vtMpI89z05yCyuHhxxtTNhd93XhwZmiRWcNZHlupvP9kNWjjyRMEH5OvZQHU+Kix+DPtNoa3m3oA811KACKliB+noxCh0fbPBC+BKSJFcOk39lQ4EKI7t6l/msQO9dlZxiqAX6bxa1R/ef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGPHxNTh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGPHxNTh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609F4C4CED1
	for <mptcp@lists.linux.dev>; Wed, 29 Jan 2025 18:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738174963;
	bh=GjZYhsta+JcMavjQ6d0ks6Dmpqwdn5utG1cbJlgXms4=;
	h=Date:From:Subject:To:From;
	b=DGPHxNThhnR6wSqnNLI1M9KYrWqYuJPxGG1hPVnYA08/0/czXdePlld9QfXcFwmld
	 Kezby2BfLvep8aftBCJxDWWgyfmObXynGKoG8wh8u6GauBPoJsZglOQsekuys8eVmk
	 RKxJ/YXZtybDMXPOyfD0maq/z2vUEpCoI7QehXCLHFp0zseQ/5GSq8JZN0j5QL45ME
	 YpypiqIcQW19NciWWvm42XZIgQxdH4AzP5JiZI0xkNeixmIoc2JLFcsnEvbGiIUwzW
	 jduediaiDf/Ea+hbt6SSYLmNySm7XzmU++SFKKxoBDfXc8oXRthWiUyiPhUEz5C0y/
	 8xyu4rijQX8uA==
Message-ID: <51db9c4a-37f3-49b2-9bc8-0dc4bb1962da@kernel.org>
Date: Wed, 29 Jan 2025 19:22:34 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Subject: MoM - 29th of January 2025
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Linux <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our new meeting with Mat (Cruise), and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Jan Stancek, Matthieu Baerts):

13939236: [net-next,1/6] selftests: mptcp: simult_flows: unify errors msgs
13939237: [net-next,2/6] selftests: mptcp: sockopt: save nstat infos
13939238: [net-next,3/6] selftests: mptcp: move stats info in case of
errors to lib.sh
13939239: [net-next,4/6] selftests: mptcp: add -m with ss in case of errors
13939240: [net-next,5/6] selftests: mptcp: connect: remove unused variable
13939241: [net-next,6/6] selftests: mptcp: connect: better display the
files size:
    - Series: mptcp: selftests: more debug in case of errors
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=925368&state=*&archive=both

13939308: [net-next] mptcp: fix for setting remote ipv4mapped address:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250114-net-next-mptcp-fix-remote-addr-v1-1-debcd84ea86f@kernel.org/

13943689: [net-next] mptcp: sysctl: add syn_retrans_before_tcp_fallback:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250117-net-next-mptcp-syn_retrans_before_tcp_fallback-v1-1-ab4b187099b0@kernel.org/

13947998: selftests: mptcp: extend CFLAGS to keep options from environment:
    - Submitter: Jan Stancek
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/7abc701da9df39c2d6cd15bc3cf9e6cee445cb96.1737621162.git.jstancek@redhat.com/

13948524: [net,1/3] mptcp: consolidate suboption status
13948525: [net,2/3] mptcp: pm: only set fullmesh for subflow endp
13948526: [net,3/3] mptcp: handle fastopen disconnect correctly:
    - Series: mptcp: fixes addressing syzbot reports
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=927901&state=*&archive=both

13947152: [5.15.y] mptcp: don't always assume copied data in
mptcp_cleanup_rbuf():
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250122111517.3284651-2-matttbe@kernel.org/


    our repo (by: Geliang Tang, Matthieu Baerts, Paolo Abeni):

13939024: [mptcp-next,1/3] doc: mptcp: sysctl: blackhole_timeout is
per-netns
13939025: [mptcp-next,2/3] mptcp: sysctl: add
syn_retrans_before_tcp_fallback
13939983: [mptcp-next] selftests/bpf: Drop cgroup_fd of run_mptcpify:
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/38e34a835050f35b7f14f7938b20f86a97ac0836.1736926065.git.tanggeliang@kylinos.cn/

13940967: [mptcp-net] mptcp: consolidate suboption status.:
    - Submitter: Paolo Abeni
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/7c8a258328ed6d235a100e3fa13c2da355119951.1736974476.git.pabeni@redhat.com/

13943064: [mptcp-net,v2,1/3] mptcp: pm: only set fullmesh for subflow endp
13944228: [mptcp-net] mptcp: handle fastopen disconnect correctly:
    - Submitter: Paolo Abeni
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/e8371ec8065e09317dcf7d7aabc6c54e63634bbb.1737222305.git.pabeni@redhat.com/

13945469: [mptcp-next] mptcp: drop __mptcp_fastopen_gen_msk_ackseq():
    - Submitter: Paolo Abeni
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/e96b1f70660ffd750c09c051991e2b65a7d1b492.1737398231.git.pabeni@redhat.com/

13947233: [mptcp-net,v2,1/2] mptcp: blackhole only if 1st SYN retrans
w/o MPC is accepted
13947234: [mptcp-net,v2,2/2] mptcp: blackhole: avoid checking the state
twice:
    - Series: mptcp: blackhole: sysctl SYN retrans + fix conditions
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=927518&state=*&archive=both

13947307: [mptcp-next,v3,1/2] mptcp: pm: remove unused ret value to set
flags
13947308: [mptcp-next,v3,2/2] mptcp: pm: change to fullmesh only for
'subflow':
    - Series: mptcp: pm: only set fullmesh for subflow endp
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=927547&state=*&archive=both

13949006: [mptcp-next,v5,1/5] mptcp: add a build check for
userspace_pm_dump_addr
13949007: [mptcp-next,v5,2/5] mptcp: add mptcp_pm_genl_fill_addr helper
13949008: [mptcp-next,v5,3/5] mptcp: drop match in
userspace_pm_append_new_local_addr
13949009: [mptcp-next,v5,4/5] mptcp: drop inet6_sk after inet_sk
13949010: [mptcp-next,v5,5/5] mptcp: use ipv6_addr_equal in addresses_equal:
    - Series: BPF path manager, part 3
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=928039&state=*&archive=both



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

13953714: [net,1/2] mptcp: blackhole only if 1st SYN retrans w/o MPC is
accepted
13953715: [net,2/2] doc: mptcp: sysctl: blackhole_timeout is per-netns:
    - Series: mptcp: blackhole only if 1st SYN retrans w/o MPC is accepted
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=929059&state=*&archive=both


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

13909382: [mptcp-next,v3] mptcp: use GENL_REQ_ATTR_CHECK for token:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/d9c76c6c008c770046f665a4a4e93735fd121399.1734337790.git.tanggeliang@kylinos.cn/
    - TODO: can be dropped: superseded

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
    - State: Needs ack
    - Series: split get_subflow interface into two
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=920351&state=*&archive=both
    - to be reviewed: Mat will have a look

13918732: [mptcp-next,v12,01/10] bpf: Add bpf_mptcp_send_info_to_ssk
13918733: [mptcp-next,v12,02/10] Revert "mptcp: add sched_data helpers"
13918734: [mptcp-next,v12,03/10] mptcp: drop struct mptcp_sched_data
13918735: [mptcp-next,v12,04/10] Squash to "bpf: Add bpf_mptcp_sched_ops"
13918736: [mptcp-next,v12,05/10] Squash to "bpf: Export mptcp packet
scheduler helpers"
13918737: [mptcp-next,v12,06/10] Squash to "selftests/bpf: Add bpf_first
scheduler & test"
13918738: [mptcp-next,v12,07/10] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
13918739: [mptcp-next,v12,08/10] Squash to "selftests/bpf: Add bpf_rr
scheduler & test"
13918740: [mptcp-next,v12,09/10] Squash to "selftests/bpf: Add bpf_red
scheduler & test"
13918741: [mptcp-next,v12,10/10] Squash to "selftests/bpf: Add bpf_burst
scheduler & test":
    - State: Needs ack
    - Series: use bpf_iter in bpf schedulers
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=920379&state=*&archive=both
    - to be reviewed: Mat will have a look

13930286: [mptcp-next,v4,1/5] selftests/bpf: Add mptcp pm_nl_ctl link
13930287: [mptcp-next,v4,2/5] selftests/bpf: Use pm_nl_ctl if ip mptcp
not supported
13930288: [mptcp-next,v4,3/5] bpf: Add mptcp_userspace_pm_addr bpf_iter
13930289: [mptcp-next,v4,4/5] bpf: Export more helpers for
mptcp_userspace_pm_addr test
13930290: [mptcp-next,v4,5/5] selftests/bpf: Add mptcp_userspace_pm_addr
bpf_iter subtest:
    - State: Needs ack
    - Series: add mptcp_address bpf_iter
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=923265&state=*&archive=both
    - to be reviewed

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

13941376: [mptcp-next,v3,1/3] mptcp: define struct mptcp_pm_ops
13941377: [mptcp-next,v3,2/3] mptcp: register default userspace pm
13941378: [mptcp-next,v3,3/3] mptcp: init and release mptcp_pm_ops:
    - State: Changes requested
    - Series: BPF path manager, part 4
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=925962&state=*&archive=both
    - status: reviewed

13941483: [v2] selftests: mptcp: Fix incorrect file descriptor check in
main_loop:
    - State: Changes requested
    - Submitter: Cong Liu
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250116085459.31419-1-liucong2@kylinos.cn/
    - status: reviewed

13942922: [mptcp-next] selftests: mptcp: cover 'mptcp_diag_dump_one' in
mptcp_sockopt:
    - State: Changes requested
    - Submitter: Gang Yan
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/tencent_EE06C3EF8440C6905D8EC0B94E3E4A589905@qq.com/
    - status: reviewed

13943874: [net-next,v2,01/15] mptcp: pm: drop info of
userspace_pm_remove_id_zero_address
13943875: [net-next,v2,02/15] mptcp: pm: userspace: flags: clearer msg
if no remote addr
13943876: [net-next,v2,03/15] mptcp: pm: more precise error messages
13943877: [net-next,v2,04/15] mptcp: pm: improve error messages
13943878: [net-next,v2,05/15] mptcp: pm: userspace: use GENL_REQ_ATTR_CHECK
13943879: [net-next,v2,06/15] mptcp: pm: remove duplicated error messages
13943880: [net-next,v2,07/15] mptcp: pm: mark missing address attributes
13943881: [net-next,v2,08/15] mptcp: pm: use NL_SET_ERR_MSG_ATTR when
possible
13943882: [net-next,v2,09/15] mptcp: pm: make three pm wrappers static
13943883: [net-next,v2,10/15] mptcp: pm: drop skb parameter of get_addr
13943884: [net-next,v2,11/15] mptcp: pm: add id parameter for get_addr
13943885: [net-next,v2,12/15] mptcp: pm: reuse sending nlmsg code in
get_addr
13943886: [net-next,v2,13/15] mptcp: pm: drop skb parameter of set_flags
13943887: [net-next,v2,14/15] mptcp: pm: change rem type of set_flags
13943888: [net-next,v2,15/15] mptcp: pm: add local parameter for set_flags:
    - State: Changes requested
    - Series: mptcp: pm: misc cleanups, part 2
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=926564&state=*&archive=both
    - Matth will resent it to net-next when it will re-open

13949233: [mptcp-next,1/3] Squash to "bpf: Add mptcp_subflow bpf_iter"
13949234: [mptcp-next,2/3] Revert "bpf: Acquire and release mptcp socket"
13949235: [mptcp-next,3/3] Squash to "selftests/bpf: Add mptcp_subflow
bpf_iter subtest":
    - State: Under review
    - Series: Squash to "Add mptcp_subflow bpf_iter support"
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=928101&state=*&archive=both
    - Matth looked at it, Mat will also look at it

13951660: [mptcp-net] selftests: mptcp: connect: -f: no reconnect:
    - State: New
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250127-selftests-mptcp-fastclose-tests-v1-1-787609c66612@kernel.org/
    - Mat will review it → Done



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from the last meeting: 539):

  541  KMSAN: uninit-value in `mptcp_incoming_options` (2) [bug]
[syzkaller] @pabeni:
      - already closed

  540  [syzkaller] WARNING in `mptcp_pm_nl_set_flags` (2) [bug]
[syzkaller] [reproducer] @matttbe:
      - already closed


    Bugs (opened, flagged as "bug" and assigned)

  529  BUG: sleeping function called from invalid context in BPF sched
selftests [bug] [selftests] [sched] [bpf] @geliangtang
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
  501  Why do endpoint tcp connections close? [bug] [feedback-needed]
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
  502  Question for ip-mptcp command [question]
  489  IPv6 Rejoin Subflow [question]
  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned)

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


    Recently closed (since 2025-01-15)

  541  KMSAN: uninit-value in `mptcp_incoming_options` (2) [bug]
[syzkaller] @pabeni
  540  [syzkaller] WARNING in `mptcp_pm_nl_set_flags` (2) [bug]
[syzkaller] [reproducer] @matttbe
  539  WARN in `__mptcp_fastopen_gen_msk_ackseq()`: sock owned by user
[bug] @pabeni
  537  [syzkaller] WARNING in `__mptcp_clean_una` (2) [bug] [syzkaller]
[reproducer] [bisected] @pabeni



    Packetdrill PRs

  52  13 days ago  dcaratti  Add initial coverage for RM_ADDR


    mptcp.dev PRs

  /

    mptcpd PRs

  314  1 day ago  matttbe  musl compat:
      - new version proposed with fixes asked by Ossama



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.15):
https://github.com/orgs/multipath-tcp/projects/13
    - For later: https://github.com/orgs/multipath-tcp/projects/1
    - ChangeLog has been updated for v6.14:
        https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog



Patches to send to NetDev:

    - Fixes for other trees:

        - [894ec68b8240] mm: kmemleak: Fix upper boundary check for
physical address objects (Catalin Marinas):
            - to fix a false positive

    - Fixes for -net:

        - [67444f4daa2c] doc: mptcp: sysctl: blackhole_timeout is
per-netns (Matthieu Baerts (NGI0))
        - [087c73ed93c7] mptcp: blackhole only if 1st SYN retrans w/o
MPC is accepted (Matthieu Baerts (NGI0)):
            - already sent


    - Fixes for net-next: /


    - Features for net-next:

        - [dd103c92f733] mptcp: consolidate subflow cleanup (Paolo Abeni)
        - [87085e3b432e] mptcp: drop __mptcp_fastopen_gen_msk_ackseq()
(Paolo Abeni)
        - [bf407d721884] mptcp: move the whole rx path under msk socket
lock protection (Paolo Abeni)
        - [b4dd9939f4fe] mptcp: cleanup mem accounting (Paolo Abeni)
        - [ee89424e0a5c] net: dismiss sk_forward_alloc_get() (Paolo Abeni)
        - [b25fd4ebb44a] mptcp: dismiss __mptcp_rmem() (Paolo Abeni)
        - [6f1b55083986] mptcp: micro-optimize __mptcp_move_skb() (Paolo
Abeni)
        - [f8a9e455306f] mptcp: pm: drop info of
userspace_pm_remove_id_zero_address (Geliang Tang)
        - [fa8d02cf6c2a] mptcp: pm: userspace: flags: clearer msg if no
remote addr (Matthieu Baerts (NGI0))
        - [17043d6c4172] mptcp: pm: more precise error messages
(Matthieu Baerts (NGI0))
        - [7b1970d994ca] mptcp: pm: improve error messages (Matthieu
Baerts (NGI0))
        - [56d87b3a6491] mptcp: pm: userspace: use GENL_REQ_ATTR_CHECK
(Geliang Tang)
        - [066fe4b00284] mptcp: pm: remove duplicated error messages
(Matthieu Baerts (NGI0))
        - [0e64391d8433] mptcp: pm: mark missing address attributes
(Matthieu Baerts (NGI0))
        - [984f9d56a9b4] mptcp: pm: use NL_SET_ERR_MSG_ATTR when
possible (Matthieu Baerts (NGI0))
        - [e595d52aeba3] mptcp: pm: make three pm wrappers static
(Geliang Tang)
        - [5292606da531] mptcp: pm: drop skb parameter of get_addr
(Geliang Tang)
        - [fb88a91dd260] mptcp: pm: add id parameter for get_addr
(Geliang Tang)
        - [86c6e1174c1f] mptcp: pm: reuse sending nlmsg code in get_addr
(Geliang Tang)
        - [a165aefc78d5] mptcp: pm: drop skb parameter of set_flags
(Geliang Tang)
        - [c41f13967421] mptcp: pm: change rem type of set_flags
(Geliang Tang)
        - [f99ddf1fa513] mptcp: pm: add local parameter for set_flags
(Geliang Tang)
        - [ca724d579267] mptcp: pm: remove unused ret value to set flags
(Matthieu Baerts (NGI0))
        - [df2ad169d9e0] mptcp: pm: change to fullmesh only for
'subflow' (Matthieu Baerts (NGI0))
        - [04d37feb59ab] mptcp: blackhole: avoid checking the state
twice (Matthieu Baerts (NGI0))
        - [74cc3d27bee8] mptcp: add a build check for
userspace_pm_dump_addr (Geliang Tang)
        - [3bfe349390e2] mptcp: add mptcp_pm_genl_fill_addr helper
(Geliang Tang)
        - [5b3f0f5750d1] mptcp: drop match in
userspace_pm_append_new_local_addr (Geliang Tang)
        - [f3bddf1c232e] mptcp: drop inet6_sk after inet_sk (Geliang Tang)
        - [d84577bdb11c] mptcp: use ipv6_addr_equal in addresses_equal
(Geliang Tang):
            - net-next is closed for the moment


    - Features for net-next (next): /


    - Features for other trees:

        - [cae12e47cbc8] bpf: Extend bpf_skc_to_mptcp_sock to MPTCP sock
(Geliang Tang)
        - [e44bd7105eed] bpf: Allow use of skc_to_mptcp_sock in
cg_sockopt (Geliang Tang)
        - [7f9089d03624] bpf: Register mptcp common kfunc set (Geliang Tang)
        - [82627189e2d3] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [601e93b2d3af] bpf: Acquire and release mptcp socket (Geliang
Tang)
        - [bd73dc6b9417] selftests/bpf: More endpoints for endpoint_init
(Geliang Tang)
        - [9fb7d003ad7b] selftests/bpf: Add mptcp_subflow bpf_iter
subtest (Geliang Tang):
            - new version in progress

        - [85f3662d076c] selftests/bpf: Drop cgroup_fd of run_mptcpify
(Geliang Tang)
        - [8ab630dbadb2] mptcp: add sched_data helpers (Geliang Tang)
        - [cc36a049d4aa] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [73419e94b1f6] bpf: Export mptcp packet scheduler helpers
(Geliang Tang)
        - [fd830337c568] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [9043877c3928] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [8bff047105cc] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [7b39b47a1af0] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [5a4f2f522377] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [d0013c2d3e90] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang)



Extra tests:
    - news about Syzkaller? (Christoph):
        - Still broken :'(

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp



Patches for stable:
    - OK to send "mptcp: prevent excessive coalescing on receive" to
stable?:

https://github.com/multipath-tcp/mptcp_net-next/commit/56b824eb49d625
        - OK for Paolo to send it around the rc1
        - TODO: Matth: send it next week



Netdev 0x19:
    - Dates: March 10th-13th.
    - Location: Zagreb Fair - Avenija Dubrovnik 15, 10020, Zagreb, Croatia.
    - Who will be there? Maybe Christoph, Matth, others?



FOSDEM 25:
    - Community meetup on Saturday
    -
https://fosdem.org/2025/schedule/event/fosdem-2025-6750-mptcp-community-meetup-bof/



Blog:
    - New post: https://blog.mptcp.dev/2025/01/27/one-year-NGI0-Core.html



Next meeting:
    - Next one on Wednesday, the 12th of February.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20250212



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you soon,
Matt
-- 
Sponsored by the NGI0 Core fund.

