Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5A117BB2B
	for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769593; cv=none; b=Et4BBI2kNk0c0jvyFMdQrK2lwigZFFIo3G4VYOVoycqYwMh9qbggJIQeIM0wS6Ieis5Ymvr0+VdSvQVLpLNNJ7+mEvlgZORlApPuaJIkup4TqssSejFnTT5QzmeCf+7V5RL5zSEvCw32DiUbJDt/1+sUsrJkjwPdLYVZXrl0n40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769593; c=relaxed/simple;
	bh=XVwaesOqTKGr746RkJRFiAmIvldxOpYmvJpe2pd4wlo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=idQaw2/4o+9eFspHKG92XvHJal2C1Gc8U+FaS9K9/c2UTkbjfWZpzyz8rJ+Ar23cT2Gvq0kLgoInEmgRfSS1HJvQl4PFwM7v00R1eZiukSd3hAVUxdom7UuneUQIiycltzBddQszRwl4MGiFcZf2KHc7HDSOMFvxplzMXrCDq+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gB0u1BB4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gB0u1BB4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDF8C433B1
	for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 17:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769593;
	bh=XVwaesOqTKGr746RkJRFiAmIvldxOpYmvJpe2pd4wlo=;
	h=Date:To:From:Subject:From;
	b=gB0u1BB4QDr/sWehu0h6csijoenYGHxxJWs9NU6syDQSpcH0kKyDmHxZ94Bj3JXHG
	 F+oDRACutHEsaB0aWCKFTIzvkHEhq+rEWy6knHeWxr+Au/w9eOljR8MNSaRXrwW/On
	 /4L4jB1s7kCcRyQE0WPTzj9DofDz+/QEnHiygzRJpXIPl40Uu7S5e91DZqD7uaLKra
	 +i1pOBeZML167Dt9wo8qSsb+bNZiAyVimg1pYQWamY8iFFZyxzVuiOOmmeB4Is2Ncx
	 9rTteJ09ccZL/WFgDFzeuFQi6VAOK+ZfttLIayAW7f5SRLdOA1AZz82XF4yRCIOQc0
	 PYLFt8QXsEtMA==
Message-ID: <810beefc-7e25-4a67-94e8-521107785646@kernel.org>
Date: Wed, 10 Apr 2024 19:19:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 10th of April 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our new meeting with Davide (Red Hat), Christoph
(Apple), and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Jason Xing,
Matthieu Baerts (NGI0)):

13603810: [bpf-next,v4,1/2] selftests/bpf: Use connect_fd_to_fd in
bpf_tcp_ca
13603811: [bpf-next,v4,2/2] selftests/bpf: Drop settimeo in do_test:
      - Series: Use start_server and connect_fd_to_fd
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=838305&state=*&archive=both

13613718: [bpf-next] selftests/bpf: Add pid limit for mptcpify prog:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/8987e2938e15e8ec390b85b5dcbee704751359dc.1712054986.git.tanggeliang@kylinos.cn/

13618881: [net-next,01/11] selftests: mptcp: add tc check for check_tools
13618882: [net-next,02/11] selftests: mptcp: add ms units for tc-netem delay
13618883: [net-next,03/11] selftests: mptcp: export ip_mptcp to mptcp_lib
13618884: [net-next,04/11] selftests: mptcp: netlink: add 'limits' helpers
13618885: [net-next,05/11] selftests: mptcp: add
{get,format}_endpoint(s) helpers
13618886: [net-next,06/11] selftests: mptcp: netlink: add change_address
helper
13618887: [net-next,07/11] selftests: mptcp: join: update endpoint ops
13618888: [net-next,08/11] selftests: mptcp: export pm_nl endpoint ops
13618889: [net-next,09/11] selftests: mptcp: use pm_nl endpoint ops
13618890: [net-next,10/11] selftests: mptcp: ip_mptcp option for more
scripts
13618891: [net-next,11/11] selftests: mptcp: netlink: drop disable=SC2086:
      - Series: selftests: mptcp: cleanups and 'ip mptcp' support
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=841762&state=*&archive=both

