Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA09F446AE
	for <mptcp@lists.linux.dev>; Wed, 27 Dec 2023 11:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVYoONZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0A3C433C7
	for <mptcp@lists.linux.dev>; Wed, 27 Dec 2023 11:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703677409;
	bh=jqhnE5LKdNn3EMC0wZcG8GccYjHrmjHe6+ru965NsA4=;
	h=Date:From:Subject:To:From;
	b=DVYoONZhxSmMcjUIK8Yr4y23DKmWVj5/fz0JdAVf198xfjqYdZtxrpHxBNO137O8O
	 OZcca07i3cC1IhWyTvT/JJH1FAdiLpHWlzCZVZEQ5wHv+5fB3Mo9DRZVBOG+L0pE/N
	 lkGfuxw152vlXA4i4YGIuhp32R36W3w0YS6MnbB/UzGw3nO4ARUJuAXAlzrMGwdiwY
	 E+TjCVsJ/Bw4VOTbZZG+87oR8O6alK8bje1r6/3QZPqkc3frNEZygBlUvJwKmGG+T9
	 MbbHCkXdXy+A1KabskqiO9OBEKEpc59nzwNXzWjLf1EnYbKzafXpa2OQY0kQc71yef
	 1yjkmUL00mEOg==
Message-ID: <2bd312a6-d5dc-4f28-a6d8-dce9f09656ee@kernel.org>
Date: Wed, 27 Dec 2023 12:43:27 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 13th of December 2023
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Two weeks ago, we had our 266th meeting with Christoph (Apple), Davide,
Paolo (Redhat), Mat (Cruise) and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Davide Caratti, Geliang Tang):

13486799: [mptcp-next] mailmap: add entries for Geliang Tang:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/887df28eb56432c25ae6cc64da4817667562a020.1702282928.git.geliang.tang@linux.dev/

13486990: [mptcp-next,v2] mptcp: don't overwrite sock_ops in
mptcp_is_tcpsk():
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/784668db3e21351c91f4f312720059c6fa5cc15d.1702290281.git.dcaratti@redhat.com/

13490372: [mptcp-next,v5,1/3] mptcp: add mptcp_set_state
13490373: [mptcp-next,v5,2/3] mptcp: use mptcp_set_state
13490374: [mptcp-next,v5,3/3] selftests: mptcp: check CURRESTAB counters:
      - Series: add MPTCP_MIB_CURRESTAB
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=809531&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang):

13474261: [iproute2-next] ss: mptcp: print out subflows_total counter:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/ecf501dce539b4cc77e450d510c0414eec4bba7f.1701344289.git.geliang.tang@linux.dev/
      - It has been accepted (but no notifications have been sent)


    our repo (by: Geliang Tang, Matthieu Baerts, Maxim Galaganov):

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

13294008: [iperf3] add MPTCPv1 support:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/
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

