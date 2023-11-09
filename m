Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5485922316
	for <mptcp@lists.linux.dev>; Thu,  9 Nov 2023 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ7Ojyl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAD0C433C7
	for <mptcp@lists.linux.dev>; Thu,  9 Nov 2023 16:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699548422;
	bh=807ZLvqRGHXN2yzw+A0/daoV57IkNwdC8aRnM5yQ/uM=;
	h=Date:From:Subject:To:From;
	b=UJ7Ojyl6g9GKukWzOzyaydYR+EtJqm9UHw/pbmk1F6yBM4QbZbtFCXQ+mXLpQU8OT
	 dIwerctL0NbEfZQfoJ4DPTBYoZGk0C58bpH8rS03MLU8m+5QIqbJ5qx3hf54R/DfAz
	 CXF1dImhC/2eSUt6eA+Jw3NIrSMyhqAUhp23fw5tT5iuXaazwhtS6N60dVbNZdZj/O
	 mWtpBuUJtOJAshjBjx8DyXHonKsjXijSz6SO77YOgRFHtWFRon6tafXn6n5pwxVuUi
	 8XqBCmmJk4obw1+bk3AGBfYqVAepitbD9g3q/l11FruJjGu0w7gsMZjveOVAd7EPT+
	 qvrdQ0vt/BC3Q==
Message-ID: <f46cb5b0-430f-48b7-8e4f-248351a316df@kernel.org>
Date: Thu, 9 Nov 2023 17:46:59 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 7th of November 2023
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our 261st meeting with Christoph (Apple), Paolo,
Davide (Redhat), Mat (Cruise) and myself (self-employed).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3

    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: /):

/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Jiri Olsa):

13442980: [PATCHv2,bpf-next] bpf: fix compilation error without CGROUPS:
      - Submitter: Jiri Olsa
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20231101181601.1493271-1-jolsa@kernel.org/
      - Handled by BPF maintainers


    our repo (by: Davide Caratti, Geliang Tang, Matthieu Baerts, Paolo
Abeni):

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

13397528: [mptcp-next,v3,20/29] selftests: mptcp: add userspace pm
fullmesh tests:
    - can be dropped?
    - it looks like we can

13438610: [net-next] mptcp: deal with large GSO size.:
      - State: Changes requested
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/ce93989da39fd2e47baa4506fbbf4c2049c2da13.1698416467.git.pabeni@redhat.com/
      - It might be better to take the decision on MPTCP side (for when
we will cover bigger than 64K) instead of moving that to an extension
(at a upper layer where we would check per sk, not taking into account
MPTCP specificities like support larger segments) → in preparation of a
possible MPTCPv2
      - Can be applied as it is: TODO: Matth → Done

13441631: [mptcp-next] net/mptcp: don't overwrite sock_ops in
mptcp_is_tcpsk():
      - State: Changes requested
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/a2581b975c0c5bec417b2dd5e0b014acd7770e14.1698764762.git.dcaratti@redhat.com/
      - change the helper name to make it clear we will write something
      - or remove the usage of the helper
      - maybe we can do both:
          - start with the current patch
          - then remove the usage of the helper
      → this plan sounds OK
      - but best to avoid mptcp_get_... → so v2 expected

13444521: [mptcp-net] mptcp: add validity check for sending RM_ADDR:
      - State: Queued
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/02d38d6b7a98765bf516c90541d4f2a911f428ce.1699014584.git.geliang.tang@suse.com/
      - to avoid sending a RM_ADDR for something that cannot be removed
      - maybe the commit message can be improved? But the code is OK

13446904: [mptcp-next] Squash to "selftests: mptcp: add
mptcp_lib_get_counter":
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/7cb131ce1dae4445c05b2955744c63a2d8a1c058.1699275225.git.geliang.tang@suse.com/
      - TODO: Matth: review → Done

13446958: [mptcp-net] mptcp: fix possible NULL pointer dereference on close:
      - State: Changes requested
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/3350eaf14a073538bf491f93fc852cd02ab0875a.1699280113.git.pabeni@redhat.com/
      - Paolo just sent a v2 with a better commit message, already reviewed!

