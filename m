Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBB318026
	for <mptcp@lists.linux.dev>; Mon,  5 Aug 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722861050; cv=none; b=jxP8N4v5NlvQZKByxMfZwRkd0qiDvE9FX482HMRr28eWBBkge5F7uR1ra0EsgW+Z4UlHhXoElPprdoRV2/fmWoPJkffT6QP0rJo866UtaTxU3L6LWpqzRQqCFpIoPjbVYHfiZ5NX51yhh28YoEAT/9cfnL7MsLa97s3GZ5iFPdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722861050; c=relaxed/simple;
	bh=8YSACPnenYTMKibQVW4PZjK9rU/uK4WyxeLaoaN7Kng=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ZE6yZZ7ceJ/U1xPX+YkIrCxk1KuFF23IJb23kapcJz0RpMtDkJ2vQ18U70WQEdoQb4fDTB7v2bZKTwkh5qDnbGbxtCU5f5FV2t2qA5f3Rqh50HjwcMghcS+5eWWu2dGl+fOVaoFoo59RV7duiGwhZ9TFBv0U8YvHFH6O2M+POsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWZVCnzj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWZVCnzj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52212C32782
	for <mptcp@lists.linux.dev>; Mon,  5 Aug 2024 12:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722861049;
	bh=8YSACPnenYTMKibQVW4PZjK9rU/uK4WyxeLaoaN7Kng=;
	h=Date:To:From:Subject:From;
	b=rWZVCnzjtKO6s1x4Ou7K1lgqRv4O1Zl1wjd9P/8D+R3DQVCEddPP9N/U13BYhEACu
	 QvqgBFt1l/wXtUqibHejrlffATR2VQDyUXAGV76VtqCuYvL60N/fgesy9i/mC2svvz
	 BJkFZqIRkO3reQBcQyPwNFoWzC+FEEWNzbE79zsqVkHzf09HqpNCExYxk8LdkItTRT
	 yzA2cnMed+pLuM9PpLLXEp2zCWnrTczpjcZe/4pyE68pEcUByS+D5PpP6U+pleE0NW
	 PuagbrWuZxT/zdNEPeR+PDftEQI5vh7ou0zER4wQ9m7WBUdXLKF3heeSMQvdpBy6h+
	 p6tSHHySYi2Ow==
Message-ID: <bd34f627-245b-42df-935d-60c3d5894270@kernel.org>
Date: Mon, 5 Aug 2024 14:30:47 +0200
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
Subject: [Weekly meetings] MoM - 24th of July 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Two weeks ago, we had our new meeting with Mat (Cruise), Christoph
(Apple), Paolo (Redhat), Arınç, Dwayne (BondingShouldBeFree) and myself
(NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

13732235: selftests/net: fix gro.c compilation failure due to
non-existent opt_ipproto_off:
    - Series: selftests/net: fix gro.c compilation failure due to
non-existent opt_ipproto_off
    - Submitter: John Hubbard
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=870973&state=*&archive=both
    - for stable, not related to MPTCP


    our repo (by: Liu Jing, Matthieu Baerts (NGI0), Paolo Abeni):

13719461: [v2] selftests: mptcp: always close input's FD if opened:
    - Submitter: Liu Jing
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240702040518.11058-1-liujing@cmss.chinamobile.com/

13725528: [mptcp-net,v2,1/4] mptcp: fix user-space PM announced address
accounting
13725530: [mptcp-net,v2,2/4] mptcp: fix NL PM announced address accounting
13725532: [mptcp-net,v2,3/4] selftests: mptcp: add explicit test case
for remove/readd
13725531: [mptcp-net,v2,4/4] selftests: mptcp: fix error path:
    - Series: mptcp: fix signal endpoint readd
    - Submitter: Paolo Abeni
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=868916&state=*&archive=both

13731564: [net-next] selftests: mptcp: lib: fix shellcheck errors:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240712-upstream-net-next-20240712-selftests-mptcp-fix-shellcheck-v1-1-1cb7180db40a@kernel.org/

13736591: [mptcp-net,v3,1/9] mptcp: sched: check both directions for backup
13736592: [mptcp-net,v3,2/9] mptcp: distinguish rcv vs sent backup flag
in requests
13736593: [mptcp-net,v3,3/9] mptcp: pm: only set request_bkup flag when
sending MP_PRIO
13736594: [mptcp-net,v3,4/9] mptcp: mib: count MPJ with backup flag
13736595: [mptcp-net,v3,5/9] selftests: mptcp: join: validate backup in MPJ
13736596: [mptcp-net,v3,6/9] mptcp: pm: fix backup support in signal
endpoints
13736597: [mptcp-net,v3,7/9] selftests: mptcp: join: check backup
support in signal endp
13736598: [mptcp-net,v3,8/9] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
13736599: [mptcp-net,v3,9/9] Squash to "selftests/bpf: Add bpf_burst
scheduler & test":
    - Series: mptcp: fix inconsistent backup usage
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=872303&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang, John Hubbard,
Matthieu Baerts (NGI0), Yunsheng Lin):

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
    - TODO: Matth: check with Geliang what he wants to do with it → done

