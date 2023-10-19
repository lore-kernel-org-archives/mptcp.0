Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2907199A5
	for <mptcp@lists.linux.dev>; Thu, 19 Oct 2023 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTkuiOOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C526DC433C8
	for <mptcp@lists.linux.dev>; Thu, 19 Oct 2023 11:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697715546;
	bh=DPdvEvXtxmcL1Immr1Bo/adjqN2P0OQNiIw97innfiY=;
	h=Date:To:From:Subject:From;
	b=GTkuiOOwH2fUfV0aM3IMeOS99f9huiUFghzIJrzxb2rQaQxIHD1tLQ9+p3B1a2piO
	 adEfJSFxEsfIXDi9eBTVLcEyYdn6YXXTxzQK253XGI9+af1EFxNne8osG4Dr2S3J+O
	 boXqc0HFU4H2SKJ8A3aIxRcMDtowlwiDxE34LP4ceCHqVgO0KHbzRgHwnRG2sCRNe3
	 OBIN8QGJJpOjwX7X26IQTwW4ZoYFSYV3Y0EU+/lcq1buBqtNH8C7lLxx2TMGyUwPx4
	 r6zU9XvD2On0NUgQSiMIed9+leFPDdVDSQKwdHL2Qz1eTaCYQJ+ax6uSO4Bh8Vpbis
	 LcsNbngC2oL0Q==
Message-ID: <4dd85547-d4a9-4390-8471-863faca23fe2@kernel.org>
Date: Thu, 19 Oct 2023 13:39:03 +0200
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
Subject: [Weekly meetings] MoM - 18th of October 2023
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: Tessares
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our 259th meeting with Christoph (Apple), Mat (Cruise)
and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Paolo Abeni):

13416759: [v2,net] tcp: allow again tcp_disconnect() when threads are
waiting:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/f3b95e47e3dbed840960548aebaa8d954372db41.1697008693.git.pabeni@redhat.com/


    our repo (by: Geliang Tang, Matthieu Baerts, Paolo Abeni):

13415623: [mptcp-net,1/2] selftests: mptcp: join: correctly check for no RST
      - Submitter: Matthieu Baerts

13417558: [mptcp-net,v2] tcp: check mptcp-level constraints for backlog
coalescing:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/f1e771e52c4dce3db4884ac0e629d363d1676b75.1697037788.git.pabeni@redhat.com/

13419402: [v2,mptcp-net] mptcp: more conservative check for zero probes.:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/0ee2a306b00ef868b993e2426d9d51e14882bd72.1697125647.git.pabeni@redhat.com/

13420149: [mptcp-next,v16,1/8] mptcp: add __mptcp_subflow_disconnect helper
13420150: [mptcp-next,v16,2/8] selftests: mptcp: join: no RST when rm
subflow/addr
      - Submitter: Geliang Tang



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13415909: [net-next,1/6] tools: ynl: add uns-admin-perm to genetlink legacy
13415910: [net-next,2/6] net: mptcp: convert netlink from small_ops to ops
13415911: [net-next,3/6] Documentation: netlink: add a YAML spec for mptcp
13415912: [net-next,4/6] uapi: mptcp: use header file generated from
YAML spec
13415913: [net-next,5/6] net: mptcp: rename netlink handlers to
mptcp_pm_nl_<blah>_{doit,dumpit}
13415914: [net-next,6/6] net: mptcp: use policy generated by YAML spec:
      - Series: mptcp: convert Netlink code to use YAML spec
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=791905&state=*&archive=both


    our repo (by: Davide Caratti, Geliang Tang, Matthieu Baerts):

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
      - Status: same as the previous weeks

13294008: [iperf3] add MPTCPv1 support:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/
      - Status: same as the previous weeks

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
      - Status: same as the previous weeks

13386450: [mptcp-next,v2] ss: mptcp: print out subflows_total counter:
      - State: Awaiting upstream
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/3ca520a2ce84c33ad8f9421add0b717091173a22.1694763872.git.geliang.tang@suse.com/
      - Status: same as the previous weeks

