Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD8C219FC
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiRRmcpl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0811CC433C8
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 16:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697214950;
	bh=6KniJFp6SN4ZN0U3E0F0eDxSVR2KeabbQFe17Q1ps4U=;
	h=Date:From:Subject:To:From;
	b=YiRRmcplgrfiBn6Ftx0bXmIIg54TC8tubmjre6l+NrjfAi7HW27GNERUGV8OV5FRX
	 HSZbhVM5TmJkBa/bld1AeQ1OYd49hT3S1Y2MfPnAgxpHhTpbEEFFd0WoapKDX0wa0p
	 +359bQOqyJ/62jFvNyL0TzsYqhLO2UWgVEIvom1TvDatpozjHmSUuCcGS4lenDeP80
	 fER0RJzXkfbUw+pDeHFy0oOR1L2nMpZWf8g8ArroXKYy2ZIdEagtAJfNH7YRGiIrKU
	 ZMKEbeoDGs7Goi98NaOQ8TETduXVPaHwsQ1PAE00sE/9pxMTjL4OW+PJ8fDoDaouXg
	 MbjACkfwHWZNQ==
Message-ID: <12b4c0c8-c513-4de3-82aa-44059dc5e34e@kernel.org>
Date: Fri, 13 Oct 2023 18:35:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 3rd of October 2023
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Language: en-GB, fr-BE
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: Tessares
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last week, we had our 257th meeting with Christoph (Apple), Paolo,
Davide (Redhat) Mat (Cruise) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Davide Caratti, Geliang Tang, Paolo Abeni):

13392397: [mptcp-next,v4,1/6] tools: ynl: add uns-admin-perm to
genetlink legacy
13392398: [mptcp-next,v4,2/6] net: mptcp: convert netlink from small_ops
to ops
13392399: [mptcp-next,v4,3/6] Documentation: netlink: add a YAML spec
for mptcp
13392400: [mptcp-next,v4,4/6] uapi: mptcp: use header file generated
from YAML spec
13392401: [mptcp-next,v4,5/6] net: mptcp: rename netlink handlers to
mptcp_pm_nl_<blah>_{doit,dumpit}
13392402: [mptcp-next,v4,6/6] net: mptcp: use policy generated by YAML spec:
      - Series: mptcp: convert netlink code to use YAML spec
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=785875&state=*&archive=both

13392634: [mptcp-next,1/4] mptcp: properly account fastopen data
13392635: [mptcp-next,2/4] mptcp: use plain bool instead of custom
binary enum
13392638: [mptcp-next,3/4] mptcp: give rcvlowat some love.
13392637: [mptcp-next,4/4] mptcp: use copy_from_iter helpers on transmit..:
      - Series: mptcp: performance improvemets
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=785941&state=*&archive=both

13395175: [v5,mptcp-next,1/4] mptcp: fix delegated action races.
13395176: [v5,mptcp-next,2/4] mptcp: consolidate sockopt synchronization
13395177: [v5,mptcp-next,3/4] mptcp: ignore notsent_lowat setting at the
subflow level.
13395178: [v5,mptcp-next,4/4] mptcp: refactor sndbuf auto-tuning.:
      - Series: mptcp: misc improvement
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=786528&state=*&archive=both

13397500: [mptcp-next,v3,01/29] mptcp: drop useless ssk in
pm_subflow_check_next
13397501: [mptcp-next,v3,02/29] mptcp: use mptcp_check_fallback helper
13397502: [mptcp-next,v3,03/29] mptcp: use mptcp_get_ext helper
13397503: [mptcp-next,v3,04/29] mptcp: move sk assignment statement ahead
13397504: [mptcp-next,v3,05/29] mptcp: define more local variables sk
13397505: [mptcp-next,v3,06/29] selftests: mptcp: sockopt: drop
mptcp_connect var
13397506: [mptcp-next,v3,07/29] selftests: mptcp: display simult in
extra_msg
13397507: [mptcp-next,v3,08/29] mptcp: add mptcpi_subflows_total counter
13397508: [mptcp-next,v3,09/29] selftests: mptcp: add evts_get_info helper
13397509: [mptcp-next,v3,10/29] selftests: mptcp: add chk_subflows_total
helper
13397510: [mptcp-next,v3,11/29] selftests: mptcp: update userspace pm
test helpers
13397512: [mptcp-next,v3,13/29] mptcp: userspace pm allow creating id 0
subflow
13397513: [mptcp-next,v3,14/29] selftests: mptcp: userspace pm create id
0 subflow
      - Series: userspace pm enhancements
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=787173&state=*&archive=both
      - One part has been merged
      - 3 remaining part:
          - some patches need to be modified:no special behaviour for ID
