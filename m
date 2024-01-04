Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A84D28E1B
	for <mptcp@lists.linux.dev>; Thu,  4 Jan 2024 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIQzmcll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C35AC433C7
	for <mptcp@lists.linux.dev>; Thu,  4 Jan 2024 18:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704394297;
	bh=SXXu6QOetonI4eU7kS6EPZBqXXWuxOyLrg63yaXL6Vk=;
	h=Date:To:From:Subject:From;
	b=QIQzmcllAMfMPCi7tmWEd6xa1XJphxDiplyHckmFn+PDc979Md9qkQpN/ZUX+ssUC
	 GIkIUj2y+x9bOOjm9mv9tvQWDtKjkiHs4defdAxcNANN6UVqLu4XXfBCqRohdBHZBq
	 e6SneS52iFjhYgLL1go8ZIlwGIQYHjfDwCT8ZRqZGRcRr0JE1abc4K25gPFVzFNrvI
	 tr3A+ZiyACMWwOFhVZhMA+UY8gKoeJkMfucPyMxS9qz1j6/zf1JYJW6ANSbpN9ToyM
	 +W6D4mGTDxIXVEQYqXDufucwxC+om29WvUREkk92R42F/nywHZlYvshWA4DmwyHpLC
	 MOFe3nWqijipg==
Message-ID: <2fa13613-6900-40e7-9917-3d8c75e8ae69@kernel.org>
Date: Thu, 4 Jan 2024 19:51:35 +0100
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
Subject: [Weekly meetings] MoM - 3rd of January 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Happy New Year 2024!

Two weeks ago, we had our 267th meeting with Mat (Cruise) and myself
(NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Ido Schimmel, Matthieu Baerts):

13499146: [net-next,1/4] mptcp: don't overwrite sock_ops in mptcp_is_tcpsk()
13499147: [net-next,2/4] mptcp: rename
mptcp_setsockopt_sol_ip_set_transparent()
13499148: [net-next,3/4] mptcp: sockopt: support IP_LOCAL_PORT_RANGE and
IP_BIND_ADDRESS_NO_PORT
13499149: [net-next,4/4] selftests/net: add MPTCP coverage for
IP_LOCAL_PORT_RANGE:
      - Series: mptcp: cleanup and support more ephemeral ports sockopts
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=811573&state=*&archive=both

13500281: [net-next,v2] genetlink: Use internal flags for multicast groups:
      - Submitter: Ido Schimmel
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20231220154358.2063280-1-idosch@nvidia.com/
      - modifying MPTCP as part of a batch

13503316: [net-next,1/4] mptcp: add CurrEstab MIB counter support
13503317: [net-next,2/4] mptcp: use mptcp_set_state
13503318: [net-next,3/4] selftests: mptcp: join: check CURRESTAB counters
13503319: [net-next,4/4] selftests: mptcp: diag: check CURRESTAB counters:
      - Series: mptcp: add CurrEstab MIB counter
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=812489&state=*&archive=both

13504881: [net,1/2] MAINTAINERS: add Geliang as reviewer for MPTCP
13504882: [net,2/2] mptcp: prevent tcp diag from closing listener subflows:
      - Series: mptcp: new reviewer and prevent a warning
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=812891&state=*&archive=both


    our repo (by: Geliang Tang, Paolo Abeni):

13494142: [mptcp-net] mptcp: prevent tcp diag from closing listener
subflows:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/f6371f65b1ebabc0f308528494ec39c9bdf786fd.1702631517.git.pabeni@redhat.com/

13499455: [mptcp-next,v3,1/2] Squash to "mptcp: use mptcp_set_state"
13499456: [mptcp-next,v3,2/2] selftests: mptcp: diag: check CURRESTAB
counters:
      - Series: fixes for CURRESTAB
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=811634&state=*&archive=both



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
      - Refcount part:
          - The Userspace PM can be responsible for the ID it picks for
the RM_ADDR
          → if it has not been announced before, that's its fault and
that's not forbidden.
          - Or do we need to keep a ref of the addresses that have been
announced for other reasons?
          - Matth will recheck that

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
      - State: New
      - Series: add helpers and vars in mptcp_lib.sh
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=812150&state=*&archive=both
      - To be reviewed, Matth will look at that

