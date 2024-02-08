Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C656D1A8
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387335; cv=none; b=oS+e4S7V5Tgj9mbWise1CNsKAxo6J2uQVYQfCtoOMpRs2MadXjwtQhiupduFWjCVH3g6pp32NEobmXhuH/VAtDoPnokV0tgcr6Ux6yTColRtWwLA6i0t5caDeEkzi2TD4Ci8sVD2gmY9eMQIPJZf7PmmJop2FNK8VBsnASVNlpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387335; c=relaxed/simple;
	bh=QcXDmGqSCWLLJU7wglZOdSs3ZrWI344t4G4+H1tSAsc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=Q6Zfq1lvYc1ywfvVKq733Kw0s52I9HDDi2dlb5EGhlmG5ztY57NqDwp00wfShd0EAWTc8tdheETYoEPusORjihOli7TUgWIldGGB8AHzscpCE6s8yKJDH2XAIWp1K6Ik8IA+NCpq0+KAujJV9Tj2eoAQj4Wb+JoDQF5NqPgn/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwb8JgDj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwb8JgDj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F829C433F1
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 10:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707387335;
	bh=QcXDmGqSCWLLJU7wglZOdSs3ZrWI344t4G4+H1tSAsc=;
	h=Date:From:Subject:To:From;
	b=dwb8JgDjrrLPWhZeZU0AEajM3rcNGygxDs9YFJNqj5+Cg5kSoqCX8BSSk7D7ourHZ
	 sBlb0ffFJ/pxz0dYBIyBl9swYWtJ6K4ZyifgKO5GP2agqgfxSWXFxL68+fvXicr9Dj
	 wkj8KeTUYaN8jy20naF+vyHEkBFf+Jcj0FNvZCwIlliBrPtJp+OP7VwEAR4pwE0fxU
	 8NdOxL6l2b8Rj7oZTXXwATblLfOnoVnIB0v22nzc1WHS/NOWj6trDV9ut0zLQxSgJ6
	 g4WZlvyOS1w+7jrsPq0EuyJRcN90Kw4q2+knMusYiTOVUSdYmX5kE5FkLQ9FDPj8Gk
	 Yg9ye0fMom2ZQ==
Message-ID: <98472b70-d646-4e70-bf75-9c98337df029@kernel.org>
Date: Thu, 8 Feb 2024 11:15:32 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 7th of February 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our 270th meeting with Mat (Cruise), Christoph (Apple)
Paolo, Davide (Red Hat) and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13540008: [net,1/9] mptcp: fix data re-injection from stale subflow
13540009: [net,2/9] selftests: mptcp: add missing kconfig for NF Filter
13540010: [net,3/9] selftests: mptcp: add missing kconfig for NF Filter
in v6
13540011: [net,4/9] selftests: mptcp: add missing kconfig for NF Mangle
13540012: [net,5/9] selftests: mptcp: increase timeout to 30 min
13540013: [net,6/9] selftests: mptcp: decrease BW in simult flows
13540014: [net,7/9] selftests: mptcp: allow changing subtests prefix
13540015: [net,8/9] selftests: mptcp: join: stop transfer when check is
done (part 1)
13540016: [net,9/9] selftests: mptcp: join: stop transfer when check is
done (part 2):
      - Series: mptcp: fixes for recent issues reported by CI's
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=821881&state=*&archive=both
      - improving the tests reported by the NIPA Netdev CI:
          -
https://netdev.bots.linux.dev/flakes.html?br-cnt=88&tn-needle=mptcp
          - https://netdev.bots.linux.dev/contest.html?executor=vmksft-mptcp
          - But still some/more issues with simult_flows.sh in the
no-kvm runner
          - This runner has been removed, but a new dbg one is causing
issues

13542793: [net-next,1/5] mptcp: annotate access for msk keys
13542794: [net-next,2/5] mptcp: annotate lockless access for the tx path
13542795: [net-next,3/5] mptcp: annotate lockless access for RX path fields
13542796: [net-next,4/5] mptcp: annotate lockless access for token
13542797: [net-next,5/5] mptcp: annotate lockless accesses around
read-mostly fields:
      - Series: mptcp: annotate lockless access
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=822496&state=*&archive=both


    our repo (by: Geliang Tang):

