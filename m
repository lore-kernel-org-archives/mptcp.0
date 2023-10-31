Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BB020B07
	for <mptcp@lists.linux.dev>; Tue, 31 Oct 2023 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjdrwpnz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BE7C433C7
	for <mptcp@lists.linux.dev>; Tue, 31 Oct 2023 17:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698774211;
	bh=yCsD4VeA8+D1haiHs8QKAtGAOr03oc+OW5Hq26ZKYyk=;
	h=Date:To:From:Subject:From;
	b=kjdrwpnzPDeCTMnQYurnCraujbEJufWMW3fS05+aJK+EwrI5zlx7vxF/LDDZO/d8G
	 aVrDLVbKujqsPLF1AZiB0WFKjq5p6RJg9J5cX6xKWszsXoKWYGc4R8VD40I/p2s4Km
	 zrJQzGi+HUGtzKk5ifRVIScqRMEEintGR0688uYvpMoB0F5+rqFDvjvKgczQ1BzP4S
	 uQ5bo0MrUBHqjgQnaDHv9rpBmiorPQShqiUefBrF55oNZKmKefpvsGXnaGNYc7HXBb
	 YK+P6bZuuWISyRLjmcDzqRJhXN6GJoHv4+xhwda/bC/lneBaLvA64tPXO5lRklzV48
	 K+ACxpnbxcx1A==
Message-ID: <e2de3015-addb-40be-9e94-71ca1d2a6e75@kernel.org>
Date: Tue, 31 Oct 2023 18:43:28 +0100
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
Subject: [Weekly meetings] MoM - 31st of October 2023
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our 260th meeting with Davide (Redhat), Mat (Cruise)
and myself (self-employed).


Thanks again for this new good meeting!

Here are the minutes of the meeting:


Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau, Matthieu Baerts):

13427722: [net,1/5] selftests: mptcp: join: correctly check for no RST
13427723: [net,2/5] tcp: check mptcp-level constraints for backlog
coalescing
13427724: [net,3/5] mptcp: more conservative check for zero probes
13427725: [net,4/5] mptcp: avoid sending RST when closing the initial
subflow
13427726: [net,5/5] selftests: mptcp: join: no RST when rm subflow/addr:
      - Series: mptcp: Fixes for v6.6
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=794446&state=*&archive=both

13432004: [6.5.y] mptcp: avoid sending RST when closing the initial subflow:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20231022170312.2806040-1-matttbe@kernel.org/

13432005: [6.5.y] selftests: mptcp: join: correctly check for no RST:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20231022170546.2809827-1-matttbe@kernel.org/

13432090: [6.1.y] mptcp: avoid sending RST when closing the initial subflow:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20231022213013.3391376-1-matttbe@kernel.org/

13432091: [6.1.y] selftests: mptcp: join: correctly check for no RST:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20231022213140.3393546-1-matttbe@kernel.org/

13432092: [6.1.y] selftests: mptcp: join: no RST when rm subflow/addr:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20231022213229.3394813-1-matttbe@kernel.org/

13433346: [net-next,v2,1/7] tools: ynl: add uns-admin-perm to genetlink
legacy
13433347: [net-next,v2,2/7] tools: ynl-gen: add support for exact-len
validation
13433348: [net-next,v2,3/7] net: mptcp: convert netlink from small_ops
to ops
13433349: [net-next,v2,4/7] Documentation: netlink: add a YAML spec for
mptcp
13433350: [net-next,v2,5/7] uapi: mptcp: use header file generated from
YAML spec
13433352: [net-next,v2,6/7] net: mptcp: rename netlink handlers to
mptcp_pm_nl_<blah>_{doit,dumpit}
13433351: [net-next,v2,7/7] net: mptcp: use policy generated by YAML spec:
      - Series: mptcp: convert Netlink code to use YAML spec
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=795753&state=*&archive=both