13689188: [RESEND,v2] checkpatch: skip warnings for symbol links:
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/dc502b1b45cb27fda48d72d73e3267a32db023d8.1717722648.git.tanggeliang@kylinos.cn/
    - TODO: Matth: check with checkpatch maintainers? → done

13722725: [bpf-next,v3,1/3] selftests/bpf: Add mptcp subflow example
13722726: [bpf-next,v3,2/3] selftests/bpf: Add mptcp pm_nl_ctl link
13722727: [bpf-next,v3,3/3] selftests/bpf: Add mptcp subflow subtest:
    - Series: selftests/bpf: new MPTCP subflow subtest
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=868164&state=*&archive=both
    - Next step: Geliang will skip the test if 'ip mptcp' is not available

13736352: [net,v2,2/2] tcp: limit wake-up for crossed SYN cases to SYN-ACK:
    - Series: tcp: restrict crossed SYN specific actions to SYN-ACK
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=872226&state=*&archive=both
    - TODO: Matth: send that next week → done

13737070: [RFC,v11,12/14] net: replace page_frag with page_frag_cache:
    - Still OK

13740840: [net,v3] tcp: process the 3rd ACK with sk_socket for TFO/MPTCP:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240724-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v3-1-d48339764ce9@kernel.org/


    our repo (by: Geliang Tang, Gregory Detal, Matthieu Baerts, Matthieu
Baerts (NGI0), Paolo Abeni):

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

13665855: [mptcp-next,v3,1/2] Squash to "selftests/bpf: Add mptcp
subflow subtest"
13665856: [mptcp-next,v3,2/2] Squash to "selftests/bpf: Add bpf
scheduler test":
    - State: Changes requested
    - Series: fixes for create_netns
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=853620&state=*&archive=both
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
    - TODO: to be reviewed: is it needed?

13739048: [mptcp-net,v4,01/23] mptcp: fully established after ADD_ADDR
echo on MPJ
13739049: [mptcp-net,v4,02/23] mptcp: pm: deny endp with signal +
subflow + port
13739050: [mptcp-net,v4,03/23] mptcp: pm: reduce indentation blocks
13739051: [mptcp-net,v4,04/23] mptcp: pm: don't try to create sf if
alloc failed
13739052: [mptcp-net,v4,05/23] mptcp: pm: do not ignore 'subflow' if
'signal' flag is also set
13739053: [mptcp-net,v4,06/23] selftests: mptcp: join: ability to invert
ADD_ADDR check
13739054: [mptcp-net,v4,07/23] selftests: mptcp: join: test both signal
& subflow
13739055: [mptcp-net,v4,08/23] mptcp: pm: re-using ID of unused removed
ADD_ADDR
13739056: [mptcp-net,v4,09/23] selftests: mptcp: join: check re-using ID
of unused ADD_ADDR
13739057: [mptcp-net,v4,10/23] mptcp: pm: re-using ID of unused removed
subflows
13739058: [mptcp-net,v4,11/23] selftests: mptcp: join: check re-using ID
of closed subflow:
    - TODO: Matth: Apply ↑ → Done

13739059: [mptcp-net,v4,12/23] mptcp: pm: re-using ID of unused flushed
subflows:
    - Better to split: for -net and net-next
