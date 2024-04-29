Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF7B83CC7
	for <mptcp@lists.linux.dev>; Mon, 29 Apr 2024 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407021; cv=none; b=q9ILP2Ryw99czfv69PK+QOrHLBjX8aJJeGQ28Sf5MZqytTBHHCpAAm2tLbGuD7klz8CYTh6rn1EVWrxky/z0M9yQuteEtP/gAAb1OmUgHjSwfxTlLXblK3+m07A8oddFbl0Ptr37q8LJFBsXHysI6xrRQmew9WjjSgP81Yg2ZDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407021; c=relaxed/simple;
	bh=5KVV7336vX+F/FIsPaMcWP2/4U4eMclWnOdKKRK77lo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=nqdT4DkgeDZLc8kiWt9ePGKST9pVuwDS2gmnXGE8xzOgKCkmBvjvSqe5A+S8VVwqycx7ej4Y7RETu7GQzDHrtII2KbozdYiRqUvZd4A5KuioNQe8WWsjlDFvCuCNOWvMnMA4i4BNLus+I3QcsrBFIAO0M5PZPxffaZulIH/VfuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wr+c+Y6/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wr+c+Y6/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872A8C116B1
	for <mptcp@lists.linux.dev>; Mon, 29 Apr 2024 16:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714407021;
	bh=5KVV7336vX+F/FIsPaMcWP2/4U4eMclWnOdKKRK77lo=;
	h=Date:To:From:Subject:From;
	b=Wr+c+Y6/Su1Drorol810ofRhMIHMbZcfC/6q8FnNno6yOGAMauFtDXoLZPcr3vSP3
	 J7fTbHZexO35JN4vjOXvU+DPUwq7MMkOhKhRVjG8tAtNtYCL3Q1gnQxuBUCSW27QPk
	 Do6XyT12owt6cNu61hbNELuTqwtDHiYpLs9m9+zfWN9thorYlMImlz16pcu+uGo6sj
	 QpFYyqM6R6M5rtJ3Ay1MEvTqUXp3w15IayEOesZ/FI9zBnTKNbGl+DQOvmV8jsUUZD
	 CX6jqZNhO/gDPAscm6Ddk4X6OpcZ06bBKVqhVB0/buzIY2vaqseSK58XvKbX327WZJ
	 f4yRnMlBE+BEg==
Message-ID: <cd86c74a-638a-45a8-9f32-ecfcf7c9b35c@kernel.org>
Date: Mon, 29 Apr 2024 18:10:17 +0200
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
Subject: [Weekly meetings] MoM - 24th of April 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last week, we had our new meeting with Mat (Cruise), Paolo, Davide (Red
Hat), Christoph (Apple), and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Matthieu Baerts, Paolo Abeni):

13632813: [mptcp-next,v9,1/8] selftests/bpf: Add RUN_MPTCP_TEST macro
13632814: [mptcp-next,v9,2/8] Squash to "selftests/bpf: Add bpf
scheduler test" 1 verify
13632815: [mptcp-next,v9,3/8] Squash to "selftests/bpf: Add bpf
scheduler test" 2 time
13632816: [mptcp-next,v9,4/8] Squash to "selftests/bpf: Add bpf_first
scheduler & test"
13632817: [mptcp-next,v9,5/8] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
13632818: [mptcp-next,v9,6/8] Squash to "selftests/bpf: Add bpf_rr
scheduler & test"
13632819: [mptcp-next,v9,7/8] Squash to "selftests/bpf: Add bpf_red
scheduler & test"
13632820: [mptcp-next,v9,8/8] Squash to "selftests/bpf: Add bpf_burst
scheduler & test":
      - Series: refactor mptcp bpf tests
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=845257&state=*&archive=both

13634058: [mptcp-next] Squash to "selftests/bpf: Add bpf_first scheduler
& test" 2:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/cc01abb2882608ac5f719e0f7960aa2a2d9fca41.1713404174.git.tanggeliang@kylinos.cn/

13634284: [mptcp-net,v3] mptcp: ensure snd_nxt is properly initialized
on connect:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/3b0ca23eaa8906f967a841f55bafed48d0f895cb.1713367699.git.pabeni@redhat.com/
      - when the patch has been applied, the CI complained about a test
twice
      - the problem is at the end of the connection: the script expects
to see a DATA_FIN but this DATA_FIN is merged with another packets, it
can happen. (or we need a way to prevent it)

13635076: [mptcp-next] mptcp: sockopt: info: stop early if no buffer:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240418-mptcp-getsockopt-info-opti-v1-1-7138a96eb50c@kernel.org/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Jason Xing, Thomas Weißschuh):

13634417: [v2] sysctl: treewide: constify ctl_table_header::ctl_table_arg:
      - Submitter: Thomas Weißschuh
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240418-sysctl-const-table-arg-v2-1-4012abc31311@weissschuh.net/
      - TODO: archive → Done

13639404: [net-next,v8,1/7] net: introduce rstreason to detect why the
RST is sent
13639405: [net-next,v8,2/7] rstreason: prepare for passive reset
13639406: [net-next,v8,3/7] rstreason: prepare for active reset
13639407: [net-next,v8,4/7] tcp: support rstreason for passive reset
13639408: [net-next,v8,5/7] mptcp: support rstreason for passive reset
13639409: [net-next,v8,6/7] mptcp: introducing a helper into active
reset logic
13639410: [net-next,v8,7/7] rstreason: make it work in trace world:
      - Series: Implement reset reason mechanism to detect
      - Submitter: Jason Xing
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=846887&state=*&archive=both


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

