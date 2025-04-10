Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE051AAA1E
	for <mptcp@lists.linux.dev>; Thu, 10 Apr 2025 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744303108; cv=none; b=Z+0iU6Mx/uASU6ZaypyY973hzqpwHYVZNmRC63rY6OxQn0L3Iq9biPvYSmB5PyKLGrNIoOovjbKvN+8x+m6j1E2uqvSRsoK5W5v2X4H0gyqMzoqssXJxdPo5wHb9Jki5JXfcCG1q7qAwtiwsdPKKkTvk7sbt8AZRA09p/4yb/s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744303108; c=relaxed/simple;
	bh=0VK2LBZm0VT3uAsoDuthRKuiHupN9EXMZsHO0Fzjg5s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=BrJ9h4dlVDJgPsNeRTxuKotJftKcWW9N44SQHZ5Q/JXJh/uJB56E1Hfnf5ICJd8BAOwZE8xH0O9g8bR6kkOEX0E4GDfatUAJ4ptje5XoHs00VtOafn2i/HkoSwJ/xAVuVqQelGzcf4ZquS5drXqJGIApKhMMgmfwc5Q+vSVxARg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ak0a1Jrg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ak0a1Jrg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A5BC4CEDD
	for <mptcp@lists.linux.dev>; Thu, 10 Apr 2025 16:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744303108;
	bh=0VK2LBZm0VT3uAsoDuthRKuiHupN9EXMZsHO0Fzjg5s=;
	h=Date:From:Subject:To:From;
	b=ak0a1JrghErTviDEXa7s+kMPEvF+8PJkaABYZONzf/DKSUnmvkSy30IxFYZKAOklV
	 qtDjvf7BX3B3GyKqp3K1skxImNmzhnX1rU8idCqUW6v5i5mnJTI5GwBme37vJdlFG3
	 9gfRwiF2LxVeeEAcMv5rxtI27+epCbKm6xrdGaSD36zyxr2vd+swb5DdaU8C/LXljJ
	 rbbJMvpXtlXHnkqjTpcnz5jnjsLeSpCxewhe+7FNy8fiUvKi5yTbCSz3voCtp6EMK9
	 C4FI2PGTqTHMQIP5OyL5xUmcfkO/Qv6ACT1wTWi5wPyh9KZPQOyOTmZqJCv8St2fyF
	 dFgsQWaI6l64Q==
Message-ID: <b09dc718-2701-4160-8de1-7860910e6641@kernel.org>
Date: Thu, 10 Apr 2025 18:38:25 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: en-GB, fr-BE
Subject: [Weekly meetings] MoM - 9th of April 2025
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Linux <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Yesterday, we had our new meeting with Mat (Cruise) and myself (NGI0
Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

14032093: [net,1/4] mptcp: fix NULL pointer in can_accept_new_subflow
14032094: [net,2/4] selftests: mptcp: fix incorrect fd checks in main_loop
14032095: [net,3/4] selftests: mptcp: close fd_in before returning in
main_loop
14032096: [net,4/4] selftests: mptcp: ignore mptcp_diag binary:
    - Series: mptcp: misc. fixes for 6.15-rc0
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=948084&state=*&archive=both

14041515: [net,1/2] mptcp: only inc MPJoinAckHMacFailure for HMAC failures
14041516: [net,2/2] selftests: mptcp: validate MPJoin HMacFailure counters:
    - Series: mptcp: only inc MPJoinAckHMacFailure for HMAC failures
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=950742&state=*&archive=both


    our repo (by: Matthieu Baerts):

14032736: [mptcp-next,1/5] mptcp: only inc MPJoinAckHMacFailure for HMAC
failures
14032737: [mptcp-next,2/5] selftests: mptcp: validate MPJoin HMacFailure
counters
14032738: [mptcp-next,3/5] mptcp: pass right struct to subflow_hmac_valid
14032739: [mptcp-next,4/5] mptcp: add MPJoinRejected MIB counter
14032740: [mptcp-next,5/5] selftests: mptcp: validate MPJoinRejected
counter:
    - Series: mptcp: fix MPJoinAckHMacFailure, add MPJoinRejected
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=948274&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts, Stefan
Metzmacher, Yunsheng Lin):

