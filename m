Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45753374CC
	for <mptcp@lists.linux.dev>; Sat, 21 Dec 2024 11:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734780751; cv=none; b=EgG7yKYKLr8akj1/iviG+h3hkGNV9pUYwVH5H6G5uVDc6GnbDiFiV7hn/I39c9cwZnkzR6H1OFawZgUBCg+kYFM0OyH5TcX5jOWELDO+zNzRVZYSNKnbMRSC2c3VUQmhtaaapjaPzip0sD8nN+Sn1EMR+L85ZpzqQPZ9uZn3Wzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734780751; c=relaxed/simple;
	bh=n77PdpdwIiwQgUxfVMwgXOBmu40xb9vVmDJT0YKzpW0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=pT+gyWwyqHvhu9TMzu7RXpr4FpQSKinHKVzyqr0IDSgNY87vN6KXmXWj+HSuZBLvUtSwjMah+/LqNsLmQmT8RaGCWkmbFW6t6vK2Vdt8bTKLUcdEXgauqgBWBNcj66v24I8isKRub/JhJs2mS5XchjrXCz0mvUeEO9o4Y/FoIgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuSlkvvt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuSlkvvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E97CC4CECE
	for <mptcp@lists.linux.dev>; Sat, 21 Dec 2024 11:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734780750;
	bh=n77PdpdwIiwQgUxfVMwgXOBmu40xb9vVmDJT0YKzpW0=;
	h=Date:To:From:Subject:From;
	b=LuSlkvvtW2x/rEAZfDmitNcPQsM/CJv3vN9LDWj8iW7zimzt9yA66kKtSQxRXf7P5
	 +fHsTNwsxnSm2nZEXIQjoBLAzxJ59vCaNTt9VfS7R9JZif25XFn2ypq1sElrBRlEET
	 HIVdzpsnd1Si75Vf9VI7wgeyi03+htyzUq7djSAuWtkkh6qnKarF4kF9W/CZdQewrK
	 fZa+DVUlS11T7mjzbcS0GlwPoo+JBQjM5XVoJcfNC8+DAxdLM07zYgs3sZVn7EOmSz
	 mEvailzsT5oQVRK0WTpnxoCaM7dIIoRtyy32k5T90ycidyadWFvwJX/UBZDYW90vek
	 bC5N7luFYA4gA==
Message-ID: <3775f729-dffd-4ecc-8dde-dfce17e775bf@kernel.org>
Date: Sat, 21 Dec 2024 12:32:28 +0100
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
Subject: [Weekly meetings] MoM - 18th of December 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
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


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13884930: [6.6.y] mptcp: fix possible integer overflow in
mptcp_reset_tout_timer:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241125140450.3752859-2-matttbe@kernel.org/

13884931: [6.1.y] mptcp: fix possible integer overflow in
mptcp_reset_tout_timer:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241125140524.3753666-2-matttbe@kernel.org/

13899476: [net] tcp: check space before adding MPTCP SYN options:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241209-net-mptcp-check-space-syn-v1-1-2da992bb6f74@kernel.org/

13907805: [net-next,1/7] mptcp: add mptcp_userspace_pm_lookup_addr helper
13907806: [net-next,2/7] mptcp: add mptcp_for_each_userspace_pm_addr macro
13907807: [net-next,3/7] mptcp: add mptcp_userspace_pm_get_sock helper
13907808: [net-next,4/7] mptcp: move mptcp_pm_remove_addrs into pm_userspace
13907809: [net-next,5/7] mptcp: drop free_list for deleting entries
13907810: [net-next,6/7] mptcp: change local addr type of subflow_destroy
13907811: [net-next,7/7] mptcp: drop useless "err = 0" in subflow_destroy:
    - Series: mptcp: pm: userspace: misc cleanups
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=917749&state=*&archive=both


    our repo (by: Geliang Tang):

