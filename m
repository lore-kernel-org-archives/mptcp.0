Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC1315D5DB
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789452; cv=none; b=n0gTZJobJrEi3EwVQ0gTo1V6784Ulu5Z9nGaCVRzuIZBAHbWblxvmWneg7IhI9nl5k8H3riyNxfEjm+dVZ2487hjr1cmwoPv2mO78dxAL1XUOiuaqlWNTntYYE6YrKBw94K+uzdNA2URXnBV6Vh9l1RyQSMB/khsrD9hEhc67Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789452; c=relaxed/simple;
	bh=euu2HA9KfxS4SVHRa+QzEzXk0zBcRqXs+JFR9PQ6vUw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ueOQyKV3Di/cBWX2fmbJX1DQXG1J6qS4kWUZEX6mMPx8pPJadJZErVgPg5/aIK0j6JzZyoIVMtL4aq6imCEgOfrOsYguGcsI9AZKcRNQQohBpE1GxsciJhYrtp8aBkmPq1mB7I7MIQsWkhn2a57smVFwsGrGSLQ5hgMeaUQHASg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIwL5PQG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIwL5PQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296E4C433C7
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 12:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706789451;
	bh=euu2HA9KfxS4SVHRa+QzEzXk0zBcRqXs+JFR9PQ6vUw=;
	h=Date:To:From:Subject:From;
	b=nIwL5PQGGl4pMduFOdGai+9nmYnk8P0bdN/ToGFGZJsSoMhEkCA/s2b0Kk2BGRPWb
	 3rNOMwTjQQxZPyugq7ShIXQCQnB+3fKXS5QK9O01WefMvA6E8khQ3ezV/SVezGuq9+
	 pe3tS3acypv50qbaKCXeLbCnONgMOeCl0+eVJsv8cNu1Fa9Ri5Y5C++JlJMhFqSj3r
	 D0q7Z5tBQfPGOZBPQRozkdQ69RNAQQcfrFiEpjnfRNP+ZB4eOy3HHBel7jaRL4Uqwi
	 kEfpzy91zNPYZaOpe+hbGTlcR9o+U5XgBqFx2QKtL+rKZWO4cLeAtk0y5Vyy3IGJ2y
	 OptCf+YAIxWrw==
Message-ID: <30c3dde6-25eb-4e25-8179-db4353e8b278@kernel.org>
Date: Thu, 1 Feb 2024 13:10:48 +0100
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
Subject: [Weekly meetings] MoM - 31st of January 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our 270th meeting with Mat (Cruise), Paolo, Davide
(Red Hat) and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:

    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Matthieu Baerts (NGI0), Paolo Abeni):

13521002: [mptcp-next,1/5] mptcp: annotate access for msk keys
13521003: [mptcp-next,2/5] mptcp: annotate lockless access for the tx path
13521004: [mptcp-next,3/5] mptcp: annotate lockless access for RX path
fields.
13521005: [mptcp-next,4/5] mptcp: annotate lockless access for token
13521006: [mptcp-next,5/5] mptcp: annotate lockless accesses around
read-mostly fields:
      - Series: mptcp: annotate lockless access
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=817295&state=*&archive=both

13523090: [mptcp-next,1/7] selftests: mptcp: add missing kconfig for NF
Filter
13523091: [mptcp-next,2/7] selftests: mptcp: add missing kconfig for NF
Filter in v6
13523092: [mptcp-next,3/7] selftests: mptcp: add missing kconfig for NF
Mangle
13523093: [mptcp-next,4/7] selftests: mptcp: increase timeout to 30 min
13523094: [mptcp-next,5/7] selftests: mptcp: decrease BW in simult flows
13523095: [mptcp-next,6/7] selftests: mptcp: allow changing subtests prefix
13523096: [mptcp-next,7/7] selftests: mptcp: join: stop transfer when
check is done:
      - Series: selftests: mptcp: improve results in slow CI envs
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=817906&state=*&archive=both