13897129: [net-next,v2,09/10] net: replace page_frag with page_frag_cache

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
    - waiting for some feedback from the BPF maintainers

14033909: [RFC,1/4] net: introduce get_optlen() and put_optlen() helpers
14033910: [RFC,2/4] net: pass 'optlen_t' to proto[ops].getsockopt() hooks:
14033911: [RFC,3/4] net: pass a kernel pointer via 'optlen_t' to
proto[ops].getsockopt() hooks:
14033912: [RFC,4/4] io_uring: let io_uring_cmd_getsockopt() allow level
other than SOL_SOCKET:
    - Series: net/io_uring: pass a kernel pointer via optlen_t to
proto[_ops].getsockopt()
    - Submitter: Stefan Metzmacher
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=948670&state=*&archive=both
    - Modifying MPTCP but the same way as in other parts of the kernel.


    our repo (by: Gang Yan, Geliang Tang, Gregory Detal, Matthieu
Baerts, zhenwei pi):

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
    - State: New
    - Series: BPF path manager, part 6
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=947940&state=*&archive=both
    - Matth will look at how the pm->lock is handled

14034338: [mptcp-next,1/4] mptcp: pm: add accept_address helper
14034339: [mptcp-next,2/4] mptcp: pm: add accept_new_address() interface
14034340: [mptcp-next,3/4] mptcp: pm: add add_addr_received() interface
14034341: [mptcp-next,4/4] mptcp: pm: add rm_addr_received() interface:
    - State: New
    - Series: BPF path manager, part 7
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=948762&state=*&archive=both
    - the PM ops should look like this:

        /* required, call from the subflow context */
        int (*get_local_id)(struct mptcp_sock *msk,
                            struct mptcp_pm_addr_entry *skc);
        bool (*get_priority)(struct mptcp_sock *msk,
                             struct mptcp_addr_info *skc);
        bool (*accept_new_subflow)(struct mptcp_sock *msk, bool allow);

        /* optional, call from the msk context */
        void (*established)(struct mptcp_sock *msk);
        void (*subflow_established)(struct mptcp_sock *msk);
        void (*add_addr_received)(struct mptcp_sock *msk);
        void (*rm_addr_received)(struct mptcp_sock *msk, u8 rm_id);

    - looks good!

14035512: [mptcp-next,1/3] mptcp: pm: userspace: local_addr_used-- after
sending REMOVE_ADDR
14035513: [mptcp-next,2/3] mptcp: pm: userspace: drop delete_local_addr
helper
14035514: [mptcp-next,3/3] selftests: mptcp: send REMOVE_ADDR after
subflow is deleted:
    - State: Changes requested
    - Series: only remove entry from local_addr_list when sending a
REMOVE_ADDR
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=949152&state=*&archive=both
    - Not clear if it changes the behaviour or not, if it can be
backported or not.
    - Mat will check if it does change the behaviour.
    - Matth will check later.

14036875: [mptcp-next] selftests: mptcp: diag: use mptcp_lib_get_info_value:
    - State: New
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/e34e86805f3fe69e0aec08c83c596c49799573c7.1743666387.git.tanggeliang@kylinos.cn/
    - Matth will look at that

14039147: [mptcp-next] mptcp: pm: drop redundant mptcp_pm_send_ack:
    - State: New
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/539ce4556220df3d2ea4826c311c5bc4e306f9a2.1743863553.git.tanggeliang@kylinos.cn/

14039908: [mptcp-next] selftests: mptcp: diag: drop nlh parameter of
recv_nlmsg:
    - State: New
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/0a7cb982ea5886c2f00e69703feb92c3934dcd63.1744012385.git.tanggeliang@kylinos.cn/
    - Matth will look at that

14044104: [mptcp-next,v2] selftests: mptcp: use IPPROTO_MPTCP for
getaddrinfo:
    - State: New
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/77efff47e3cace7d2dd9a1394d3ece4e234a5e74.1744178165.git.tanggeliang@kylinos.cn/
    - Matth will look at that
    - linked: https://github.com/valkey-io/valkey/pull/1811




