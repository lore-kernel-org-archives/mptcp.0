Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAE92E3EE
	for <mptcp@lists.linux.dev>; Fri, 22 Nov 2024 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732291691; cv=none; b=Q7Zek5TXwANeepM4jXnWQGlIr7jIT6zUe2Qe+2pj6ovF9wkT4QmLa3QlMaFO4s+/vOmPxyyqMSZMv7rbliZkmTqgdyR7GwpQOfs/Xm7o9inzGKuIMx8fmeLKsczwbg9O0RmYJANmVkuDOMwTSaQ35/7NfvieRRcOgHtZD5Viya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732291691; c=relaxed/simple;
	bh=aguCjlk/ntIdDMKTIM49iUtequrzizfFgMT26XR5Ni4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=hNePJTEsQnBH5wfHTAjkiaepNIXBfJ25Nqn4bngi6SRTol1OTXIBkc8K+nmxcIWO1e2BtOL61iUsDS79gVfFehFFhWoDjp9QwyK5hqW/5WD5MH7r1vFPtATvC4n6YeBCPeDSJCA2ndFmlkIxnqPqVg5n/k3/7J5dnx6IaXI4WFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsuImmNh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsuImmNh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101B5C4CECE
	for <mptcp@lists.linux.dev>; Fri, 22 Nov 2024 16:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732291690;
	bh=aguCjlk/ntIdDMKTIM49iUtequrzizfFgMT26XR5Ni4=;
	h=Date:From:Subject:To:From;
	b=bsuImmNhPhficNoBUmiJSx5oj2iVm9FY63Nfolc7vjDMZ/8361FvrTIagFElPwBxl
	 KucfTy8PJgbWush/Hbymnx3mt+BXFuX4Mt8YagrdxfzFP+2zY86nqjYn+Zqo4cYfp8
	 9ZEKHe8U/5lFrVA9u2t02mRfrK4swg4MoG3B4Xy7UoMoSnm3xF+7DTAGuwjzffIYXx
	 gALvkoI4vh7VKSg9OCw5CdqPnGFGzpq1EetEVRXD8qnrDWBr6vrQXjb3GDBF75/1bQ
	 +uDPokXWZEuYCk7qSlEd0XKDJiOY8DokqtEuEkIangFsY1vKPy+T0cU/pWRRjkth1X
	 6/QFHZNZs8m8Q==
Message-ID: <bcc3a101-3e4b-4630-b093-8aca509a6007@kernel.org>
Date: Fri, 22 Nov 2024 17:08:07 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 20th of November 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Linux <mptcp@lists.linux.dev>
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


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts (NGI0),
MoYuanhao, Paolo Abeni):

13863942: mptcp: remove the redundant assignment of 'new_ctx->tcp_sock'
in subflow_ulp_clone():
    - Submitter: MoYuanhao
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241106071035.2591-1-moyuanhao3676@163.com/

13868042: [net,1/2] mptcp: error out earlier on disconnect
13868041: [net,2/2] mptcp: cope racing subflow creation in
mptcp_rcv_space_adjust:
    - Series: mptcp: fix a couple of races
    - Submitter: Paolo Abeni
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=907752&state=*&archive=both

13872855: [net,1/3] mptcp: update local address flags when setting it
13872856: [net,2/3] mptcp: hold pm lock when deleting entry
13872857: [net,3/3] mptcp: pm: use _rcu variant under rcu_read_lock:
    - Series: mptcp: pm: a few more fixes
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=908997&state=*&archive=both

13876625: [net-next,1/2] mptcp: pm: lockless list traversal to dump endp
13876626: [net-next,2/2] mptcp: pm: avoid code duplication to lookup endp:
    - Series: mptcp: pm: lockless list traversal and cleanup
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=910081&state=*&archive=both

13878946: [6.6.y,1/6] mptcp: define more local variables sk
13878947: [6.6.y,2/6] mptcp: add userspace_pm_lookup_addr_by_id helper
13878948: [6.6.y,3/6] mptcp: update local address flags when setting it
13878949: [6.6.y,4/6] mptcp: hold pm lock when deleting entry
13878950: [6.6.y,5/6] mptcp: drop lookup_by_id in lookup_addr
13878951: [6.6.y,6/6] mptcp: pm: use _rcu variant under rcu_read_lock:
    - Series: mptcp: fix recent failed backports

13866141: mptcp: fix possible integer overflow in mptcp_reset_tout_timer:
    - Submitter: Dmitry Kandybka
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241107103657.1560536-1-d.kandybka@gmail.com/
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=910715&state=*&archive=both

