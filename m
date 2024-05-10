Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12541581E3
	for <mptcp@lists.linux.dev>; Fri, 10 May 2024 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333245; cv=none; b=PF8JtTw9+1mhhJLPsWdtQItqv41YjQVLWyu9X+2kRkwvKfHae1xXoosz8+ZKqCS7bVwo7D1ye+7CjKNYg9Lkv7qqkQjDO2HMZjMOlLwQ6qZ7DUr3vnhTtgx4E6VfqoKvHwMwsuW5XbIJ5TUOIJMar7tL0oFcoI7ApgCpFFK+NMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333245; c=relaxed/simple;
	bh=HVhBNidxuXHcEX3jmqyJpscOVS0VU+D8SKkae4wZ91o=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=nuCgTf2chQ0LNXxInIYnttecFyBhnx5AsNjw4tK7kikLPdTA4h8bbjGSu4oIxOQ/6z2FTFu2QBSubs9TEpUmfK96n5Q0mKqjFROcRYAwEmXjq421khb0i6QKJIOba0tOIBF5XIVfGLggZcbIlxgEPliW+eKMZpsuV8SDTDQqejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6KtOYT7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6KtOYT7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4FBC113CC
	for <mptcp@lists.linux.dev>; Fri, 10 May 2024 09:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715333244;
	bh=HVhBNidxuXHcEX3jmqyJpscOVS0VU+D8SKkae4wZ91o=;
	h=Date:To:From:Subject:From;
	b=o6KtOYT7No9PcE/B8BJQLmmc55+UN/cGkSMVWfbZ1+iV0rmiXj/BbyLE8zN/08mUV
	 4C3tDbKba1p/SoA1azIsiuNHCjqDCbLJiUwrp2YB0Beaj/nNJLGaCCMlT4qEpIFWBM
	 X3iJnuMbXGbcdWtJbL56bfznRzCyukTfE3ASmj6o+Q+ODe349t2AVn0qvnRbJ9JgSS
	 b4F3FcnY+infk1HbHFPL4vAkcSp6HW3WWmhWLqTJxSgJuRr7lGwbOLFBF5ef7+35xV
	 aPCPL0FfywzQHgqGW6FY3UUc7mjjS8uEIoecqy9GF9U6tPT3qvzAi9oKpAil440OEE
	 OXFjaoyEMfVPA==
Message-ID: <2e885332-f467-4323-8e69-5b95a4ae3a76@kernel.org>
Date: Fri, 10 May 2024 11:27:21 +0200
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
Subject: [Weekly meetings] MoM - 8th of May 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last week, we had our new meeting with Mat (Cruise), Christoph (Apple),
and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Jason Xing, Joel Granados via B4
Relay, John Hubbard, Matthieu Baerts (NGI0), Shi-Sheng Yang):

13642818: [net-next,v9,1/7] net: introduce rstreason to detect why the
RST is sent
13642819: [net-next,v9,2/7] rstreason: prepare for passive reset
13642820: [net-next,v9,3/7] rstreason: prepare for active reset
13642821: [net-next,v9,4/7] tcp: support rstreason for passive reset
13642822: [net-next,v9,5/7] mptcp: support rstreason for passive reset
13642823: [net-next,v9,6/7] mptcp: introducing a helper into active
reset logic
13642824: [net-next,v9,7/7] rstreason: make it work in trace world:
      - Series: Implement reset reason mechanism to detect
      - Submitter: Jason Xing
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=847691&state=*&archive=both

13647492: [net] mptcp: ensure snd_nxt is properly initialized on connect:
      - Submitter: Matthieu Baerts (NGI0) (Paolo Abeni)
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240429-upstream-net-20240429-mptcp-snd_nxt-init-connect-v1-1-59ceac0a7dcb@kernel.org/

13650394: [net-next,v6,0/8] sysctl: Remove sentinel elements from networking
13650393: [net-next,v6,1/8] net: Remove the now superfluous sentinel
elements from ctl_table array
13650395: [net-next,v6,2/8] net: ipv{6,4}: Remove the now superfluous
sentinel elements from ctl_table array
13650397: [net-next,v6,3/8] net: rds: Remove the now superfluous
sentinel elements from ctl_table array
13650401: [net-next,v6,4/8] net: sunrpc: Remove the now superfluous
sentinel elements from ctl_table array
13650400: [net-next,v6,5/8] net: Remove ctl_table sentinel elements from
several networking subsystems
13650396: [net-next,v6,6/8] netfilter: Remove the now superfluous
sentinel elements from ctl_table array
13650399: [net-next,v6,7/8] appletalk: Remove the now superfluous
sentinel elements from ctl_table array
13650398: [net-next,v6,8/8] ax.25: x.25: Remove the now superfluous
sentinel elements from ctl_table array:
      - Series: [net-next,v6,1/8] net: Remove the now superfluous