0 - initial subflow
          - one part to add a refcount: to be reviewed
          - one part to reduce code duplication in the selftests: to be
reviewed




Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Matthieu Baerts, Paolo Abeni):

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
      - Status: same as last time

13294008: [iperf3] add MPTCPv1 support:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/
      - Status: same as last time

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
      - Status: same as last time

13386450: [mptcp-next,v2] ss: mptcp: print out subflows_total counter:
      - State: Needs ack
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/3ca520a2ce84c33ad8f9421add0b717091173a22.1694763872.git.geliang.tang@suse.com/
      - TODO: Add RvB: done

13397511: [mptcp-next,v3,12/29] selftests: mptcp: userspace pm remove id
0 subflow
13397514: [mptcp-next,v3,15/29] mptcp: userspace pm remove id 0 address
13397524: [mptcp-next,v3,16/29] selftests: mptcp: userspace pm remove id
0 address
13397525: [mptcp-next,v3,17/29] mptcp: add userspace_pm_get_entry helper
13397526: [mptcp-next,v3,18/29] mptcp: add userspace pm addr entry refcount
13397527: [mptcp-next,v3,19/29] mptcp: add netlink pm addr entry refcount
13397528: [mptcp-next,v3,20/29] selftests: mptcp: add userspace pm
fullmesh tests
13397529: [mptcp-next,v3,21/29] selftests: mptcp: add mptcp_lib_kill_wait
13397530: [mptcp-next,v3,22/29] selftests: mptcp: add mptcp_lib_evts_*
13397531: [mptcp-next,v3,23/29] selftests: mptcp: userspace: print
colored results
13397532: [mptcp-next,v3,24/29] selftests: mptcp: add
mptcp_lib_verify_listener_events
13397533: [mptcp-next,v3,25/29] selftests: mptcp: add mptcp_lib_is_v6
13397534: [mptcp-next,v3,26/29] selftests: mptcp: add mptcp_lib_get_counter
13397535: [mptcp-next,v3,27/29] selftests: mptcp: add mptcp_lib_make_file
13397536: [mptcp-next,v3,28/29] selftests: mptcp: add
mptcp_lib_check_transfer
13397537: [mptcp-next,v3,29/29] selftests: mptcp: add
mptcp_lib_wait_local_port_listen:
      - State: Under review
      - Series: userspace pm enhancements
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=787173&state=*&archive=both
      - When the initial subflow is removed, a RST is sent: not normal
      - Maybe the patches sharing code between selftests can be merged?
→ TODO: Matth: check that: not yet OK → Done

13405030: [mptcp-next] Squash to "selftests: mptcp: update userspace pm
test helpers":
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/7a8234908b8198636e231d1ce6e42ab6d5864d0e.1696062626.git.geliang.tang@suse.com/
      - TODO: Matth: to apply: Done

13405756: [mptcp-next,v2,1/2] tcp: define initial scaling factor value
as a macro
13405757: [mptcp-next,v2,2/2] Squash-to: "mptcp: give rcvlowat some love":
      - State: New
      - Series: [mptcp-next,v2,1/2] tcp: define initial scaling factor
value as a macro
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=789230&state=*&archive=both
      - define vs function: here there is no argument so it is the same,
we can use the define
      - TODO: Matth: to apply: Done

13407740: [mptcp-net] MAINTAINERS: update Matthieu's email address:
      - State: New
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20231003-mptcp-matt-email-v1-1-5d86d82f8c08@kernel.org/
      - TODO: update 0day config to use the new email address → Done
      - Example PR from Mat's change:
https://github.com/intel/lkp-tests/pull/301
      - https://github.com/intel/lkp-tests/pull/317 → Done



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 440):

  444  syzkaller: WARNING in `mptcp_sendmsg_frag` [bug] [syzkaller]:
      - happening on other instances, not rare.

  443  syzkaller: divide error in `mptcp_set_rcvlowat` [bug] [syzkaller]
