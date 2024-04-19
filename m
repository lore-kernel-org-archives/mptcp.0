Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E596745EF
	for <mptcp@lists.linux.dev>; Fri, 19 Apr 2024 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521744; cv=none; b=YxGj1zSYS3gjfE1HWtoY68ZHvCZo3Yaho6gZyvOctHoJj8DgW69Ap2yq2wnnwqnzGwUW5A3OQ9UZ7lMmItCW63t9XblYaQUpYz6JgqzycfqaPRQvgzS5m/YSaSGnz/0PNYBEALGhMT8EUQwnMAUzwvawh1Ypo8U+FD7JjUooFII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521744; c=relaxed/simple;
	bh=T0i7wFz10OFyFLNroH1Y3FR1d9R8IVZZgJ6Wpe/zuWY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=L0kj2BzfMMStY5ACGRwS0hFeWcgeCnBb0/8HdjT9FbhnNzGcyBdBHqUmjKzEh9MCeGYtqvFJjje27TtgjH/nMRxZfJfF/fyIlKwssJwIxISZRpMqdeJsEszuFKloZq5bFGDc1Ons8c/526fBtn/N5ox2dlsRv751gH0QPtfJ95I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnZbisXr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnZbisXr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281C4C072AA
	for <mptcp@lists.linux.dev>; Fri, 19 Apr 2024 10:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713521743;
	bh=T0i7wFz10OFyFLNroH1Y3FR1d9R8IVZZgJ6Wpe/zuWY=;
	h=Date:From:Subject:To:From;
	b=AnZbisXr1bjX0r7odwnzAjvGhy3fOF1zwHNKOJ5kuPxVy5bymYhHqv4/2SSNjDTDV
	 IYAja7ruIy7fApLZi8HkgbVDjAqg6g+H7Fv/RsMMiBNA/rKSeK+yK+0cxJd6YDgouO
	 2SinAdXKvPdQIjwM2+2KiaWOIWEFBvVsz6zdAKB4LNHbYYLiCHIqxUZBwdIwJNMEkY
	 EmwmZLJmtYEJukm6PCGK8e7mZqUPAB7VHbIA4Wdhhrunx9dWRi00fJnoHEWlx7f+hz
	 OY+I0dYxYLhbtKRGIX6DKOhvO+Wt6x4t5qa8D8N7u27Oooug7CoWjRLGrRM9Nmtpx+
	 ErLRIMwnWUiJg==
Message-ID: <1f47bb0f-59aa-4cbd-a822-0e7b2b721818@kernel.org>
Date: Fri, 19 Apr 2024 12:15:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 17th of April 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our new meeting with Mat (Cruise), Paolo, Davide (Red
Hat), Christoph (Apple), and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Matthieu Baerts):

13623989: [net-next,v2,1/2] mptcp: add last time fields in mptcp_info
13623990: [net-next,v2,2/2] selftests: mptcp: test last time mptcp_info:
      - Series: mptcp: add last time fields in mptcp_info
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=843161&state=*&archive=both

13627145: [iproute2-next] ss: mptcp: print out last time counters:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240412-upstream-iproute2-next-20240412-mptcp-last-time-info-v1-1-7985c7c395b9@kernel.org/

13625426: [bpf-next,v5,1/2] selftests/bpf: Add struct send_recv_arg
13625427: [bpf-next,v5,2/2] selftests/bpf: Export send_recv_data helper:
      - Series: export send_recv_data
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=843483&state=*&archive=both

13619223: [6.6.y,1/5] selftests: mptcp: display simult in extra_msg
13625673: [6.6.y] selftests: mptcp: use += operator to append strings:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240411100709.367235-2-matttbe@kernel.org/


    our repo (by: /):

/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Jason Xing, Joel Granados via B4
Relay, Yunsheng Lin):

13630040: [net-next,v2,13/15] net: replace page_frag with page_frag_cache:
    - State: Changes requested
    - Submitter: Yunsheng Lin
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240415131941.51153-14-linyunsheng@huawei.com/
    - Is it OK for MPTCP?
    - Mat looked at it, and it looks like it doesn't affect perfs
    - mm maintainers are asking for other changes
    - not clear if this solves anything useful/important, maybe it helps
for the maintenance?

13627914: [v3,0/4] sysctl: Remove sentinel elements from networking
13627915: [v3,1/4] networking: Remove the now superfluous sentinel
elements from ctl_table array
13627916: [v3,2/4] netfilter: Remove the now superfluous sentinel
elements from ctl_table array
13627917: [v3,3/4] appletalk: Remove the now superfluous sentinel
elements from ctl_table array
13627918: [v3,4/4] ax.25: Remove the now superfluous sentinel elements
from ctl_table array:
      - State: Changes requested
      - Series: [v3,1/4] networking: Remove the now superfluous sentinel
elements from ctl_table array
      - Submitter: Joel Granados via B4 Relay
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=844071&state=*&archive=both
      - Looks OK for MPTCP, other changes asked by netdev maintainers

13633010: [net-next,v6,1/7] net: introduce rstreason to detect why the
RST is sent
13633011: [net-next,v6,2/7] rstreason: prepare for passive reset
13633012: [net-next,v6,3/7] rstreason: prepare for active reset
13633013: [net-next,v6,4/7] tcp: support rstreason for passive reset
13633014: [net-next,v6,5/7] mptcp: support rstreason for passive reset
13633015: [net-next,v6,6/7] mptcp: introducing a helper into active
reset logic
13633016: [net-next,v6,7/7] rstreason: make it work in trace world:
      - Series: Implement reset reason mechanism to detect
      - Submitter: Jason Xing
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=845351&state=*&archive=both
      - Looks OK for MPTCP, not for netdev


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
      - status: same

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
      - status: same

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
      - status: same