13894758: [mptcp-next,v4,1/7] mptcp: add mptcp_userspace_pm_lookup_addr
helper
13894759: [mptcp-next,v4,2/7] mptcp: add
mptcp_for_each_userspace_pm_addr macro
13894760: [mptcp-next,v4,3/7] mptcp: add mptcp_userspace_pm_get_sock helper
13894762: [mptcp-next,v4,4/7] mptcp: move mptcp_pm_remove_addrs into
pm_userspace
13894761: [mptcp-next,v4,5/7] mptcp: drop free_list for deleting entries
13894763: [mptcp-next,v4,6/7] mptcp: change local addr type of
subflow_destroy
13894764: [mptcp-next,v4,7/7] mptcp: drop useless "err = 0" in
subflow_destroy:
    - Series: BPF path manager, part 1
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=914798&state=*&archive=both

13902794: [mptcp-next,v5,1/5] bpf: Extend bpf_skc_to_mptcp_sock to MPTCP
sock
13902795: [mptcp-next,v5,2/5] bpf: Allow use of skc_to_mptcp_sock in
cg_sockopt
13902796: [mptcp-next,v5,3/5] Squash to "bpf: Register mptcp common
kfunc set"
13902797: [mptcp-next,v5,4/5] Squash to "bpf: Add mptcp_subflow bpf_iter"
13902798: [mptcp-next,v5,5/5] Squash to "selftests/bpf: Add
mptcp_subflow bpf_iter subtest":
    - Series: Squash to "Add mptcp_subflow bpf_iter support"
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=916627&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Yunsheng Lin):

13897129: [net-next,v2,09/10] net: replace page_frag with page_frag_cache

13868390: [bpf-next/net,1/5] bpf: Register mptcp common kfunc set
13868391: [bpf-next/net,2/5] bpf: Add mptcp_subflow bpf_iter
13868392: [bpf-next/net,3/5] bpf: Acquire and release mptcp socket
13868393: [bpf-next/net,4/5] selftests/bpf: More endpoints for endpoint_init
13868416: [bpf-next/net,5/5] selftests/bpf: Add mptcp_subflow bpf_iter
subtest:
    - State: Changes requested
    - Series: bpf: Add mptcp_subflow bpf_iter support
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=907856&state=*&archive=both
    - TODO: Matth: send new version: Done


    our repo (by: Gang Yan, Geliang Tang, Gregory Detal, Matthieu
Baerts, Paolo Abeni):

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
    - State: Changes requested
    - Series: BPF path manager
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=901761&state=*&archive=both

13865804: [mptcp-next,v3,1/5] selftests/bpf: Add mptcp pm_nl_ctl link
13865805: [mptcp-next,v3,2/5] selftests/bpf: Use pm_nl_ctl if ip mptcp
not supported
13865806: [mptcp-next,v3,3/5] bpf: Add mptcp_userspace_pm_addr bpf_iter
13865807: [mptcp-next,v3,4/5] bpf: Export more helpers for
mptcp_userspace_pm_addr test
13865808: [mptcp-next,v3,5/5] selftests/bpf: Add mptcp_userspace_pm_addr
bpf_iter subtest:
    - State: Needs ack
    - Series: add mptcp_address bpf_iter
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=907195&state=*&archive=both
    - status: same

13881593: [mptcp-next,1/8] mptcp: split get_subflow interface into two
13881594: [mptcp-next,2/8] Squash to "selftests/bpf: Add bpf_first
scheduler & test"
13881595: [mptcp-next,3/8] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
13881596: [mptcp-next,4/8] Squash to "selftests/bpf: Add bpf_rr
scheduler & test"
13881597: [mptcp-next,5/8] Squash to "selftests/bpf: Add bpf_red
scheduler & test"
13881598: [mptcp-next,6/8] Squash to "selftests/bpf: Add bpf_burst
scheduler & test"
13881599: [mptcp-next,7/8] Squash to "bpf: Export mptcp packet scheduler
helpers"
13881600: [mptcp-next,8/8] Squash to "selftests/bpf: Add bpf_burst
scheduler & test":
    - State: Needs ack
    - Series: split get_subflow interface into two
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=911397&state=*&archive=both