13879489: [6.1.y,1/7] mptcp: cope racing subflow creation in
mptcp_rcv_space_adjust
13879490: [6.1.y,2/7] mptcp: define more local variables sk
13879491: [6.1.y,3/7] mptcp: add userspace_pm_lookup_addr_by_id helper
13879492: [6.1.y,4/7] mptcp: update local address flags when setting it
13879493: [6.1.y,5/7] mptcp: hold pm lock when deleting entry
13879494: [6.1.y,6/7] mptcp: drop lookup_by_id in lookup_addr
13879495: [6.1.y,7/7] mptcp: pm: use _rcu variant under rcu_read_lock:
    - Series: mptcp: fix recent failed backports
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=910861&state=*&archive=both

13879715: [5.15.y] mptcp: cope racing subflow creation in
mptcp_rcv_space_adjust:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241119105858.3494900-2-matttbe@kernel.org/

Note: when sending a patch to the stable ML, there is now a bot that do
some tests and show a diff:
    -
https://lore.kernel.org/stable/20241119144703.YiOgIY7yIthzQT-LJrSR-9tGvKTJn7NoUcgemj5KzBw@z/

13866141: mptcp: fix possible integer overflow in mptcp_reset_tout_timer:
    - Submitter: Dmitry Kandybka
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241107103657.1560536-1-d.kandybka@gmail.com/


    our repo (by: Matthieu Baerts (NGI0)):

13866037: [mptcp-net,v3,1/3] mptcp: pm: use _rcu variant under rcu_read_lock
13866038: [mptcp-net,v3,2/3] mptcp: pm: lockless list traversal to dump
endpoints
13866039: [mptcp-net,v3,3/3] mptcp: pm: avoid code duplication to lookup
endp:
    - Series: mptcp: pm: use _rcu variant under rcu_read_lock
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=907253&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Dmitry Kandybka, Dmitry Safonov
via B4 Relay, Yunsheng Lin):

13874162: [net,v2,1/5] net/diag: Do not race on dumping MD5 keys with
adding new MD5 keys
13874163: [net,v2,2/5] net/diag: Warn only once on EMSGSIZE
13874164: [net,v2,3/5] net/diag: Pre-allocate optional info only if
requested
13874166: [net,v2,4/5] net/diag: Always pre-allocate tcp_ulp info
13874165: [net,v2,5/5] net/netlink: Correct the comment on netlink
message max cap:
    - Series: Make TCP-MD5-diag slightly less broken
    - Submitter: Dmitry Safonov via B4 Relay
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=909394&state=*&archive=both
    - Looks good, the modification in MPTCP is the same as done elsewhere

13875089: [net-next,v1,09/10] net: replace page_frag with page_frag_cache

13868390: [bpf-next/net,1/5] bpf: Register mptcp common kfunc set
13868391: [bpf-next/net,2/5] bpf: Add mptcp_subflow bpf_iter
13868392: [bpf-next/net,3/5] bpf: Acquire and release mptcp socket
13868393: [bpf-next/net,4/5] selftests/bpf: More endpoints for endpoint_init
13868416: [bpf-next/net,5/5] selftests/bpf: Add mptcp_subflow bpf_iter
subtest:
    - State: Changes requested
    - Series: bpf: Add mptcp_subflow bpf_iter support
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=907856&state=*&archive=both


    our repo (by: Geliang Tang, Gregory Detal, Matthieu Baerts, Matthieu
Baerts (NGI0)):

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
    - skip: status is the same as before

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
    - skip: status is the same as before

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
    - skip: status is the same as before

13656189: [mptcp-net,v2] mptcp: fix the default value of scaling_ratio:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn/
    - skip: status is the same as before

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
    - skip: status is the same as before

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
    - skip: status is the same as before

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
    - wait for the other patches to be applied first

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
    - State: Changes requested
    - Series: use bpf_iter in bpf schedulers
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=904507&state=*&archive=both

13865804: [mptcp-next,v3,1/5] selftests/bpf: Add mptcp pm_nl_ctl link
13865805: [mptcp-next,v3,2/5] selftests/bpf: Use pm_nl_ctl if ip mptcp
not supported
13865806: [mptcp-next,v3,3/5] bpf: Add mptcp_userspace_pm_addr bpf_iter
13865807: [mptcp-next,v3,4/5] bpf: Export more helpers for
mptcp_userspace_pm_addr test
13865808: [mptcp-next,v3,5/5] selftests/bpf: Add mptcp_userspace_pm_addr
bpf_iter subtest:
    - State: New
    - Series: add mptcp_address bpf_iter
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=907195&state=*&archive=both