sentinel elements from ctl_table array
      - Submitter: Joel Granados via B4 Relay
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=849602&state=*&archive=both

13651840: [v2,net-next] mptcp: fix typos in comments:
      - Submitter: Shi-Sheng Yang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240502154740.249839-1-fourcolor4c@gmail.com/
      - Such patches not coming from big companies are OK

13655511: mptcp: fix possible NULL dereferences:
      - Submitter: Matthieu Baerts (NGI0) (Eric Dumazet)
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240506135129.3528973-2-matttbe@kernel.org/

13655640: [net] mptcp: only allow set existing scheduler for
net.mptcp.scheduler:
      - Submitter: Matthieu Baerts (NGI0) (Gegory Detal)
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240506-upstream-net-20240506-mptcp-sched-exist-v1-1-2ed1529e521e@kernel.org/

13655905: [v2] selftests/net: fix uninitialized variables:
      - Submitter: John Hubbard
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240506190204.28497-1-jhubbard@nvidia.com/


    our repo (by: Geliang Tang, Gregory Detal, Matthieu Baerts (NGI0)):

13640918: [mptcp-next,v9,1/4] selftests/bpf: Add mptcp subflow example
13640919: [mptcp-next,v9,2/4] selftests/bpf: Add mptcp subflow subtest
13640920: [mptcp-next,v9,3/4] selftests/bpf: Handle SIGINT when creating
netns
13640921: [mptcp-next,v9,4/4] Squash to "selftests/bpf: Add bpf
scheduler test":
13651699: [mptcp-next] Squash to "selftests/bpf: Add bpf scheduler test"
- drop send_data:
      - Series: setsockopt per subflow: BPF
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=847234&state=*&archive=both
      - Already sent to BPF maintainers

13648892: [mptcp-next,1/2] mptcp: only allow set existing scheduler for
net.mptcp.scheduler
13648893: [mptcp-next,2/2] mptcp: add net.mptcp.available_schedulers:
      - Series: mptcp: fix net.mptcp.scheduler behavior
      - Submitter: Gregory Detal
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=849264&state=*&archive=both
      - Patch 1 already sent to Netdev

13651925: [mptcp-next,1/4] mptcp: prefer strscpy over strcpy
13651926: [mptcp-next,2/4] mptcp: move mptcp_pm_gen.h's include
13651927: [mptcp-next,3/4] mptcp: remove unnecessary else statements
13651928: [mptcp-next,4/4] mptcp: include inet_common in mib.h:
      - Series: mptcp: Spring cleaning
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=849979&state=*&archive=both
      - Fix CLang / CheckPatch warnings

13653375: [mptcp-next] Squash to "mptcp: add bpf_mptcp_sched_ops" -- fix
bpf access:
      - Submitter: Gregory Detal
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240503-bpf_fix_access-v1-1-5a714318ea64@gmail.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Edward Liaw):

13657875: [v2,4/5] selftests: Drop define _GNU_SOURCE

    our repo (by: Geliang Tang, Matthieu Baerts, Matthieu Baerts (NGI0),
Yunsheng Lin):

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
      - skip: same status

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
      - skip: same status

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
      - skip: same status

13655427: [mptcp-next,RFC] mptcp: socket option to check for fallback:
      - State: RFC
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240506-getsockopt-tcp_is_mptcp-v1-1-4f044660f7c3@kernel.org/
      - Send this to netdev: without the RFC tag
      - Add Mat's ACK
      - TODO Matth → Done

13656189: [mptcp-net,v2] mptcp: fix the default value of scaling_ratio:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn/
      - Matth asked some questions to Geliang: the root cause is not clear
      - It is possible that scaling_ratio is linked to the issue, but it
looks strange to limit it
      - Maybe scaling_ratio is set to the max value by accident?

13656646: [bpf-next,1/4] selftests/bpf: Handle SIGINT when creating netns
13656647: [bpf-next,2/4] selftests/bpf: Add RUN_MPTCP_TEST macro
13656648: [bpf-next,3/4] selftests/bpf: Add mptcp subflow example
13656649: [bpf-next,4/4] selftests/bpf: Add mptcp subflow subtest:
      - State: Changes requested
      - Series: selftests/bpf: new MPTCP subflow subtest & improvements
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=851127&state=*&archive=both
      - We should drop patch 2
      - Patch 1 should be separated and for all BPF selftests using netns
      - Patch 3 and 4 seem OK, but need to be adapted after having
removed patch 2/4: Matth can do that directly in TopGit.
      - TODO Matth → Done (but not OK for BPF CI using IPRoute 5.5!)

