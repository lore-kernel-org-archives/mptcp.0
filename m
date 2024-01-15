Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49CE2C68A
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxNJFSK2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDFCC433F1
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 11:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705319371;
	bh=q8kSoJXg1fJjAxoAbLxBvyUrY+nmXRZxeSipj3Dskwg=;
	h=Date:To:From:Subject:From;
	b=uxNJFSK2x9T7gHFGU9NTfgZxdSeLAWcGZYVjXWNfEXiwkNyX6W9UZvjNYBJscWLKP
	 31wEUuuKbv40l7XRSngb60sWyyx2/ye4U3tNihnbQkPXmMuSKoN5Jv1+dmCCgXudVZ
	 BPngz5NpaZuF22VE1m+XdMJlJ0jgZIf8uBYV8TDyFItYTYSAIPsETIBgbV847YYqdf
	 TOcMemzIgYR2hUHNzlTY9xhanqNu0MqLTXPJZa7i+Xzl2n76vBlAtow4jjZUBJeSDd
	 dXgZahaX8+U7wiDNpww8Uczb37Drn4j+Hr7tDcif1QmoLZcGks8KjAe7IwJbz1fKSy
	 MLOkELOLjbmLQ==
Message-ID: <14f61142-ecb4-457e-8186-0c7e0bb98ae8@kernel.org>
Date: Mon, 15 Jan 2024 12:49:29 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, fr-BE
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 10th of January 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Happy New Year 2024!

Two weeks ago, we had our 268th meeting with Mat (Cruise), Christoph
(Apple), Paolo (Red Hat) and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang):

13506752: [mptcp-next,v7,04/24] mptcp: check addrs list in
userspace_pm_get_local_id
13512667: [mptcp-next] bpf: Add mptcp_sched_ops CFI:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/9e2fbdc6e5a9c59d4b8eded4bfb2ae71a768afad.1704530434.git.geliang.tang@linux.dev/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


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
      - Status: same

13294008: [iperf3] add MPTCPv1 support:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/
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

13485156: [mptcp-next,v14,05/25] mptcp: drop lookup_by_id parameter in
lookup_addr
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
      - Status: same

13501732: [mptcp-next,v6,01/15] selftests: mptcp: add mptcp_lib_evts_*
helpers
13501733: [mptcp-next,v6,02/15] selftests: mptcp: userspace: capitalize
test_name
13501734: [mptcp-next,v6,03/15] selftests: mptcp: userspace: print
colored output
13501735: [mptcp-next,v6,04/15] selftests: mptcp: capitalize ok/fail/skip
13501736: [mptcp-next,v6,05/15] selftests: mptcp: netlink: drop
duplicate var ret
13501737: [mptcp-next,v6,06/15] selftests: mptcp: export ret into mptcp_lib
13501738: [mptcp-next,v6,07/15] selftests: mptcp: extract
mptcp_lib_check_expected
13501739: [mptcp-next,v6,08/15] selftests: mptcp: export event macros in
mptcp_lib
13501740: [mptcp-next,v6,09/15] selftests: mptcp: add
mptcp_lib_verify_listener_events
13501741: [mptcp-next,v6,10/15] selftests: mptcp: unify namespace names
13501742: [mptcp-next,v6,11/15] selftests: mptcp: add mptcp_lib_ns_* helpers
13501743: [mptcp-next,v6,12/15] selftests: mptcp: add ss mptcp support
checks
13501744: [mptcp-next,v6,13/15] selftests: mptcp: add
mptcp_lib_check_tools helper
13501745: [mptcp-next,v6,14/15] selftests: mptcp: add mptcp_lib_cleanup
helper
13501746: [mptcp-next,v6,15/15] selftests: mptcp: add
mptcp_lib_check_output helper:
      - State: Needs ack
      - Series: add helpers and vars in mptcp_lib.sh
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=812150&state=*&archive=both
      - Status: same

13516126: [mptcp-next,v8,01/23] mptcp: add mptcp_pm_parse_needs_id helper
13516128: [mptcp-next,v8,02/23] mptcp: add needs_id for userspace
appending addr
13516129: [mptcp-next,v8,03/23] mptcp: add needs_id for netlink
appending addr
13516130: [mptcp-next,v8,04/23] mptcp: map v4 address to v6 when
destroying subflow
13516131: [mptcp-next,v8,05/23] selftests: mptcp: rm subflow with
v4/v4mapped addr
13516132: [mptcp-next,v8,06/23] mptcp: export mptcp_genl_family &
mptcp_nl_fill_addr
13516133: [mptcp-next,v8,07/23] mptcp: implement
mptcp_userspace_pm_dump_addr
13516134: [mptcp-next,v8,08/23] mptcp: add token for get-addr in yaml
13516135: [mptcp-next,v8,09/23] mptcp: dump addrs in userspace pm list
13516136: [mptcp-next,v8,10/23] mptcp: check userspace pm subflow flag
13516137: [mptcp-next,v8,11/23] selftests: mptcp: add userspace pm
subflow flag
13516138: [mptcp-next,v8,12/23] selftests: mptcp: add token for dump_addr
13516139: [mptcp-next,v8,13/23] selftests: mptcp: add check_output helper
13516140: [mptcp-next,v8,14/23] selftests: mptcp: dump after creating id
0 subflow
13516141: [mptcp-next,v8,15/23] selftests: mptcp: dump userspace addrs list
13516142: [mptcp-next,v8,16/23] mptcp: add
userspace_pm_lookup_addr_by_id helper
13516143: [mptcp-next,v8,17/23] mptcp: implement mptcp_userspace_pm_get_addr
13516144: [mptcp-next,v8,18/23] mptcp: get addr in userspace pm list
13516145: [mptcp-next,v8,19/23] selftests: mptcp: add token for get_addr
13516146: [mptcp-next,v8,20/23] selftests: mptcp: userspace pm get addr
tests
13516147: [mptcp-next,v8,21/23] mptcp: update set_flags interfaces
13516148: [mptcp-next,v8,22/23] mptcp: set error messages for set_flags
13516149: [mptcp-next,v8,23/23] selftests: mptcp: flush userspace addrs
list:
      - State: New
      - Series: dump for userspace pm
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=815739&state=*&archive=both
      - The CI complained about KMemleak → Geliang will fix that in v9




Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 468):

  470  CI: execute tests with GH Actions [CI] @matttbe:
      - 'simult_flows' selftest is sometimes failing:
          - we are running the tests with QEmu without KVM
          - We could be more tolerant in this case, but maybe not the best
          - Idea from Paolo: reduce the BW, to reduce the stress on the CPU

  469  CI: add code coverage support [CI]:
      - be careful that in the doc, there are some explanations about