13397525: [mptcp-next,v3,17/29] mptcp: add userspace_pm_get_entry helper
13397526: [mptcp-next,v3,18/29] mptcp: add userspace pm addr entry refcount
13397527: [mptcp-next,v3,19/29] mptcp: add netlink pm addr entry refcount:
    - Changes requested here but there are other series to fix first

13397528: [mptcp-next,v3,20/29] selftests: mptcp: add userspace pm
fullmesh tests
13397530: [mptcp-next,v3,22/29] selftests: mptcp: add mptcp_lib_evts_*
13397531: [mptcp-next,v3,23/29] selftests: mptcp: userspace: print
colored results:
    - Not clear what Geliang wants to do with them
    - *@Geliang:* just to be sure: do you still plan to work on them?

13420223: [mptcp-next,v4,1/7] selftests: mptcp: add mptcp_lib_kill_wait
13420224: [mptcp-next,v4,2/7] selftests: mptcp: add mptcp_lib_is_v6
13420225: [mptcp-next,v4,3/7] selftests: mptcp: add mptcp_lib_get_counter
13420226: [mptcp-next,v4,4/7] selftests: mptcp: add missing oflag=append
13420229: [mptcp-next,v4,5/7] selftests: mptcp: add mptcp_lib_make_file
13420230: [mptcp-next,v4,6/7] selftests: mptcp: add mptcp_lib_check_transfer
13420231: [mptcp-next,v4,7/7] selftests: mptcp: add
mptcp_lib_wait_local_port_listen:
      - State: New
      - Series: export helpers to mptcp_lib.sh
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=792889&state=*&archive=both
      - TODO: Matth: check the new version

13423370: [mptcp-next,1/5] Squash-to: "net: mptcp: convert netlink from
small_ops to ops"
13423365: [mptcp-next,2/5] Squash-to: "Documentation: netlink: add a
YAML spec for mptcp"
13423366: [mptcp-next,3/5] Squash-to: "uapi: mptcp: use header file
generated from YAML spec"
13423367: [mptcp-next,4/5] Squash to: "net: mptcp: use policy generated
by YAML spec"
13423368: [mptcp-next,5/5] tools: ynl-gen: add support for exact-len
validation:
      - State: New
      - Series: v2 fixes for "mptcp: convert Netlink code to use YAML spec"
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=793554&state=*&archive=both
      - TODO: Matth: check with Paolo as he acked the previous version
that is in our tree → Email sent

13424347: [mptcp-next,v17,1/9] selftests: mptcp: run userspace pm tests
slower
13424350: [mptcp-next,v17,2/9] selftests: mptcp: fix wait_rm_addr/sf
parameters
13424348: [mptcp-next,v17,3/9] Squash to "selftests: mptcp: userspace pm
create id 0 subflow"
13424349: [mptcp-next,v17,4/9] Squash to "mptcp: add
mptcpi_subflows_total counter"
13424351: [mptcp-next,v17,5/9] Squash to "selftests: mptcp: add
chk_subflows_total helper"
13424352: [mptcp-next,v17,6/9] selftests: mptcp: userspace pm remove
initial subflow
13424353: [mptcp-next,v17,7/9] mptcp: userspace pm send RM_ADDR for ID 0
13424354: [mptcp-next,v17,8/9] mptcp: userspace pm rename remove_err to out
13424355: [mptcp-next,v17,9/9] selftests: mptcp: userspace pm send
RM_ADDR for ID 0:
      - State: New
      - Series: userspace pm remove id 0 subflow & address
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=793778&state=*&archive=both
      - TODO: Matth: check the new version



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from the last meeting: 444):

  448  Allow sending ADD_ADDR IPv6 with port-number if TCP-timestamps
are enabled [enhancement]:
      - TCP timestamps are 12 bytes long if padded
      - ADD_ADDR IPv6 + port number is 30 bytes long → 42, too long
      - Seems risky to disable TCP Timestamps just for one packet
      - Reordering should work: first ADD_ADDR, then TCP Timestamps
      - we need to be careful that some middleboxes can be disturbed if
