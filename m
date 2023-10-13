Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51012219E5
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Biy0Q97C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141C4C433C8
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 16:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697214953;
	bh=TggoQh61VkGo4Md+0G1X+LSFNcxLfI7R/8Tf1gp7au4=;
	h=Date:To:From:Subject:From;
	b=Biy0Q97CU4Cr4MVwIFEC6G8P1HEiQG0RtP5DeR6v+VCGcT5WdQiVbsKXaUvf1nVju
	 T9rR5gL8mANuju5S+kUXOYLeWAEfRKjpWlAsOpe+DV+zZwnbZ7l2QOylMKGPd1o18y
	 dqz9vu3XVZG9C29oBToOyF57fHWMyfCHAZpIh1xTTDoCfjeUJw8iETM03F0E0VLWw3
	 z1BPyELpHZvQkuRe83xYr8dMjlPFYKqnKMFEgnjl/npsDhxgldsPzDnDKBTJiNg0ne
	 BU9+pZfdPBWc0iTeycH2Y47SABaLwV/MOrWUP306tYpjVXil7iTeAbhFm8xOh4/9IM
	 A565MQiAc/3kQ==
Message-ID: <5b1b9d86-db0e-4f59-b832-d2559619891e@kernel.org>
Date: Fri, 13 Oct 2023 18:35:52 +0200
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
Subject: [Weekly meetings] MoM - 10th of October 2023
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: Tessares
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our 258th meeting with Christoph (Apple), Paolo,
Davide (Redhat) Mat (Cruise) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

13409442: [net,1/3] mptcp: fix delegated action races
13409443: [net,2/3] mptcp: userspace pm allow creating id 0 subflow
13409444: [net,3/3] MAINTAINERS: update Matthieu's email address:
      - Series: mptcp: Fixes and maintainer email update for v6.6
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=790083&state=*&archive=both


    our repo (by: Geliang Tang, Matthieu Baerts, Paolo Abeni):

13405030: [mptcp-next] Squash to "selftests: mptcp: update userspace pm
test helpers":
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/7a8234908b8198636e231d1ce6e42ab6d5864d0e.1696062626.git.geliang.tang@suse.com/

13405756: [mptcp-next,v2,1/2] tcp: define initial scaling factor value
as a macro
13405757: [mptcp-next,v2,2/2] Squash-to: "mptcp: give rcvlowat some love":
      - Series: [mptcp-next,v2,1/2] tcp: define initial scaling factor
value as a macro
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=789230&state=*&archive=both

13407740: [mptcp-net] MAINTAINERS: update Matthieu's email address:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20231003-mptcp-matt-email-v1-1-5d86d82f8c08@kernel.org/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13411643: [net-next,1/6] tools: ynl: add uns-admin-perm to genetlink legacy
13411644: [net-next,2/6] net: mptcp: convert netlink from small_ops to ops
13411645: [net-next,3/6] Documentation: netlink: add a YAML spec for mptcp
13411646: [net-next,4/6] uapi: mptcp: use header file generated from
YAML spec
13411647: [net-next,5/6] net: mptcp: rename netlink handlers to
mptcp_pm_nl_<blah>_{doit,dumpit}
13411648: [net-next,6/6] net: mptcp: use policy generated by YAML spec:
      - Series: mptcp: convert Netlink code to use YAML spec
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=790662&state=*&archive=both


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
      - Status: same as last week

13294008: [iperf3] add MPTCPv1 support:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/
      - Status: same as last week

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
      - Status: same as last week

13386450: [mptcp-next,v2] ss: mptcp: print out subflows_total counter:
      - State: Awaiting upstream
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/3ca520a2ce84c33ad8f9421add0b717091173a22.1694763872.git.geliang.tang@suse.com/
      - Status: same as last week

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
      - State: Changes requested
      - Series: userspace pm enhancements
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=787173&state=*&archive=both
      - Matth did a review, some patches are OK but not all of them. A
v4 is expected

13409093: [mptcp-net] tcp: check mptcp-level constraints for backlog
calescing:
      - State: Needs ack
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/b41dd0ae28701666ba2c59170acedaafdb41726c.1696439853.git.pabeni@redhat.com/
      - Mat will have a look at that
      - ("o" is missing in "coalescing")