13540524: [mptcp-net] MAINTAINERS: update Geliang's email address:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/eb152068d96e0980d010272f5190da7807f35c13.1706749536.git.geliang@kernel.org/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Paolo Abeni):

13528961: [mptcp-stable] mptcp: introduce explicit flag for first
subflow disposal:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/a1503ab571c8c076de62b872437d220a2260d2a5.1706094997.git.pabeni@redhat.com/

13548566: [bpf-next,v4,1/3] bpf, btf: Fix error checks for
btf_get_module_btf
13548567: [bpf-next,v4,2/3] bpf, btf: Add check_btf_kconfigs helper
13548568: [bpf-next,v4,3/3] bpf, btf: Check btf for register_bpf_struct_ops:
      - State: New
      - Series: bpf, btf: Add DEBUG_INFO_BTF checks for
__register_bpf_struct_ops
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=823976&state=*&archive=both


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
      - fixes for the "refcount" are in "dump for userspace" series
      - we can archive these patches

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
      - Status: same as before: Matth will (really) check

13522386: [mptcp-next,v10,01/23] mptcp: add pm_has_addr_attr_id helper
13522406: [mptcp-next,v10,21/23] mptcp: update set_flags interfaces
13522407: [mptcp-next,v10,22/23] mptcp: set error messages for set_flags
13522408: [mptcp-next,v10,23/23] selftests: mptcp: flush userspace addrs
list:
      - State: Changes requested
      - Series: dump for userspace pm
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=817723&state=*&archive=both
      - no longer needed: can be archived → done

13525637: [mptcp-next,1/7] mptcp: push ad DSS boundaries
13525635: [mptcp-next,2/7] mptcp: fix snd_wnd initialization for passive
socket
13525638: [mptcp-next,3/7] mptcp: fix potential wake-up event loss
13525639: [mptcp-next,4/7] mptcp: cleanup writer wake-up
13525640: [mptcp-next,5/7] mptcp: avoid some duplicate code in socket
option handling
13525641: [mptcp-next,6/7] mptcp: implement TCP_NOTSENT_LOWAT support.
13525642: [mptcp-next,7/7] mptcp: cleanup SOL_TCP handling:
      - State: Needs ack
      - Series: mptcp: implement TCP_NOTSENT_LOWAT support
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=818661&state=*&archive=both
      - to be reviewed → done

13540609: [mptcp-net,1/4] mptcp: add needs_id for userspace appending addr
13540610: [mptcp-net,2/4] mptcp: add needs_id for netlink appending addr:
    - State: can be applied
    - TODO Matth: apply → Done

13540656: [mptcp-next,v11,01/15] mptcp: export mptcp_genl_family &
mptcp_nl_fill_addr
13540657: [mptcp-next,v11,02/15] mptcp: implement
mptcp_userspace_pm_dump_addr
13540658: [mptcp-next,v11,03/15] mptcp: add token for get-addr in yaml
13540659: [mptcp-next,v11,04/15] mptcp: dump addrs in userspace pm list
13540660: [mptcp-next,v11,05/15] mptcp: check userspace pm flags
13540661: [mptcp-next,v11,06/15] selftests: mptcp: add userspace pm
subflow flag
13540662: [mptcp-next,v11,07/15] selftests: mptcp: add token for dump_addr
13540663: [mptcp-next,v11,08/15] selftests: mptcp: add check_output helper
13540664: [mptcp-next,v11,09/15] selftests: mptcp: dump after creating
id 0 subflow
13540665: [mptcp-next,v11,10/15] selftests: mptcp: dump userspace addrs list
13540666: [mptcp-next,v11,11/15] mptcp: add
userspace_pm_lookup_addr_by_id helper
13540667: [mptcp-next,v11,12/15] mptcp: implement
mptcp_userspace_pm_get_addr
13540668: [mptcp-next,v11,13/15] mptcp: get addr in userspace pm list
13540669: [mptcp-next,v11,14/15] selftests: mptcp: add token for get_addr
13540670: [mptcp-next,v11,15/15] selftests: mptcp: userspace pm get addr
tests:
      - State: New
      - Series: dump for userspace pm
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=821965&state=*&archive=both
      - should now only contain new features for net-next