13433537: [net-next,1/9] mptcp: add a new sysctl for make after break
timeout
13433538: [net-next,2/9] mptcp: properly account fastopen data
13433539: [net-next,3/9] mptcp: use plain bool instead of custom binary enum
13433542: [net-next,4/9] tcp: define initial scaling factor value as a macro
13433540: [net-next,5/9] mptcp: give rcvlowat some love
13433541: [net-next,6/9] mptcp: use copy_from_iter helpers on transmit
13433543: [net-next,7/9] mptcp: consolidate sockopt synchronization
13433545: [net-next,8/9] mptcp: ignore notsent_lowat setting at the
subflow level
13433544: [net-next,9/9] mptcp: refactor sndbuf auto-tuning:
      - Series: mptcp: Features and fixes for v6.7
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=795803&state=*&archive=both

13436951: [net-next,01/10] selftests: mptcp: run userspace pm tests slower
13436952: [net-next,02/10] selftests: mptcp: fix wait_rm_addr/sf parameters
13436953: [net-next,03/10] mptcp: userspace pm send RM_ADDR for ID 0
13436955: [net-next,04/10] mptcp: drop useless ssk in pm_subflow_check_next
13436954: [net-next,05/10] mptcp: use mptcp_check_fallback helper
13436956: [net-next,06/10] mptcp: use mptcp_get_ext helper
13436957: [net-next,07/10] mptcp: move sk assignment statement ahead
13436958: [net-next,08/10] mptcp: define more local variables sk
13436960: [net-next,09/10] selftests: mptcp: sockopt: drop mptcp_connect var
13436959: [net-next,10/10] selftests: mptcp: display simult in extra_msg:
      - Series: mptcp: Fixes and cleanup for v6.7
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=796615&state=*&archive=both


    our repo (by: Davide Caratti, Geliang Tang, Matthieu Baerts):

13420223: [mptcp-next,v4,1/7] selftests: mptcp: add mptcp_lib_kill_wait
13420224: [mptcp-next,v4,2/7] selftests: mptcp: add mptcp_lib_is_v6
13420225: [mptcp-next,v4,3/7] selftests: mptcp: add mptcp_lib_get_counter
13420226: [mptcp-next,v4,4/7] selftests: mptcp: add missing oflag=append
13420229: [mptcp-next,v4,5/7] selftests: mptcp: add mptcp_lib_make_file
13420230: [mptcp-next,v4,6/7] selftests: mptcp: add mptcp_lib_check_transfer
13420231: [mptcp-next,v4,7/7] selftests: mptcp: add
mptcp_lib_wait_local_port_listen:
      - Series: export helpers to mptcp_lib.sh
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=792889&state=*&archive=both

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
      - Series: v2 fixes for "mptcp: convert Netlink code to use YAML spec"
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=793554&state=*&archive=both

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
      - Series: userspace pm remove id 0 subflow & address
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=793778&state=*&archive=both

13432198: Squash to "selftests: mptcp: add evts_get_info helper":
      - Series: Squash to "selftests: mptcp: add evts_get_info helper"
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=795469&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Mat Martineau, Matthieu Baerts):

13439267: [net-next,01/15] mptcp: add mptcpi_subflows_total counter
13439268: [net-next,02/15] selftests: mptcp: add evts_get_info helper
13439269: [net-next,03/15] selftests: mptcp: add chk_subflows_total helper
13439271: [net-next,04/15] selftests: mptcp: update userspace pm test
helpers
13439270: [net-next,05/15] selftests: mptcp: userspace pm create id 0
subflow
13439272: [net-next,06/15] mptcp: userspace pm rename remove_err to out
13439273: [net-next,07/15] selftests: mptcp: userspace pm remove initial
subflow
13439274: [net-next,08/15] selftests: mptcp: userspace pm send RM_ADDR
for ID 0
13439276: [net-next,09/15] selftests: mptcp: add mptcp_lib_kill_wait
13439275: [net-next,10/15] selftests: mptcp: add mptcp_lib_is_v6
13439277: [net-next,11/15] selftests: mptcp: add mptcp_lib_get_counter
13439278: [net-next,12/15] selftests: mptcp: add missing oflag=append
13439279: [net-next,13/15] selftests: mptcp: add mptcp_lib_make_file
13439280: [net-next,14/15] selftests: mptcp: add mptcp_lib_check_transfer
13439281: [net-next,15/15] selftests: mptcp: add
mptcp_lib_wait_local_port_listen:
      - Series: mptcp: More selftest coverage and code cleanup for net-next
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=797257&state=*&archive=both
      - Will need to be sent when net-next will re-open
      - → archived