13630040: [net-next,v2,13/15] net: replace page_frag with page_frag_cache
      - Skip: status is the same

13640918: [mptcp-next,v9,1/4] selftests/bpf: Add mptcp subflow example
13640919: [mptcp-next,v9,2/4] selftests/bpf: Add mptcp subflow subtest
13640920: [mptcp-next,v9,3/4] selftests/bpf: Handle SIGINT when creating
netns
13640921: [mptcp-next,v9,4/4] Squash to "selftests/bpf: Add bpf
scheduler test":
      - State: New
      - Series: setsockopt per subflow: BPF
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=847234&state=*&archive=both
      - TODO: applied them, then check with Geliang if he wants to send them
      - (Please send them for me, thanks. Geliang)



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 485):

  487  BPF selftests fails with EAGAIN [bug] [selftests] [bpf]:
      - it looks like we can get that with a blocking IO socket
      - to be investigated
      - when a lock has to be acquired by the BPF program, it is in fact
acquired before calling the BPF program. The rest of the operations are
done in a non-blocking mode, and that's maybe how we can get EAGAIN here.


    Bugs (opened, flagged as "bug" and assigned)

  477  Client: fallback to TCP after X MPC [bug] @matttbe
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  487  BPF selftests fails with EAGAIN [bug] [selftests] [bpf]
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
  383  TCP_KEEPIDLE, TCP_KEEPINTVL, TCP_KEEPCNT are not implemented in
mptcp_setsockopt_sol_tcp [enhancement] @matttbe
  353  sockopt: uniform code to get/set values [enhancement] @matttbe
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   76  [gs]etsockopt per subflow: BPF [enhancement] [bpf] @geliangtang
   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang
   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang


    Assigned Questions (opened, questions and assigned)

None.


    Open questions (opened, questions and not assigned)

  479  when using openvpn in tcp with dco, we have a bug [question]
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


    Recently closed (since 2024-04-17)

  485  syzkaller: WARNING in `__mptcp_clean_una` [bug] [syzkaller]
[reproducer]
  294  Clear way for userspace to know if the connection fell back to
TCP [enhancement] @matttbe:
     - The example has been updated to take into account client cases.



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.10):
https://github.com/orgs/multipath-tcp/projects/8
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees: /


    - Fixes for -net:

        - [5842b10c9cb9] selftests: mptcp: simult flows: re-adapt BW
(Matthieu Baerts (NGI0)):
            - wait

        - [ae14d5ad20e4] mptcp: ensure snd_nxt is properly initialized
on connect (Paolo Abeni):
            - can be sent: TODO: Matth

    - Fixes for net-next:

        - [d174967b4447] selftests/bpf: Use connect_fd_to_fd in
bpf_tcp_ca (Geliang Tang)
        - [49e870fbed18] selftests/bpf: Drop settimeo in do_test
(Geliang Tang)
        - [9654a8889fa4] selftests/bpf: Add pid limit for mptcpify prog
(Geliang Tang)

    - Features for net-next:

        - [17014a25b61b] mptcp: sockopt: info: stop early if no buffer
(Matthieu Baerts (NGI0)):
            - not urgent, can wait

    - Features for net-next (next): /

    - Features for other trees:

        - [c8118b3a3a3b] mptcp: add sched_data helpers (Geliang Tang)
        - [eb524dcb1321] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [98d612d35269] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [87bc4d57b4e8] selftests/bpf: Add RUN_MPTCP_TEST macro
(Geliang Tang)
        - [93ae2148e798] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [103da64db69a] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [e89a210d6afc] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [ad44a1b6e4e6] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [705ef08abad6] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [80645db5f48a] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [8c311d579cb6] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [b37f50ee0cbd] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang):
            - status: same as before



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - /



mptcp.dev:
    - Went on HackerNews: https://news.ycombinator.com/item?id=40089609
    - 7k visits according to CloudFlare (but blocked by ad blockers, I
guess used by many in this "hacker" community)



MPTCP on macOS:
    - high level API to get access to the flow stuff to be able to use
multiple subflows:
        - Recommended way:
          https://developer.apple.com/documentation/network
        - example with OpenSSH:
https://github.com/apple-oss-distributions/OpenSSH/blob/main/openssh/sshconnect.c#L487

    - can we use AF_MULTIPATH + connectx()?:
        - should work but *not* recommended: AF_MULTIPATH is not an API:
so it might change
        - To be tested on macOS: e.g. being connected by Ethernet + WiFi
(different networks), disconnect Ethernet
        - Example in Rust:
https://github.com/gdetal/mptcp-rs/commit/3584874b1f62d10caf5b2d75e170a50aa901204d#diff-34b81f44eb134c3ded2896ab21b7678fc225b360194c0da53be1551cacddfb92



Check fallback:
    - current way:
        - MPTCP_INFO (>= 5.16): err || (mptcpi_flags &
MPTCP_INFO_FLAG_FALLBACK)
        - MPTCP_INFO now requires 2 locks (sock (lock_sock_fast) + data
(spin lock))
    - A new dedicated socket option?:
        - typically we want to know if a socket was established with
MPTCP at the beginning of a connection
        - server case is still annoying: if the client didn't ask to use
MPTCP, the kernel will create a TCP socket, so we get the same error if
the kernel doesn't support this or a fallback happened because we don't
go through mptcp_getsockopt()
        - Or we patch the upper layer to return a different error
(supported vs fallback)
        - Or we add this socket option in TCP level space
    => TODO: Matth: share RFC for ↑



Next meeting:
    - *No meeting on the 1st of May*
    - Next one on *Wednesday*, the 8th of May.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240508



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you *next* Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.

