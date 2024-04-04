Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8873459157
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228592; cv=none; b=PT+ya8KkEEg1CtgnMFhyE+Sjsuav2hR5gkzbll8do0JOmPRN6nNdX+ShF3dJF8NFqNdrLfYXhqqjHzXqcvWUBhlo8VKXyPEKEbe6C38c9XEvJM5NV3mTLdCP7mAkpT6qHx7kj75TMKj0bp59m8xNl1Y+hB6G0hNQhGbfITssEfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228592; c=relaxed/simple;
	bh=6BUQlD0itmSN3t4Tctpllglg0/sZ6F4qr+owqoZrxEI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=OXH29iAqZLqOumSg+/AagQvD2E0ZCf0WS7pjQXg1S3KSYnj1+ril9jmQ6v7BMIA25o9BIJcCanf8UtIVN9qdPXvVd1tvAp+kWElKxWYQ45XJ+s7XiUzrCkkr9KjUUttHKopf0CVnrl76P36Gpt1CwBlPHTgneBI6GwLliahnw2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaR9iaRO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaR9iaRO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A02C43390
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 11:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712228592;
	bh=6BUQlD0itmSN3t4Tctpllglg0/sZ6F4qr+owqoZrxEI=;
	h=Date:From:Subject:To:From;
	b=EaR9iaROhZcNmFb3KEiGs7Fcz7AqqMmIigtup9DliwWUNnXQfTSHrA1/RdawG0HX+
	 /n9ZCxaKxzct6G9BU926scPSQVXGjUwa6pBHBxiKWVre2JwoR18DX3mU7u2TQV6Bl8
	 CiyTU5K3iqfI9HV/gcpBkFNyWDhzDO+TSbgJ9X3Ox9JYpC0wOSRb7uU4gXZwnTF2Ek
	 Q4tDc9VxkNUw0VVuBnRI6TGHG0D1rms6PsnLSerj0SnMjD8C2XeINhwOxJD6XQCCa6
	 4xOsMYgoh4cEB10+dFKQZp2tSWA1AAsQTET2GxmqmPkhmKaim0fNP/DBiwdCp7Bm7e
	 HtV8NuLEG4sxg==
Message-ID: <73ed8019-2c6e-4b2d-93e0-05c28f2da0fa@kernel.org>
Date: Thu, 4 Apr 2024 13:03:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 3rd of April 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our new meeting with Mat (Cruise), Paolo (Red Hat),
Christoph (Apple), and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts, Paolo Abeni):

13610598: [net,1/2] mptcp: don't account accept() of non-MPC client as
fallback to TCP
13610599: [net,2/2] selftests: mptcp: join: fix dev in check_endpoint:
      - Series: mptcp: fix fallback MIB counter and wrong var in selftests
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=839766&state=*&archive=both

13610680: [6.1.y] selftests: mptcp: diag: return KSFT_FAIL not test_cnt:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240329143617.1542073-2-matttbe@kernel.org/

13610683: [5.15.y] selftests: mptcp: diag: return KSFT_FAIL not test_cnt:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240329145105.1637785-2-matttbe@kernel.org/

13610934: [net] mptcp: prevent BPF accessing lowat from a subflow socket.:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/d8cb7d8476d66cb0812a6e29cd1e626869d9d53e.1711738080.git.pabeni@redhat.com/
      - possibly linked (future) issue:
          - doing a setsockopt on an MPTCP socket might be a problem:
              - this is done in an atomic context
              - but MPTCP will then lock the subflows
              - to be checked
              - TODO: Matth: open a new issue → done #484
         - we could have a similar issue with peek_xxx:
             - but from what Paolo saw, BPF doesn't allow this socketoption
             - TODO: Matth: check and open a new issue if needed →
               - looks OK: only supported by UNIX and UDP sockets


    our repo (by: Geliang Tang):

13613964: [mptcp-next,v5,1/2] mptcp: add last time fields in mptcp_info
13613965: [mptcp-next,v5,2/2] selftests: mptcp: test last time mptcp_info:
      - Series: display "last time" actions info
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=840625&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Jason Xing, Joel
Granados via B4 Relay, Yunsheng Lin):

13608552: [RFC,10/10] net: replace page_frag with page_frag_cache:
      - Series: -
      - Submitter: Yunsheng Lin
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=839344&state=*&archive=both:
    - Not specific to MPTCP, modifications are similar to what has been
done in other parts
    - Might still be good to review that if we have a chance to

13608731: [v2,0/4] sysctl: Remove sentinel elements from networking
13608732: [v2,1/4] networking: Remove the now superfluous sentinel
elements from ctl_table array:
    - Not specific to MPTCP, modifications are similar to what has been
done in other parts
    - TODO: Matth: archive them → Done