13620951: [mptcp-next,v7,1/5] selftests/bpf: Add mptcp subflow example
13620952: [mptcp-next,v7,2/5] selftests/bpf: Support nonblock for
send_recv_data
13620953: [mptcp-next,v7,3/5] selftests/bpf: Add mptcp subflow subtest
13620954: [mptcp-next,v7,4/5] selftests/bpf: Handle SIGINT when creating
netns
13620955: [mptcp-next,v7,5/5] Squash to "selftests/bpf: Add bpf
scheduler test" 4:
      - State: Changes requested
      - Series: setsockopt per subflow: BPF
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=842404&state=*&archive=both
      - status: same

13630106: [mptcp-net,v2] mptcp: ensure snd_una is properly initialized
on connect:
      - State: Changes requested
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/864efc65050c64f3876e75376bbe587bdf42e2eb.1713189887.git.pabeni@redhat.com/
      - v3 is being sent, tested by Christoph

13632813: [mptcp-next,v9,1/8] selftests/bpf: Add RUN_MPTCP_TEST macro
13632814: [mptcp-next,v9,2/8] Squash to "selftests/bpf: Add bpf
scheduler test" 1 verify
13632815: [mptcp-next,v9,3/8] Squash to "selftests/bpf: Add bpf
scheduler test" 2 time
13632816: [mptcp-next,v9,4/8] Squash to "selftests/bpf: Add bpf_first
scheduler & test"
13632817: [mptcp-next,v9,5/8] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
13632818: [mptcp-next,v9,6/8] Squash to "selftests/bpf: Add bpf_rr
scheduler & test"
13632819: [mptcp-next,v9,7/8] Squash to "selftests/bpf: Add bpf_red
scheduler & test"
13632820: [mptcp-next,v9,8/8] Squash to "selftests/bpf: Add bpf_burst
scheduler & test":
      - State: New
      - Series: refactor mptcp bpf tests
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=845257&state=*&archive=both
      - v9: addressing comments from Matth and Mat
      - Looks OK for Matth (smaller function included in the macro), Mat
will also check



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 484):

  485  syzkaller: WARNING in `__mptcp_clean_una` [bug] [syzkaller]
[reproducer]:
      - Paolo has sent a patch (v3), tested by Christoph


    Bugs (opened, flagged as "bug" and assigned)

  477  Client: fallback to TCP after X MPC [bug] @matttbe
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  485  syzkaller: WARNING in `__mptcp_clean_una` [bug] [syzkaller]
[reproducer]
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


    Recently closed (since 2024-04-10)

  294  Clear way for userspace to know if the connection fell back to
TCP [enhancement] @matttbe:
      - The example was only working for a server if a client requested
to use MPTCP
      - comment has been updated



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.10):
https://github.com/orgs/multipath-tcp/projects/8
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [7dfade76849e] selftests: mptcp: simult flows: re-adapt BW
(Matthieu Baerts (NGI0)):
            - wait

    - Fixes for net-next:

        - [5f6f2a7f1137] selftests/bpf: Use connect_fd_to_fd in
bpf_tcp_ca (Geliang Tang)
        - [fd9a98c207df] selftests/bpf: Drop settimeo in do_test
(Geliang Tang)
        - [ddc6cfe25601] selftests/bpf: Add pid limit for mptcpify prog
(Geliang Tang):
            - They are in BPF-next, waiting for their PR

    - Features for net-next: /

    - Features for net-next (next): /

    - Features for other trees:

        - [cb4d08853c1b] mptcp: add sched_data helpers (Geliang Tang)
        - [63b6ab7711ad] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [c810c8ff290a] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [3df604ae4e96] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [45d2653325a4] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [562585e7cb4e] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [f90f8d6f4048] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [b6181f3b58ac] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [95e755b67736] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [78b4865ee1cb] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [44ca392704fc] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [b441d2ffc6f5] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [186d85133332] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [26ba47e0ac64] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [3eae154fd294] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [a38ea4b8419a] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - status: same: waiting for the sched refactoring



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - MIB test from Davide has been updated

    - Patchew (Davide):
        - it looks like we cannot include a diff in the comment section
of a test:
        -
https://patchew.org/MPTCP/864efc65050c64f3876e75376bbe587bdf42e2eb.1713189887.git.pabeni@redhat.com/logs/git/

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html



Network Manager:
    - ask to automatically create IP rules/routes per IP to route
packets using this source IP through the right iface?
    - they are implementing that
    - but if we use the 'ip mptcp endpoint add' with a 'device', we
don't need such rules
    - TODO: update doc → done



MPTCP (fork):
    - https://github.com/multipath-tcp/mptcp
    - should we archive the repo?
    - Best to archive it + put the link to the new implementation
    - TODO: Matth → done



LPC & netconf 2024:
    - co-located this year
    - how many days for the networking track (public) vs netconf (private)?
    - there will still be a public networking track at LPC
    - to be checked if there are stuff that need to be discussed and
related to MPTCP



mptcp.dev:
    - https://github.com/multipath-tcp/mptcp.dev/pull/2
    - It adds Cloudflare analytics, but not using cookies, nor taking
data, etc. and anyway blocked by ublock, privacy badger, Firefox
Enhanced Tracking Protection, etc.
    - plan:
        - Mat will look at it before merging → Done
        - Matth will change the routing section → Done



Next meeting:
    - Next one on *Wednesday*, the 24th of April.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240424



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.