13619135: [6.8.y,1/3] selftests: mptcp: connect: fix shellcheck warnings
13619136: [6.8.y,2/3] selftests: mptcp: use += operator to append strings
13619137: [6.8.y,3/3] mptcp: don't account accept() of non-MPC client as
fallback to TCP:
      - Series: Backport "mptcp: don't account accept() of non-MPC
client as fallback to TCP"
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=841842&state=*&archive=both

13619224: [6.6.y,2/5] selftests: mptcp: connect: fix shellcheck warnings
13619226: [6.6.y,4/5] mptcp: don't overwrite sock_ops in mptcp_is_tcpsk()
13619227: [6.6.y,5/5] mptcp: don't account accept() of non-MPC client as
fallback to TCP:
      - Series: Backport "mptcp: don't account accept() of non-MPC
client as fallback to TCP"
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=841860&state=*&archive=both

13619240: [6.1.y] selftests: mptcp: join: fix dev in check_endpoint:
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240405155442.1054470-2-matttbe@kernel.org/

13619263: [6.1.y] mptcp: don't account accept() of non-MPC client as
fallback to TCP:
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240405163521.1221351-2-matttbe@kernel.org/

13619291: [5.15.y] mptcp: don't account accept() of non-MPC client as
fallback to TCP:
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240405171415.1389330-2-matttbe@kernel.org/

13619294: [5.10.y] mptcp: don't account accept() of non-MPC client as
fallback to TCP:
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240405173034.1471178-2-matttbe@kernel.org/

13619643: [net-next,v2] mptcp: add reset reason options in some places:
      - Submitter: Jason Xing
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240406014848.71739-1-kerneljasonxing@gmail.com/


    our repo (by: Geliang Tang):

13620137: [mptcp-next,v2] Squash to "mptcp: add last time fields in
mptcp_info":
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/7930751788d3bc8155898d4a22bdd6efca8cfde0.1712486293.git.tanggeliang@kylinos.cn/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Matthieu Baerts
(NGI0)):

13619223: [6.6.y,1/5] selftests: mptcp: display simult in extra_msg
13619225: [6.6.y,3/5] selftests: mptcp: use += operator to append strings
      - Series: Backport "mptcp: don't account accept() of non-MPC
client as fallback to TCP"
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=841860&state=*&archive=both
      - to be re-sent, not sure why one patch didn't get backported,
maybe missed?

13621835: [bpf,v4,1/2] selftests/bpf: Add F_SETFL for fcntl in test_sockmap
13621836: [bpf,v4,2/2] selftests/bpf: Fix umount cgroup2 error in
test_sockmap:
      - Series: Two fixes for test_sockmap
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=842664&state=*&archive=both
      - Not related to MPTCP

13623607: [bpf-next,v4,1/3] selftests/bpf: Add struct send_recv_arg
13623608: [bpf-next,v4,2/3] selftests/bpf: Export send_recv_data helper
13623609: [bpf-next,v4,3/3] selftests/bpf: Support nonblock for
send_recv_data:
      - Series: export send_recv_data
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=843088&state=*&archive=both
      - Not directly related to MPTCP

13623719: [bpf-next,01/14] selftests/bpf: Add start_server_addr helper
13623720: [bpf-next,02/14] selftests/bpf: Use start_server_addr in
cls_redirect
13623721: [bpf-next,03/14] selftests/bpf: Use connect_to_addr in
cls_redirect
13623722: [bpf-next,04/14] selftests/bpf: Use start_server_addr in sk_assign
13623723: [bpf-next,05/14] selftests/bpf: Use connect_to_addr in sk_assign
13623724: [bpf-next,06/14] selftests/bpf: Use log_err in network_helpers
13623725: [bpf-next,07/14] selftests/bpf: Use start_server_addr in
test_sock_addr
13623726: [bpf-next,08/14] selftests/bpf: Use connect_to_addr in
test_sock_addr
13623727: [bpf-next,09/14] selftests/bpf: Add function pointer for
__start_server
13623728: [bpf-next,10/14] selftests/bpf: Add start_server_setsockopt helper
13623729: [bpf-next,11/14] selftests/bpf: Use start_server_setsockopt in
sockopt_inherit
13623730: [bpf-next,12/14] selftests/bpf: Use connect_to_fd in
sockopt_inherit
13623731: [bpf-next,13/14] selftests/bpf: Use start_server_* in
test_tcp_check_syncookie
13623732: [bpf-next,14/14] selftests/bpf: Use connect_to_addr in
test_tcp_check_syncookie:
      - Series: use start_server and connect_to helpers
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=843118&state=*&archive=both
      - Not directly related to MPTCP

