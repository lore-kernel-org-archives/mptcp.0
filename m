Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90294AF93
	for <mptcp@lists.linux.dev>; Thu,  7 Dec 2023 23:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLUNG5zp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C35FC433C8
	for <mptcp@lists.linux.dev>; Thu,  7 Dec 2023 23:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701992772;
	bh=AhrY1WsfMkQJWRRQLqTKMFB+XbI7W3/D4OwaeGLDP8I=;
	h=Date:From:To:Subject:From;
	b=BLUNG5zpjUeatl+X5mXZCd3jxY/Yu9SkL5QXC+DVG/rlq8g/xcP3Wq6a0VJF2ok6d
	 H+BC6yuZtd79TODAzJF+PVz2yBn1WlIx15V9fOy+cQk/9T2VILmZ5D5KNUoPIAcVMS
	 O1TWq/KqzNOCF+YGPHDsrc/4TM3vwNAgOdxT8tuj173CKd95PM7MAfi1wCPzfoxxKv
	 0xPmC3LU35SOwvGQV3HAAvCVn2egxnUOjg9/w2d5vOOpVOgthENNF95wTxkUBKBSDO
	 gkxjioQctA57s8Lf/XiJg3db6O35BzjQEgxCtCIFYCLl8Zh6gfWxT8WvA7Uc09+gzy
	 U9XxfK6/843bg==
Date: Thu, 7 Dec 2023 15:46:11 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: mptcp@lists.linux.dev
Subject: [Weekly meetings] MoM - 6th of December 2023
Message-ID: <e225059c-a008-e456-81c1-c5c58d465290@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


Hello -

Minutes from the 265th MPTCP meeting with Christoph (Apple), Davide, Paolo
(Redhat), and me (Cruise):

Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.kernel.org/project/mptcp/list/?state=3


     netdev (if mptcp ML is in cc) (by: Mat Martineau):

13471931: [net-next,v4,01/15] mptcp: add mptcpi_subflows_total counter
13471930: [net-next,v4,02/15] selftests: mptcp: add evts_get_info helper
13471932: [net-next,v4,03/15] selftests: mptcp: add chk_subflows_total 
helper
13471934: [net-next,v4,04/15] selftests: mptcp: update userspace pm test 
helpers
13471933: [net-next,v4,05/15] selftests: mptcp: userspace pm create id 0 
subflow
13471935: [net-next,v4,06/15] mptcp: userspace pm rename remove_err to out
13471936: [net-next,v4,07/15] selftests: mptcp: userspace pm remove 
initial subflow
13471937: [net-next,v4,08/15] selftests: mptcp: userspace pm send RM_ADDR 
for ID 0
13471938: [net-next,v4,09/15] selftests: mptcp: add mptcp_lib_kill_wait
13471939: [net-next,v4,10/15] selftests: mptcp: add mptcp_lib_is_v6
13471941: [net-next,v4,11/15] selftests: mptcp: add mptcp_lib_get_counter
13471940: [net-next,v4,12/15] selftests: mptcp: add missing oflag=append
13471942: [net-next,v4,13/15] selftests: mptcp: add mptcp_lib_make_file
13471943: [net-next,v4,14/15] selftests: mptcp: add 
mptcp_lib_check_transfer
13471944: [net-next,v4,15/15] selftests: mptcp: add 
mptcp_lib_wait_local_port_listen:
       - Series: mptcp: More selftest coverage and code cleanup for 
net-next
       - Submitter: Mat Martineau
       - URL: 
https://patchwork.kernel.org/project/mptcp/list/?series=805045&state=*&archive=both


     our repo (by: Geliang Tang, Matthieu Baerts, Paolo Abeni):

13455483: [mptcp-net,v2] selftests: mptcp: join: fix subflow_send_ack 
lookup:
       - Submitter: Geliang Tang
       - URL: 