13739060: [mptcp-net,v4,13/23] selftests: mptcp: join: test for
flush/re-add endpoints
13739061: [mptcp-net,v4,14/23] mptcp: pm: remove mptcp_pm_remove_subflow()
13739062: [mptcp-net,v4,15/23] mptcp: pm: only mark 'subflow' endp as
available
13739063: [mptcp-net,v4,16/23] mptcp: pm: only decrement
add_addr_accepted for MPJ req
13739064: [mptcp-net,v4,17/23] mptcp: pm: check add_addr_accept_max
before accepting new ADD_ADDR
13739065: [mptcp-net,v4,18/23] mptcp: pm: only in-kernel cannot have
entries with ID 0
13739066: [mptcp-net,v4,19/23] mptcp: pm: fullmesh: select the right ID
later
13739067: [mptcp-net,v4,20/23] selftests: mptcp: join: validate fullmesh
endp on 1st sf
13739068: [mptcp-net,v4,21/23] mptcp: pm: avoid possible UaF whend
selecting endp
13739069: [mptcp-net,v4,22/23] mptcp: pm: reuse ID 0 after delete and re-add
13739070: [mptcp-net,v4,23/23] mptcp: pm: reduce entries iterations on
connect:
    - State: New
    - Series: mptcp: fix endpoints with 'signal' and 'subflow' flags
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=873047&state=*&archive=both

13740210: [mptcp-iproute,v2,1/7] man: mptcp: document 'dev IFNAME'
13740212: [mptcp-iproute,v2,2/7] man: mptcp: clarify 'signal' and
'subflow' flags
13740213: [mptcp-iproute,v2,3/7] man: mptcp: 'port' has to be used with
'signal'
13740214: [mptcp-iproute,v2,4/7] man: mptcp: 'backup' flag also affects
outgoing data
13740215: [mptcp-iproute,v2,5/7] man: mptcp: 'fullmesh' has to be used
with 'subflow'
13740216: [mptcp-iproute,v2,6/7] man: mptcp: clarify the 'ID' parameter
13740217: [mptcp-iproute,v2,7/7] ip: mptcp: 'id 0' is only for 'del':
    - State: New
    - Series: mptcp: guide users to avoid mistakes
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=873309&state=*&archive=both




Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 505):


  509  Add MIB counters for sent MPJ [enhancement]:
      - TODO: assign Matth → Done

  508  Divide error on device removal [bug]:
      - Paolo asked for more info, but no replies so far

  506  [Question] Cannot create backup subflows to remote endpoints?
[question]:
      - Should be fixed by the "mptcp: fix inconsistent backup usage" series

Recently discussed:

  505  Subflows won't be used when the interface for the main flow is a
subinterface [bug]
  503  in-kernel PM: use endpoints only to create subflows with received
`ADD_ADDR` [enhancement] [pm]

  501  Why do endpoint tcp connections close? [bug]:
      - Some subflows got reset, under investigations by Paolo
      - But it looks like there are maybe other issues
      - Paolo sent a patch, waiting for some feedback

  499  selftests: `mptcp_connect.sh`: disconnect test timed out [bug]
[selftests]
  489  IPv6 Rejoin Subflow [question]
  475  `simult_flows`: unbalanced bwidth tests are unstable [bug]
[selftests]
  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  440  in-kernel PM: re-establish subflows after "network" errors
[enhancement] [pm]


    Bugs (opened, flagged as "bug" and assigned)

  487  `send()` fails with `EAGAIN` in blocking IO mode [bug]
[selftests] [bpf] @geliangtang
  477  Client: fallback to TCP after X MPC [bug] @matttbe
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  508  Divide error on device removal [bug]
  505  Subflows won't be used when the interface for the main flow is a
subinterface [bug]
  501  Why do endpoint tcp connections close? [bug]
  500  cleanup rbuf bug [bug]
  499  selftests: `mptcp_connect.sh`: disconnect test timed out [bug]
[selftests]
  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement
`add_addr_accepted` [bug] [pm]
  495  [syzkaller] KASAN: slab-use-after-free Read in
`__inet6_lookup_established` [bug] [syzkaller]
  494  [syzkaller] WARNING in `__skb_flow_dissect` [bug] [syzkaller]
  493  [syzkaller] WARNING in `__mptcp_clean_una` [bug] [syzkaller]
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
  416  No new subflow when removing an endpoint and adding a new one [bug]
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

  506  [Question] Cannot create backup subflows to remote endpoints?
[question]
  502  Question for ip-mptcp command [question]
  489  IPv6 Rejoin Subflow [question]
  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned)

  509  Add MIB counters for sent MPJ [enhancement]
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


    Recently closed (since 20240703)

  510  Some newly added endpoints won't be used to create subflows on an
