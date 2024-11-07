Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7BB217F32
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731010380; cv=none; b=e0+MFcZAZ4UikVwA7iWQ7WLR6HYVaD872hbgt01wtuIkDBx5NsQNe+3oHICd6Avdjjt1Vf9shh3svBIMtNMqsNPeLE2cRgPT9TFNZAPrYJPiw8Vp74a51doG40OFRqGYtIo7Fbmk13pqgNqgxlvSv4xElwabb3o44G8JgjLgVcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731010380; c=relaxed/simple;
	bh=ICwIgE3DSW/Gk9iIUmhBZXm6H5eDqlTc51+moUqplc8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=GlUKczMQcishliFYMV4NqSpx6wTTYFGc+/S0+37egpfkZLs+SvMvopTAR35LOEeO+kfs+JsSH8eZJeNdJqDreYFl3bz2ZaLuS/oRjn3GwfLrc2+O7ouM5iM5vxyEhwcpCffTr3DWusBmykxwiAWKMt9GgM7cTRNyP+Sd9rH0ODA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBSJTws+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBSJTws+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4171C4CECC
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 20:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731010380;
	bh=ICwIgE3DSW/Gk9iIUmhBZXm6H5eDqlTc51+moUqplc8=;
	h=Date:To:From:Subject:From;
	b=UBSJTws+a4MRSh3OGhFXV3FhGUf4j4xYYjF2/FObHdTrsiFKTAiaelvVsQqgqlOVj
	 7mwXDPlOi/eMgR+gqA8KWRFR0LfEIKRPKjXnfWRX/R0pdxayBmmbCrsAnZkrgqZldD
	 hN6DDZZJ6sAF6fS6CPq3R1DZAN1vGumROEkW3vCla5uhhoscWIBuAyuqaOk/ny/vWS
	 2Lt6ZZeNvOyw2tj6Z6Oaw+siX+4ZPTtOUShYkhMKz5ON64Z6H5lsQNUkHpIMaexf1c
	 oAQV5+iM5jfLbuFUwIGu2QvLLkLRzTApo66Vz3ZJsq3b8MSx01FvbR/+C0KmpXV1IF
	 w2dal1CG61EkQ==
Message-ID: <9b4827b5-aa64-4e64-ad7d-ee36c2bef25b@kernel.org>
Date: Thu, 7 Nov 2024 21:12:57 +0100
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
Subject: [Weekly meetings] MoM - 6th of November 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our new meeting with Mat (Cruise), Paolo (Redhat), and
myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Matthieu Baerts):

13843828: [net,1/3] mptcp: init: protect sched with rcu_read_lock
13843830: [net,3/3] selftests: mptcp: list sysctl data:
    - Series: mptcp: sched: fix some lock issues
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=901302&state=*&archive=both

13844310: [net-next,1/4] mptcp: pm: send ACK on non-stale subflows
13844311: [net-next,2/4] mptcp: annotate data-races around
subflow->fully_established
13844312: [net-next,3/4] mptcp: implement mptcp_pm_connection_closed
13844313: [net-next,4/4] mptcp: use "middlebox interference" RST when no
DSS:
    - Series: mptcp: various small improvements
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=901451&state=*&archive=both

13857407: [bpf-next/net,v3] selftests/bpf: Drop netns helpers in mptcp:
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/c02fda3177b34f9e74a044833fda9761627f4d07.1730338692.git.tanggeliang@kylinos.cn/

