Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AF858229
	for <mptcp@lists.linux.dev>; Thu, 21 Mar 2024 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020371; cv=none; b=UaKC4QnFeApZ+V4iLFbspjj+1dU4DKUbSFvVN4WbTkGXG7Ub/LB1HI8YcL0W+8qE7KQYzChFeXDqoLHG7DV5oCuG1udMsz4/nVPcosIf1dJ8Rcb4b3WU/0B94nuXSBs8cAEy01wXRxv3gWgsiK61xnO63zw3Yp4PluQNxKJeuvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020371; c=relaxed/simple;
	bh=y4UjZxdZZ51Q452NoBIViRnFm6CfwhQ4FN/DzXB523I=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Sa9SYjzRSjJPnGfEyRRR0FgPcH2PVbT+aB8Zv86OpQq2cU4+t5U7NivMrdQ7xGuTNR5+CGhYzGC3zyKqwsEBTK3wR2Xf5RLYUZWayMxX9SM3gZEgMU4nQjyb/oLuQEP5aZRxZWPq0ilvj0hY+1pdy3+YKt9LyscvQeNrUtcdhNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwpU15V2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwpU15V2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AD1C433C7
	for <mptcp@lists.linux.dev>; Thu, 21 Mar 2024 11:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711020371;
	bh=y4UjZxdZZ51Q452NoBIViRnFm6CfwhQ4FN/DzXB523I=;
	h=Date:To:From:Subject:From;
	b=dwpU15V2FQnt+IziuDO0OGqPF7SwUGMznARR0pNV4eknpvqY94e/XmWTXj004O9EB
	 2eZzYiF+Zx2R9HJ5pu55f7aVsIbSqoX7GCv3tVRd/1FvLKvAu/TlNFbdFiXObXymrz
	 gpslLHb6uYLpphZpff9eMPWTPTzB4ia/VSWoOwGvOzsO/8Web/8MES/XGlZtoXzIDD
	 ntlzoXKK40H/ah9Gdgj0myBL9oTWhqmPqg8/a+hzre2wWBM/N6mcgrigr3D1/JhIpA
	 bL7wr18upCM8iFz5Abt7Klqy0N1x7iZlax3LT5XvjQt9jipdOBRjKEc3Qc8uY0fASW
	 2s4mUsV8Oc1xw==
Message-ID: <fb3a32c8-1567-49e9-aaad-be1d7e98ac90@kernel.org>
Date: Thu, 21 Mar 2024 12:26:08 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB, fr
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 20th of March 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our new meeting with Paolo (Red Hat), and myself (NGI0
Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang):

13596253: [mptcp-next,v4,1/9] selftests: mptcp: export ip_mptcp to mptcp_lib
13596254: [mptcp-next,v4,2/9] selftests: mptcp: add get_limits helper
13596255: [mptcp-next,v4,3/9] selftests: mptcp: add get_endpoint helper
13596256: [mptcp-next,v4,4/9] selftests: mptcp: add change_address helper
13596257: [mptcp-next,v4,5/9] selftests: mptcp: join: update endpoint ops
13596258: [mptcp-next,v4,6/9] selftests: mptcp: export pm_nl endpoint ops
13596259: [mptcp-next,v4,7/9] selftests: mptcp: use pm_nl endpoint ops
13596261: [mptcp-next,v4,8/9] selftests: mptcp: ip_mptcp option for more
scripts
13596262: [mptcp-next,v4,9/9] selftests: mptcp: netlink: drop
disable=SC2086:
      - Series: add helpers and vars in mptcp_lib.sh, final
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=836322&state=*&archive=both

13596346: [mptcp-next] Squash to "selftests: mptcp: add get_endpoint
helper":
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/1babce1397309da3dd9f581b9c4ee846fff23a36.1710835995.git.tanggeliang@kylinos.cn/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Joel Granados via B4 Relay):

13592685: [0/4] sysctl: Remove sentinel elements from networking
13592686: [1/4] networking: Remove the now superfluous sentinel elements
from ctl_table array
13592687: [2/4] netfilter: Remove the now superfluous sentinel elements
from ctl_table array
13592689: [3/4] appletalk: Remove the now superfluous sentinel elements
from ctl_table array
13592688: [4/4] ax.25: Remove the now superfluous sentinel elements from
ctl_table array:
      - Series: sysctl: Remove sentinel elements from networking
      - Submitter: Joel Granados via B4 Relay
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=835404&state=*&archive=both
      - to be reposted when net-next will be open
      - not specific to MPTCP but modifying it


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

13566825: [mptcp-next,v2,6/7] mptcp: add check_id for
lookup_anno_list_by_saddr
13566826: [mptcp-next,v2,7/7] selftests: mptcp: flush userspace addrs list:
      - State: Changes requested
      - Series: some cleanups
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=828557&state=*&archive=both
      - status: same as before

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
      - status: same as before

13589477: [virtme-docker] docker: install iperf:
      - State: Rejected
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/27fc057073806f67eb30b20ad732a1d3ccaf05e1.1710210140.git.geliang@kernel.org/

13595081: [mptcp-next,1/3] mptcp: add last time fields in mptcp_sock
13595082: [mptcp-next,2/3] mptcp: add last time fields in mptcp_info
13595083: [mptcp-next,3/3] selftests: mptcp: add last time actions tests:
      - State: New
      - Series: display "last time" actions info
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=836000&state=*&archive=both
      - TODO:
          - hook OK?
          - lock OK?
          - squash 1 and 2? They don't make sense alone