Extra, just in case

    deferred (by: Gang Yan):

14044189: [v2,1/2] BCC: Python: Support 'fmod_ret' method for eBPF
14044190: [v2,2/2] BCC: python: add a useful tool for mptcp:
    - Series: BCC: python: support fmod_ret
    - Submitter: Gang Yan
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=951422&state=*&archive=both
    - A PR has been opened: https://github.com/iovisor/bcc/pull/5274



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 555):

/


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


    Recently closed (since 2025-03-26)

  554  Observing significant delays (>30 seconds) on "handover" to
subflow [bug] [pm]
  553  MPTCP backup subflow compatibility [question] [feedback-needed]
@matttbe
  538  [syzkaller] general protection fault in `put_page` (4) [bug]
[syzkaller] [reproducer]
  416  No new subflow when removing an endpoint and adding a new one
[bug] [feedback-needed]


    Packetdrill PRs

  52  2 months ago  dcaratti  Add initial coverage for RM_ADDR


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

    - The changelog has been updated:
https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog



Patches to send to NetDev:

    - Fixes for other trees:

        - [984f05547107] fwctl/cxl: Fix uuid_t usage in uapi (Dan Williams)

    - Fixes for -net: /


    - Fixes for net-next: /


    - Features for net-next:

        - [2a13cfdeed30] mptcp: sched: remove mptcp_sched_data (Matthieu
Baerts (NGI0)):
            - can be sent.

        - [89cc1710b569] mptcp: pm: init and release mptcp_pm_ops
(Geliang Tang)
        - [c6225faeac6c] mptcp: pm: add get_local_id() interface
(Geliang Tang)
        - [3548666bd480] mptcp: pm: add get_priority() interface
(Geliang Tang):
            - maybe best to send those with the rest of the PM ops

        - [22d9c75e5d9d] mptcp: sched: split validation part (Geliang Tang)
        - [28c713276584] mptcp: pm: Return local variable instead of
freed pointer (Thorsten Blum)
        - [5a18533532d2] mptcp: pass right struct to subflow_hmac_valid
(Matthieu Baerts (NGI0))
        - [1795b7066d60] mptcp: add MPJoinRejected MIB counter (Matthieu
Baerts (NGI0))
        - [36d6c66a6587] selftests: mptcp: validate MPJoinRejected
counter (Matthieu Baerts (NGI0)):
            - can be sent

    - Features for net-next (next): /

    - Features for other trees:

        - [9d8b94eb3bb2] bpf: Register mptcp common kfunc set (Geliang Tang)
        - [4c328b8b2369] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [f4c28a1dfa96] selftests/bpf: More endpoints for endpoint_init
(Geliang Tang)
        - [b41675287824] selftests/bpf: Add mptcp_subflow bpf_iter
subtest (Geliang Tang)
        - [b71172be48ea] selftests/bpf: Drop cgroup_fd of run_mptcpify
(Geliang Tang)
        - [747fa5e7195a] bpf: Add mptcp packet scheduler struct_ops
(Geliang Tang)
        - [13d25b82f217] bpf: Export mptcp packet scheduler helpers
(Geliang Tang)
        - [d16ebfe7543c] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [5715ea4636a9] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [ae2a1f33f832] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [f09adae062dd] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [7ad2427fd1c7] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [139c6f993f98] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang)



Extra tests:
    - news about Syzkaller? (Matth):
        - Matth has setup a few machine, with syz-hub
        - currently running without kasan, etc.
        - TODO: add kasan, kmemleak, etc. → In progress

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp
        - enable PREEMPT + DEBUG in debug?

https://lore.kernel.org/netdev/20250402172305.1775226-1-sdf@fomichev.me/



Stable:
    - mptcp: move the whole rx path under msk socket lock:
        - auto selected: not sure why
        - sounds safer to drop it from the stable queues.
        - TODO: Matth: ask to drop it. → Done



Next meeting:
    - Next one on Wednesday, the 23rd of April.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20250423



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you soon,
Matt
-- 
Sponsored by the NGI0 Core fund.

