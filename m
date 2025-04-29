Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA6E2BF3DD
	for <mptcp@lists.linux.dev>; Tue, 29 Apr 2025 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921384; cv=none; b=l4/grtguBnTCNck3HujJFcwhKHvyJblhm71NGejlgoCOjV4EgnhGC7ycMFcSRex2+puEqQkSD1k8807lhd+vXOoC45ylap1I5pDoYqggEcbOzxWdrQHZe/YwvpSaTt73BAJwkhqrMUqMGJ4ND65+vATxzs3L7ob6adrgLwLn1R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921384; c=relaxed/simple;
	bh=nIdSsoM3490/ltz10RxeEDhrKrRbfGEcoCTomcyaGlE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=A8UMpWemjwYOkhp8egha14DO0UisdHvbFrPRuUiM9e4/ScW3NDQSHjIAOFAP7ktQMBS+qny0H0dVeG5BsCVTtAQthb0f6qO3VjjPk2RhxcNpv7s+Dkv4vXbCoSqPCjb3OmFQforfNOjFnZ3+zbvBmggcWZEk4nL10RQ5FhhqnQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myKhS9Wz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myKhS9Wz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3540C4CEE3
	for <mptcp@lists.linux.dev>; Tue, 29 Apr 2025 10:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745921383;
	bh=nIdSsoM3490/ltz10RxeEDhrKrRbfGEcoCTomcyaGlE=;
	h=Date:From:Subject:To:From;
	b=myKhS9WzhkCPL8xzN/BJJZPxX77UbclnsxfIFeOHatzhrekj31eaKacpSryIH8jhB
	 /HGVUPiEyevJ1C95IXyx+PvED2ZGkY75FqD0+7+Jzm0AGRkq7EK2RsRIMy/JJsCnW3
	 8lR89qwa8YgB8aI6Q5CF8sAYKICLZL4ysnkqI41IqjCxzFO+DBKzGO9+MPlpilEnnG
	 fDf/BeFN8nOnoJC+eaLGTPjpCVK7GdZ0yIxsdxurLB1t35vNnS9bgL6e4tPIDlYjxy
	 xYNwsw+CBI9yV8cMiy7urcR3Eb2Y/doPca3ja+DjtpvXbQDcpneiRucFdH4eUPX/Mj
	 2bqtGXfz2eNhQ==