13865898: [mptcp-next,v3,1/9] mptcp: add mptcp_userspace_pm_lookup_addr
helper
13865899: [mptcp-next,v3,2/9] mptcp: add
mptcp_for_each_userspace_pm_addr macro
13865900: [mptcp-next,v3,3/9] mptcp: add mptcp_userspace_pm_get_sock helper
13865901: [mptcp-next,v3,4/9] mptcp: move mptcp_pm_remove_addrs into
pm_userspace
13865902: [mptcp-next,v3,5/9] mptcp: drop free_list for deleting entries
13865903: [mptcp-next,v3,6/9] mptcp: use mptcp_pm_local in pm_netlink only
13865904: [mptcp-next,v3,7/9] mptcp: drop struct mptcp_pm_add_entry
13865905: [mptcp-next,v3,8/9] mptcp: change local addr type of
subflow_destroy
13865906: [mptcp-next,v3,9/9] mptcp: drop useless "err = 0" in
subflow_destroy:
    - State: New
    - Series: BPF path manager, part 1
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=907218&state=*&archive=both
    - Matth: TODO: look at the new version

13867761: [mptcp-next] Squash to "selftests/bpf: Add
mptcp_userspace_pm_addr bpf_iter subtest":
    - State: Rejected
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/aeca45ea8522298327715230f45d718338906732.1731055793.git.tanggeliang@kylinos.cn/




Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 528):

  529  BUG: sleeping function called from invalid context in BPF sched
selftests [bug] [selftests] [sched] [bpf] @geliangtang

    Discussed recently:

  524  tests: cover more Diag-related code [selftests] @geliangtang
  514  Add MIB counters for fallback to TCP [enhancement] @geliangtang
  487  `send()` fails with `EAGAIN` in blocking IO mode [bug]
[selftests] [sched] @geliangtang:
      - can happen with send/receive timeout being set in the BPF selftests
      - what to do to fix the issue: TODO Matth: ask Geliang → Done
      - Can drop the corresponding patches?


    Bugs (opened, flagged as "bug" and assigned)

  529  BUG: sleeping function called from invalid context in BPF sched
selftests [bug] [selftests] [sched] [bpf] @geliangtang
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

  514  Add MIB counters for fallback to TCP [enhancement] @geliangtang
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


    Recently closed (since 2024-11-06)

  528  Can't Find Balia, Lia, Olia congestion control selection in
menuconfig . [question] [feedback-needed]
  527  MPTCP advanced options in Kernel configuration  [question]
  526  Question: MPTCP subflows are reconnected every now and then
[question]

Note:
    - The bug template has been updated:
     https://github.com/multipath-tcp/mptcp_net-next/issues/new/choose


    Packetdrill PRs

  52  3 years ago  dcaratti  Add initial coverage for RM_ADDR


    mptcp.dev PRs: /


    mptcpd PRs

  314  1 hour ago  matttbe  musl compat:
      - to add mptcpd in AlpineLinux:

https://gitlab.alpinelinux.org/alpine/aports/-/merge_requests/75529

      - TODO: Matth: set the GODEBUG env var to enable MPTCP support in
mptcpize → Done:
          - https://github.com/multipath-tcp/mptcpd/pull/316
          - https://go-review.googlesource.com/c/go/+/630715


FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.13):
https://github.com/orgs/multipath-tcp/projects/11
    - For later: https://github.com/orgs/multipath-tcp/projects/1
    - TODO: Matth: update changelog + new project → Done:
        - https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog
        - https://github.com/orgs/multipath-tcp/projects/11



Patches to send to NetDev:

    - Fixes for other trees:

        - [9ff2b1264ea2] netfilter: nf_tables: avoid false-positive
lockdep splat on rule deletion (Florian Westphal)
        - [d739fd31df65] selftests/bpf: Remove test_skb_cgroup_id.sh
from TEST_PROGS (Ihor Solodrai)
        - [a29e82149823] selftests/bpf: Set vpath in Makefile to search
for skels (Ihor Solodrai)

    - Fixes for -net:

        - [2632fa95f335] mptcp: remove unneeded lock when listing scheds
(Matthieu Baerts (NGI0))

    - Fixes for net-next: /

    - Features for net-next: /

    - Features for net-next (next): /

    - Features for other trees:

        - [24aa296c0f15] bpf: Register mptcp common kfunc set (Geliang Tang)
        - [db69930afe41] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [304a70c8778e] bpf: Acquire and release mptcp socket (Geliang
Tang)
        - [efd42cae3a1b] selftests/bpf: More endpoints for endpoint_init
(Geliang Tang)
        - [28940f0c32ba] selftests/bpf: Add mptcp_subflow bpf_iter
subtest (Geliang Tang)
        - [e89c5ae471c0] mptcp: add sched_data helpers (Geliang Tang)
        - [064fc95e4967] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [a8e3d6478970] bpf: Export mptcp packet scheduler helpers
(Geliang Tang)
        - [20dd826ea84e] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [d206444d8b6b] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [aac0fe7480bd] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [85e72e2d82e4] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [f5594335d1e9] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [e278c42148df] selftests/bpf: Add bpf_burst scheduler & test
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
        - TODO: Matth: share sysrq trigger info on the ML → Done



Next meeting:
    - Next one on Wednesday, *in two weeks*, the 4th of December.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20241204



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday in two weeks,
Matt
-- 
Sponsored by the NGI0 Core fund.