13897106: [mptcp-next,v2,1/7] mptcp: prevent excessive coalescing on receive
13897107: [mptcp-next,v2,2/7] tcp: fix recvbuffer adjust on sleeping rcvmsg
13897108: [mptcp-next,v2,3/7] mptcp: don't always assume copied data in
mptcp_cleanup_rbuf()
13897109: [mptcp-next,v2,4/7] mptcp: consolidate subflow cleanup
13897110: [mptcp-next,v2,5/7] mptcp: move the whole rx path under msk
socket lock protection
13897111: [mptcp-next,v2,6/7] mptcp: cleanup mem accounting.
13897112: [mptcp-next,v2,7/7] net: dismiss sk_forward_alloc_get():
    - State: Under review
    - Series: mptcp: rx path refactor
    - Submitter: Paolo Abeni
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=915337&state=*&archive=both

13900810: [mptcp-next,v11,1/9] bpf: Add bpf_mptcp_send_info_to_ssk
13900811: [mptcp-next,v11,2/9] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
13900812: [mptcp-next,v11,3/9] Squash to "selftests/bpf: Add bpf_rr
scheduler & test"
13900813: [mptcp-next,v11,4/9] Squash to "selftests/bpf: Add bpf_red
scheduler & test"
13900814: [mptcp-next,v11,5/9] Squash to "selftests/bpf: Add bpf_burst
scheduler & test"
13900815: [mptcp-next,v11,6/9] Squash to "selftests/bpf: Add bpf_first
scheduler & test"
13900816: [mptcp-next,v11,7/9] Revert "mptcp: add sched_data helpers"
13900818: [mptcp-next,v11,8/9] Squash to "bpf: Export mptcp packet
scheduler helpers"
13900817: [mptcp-next,v11,9/9] mptcp: drop subflow contexts in
mptcp_sched_data:
13906638: [mptcp-next] Squash to "bpf: Add bpf_mptcp_send_info_to_ssk":
    - State: New
    - Series: use bpf_iter in bpf schedulers
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=916204&state=*&archive=both

13903215: [mptcp-next] mptcp: fix invalid addr occupy 'add_addr_accepted':
    - State: New
    - Submitter: Gang Yan
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/tencent_0FE3ED0442E69C9D86C0AEEE338A49F90305@qq.com/

13905650: [mptcp-next,1/2] mptcp: dismiss __mptcp_rmem()
13905651: [mptcp-next,2/2] mptcp: micro-optimize __mptcp_move_skb():
    - State: New
    - Series: mptcp: rx refactor follow-ups
    - Submitter: Paolo Abeni
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=917303&state=*&archive=both

13906630: [mptcp-next,v2,1/8] mptcp: make three pm wrappers static
13906631: [mptcp-next,v2,2/8] mptcp: drop skb parameter of get_addr
13906632: [mptcp-next,v2,3/8] mptcp: add id parameter for get_addr
13906633: [mptcp-next,v2,4/8] mptcp: reuse sending nlmsg code in get_addr
13906634: [mptcp-next,v2,5/8] mptcp: change info of get_addr as const
13906635: [mptcp-next,v2,6/8] mptcp: add info parameter for dump_addr
13906636: [mptcp-next,v2,7/8] mptcp: add mptcp_pm_addr_id_bitmap_t type
13906637: [mptcp-next,v2,8/8] mptcp: reuse sending nlmsg code in dump_addr:
    - State: New
    - Series: BPF path manager, part 2
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=917487&state=*&archive=both
    - TODO: Matth: look at it

13909382: [mptcp-next,v3] mptcp: use GENL_REQ_ATTR_CHECK for token:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/d9c76c6c008c770046f665a4a4e93735fd121399.1734337790.git.tanggeliang@kylinos.cn/

13909518: [mptcp-net,v2,1/3] netlink: specs: mptcp: add missing
'server-side' attr
13909519: [mptcp-net,v2,2/3] netlink: specs: mptcp: clearly mention
attributes
13909520: [mptcp-net,v2,3/3] netlink: specs: mptcp: fix missing doc:
    - State: Queued
    - Series: netlink: specs: mptcp: events: missing and clearer attr
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=918161&state=*&archive=both



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 530):

  536  PM: new subflow: avoid selecting initial endpoint upon `ADD_ADDR`