13528135: [mptcp-net] mptcp: fix data re-injection from stale subflow:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/35875ef9cb7194563b580e14c71cc8cb065f846c.1706043786.git.pabeni@redhat.com/

13529718: [mptcp-net] mptcp: really cope with fastopen race.:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/02fe7afaec6fac65fc2da5922efe25d6ebdebc88.1706132185.git.pabeni@redhat.com/

13534379: [virtme-docker,1/3] change watchdog to device
13534380: [virtme-docker,2/3] upgrade to ubuntu 23.10:
      - Switch to Ubuntu 23.10 for "mptcp-upstream-virtme-docker" used
by the CI
      - if you use it locally, you might need to clean the build dir:

https://github.com/multipath-tcp/mptcp-upstream-virtme-docker?tab=readme-ov-file#compilation-issues-with-perf-or-objtools

13537119: [bpf-next,v17,11/14] bpf, net: switch to dynamic registration
13539472: [mptcp-next] mptcp: bpf: fix compilation error without BPF_JIT:
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240131134421.1045648-2-matttbe@kernel.org/
      - needed because of some changes upstream (BPF)



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Paolo Abeni):

13528961: [mptcp-stable] mptcp: introduce explicit flag for first
subflow disposal:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/a1503ab571c8c076de62b872437d220a2260d2a5.1706094997.git.pabeni@redhat.com/
      - Christoph sent it to the stable team:
          - Hopefully they will pick it, even if [v6.1] is missing in
the subject


    our repo (by: Geliang Tang, Matthieu Baerts, Matthieu Baerts (NGI0),
Paolo Abeni):

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
      - status: same as before

13294008: [iperf3] add MPTCPv1 support:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/
      - status: same as before

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
      - status: same as before

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
      - status: same as before: Matth will look

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
      - status: same as before: Matth will look

13522386: [mptcp-next,v10,01/23] mptcp: add pm_has_addr_attr_id helper
13522387: [mptcp-next,v10,02/23] mptcp: add needs_id for userspace
appending addr
13522388: [mptcp-next,v10,03/23] mptcp: add needs_id for netlink
appending addr
13522389: [mptcp-next,v10,04/23] mptcp: map v4 address to v6 when
destroying subflow
13522390: [mptcp-next,v10,05/23] selftests: mptcp: rm subflow with
v4/v4mapped addr
13522391: [mptcp-next,v10,06/23] mptcp: export mptcp_genl_family &
mptcp_nl_fill_addr
13522392: [mptcp-next,v10,07/23] mptcp: implement
mptcp_userspace_pm_dump_addr
13522393: [mptcp-next,v10,08/23] mptcp: add token for get-addr in yaml
13522394: [mptcp-next,v10,09/23] mptcp: dump addrs in userspace pm list
13522395: [mptcp-next,v10,10/23] mptcp: check userspace pm subflow flag
13522396: [mptcp-next,v10,11/23] selftests: mptcp: add userspace pm
subflow flag
13522397: [mptcp-next,v10,12/23] selftests: mptcp: add token for dump_addr
13522398: [mptcp-next,v10,13/23] selftests: mptcp: add check_output helper
13522399: [mptcp-next,v10,14/23] selftests: mptcp: dump after creating
id 0 subflow
13522400: [mptcp-next,v10,15/23] selftests: mptcp: dump userspace addrs list
13522401: [mptcp-next,v10,16/23] mptcp: add
userspace_pm_lookup_addr_by_id helper
13522402: [mptcp-next,v10,17/23] mptcp: implement
mptcp_userspace_pm_get_addr
13522403: [mptcp-next,v10,18/23] mptcp: get addr in userspace pm list
13522404: [mptcp-next,v10,19/23] selftests: mptcp: add token for get_addr
13522405: [mptcp-next,v10,20/23] selftests: mptcp: userspace pm get addr
tests
13522406: [mptcp-next,v10,21/23] mptcp: update set_flags interfaces
13522407: [mptcp-next,v10,22/23] mptcp: set error messages for set_flags
13522408: [mptcp-next,v10,23/23] selftests: mptcp: flush userspace addrs
list:
      - State: Changes requested
      - Series: dump for userspace pm
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=817723&state=*&archive=both
      - Mat reviewed it, some changes needed
      - do we need to init the id of the first entry? (0) Maybe not needed.

