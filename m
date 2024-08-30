Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFA8190674
	for <mptcp@lists.linux.dev>; Fri, 30 Aug 2024 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027566; cv=none; b=SPdTAJYOPBBHT488o2ZbdviEV9ZoylhR2rVWcGc/SKMNXF6Nu53m++PNgJpQBHw7tUzy+TuUBy2zYR8Sfn0FBYjhQ2OCiub/lPL70agxzXDpg+12nyW5JsOmpr0rC8QTS3yq+MSdjpCGcYgn3I/dOYAlv87izH25s0657akyJgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027566; c=relaxed/simple;
	bh=54z447e08br30X5zkqszB1OQYPUUjAOUrgBAAGrpHds=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=ckHiHWevv0r1VFi9dF34jeGRm2CGuONGgeIsyZUAkYOgURUk+Dw6YWWgtTlIOIZ82hE2m0Z/mI6ygL4+qur7yexNRh6WOTuwqiv3cGilZD6GERd7sslkvJeC5rBFPTBVGOidgQepyCRhuN6QNLND4r3cDXzo2rxahPKp14L36OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=As7sMHFz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="As7sMHFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4C4C4CEC2
	for <mptcp@lists.linux.dev>; Fri, 30 Aug 2024 14:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725027566;
	bh=54z447e08br30X5zkqszB1OQYPUUjAOUrgBAAGrpHds=;
	h=Date:From:Subject:To:From;
	b=As7sMHFzChYBEMaZFao3mqYY535RumOGO2OurWTz0rkRgiT6D70S+yGdqWXf84K0x
	 bvYWu/SyQ0K69JPa7ERYP75td/XixQRvEx9EG5oWuBsgRQnhEXyx3nRTARLWpqzbhx
	 Z5BTc08x2a7xsOLikb3rLJdUhmSfiNcGJZnWLUWDtF5RQZHFbp+r7uVFP0yjV1MFRa
	 L0Lb7InTSDZJYi1scEX21l460TiAGGGg4Q9zutZSA7zvKOQ4rfCfFUGP86DqYLH3Vs
	 pmhOMWkZPCx8uZG+WxjG/EXXiTBmkBVXdVDBtcT+bIudf6SbuZ/zAD9bP1g9Jt8jcv
	 7xhyjDX3Q7WUg==
Message-ID: <5d81707e-a04f-43c9-94ca-7d5d8081bbea@kernel.org>
Date: Fri, 30 Aug 2024 16:19:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 28th of August 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Linux <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello everyone,

Yesterday, we had our new meeting with Mat (Cruise), and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3

    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13778220: [net,1/4] mptcp: close subflow when receiving TCP+FIN
13778221: [net,2/4] selftests: mptcp: join: cannot rm sf if closed
13778222: [net,3/4] mptcp: sched: check both backup in retrans
13778223: [net,4/4] mptcp: pr_debug: add missing \n at the end:
    - Series: mptcp: close subflow when receiving TCP+FIN and misc.
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=883452&state=*&archive=both

13765873: [-next] mptcp: Remove unused declaration mptcp_sockopt_sync():
    - Submitter: Yue Haibing
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240816100404.879598-1-yuehaibing@huawei.com/


    our repo (by: Matthieu Baerts):

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
    - Series: mptcp: pm: fix re-re-create the ID 0 endpoint
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=880310&state=*&archive=both

13771264: [mptcp-next,1/3] selftests: mptcp: lib: add time per subtests
in TAP output
13771265: [mptcp-next,2/3] sefltests: mptcp: connect: remote time in TAP
output
13771266: [mptcp-next,3/3] selftests: mptcp: reset the last TS before
the first test:
    - Series: selftests: mptcp: add time per subtests in TAP output
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=881720&state=*&archive=both

13779571: [mptcp-next,1/2] Squash to "selftests: mptcp: join: check
re-re-adding ID 0 endp"
13779572: [mptcp-next,2/2] Squash to "selftests: mptcp: join: check
re-re-adding ID 0 signal":
    - Series: mptcp: Squash-to patches for "mptcp: more fixes for the
in-kernel PM"
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=883825&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Gang Yan, Geliang Tang, Matthieu
Baerts, Yue Haibing, Yunsheng Lin):

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
    - Status: same

13689188: [RESEND,v2] checkpatch: skip warnings for symbol links:
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/dc502b1b45cb27fda48d72d73e3267a32db023d8.1717722648.git.tanggeliang@kylinos.cn/
    - Status: same

13753375: [bpf-next,v4,1/2] selftests/bpf: Add mptcp subflow example
13753376: [bpf-next,v4,2/2] selftests/bpf: Add mptcp subflow subtest:
    - Series: selftests/bpf: new MPTCP subflow subtest
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=876648&state=*&archive=both
    - Status: same