13620178: [net-next,v1,10/12] net: replace page_frag with page_frag_cache:
    - in review on net-next

13622108: [net-next,v3,1/6] net: introduce rstreason to detect why the
RST is sent
13622109: [net-next,v3,2/6] rstreason: prepare for passive reset
13622110: [net-next,v3,3/6] rstreason: prepare for active reset
13622111: [net-next,v3,4/6] tcp: support rstreason for passive reset
13622112: [net-next,v3,5/6] mptcp: support rstreason for passive reset
13622113: [net-next,v3,6/6] rstreason: make it work in trace world:
      - State: New
      - Series: Implement reset reason mechanism to detect
      - Submitter: Jason Xing
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=842746&state=*&archive=both


    our repo (by: Geliang Tang, Jason Xing, Matthieu Baerts, Yunsheng Lin):

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
      - status: same as last time

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
      - status: same as last time

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
      - status: same as last time

13610499: [iproute2-next] ss: mptcp: print out last time counters:
      - State: Awaiting upstream
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/fd9e850f1e00691204f1dfebc63c01c6a4318c10.1711705327.git.geliang@kernel.org/
      - status: same as last time

13620951: [mptcp-next,v7,1/5] selftests/bpf: Add mptcp subflow example
13620952: [mptcp-next,v7,2/5] selftests/bpf: Support nonblock for
send_recv_data
13620953: [mptcp-next,v7,3/5] selftests/bpf: Add mptcp subflow subtest
13620954: [mptcp-next,v7,4/5] selftests/bpf: Handle SIGINT when creating
netns
13620955: [mptcp-next,v7,5/5] Squash to "selftests/bpf: Add bpf
scheduler test" 4:
      - State: New
      - Series: setsockopt per subflow: BPF
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=842404&state=*&archive=both
      - Depends on ↓

13623462: [mptcp-next,v8,1/9] selftests/bpf: Add RUN_MPTCP_TEST macro
13623463: [mptcp-next,v8,2/9] Squash to "selftests/bpf: Add bpf
scheduler test" 1 verify
13623464: [mptcp-next,v8,3/9] Squash to "selftests/bpf: Add bpf
scheduler test" 2 time
13623465: [mptcp-next,v8,4/9] Squash to "selftests/bpf: Add bpf
scheduler test" 3 MPTCP_SCHED_TEST
13623466: [mptcp-next,v8,5/9] Squash to "selftests/bpf: Add bpf_first
scheduler & test"
13623467: [mptcp-next,v8,6/9] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
13623468: [mptcp-next,v8,7/9] Squash to "selftests/bpf: Add bpf_rr
scheduler & test"
13623469: [mptcp-next,v8,8/9] Squash to "selftests/bpf: Add bpf_red
scheduler & test"
13623470: [mptcp-next,v8,9/9] Squash to "selftests/bpf: Add bpf_burst
scheduler & test":
      - State: New
      - Series: refactor mptcp bpf tests
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=843048&state=*&archive=both
      - One question for Mat: OK with the macro including a function? It
seems useful here to avoid quite a bit of duplicated code, but that's a
macro :-/
      - (no urgency here)




Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 483):

  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf]:
      - linked to a discussion we had last week: OK to setsockopt on a
subflow (tcp sock) but what about the MPTCP socket?


    Bugs (opened, flagged as "bug" and assigned)

  477  Client: fallback to TCP after X MPC [bug] @matttbe
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf]
  483  [6.1] selftests: `mptcp_connect.sh` failures with
`copyfd_io_poll: poll timed out` errors [bug] [selftests]
  476  packetdrill: coalescing feature doesn't take into account MPTCP
options [bug] [packetdrill]
  475  `simult_flows`: unbalanced bwidth tests are unstable [bug]