13479469: [mptcp-next,v5,01/33] selftests: mptcp: add mptcp_lib_evts_*
helpers
13479470: [mptcp-next,v5,02/33] selftests: mptcp: userspace: capitalize
test_name
13479472: [mptcp-next,v5,03/33] selftests: mptcp: userspace: print
colored output
13479471: [mptcp-next,v5,04/33] selftests: mptcp: capitalize ok/fail/skip
13479473: [mptcp-next,v5,05/33] selftests: mptcp: extract
mptcp_lib_check_expected
13479474: [mptcp-next,v5,06/33] selftests: mptcp: export event macros in
mptcp_lib
13479475: [mptcp-next,v5,07/33] selftests: mptcp: add
mptcp_lib_verify_listener_events
13479476: [mptcp-next,v5,08/33] selftests: mptcp: unify namespace names
13479477: [mptcp-next,v5,09/33] selftests: mptcp: add mptcp_lib_ns_* helpers
13479478: [mptcp-next,v5,10/33] selftests: mptcp: add ss mptcp support
checks
13479479: [mptcp-next,v5,11/33] selftests: mptcp: add
mptcp_lib_check_tools helper
13479480: [mptcp-next,v5,12/33] selftests: mptcp: diag: print colored output
13479481: [mptcp-next,v5,13/33] selftests: mptcp: connect: print colored
output
13479482: [mptcp-next,v5,14/33] selftests: mptcp: sockopt: print every
test result
13479483: [mptcp-next,v5,15/33] selftests: mptcp: sockopt: print colored
output
13479484: [mptcp-next,v5,16/33] selftests: mptcp: simult flows: print
colored output
13479485: [mptcp-next,v5,17/33] selftests: mptcp: connect: add PORT
instead of TEST_COUNT
13479486: [mptcp-next,v5,18/33] selftests: mptcp: connect: print out
test counter
13479487: [mptcp-next,v5,19/33] selftests: mptcp: rename test_cnt to
TEST_COUNT
13479488: [mptcp-next,v5,20/33] selftests: mptcp: diag: print out test
counter
13479489: [mptcp-next,v5,21/33] selftests: mptcp: simult flows: print
out test counter
13479490: [mptcp-next,v5,22/33] selftests: mptcp: sockopt: print out
test counter
13479491: [mptcp-next,v5,23/33] selftests: mptcp: netlink: print out
test counter
13479492: [mptcp-next,v5,24/33] selftests: mptcp: userspace: print out
test counter
13479493: [mptcp-next,v5,25/33] selftests: mptcp: export TEST_NAME/COUNT
to mptcp_lib
13479494: [mptcp-next,v5,26/33] selftests: mptcp: simult flows: define
missing vars
13479495: [mptcp-next,v5,27/33] selftests: mptcp: export
cin/cout/sin/sout vars
13479496: [mptcp-next,v5,28/33] selftests: mptcp: join: change
capture/checksum as bool
13479497: [mptcp-next,v5,29/33] selftests: mptcp: export
capture/checksum vars
13479498: [mptcp-next,v5,30/33] selftests: mptcp: diag: change
timeout_poll to 30
13479499: [mptcp-next,v5,31/33] selftests: mptcp: export timeout_test to
mptcp_lib
13479500: [mptcp-next,v5,32/33] selftests: mptcp: use KSFT_SKIP instead
ksft_skip
13479501: [mptcp-next,v5,33/33] selftests: mptcp: use KSFT_PASS and
KSFT_FAIL:
      - State: Needs ack
      - Series: add helpers and vars in mptcp_lib.sh
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=806904&state=*&archive=both
      - Status: same as before

13485151: [mptcp-next,v14,01/25] mptcp: export pm_nl_get_pernet_from_msk
13485153: [mptcp-next,v14,02/25] mptcp: drop mptcp_pm_get_* helpers
13485152: [mptcp-next,v14,03/25] mptcp: use pernet id_bitmap in
userspace pm:
    - Can be dropped
13485156: [mptcp-next,v14,05/25] mptcp: drop lookup_by_id parameter in
lookup_addr
13485160: [mptcp-next,v14,10/25] mptcp: set set_id flag when parsing addr
13485161: [mptcp-next,v14,11/25] mptcp: use set_id flag when appending addr
13485162: [mptcp-next,v14,12/25] mptcp: check addrs list in
userspace_pm_get_local_id
13485163: [mptcp-next,v14,13/25] selftests: mptcp: dump after creating
id 0 subflow
13485164: [mptcp-next,v14,14/25] mptcp: map v4 address to v6 when
destroying subflow
13485165: [mptcp-next,v14,15/25] selftests: mptcp: rm subflow with
v4/v4mapped addr
13485166: [mptcp-next,v14,16/25] mptcp: make
pm_remove_addrs_and_subflows static
13485167: [mptcp-next,v14,17/25] mptcp: add a prefix for
free_local_addr_list
13485168: [mptcp-next,v14,18/25] selftests: mptcp: flush userspace addrs
list
13485169: [mptcp-next,v14,19/25] mptcp: add use_id parameter for
addresses_equal
13485170: [mptcp-next,v14,20/25] mptcp: add check_id for
lookup_anno_list_by_saddr
13485171: [mptcp-next,v14,21/25] mptcp: add userspace_pm_get_entry helper
13485172: [mptcp-next,v14,22/25] mptcp: drop addr_match and id_match
13485173: [mptcp-next,v14,23/25] mptcp: dup an entry when removing it
13485174: [mptcp-next,v14,24/25] mptcp: add userspace pm addr entry refcount
13485175: [mptcp-next,v14,25/25] selftests: mptcp: rm userspace addr
with random order:
      - State: Changes requested
      - Series: userspace pm enhancements
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=808195&state=*&archive=both

      > Part 1: dump for userspace pm (patches 1-9):
          - Patch 1-9 are supposed to be replaced: dump for userspace pm
          - we still have patches 1, 2, 5: TODO, Matth: ask Geliang if