https://patchwork.kernel.org/project/mptcp/patch/f343a6ca7d627b4092a284dbc6724f34e6f8c491.1699973683.git.geliang.tang@suse.com/

13465106: [mptcp-net,v2] mptcp: fix inconsistent state on fastopen race:
       - Submitter: Paolo Abeni
       - URL: 
https://patchwork.kernel.org/project/mptcp/patch/7237df51ca90d9692f133823a3a6071ee87ba02d.1700667812.git.pabeni@redhat.com/

13465107: [mptcp-net-next] mptcp: cleanup state propagation.:
       - Submitter: Paolo Abeni
       - URL: 
https://patchwork.kernel.org/project/mptcp/patch/240a97d522887a938faeb24a6a3e3a9ed24570b1.1700667908.git.pabeni@redhat.com/

13469926: [mptcp-net] mptcp: fill in missing MODULE_DESCRIPTION():
       - Submitter: Matthieu Baerts
       - URL: 
https://patchwork.kernel.org/project/mptcp/patch/20231127-mptcp-module-desc-v1-1-d2209921bf9e@kernel.org/



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.kernel.org/project/mptcp/list/?state=*


     netdev (if mptcp ML is in cc) (by: Geliang Tang):

13474261: [iproute2-next] ss: mptcp: print out subflows_total counter:
       - Submitter: Geliang Tang
       - URL: 
https://patchwork.kernel.org/project/mptcp/patch/ecf501dce539b4cc77e450d510c0414eec4bba7f.1701344289.git.geliang.tang@linux.dev/


     our repo (by: Davide Caratti, Geliang Tang, Matthieu Baerts, Maxim 
Galaganov):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to 
tcp.h/mptcp.h
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

13294008: [iperf3] add MPTCPv1 support:
       - State: Changes requested
       - Submitter: Geliang Tang
       - URL: 
https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/

13305089: [mptcp-next,1/6] mptcp: sockopt: move tcp_inq code to a 
dedicated function
13305091: [mptcp-next,2/6] mptcp: sockopt: update supported list
13305093: [mptcp-next,3/6] mptcp: sockopt: get val in a generic way
13305090: [mptcp-next,4/6] mptcp: sockopt: add missing getsockopt() 
options
13305094: [mptcp-next,5/6] mptcp: sockopt: set val in a generic way
13305092: [mptcp-next,6/6] mptcp: sockopt: support IP_TTL & 
IPV6_UNICAST_HOPS:
       - State: Changes requested
       - Series: mptcp: sockopt: uniform code to get/set values
       - Submitter: Matthieu Baerts
       - URL: 
https://patchwork.kernel.org/project/mptcp/list/?series=763505&state=*&archive=both

13441631: [mptcp-next] net/mptcp: don't overwrite sock_ops in 
mptcp_is_tcpsk():
       - State: Changes requested
       - Submitter: Davide Caratti
       - URL: 
https://patchwork.kernel.org/project/mptcp/patch/a2581b975c0c5bec417b2dd5e0b014acd7770e14.1698764762.git.dcaratti@redhat.com/