13525637: [mptcp-next,1/7] mptcp: push ad DSS boundaries
13525635: [mptcp-next,2/7] mptcp: fix snd_wnd initialization for passive
socket
13525638: [mptcp-next,3/7] mptcp: fix potential wake-up event loss
13525639: [mptcp-next,4/7] mptcp: cleanup writer wake-up
13525640: [mptcp-next,5/7] mptcp: avoid some duplicate code in socket
option handling
13525641: [mptcp-next,6/7] mptcp: implement TCP_NOTSENT_LOWAT support.
13525642: [mptcp-next,7/7] mptcp: cleanup SOL_TCP handling:
      - State: New
      - Series: mptcp: implement TCP_NOTSENT_LOWAT support
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=818661&state=*&archive=both
      - it looks like it is fine not to have an fully accurate way to
track snd_nxt:
          - it is then not needed to do a heavy refactoring
          - some patches from this series improve the accuracy
      - the 3 first patches are for -net.

13534817: [virtme-docker,v2] tests: add bpftests support:
      - State: Under review
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/52e66b47f434090528dfbadd99b8098fbaace8ae.1706493739.git.tanggeliang@kylinos.cn/
      - Matth is looking at including this: TODO

13539551: [mptcp-next,1/3] mptcp: token kunit: set protocol
13539552: [mptcp-next,2/3] tcp: check the protocol with DEBUG_NET
13539553: [mptcp-next,3/3] mptcp: check the protocol with DEBUG_NET:
      - State: New
      - Series: mptcp: check the protocol with DEBUG_NET
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=821749&state=*&archive=both
      - idea:
          - squash patches 2 and 3
          - only use macro (with 2 statements)
          - ok with WARN_ON (no ONCE)
          - the modificaiton of tcp_sk() is specific to MPTCP, we can then:
              - do an undef of tcp_sk and re-define it in protocol.h
      - TODO: Matth will send a v2



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 471):

  472  CI: switch to virtme-ng [enhancement] [CI] @matttbe:
      - virtme is not longer maintained, we had to patch it
      - virtme-ng should be faster for different reasons
      - used by netdev CI and Paolo


    Bugs (opened, flagged as "bug" and assigned)

  451  syzkaller: possible deadlock in` __dev_queue_xmit` [bug]
[syzkaller] @dcaratti
  449  `MPTcpExtMPCapableFallbackACK` - looks surprising [bug] @dcaratti
  435  in-kernel PM: fullmesh: too many paths are being created [bug]
@matttbe
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  465  syzkaller: v6.1.60 - refcount_t: addition on 0; use-after-free
[bug] [syzkaller] [reproducer] [bisected]:
      - TODO: Matth: close this one: Done

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

  472  CI: switch to virtme-ng [enhancement] [CI] @matttbe
  464  `TCP_NOTSENT_LOWAT` socket-option support [enhancement] @pabeni
  406  Compile and run mptcp bpf selftests in CI [enhancement]
[selftests] [bpf] [CI] @geliangtang
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


    Recently closed (since 20240117)

  471  Crash in `netif_rx_internal` [bug] [wontfix] [selftests]
  468  selftests: `mptcp_join`: 22 and 23 `backup flow used (...) link
fail` tests are unstable [bug] [selftests]



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.9):
https://github.com/orgs/multipath-tcp/projects/7
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to netdev:

    - Fixes for other trees:

        - [cad574384645] x86: Fixup from the removed INT3 if it is