Message-ID: <6d2877a2-0c37-42b0-8406-00bb40e4263a@kernel.org>
Date: Tue, 29 Apr 2025 12:09:40 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 23rd of April 2025
Content-Language: en-GB, fr-BE
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Linux <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last week, we had our new meeting with Mat (Cruise) and myself (NGI0
Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

14049247: [net-next,v2,1/8] mptcp: sched: remove mptcp_sched_data
14049248: [net-next,v2,2/8] mptcp: sched: split validation part
14049249: [net-next,v2,3/8] mptcp: pm: Return local variable instead of
freed pointer
14049250: [net-next,v2,4/8] mptcp: pass right struct to subflow_hmac_valid
14049251: [net-next,v2,5/8] mptcp: add MPJoinRejected MIB counter
14049252: [net-next,v2,6/8] selftests: mptcp: validate MPJoinRejected
counter
14049253: [net-next,v2,7/8] selftests: mptcp: diag: drop nlh parameter
of recv_nlmsg
14049254: [net-next,v2,8/8] selftests: mptcp: use IPPROTO_MPTCP for
getaddrinfo:
    - Series: mptcp: various small and unrelated improvements
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=952809&state=*&archive=both

14059083: [net,1/2] mptcp: pm: Defer freeing of MPTCP userspace path
manager entries
14059084: [net,2/2] selftests: mptcp: diag: use mptcp_lib_get_info_value:
    - Series: mptcp: pm: Defer freeing userspace pm entries
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=955417&state=*&archive=both

    Stable: fixing backports

14055935: [6.6.y,1/2] mptcp: sockopt: fix getting freebind & transparent
14055936: [6.6.y,2/2] selftests: mptcp: add
mptcp_lib_wait_local_port_listen:
    - Series: mptcp: sockopt: fix getting freebind & transparent
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=954594&state=*&archive=both

14057063: [6.1.y] mptcp: sockopt: fix getting freebind & transparent:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250418083955.2844365-2-matttbe@kernel.org/

14057130: [5.15.y] mptcp: sockopt: fix getting IPV6_V6ONLY:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250418102319.3212564-2-matttbe@kernel.org/

14057478: [5.10.y,1/3] mptcp: fix NULL pointer in can_accept_new_subflow
14057479: [5.10.y,2/3] mptcp: only inc MPJoinAckHMacFailure for HMAC
failures
14057480: [5.10.y,3/3] mptcp: sockopt: fix getting IPV6_V6ONLY:
    - Series: mptcp: fix recent failed backports
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=954944&state=*&archive=both


    our repo (by: Geliang Tang, Mat Martineau, Matthieu Baerts):

14036875: [mptcp-next] selftests: mptcp: diag: use mptcp_lib_get_info_value:
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/e34e86805f3fe69e0aec08c83c596c49799573c7.1743666387.git.tanggeliang@kylinos.cn/

14039908: [mptcp-next] selftests: mptcp: diag: drop nlh parameter of
recv_nlmsg:
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/0a7cb982ea5886c2f00e69703feb92c3934dcd63.1744012385.git.tanggeliang@kylinos.cn/

14044104: [mptcp-next,v2] selftests: mptcp: use IPPROTO_MPTCP for
getaddrinfo:
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/77efff47e3cace7d2dd9a1394d3ece4e234a5e74.1744178165.git.tanggeliang@kylinos.cn/

14047042: [mptcp-next] selftests: mptcp: info: hide 'grep: write error'
warnings:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250410-selftests-mptcp-grep-close-v1-1-3c360279a856@kernel.org/

14047325: [mptcp-net,v2] mptcp: pm: Defer freeing of MPTCP userspace
path manager entries:
    - Submitter: Mat Martineau
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250410224503.2056587-1-martineau@kernel.org/

14058554: [mptcp-next] selftests: mptcp: sockopt: use IPPROTO_MPTCP for
getaddrinfo:
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/4bdd7056ddd882061c56c0eee3a7121908c0bb89.1745203199.git.tanggeliang@kylinos.cn/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts, Yunsheng Lin):

13897129: [net-next,v2,09/10] net: replace page_frag with page_frag_cache:
    - can probably be archived

14024259: [bpf-next/net,v3,1/5] bpf: Register mptcp common kfunc set
14024260: [bpf-next/net,v3,2/5] bpf: Add mptcp_subflow bpf_iter
14024261: [bpf-next/net,v3,3/5] selftests/bpf: More endpoints for
endpoint_init
14024262: [bpf-next/net,v3,4/5] selftests/bpf: Add mptcp_subflow
bpf_iter subtest
14024263: [bpf-next/net,v3,5/5] selftests/bpf: Drop cgroup_fd of
run_mptcpify:
    - Series: bpf: Add mptcp_subflow bpf_iter support
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=946008&state=*&archive=both
    - No feedback yet


14050671: [net-next,v2,15/18] mptcp: Use nested-BH locking for hmac_storage:
    - there are discussions on the other patches, Paolo is involved.


    our repo (by: Gang Yan, Geliang Tang, Gregory Detal, Matthieu
Baerts, Sebastian Andrzej Siewior):

12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
    - State: Changes requested
    - Series: BPF redundant scheduler, part 3
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
    - status: same as last time

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
    - status: same as last time

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
    - status: same as last time

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
    - status: same as last time

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
    - status: same as last time

13932555: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
13932556: [2/3] selftests: mptcp: relax conditions in SYN_TX validation
13932546: [3/3] selftests: mptcp: add a testcase for invalid addr timeout:
    - State: Changes requested
    - Series: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
    - Submitter: Gang Yan
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=923771&state=*&archive=both
    - status: same as last time