GCOV and code coverage for fuzzing: that's two different things.


    Bugs (opened, flagged as "bug" and assigned)

  451  syzkaller: possible deadlock in` __dev_queue_xmit` [bug]
[syzkaller] @dcaratti
  449  `MPTcpExtMPCapableFallbackACK` - looks surprising [bug] @dcaratti
  435  in-kernel PM: fullmesh: too many paths are being created [bug]
@matttbe
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  468  selftests: `mptcp_join`: 22 and 23 `backup flow used (...) link
fail` tests are unstable [bug] [selftests]:
      - it looks like it can happen:
          - the optimisations that have been done are for prod kconfig
          - with a debug kconfig, the sizes are different
          - probably there is an impact here, and we should not worry:
              - no need to ask the author of the patch found by git blame
              - we should not do a memset using offset to reset some
part of the tcp structure.
      - idea is them to modify the tests to have it pass in debug mode:
          - e.g. longer file transfer, etc.
      - TODO: Matth: report that in the ticket → done

  465  syzkaller: v6.1.60 - refcount_t: addition on 0; use-after-free
[bug] [syzkaller] [reproducer] [bisected]:
      - Christoph shared a diff
      - He found a commit that seems to be causing the issue on v6.1,
but not on master.
      - Maybe good to check with the kernel from RHEL 9.4

  463  syzkaller: INFO: task hung in `lock_sock_nested` [bug] [syzkaller]
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

  464  `TCP_NOTSENT_LOWAT` socket-option support [enhancement] @pabeni:
      - turned out to be more than expected (~15-20 patches)
      - refactoring needed
      - pre-req will be shared at some points → more testing needed

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


  469  CI: add code coverage support [CI]
  467  Scheduler: add redundant scheduler support in BPF [enhancement]
[sched]
  462  selftests: print (and set?) random seed [enhancement] [selftests]
  461  Protocol: extend Data-Level Length field [enhancement] [protocol]
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


    Recently closed (since 2024-01-03)

None.



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.9):
https://github.com/orgs/multipath-tcp/projects/7
    - For later: https://github.com/orgs/multipath-tcp/projects/1
    - changelog has been updated for v6.8
    - TODO: Matth: update links/versions for the next meeting → done



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [7f05d04b7da3] mptcp: check addrs list in
userspace_pm_get_local_id (Geliang Tang):
            - this can wait for other patches

    - Fixes for net-next: /

    - Features for net-next: /

    - Features for net-next (next): /

    - Features for other trees:

        - [59b3e6a1ac04] mptcp: add sched_data helpers (Geliang Tang)
        - [aeb5a718afc2] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [394ea910d332] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [dd55c17cf6eb] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [64b613ab6e05] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [509c750bd6ce] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [b238c2030d4d] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [173b7d944ba5] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [f29180e68dd2] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [e4ae9598ae2d] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [ff0fcf96081c] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [f556c6bebae1] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [b29859369764] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [b6aeda81e68c] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [76a6894f3dbd] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [bfe91f9f750a] selftests/bpf: Add bpf_burst test (Geliang Tang):
            → waiting for sched API refactoring



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - GH Actions running tests now:
            - We need to improve what is being displayed
            - example:
https://github.com/multipath-tcp/mptcp_net-next/actions/runs/7477479491
        - Some regressions with diag and join: TODO: Matth: check that →
done
        - between export/20240108T172308 and export/20240108T181523
        - and between export-net/20240108T110134 and
export-net/20240108T181523:
            → was due to IPRoute 6.7:

https://lore.kernel.org/netdev/20240113-ss-fix-ext-col-disabled-v1-1-cf99a7381dec@kernel.org/



Other topics:
    - Was it OK to backport this?:

https://lore.kernel.org/stable/20240103164839.340039748@linuxfoundation.org/
        - new "feature" (or a fix for bad perf? :) ) but backport
initiated by the stable team. And tests OK.
        - to an LTS so it might help for future backports
            → good this way



Next meeting:
    - Next one on *Wednesday*, the 17th of January.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240117



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