13544551: [virtme-docker,v4] tests: add bpftests support:
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/d06fa9d096d8082675079f68d0eb213f5314fe15.1707033594.git.tanggeliang@kylinos.cn/
      - Matth is looking at that, also waiting for "bpf, btf: Add
DEBUG_INFO_BTF checks for __register_bpf_struct_ops" to be applied on
BPF side

13545002: [mptcp-next] mptcp: add a sk_is_tcp check for sk_is_mptcp:
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/e97e306f73ff10b437eef979b7d5d82b822e2f52.1707113244.git.tanggeliang@kylinos.cn/
      - maybe not needed to add additional checks for the current use?
      - maybe best to rename it to tp_is_mptcp() or something more
explicit (subflow_is_mptcp(), ssk_is_mptcp, etc.)?
      - or have both?
      - Mat will look at that

13545749: [mptcp-net,1/4] mptcp: fix lockless access in subflow ULP diag
13545752: [mptcp-net,2/4] mptcp: fix data races on local_id
13545750: [mptcp-net,3/4] mptcp: fix data races on remote_id
13545751: [mptcp-net,4/4] mptcp: fix duplicate subflow creation:
      - State: Changes requested
      - Series: mptcp: fix duplicate subflow creation
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=823221&state=*&archive=both
      - Mat did the review, v2 is expected

13548001: [mptcp-next,v3,1/2] mptcp: map v4 address to v6 when
destroying subflow
13548002: [mptcp-next,v3,2/2] selftests: mptcp: rm subflow with
v4/v4mapped addr:
      - State: New
      - Series: fixes for "map v4 address to v6"
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=823789&state=*&archive=both
      - for -net
      - that was part of another series, a split to keep only the fixes

13548358: [mptcp-next,v3,1/3] mptcp: token kunit: set protocol
13548359: [mptcp-next,v3,2/3] mptcp: check the protocol in tcp_sk() with
DEBUG_NET
13548360: [mptcp-next,v3,3/3] mptcp: check the protocol in mptcp_sk()
with DEBUG_NET:
      - State: New
      - Series: mptcp: check the protocol with DEBUG_NET
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=823928&state=*&archive=both
      - linked to a discussion we had last week
      - checkpatch warnings but seems OK:
https://github.com/multipath-tcp/mptcp_net-next/actions/runs/7814594661



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 472):

  474  CI: GH Actions: use self-hosted runners [enhancement] [CI] @matttbe:
      - would help to drop Cirrus CI (CPU time limited)
      - and maybe replace non-debug tests using a no-kvm runner?

  473  CI: tracking: publish tests results to Kernel CI [enhancement] [CI]:
      - to be able to track flaky tests


    Bugs (opened, flagged as "bug" and assigned)

  471  Crash in `netif_rx_internal` [bug] [wontfix] [selftests] @matttbe:
      - it looks like a fix has been introduced in QEmu v8.1.0, but not
backported
      - Matth is trying to have a fix in Ubuntu 23.10, so we can drop
the workaround we have in our kernel tree
      - https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2051965

  451  syzkaller: possible deadlock in` __dev_queue_xmit` [bug]
[syzkaller] @dcaratti
  449  `MPTcpExtMPCapableFallbackACK` - looks surprising [bug] @dcaratti
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  435  in-kernel PM: fullmesh: too many paths are being created [bug]
@matttbe
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  463  syzkaller: INFO: task hung in `lock_sock_nested` [bug] [syzkaller]
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

  474  CI: GH Actions: use self-hosted runners [enhancement] [CI] @matttbe
  472  CI: switch to virtme-ng [enhancement] [CI] @matttbe
  464  `TCP_NOTSENT_LOWAT` socket-option support [enhancement] @pabeni
  453  sk_is_mptcp() only works with struct tcp_sock * [enhancement]