14024767: [mptcp-next,v1,1/4] bpf: Add mptcp path manager struct_ops
14024768: [mptcp-next,v1,2/4] bpf: Export mptcp path manager kfuncs
14024769: [mptcp-next,v1,3/4] selftests/bpf: Add mptcp netlink pm subtest
14024770: [mptcp-next,v1,4/4] selftests/bpf: Add mptcp bpf_netlink pm
subtest:
    - State: Changes requested
    - Series: BPF path manager, part 7
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=946095&state=*&archive=both
    - status: same as last time

14031600: [mptcp-next,v6,1/5] mptcp: pm: call pm worker handler without
pm lock
14031601: [mptcp-next,v6,2/5] mptcp: pm: add accept_new_subflow() interface
14031602: [mptcp-next,v6,3/5] mptcp: pm: add established() interface
14031603: [mptcp-next,v6,4/5] mptcp: pm: add subflow_established() interface
14031604: [mptcp-next,v6,5/5] mptcp: pm: drop is_userspace in
subflow_check_next:
    - State: Needs ack
    - Series: BPF path manager, part 6
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=947940&state=*&archive=both
    - status: same as last time

14034338: [mptcp-next,1/4] mptcp: pm: add accept_address helper
14034339: [mptcp-next,2/4] mptcp: pm: add accept_new_address() interface
14034340: [mptcp-next,3/4] mptcp: pm: add add_addr_received() interface
14034341: [mptcp-next,4/4] mptcp: pm: add rm_addr_received() interface:
    - State: Needs ack
    - Series: BPF path manager, part 7
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=948762&state=*&archive=both
    - status: same as last time

14039147: [mptcp-next] mptcp: pm: drop redundant mptcp_pm_send_ack:
    - State: Rejected
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/539ce4556220df3d2ea4826c311c5bc4e306f9a2.1743863553.git.tanggeliang@kylinos.cn/
    - Better avoiding single small cleanup if it is not attached to
other changes: it takes time to review, document, send, etc. except if
it clearly improves a situation

14053397: [mptcp-next,v3,1/3] mptcp: pm: userspace: drop
delete_local_addr helper
14053398: [mptcp-next,v3,2/3] selftests: mptcp: join: update userspace
dump_addr outputs
14053399: [mptcp-next,v3,3/3] selftests: mptcp: userspace: send RM_ADDR
between server and client:
    - State: Queued
    - Series: only remove entry from local_addr_list when sending a
REMOVE_ADDR
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=953862&state=*&archive=both
    - Mat will do additional tests, just to make sure the behaviour
change is OK
    - Matth will look at the series as well, just to be sure we are all
OK with the behavioural change: TODO

14053541: [mptcp-next,v2,1/7] selftests: mptcp: add struct params in
mptcp_diag
14053540: [mptcp-next,v2,2/7] selftests: mptcp: refactor send_query
parameters for code clarity
14053539: [mptcp-next,v2,3/7] selftests: mptcp: refine the 'iovlen'
handling logic
14053543: [mptcp-next,v2,4/7] selftests: mptcp: refactor NLMSG handling
with 'proto'
14053545: [mptcp-next,v2,5/7] selftests: mptcp: add a helper to get
subflow_info
14053544: [mptcp-next,v2,6/7] selftests: mptcp: add a helper to print
subflow_info
14053542: [mptcp-next,v2,7/7] selftests: mptcp: add chk_sublfow in diag.sh:
    - State: Changes requested
    - Series: Add 'dump_subflow' test in selftests
    - Submitter: Gang Yan
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=953894&state=*&archive=both

14062354: [mptcp-next,v2,1/3] tcp: add tcp_sock_set_maxseg
14062355: [mptcp-next,v2,2/3] mptcp: add TCP_MAXSEG sockopt support
14062356: [mptcp-next,v2,3/3] selftests: mptcp: sockopt: add TCP_MAXSEG
sockopt tests:
    - State: New
    - Series: Add TCP_MAXSEG socket option support
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=956091&state=*&archive=both
    - Matth checked the v1, will check the v2: TODO



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 555):