13471233: [mptcp-next,v13,01/32] mptcp: export pm_nl_get_pernet_from_msk
13471234: [mptcp-next,v13,02/32] mptcp: drop mptcp_pm_get_* helpers
13471235: [mptcp-next,v13,03/32] mptcp: use pernet id_bitmap in userspace 
pm
13471236: [mptcp-next,v13,04/32] mptcp: add userspace_pm_lookup_addr_by_id 
helper
13471239: [mptcp-next,v13,05/32] mptcp: drop lookup_by_id parameter in 
lookup_addr
13471240: [mptcp-next,v13,06/32] mptcp: dump addrs in userspace pm list
13471241: [mptcp-next,v13,07/32] mptcp: check userspace pm subflow flag
13471242: [mptcp-next,v13,08/32] selftests: mptcp: add userspace pm 
subflow flag
13471243: [mptcp-next,v13,09/32] selftests: mptcp: add mptcp_lib_cleanup 
helper
13471244: [mptcp-next,v13,10/32] selftests: mptcp: netlink: drop duplicate 
var ret
13471245: [mptcp-next,v13,11/32] selftests: mptcp: export ret into 
mptcp_lib
13471246: [mptcp-next,v13,12/32] selftests: mptcp: add 
mptcp_lib_check_output
13471247: [mptcp-next,v13,13/32] selftests: mptcp: dump userspace addrs 
list
13471248: [mptcp-next,v13,14/32] mptcp: set set_id flag when parsing addr
13471249: [mptcp-next,v13,15/32] mptcp: use set_id flag when appending 
addr
13471250: [mptcp-next,v13,16/32] mptcp: check addrs list in 
userspace_pm_get_local_id
13471251: [mptcp-next,v13,17/32] selftests: mptcp: dump after creating id 
0 subflow
13471252: [mptcp-next,v13,18/32] mptcp: make pm_remove_addrs_and_subflows 
static
13471253: [mptcp-next,v13,19/32] mptcp: add a prefix for 
free_local_addr_list
13471254: [mptcp-next,v13,20/32] mptcp: add mptcp_pm_remove_subflows 
helper
13471255: [mptcp-next,v13,21/32] mptcp: rm addrs and subflows before free 
local list
13471256: [mptcp-next,v13,22/32] mptcp: flush userspace pm addrs list
13471257: [mptcp-next,v13,23/32] selftests: mptcp: flush userspace addrs 
list
13471258: [mptcp-next,v13,24/32] mptcp: add use_id parameter for 
addresses_equal
13471259: [mptcp-next,v13,25/32] mptcp: add check_id for 
lookup_anno_list_by_saddr
13471260: [mptcp-next,v13,26/32] mptcp: add userspace_pm_get_entry helper
13471261: [mptcp-next,v13,27/32] mptcp: drop addr_match and id_match
13471262: [mptcp-next,v13,28/32] mptcp: dup an entry when removing it
13471263: [mptcp-next,v13,29/32] mptcp: add userspace pm addr entry 
refcount
13471264: [mptcp-next,v13,30/32] selftests: mptcp: rm userspace addr with 
random order
13471265: [mptcp-next,v13,31/32] mptcp: map v4 address to v6 when 
destroying subflow
13471266: [mptcp-next,v13,32/32] selftests: mptcp: rm subflow with 
v4/v4mapped addr:
       - State: Needs ack
       - Series: userspace pm enhancements
       - Submitter: Geliang Tang
       - URL: 
https://patchwork.kernel.org/project/mptcp/list/?series=804889&state=*&archive=both

13472614: [mptcp-next,v3,1/5] mptcp: add mib counter dec helper
13472615: [mptcp-next,v3,2/5] mptcp: add a current established counter
13472616: [mptcp-next,v3,3/5] mptcp: add mptcp_set_state helper
13472617: [mptcp-next,v3,4/5] mptcp: use mptcp_set_state
13472618: [mptcp-next,v3,5/5] selftests: mptcp: join: check CURRESTAB 
counters:
13479430: [mptcp-next] Squash to "selftests: mptcp: join: check CURRESTAB 
counters":

       - State: Needs ack
       - Series: add MPTCP_MIB_CURRESTAB
       - Submitter: Geliang Tang
       - URL: 
https://patchwork.kernel.org/project/mptcp/list/?series=805216&state=*&archive=both

13472703: [v2,mptcp-next,1/3] mptcp: rename 
mptcp_setsockopt_sol_ip_set_transparent()
13472716: [v2,mptcp-next,2/3] mptcp: sockopt: support IP_LOCAL_PORT_RANGE 
and IP_BIND_ADDRESS_NO_PORT
13472730: [v2,mptcp-next,3/3] selftests/net: add MPTCP coverage for 
IP_LOCAL_PORT_RANGE:
       - State: Queued
       - Series: more sockopts for ephemeral ports
       - Submitter: Maxim Galaganov
       - URL: 