options are in a different order (it should not be the case but well) →
so best to do that only with this specific packet, not all MPTCP ones
      - TODO: Matth: put that in the ticket → Done

  447  syzkaller: possible deadlock in `sk_clone_lock` [bug] [syzkaller]:
      - Maybe not due to MPTCP
      - Christoph is trying with a different config

  446  MPTCP Info counters: display "last time" actions info [enhancement]:
      - maybe not needed: we need a use-case for that
      - goal is to support last_xxx like we have with TCP:
          - tcpi_last_data_sent
          - tcpi_last_data_recv
          - tcpi_last_ack_recv
      - do we need the same for MPTCP?:
          - we can get the ones for the different subflows via
MPTCP_TCP_INFO

  445  MPTCP Info counters: start seq numbers ones from 0 [bug]:
      - with the seq num, we cannot do much without TCP ones but
probably best not to expose the real value
      - maybe we can show the "relative" seq nums: substracted by the
initial number → maybe better than displaying 0


    Bugs (opened, flagged as "bug" and assigned)

  435  in-kernel PM: fullmesh: too many paths are being created [bug]
@matttbe

  379  userspace pm: ability to send `RM_ADDR` for all local IDs used (0
included) [bug] [pm] @geliangtang:
      - see patches above


    Bugs (opened and flagged as "bug" and not assigned)

  447  syzkaller: possible deadlock in `sk_clone_lock` [bug] [syzkaller]
  445  MPTCP Info counters: start seq numbers ones from 0 [bug]
  439  mptcp vs net.ipv4.tcp_shrink_window [bug]
  438  syzkaller: possible deadlock in `sk_clone_lock` [bug] [syzkaller]
  437  mptcp vs tcp performance over long fat networks [bug]
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
      - see patches above

  353  sockopt: uniform code to get/set values [enhancement] @matttbe:
      - see patches above

  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe:
      - see patches above

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang:
      - see patches above

   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang


    Assigned Questions (opened, questions and assigned)

None.


    Open questions (opened, questions and not assigned)

  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned assigned)

  448  Allow sending ADD_ADDR IPv6 with port-number if TCP-timestamps
are enabled
  446  MPTCP Info counters: display "last time" actions info [enhancement]
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


    Recently closed (since 2023-10-11)

  444  syzkaller: WARNING in `mptcp_sendmsg_frag` [bug] [syzkaller]
  420  syzkaller: WARNING in `__mptcp_move_skbs_from_subflow` [bug]
[syzkaller]



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.7):
https://github.com/orgs/multipath-tcp/projects/5
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to netdev:

    - Fixes for other trees:

        - [11c6484ec95b] rcu: kmemleak: Ignore kmemleak false positives
when RCU-freeing objects (Catalin Marinas)

    - Fixes for -net:

        - [e0dc7c68a03f] selftests: mptcp: join: correctly check for no
RST (Matthieu Baerts)
        - [15b915210a03] tcp: check mptcp-level constraints for backlog
coalescing (Paolo Abeni)
        - [3d541674fb71] mptcp: more conservative check for zero probes
(Paolo Abeni)
        - [d5a0ce635ca4] mptcp: avoid sending RST when closing the
initial subflow (Geliang Tang)
        - [07db4932b688] selftests: mptcp: join: no RST when rm
subflow/addr (Matthieu Baerts):
            - probably best to send them
            - Mat will look at sending them today

    - Fixes for net-next: /

    - Features for net-next:

        - [f8f479a4fedf] mptcp: add a new sysctl for make after break
timeout (Paolo Abeni)

        - [fd31135223df] tools: ynl: add uns-admin-perm to genetlink
legacy (Davide Caratti)
        - [d6f15d29adf4] net: mptcp: convert netlink from small_ops to
ops (Davide Caratti)
        - [4a1eb96e9247] Documentation: netlink: add a YAML spec for
mptcp (Davide Caratti)
        - [466c955192e8] uapi: mptcp: use header file generated from
YAML spec (Davide Caratti)
        - [2900cf27cb79] net: mptcp: rename netlink handlers to
mptcp_pm_nl_<blah>_{doit,dumpit} (Davide Caratti)
        - [e515e5d5c017] net: mptcp: use policy generated by YAML spec
(Davide Caratti):
            - v2 needed, there are some squash-to patches
            - TODO: Matth: check that with Paolo → Done

        - [6b45bd1315cd] mptcp: properly account fastopen data (Paolo Abeni)
        - [683023bf0fa7] mptcp: use plain bool instead of custom binary