13441677: [bpf-next] bpf: fix compilation error without CGROUPS:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20231031-bpf-compil-err-css-v1-1-e2244c637835@kernel.org/


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

13386450: [mptcp-next,v2] ss: mptcp: print out subflows_total counter:
      - State: Awaiting upstream
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/3ca520a2ce84c33ad8f9421add0b717091173a22.1694763872.git.geliang.tang@suse.com/
      - Status: same as before

13397525: [mptcp-next,v3,17/29] mptcp: add userspace_pm_get_entry helper
13397526: [mptcp-next,v3,18/29] mptcp: add userspace pm addr entry refcount
13397527: [mptcp-next,v3,19/29] mptcp: add netlink pm addr entry refcount
13397528: [mptcp-next,v3,20/29] selftests: mptcp: add userspace pm
fullmesh tests
13397530: [mptcp-next,v3,22/29] selftests: mptcp: add mptcp_lib_evts_*
13397531: [mptcp-next,v3,23/29] selftests: mptcp: userspace: print
colored results:
    - What do with these patches?
    - TODO: Matth: send a message to Geliang → Done

13438610: [net-next] mptcp: deal with large GSO size.:
      - State: New
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/ce93989da39fd2e47baa4506fbbf4c2049c2da13.1698416467.git.pabeni@redhat.com/
      - Fix for -net

13441631: [mptcp-next] net/mptcp: don't overwrite sock_ops in
mptcp_is_tcpsk():
      - State: New
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/a2581b975c0c5bec417b2dd5e0b014acd7770e14.1698764762.git.dcaratti@redhat.com/
      - We can strip 'net/' from the prefix
      - We should probably use 'is_mptcp' instead of looking at the sock
ops while at it, likely a new version will be needed.




Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 448):

  452  mptcp causes the network to become very slow [question]:
      - The issue is seen on an "old" kernel (5.15)
      - Matth asked to retry with a newer kernel (6.6 or export)

  451  syzkaller: possible deadlock in` __dev_queue_xmit` [bug] [syzkaller]:
      - not related to MPTCP (qdisc known issue)
      - well understood
      - Davide already sent a patch: it should at least fix the false
positive
      - but it is still possible to have a deadlock
      - we can keep the ticket open for another week and see later what
to do

  450  syzkaller: WARNING in `__mptcp_move_skbs_from_subflow` [bug]
[syzkaller] [reproducer] [bisected]:
      - Paolo already sent a patch for that, see above (mptcp: deal with
large GSO size)

  449  `MPTcpExtMPCapableFallbackACK` - looks surprising [bug]:
      - Looks like a bug: we probably have an MPTCP socket and the
accepted SYN didn't have MPTCP options
      - TODO: Matth: report that on the ticket just to be sure we are
aligned → done


    Bugs (opened, flagged as "bug" and assigned)

  435  in-kernel PM: fullmesh: too many paths are being created [bug]
@matttbe


    Bugs (opened and flagged as "bug" and not assigned)

  451  syzkaller: possible deadlock in` __dev_queue_xmit` [bug] [syzkaller]
  450  syzkaller: WARNING in `__mptcp_move_skbs_from_subflow` [bug]
[syzkaller] [reproducer] [bisected]
  449  `MPTcpExtMPCapableFallbackACK` - looks surprising [bug]
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

  432  Rename `mptcp_is_tcpsk()` helper [enhancement] @dcaratti:
      - See patches above

  403  userspace pm: local_addr_list: use a refcount per entry
[enhancement] [pm] @geliangtang:
      - See patches above

  353  sockopt: uniform code to get/set values [enhancement] @matttbe:
      - See patches above

  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang

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

  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned assigned)

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


    Recently closed (since 20231017)

  436  Supports redundant backup transmission of multiple subflows