https://patchwork.kernel.org/project/mptcp/list/?series=805233&state=*&archive=both
       - Waiting on "Use READ/WRITE_ONCE() for IP local_port_range." to be 
merged in net-next, will require v3
       - TODO: Matth will apply that (was waiting for the CI to double 
check, done now but there are conflicts between net and next to fix, will 
be done later: 
https://lore.kernel.org/netdev/20231206110306.01e91114@canb.auug.org.au/)

13479469: [mptcp-next,v5,01/33] selftests: mptcp: add mptcp_lib_evts_* 
helpers
13479470: [mptcp-next,v5,02/33] selftests: mptcp: userspace: capitalize 
test_name
13479472: [mptcp-next,v5,03/33] selftests: mptcp: userspace: print colored 
output
13479471: [mptcp-next,v5,04/33] selftests: mptcp: capitalize ok/fail/skip
13479473: [mptcp-next,v5,05/33] selftests: mptcp: extract 
mptcp_lib_check_expected
13479474: [mptcp-next,v5,06/33] selftests: mptcp: export event macros in 
mptcp_lib
13479475: [mptcp-next,v5,07/33] selftests: mptcp: add 
mptcp_lib_verify_listener_events
13479476: [mptcp-next,v5,08/33] selftests: mptcp: unify namespace names
13479477: [mptcp-next,v5,09/33] selftests: mptcp: add mptcp_lib_ns_* 
helpers
13479478: [mptcp-next,v5,10/33] selftests: mptcp: add ss mptcp support 
checks
13479479: [mptcp-next,v5,11/33] selftests: mptcp: add 
mptcp_lib_check_tools helper
13479480: [mptcp-next,v5,12/33] selftests: mptcp: diag: print colored 
output
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
13479486: [mptcp-next,v5,18/33] selftests: mptcp: connect: print out test 
counter
13479487: [mptcp-next,v5,19/33] selftests: mptcp: rename test_cnt to 
TEST_COUNT
13479488: [mptcp-next,v5,20/33] selftests: mptcp: diag: print out test 
counter
13479489: [mptcp-next,v5,21/33] selftests: mptcp: simult flows: print out 
test counter
13479490: [mptcp-next,v5,22/33] selftests: mptcp: sockopt: print out test 
counter
13479491: [mptcp-next,v5,23/33] selftests: mptcp: netlink: print out test 
counter
13479492: [mptcp-next,v5,24/33] selftests: mptcp: userspace: print out 
test counter
13479493: [mptcp-next,v5,25/33] selftests: mptcp: export TEST_NAME/COUNT 
to mptcp_lib
13479494: [mptcp-next,v5,26/33] selftests: mptcp: simult flows: define 
missing vars
13479495: [mptcp-next,v5,27/33] selftests: mptcp: export cin/cout/sin/sout 
vars
13479496: [mptcp-next,v5,28/33] selftests: mptcp: join: change 
capture/checksum as bool
13479497: [mptcp-next,v5,29/33] selftests: mptcp: export capture/checksum 
vars
13479498: [mptcp-next,v5,30/33] selftests: mptcp: diag: change 
timeout_poll to 30
13479499: [mptcp-next,v5,31/33] selftests: mptcp: export timeout_test to 
mptcp_lib
13479500: [mptcp-next,v5,32/33] selftests: mptcp: use KSFT_SKIP instead 
ksft_skip
13479501: [mptcp-next,v5,33/33] selftests: mptcp: use KSFT_PASS and 
KSFT_FAIL:
       - State: New
       - Series: add helpers and vars in mptcp_lib.sh
       - Submitter: Geliang Tang
       - URL: 
https://patchwork.kernel.org/project/mptcp/list/?series=806904&state=*&archive=both

13479590: [mptcp-next,v2] mptcp: don't overwrite sock_ops in 
mptcp_is_tcpsk():
       - State: New
       - Submitter: Davide Caratti
       - URL: 
https://patchwork.kernel.org/project/mptcp/patch/20231205091221.2657807-1-dcaratti@redhat.com/



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from the last meeting: 464):

   466  syzkaller: v6.1.65 KASAN: use-after-free Read in 