13412946: [mptcp-next,v12,1/5] mptcp: avoid resetting when another
subflow available
13412947: [mptcp-next,v12,2/5] selftests: mptcp: userspace pm remove
initial subflow
13412948: [mptcp-net,v12,3/5] mptcp: userspace pm send RM_ADDR for ID 0
13412949: [mptcp-next,v12,4/5] mptcp: userspace pm rename remove_err to out
13412950: [mptcp-next,v12,5/5] selftests: mptcp: userspace pm send
RM_ADDR for ID 0:
      - State: Changes requested
      - Series: userspace pm remove id 0 subflow & address
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=791130&state=*&archive=both
      - We should not disconnect the initial subflow but only closing it
(we need to keep valid refs to msk->first) → tcp_shutdown()
      - maybe we should not have such fix in -net if it is too invasive?

13413841: [net] tcp: allow again tcp_disconnect() when threads are waiting:
      - State: Needs ack
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/1d0e4528ab057a246fd8c60b91cffd34f277b957.1696848602.git.pabeni@redhat.com/
      - Mat just sent an ACK

13415623: [mptcp-net,1/2] selftests: mptcp: join: correctly check for no RST
13415624: [mptcp-net,2/2] selftests: mptcp: join: no RST when rm
subflow/addr:
      - State: New
      - Series: selftests: mptcp: join: correctly check for no RST
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=791820&state=*&archive=both
      - The second patch is currently causing issues: it can wait, we
can apply only the first patch in -net if it is OK




Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 444):

/


    Bugs (opened, flagged as "bug" and assigned)

  435  in-kernel PM: fullmesh: too many paths are being created [bug]
@matttbe

  379  userspace pm: ability to send `RM_ADDR` for all local IDs used (0
included) [bug] [pm] @geliangtang:
      - see patches above


    Bugs (opened and flagged as "bug" and not assigned)

  444  syzkaller: WARNING in `mptcp_sendmsg_frag` [bug] [syzkaller]
  439  mptcp vs net.ipv4.tcp_shrink_window [bug]
  438  syzkaller: possible deadlock in `sk_clone_lock` [bug] [syzkaller]
  437  mptcp vs tcp performance over long fat networks [bug]

  420  syzkaller: WARNING in `__mptcp_move_skbs_from_subflow` [bug]
[syzkaller]
      - see patches above

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
[enhancement] [pm] @geliangtang
      - see patches above

  353  sockopt: uniform code to get/set values [enhancement] @matttbe
      - see patches above

  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
      - see patches above

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang
      - see patches above

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


    Recently closed (since 2023-10-03)

  443  syzkaller: divide error in `mptcp_set_rcvlowat` [bug] [syzkaller]
[reproducer]
  442  syzkaller: WARNING in `mptcp_token_destroy` [bug] [syzkaller]
[reproducer]
  417  Verifier blocks access to tcp_sock fields [bug] [sched] [bpf]
@geliangtang



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.7):
https://github.com/orgs/multipath-tcp/projects/5
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to netdev:

    - Fixes for other trees:

        - [c804d1754e6a] rcu: kmemleak: Ignore kmemleak false positives
when RCU-freeing objects (Catalin Marinas)

    - Fixes for -net: /

    - Fixes for net-next: /

    - Features for net-next:

        - [356460c3f547] mptcp: add a new sysctl for make after break
timeout (Paolo Abeni)

        - [55485fbd69b7] tools: ynl: add uns-admin-perm to genetlink
legacy (Davide Caratti)
        - [21b9c08bedc4] net: mptcp: convert netlink from small_ops to
ops (Davide Caratti)
        - [9b60179348f3] Documentation: netlink: add a YAML spec for
mptcp (Davide Caratti)
        - [a396f8ba94e2] uapi: mptcp: use header file generated from
YAML spec (Davide Caratti)
        - [e3ab41bfa170] net: mptcp: rename netlink handlers to
mptcp_pm_nl_<blah>_{doit,dumpit} (Davide Caratti)
        - [ec2f43f827d8] net: mptcp: use policy generated by YAML spec