13506749: [mptcp-next,v7,01/24] mptcp: set set_id flag when parsing addr
13506753: [mptcp-next,v7,02/24] mptcp: parse userspace pm entry to get flags
13506751: [mptcp-next,v7,03/24] mptcp: test set_id flag when appending addr
13506752: [mptcp-next,v7,04/24] mptcp: check addrs list in
userspace_pm_get_local_id
13506755: [mptcp-next,v7,05/24] mptcp: map v4 address to v6 when
destroying subflow
13506754: [mptcp-next,v7,06/24] selftests: mptcp: rm subflow with
v4/v4mapped addr
13506756: [mptcp-next,v7,07/24] mptcp: export mptcp_genl_family &
mptcp_nl_fill_addr
13506757: [mptcp-next,v7,08/24] mptcp: implement
mptcp_userspace_pm_dump_addr
13506758: [mptcp-next,v7,09/24] mptcp: add token for get-addr in yaml
13506759: [mptcp-next,v7,10/24] mptcp: dump addrs in userspace pm list
13506760: [mptcp-next,v7,11/24] mptcp: check userspace pm subflow flag
13506761: [mptcp-next,v7,12/24] selftests: mptcp: add userspace pm
subflow flag
13506762: [mptcp-next,v7,13/24] selftests: mptcp: add token for dump_addr
13506763: [mptcp-next,v7,14/24] selftests: mptcp: add check_output helper
13506764: [mptcp-next,v7,15/24] selftests: mptcp: dump after creating id
0 subflow
13506765: [mptcp-next,v7,16/24] selftests: mptcp: dump userspace addrs list
13506766: [mptcp-next,v7,17/24] mptcp: add
userspace_pm_lookup_addr_by_id helper
13506767: [mptcp-next,v7,18/24] mptcp: implement mptcp_userspace_pm_get_addr
13506768: [mptcp-next,v7,19/24] mptcp: get addr in userspace pm list
13506769: [mptcp-next,v7,20/24] selftests: mptcp: add token for get_addr
13506770: [mptcp-next,v7,21/24] selftests: mptcp: userspace pm get addr
tests
13506771: [mptcp-next,v7,22/24] mptcp: update set_flags interfaces
13506772: [mptcp-next,v7,23/24] mptcp: set error messages for set_flags
13506773: [mptcp-next,v7,24/24] selftests: mptcp: flush userspace addrs
list:
      - State: New
      - Series: dump for userspace pm
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=813407&state=*&archive=both
      - Patches 1-6 are fixes for -net
      - To be reviewed, Mat will look at that



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 468):

/

    Bugs (opened, flagged as "bug" and assigned)

  451  syzkaller: possible deadlock in` __dev_queue_xmit` [bug]
[syzkaller] @dcaratti:
      - can be closed?

  449  `MPTcpExtMPCapableFallbackACK` - looks surprising [bug] @dcaratti
  435  in-kernel PM: fullmesh: too many paths are being created [bug]
@matttbe
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  468  selftests: `mptcp_join`: 22 and 23 `backup flow used (...) link
fail` tests are unstable [bug] [selftests]:
      - quite surprising: most of the modifications should be beneficial
for MPTCP (fields that we used have been moved)
      - quite easy to reproduce
      - maybe we do a memset of a part of this structure?
      - maybe good to check with pahole if there were no big changes?

  465  syzkaller: v6.1.60 - refcount_t: addition on 0; use-after-free
[bug] [syzkaller] [reproducer] [bisected]
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

  464  `TCP_NOTSENT_LOWAT` socket-option support [enhancement] @pabeni
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


    Recently closed (since 2023-12-19)

None.



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.8):
https://github.com/orgs/multipath-tcp/projects/6
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [0e0a24a5dafb] MAINTAINERS: add Geliang as reviewer for MPTCP
(Matthieu Baerts)
        - [409d45090e51] mptcp: prevent tcp diag from closing listener
subflows (Paolo Abeni):
            - already sent and applied in -net

    - Fixes for net-next:

        - [bb9120cf7689] net/sched: We should only add appropriate
qdiscs blocks to ports' xarray (Victor Nogueira):
            - a v3 is expected but this patch is needed to fix the tests
            - TODO: Matth: monitor this and replace the v2 by the v3
when available

    - Features for net-next:

        - [888678376baf] mptcp: add MPTCP_MIB_CURRESTAB counter (Geliang
Tang)
        - [9795df647c9a] mptcp: use mptcp_set_state (Geliang Tang)
        - [92e2e8dfa4ce] selftests: mptcp: join: check CURRESTAB
counters (Geliang Tang)
        - [85773ea75567] selftests: mptcp: diag: check CURRESTAB
counters (Geliang Tang):
            - already sent and applied in net-next

    - Features for net-next (next): /

    - Features for other trees:

        - [23a931534793] mptcp: add sched_data helpers (Geliang Tang)
        - [d2ebf032c7c4] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [12d9859d6488] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [92cb44dc121a] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [6342d39477ec] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [dee1a9df0710] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [3d99dffc38be] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [619fc4713e80] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [3f72553257b8] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [0ef0aa3a5797] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [222a0ff477c6] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [2b3924d9d531] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [cb2efcfd33e7] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [246c96fded75] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [cec5c47019fb] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [bf0dba6c0bec] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - same as last time: waiting for a refactoring




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
        - code coverage:
            - could be good to put that in place, seems easy to do
            - TODO: Matth: open a new ticket → Done