`mptcp_subflow_queue_clean` [bug] [syzkaller] [reproducer] [bisected]
- Older kernel, Paolo pretty sure we already fixed but the correct fix 
needs to be backported to 6.1 (maybe fixes tag issue, or patch didn't 
apply cleanly)
- Not sure who has time to work on this yet
- Looking for fix for 6.1 LTS
- Christoph will try to reproduce on net-next
   465  syzkaller: v6.1.60 - refcount_t: addition on 0; use-after-free 
[bug] [syzkaller] [reproducer] [bisected]
      - Christoph say same root cause as 466
   464  `TCP_NOTSENT_LOWAT` socket-option support [enhancement] @pabeni
      - Paolo has patches in local tree, but more work needed as MPTCP does 
not maintain a MPTCP-level snd_nxt has different meaning from the 
TCP-level one (difference between the next sequence number to apply to a 
MPTCP mapping vs the next seq to send on the wire).
      - Trying to figure out a solution that does not involve adding 
another locking operation. Might be able to reuse MPTCP-level data lock.
   463  syzkaller: INFO: task hung in `lock_sock_nested` [bug] [syzkaller]
   459  Are the endpoint flags `signal` and `subflow` meant to be 
exclusive? or how to get MPTCP to work for both directions? [question]
      - New comment


     Bugs (opened, flagged as "bug" and assigned)

   451  syzkaller: possible deadlock in` __dev_queue_xmit` [bug] 
[syzkaller] @dcaratti
   435  in-kernel PM: fullmesh: too many paths are being created [bug] 
@matttbe
   343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug] 
[sched] @geliangtang


     Bugs (opened and flagged as "bug" and not assigned)

   466  syzkaller: v6.1.65 KASAN: use-after-free Read in 
`mptcp_subflow_queue_clean` [bug] [syzkaller] [reproducer] [bisected]
   465  syzkaller: v6.1.60 - refcount_t: addition on 0; use-after-free 
[bug] [syzkaller] [reproducer] [bisected]
   463  syzkaller: INFO: task hung in `lock_sock_nested` [bug] [syzkaller]
   449  `MPTcpExtMPCapableFallbackACK` - looks surprising [bug]
   445  MPTCP Info counters: start seq numbers ones from 0 [bug]
   439  mptcp vs net.ipv4.tcp_shrink_window [bug]
   416  No new subflow when removing an endpoint and adding a new one [bug]
   336  Issues with BPF packet scheduler [bug] [sched] [bpf]
   325  selftests: `mptcp_join`: test 18 `signal addresses race test` is 
sometimes failing [bug] [selftests]
   324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose server 