13861259: [net-next] selftests: net: include lib/sh/*.sh with lib.sh:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241104-net-next-selftests-lib-sh-deps-v1-1-7c9f7d939fc2@kernel.org/

13861314: [net,1/2] mptcp: no admin perm to list endpoints
13861315: [net,2/2] mptcp: use sock_kfree_s instead of kfree:
    - Series: mptcp: pm: fix wrong perm and sock kfree
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=906038&state=*&archive=both

13861334: [net-next,v2] mptcp: remove unneeded lock when listing scheds:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241104-net-next-mptcp-sched-unneeded-lock-v2-1-2ccc1e0c750c@kernel.org/


    our repo (by: Geliang Tang):

13855896: [mptcp-next,v4,1/4] selftests/bpf: Drop netns helpers in mptcp
13855897: [mptcp-next,v4,2/4] Squash to "selftests/bpf: Add
mptcp_subflow bpf_iter subtest"
13855898: [mptcp-next,v4,3/4] Squash to "selftests/bpf: Add bpf
scheduler test"
13855899: [mptcp-next,v4,4/4] Squash to "selftests/bpf: Add bpf_first
scheduler & test":
    - Series: add netns helpers
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=904491&state=*&archive=both

13857664: [mptcp-net] mptcp: use sock_kfree_s instead of kfree:
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/6a3e3dd94642cf24f3d6f97fb869d77d7315d5af.1730360928.git.tanggeliang@kylinos.cn/

13863887: [mptcp-net,v2,1/2] mptcp: update local address flags when
setting it
13863888: [mptcp-net,v2,2/2] mptcp: hold pm lock when deleting entry:
    - Series: fixes for userspace pm
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=906742&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Yunsheng Lin):

13853386: [RFC,09/10] net: replace page_frag with page_frag_cache

13863942: mptcp: remove the redundant assignment of 'new_ctx->tcp_sock'
in subflow_ulp_clone():
    - State: New
    - Submitter: MoYuanhao
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241106071035.2591-1-moyuanhao3676@163.com/
    - Can be applied in net-next directly

    our repo (by: Breno Leitao, Geliang Tang, Gregory Detal, Matthieu
Baerts, MoYuanhao, Tao Chen):

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
    - Status: same

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
    - Status: same

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
    - Status: same

13656189: [mptcp-net,v2] mptcp: fix the default value of scaling_ratio:
    - State: Changes requested
    - Submitter: Geliang Tang

13863942: mptcp: remove the redundant assignment of 'new_ctx->tcp_sock'
in subflow_ulp_clone():
    - State: New
    - Submitter: MoYuanhao
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241106071035.2591-1-moyuanhao3676@163.com/
    - Can be applied in net-next directly
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn/
    - Status: same

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
    - Status: same

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
    - Status: same


13845248: [mptcp-next,v2,1/5] selftests/bpf: Add mptcp pm_nl_ctl link
13845249: [mptcp-next,v2,2/5] selftests/bpf: Use pm_nl_ctl if ip mptcp
not supported
13845250: [mptcp-next,v2,3/5] bpf: Add mptcp_address bpf_iter
13845251: [mptcp-next,v2,4/5] bpf: Export more helpers used by
mptcp_address test
13845252: [mptcp-next,v2,5/5] selftests/bpf: Add mptcp_address bpf_iter
subtest:
    - State: Needs ack
    - Series: add mptcp_address bpf_iter
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=901713&state=*&archive=both

13863942: mptcp: remove the redundant assignment of 'new_ctx->tcp_sock'
in subflow_ulp_clone():
    - State: New
    - Submitter: MoYuanhao
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241106071035.2591-1-moyuanhao3676@163.com/
    - Can be applied in net-next directly

13845376: [mptcp-next,v2,03/36] mptcp: add mptcp_for_each_address macros
13845378: [mptcp-next,v2,05/36] mptcp: add lookup_addr for userspace pm
13845379: [mptcp-next,v2,06/36] mptcp: add mptcp_userspace_pm_get_sock
helper
13845380: [mptcp-next,v2,07/36] mptcp: make three pm wrappers static
13845381: [mptcp-next,v2,08/36] mptcp: drop skb parameter of get_addr
13845382: [mptcp-next,v2,09/36] mptcp: add id parameter for get_addr
13845383: [mptcp-next,v2,10/36] mptcp: add addr parameter for get_addr
13845384: [mptcp-next,v2,11/36] mptcp: reuse sending nlmsg code in get_addr
13845385: [mptcp-next,v2,12/36] mptcp: change info of get_addr as const
13845386: [mptcp-next,v2,13/36] mptcp: add struct mptcp_id_bitmap
13845387: [mptcp-next,v2,14/36] mptcp: refactor dump_addr with id bitmap
13845388: [mptcp-next,v2,15/36] mptcp: refactor dump_addr with get_addr
13845389: [mptcp-next,v2,16/36] mptcp: reuse sending nlmsg code in dump_addr
13845391: [mptcp-next,v2,18/36] mptcp: change rem type of set_flags
13845392: [mptcp-next,v2,19/36] mptcp: drop skb parameter of set_flags
13845393: [mptcp-next,v2,20/36] mptcp: add loc and rem for set_flags
13845394: [mptcp-next,v2,21/36] mptcp: update address type of get_local_id
13845395: [mptcp-next,v2,22/36] mptcp: change is_backup interfaces as
get_flags
13845396: [mptcp-next,v2,23/36] mptcp: drop struct mptcp_pm_local
13845397: [mptcp-next,v2,24/36] mptcp: drop struct mptcp_pm_add_entry
13845398: [mptcp-next,v2,25/36] mptcp: change local type of subflow_destroy
13845400: [mptcp-next,v2,27/36] mptcp: rename mptcp_pm_remove_addrs
13845401: [mptcp-next,v2,28/36] mptcp: drop free_list for deleting entries
13845402: [mptcp-next,v2,29/36] mptcp: define struct mptcp_pm_ops
13845403: [mptcp-next,v2,30/36] mptcp: implement userspace pm interfaces
13845404: [mptcp-next,v2,31/36] mptcp: register default userspace pm
13845405: [mptcp-next,v2,32/36] bpf: Add mptcp path manager struct_ops
13845406: [mptcp-next,v2,33/36] bpf: Register mptcp struct_ops kfunc set
13845407: [mptcp-next,v2,34/36] Squash to "bpf: Export mptcp packet
scheduler helpers"
13845408: [mptcp-next,v2,35/36] selftests/bpf: Add mptcp userspace pm
subtest
13845409: [mptcp-next,v2,36/36] selftests/bpf: Add mptcp bpf path
manager subtest:
    - State: Under review
    - Series: BPF path manager
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=901761&state=*&archive=both
    - Matth did a review of the 28 first patches, we might split the
series after to ease the reviews

13850314: [mptcp-net,v2,1/3] mptcp: pm: use _rcu variant under rcu_read_lock
13850315: [mptcp-net,v2,2/3] mptcp: pm: lockless list traversal
13850316: [mptcp-net,v2,3/3] mptcp: pm: avoid code duplication to lookup
endp:
    - State: Changes requested
    - Series: mptcp: pm: use _rcu variant under rcu_read_lock
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=903060&state=*&archive=both
    - some modifications needed there.

13855939: [mptcp-next,v9,01/13] mptcp: check sk_stream_memory_free in loop
13855940: [mptcp-next,v9,02/13] mptcp: make mptcp_subflow_set_scheduled
inline
13855941: [mptcp-next,v9,03/13] mptcp: add mptcp_validate_scheduler helper
13855942: [mptcp-next,v9,04/13] Squash to "bpf: Add bpf_mptcp_sched_ops"
13855943: [mptcp-next,v9,05/13] Squash to "selftests/bpf: Add bpf
scheduler test"
13855944: [mptcp-next,v9,06/13] Squash to "selftests/bpf: Add bpf_first
scheduler & test"
13855945: [mptcp-next,v9,07/13] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
13855946: [mptcp-next,v9,08/13] Squash to "selftests/bpf: Add bpf_rr
scheduler & test"
13855947: [mptcp-next,v9,09/13] Squash to "selftests/bpf: Add bpf_red
scheduler & test"
13855948: [mptcp-next,v9,10/13] Squash to "selftests/bpf: Add bpf_burst
scheduler & test"
13855949: [mptcp-next,v9,11/13] Squash to "bpf: Export mptcp packet
scheduler helpers"
13855950: [mptcp-next,v9,12/13] Revert "mptcp: add sched_data helpers"
13855951: [mptcp-next,v9,13/13] mptcp: drop subflow contexts in
mptcp_sched_data:
    - State: New
    - Series: use bpf_iter in bpf schedulers
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=904507&state=*&archive=both

13856227: [bpf-next] selftests/bpf: Fix compile error when MPTCP not
support:
    - State: Changes requested
    - Submitter: Tao Chen
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241030100108.2443371-1-chen.dylane@gmail.com/
    - MPTCP is supposed to be supported.
    - We cannot support all possible kconfig: the test could be skipped
if MPTCP is not supported, but maybe this should be done in the
Makefile? No need to spend time on our side.
    - TODO: can be archived → Done

13856585: [net] mptcp: Ensure RCU read lock is held when calling
mptcp_sched_find():
    - State: Rejected
    - Submitter: Breno Leitao
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241030140224.972565-1-leitao@debian.org/
    - A fix for this issue was already applied

13861026: [mptcp-next] Squash to "DO-NOT-MERGE: mptcp: improve code
coverage for CI":
    - State: Rejected
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/ab62e7d2f50512594416acb973dcaf3d4ec85fe3.1730708911.git.geliang@kernel.org/
    - a different fix has been backported


Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


- Note: we have new template when creating a new issue:
    - https://github.com/multipath-tcp/mptcp_net-next/issues/new/choose
    - The bug template is a bit long: probably better to provide a list
of commands to run instead of having all the TODO + ask: run on client
and server side → Done
    - so people are less scared about filling info there


    Recently opened (latest from the last meeting: 526):

  528  Can't Find Balia, Lia, Olia congestion control selection in
menuconfig . [question]:
      - responsibility of the packet scheduler to use more or less a
path depending on the conditions
      - still, if people have use-cases to add CCA dedicated to MPTCP,
why not.

  527  MPTCP advanced options in Kernel configuration  [question] [triage]:
      - expected to see the same kconfig options as in the fork, but
they are either not needed, or in sysctl.

    Recently discussed:

  526  Question: MPTCP subflows are reconnected every now and then
[question]:
      - strange: the creation and removal of subflows should only be
caused by ip mptcp endpoint add/del
      - We can use this filter with Wireshark: netlink.family == 0x10
and genl.family_id == 0x15
      - e.g. 2505, we can see command 11: remove subflow
      - TODO: Matth: reply → Done

  525  tests: cover more MPTCP socket options [enhancement]
[packetdrill] [selftests]
  520  Question about proper MPTCP configuration over VPN. [question]
[feedback-needed]


    Bugs (opened, flagged as "bug" and assigned)

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
  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement
`add_addr_accepted` [bug] [pm]
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

  528  Can't Find Balia, Lia, Olia congestion control selection in
menuconfig . [question]
  527  MPTCP advanced options in Kernel configuration  [question] [triage]
  526  Question: MPTCP subflows are reconnected every now and then
[question]
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

  525  tests: cover more MPTCP socket options [enhancement]
[packetdrill] [selftests]
  524  tests: cover more Diag-related code [selftests]
  521  Implement psock_update_sk_prot, for eBPF SOCKMAP support
[enhancement]
  519  Reset the connection once "MPTCP has been verified" instead of a
fallback [enhancement]
  515  Add `TCP_MAXSEG` socket option support [enhancement]
  514  Add MIB counters for fallback to TCP [enhancement]
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


    Recently closed (since 2024-10-23)

None.


    Packetdrill PRs

  52  3 years ago  dcaratti  Add initial coverage for RM_ADDR


    mptcp.dev PRs: https://github.com/multipath-tcp/mptcp.dev/pulls

  31  6 days ago  matttbe  mptcp info: recommend using `TCP_IS_MPTCP`
  30  8 days ago  matttbe  apps: add 'Linux distributions' section


    mptcpd PRs

 /


FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.13):
https://github.com/orgs/multipath-tcp/projects/11
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees:

        - [c4ccd152f6fe] perf: Fix missing RCU reader protection in
perf_event_clear_cpumask() (Kan Liang)
        - [810bfce0f94c] netfilter: nf_tables: avoid false-positive
lockdep splat on rule deletion (Florian Westphal)
        - [5b55ef52d78b] selftests/bpf: Remove test_skb_cgroup_id.sh
from TEST_PROGS (Ihor Solodrai)
        - [316eb9d0eec9] selftests/bpf: Set vpath in Makefile to search
for skels (Ihor Solodrai)
            - Fixes for PROVE_RCU_LIST

    - Fixes for -net:

        - [e96551845552] mptcp: remove unneeded lock when listing scheds
(Matthieu Baerts (NGI0)):
            - has been applied but in net-next

        - [c93a012f7ac4] mptcp: update local address flags when setting
it (Geliang Tang)
        - [237a7eb31a83] mptcp: hold pm lock when deleting entry
(Geliang Tang)

    - Fixes for net-next: /

    - Features for net-next: /

    - Features for net-next (next): /

    - Features for other trees:

        - [c75acaa40fe2] selftests/bpf: Drop netns helpers in mptcp
(Geliang Tang):
            - already applied

        - [58e56f157a40] bpf: Register mptcp common kfunc set (Geliang Tang)
        - [74ab65210e7e] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [cf376dfef1ab] bpf: Acquire and release mptcp socket (Geliang
Tang)
        - [98b334305b35] selftests/bpf: More endpoints for endpoint_init
(Geliang Tang)
        - [b10ba15fe3b9] selftests/bpf: Add mptcp_subflow bpf_iter
subtest (Geliang Tang)
        - [73afbb9af8a1] mptcp: add sched_data helpers (Geliang Tang)
        - [2f1032450822] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [2debd9c9311e] bpf: Export mptcp packet scheduler helpers
(Geliang Tang)
        - [1addd13a5aca] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [25a99f695f5b] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [49189c7e4048] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [3e0527993e16] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [22f5b2293914] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [2b55cfd8aebb] selftests/bpf: Add bpf_burst scheduler & test
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
        - some tests are stuck: maybe best to have something running in
the background to print the stacktrace: TODO



mptcpd:
    - https://github.com/multipath-tcp/mptcpd/releases/tag/v0.13
    - Mainly fixing the compatibility with newer versions of ELL + some
small extra



Next meeting:
    - Next one on Wednesday, *in two weeks*, the 20th of November.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20241120



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.