13613430: [bpf-next,1/3] selftests/bpf: Export send_byte helper
13613431: [bpf-next,2/3] selftests/bpf: Add struct send_recv_arg
13613432: [bpf-next,3/3] selftests/bpf: Export send_recv_data helper:
      - Series: export send_byte and send_recv_data
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=840471&state=*&archive=both

13615107: [net-next,1/6] net: introduce rstreason to detect why the RST
is sent
13615108: [net-next,2/6] rstreason: prepare for passive reset
13615109: [net-next,3/6] rstreason: prepare for active reset
13615110: [net-next,4/6] tcp: support rstreason for passive reset
13615111: [net-next,5/6] mptcp: support rstreason for passive reset
13615112: [net-next,6/6] rstreason: make it work in trace world:
      - Series: Implement reset reason mechanism to detect
      - Submitter: Jason Xing
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=840909&state=*&archive=both
      - Patches 1-3, 5-6 need to be reviewed


    our repo (by: Geliang Tang, Matthieu Baerts):

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
      - Status: same as before

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
      - Status: same as before

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
      - Status: same as before

13603810: [bpf-next,v4,1/2] selftests/bpf: Use connect_fd_to_fd in
bpf_tcp_ca
13603811: [bpf-next,v4,2/2] selftests/bpf: Drop settimeo in do_test:
      - State: Queued
      - Series: Use start_server and connect_fd_to_fd
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=838305&state=*&archive=both
      - TODO: Matth: add them in our tree (if bpf-next is not merged
into net-next before) → Done

13610499: [iproute2-next] ss: mptcp: print out last time counters:
      - State: Awaiting upstream
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/fd9e850f1e00691204f1dfebc63c01c6a4318c10.1711705327.git.geliang@kernel.org/

13613467: [mptcp-next,v5,01/10] Squash to "selftests/bpf: Add bpf
scheduler test" 1 nonblock
13613468: [mptcp-next,v5,02/10] selftests/bpf: Add RUN_MPTCP_TEST macro
13613469: [mptcp-next,v5,03/10] Squash to "selftests/bpf: Add bpf
scheduler test" 2 verify
13613470: [mptcp-next,v5,04/10] Squash to "selftests/bpf: Add bpf
scheduler test" 3 time
13613471: [mptcp-next,v5,05/10] selftests/bpf: Add MPTCP_SCHED_TEST macro
13613472: [mptcp-next,v5,06/10] Squash to "selftests/bpf: Add bpf_first
scheduler & test"
13613473: [mptcp-next,v5,07/10] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
13613474: [mptcp-next,v5,08/10] Squash to "selftests/bpf: Add bpf_rr
scheduler & test"
13613475: [mptcp-next,v5,09/10] Squash to "selftests/bpf: Add bpf_red
scheduler & test"
13613476: [mptcp-next,v5,10/10] Squash to "selftests/bpf: Add bpf_burst
scheduler & test":
      - State: New
      - Series: refactor mptcp bpf tests
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=840483&state=*&archive=both
      - TODO: Matth: check this

13613493: [mptcp-next,v6,1/8] Squash to "selftests/bpf: Add bpf
scheduler test" 4 send_data
13613494: [mptcp-next,v6,2/8] selftests/bpf: Handle SIGINT when creating
netns
13613495: [mptcp-next,v6,3/8] selftests/bpf: Refactor mptcp_sock test
13613496: [mptcp-next,v6,4/8] selftests/bpf: Refactor mptcpify test
13613497: [mptcp-next,v6,5/8] selftests/bpf: Add MPTCP_BASE_TEST macro
13613498: [mptcp-next,v6,6/8] selftests/bpf: Add mptcp subflow example
13613499: [mptcp-next,v6,7/8] selftests/bpf: Add mptcp subflow subtest
13613500: [mptcp-next,v6,8/8] Squash to "selftests/bpf: Add bpf
scheduler test" 5 endpoint_init:
      - State: New
      - Series: setsockopt per subflow: BPF
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=840488&state=*&archive=both
      - Looks like it depends on "refactor mptcp bpf tests"
      - Probably best not to have too many series depending on each
others, best to do one at a time
      - Mat will look at it

13613718: [bpf-next] selftests/bpf: Add pid limit for mptcpify prog:
      - State: Queued
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/8987e2938e15e8ec390b85b5dcbee704751359dc.1712054986.git.tanggeliang@kylinos.cn/
      - Without this patch, some tests in bpf selftests were using MPTCP
instead of TCP when being launched in //

13615363: [bpf-next] selftests/bpf: Add F_SETFL for fcntl:
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/b67101632c6858d281f105b5d4e1bc62dd6b7d27.1712133039.git.tanggeliang@kylinos.cn/
      - Not linked to MPTCP, a fix while doing some refactoring



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 480):

  483  [6.1] selftests: `mptcp_connect.sh` failures with
`copyfd_io_poll: poll timed out` errors [bug] [selftests]:
      - maybe there are two differents issues in this ticket:
          - the first one is with mptcp_connect.sh:
              - a timeout error
              - maybe we missed the FIN: from Paolo: check the expected