we drop them or not → Done

      > Part 2: fixes for creating id 0 subflow (patches 10-13):
          - not ideal to have fixes after not features
          - to be reviewed

      > Part 3: v4-mapped addr support (patches 14-15):
          - to be reviewed

      > Part 4: flush for userspace pm (patches 16-18):
          - We don't need that

      > Part 5: address entry refcount for userspace pm (patches 19-25):
          - From Mat: I think a refcount is not necessary to make the
userspace local address list work correctly.
https://lore.kernel.org/all/e136346b-936f-9f63-50a0-788bef0f276e@kernel.org/
          - We should not need to have this to delete a subflow
          - even to remove an address ID that was previously needed: we
need the local list for the MP_JOIN
          - Matth: check that


13486777: [mptcp-next,01/12] mptcp: add mptcp_pm_nl_put_entry_msg helper
13486778: [mptcp-next,02/12] mptcp: implement mptcp_userspace_pm_dump_addr
13486779: [mptcp-next,03/12] mptcp: dump addrs in userspace pm list
13486780: [mptcp-next,04/12] mptcp: check userspace pm subflow flag
13486781: [mptcp-next,05/12] selftests: mptcp: add userspace pm subflow flag
13486783: [mptcp-next,06/12] selftests: mptcp: dump userspace addrs list
13486782: [mptcp-next,07/12] mptcp: add userspace_pm_lookup_addr_by_id
helper
13486784: [mptcp-next,08/12] mptcp: add mptcp_pm_nl_put_entry_info helper
13486785: [mptcp-next,09/12] mptcp: implement mptcp_userspace_pm_get_addr
13486786: [mptcp-next,10/12] mptcp: get addr in userspace pm list
13486787: [mptcp-next,11/12] selftests: mptcp: add token for get_addr
13486788: [mptcp-next,12/12] selftests: mptcp: userspace pm get addr tests:
      - State: New
      - Series: dump for userspace pm
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=808681&state=*&archive=both
      - What's the use-case for that?:
          - Recovery (if the userspace daemon crashed/got updated/...)?
          - It means that the userspace daemon has to list all the MPTCP
connections, then for each of them, ask individually to get more info
(addresses ID)
          - Maybe more efficiant to dump info from all MPTCP connections
of a netns?
        - We need to think a bit more about that.


13487112: [v3,mptcp-next,1/3] mptcp: rename
mptcp_setsockopt_sol_ip_set_transparent()
13487113: [v3,mptcp-next,2/3] mptcp: sockopt: support
IP_LOCAL_PORT_RANGE and IP_BIND_ADDRESS_NO_PORT
13487114: [v3,mptcp-next,3/3] selftests/net: add MPTCP coverage for
IP_LOCAL_PORT_RANGE:
      - State: New
      - Series: more sockopts for ephemeral ports
      - Submitter: Maxim Galaganov
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=808765&state=*&archive=both
      - Can be applied: TODO Matth → Done




Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 466):

  467  Scheduler: add redundant scheduler support in BPF [enhancement]