/

    Recently discussed

  515  Add `TCP_MAXSEG` socket option support [enhancement] @geliangtang:
    - See patches above

  348  scheduler: frequently probe "stale" subflow with reinjected data
[enhancement] [sched]


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

  555  [syzbot] WARNING in `mptcp_do_fallback` [bug] [syzkaller]
  549  pm: in-kernel: set `msk->pm.work_pending` back to `true` [bug]
[selftests] [pm]
  508  Divide error on device removal [bug] [feedback-needed]
  505  Subflows won't be used when the interface for the main flow is a
subinterface [bug] [feedback-needed]
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
  336  Issues with BPF packet scheduler [bug] [sched] [bpf]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose
server test` are sometimes failing [bug] [selftests]
  315  Issues with backup flow [bug]


    In Progress (opened, new feature and assigned)

  515  Add `TCP_MAXSEG` socket option support [enhancement] @geliangtang
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

  552  pm: in-kernel: delay before creating new subflows [enhancement]
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


    Recently closed (since 2025-04-09)

None.


    Packetdrill PRs

  52  3 months ago  dcaratti  Add initial coverage for RM_ADDR


    mptcp.dev PRs

/

    mptcpd PRs

  314  2 months ago  matttbe  musl compat



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.16):
https://github.com/orgs/multipath-tcp/projects/14
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees:

        - [2e33d7df9466] tracing: fprobe: Fix RCU warning message in
list traversal (Breno Leitao):
            - TODO: Matth: check if another version didn't get applied
upstream:
                - Apparently no:
https://lore.kernel.org/20250410-fprobe-v1-1-068ef5f41436@debian.org
                - Also reported by Intel's kbot and Steven mentioned the
same patch:
https://lore.kernel.org/20250417104811.38a4bb88@gandalf.local.home

    - Fixes for -net:

        - [68cdd440aed1] selftests: mptcp: diag: use
mptcp_lib_get_info_value (Geliang Tang)
        - [aa9ac409684e] mptcp: pm: Defer freeing of MPTCP userspace
path manager entries (Mat Martineau):
            - Already sent

    - Fixes for net-next: /

    - Features for net-next:

        - [5256f4ab782b] mptcp: pm: init and release mptcp_pm_ops
(Geliang Tang)
        - [a7866d001b42] mptcp: pm: add get_local_id() interface
(Geliang Tang)
        - [bdee73798a4c] mptcp: pm: add get_priority() interface
(Geliang Tang):
            - Waiting for the other patches related to that

        - [8a17ab3368bd] selftests: mptcp: info: hide 'grep: write
error' warnings (Matthieu Baerts (NGI0))
        - [9586657a3611] selftests: mptcp: sockopt: use IPPROTO_MPTCP
for getaddrinfo (Geliang Tang):
            - can be sent

    - Features for net-next (next): /

    - Features for other trees:

        - [de28738ca520] bpf: Register mptcp common kfunc set (Geliang Tang)
        - [5a59ae7f2cb2] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [fcc55860a7e5] selftests/bpf: More endpoints for endpoint_init
(Geliang Tang)
        - [8187fee1054e] selftests/bpf: Add mptcp_subflow bpf_iter
subtest (Geliang Tang)
        - [380c8bae2f9f] selftests/bpf: Drop cgroup_fd of run_mptcpify
(Geliang Tang):
            - Already sent

        - [5d29af4e3cd8] bpf: Add mptcp packet scheduler struct_ops
(Geliang Tang)
        - [049a1c63c38f] bpf: Export mptcp packet scheduler helpers
(Geliang Tang)
        - [849fd010ee63] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [054529909d1a] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [f8e8e7fa1f9d] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [9dfbee81c452] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [621f4be304f1] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [1617ce0aff5f] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang)



Extra tests:
    - news about Syzkaller? (Matth):
        - TODO: Matth: change "owner" in the next meeting → done
        - TODO: check server room temp → WIP
        - Running well, not finding anything related to MPTCP

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp



Next meeting:
    - Next one on Wednesday, the 7th of May.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20250507



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you soon,
Matt
-- 
Sponsored by the NGI0 Core fund.