reception if servers deny MPJ to initial address [enhancement] [pm]:
      - otherwise, the other interfaces are likely never used

  535  TCPDump: display `MP_CAPABLE` C flag [enhancement]:
      - This flag is not displayed if set. It is important, it should be
shown.

  532  Userspace PM doesn't have access to `allow_join_id0` /
`allow_join_initial_addr_port` bit from the SYN-ACK [enhancement]:
      - The userspace daemon doesn't know if the C flag has been set or not


   Syzbot reports:
    - general protection fault in put_page (4):
        - https://syzkaller.appspot.com/bug?extid=38a095a81f30d82884c1
        - Matth is trying to bisect this: the one reported on syzbot
side looks wrong → Paolo found the issue

    - [syzbot] [mptcp?] WARNING in __mptcp_clean_una (2):
        - https://syzkaller.appspot.com/bug?extid=ebc0b8ae5d3590b2c074
        - Not urgent, but needs to be fixed


   Recently discussed:

  530  about mptcp subflow creation question [question]
[feedback-needed] [triage]:
      - probably an old kernel being used

  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement
`add_addr_accepted` [bug] [pm] @geliangtang:
      - recently assigned to Geliang (his colleague)
      - See patch above


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


    Recently closed (since 2024-12-04)

  534  Kernel built-in PM is unreliable [bug]:
      - fixed after having updated the kernel

  533  Userspace PM can't specify if_idx on MPTCP_PM_CMD_SUBFLOW_CREATE
[bug]:
      - fixed after having updated the kernel

  531  Issue creating subflow 2/ backup subflow to a remote endpoint
[question] [triage]:
      - limits were too low


    Packetdrill PRs

  52  3 years ago  dcaratti  Add initial coverage for RM_ADDR


    mptcp.dev PRs

  38  1 hour ago  matttbe  faq: enable MPTCP support with OpenSSH:
    - Mat will look at it


    mptcpd PRs

  316  26 days ago  matttbe  mptcpize: set `GODEBUG=multipathtcp=1` env var
  315  26 days ago  matttbe  mptcpize: do not override existing
LD_PRELOAD value
  314  13 days ago  matttbe  musl compat



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.14):
https://github.com/orgs/multipath-tcp/projects/12
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees: /


    - Fixes for -net: /


    - Fixes for net-next: /


    - Features for net-next: /


    - Features for net-next (next): /


    - Features for other trees:

        - [1baca73d317d] bpf: Extend bpf_skc_to_mptcp_sock to MPTCP sock
(Geliang Tang)
        - [04eb1bd60525] bpf: Allow use of skc_to_mptcp_sock in
cg_sockopt (Geliang Tang)
        - [bfb93727315c] bpf: Register mptcp common kfunc set (Geliang Tang)
        - [c12fb7b60a4b] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [4bbef03b1190] bpf: Acquire and release mptcp socket (Geliang
Tang)
        - [41322b880f9b] selftests/bpf: More endpoints for endpoint_init
(Geliang Tang)
        - [d4e01cad6922] selftests/bpf: Add mptcp_subflow bpf_iter
subtest (Geliang Tang):
            - TODO: Matth: send them → Done

        - [3e0343ae4130] mptcp: add sched_data helpers (Geliang Tang)
        - [e5c02d367e7c] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [003917aaa225] bpf: Export mptcp packet scheduler helpers
(Geliang Tang)
        - [de0f9a631883] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [21eaba6c8e4d] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [3835105b6fcf] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [854af0bf3065] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [f1e68ce61a16] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [e539983859ce] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang)



Extra tests:
    - news about Syzkaller? (Christoph):
        - Christoph is looking at having it back

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp



Next meeting:
    - Next meeting 1st of January is obviously cancelled.
    - Next one on Wednesday, the 15th of January.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20250115



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you in 2025,
Matt
-- 
Sponsored by the NGI0 Core fund.