test` are sometimes failing [bug] [selftests]
   318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN 
cookies [bug] [selftests]
   315  Issues with backup flow [bug]


     In Progress (opened, new feature and assigned)

   464  `TCP_NOTSENT_LOWAT` socket-option support [enhancement] @pabeni
   460  Add `MPTCP_MIB_CURRESTAB` similar to TCP [enhancement] @geliangtang
   432  Rename `mptcp_is_tcpsk()` helper [enhancement] @dcaratti
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

   462  selftests: print (and set?) random seed [enhancement] [selftests]
   461  Protocol: extend Data-Level Length field [enhancement]
   453  sk_is_mptcp() only works with struct tcp_sock * [enhancement]
   448  Allow sending ADD_ADDR IPv6 with port-number if TCP-timestamps are 
enabled [enhancement]
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
   345  scheduler: "penalise" some subflows by sending less than their cwnd 
[enhancement] [sched]
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
   332  scheduler: implement a "opportunistic retransmission" [enhancement] 
[sched]
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
    78  notify the application (userspace) when a subflow is added/removed 
[enhancement]
    77  [gs]etsockopt: forward to new/existing SF [enhancement]
    76  [gs]etsockopt per subflow: BPF [enhancement] [bpf]
    57  After a few attempts of failed MPTCP, directly fallback to TCP for 
new connections [enhancement]
    43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag interface 
[enhancement] [syzkaller]
    41  reduce indirect call usage [enhancement]
    24  Revisit layout of struct mptcp_subflow_context [enhancement]


     Recently closed (since 2023-11-29)

   458  syzkaller: `WARNING` in `subflow_data_ready` [bug] [syzkaller]
   447  syzkaller: possible deadlock in `sk_clone_lock` [bug] [syzkaller]



FYI: Current Roadmap:
     - Bugs: 
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
     - Current/Coming merge window (6.8): 
https://github.com/orgs/multipath-tcp/projects/6
     - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to netdev:

     - Fixes for other trees:


     - Fixes for -net:

         - [bd68003e4ad4] selftests: mptcp: join: fix subflow_send_ack 
lookup (Geliang Tang)
         - [eb322afc208b] mptcp: fix inconsistent state on fastopen race 
(Paolo Abeni)
         - [e9491266e923] mptcp: fill in missing MODULE_DESCRIPTION() 
(Matthieu Baerts)
            - Let them sit in the export branch a little long - send next 
week.

     - Fixes for net-next:


     - Features for net-next:

         - [9f7492f23251] mptcp: cleanup state propagation (Paolo Abeni)

     - Features for net-next (next):


     - Features for other trees:

         - [eae650b39c42] mptcp: add sched_data helpers (Geliang Tang)
         - [5c1b0942d422] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
         - [9cea4586b963] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
         - [445878802d05] selftests/bpf: Add mptcp sched structs (Geliang 
Tang)
         - [f352889a6fb2] selftests/bpf: Add bpf scheduler test (Geliang 
Tang)
         - [1cb0d3d42184] selftests/bpf: Add bpf_first scheduler (Geliang 
Tang)
         - [2c8f88398697] selftests/bpf: Add bpf_first test (Geliang Tang)
         - [b64b154b7a65] selftests/bpf: Add bpf_bkup scheduler (Geliang 
Tang)
         - [fa8c6a264307] selftests/bpf: Add bpf_bkup test (Geliang Tang)
         - [fc7cc1e7f61f] selftests/bpf: Add bpf_rr scheduler (Geliang 
Tang)
         - [d70145271499] selftests/bpf: Add bpf_rr test (Geliang Tang)
         - [d29304c08b52] selftests/bpf: Add bpf_red scheduler (Geliang 
Tang)
         - [82de6b5fc403] selftests/bpf: Add bpf_red test (Geliang Tang)
         - [3a7f44f398d5] bpf: Export more bpf_burst related functions 
(Geliang Tang)
         - [f8c4f7bc20ad] selftests/bpf: Add bpf_burst scheduler (Geliang 
Tang)
         - [ca783a436f3b] selftests/bpf: Add bpf_burst test (Geliang Tang)



Extra tests:
     - news about Syzkaller? (Christoph):
         - Covered by issues filed in the last week

     - news about interop with mptcp.org/other stacks? (?):
         - N/A

     - packetdrill (Davide):
         - N/A

     - Patchew (Davide):
         - N/A

     - CI (Matth):
         - Jakub is working on running selftests for netdev patches using 
virtme
         - Also planning (longer term) to run tests provided by vendors
    - May be able to reuse some ideas/architecture to work around Cirrus CI 
limits - netdev work is using Github Actions



Next meeting: the 13th (Wednesday) of December at 16:30 UTC (8.30am PST, 
5.30pm CET, 12.30am CST)
Link next meeting: 
https://annuel2.framapad.org/p/mptcp_upstreaming_20231213