@geliangtang
  446  MPTCP Info counters: display "last time" actions info
[enhancement] @geliangtang
  406  Compile and run mptcp bpf selftests in CI [enhancement]
[selftests] [bpf] [CI] @geliangtang
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

  473  CI: tracking: publish tests results to Kernel CI [enhancement] [CI]
  469  CI: add code coverage support [enhancement] [CI]
  467  Scheduler: add redundant scheduler support in BPF [enhancement]
[sched]
  462  selftests: print (and set?) random seed [enhancement] [selftests]
  461  Protocol: extend Data-Level Length field [enhancement] [protocol]
  448  Allow sending ADD_ADDR IPv6 with port-number if TCP-timestamps
are enabled [enhancement]
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


    Recently closed (since 2024-01-31)

  470  CI: execute tests with GH Actions [enhancement] [CI] @matttbe
  465  syzkaller: v6.1.60 - refcount_t: addition on 0; use-after-free
[bug] [syzkaller] [reproducer] [bisected]



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.9):
https://github.com/orgs/multipath-tcp/projects/7
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to netdev:

    - Fixes for other trees:

        - [341ff7559a88] x86: Fixup from the removed INT3 if it is
unhandled (Masami Hiramatsu):
            - workaround for QEmu < 8.1 (without KVM)

    - Fixes for -net:

        - [d50953d6ac17] mptcp: check addrs list in
userspace_pm_get_local_id (Geliang Tang)
        - [c28397bbe894] mptcp: drop the push_pending field (Paolo Abeni)
        - [4a3213453660] mptcp: fix rcv space initialization (Paolo Abeni)
        - [12b3068492fe] mptcp: fix more tx path fields initialization
(Paolo Abeni)
        - [b3f50a461cc4] mptcp: corner case locking for rx path fields
initialization (Paolo Abeni)
        - [3ba875688236] mptcp: really cope with fastopen race (Paolo Abeni)
        - [8655530c5caa] MAINTAINERS: update Geliang's email address
(Geliang Tang):
            - can be sent: TODO Matth → tests in progress

    - Fixes for net-next: /

    - Features for net-next: /

    - Features for net-next (next): /

    - Features for other trees:

        - [29a4b5865ad3] mptcp: add sched_data helpers (Geliang Tang)
        - [b7d84a6b460e] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [41ae09cdf0cf] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [281003d27d2e] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [4f917029955a] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [3cbf85a72111] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [52ba94071786] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [e433d12cffd2] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [fda7fb6b09ec] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [71ba3a36d4cb] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [0acdadcfd697] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [259d217c2bcb] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [1fb7e70e863c] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [b406e0d20e28] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [7ca7eca86055] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [8d69c89af563] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - same as before: waiting for sched refactoring



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - stable branches have been synced with upstream to fix
compilation issues with newer compiler + get new fixes and features, etc.
        - + a small fix:
          https://github.com/multipath-tcp/packetdrill/pull/131

    - Patchew (Davide):
        - /

    - CI (Matth):
        - New summaries on GH Actions pages:
            → no longer needed to download the artifacts / check logs, e.g.
            - Checkpatch:
https://github.com/multipath-tcp/mptcp_net-next/actions/runs/7787400211
            - Build:
https://github.com/multipath-tcp/mptcp_net-next/actions/runs/7787400267
            - Tests:
https://github.com/multipath-tcp/mptcp_net-next/actions/runs/7787400213
                → and with Telemetry: CPU, Network, IO
                → we can see that packetdrill tests (at the end) are
using a lot of CPU resources (to be confirmed): that maybe explains some
instabilities.

        - NIPA:
            - some instabilities with mptcp join: 102 (fastclose) and
104 (infinite map) + simult flows
            - for mptcp join, we have (old) tickets
            - also mptcp join timeout in dbg mode: Matth will look at
increasing the timeout only for these dbg mode



Netdev 0x18:
    - Date : July 15, 2024
    - Location : Silicon Valley, .ca.us (again West coast, North America)



Next meeting:
    - Next one on *Wednesday*, the 14th <3 of February.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240214



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.
