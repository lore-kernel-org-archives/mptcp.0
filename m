Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E8A747D
	for <mptcp@lists.linux.dev>; Thu, 28 Dec 2023 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTWOH9LZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7814C433C8
	for <mptcp@lists.linux.dev>; Thu, 28 Dec 2023 12:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703767366;
	bh=3GX+XjMUdEVafo1nORUrvIUJt+2Z6WPEyd815s1GynM=;
	h=Date:To:From:Subject:From;
	b=pTWOH9LZC2Pad2JHx4y4QGQPWtpG2fZOyEJQ2BraYLKrEu6RjgqhHRVa9Cp+YGCzK
	 TiohKS+LgvyZL0m0O0Ycs+Hz+WMDXmWsXOJhiOCoe2WqPE8oobXrj68NkEj6Sc9Mqh
	 OuqxsUDfF3mCAYJFs/jWQn7QSMGk9/HJKzqbE5sx8MQ4EuANGNWz/9342yhGceOjv5
	 ExRQ5GyPmuY05qG4hv1KeHAvSv/1tbEphrtm00IJhW9EoHagpopPlAjMgeBKEGo9mn
	 CIHgsW2q4zOf43pGvthjaqvagNFhbRuEEjAeu/3598Ac8uSjfM8DfsSpAATF0L6pXQ
	 vHUmMkT6J+FRA==
Message-ID: <d5a9a5a9-c510-4c4c-92ee-f24da97bfdb7@kernel.org>
Date: Thu, 28 Dec 2023 13:42:42 +0100
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
Subject: [Weekly meetings] MoM - 19th of December 2023
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Two weeks ago, we had our 266th meeting with Davide, Paolo (Redhat), Mat
(Cruise) and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13494633: [net,1/4] selftests: mptcp: join: fix subflow_send_ack lookup
13494634: [net,2/4] mptcp: fix inconsistent state on fastopen race
13494635: [net,3/4] mptcp: fill in missing MODULE_DESCRIPTION()
13494636: [net,4/4] mailmap: add entries for Geliang Tang:
      - Series: mptcp: misc. fixes for v6.7
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=810528&state=*&archive=both

13493896: [net-next,v2,3/3] netlink: specs: mptcp: rename the MPTCP path
management spec:
      - Series: -
      - Submitter: Jakub Kicinski
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=810295&state=*&archive=both


    our repo (by: Matthieu Baerts, Maxim Galaganov):

13487112: [v3,mptcp-next,1/3] mptcp: rename
mptcp_setsockopt_sol_ip_set_transparent()
13487113: [v3,mptcp-next,2/3] mptcp: sockopt: support
IP_LOCAL_PORT_RANGE and IP_BIND_ADDRESS_NO_PORT
13487114: [v3,mptcp-next,3/3] selftests/net: add MPTCP coverage for
IP_LOCAL_PORT_RANGE:
      - Series: more sockopts for ephemeral ports
      - Submitter: Maxim Galaganov
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=808765&state=*&archive=both

13494549: [mptcp-net] MAINTAINERS: add Geliang as reviewer for MPTCP:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20231215-mptcp-reviewers-geliang-v1-1-3fec5a0f8eac@kernel.org/

13498084: [mptcp-next] Squash to "bpf: Add bpf_mptcp_sched_ops":
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20231219092705.4120179-1-matttbe@kernel.org/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Jakub Kicinski):

[PATCH v6 bpf-next 3/6] bpf: tcp: Handle BPF SYN Cookie in
skb_steal_sock().:
      - Series: bpf: tcp: Support arbitrary SYN Cookie at TC.
      - Submitter: Kuniyuki Iwashima
      - URL:
https://patchwork.kernel.org/project/netdevbpf/patch/20231214155424.67136-4-kuniyu@amazon.com/

    our repo (by: Geliang Tang, Ido Schimmel, Matthieu Baerts, Paolo Abeni):

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
      - Status: same as last time: Matt will try to look at them

13485151: [mptcp-next,v14,01/25] mptcp: export pm_nl_get_pernet_from_msk
13485153: [mptcp-next,v14,02/25] mptcp: drop mptcp_pm_get_* helpers
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
      - Status: Matth: check with Geliang which patches we can drop → Done

13494142: [mptcp-net] mptcp: prevent tcp diag from closing listener
subflows:
      - State: Changes requested
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/f6371f65b1ebabc0f308528494ec39c9bdf786fd.1702631517.git.pabeni@redhat.com/
      - Mat reviewed it: maybe we do need to trigger the worker to
finish the clean-up?:
          - Similar to what we do to disconnect subflows
          - maybe not too racy?
      - Waiting for Paolo's feedback:
          - invoking the worker could trigger some races we might want
to avoid for -net
          - so here it is the minimal patch for -net
          - but we should do something better for net-next

13495784: [net-next] genetlink: Use internal flags for multicast groups:
      - State: New
      - Submitter: Ido Schimmel
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20231217075348.4040051-1-idosch@nvidia.com/

13497790: [mptcp-next,v2,1/4] Squash to "mptcp: use mptcp_set_state" 1
13497791: [mptcp-next,v2,2/4] mptcp: move inet_sk_state_store under lock
13497792: [mptcp-next,v2,3/4] Squash to "mptcp: use mptcp_set_state" 2
13497793: [mptcp-next,v2,4/4] selftests: mptcp: diag: check CURRESTAB
counters:
      - State: Changes requested
      - Series: fixes for CURRESTAB
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=811243&state=*&archive=both
      - Probably safer not to have patches 2-3/4.
      - For patch 1: probably best to clarify the comment (see ML):
          -
https://lore.kernel.org/all/8d75b638-9d21-4ca9-af28-5f2c7caa0632@kernel.org/
      - For patch 4/4: just some small modifications needed