[selftests]
  439  mptcp vs net.ipv4.tcp_shrink_window [bug]
  416  No new subflow when removing an endpoint and adding a new one [bug]
  336  Issues with BPF packet scheduler [bug] [sched] [bpf]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose
server test` are sometimes failing [bug] [selftests]
  315  Issues with backup flow [bug]


    In Progress (opened, new feature and assigned)

  434  in-kernel PM: increase subflows limit [enhancement] [pm] @matttbe
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

None.


    Open questions (opened, questions and not assigned)

  479  when using openvpn in tcp with dco, we have a bug [question]
  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned)

  481  remove refcount on TCP sockets for the timers [enhancement]
  480  MPTCP and KTLS support [enhancement]
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
   78  notify the application (userspace) when a subflow is
added/removed [enhancement]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 2024-04-03)

  128  When the last subflow is closed without DATA_FIN and msk
Established, close msk (after a timeout) [enhancement]



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.10):
https://github.com/orgs/multipath-tcp/projects/8
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [b8672178fa4a] selftests: mptcp: simult flows: re-adapt BW
(Matthieu Baerts (NGI0)):
            - we can wait

    - Fixes for net-next:

        - [4313494ce731] selftests/bpf: Use connect_fd_to_fd in
bpf_tcp_ca (Geliang Tang)
        - [e5998d5eff9e] selftests/bpf: Drop settimeo in do_test
(Geliang Tang)
        - [9cd8c781e3c6] selftests/bpf: Add pid limit for mptcpify prog
(Geliang Tang):
            - some dependences from bpf-next tree, nothing to send

    - Features for net-next:

        - [5c7503916336] mptcp: add last time fields in mptcp_info
(Geliang Tang)
        - [a124f284aca4] selftests: mptcp: test last time mptcp_info
(Geliang Tang):
            - v2 has been sent

    - Features for net-next (next): /

    - Features for other trees:

        - [bb44c2c9b349] mptcp: add sched_data helpers (Geliang Tang)
        - [e03dfee0f098] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [38575d73d222] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [3ba497738fdd] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [1bc4c7bfa907] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [3292e65a9e9c] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [db23ab19fa3e] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [2fe598e83978] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [7dc7855f4eac] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [25602f12899c] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [9494edccead0] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [e807ab6e79d3] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [d51254fff495] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [1c755a844aca] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [95d7c37aa7ad] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [1f2c34c3051b] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - status is the same: we can wait



Extra tests:
    - news about Syzkaller? (Christoph):
        - new bug report coming

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html → still OK



mptcp.dev:
    - Matth is the new owner
    - Just in case we need, we can easily have:
        - email redirection
        - subdomains
    - It might be good to have a test server, a bit like:
        - http://test.multipath-tcp.org:5000/ → for MPTCPv1, e.g. used
with curl
        - Feel free to check that with Matth



MPTCP ideas:
    - A spreadsheet with ideas about stuff related to MPTCP: native
support in apps, etc.
    -
https://docs.google.com/spreadsheets/d/1F2-v4Dhdn0rMyJZ3m5chyNiwg7oj0rpSR11GEykatJw/edit#gid=0
    - maybe we should remove the kernel ones?
    - TODO: add apps already supporting MPTCP: → done
        - https://github.com/apache/trafficserver
        - https://github.com/envoyproxy/envoy
        - TCPDump
        - Wireshark
        - + update website: https://mux99.github.io/mptcp.dev/supported.html



Website:
    - mptcp.dev candidate:
        - mptcp.dev was lacking some useful info (what is MPTCP, how to
use it, etc.)
        - Preview: https://mux99.github.io/mptcp.dev/
        - WIP: Matth will do a first review, then create a PR to modify
mptcp.dev
        - Feel free to comment: https://github.com/mux99/mptcp.dev/

    - multipath-tcp.org candidate:
        - Preview: https://mptcp-apps.github.io/mptcp-doc/
        - WIP: Some sections are blank: to be checked first before
re-using it with multipath-tcp.org
        - Feel free to comment: https://github.com/mptcp-apps/mptcp-doc



Next meeting:
    - Next one on *Wednesday*, the 17th of April.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240417



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.