seq num (/send,received bytes)
          - the second one is with mptcp_join.sh:
              - there is a RST because one peer sends data after having
ACKed the FIN (so the other peer sends a reset)
      - more investigation needed here

  481  remove refcount on TCP sockets for the timers [enhancement]:
      - linked to a patch created by Eric
      - we should be able to remove some code, all instructions are
there, but it needs to be tested


    Bugs (opened, flagged as "bug" and assigned)

  477  Client: fallback to TCP after X MPC [bug] @matttbe
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

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


    For later (opened and not assigned assigned)

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

  128  When the last subflow is closed without DATA_FIN and msk
Established, close msk (after a timeout) [enhancement]:
      - TODO: Matth: close this → Done

   78  notify the application (userspace) when a subflow is
added/removed [enhancement]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 2024-03-27)

  482  `SO_RCVLOWAT` modified via BPF
  463  syzkaller: INFO: task hung in `lock_sock_nested` [bug] [syzkaller]
  446  MPTCP Info counters: display "last time" actions info
[enhancement] @geliangtang
  394  selftests: ability to track subtests [enhancement] [selftests]
  318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
cookies [bug] [selftests]
  133  PM: Closing the MPTCP connection when last subflow is not the
initial one and its IP address is removed [enhancement]
   77  [gs]etsockopt: forward to new/existing SF [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
      - Spring cleaning \o/



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.10):
https://github.com/orgs/multipath-tcp/projects/8
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [e6c3ccbdb932] selftests: mptcp: simult flows: re-adapt BW
(Matthieu Baerts (NGI0))
            - wait

    - Fixes for net-next: /

    - Features for net-next:

        - [8d5eec164b1f] selftests: mptcp: add tc check for check_tools
(Geliang Tang)
        - [b84449c02c18] selftests: mptcp: add ms units for tc-netem
delay (Geliang Tang)
        - [2b69c1d3b33c] selftests: mptcp: export ip_mptcp to mptcp_lib
(Geliang Tang)
        - [8910e1ff4422] selftests: mptcp: netlink: add 'limits' helpers
(Geliang Tang)
        - [64cbbc6fefba] selftests: mptcp: add {get,format}_endpoint(s)
helpers (Geliang Tang)
        - [27cfda69b5ec] selftests: mptcp: netlink: add change_address
helper (Geliang Tang)
        - [99e6dace203d] selftests: mptcp: join: update endpoint ops
(Geliang Tang)
        - [db4ef5769567] selftests: mptcp: export pm_nl endpoint ops
(Geliang Tang)
        - [c5066f888fd8] selftests: mptcp: use pm_nl endpoint ops
(Geliang Tang)
        - [d08c282ad327] selftests: mptcp: ip_mptcp option for more
scripts (Geliang Tang)
        - [50c41f29b9fd] selftests: mptcp: netlink: drop disable=SC2086
(Geliang Tang):
            - Can be sent:
                - not right now: depends on a patch that is currenty in
-net, but not in net-next
                - should be OK on Friday

        - [6778e961b726] mptcp: add last time fields in mptcp_info
(Geliang Tang)
        - [62648327acd6] selftests: mptcp: test last time mptcp_info
(Geliang Tang):
            - Can be sent:
                - not right now: applied yesterday
                - but should be ok on Friday

    - Features for net-next (next): /

    - Features for other trees:

        - [9764079c66c6] mptcp: add sched_data helpers (Geliang Tang)
        - [c1a2fb3cfb7f] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [3517a11d6723] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [1f238f31d8c0] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [046177f43010] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [ee781eb7dec0] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [3490ad935b01] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [03aaefbff864] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [a87fbe24a0a3] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [5cd8db34e215] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [f36cb0a00c9c] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [210169a081b4] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [f17f2d90a1cc] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [0b65fca2c6eb] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [fdebfd050c0d] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [779b4f240d6d] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - status: same: depends on a refactoring of the sched API



Extra tests:
    - news about Syzkaller? (Christoph):
        - Christoph is now running syzkaller on top of the export branch
        - still some issues to test the RH kernel

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - looks stable



mptcp git repo on kernel.org:
    - Konstantin created this NS:
        https://git.kernel.org/pub/scm/linux/kernel/git/mptcp/
    - But do we want to use it?
    - Confusing if it is not up to date:
        - or we have a mirror but not sure if there is something on
gitolite side to automatically sync it
        - or use the description to say to check github
        - TODO: Matth: check what is possible there:
            - no option to automatically mirror a repo from outside
kernel.org
            - probably best to have an empty repo with a description
explaining to look at GitHub for the moment?



MPTCP and xz support:
    - https://social.kernel.org/notice/AgRHZ8p1mmJPKAmgGO
    - (it only works on the 1st of April)



Next meeting:
    - Next one on *Wednesday*, the 10th of April.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240410



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.