13498277: [mptcp-next,v4,01/14] mptcp: export mptcp_genl_family &
mptcp_nl_fill_addr
13498278: [mptcp-next,v4,02/14] mptcp: implement
mptcp_userspace_pm_dump_addr
13498279: [mptcp-next,v4,03/14] mptcp: dump addrs in userspace pm list
13498280: [mptcp-next,v4,04/14] mptcp: check userspace pm subflow flag
13498281: [mptcp-next,v4,05/14] mptcp: add token for get-addr in yaml
13498282: [mptcp-next,v4,06/14] selftests: mptcp: add userspace pm
subflow flag
13498283: [mptcp-next,v4,07/14] selftests: mptcp: add token for dump_addr
13498284: [mptcp-next,v4,08/14] selftests: mptcp: add check_output helper
13498285: [mptcp-next,v4,09/14] selftests: mptcp: dump userspace addrs list
13498286: [mptcp-next,v4,10/14] mptcp: add
userspace_pm_lookup_addr_by_id helper
13498287: [mptcp-next,v4,11/14] mptcp: implement mptcp_userspace_pm_get_addr
13498288: [mptcp-next,v4,12/14] mptcp: get addr in userspace pm list
13498289: [mptcp-next,v4,13/14] selftests: mptcp: add token for get_addr
13498290: [mptcp-next,v4,14/14] selftests: mptcp: userspace pm get addr
tests
13498318: [mptcp-next] Squash to "mptcp: dump addrs in userspace pm list":
      - State: New
      - Series: dump for userspace pm
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=811409&state=*&archive=both
      - the v1 was dumping everything for both the in-kernel and
userspace pm in a huge skb + not using YANL
      - the new version needs to be reviewed




Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 467):

  468  selftests: `mptcp_join`: 22 and 23 `backup flow used (...) link
fail` tests are unstable [bug] [selftests]:
      - It is possible it is due to a timing issue ("sleep" commands are
being used instead of waiting on events)
      - It looks like a regression because the public CI didn't complain
about it before but maybe a fix in the test is needed, to be analysed
      - TODO: Matth: try to reproduce it and ideally bisect it → done


    Bugs (opened, flagged as "bug" and assigned)

  451  syzkaller: possible deadlock in` __dev_queue_xmit` [bug]
[syzkaller] @dcaratti
  435  in-kernel PM: fullmesh: too many paths are being created [bug]
@matttbe
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang
  449  `MPTcpExtMPCapableFallbackACK` - looks surprising [bug] @dcaratti


    Bugs (opened and flagged as "bug" and not assigned)

  468  selftests: `mptcp_join`: 22 and 23 `backup flow used (...) link
fail` tests are unstable [bug] [selftests]
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


    Recently closed (since 2023-12-12)

  466  syzkaller: v6.1.65 KASAN: use-after-free Read in
`mptcp_subflow_queue_clean` [bug] [syzkaller] [reproducer] [bisected]
  460  Add `MPTCP_MIB_CURRESTAB` similar to TCP [enhancement] @geliangtang
  432  Rename `mptcp_is_tcpsk()` helper [enhancement] @dcaratti
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

        - [08298e6a7827] MAINTAINERS: add Geliang as reviewer for MPTCP
(Matthieu Baerts)

    - Fixes for net-next: /

    - Features for net-next:

        - [6f1447eed9aa] mptcp: cleanup state propagation (Paolo Abeni):
            - Depends on a patch that is in -net but not in net-next yet
            - TODO: Matth: send it on Friday morning, after the sync → done

        - [6b8bf15f1b53] mptcp: don't overwrite sock_ops in
mptcp_is_tcpsk() (Davide Caratti):
            - Can be sent

        - [401873730ca2] mptcp: add mptcp_set_state (Geliang Tang):
            - TODO: Matth: change the title → Done
        - [67f02d1a5edf] mptcp: use mptcp_set_state (Geliang Tang):
            - TODO: Matth: change the comment (if OK for others) → Done
        - [049fbb873c15] selftests: mptcp: join: check CURRESTAB
counters (Geliang Tang):
            - There is an extra one coming
            → TODO: Matth: can send the patches when the series is ready
→ done

        - [c3d3913a28f8] mptcp: rename
mptcp_setsockopt_sol_ip_set_transparent() (Maxim Galaganov)
        - [df8d67b3e9cb] mptcp: sockopt: support IP_LOCAL_PORT_RANGE and
IP_BIND_ADDRESS_NO_PORT (Maxim Galaganov)
        - [a9061c7719c2] selftests/net: add MPTCP coverage for
IP_LOCAL_PORT_RANGE (Maxim Galaganov):
            - Can be sent
            - TODO: Matth: send them "ASAP" → Done

    - Features for net-next (next): /

    - Features for other trees:

        - [f1dfe037fdf0] mptcp: add sched_data helpers (Geliang Tang)
        - [229208a99e76] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [c128adc086aa] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [4942cd8ab734] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [4f69aab96705] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [0a665bcef05e] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [a13ac231aa5d] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [eab447a51e88] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [626fc286143a] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [4bc9afdb0307] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [6d1270e9294d] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [76601237fa2d] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [0e5eeed6aa08] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [f322294a8f32] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [7b7787208d95] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [082981260d64] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - waiting for sched refactoring



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
        - We just reached the monthly limits: Matth disabled the CI for
the moment not to have notifications
        - TODO: Matth: find another solution: GH Action + Tuxsuite
(first, check the limitations) → in progress
        - /



Next meeting:
    - No meeting next week (27th of December).
    - Next one will be next year.
    - Next one on *Wednesday*, the 3rd of January.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240103



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.