(Davide Caratti):
            - To be re-sent to netdev ML (was sent to MPTCP list only)
            - TODO: Matth → Done

        - [afc235620b45] mptcp: properly account fastopen data (Paolo Abeni)
        - [39420c3874ec] mptcp: use plain bool instead of custom binary
enum (Paolo Abeni)
        - [da94b2b88953] tcp: define initial scaling factor value as a
macro (Paolo Abeni)
        - [29eac7e1d7c7] mptcp: give rcvlowat some love (Paolo Abeni)
        - [1247fc99def7] mptcp: use copy_from_iter helpers on transmit
(Paolo Abeni)
        - [cf7c531dbeeb] mptcp: consolidate sockopt synchronization
(Paolo Abeni)
        - [ddf2b7d0eadb] mptcp: ignore notsent_lowat setting at the
subflow level (Paolo Abeni)
        - [dc377639219e] mptcp: refactor sndbuf auto-tuning (Paolo Abeni):
            - probably best to wait for a fix for issue #444

        - [04c86b59274a] mptcp: drop useless ssk in
pm_subflow_check_next (Geliang Tang)
        - [90c560efe503] mptcp: use mptcp_check_fallback helper (Geliang
Tang)
        - [883dde712f0a] mptcp: use mptcp_get_ext helper (Geliang Tang)
        - [0720dc9469c1] mptcp: move sk assignment statement ahead
(Geliang Tang)
        - [6dc3a2012a56] mptcp: define more local variables sk (Geliang
Tang)
        - [0f0c6c33d712] selftests: mptcp: sockopt: drop mptcp_connect
var (Geliang Tang)
        - [99c95cda2603] selftests: mptcp: display simult in extra_msg
(Geliang Tang)
        - [f6239d1a0aa5] mptcp: add mptcpi_subflows_total counter
(Geliang Tang)
        - [3f1804020d8f] selftests: mptcp: add evts_get_info helper
(Geliang Tang)
        - [27aaf347dbf9] selftests: mptcp: add chk_subflows_total helper
(Geliang Tang)
        - [49b0e950413f] selftests: mptcp: update userspace pm test
helpers (Geliang Tang)
        - [b00759cbe73f] selftests: mptcp: userspace pm create id 0
subflow (Geliang Tang)

    - Features for net-next (next): /

    - Features for other trees:

        - [3f0c848e56f1] mptcp: add sched_data helpers (Geliang Tang)
        - [aa36fd8edf1e] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [cb49b48ee053] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [eade27c79d61] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [6cfa13c8e58d] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [9c73e4835af0] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [4fc06f1c7760] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [0124de3e045a] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [9c527cad4edc] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [c4c4a3031098] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [2b40ff056505] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [2e8292afbd97] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [6f374fbe31c3] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [541d66c280bc] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [118207129d58] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [7aafb241564f] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - Wait for the refactoring of the Sched API



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
        - tests 112 and 113 are regularly failing on the public CI
(debug kconfig):
            - Geliang is looking at that
            - Maybe better to revert the commit introducing the
instability and re-revert it later when it is fixed → TODO Matth, will
check next week



Other topics:
    - 6.1 failure:
        -
https://lore.kernel.org/mptcp/CA+G9fYvWCf4fYuQsVLu0NdN+=W73bW1hr1hiokajktNzPFyYtA@mail.gmail.com/T/#u
        - doesn't seem to be related to MPTCP
        - TODO: Matth: reply to make sure it is clear for everybody that
it is not due to MPTCP → Done

    - next meeting later?:
        - yes, on Wednesday

    - Google meet events have been created with a Tessares that Matthieu
will loose by the end of the year:
        - try setting up a google account with the kernel.org email
address → TODO Matth
        - Matth will send invitations to the new event

    - question on the list with 4 starlink connections:
        - the startlink connections are not supposed to be high latency
but still it is not clear what is the situation
        - it could be good to collect more info + test on the export branch
        - open a new ticket on GH?
        - interesting setup!
        - Mat will send a reply → done



Next meeting:
    - /!\ We move the one of next week from Tuesday to Wednesday /!\
    - Next one on **Wednesday**, the 18th of October.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20231018



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on **Wednesday**,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