13448036: [mptcp-next,v6,01/20] mptcp: export pm_nl_get_pernet_from_msk
13448037: [mptcp-next,v6,02/20] mptcp: drop mptcp_pm_get_* helpers
13448038: [mptcp-next,v6,03/20] mptcp: use pernet id_bitmap in userspace pm
13448039: [mptcp-next,v6,04/20] mptcp: add a prefix for free_local_addr_list
13448040: [mptcp-next,v6,05/20] mptcp: flush userspace pm addrs list
13448041: [mptcp-next,v6,06/20] mptcp: add
userspace_pm_lookup_addr_by_id helper
13448042: [mptcp-next,v6,07/20] mptcp: drop lookup_by_id parameter in
lookup_addr
13448043: [mptcp-next,v6,08/20] mptcp: dump userspace pm addrs
13448044: [mptcp-next,v6,09/20] mptcp: check userspace pm subflow flag
13448045: [mptcp-next,v6,10/20] selftests: mptcp: add userspace pm
subflow flag
13448046: [mptcp-next,v6,11/20] selftests: mptcp: add mptcp_lib_evts_*
helpers
13448047: [mptcp-next,v6,12/20] selftests: mptcp: flush and dump
userspace addrs list
13448048: [mptcp-next,v6,13/20] mptcp: add use_id parameter for
addresses_equal
13448049: [mptcp-next,v6,14/20] mptcp: add check_id for
lookup_anno_list_by_saddr
13448050: [mptcp-next,v6,15/20] mptcp: add userspace_pm_get_entry helper
13448051: [mptcp-next,v6,16/20] mptcp: drop addr_match and id_match
13448057: [mptcp-next,v6,17/20] mptcp: dup an entry when removing it
13448058: [mptcp-next,v6,18/20] mptcp: add userspace pm addr entry refcount
13448059: [mptcp-next,v6,19/20] selftests: mptcp: export event macros in
mptcp_lib
13448060: [mptcp-next,v6,20/20] selftests: mptcp: rm userspace addr with
random order:
13449065: [mptcp-next] Squash to "mptcp: add use_id parameter for
addresses_equal v6":
      - State: New
      - Series: userspace pm enhancements
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=799335&state=*&archive=both
      - Not clear why we need to do a flush of the address list for the
userspace PM → it should keep track of what happened
      - Maybe a "dump" command might be needed, e.g. if the userspace
daemon is restarted and lost the state.
      - TODO: Matth will have a look (but Matth is busy with admin work)



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from the last meeting: 452):

  457  `mptcp_setsockopt_v4_set_tos()`: lock needed around
`__ip_sock_set_tos()` [bug]:
      - Linked to a patch sent by Eric where Paolo noticed there is
probably a missing lock in the code that was already there

  454  syzkaller: NULL dereference in `__mptcp_propagate_sndbuf()`:
      - There is already a patch for that
      - https://syzkaller.appspot.com/bug?extid=9dfbaedb6e6baca57a32

  TODO: open a new ticket for: → Done
      - https://syzkaller.appspot.com/bug?extid=c53d4d3ddb327e80bc51
      - From Google on net-next
      - Not found by Christoph: maybe a different config? Or not
happening when using our tree?
      - Christoph will check
      - New ticket:
https://github.com/multipath-tcp/mptcp_net-next/issues/458

  453  sk_is_mptcp() only works with struct tcp_sock *:
      - Linked to the discussion on Paolo's patch (but not fixed by)
      - More an enhancement than a bug: for the moment, the situation is
OK but we could have issues thinking it is OK to use this helper on any sk.


    Bugs (opened, flagged as "bug" and assigned)

  451  syzkaller: possible deadlock in` __dev_queue_xmit` [bug]
[syzkaller] @dcaratti:
      - Not a bug in MPTCP

  450  syzkaller: WARNING in `__mptcp_move_skbs_from_subflow` [bug]
[syzkaller] [reproducer] [bisected] @pabeni
  435  in-kernel PM: fullmesh: too many paths are being created [bug]
@matttbe


    Bugs (opened and flagged as "bug" and not assigned)

  457  `mptcp_setsockopt_v4_set_tos()`: lock needed around
`__ip_sock_set_tos()` [bug]

  449  `MPTcpExtMPCapableFallbackACK` - looks surprising [bug]:
      - happening on a server with an MPTCP listen socket receiving
"plain" TCP requests

  447  syzkaller: possible deadlock in `sk_clone_lock` [bug] [syzkaller]
  445  MPTCP Info counters: start seq numbers ones from 0 [bug]
  439  mptcp vs net.ipv4.tcp_shrink_window [bug]
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

  432  Rename `mptcp_is_tcpsk()` helper [enhancement] @dcaratti:
      - see patches above

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

  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned assigned)

  454  syzkaller: NULL dereference in `__mptcp_propagate_sndbuf()`
  453  sk_is_mptcp() only works with struct tcp_sock *
  448  Allow sending ADD_ADDR IPv6 with port-number if TCP-timestamps