[reproducer]
  442  syzkaller: WARNING in `mptcp_token_destroy` [bug] [syzkaller]
[reproducer]:
      - Already fixed by Paolo's patch, see above


    Bugs (opened, flagged as "bug" and assigned)

  435  in-kernel PM: fullmesh: too many paths are being created [bug]
@matttbe

  379  userspace pm: ability to send `RM_ADDR` for all local IDs used (0
included) [bug] [pm] @geliangtang:
      - See patches above


    Bugs (opened and flagged as "bug" and not assigned)

  444  syzkaller: WARNING in `mptcp_sendmsg_frag` [bug] [syzkaller]
  443  syzkaller: divide error in `mptcp_set_rcvlowat` [bug] [syzkaller]
[reproducer]
  442  syzkaller: WARNING in `mptcp_token_destroy` [bug] [syzkaller]
[reproducer]
  439  mptcp vs net.ipv4.tcp_shrink_window [bug]
  438  syzkaller: possible deadlock in `sk_clone_lock` [bug] [syzkaller]
  437  mptcp vs tcp performance over long fat networks [bug]
  420  syzkaller: WARNING in `__mptcp_move_skbs_from_subflow` [bug]
[syzkaller]
  416  No new subflow when removing an endpoint and adding a new one [bug]
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched]
  336  Issues with BPF packet scheduler [bug] [sched] [bpf]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose
server test` are sometimes failing [bug] [selftests]
  318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
cookies [bug] [selftests]
  315  Issues with backup flow [bug]


    In Progress (opened, new feature and assigned)

  432  Rename `mptcp_is_tcpsk()` helper [enhancement] @dcaratti
  403  userspace pm: local_addr_list: use a refcount per entry
[enhancement] [pm] @geliangtang:
      - See patches above

  353  sockopt: uniform code to get/set values [enhancement] @matttbe:
      - See patches above

  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang:
      - See patches above

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe:
      - See patches above

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang:
      - See patches above

   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang


    Assigned Questions (opened, questions and assigned)

None.


    Open questions (opened, questions and not assigned)

  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned assigned)

  441  optimize established options generation [enhancement]
  440  in-kernel PM: re-establish subflows after "network" errors
[enhancement] [pm]
  436  Supports redundant backup transmission of multiple subflows
[enhancement] [sched]
  426  selftests: validate listener sockets with multiple accepts
[enhancement] [selftests]
  425  syzkaller: validate all MPTCP Netlink API [enhancement] [syzkaller]
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


    Recently closed (since 2023-09-26)

  428  `mptcp_info`: expose if the initial subflow has been removed /
total number of subflows [enhancement] @geliangtang
  391  PM: userspace: unable to create additional subflows with the
local addr ID 0 [bug] [pm] @geliangtang



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.7):
https://github.com/orgs/multipath-tcp/projects/5
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to netdev:

    - Fixes for other trees:

        - [e78db0e3134b] workqueue: Remove duplicate worqueue attributes
allocation (Catalin Marinas)
        - [b5eb2de538da] rcu: kmemleak: Ignore kmemleak false positives
when RCU-freeing objects (Catalin Marinas):
            - handled by other trees

    - Fixes for -net:

        - [65de7bb29f6a] mptcp: fix delegated action races (Paolo Abeni)
        - [1e476db31113] mptcp: userspace pm allow creating id 0 subflow
(Geliang Tang):
            - can be sent: Mat will look at that
            - + the patch updating Matth's email address

    - Fixes for net-next: /

    - Features for net-next:

        - [0ae7708b93f1] mptcp: add a new sysctl for make after break
timeout (Paolo Abeni):

        - [d3d8ad18a7c7] tools: ynl: add uns-admin-perm to genetlink
legacy (Davide Caratti)
        - [16b0572cdb61] net: mptcp: convert netlink from small_ops to
ops (Davide Caratti)
        - [e5847b597013] Documentation: netlink: add a YAML spec for
mptcp (Davide Caratti)
        - [36019f37d83b] uapi: mptcp: use header file generated from
YAML spec (Davide Caratti)
        - [c1f2d71c1cdf] net: mptcp: rename netlink handlers to
mptcp_pm_nl_<blah>_{doit,dumpit} (Davide Caratti)
        - [c31b3ab8892a] net: mptcp: use policy generated by YAML spec
(Davide Caratti):
            - Can be sent: Matth: TODO → on Done

        - [7352672b33e8] mptcp: properly account fastopen data (Paolo Abeni)
        - [a87fc744e1de] mptcp: use plain bool instead of custom binary
enum (Paolo Abeni)
        - [8d128e047ee8] mptcp: give rcvlowat some love (Paolo Abeni):
            - there is a squash to patch

        - [cb78a857239a] mptcp: use copy_from_iter helpers on transmit
(Paolo Abeni)
        - [14a70f8802ca] mptcp: consolidate sockopt synchronization
(Paolo Abeni)
        - [402af041beed] mptcp: ignore notsent_lowat setting at the
subflow level (Paolo Abeni)
        - [a4b651bc5fbb] mptcp: refactor sndbuf auto-tuning (Paolo Abeni):
            - we can wait a bit, just to be sure there are no other
issues and to make sure #444 is not linked to that

        - [9f620b404095] mptcp: drop useless ssk in
pm_subflow_check_next (Geliang Tang)
        - [c7cb7151598d] mptcp: use mptcp_check_fallback helper (Geliang
Tang)
        - [1988b510a6d6] mptcp: use mptcp_get_ext helper (Geliang Tang)
        - [47947bfda262] mptcp: move sk assignment statement ahead
(Geliang Tang)
        - [2f8a7c3cab72] mptcp: define more local variables sk (Geliang
Tang)
        - [0ceb0812ee5c] selftests: mptcp: sockopt: drop mptcp_connect
var (Geliang Tang)
        - [435617cf67ef] selftests: mptcp: display simult in extra_msg
(Geliang Tang)
        - [df6889c5f25d] mptcp: add mptcpi_subflows_total counter
(Geliang Tang)
        - [9cb627773e54] selftests: mptcp: add evts_get_info helper
(Geliang Tang)
        - [97bce472bf2f] selftests: mptcp: add chk_subflows_total helper
(Geliang Tang)
        - [a9704dabc443] selftests: mptcp: update userspace pm test
helpers (Geliang Tang)
        - [d466f3b5d203] selftests: mptcp: userspace pm create id 0
subflow (Geliang Tang):
            - can wait a bit (at least for the other series to be applied)

    - Features for net-next (next): /

    - Features for other trees:

        - [6574d4f7e9d5] mptcp: add sched_data helpers (Geliang Tang)
        - [edbef58647f1] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [51e89fdb73af] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [09ce0e434166] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [ac977b9e0329] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [34cb996e9541] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [4c4c13b0fb55] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [acb9a5bd28df] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [20d30ecfdedb] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [8e7aac3527b8] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [0b63a0470ac8] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [e874e2d6ca47] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [ff88b78fa8ac] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [7813e9a63b22] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [1a6b822efdc3] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [e3d8177e4920] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - waiting for the scheduler API refactoring


Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - tcpdump can be used with '--immediate-mode'
        - what about upstreaming packetdrill:
            - duplicated code in the parser: should not be too difficult
to fix
            - big limitation: only one socket is supported because there
is a global mptcp status variable
            - there is maybe a packetdrill version for QUIC supporting
multiple sockets: could be interesting to see how they did that
            - + rework the core to have the code more "upstreamable"

    - Patchew (Davide):
        - still working

    - CI (Matth):
        - It looks like the new tests are unstable:
            112 - mptcp_join: userspace pm add & remove address
            113 - mptcp_join: userspace pm create destroy subflow
            → TODO Matth: check with Geliang → done: email sent



Token info exposed to any user via Netlink:
    - is TCP exposing the next expected segment? → no, they expose the
last time "something" happened: last ack, last sent/received data →
create ticket? → but wait for real use case to implement that
    - received bytes is exposed but not acked bytes → TODO: create
ticket → we already have "mptcpi_bytes_acked"
    - seq num that are exposed: might be good not to expose the real
value → do we not already store the initial seq num? → TODO: new ticket?
→ #445



Next meeting:
    - Next one on Tuesday, the 10th of October.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20231010



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