13597481: [mptcp-net,v4] mptcp: don't account accept() of non-MPC client
as fallback to TCP:
      - State: New
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/054bcffde84b87f588f788b30dce2b702a532f64.1710923679.git.dcaratti@redhat.com/
      - Can be applied
      - Maybe a test with PacketDrill?

13597840: [mptcp-next,1/4] Squash to "selftests/bpf: Add bpf scheduler
test" fix
13597841: [mptcp-next,2/4] selftests/bpf: Add mptcp subflow prog
13597842: [mptcp-next,3/4] selftests/bpf: Add mptcp subflow test
13597843: [mptcp-next,4/4] Squash to "selftests/bpf: Add bpf scheduler
test" cleanup:
      - State: New
      - Series: etsockopt per subflow: BPF
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=836743&state=*&archive=both
      - Good to have such example



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 478):

  480  MPTCP and KTLS support [enhancement]:
      - KTLS would need to interact with the MPTCP socket
      - Software part might be OK
      - Hardware offload might not be, to be studied → encrypted content
has the same size as the unencrypted one?
      - TODO: check which other sockoptions are being used by lighttpd:
Matth
         - I didn't check the libs, but for lighttpd:
           TCP_CORK, TCP_NODELAY, SO_REUSEADDR, IPV6_V6ONLY,
TCP_DEFER_ACCEPT: all supported

  479  when using openvpn in tcp with dco, we have a bug [question]:
      - Linked to: https://github.com/OpenVPN/ovpn-dco/issues/60
      - An out-of-tree kernel module that needs to be modified to
support MPTCP


    Bugs (opened, flagged as "bug" and assigned)

  449  `MPTcpExtMPCapableFallbackACK` - looks surprising [bug] @dcaratti
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  477  Client: fallback to TCP after X MPC [bug]
  476  packetdrill: coalescing feature doesn't take into account MPTCP
options [bug] [packetdrill]
  475  `simult_flows`: unbalanced bwidth tests are unstable [bug]
[selftests]
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

  446  MPTCP Info counters: display "last time" actions info
[enhancement] @geliangtang
  383  TCP_KEEPIDLE, TCP_KEEPINTVL, TCP_KEEPCNT are not implemented in
mptcp_setsockopt_sol_tcp [enhancement] @matttbe
  353  sockopt: uniform code to get/set values [enhancement] @matttbe
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   76  [gs]etsockopt per subflow: BPF [enhancement] [bpf] @geliangtang
   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang
   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang


    Assigned Questions (opened, questions and assigned)

  478  A hypothesis [question] @geliangtang


    Open questions (opened, questions and not assigned)

  479  when using openvpn in tcp with dco, we have a bug [question]
  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned assigned)

  480  MPTCP and KTLS support [enhancement]
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
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 2024-03-13)

  472  CI: switch to virtme-ng [enhancement] [CI] @matttbe



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.10):
https://github.com/orgs/multipath-tcp/projects/8
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [38fa8e690fd7] selftests: mptcp: simult flows: re-adapt BW
(Matthieu Baerts (NGI0)):
            - wait a bit more

        - [4ada5567681c] selftests: mptcp: join: fix dev in
check_endpoint (Geliang Tang)
            - can be sent, but not urgent

    - Fixes for net-next: /

    - Features for net-next:

        - [920b6406be2d] selftests: mptcp: add tc check for check_tools
(Geliang Tang)
        - [464b34302da3] selftests: mptcp: add ms units for tc-netem
delay (Geliang Tang)
        - [341d01dd32d5] selftests: mptcp: export ip_mptcp to mptcp_lib
(Geliang Tang)
        - [956076278bbc] selftests: mptcp: netlink: add 'limits' helpers
(Geliang Tang)
        - [8c6345537118] selftests: mptcp: add {get,format}_endpoint(s)
helpers (Geliang Tang)
        - [89bf782ecf03] selftests: mptcp: netlink: add change_address
helper (Geliang Tang)
        - [87e13d989129] selftests: mptcp: join: update endpoint ops
(Geliang Tang)
        - [0e69d07c4fa1] selftests: mptcp: export pm_nl endpoint ops
(Geliang Tang)
        - [c29e0903823b] selftests: mptcp: use pm_nl endpoint ops
(Geliang Tang)
        - [b780607879f6] selftests: mptcp: ip_mptcp option for more
scripts (Geliang Tang)
        - [41e65dc70e3f] selftests: mptcp: netlink: drop disable=SC2086
(Geliang Tang):
            - applied recently, and net-next is closed: wait

    - Features for net-next (next): /

    - Features for other trees:

        - [76d815584bfc] mptcp: add sched_data helpers (Geliang Tang)
        - [ef9555a2918b] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [830038759b40] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [2f7c769859f6] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [8f13874bdc67] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [7c9da01b3fcc] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [f573db18bd40] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [2944bb42e56d] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [85b96dc979b2] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [5128500d3960] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [d31ebb81b9b5] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [beee10260b26] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [23c34df6578c] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [e1be1dffa329] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [c782915018e7] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [548ef301a2e7] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - same as last week, waiting for the new sched interface



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
        - virtme-ng is now used
        - Flacky tests are reported on: https://ci-results.mptcp.dev



CVE:
    - the first CVE linked to MPTCP has been fixed by Paolo! (3 years ago)
      https://cve.org/CVERecord/?id=CVE-2021-47132



Next meeting:
    - Next one on *Wednesday*, the 27th of March.
    - 16:30 UTC (*9*.30am PDT, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240327



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.