existing MPTCP connection [question]
  507  PM: Backup flags is not set in MPJ SYN+ACK even with there is a
'signal' endpoint having the backup flag [bug] @matttbe


    Packetdrill PRs

  # 52  2 years ago  dcaratti  Add initial coverage for RM_ADDR


    mptcp.dev PRs

  # /



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.11):
https://github.com/orgs/multipath-tcp/projects/9
    - For later: https://github.com/orgs/multipath-tcp/projects/1
    - TODO: Matth: update that → Done
      https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog



Patches to send to NetDev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [b5db93b53fa0] selftests: mptcp: always close input's FD if
opened (Liu Jing):
            - can be sent: TODO: Matth → done

        - [45ae955e1f0f] mptcp: fix user-space PM announced address
accounting (Paolo Abeni)
        - [5628c8f06792] mptcp: fix NL PM announced address accounting
(Paolo Abeni)
        - [2c270be7b08e] selftests: mptcp: add explicit test case for
remove/readd (Paolo Abeni)
        - [bc352e10f00b] selftests: mptcp: fix error path (Paolo Abeni):
            - can be sent: TODO: Matth → done

        - [10064045856c] tcp: process the 3rd ACK with sk_socket for
TFO/MPTCP (Matthieu Baerts (NGI0)):
            - already sent

        - [d89069281687] tcp: limit wake-up for crossed SYN cases to
SYN-ACK (Matthieu Baerts (NGI0)):
            - for net-next

        - [d555fa7e2d0e] mptcp: sched: check both directions for backup
(Matthieu Baerts (NGI0))
        - [b100cde2d468] mptcp: distinguish rcv vs sent backup flag in
requests (Matthieu Baerts (NGI0))
        - [2e4593693047] mptcp: pm: only set request_bkup flag when
sending MP_PRIO (Matthieu Baerts (NGI0))
        - [ddb806f796f6] mptcp: mib: count MPJ with backup flag
(Matthieu Baerts (NGI0))
        - [0f671868eb77] selftests: mptcp: join: validate backup in MPJ
(Matthieu Baerts (NGI0))
        - [6fe5e3c20bde] mptcp: pm: fix backup support in signal
endpoints (Matthieu Baerts (NGI0))
        - [9c5d5018092e] selftests: mptcp: join: check backup support in
signal endp (Matthieu Baerts (NGI0)):
            - can be sent next week: TODO: Matth → done

    - Fixes for net-next: /

    - Features for net-next: /

    - Features for net-next (next): /

    - Features for other trees:

        - [220c5737c741] mptcp: add sched_data helpers (Geliang Tang)
        - [359d09c34207] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [ae00add4ce59] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [ec3d433e4226] selftests/bpf: Add mptcp subflow example
(Nicolas Rybowski)
        - [8c0e3c67e4b6] selftests/bpf: Add mptcp pm_nl_ctl link
(Geliang Tang)
        - [4d7eeaee5591] selftests/bpf: Add mptcp subflow subtest
(Geliang Tang)
        - [5f13e2df38b1] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [e52162af050a] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [fce1f4c5a7c7] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [66eae184bb54] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [3dd34cef8eac] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [effcc8f5a22c] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [6486217c7984] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang):
            - status: same as before



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - / TODO: Matth: remove this item

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp



Perf:
     - last time check:
         - TCP vs MPTCP: one subflow, cpu bounded: 10% impact



Bonding Should Be Free:
     - https://bondingshouldbefree.com/
     - Idea is to have a banana pi, to bond 50 Mbps for free
     - Perf are not that good when bonding fibre with 4G (that's just
for the tests, but still):
         - check CPU limits
         - maybe limited by buffers (net.ipv4.tcp_*mem) → better with
multiple subflows in // → iperf3 -P4
         - maybe IO limits? → iperf3 -Z
         - maybe bufferbloat? → check RTT with a packet trace (taken in
the middle/server side or client if not CPU limited):
             - iperf3 -R → download vs upload
             - iperf3 --get-server-output → to get TCP INFO


Netdev.conf:
     - One requested feature is to get the BPF scheduler:
         - TODO: check with Gregory



Curl:
     - New version 8.9.0 is available with 'curl --mptcp' \o/



Next meeting:
    - Next one on Wednesday, the 31st of July.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240731



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.