GH Actions:
    - https://github.com/matttbe/mptcp_net-next/actions/runs/7308958948 :
        - Without the debug kconfig: quite OK, except simult_flows:
            - maybe we can add more "slack" if in a VM but KVM is not
enabled?
        - With debug: not OK (see below):
            - only run "normal" mode on GH Actions?:
                OK → TODO: Matth: change that
            - when/where to run the "debug" mode?
            - should be OK to run only the "debug" mode on cirrus-ci:
                OK → TODO: Matth: change that
            - TuxSuite was (still is?) not using KVM:
                - so not OK to use a debug kernel either?
        - Idea: use local machine as a "GH Actions self hosted runner"?:
            - Matth could run that: TODO
            - but a git cache will be needed not to re-clone everything
from scratch all the time.
        - We should publish the results somewhere to be able to track
regressions:
            - check KCIDB: TODO: Matth

FYI, GH Actions debug kconfig tests results:
    - ok 1 test: kunit.tap

    - ok 1 test: packetdrill_add_addr.tap
    - ok 1 test: packetdrill_dss.tap
    - ok 1 test: packetdrill_fastclose.tap
    - ok 1 test: packetdrill_fastopen.tap
    - ok 1 test: packetdrill_mp_capable.tap
    - not ok 1 test: packetdrill_mp_join.tap # exit=1
    - ok 1 test: packetdrill_mp_prio.tap
    - ok 1 test: packetdrill_mp_reset.tap
    - not ok 1 test: packetdrill_regressions.tap # exit=1
    - not ok 1 test: packetdrill_sockopts.tap # exit=1
    - ok 1 test: packetdrill_syscalls.tap

    - not ok 1 test: selftest_diag.tap # exit=20
        - not ok 18 - diag: many msk socket present # timeout
        - not ok 19 - diag: ....chk many msk in use
        - not ok 20 - diag: ....chk 200 cestab

    - ok 1 test: mptcp_connect_mmap.tap
    - ok 1 test: selftest_mptcp_connect.tap

    - not ok 1 test: selftest_mptcp_join.tap # exit=1
        - not ok 29 - mptcp_join: remove multiple subflows
        - not ok 31 - mptcp_join: remove subflow and signal
        - not ok 33 - mptcp_join: remove addresses
        - not ok 50 - mptcp_join: remove subflow and signal IPv6
        - not ok 65 - mptcp_join: single address, backup
        - not ok 74 - mptcp_join: remove subflow and signal with port
        - not ok 75 - mptcp_join: flush subflows and signal with port
        - not ok 98 - mptcp_join: set fullmesh flag test
        - not ok 99 - mptcp_join: set nofullmesh flag test
        - not ok 100 - mptcp_join: set backup,fullmesh flags test
        - not ok 112 - mptcp_join: userspace pm add & remove address
        - not ok 113 - mptcp_join: userspace pm create destroy subflow
        - not ok 114 - mptcp_join: userspace pm create id 0 subflow
        - not ok 115 - mptcp_join: userspace pm remove initial subflow
        - not ok 116 - mptcp_join: userspace pm send RM_ADDR for ID 0
        - not ok 117 - mptcp_join: implicit EP
        - not ok 118 - mptcp_join: delete and re-add

    - ok 1 test: selftest_mptcp_sockopt.tap

    - ok 1 test: selftest_pm_netlink.tap

    - not ok 1 test: selftest_simult_flows.tap # exit=1
        - not ok 1 - simult_flows: balanced bwidth
        - not ok 2 - simult_flows: balanced bwidth
        - not ok 3 - simult_flows: balanced bwidth with unbalanced delay
        - not ok 4 - simult_flows: balanced bwidth with unbalanced delay
        - not ok 5 - simult_flows: unbalanced bwidth
        - not ok 6 - simult_flows: unbalanced bwidth
        - not ok 7 - simult_flows: unbalanced bwidth with unbalanced delay
        - not ok 8 - simult_flows: unbalanced bwidth with unbalanced delay
        - not ok 9 - simult_flows: unbalanced bwidth with opposed,
unbalanced delay
        - not ok 10 - simult_flows: unbalanced bwidth with opposed,
unbalanced delay

    - not ok 1 test: selftest_userspace_pm.tap # exit=1
        - not ok 31 - userspace_pm: ADD_ADDR4 id:78 10.0.2.1 (ns1) =>
ns2, reuse port
        - not ok 32 - userspace_pm: CREATE_SUBFLOW 10.0.2.2 (ns2) =>
10.0.2.1 (ns1)
        - not ok 33 - userspace_pm: DESTROY_SUBFLOW 10.0.2.2 (ns2) =>
10.0.2.1 (ns1)
        - not ok 34 - userspace_pm: MP_PRIO TX
        - not ok 35 - userspace_pm: MP_PRIO RX



Next meeting:
    - Next one on *Wednesday*, the 10th of January.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240110



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.