enum (Paolo Abeni)
        - [371831949c17] tcp: define initial scaling factor value as a
macro (Paolo Abeni)
        - [87d0a3998751] mptcp: give rcvlowat some love (Paolo Abeni)
        - [51e2a881e388] mptcp: use copy_from_iter helpers on transmit
(Paolo Abeni)
        - [ea58aca7c744] mptcp: consolidate sockopt synchronization
(Paolo Abeni)
        - [d12dd8467ddd] mptcp: ignore notsent_lowat setting at the
subflow level (Paolo Abeni)
        - [a3a65a4e223b] mptcp: refactor sndbuf auto-tuning (Paolo Abeni):
            - send that next week, when patches that are queued for net
are in net-next
            - → Mat will check that

        - [2eda86769570] mptcp: drop useless ssk in
pm_subflow_check_next (Geliang Tang)
        - [c65bbb93d728] mptcp: use mptcp_check_fallback helper (Geliang
Tang)
        - [d45c40e90211] mptcp: use mptcp_get_ext helper (Geliang Tang)
        - [b01df2a6b47a] mptcp: move sk assignment statement ahead
(Geliang Tang)
        - [24e880cc9cf6] mptcp: define more local variables sk (Geliang
Tang)
        - [793486aa236a] selftests: mptcp: sockopt: drop mptcp_connect
var (Geliang Tang)
        - [64be35e105f2] selftests: mptcp: display simult in extra_msg
(Geliang Tang):
            - they should be OK but we need to check for conflicts
            - Mat will check that

        - [209ab57011d8] mptcp: add mptcpi_subflows_total counter
(Geliang Tang)
        - [bc3e93d433ab] selftests: mptcp: add evts_get_info helper
(Geliang Tang)
        - [55e4d411a6f4] selftests: mptcp: add chk_subflows_total helper
(Geliang Tang)
        - [ee397d48bcb1] selftests: mptcp: update userspace pm test
helpers (Geliang Tang)
        - [00b2498edef7] selftests: mptcp: userspace pm create id 0
subflow (Geliang Tang):
            - there are some squash-to patches
            - send that next week → Mat will check that

    - Features for net-next (next): /

    - Features for other trees:

        - [71934f0283c4] mptcp: add sched_data helpers (Geliang Tang)
        - [d178c8df48b5] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [385c32ec73d0] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [c1bf1d6a5def] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [a4c68a5e0e00] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [994d91660c17] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [8dac0f8b4578] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [138bf592967b] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [fbe82f0e4a3e] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [b7b2b63b00a6] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [3a248f2f4bba] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [d971b977f2e1] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [9ba9a86abda0] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [7883007bcb15] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [490a2d9024de] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [99d1d34f1688] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - wait: Sched API refactoring needed


Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - Some interop tests between iOS and MPTCP Upstream with v6.1:
running well
        - Having two issues: 444 and 420
        - There are fixes coming!

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - some issues with mptcp_join.sh tests but Geliang is working on
that (that are patches waiting for reviews)



Change date of the week for the meeting?
    - conflicting with netdev meetings
    - maybe it could be good for us to participate?
    - to be discussed next time when there will be more people



Meeting link:
    - We will no longer be able to use the previous link
    - Do we want to continue with Google Meet or BBB (lwn.net?) or
other? → We continue with Google Meet but a different link
    - New link: https://meet.google.com/ykz-qmys-zjh
    - Attached to Matth's kernel.org account.
    - Still opened to everybody (everybody can join)
    - People present during the last meetings will be added to the
"guest list" just to get notification by email.
    - Please contact Matthieu if you want to be added to this list.



Next meeting:
    - /!\ We cancelled the one for next week /!\

    - /!\ New event: https://meet.google.com/ykz-qmys-zjh /!\

    - /!\ UTC time will be different: 16:30, it might impact you if you
didn't switch to "daylight saving" on the 30th of October /!\

    - Next one on **Tuesday**, the 31st of October.
    - 16:30 UTC (9.30am PDT, 5.30pm CET)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20231031



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