13772665: [bpf-next] bpf: Allow error injection for update_socket_protocol:
    - Submitter: Gang Yan
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/tencent_CD94B9310E4F3464B4D83B0942EA0EA28409@qq.com/
    - looks like it is not needed

13777867: [net-next,v15,11/13] net: replace page_frag with page_frag_cache:
    - Mat will look at the recent modifications

13780721: [net,v2,01/15] mptcp: pm: reuse ID 0 after delete and re-add
13780722: [net,v2,02/15] mptcp: pm: fix RM_ADDR ID for the initial subflow
13780723: [net,v2,03/15] selftests: mptcp: join: check removing ID 0
endpoint
13780724: [net,v2,04/15] mptcp: pm: send ACK on an active subflow
13780725: [net,v2,05/15] mptcp: pm: skip connecting to already
established sf
13780726: [net,v2,06/15] mptcp: pm: reset MPC endp ID when re-added
13780727: [net,v2,07/15] selftests: mptcp: join: check re-adding init
endp with != id
13780728: [net,v2,08/15] selftests: mptcp: join: no extra msg if no counter
13780729: [net,v2,09/15] mptcp: pm: do not remove already closed subflows
13780730: [net,v2,10/15] mptcp: pm: fix ID 0 endp usage after multiple
re-creations
13780731: [net,v2,11/15] selftests: mptcp: join: check re-re-adding ID 0
endp
13780732: [net,v2,12/15] mptcp: avoid duplicated SUB_CLOSED events
13780733: [net,v2,13/15] selftests: mptcp: join: validate event numbers
13780734: [net,v2,14/15] mptcp: pm: ADD_ADDR 0 is not a new address
13780735: [net,v2,15/15] selftests: mptcp: join: check re-re-adding ID 0
signal:
    - Series: mptcp: more fixes for the in-kernel PM
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=884100&state=*&archive=both
    - v2 to fix CI issues


    our repo (by: Gang Yan, Geliang Tang, Gregory Detal, Matthieu Baerts):

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

13766743: [bpf-next,1/2] selftests: bpf: use KHDR_INCLUDES for the UAPI
headers
13766744: [bpf-next,2/2] selftests: bpf: remove duplicated UAPI if_xdp
headers:
    - State: Changes requested
    - Series: selftests: bpf: avoid duplicated UAPI headers
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=880440&state=*&archive=both
    - BPF maintainers don't want that, BPF selftests are not part of the
KSelftests

13775047: [mptcp-next,v4,1/3] Squash to "selftests/bpf: Add mptcp
subflow example"
13775048: [mptcp-next,v4,2/3] selftests/bpf: Add getsockopt to inspect
mptcp subflow
13775049: [mptcp-next,v4,3/3] Squash to "selftests/bpf: Add mptcp
subflow subtest":
    - State: Changes requested
    - Series: fixes for "new MPTCP subflow subtest v4"
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=882630&state=*&archive=both
    - Probably best not to change values in the validation step



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 514):

  515  Add `TCP_MAXSEG` socket option support [enhancement]:
      - Needed for HAProxy, some people are still configuring it, e.g.
to support VPN network without TCP MSS clamping


    Recently discussed:

  513  [syzbot] WARNING in `__mptcp_move_skbs_from_subflow` [bug]
[syzkaller]


    Bugs (opened, flagged as "bug" and assigned)

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

  515  Add `TCP_MAXSEG` socket option support [enhancement]
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


    Recently closed (since 2024-08-21)

  512  Primary flow re-establishes as a subflow but immediately closes
[bug] @matttbe


    Packetdrill PRs

  153  27 days ago  matttbe   mptcp: tfo: inject DFIN without delay
  52   2 years ago  dcaratti  Add initial coverage for RM_ADDR


    mptcp.dev PRs: /


    mptcpd PRs

  192  3 months ago  ossama-othman  Test mptcpize
  56   3 months ago  ossama-othman  Add standalone mptcpd plugin example.



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.12):
https://github.com/orgs/multipath-tcp/projects/10
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees: /


    - Fixes for -net:

        - [7ff9416bf516] mptcp: pm: reuse ID 0 after delete and re-add
(Matthieu Baerts (NGI0))
        - [d37ad22c741b] mptcp: pm: fix RM_ADDR ID for the initial
subflow (Matthieu Baerts (NGI0))
        - [294cd99d84d2] selftests: mptcp: join: check removing ID 0
endpoint (Matthieu Baerts (NGI0))
        - [d36ab90a57d7] mptcp: pm: send ACK on an active subflow
(Matthieu Baerts (NGI0))
        - [47140e497b38] mptcp: pm: skip connecting to already