13658316: [mptcp-net,1/2] mptcp: SO_KEEPALIVE: fix getsockopt support
13658317: [mptcp-net,2/2] mptcp: fix full TCP keep-alive support:
      - State: New
      - Series: mptcp: getsockopt(SO_KEEPALIVE) and TCP_KEEP* sockopts
      - Submitter: Matthieu Baerts (NGI0)
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=851490&state=*&archive=both
      - Paolo just did a review
      - Matt will send a v2
      - The idea would be to send that this week to netdev, for next,
with a Fixes tag
      - TODO Matth → done

13658789: [net-next,v3,11/13] net: replace page_frag with page_frag_cache:
    - This address one comment from Mat
    - To be reviewed → Done




Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 487):

/

    Bugs (opened, flagged as "bug" and assigned)

  487  BPF selftests fails with EAGAIN [bug] [selftests] [bpf] @geliangtang
  477  Client: fallback to TCP after X MPC [bug] @matttbe
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  383  TCP_KEEPIDLE, TCP_KEEPINTVL, TCP_KEEPCNT are not implemented in
mptcp_setsockopt_sol_tcp [enhancement] @matttbe
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

  350  scheduler: API changes (tasks) [enhancement] [sched]:
      - Gregory (Tessares) is working on it
      - RFC patches will come to start discussions
      - Extending the API seems possible, but checking if it would not
be better to break it while we can

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


    Recently closed (since 20240424)

  488  Does MPTCP support a global proxy in the middle? [question]
  294  Clear way for userspace to know if the connection fell back to
TCP [enhancement] @matttbe
   76  [gs]etsockopt per subflow: BPF [enhancement] [bpf] @geliangtang



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.10):
https://github.com/orgs/multipath-tcp/projects/8
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees: /


    - Fixes for -net:

        - [ad3ad64b961f] selftests: mptcp: simult flows: re-adapt BW
(Matthieu Baerts (NGI0))
        - [42f34e423396] mptcp: only allow set existing scheduler for
net.mptcp.scheduler (Gregory Detal):
            - sent and applied

    - Fixes for net-next: /


    - Features for net-next:

        - [c0282bcde32c] mptcp: sockopt: info: stop early if no buffer
(Matthieu Baerts (NGI0))
        - [c1b52a874e4a] mptcp: add net.mptcp.available_schedulers
(Gregory Detal)
        - [1516d8b4a848] mptcp: prefer strscpy over strcpy (Matthieu
Baerts (NGI0))
        - [082768b8a71b] mptcp: move mptcp_pm_gen.h's include (Matthieu
Baerts (NGI0))
        - [656b77aa8654] mptcp: remove unnecessary else statements
(Matthieu Baerts (NGI0))
        - [4ccf962f8cf3] mptcp: include inet_common in mib.h (Matthieu
Baerts (NGI0)):
            - Can be sent: TODO Matth → In progress
            - Should be sent this week: will likely be closed next week

    - Features for net-next (next): /


    - Features for other trees:

        - [aa0777552cf7] mptcp: add sched_data helpers (Geliang Tang)
        - [11588a1d3a08] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [b86073ebdee1] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)

        - [603674bf860f] selftests/bpf: Handle SIGINT when creating
netns (Geliang Tang):
            - To be removed from our tree (Matth: done), adapted (no
longer MPTCP specific) and sent separately to BPF

        - [3cac815b52cb] selftests/bpf: Add RUN_MPTCP_TEST macro
(Geliang Tang)
            - To be removed from our tree (Matth: done)

        - [698cf2058dea] selftests/bpf: Add mptcp subflow example
(Nicolas Rybowski)
        - [a1b677baab0a] selftests/bpf: Add mptcp subflow subtest
(Geliang Tang):
            - To be adapted and resent (Matth) → Done

        - [1622dcfffa65] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [1a8819c70ad2] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [800141f83243] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang):
            - To be adapted to remove the macro containing the helper
(Matth: done)

        - [0c6e328153ef] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [ff0e7a8f3367] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [7f3c484af108] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [2f49b51c86f2] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [0be4d21a9b29] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang)




Extra tests:
    - news about Syzkaller? (Christoph):
        - Christoph is trying to have it back

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - Packetdrill (Davide):
        - Matth opened a PR to have CLang support

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - quite stable (more than on netdev side)



Other topics:
    - Netdev conference @ Intel Santa Clara (CA, USA), 15-19 July 2024:
        - https://netdevconf.info/0x18/pages/travel.html
        - Christoph and Mat will probably be there



Next meeting:
    - Next one on *Wednesday*, the 15th of May.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240515



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.