are enabled [enhancement]
  446  MPTCP Info counters: display "last time" actions info [enhancement]
  441  optimize established options generation [enhancement]
  440  in-kernel PM: re-establish subflows after "network" errors
[enhancement] [pm]
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


    Recently closed (since 2023-10-31)

  438  syzkaller: possible deadlock in `sk_clone_lock` [bug] [syzkaller]
  437  mptcp vs tcp performance over long fat networks [bug] @pabeni



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.8):
https://github.com/orgs/multipath-tcp/projects/6
    - For later: https://github.com/orgs/multipath-tcp/projects/1

    - ChangeLog has been updated:
https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog



Patches to send to netdev:

    - Fixes for other trees:

        - [fc52c91f74a6] bpf: fix compilation error without CGROUPS
(Matthieu Baerts):
            - patch applied in BPF tree

    - Fixes for -net: /:
        - there will be new ones that can be sent on Monday if syzbot is
happy with them
        - TODO: Matth can look at sending them on Monday

    - Fixes for net-next: /

    - Features for net-next:

        - [a47efe0d99d5] mptcp: add mptcpi_subflows_total counter
(Geliang Tang)
        - [037cc94fa2c0] selftests: mptcp: add evts_get_info helper
(Geliang Tang)
        - [1b027033a8e6] selftests: mptcp: add chk_subflows_total helper
(Geliang Tang)
        - [e7bce13b6760] selftests: mptcp: update userspace pm test
helpers (Geliang Tang)
        - [f1c00e818bc0] selftests: mptcp: userspace pm create id 0
subflow (Geliang Tang)
        - [ac18f370688b] mptcp: userspace pm rename remove_err to out
(Geliang Tang)
        - [d691e368b35c] selftests: mptcp: userspace pm remove initial
subflow (Geliang Tang)
        - [29da1a5792e4] selftests: mptcp: userspace pm send RM_ADDR for
ID 0 (Geliang Tang)
        - [e8846c1aab1c] selftests: mptcp: add mptcp_lib_kill_wait
(Geliang Tang)
        - [2a05d5676c40] selftests: mptcp: add mptcp_lib_is_v6 (Geliang
Tang)
        - [625aadee7dd1] selftests: mptcp: add mptcp_lib_get_counter
(Geliang Tang)
        - [c1a359c3a8d4] selftests: mptcp: add missing oflag=append
(Geliang Tang)
        - [3207a9728113] selftests: mptcp: add mptcp_lib_make_file
(Geliang Tang)
        - [467b5456bd93] selftests: mptcp: add mptcp_lib_check_transfer
(Geliang Tang)
        - [27f0df963e32] selftests: mptcp: add
mptcp_lib_wait_local_port_listen (Geliang Tang):
            - net-next is closed: https://patchwork.hopto.org/net-next.html

    - Features for net-next (next): /

    - Features for other trees:

        - [22424755e4d5] mptcp: add sched_data helpers (Geliang Tang)
        - [5cf8820c0b75] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [663d65afa630] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [1391fdb2eeba] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [21a92f6a1b39] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [53f1c8299deb] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [fc29cd56a907] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [5ee0617a3b70] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [2481515686e0] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [8e0aea855f33] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [8773541d00b9] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [42d545bab2a4] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [d2b9f3a09a47] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [c9acd7c985f5] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [93fc0ae440e6] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [51d72e591ca7] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - waiting for packet sched API refactorisation



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
        - /



Conflict with netdev biweekly meetings:
    - Or not for us? → could be from time to time
    - Mainly for drivers and NIC vendors
    - Change date? → yes, Wednesday (starting in 2 weeks)



Meetings:
    - extend by 30 min to avoid ending too soon? Not possible
    - Matth will find something for that → Done (will try next week)



Backport to stable:
    -
https://lore.kernel.org/netdev/20231025-send-net-next-20231025-v1-3-db8f25f798eb@kernel.org/
    - Matth sent an email:
https://lore.kernel.org/stable/a7a3675a-4531-4559-bea2-c7689317764a@kernel.org/



PGP key signing:
    - Matth is switching to the UUID with his @kernel.org address by default
    - But this key is not signed by other kernel devs
    - Anybody is OK to sign it? :)
        - Mat is → Done
    - Fingerprint: E8CB 85F7 6877 057A 6E27  F77A F6B7 824F 4269 A073



Next meeting:
    - Next one on *Tuesday*, the 14th of November.
    - (The ones *after* this one will be on Wednesday)
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20231114



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