unhandled (Masami Hiramatsu):
            - CI now running with QEmu >6, no longer needed
            - TODO: remove it and report the issue to Ubuntu bug tracker

    - Fixes for -net:

        - [c259beb9ce80] mptcp: check addrs list in
userspace_pm_get_local_id (Geliang Tang):
            - ready

        - [860905e8bb6b] mptcp: drop the push_pending field (Paolo Abeni)
        - [615f5bae115d] mptcp: fix rcv space initialization (Paolo Abeni)
        - [248204e64aa5] mptcp: fix more tx path fields initialization
(Paolo Abeni)
        - [4401bbb2926a] mptcp: corner case locking for rx path fields
initialization (Paolo Abeni)
        - [517ac720ea5d] mptcp: really cope with fastopen race (Paolo
Abeni):
            - can wait a bit because the ones below fixes issues
reported by CI

        - [b233458c6cc5] selftests: mptcp: add missing kconfig for NF
Filter (Matthieu Baerts (NGI0))
        - [8a681334326c] selftests: mptcp: add missing kconfig for NF
Filter in v6 (Matthieu Baerts (NGI0))
        - [3254d949f5b3] selftests: mptcp: add missing kconfig for NF
Mangle (Matthieu Baerts (NGI0))
        - [2e0154117a4e] selftests: mptcp: increase timeout to 30 min
(Matthieu Baerts (NGI0))
        - [7ae689688a0e] selftests: mptcp: decrease BW in simult flows
(Matthieu Baerts (NGI0))
        - [29237b01db64] selftests: mptcp: allow changing subtests
prefix (Matthieu Baerts (NGI0))
        - [00241a36caef] selftests: mptcp: join: stop transfer when
check is done (Matthieu Baerts (NGI0))
        - [f7007fe3ac22] mptcp: fix data re-injection from stale subflow
(Paolo Abeni):
            - can be sent: fixing issues seen by the CI

    - Fixes for net-next: /

    - Features for net-next:

        - [d4ea57ebecaa] mptcp: annotate access for msk keys (Paolo Abeni)
        - [6cb7a4d460de] mptcp: annotate lockless access for the tx path
(Paolo Abeni)
        - [3fe372958e65] mptcp: annotate lockless access for RX path
fields (Paolo Abeni)
        - [1c8852f1da58] mptcp: annotate lockless access for token
(Paolo Abeni)
        - [485ac3c4e7ef] mptcp: annotate lockless accesses around
read-mostly fields (Paolo Abeni):
            - Matth can send them on Friday if there is no conflicts
with -net → TODO (scheduled)
            - or Mat on Monday

    - Features for net-next (next): /

    - Features for other trees:

        - [89defe95ddf4] mptcp: add sched_data helpers (Geliang Tang)
        - [d20efef2c839] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [3399dc11c5a7] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [08f2d4534825] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [8aeaba1247a7] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [5dd3e2f9140b] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [c0fa216b6433] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [e6580435eb41] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [6dbf78154bd7] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [99b09afd49a4] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [1f0164995023] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [61177b3d87ad] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [5149adb147c3] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [74346d9d53ac] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [eee4ff9bf4ad] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [5caaf9d59154] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - status: same as last time: waiting for sched refactoring



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
        - The tests being on GH (GitHub Actions, with QEmu, without KVM)
often have failures with packetdrill, not the same test but similar error:
            - timing error: expected system call return at 2.628674 sec
but happened at 3.514103 sec; tolerance 0.400000 sec
            - packet for another subflow → retransmission?
            - runtime error in write call: Expected result -1 but got 1
with errno 2 (No such file or directory)
            → likely because the environment is too slow...

        - probably best to run all tests on a self hosted runner? → new
ticket

        - Cirrus:
            - we reached the monthly limit today (31/1):
            - but we are at the end of the month
            - or maybe it looks at how we used it the last 30 days? (but
strange because it shows the usage per month)
            - will check tomorrow if the limit has been reached or not
(seems OK)


Next meeting:
    - Next one on *Wednesday*, the 7th of February.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240207



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.