established sf (Matthieu Baerts (NGI0))
        - [99e72dc56402] mptcp: pm: reset MPC endp ID when re-added
(Matthieu Baerts (NGI0))
        - [24b22cbd23a8] selftests: mptcp: join: check re-adding init
endp with != id (Matthieu Baerts (NGI0))
        - [fe31715a05c6] selftests: mptcp: join: no extra msg if no
counter (Matthieu Baerts (NGI0))
        - [b7f709e47163] mptcp: pm: do not remove already closed
subflows (Matthieu Baerts (NGI0))
        - [c394d6697f93] mptcp: pm: fix ID 0 endp usage after multiple
re-creations (Matthieu Baerts (NGI0))
        - [bac221224b3a] selftests: mptcp: join: check re-re-adding ID 0
endp (Matthieu Baerts (NGI0))
        - [0bbb4bb58c23] mptcp: avoid duplicated SUB_CLOSED events
(Matthieu Baerts (NGI0))
        - [54fa964ad708] selftests: mptcp: join: validate event numbers
(Matthieu Baerts (NGI0))
        - [fb20de8c089c] mptcp: pm: ADD_ADDR 0 is not a new address
(Matthieu Baerts (NGI0))
        - [a532e12dda9c] selftests: mptcp: join: check re-re-adding ID 0
signal (Matthieu Baerts (NGI0)):
            - have been sent

    - Fixes for net-next:


    - Features for net-next:

        - [659ab3c9c6b4] selftests: mptcp: join: simplify checksum_tests
(Geliang Tang)
        - [bc3cd12236aa] mptcp: pm: rename helpers linked to 'flush'
(Matthieu Baerts (NGI0))
        - [bf332298a78b] mptcp: pm: reduce entries iterations on connect
(Matthieu Baerts (NGI0))
        - [12c4182e5b2f] mptcp: MIB counters for sent MP_JOIN (Matthieu
Baerts (NGI0))
        - [da5b3cbf0fcc] selftests: mptcp: join: reduce join_nr params
(Matthieu Baerts (NGI0))
        - [d19a5bd785a9] selftests: mptcp: join: one line for join check
(Matthieu Baerts (NGI0))
        - [5698b02cd443] selftests: mptcp: join: validate MPJ SYN TX MIB
counters (Matthieu Baerts (NGI0))
        - [39da2db69668] selftests: mptcp: join: more explicit check
name (Matthieu Baerts (NGI0))
        - [cb2916f9acf3] selftests: mptcp: join: specify host being
checked (Matthieu Baerts (NGI0))
        - [a62af0b1aa79] selftests: mptcp: join: mute errors when ran in
the background (Matthieu Baerts (NGI0))
        - [a377d0e9db97] selftests: mptcp: pm_nl_ctl: remove
re-definition (Matthieu Baerts (NGI0))
        - [3bcdba3847aa] mptcp: pm: send ACK on non stale subflows
(Matthieu Baerts (NGI0))
        - [2045d0aa2df1] selftests: mptcp: lib: add time per subtests in
TAP output (Matthieu Baerts (NGI0))
        - [b648622fb444] sefltests: mptcp: connect: remote time in TAP
output (Matthieu Baerts (NGI0))
        - [f3f7bcc281d3] selftests: mptcp: reset the last TS before the
first test (Matthieu Baerts (NGI0)):
            - Can be sent when the patches for -net have been applied
and synced with net-next

    - Features for net-next (next):


    - Features for other trees:

        - [79de83178d73] mptcp: add sched_data helpers (Geliang Tang)
        - [9bcb62aca0f0] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [d74a314c2418] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)

        - [768ee168a882] selftests/bpf: Add mptcp subflow example
(Nicolas Rybowski)
        - [52d913a16ac7] selftests/bpf: Add mptcp pm_nl_ctl link
(Geliang Tang):
            - can be dropped
        - [76eb01cf1770] selftests/bpf: Add mptcp subflow subtest
(Geliang Tang):
            - can be sent when the squashed to patches from Geliang will
be applied

        - [6c0d3c213cf3] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [a35688e5987a] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [fe16f5a22ced] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [2492cf0439a4] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [6ff6aa4849a2] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [f57e12c9bc68] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [e88fd8e54492] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang):
            - wait for sched refactoring



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - Packetdrill (Davide):
        - Google is adding their packetdrill tests in kselftests
        - Might be good to also have the MPTCP packetdrill tests being
validated when new patches are sent on netdev.

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - Some instabilities seen on top of export-net:
            -
https://github.com/multipath-tcp/mptcp_net-next/actions/runs/10591493745
            - to be monitored
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp:
            - had some issues with the v1 of "mptcp: more fixes for the
in-kernel PM"



Next meeting:
    - Next one on Wednesday, the 4th of September.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240904



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.