[sched]:
      - initially a question
      - Maybe MPTCP is not the best for this use-case:
          - TCP might not be one if the goal is to have a low latency
communication
          - if we loose a packet, we still need to retransmitted even if
it has been received via another subflow
          - but can still be implemented if it doesn't affect others


    Bugs (opened, flagged as "bug" and assigned)

  451  syzkaller: possible deadlock in` __dev_queue_xmit` [bug]
[syzkaller] @dcaratti
  435  in-kernel PM: fullmesh: too many paths are being created [bug]
@matttbe
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  466  syzkaller: v6.1.65 KASAN: use-after-free Read in
`mptcp_subflow_queue_clean` [bug] [syzkaller] [reproducer] [bisected]:
      - only in v6.1?

  465  syzkaller: v6.1.60 - refcount_t: addition on 0; use-after-free
[bug] [syzkaller] [reproducer] [bisected]:
      - Only in v6.1 apparently
      - Maybe one patch has not been backported?
      - Christoph will share a diff (+ git log) with 6.1.60 and MPTCP
export branch

  463  syzkaller: INFO: task hung in `lock_sock_nested` [bug] [syzkaller]
  449  `MPTcpExtMPCapableFallbackACK` - looks surprising [bug]
  445  MPTCP Info counters: start seq numbers ones from 0 [bug]
  439  mptcp vs net.ipv4.tcp_shrink_window [bug]
  416  No new subflow when removing an endpoint and adding a new one [bug]
  336  Issues with BPF packet scheduler [bug] [sched] [bpf]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose
server test` are sometimes failing [bug] [selftests]
  318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
cookies [bug] [selftests]
  315  Issues with backup flow [bug]


    In Progress (opened, new feature and assigned)

  464  `TCP_NOTSENT_LOWAT` socket-option support [enhancement] @pabeni
  432  Rename `mptcp_is_tcpsk()` helper [enhancement] @dcaratti
  403  userspace pm: local_addr_list: use a refcount per entry
[enhancement] [pm] @geliangtang
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

  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned assigned)

  467  Scheduler: add redundant scheduler support in BPF [enhancement]
[sched]
  462  selftests: print (and set?) random seed [enhancement] [selftests]
  461  Protocol: extend Data-Level Length field [enhancement]
  453  sk_is_mptcp() only works with struct tcp_sock * [enhancement]
  448  Allow sending ADD_ADDR IPv6 with port-number if TCP-timestamps
are enabled [enhancement]
  446  MPTCP Info counters: display "last time" actions info [enhancement]
  441  optimize established options generation [enhancement]
  440  in-kernel PM: re-establish subflows after "network" errors
[enhancement] [pm]
  426  selftests: validate listener sockets with multiple accepts
[enhancement] [selftests]
  406  Compile and run mptcp bpf selftests in CI [enhancement] [selftests]
  397  Doc and guidance for users [enhancement] [documentation]
  396  ci: periodically run selftests from the export branch on stable
kernels [enhancement] [selftests]
  394  selftests: ability to track subtests [enhancement] [selftests]
  389  packetdrill: increase coverage for "early `close()`" cases
[enhancement] [packetdrill]
  383  TCP_KEEPIDLE, TCP_KEEPINTVL, TCP_KEEPCNT are not implemented in
mptcp_setsockopt_sol_tcp [enhancement]
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
  133  PM: Closing the MPTCP connection when last subflow is not the
initial one and its IP address is removed [enhancement]
  128  When the last subflow is closed without DATA_FIN and msk
Established, close msk (after a timeout) [enhancement]
   78  notify the application (userspace) when a subflow is
added/removed [enhancement]
   77  [gs]etsockopt: forward to new/existing SF [enhancement]
   76  [gs]etsockopt per subflow: BPF [enhancement] [bpf]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 2023-12-06)

  460  Add `MPTCP_MIB_CURRESTAB` similar to TCP [enhancement] @geliangtang
  425  syzkaller: validate all MPTCP Netlink API [enhancement] [syzkaller]



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.8):
https://github.com/orgs/multipath-tcp/projects/6
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [40abb6c801f4] selftests: mptcp: join: fix subflow_send_ack
lookup (Geliang Tang)
        - [9dcb67a7f3c7] mptcp: fix inconsistent state on fastopen race
(Paolo Abeni)
        - [ec3783bd4ce1] mptcp: fill in missing MODULE_DESCRIPTION()
(Matthieu Baerts)
        - [b1899fabd4a5] mailmap: add entries for Geliang Tang (Geliang
Tang):
            - TODO: Matth: send patches → Done

    - Fixes for net-next: /

    - Features for net-next:

        - [df09292a74fa] mptcp: cleanup state propagation (Paolo Abeni):
            - depends on "mptcp: fix inconsistent state on fastopen race"
        - [b491534e5b5b] mptcp: don't overwrite sock_ops in
mptcp_is_tcpsk() (Davide Caratti)
        - [e7d53b5a6bb7] mptcp: add mptcp_set_state (Geliang Tang):
            - Probably best to change the title:
                - mptcp: add CURRESTAB MIB (something like that)
                - TODO: mention that on the ML → Done
        - [4bc16e4367e0] mptcp: use mptcp_set_state (Geliang Tang):
            - Matth suggested modifying something there
        - [21ebfc777c66] selftests: mptcp: check CURRESTAB counters
(Geliang Tang):
            - Matth suggested modifying something there
        → send them next week

    - Features for net-next (next): /

    - Features for other trees:

        - [1975f7807d87] mptcp: add sched_data helpers (Geliang Tang)
        - [8ab2a8bea581] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [27911655e0c5] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [7320c7a275f9] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [6bb575951a8a] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [348c7022a938] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [a2701342bb4b] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [f6ea2c2dbb2c] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [f8fd54d71117] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [5ec56f2cbfa7] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [3d17ec6f9de6] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [547ec3ac6165] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [daac783ea89e] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [11b72fcdc667] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [27907afcec48] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [67ed8e269550] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - waiting for sched refactoring



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - some tests were failing due to a recent changes upstream
        - already fixed (unnoticed before)

    - Patchew (Davide):
        - /

    - CI (Matth):
        - virtme: being used by netdev?
        - TODO: Matth: check with Jakub want can be shared → Done
        - Matth will look at virtme-ng
        - We can check to use GH Action → In progress



Add more people as reviewers in MAINTAINERS file?:
    - We can add Geliang as Reviewer: TODO Matth → Done



Not re-transmitting packets that are lost on one path but successfully
re-injected on another path?:
    - with this, having a redundant scheduler would make sense

    - but not compliant with the MPTCPv1:
        - https://datatracker.ietf.org/doc/html/rfc8684#section-3.3.2-4
            "An MPTCP sender MUST NOT free data from the send buffer
until it has been acknowledged by both a Data ACK received on any
subflow and at the subflow level by all subflows on which the data was
sent. The former condition ensures liveness of the connection, and the
latter condition ensures liveness and self-consistence of a subflow when
data needs to be retransmitted. Note, however, that if some data needs
to be retransmitted multiple times over a subflow, there is a risk of
blocking the send window. In this case, the MPTCP sender can decide to
terminate the subflow that is behaving badly by sending a RST, using an
appropriate MP_TCPRST (Section 3.6) error code."
        - part of an extension to MPTCP?

    - But this would break middleboxes, no?:
        - e.g. ConnTrack if nf_conntrack_tcp_be_liberal is not set?
        - But maybe OK if it is optional? (e.g. if the middlebox stop
the flow, the PM could re-create the subflow)
        - Or still better to have the PM stopping and recreating the
subflow?

    - probably not even easy to do that with the current code → we would
need to "hack" TCP internal code:
        - would be messy and complex
        - so certainly no



Next meeting:
    - We will have a meeting next week but not the week after
    - Next one on Tuesday, the 19th of December.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20231220



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.