[enhancement] [sched]
  379  userspace pm: ability to send `RM_ADDR` for all local IDs used (0
included) [bug] [pm] @geliangtang



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.7):
https://github.com/orgs/multipath-tcp/projects/5
    - For later: https://github.com/orgs/multipath-tcp/projects/1
    - TODO: Matth: update changelog + projects



Patches to send to netdev:

    - Fixes for other trees:

        - [9c2c09b0b641] bpf: fix compilation error without CGROUPS
(Matthieu Baerts)
        - [9092ea6f8a82] rcu: kmemleak: Ignore kmemleak false positives
when RCU-freeing objects (Catalin Marinas)

    - Fixes for -net: /

    - Fixes for net-next: /

    - Features for net-next:

        - [af9c75a02d50] mptcp: add mptcpi_subflows_total counter
(Geliang Tang)
        - [3e64d6b42da9] selftests: mptcp: add evts_get_info helper
(Geliang Tang)
        - [ef22a0a29dd0] selftests: mptcp: add chk_subflows_total helper
(Geliang Tang)
        - [18473937275f] selftests: mptcp: update userspace pm test
helpers (Geliang Tang)
        - [8b1de4f96406] selftests: mptcp: userspace pm create id 0
subflow (Geliang Tang)
        - [8a8243f69d88] mptcp: userspace pm rename remove_err to out
(Geliang Tang)
        - [291ce21a4c74] selftests: mptcp: userspace pm remove initial
subflow (Geliang Tang)
        - [ea7810730345] selftests: mptcp: userspace pm send RM_ADDR for
ID 0 (Geliang Tang)
        - [62fd66cb789f] selftests: mptcp: add mptcp_lib_kill_wait
(Geliang Tang)
        - [13e2dde00590] selftests: mptcp: add mptcp_lib_is_v6 (Geliang
Tang)
        - [68f283f2525f] selftests: mptcp: add mptcp_lib_get_counter
(Geliang Tang)
        - [1f2bc0970931] selftests: mptcp: add missing oflag=append
(Geliang Tang)
        - [507d2d585681] selftests: mptcp: add mptcp_lib_make_file
(Geliang Tang)
        - [441d15af0432] selftests: mptcp: add mptcp_lib_check_transfer
(Geliang Tang)
        - [70a652f0775c] selftests: mptcp: add
mptcp_lib_wait_local_port_listen (Geliang Tang):
            - net-next is closed, will be sent when it will re-open

    - Features for net-next (next): /

    - Features for other trees:

        - [42428536353f] mptcp: add sched_data helpers (Geliang Tang)
        - [a341c7169254] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [47f6a9a296a6] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [71d5c53c5833] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [d38b18fbac7a] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [80035cb6b725] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [0056ccc13b23] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [1be7d5c2e73d] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [da337c769b2d] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [c24d851a65ae] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [eb4ff7344f60] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [6d03d0227ab0] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [c9e624c8ae6c] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [1c9eeb5195f7] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [557995f85bcb] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [b26a541ca460] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - Waiting for a refactoring of the sched API




Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - One PR sent upstream:
https://github.com/google/packetdrill/pull/81
        - Accepted by Willem but not merged yet

    - Patchew (Davide):
        - /

    - CI (Matth):
        - Issues with the new "subflows_total" counter have been fixed
apparently
        - Some build issues recently but due to BPF code, patch sent and
applied in our tree



net-next:
    - it has been closed earlier than expected (before the release)
    - the last series we sent has not been applied (but sent too late
anyway)
    - just before it closes, it might be easier to send the series to
net-next to have them quicker in Linus tree → BUT we should not include
stable in cc because it's weird.
    - Watch to see if
https://lore.kernel.org/netdev/20231025-send-net-next-20231025-v1-3-db8f25f798eb@kernel.org/
is selected for stable, might need to be manually posted
    - Fixes tag got stripped before applying to net-next
    - TODO: Matth: check next week if it is in Linus tree → if yes, we
should probably manually ask the stable tree to pick it



Next meeting:
    - Next one on Tuesday, the 7th of November.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20231107



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
