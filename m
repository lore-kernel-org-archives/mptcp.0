Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A48F26295
	for <mptcp@lists.linux.dev>; Tue, 26 Sep 2023 10:55:45 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2c02e232c48so143689491fa.1
        for <mptcp@lists.linux.dev>; Tue, 26 Sep 2023 03:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1695725744; x=1696330544; darn=lists.linux.dev;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZRQpQKZiFpzNbQQ3zOCXfTZ4ycUMw06U7reI9ONqIg=;
        b=a9cRATiBhkmi+jn6itbMO9Z/AoaFSpr5gS6DOkv+rawNs2/GP531izgv1TTXStGZ3S
         CL1NFcU1zDYcoBOjmmsFItzT74OkeUHZl1ZkkgHUG8JrsnXbXtqsjGfbe6R/Pn8SKlTO
         ntiCY5C5I7/WQTfkUSTx4o3ZA7EZgQlL103BxXTIYzPkBbxJNP+Co4Ai3OMHjKFakfzv
         xGcV7btaTuBZyWZtmobn4whEtzExbYL/ByBb1h28qOo7+KMxJ1C5kNCSv6bOfrtLDQX5
         bwK3SHiwEzq9nzw/d9zD4K70WtsfNaJDxhZ2N/TLLYvooe5f6wQ9C/IUJvmZFDiteBnQ
         gx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695725744; x=1696330544;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZRQpQKZiFpzNbQQ3zOCXfTZ4ycUMw06U7reI9ONqIg=;
        b=oPBYEeWTf1Of3WRYX11siZnGojdovRJb1SCxqYQ5MJPg9ciKDAHcYwmZQ8FQC2LWZ7
         udiukhUF945Hz4Fgo9cciFzQeRzS3J62sqwr7qx/7yNNbIUmeNt8MhUcVD820yW7kcRU
         hTEqvr2dnjfKAPS8C09h6FdSefatCYgewk6pZCfVdJYXmBk8NPdaAvaEgylJFyU0WMBz
         cB9G59htFiiutyAzl7RcyNNVnQysT1LzWUonxbHGupPsumkifGX9grAQ3Lj1RN+I/Rqy
         q2enzXpxgHjvMgP2yz33pw8Q8wdLF5sHeVdUo0x3zosdNmJeMPdo/boSvEvq2pJt0ENj
         UdBg==
X-Gm-Message-State: AOJu0YzSiIDrlfECVlsbZoAoVB9Mr0ikW6JC6Sz4JngWL/bzao4SDwru
	6iOYzlYYhCRFk+ISV/FvOMSG1hK4R1ptUKiIPojYxaHy
X-Google-Smtp-Source: AGHT+IEc8Ao5imvbsGWI9I/fMb3o6m5nTLgfo9/kfexZwW/9FEhUOFLcmt6rqnS8zMZlUBLqgkq0dA==
X-Received: by 2002:a2e:320b:0:b0:2bc:d7d6:2588 with SMTP id y11-20020a2e320b000000b002bcd7d62588mr7831923ljy.17.1695725743327;
        Tue, 26 Sep 2023 03:55:43 -0700 (PDT)
Received: from [100.65.141.57] ([149.36.51.146])
        by smtp.gmail.com with ESMTPSA id z15-20020a170906944f00b00993928e4d1bsm7592018ejx.24.2023.09.26.03.55.42
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 03:55:43 -0700 (PDT)
Message-ID: <86ddb693-33d5-41f0-94fe-6df6ec919494@tessares.net>
Date: Tue, 26 Sep 2023 12:55:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, fr-BE
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 19th of September 2023
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last week, we had our 257th meeting with Christoph (Apple), Paolo,
Davide (Redhat) and myself (Tessares).


Thanks again for this new good meeting (and sorry for the delay)!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

13388290: [net,1/5] mptcp: fix bogus receive window shrinkage with
multiple subflows
13388291: [net,2/5] mptcp: move __mptcp_error_report in protocol.c
13388292: [net,3/5] mptcp: process pending subflow error on close
13388293: [net,4/5] mptcp: rename timer related helper to less confusing
names
13388294: [net,5/5] mptcp: fix dangling connection hang-up:
      - Series: mptcp: fix stalled connections
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=784913&state=*&archive=both


    our repo (by: Geliang Tang, Paolo Abeni):

13373652: [mptcp-next,v3,1/9] Squash to "bpf: Export more bpf_burst
related functions"
13373653: [mptcp-next,v3,2/9] Squash to "mptcp: add sched_data helpers"
13373654: [mptcp-next,v3,3/9] Squash to "bpf: Add bpf_mptcp_sched_ops"
13373655: [mptcp-next,v3,4/9] Squash to "selftests/bpf: Add mptcp sched
structs"
13373656: [mptcp-next,v3,5/9] Squash to "selftests/bpf: Add bpf_first
scheduler"
13373657: [mptcp-next,v3,6/9] Squash to "selftests/bpf: Add bpf_bkup
scheduler"
13373658: [mptcp-next,v3,7/9] Squash to "selftests/bpf: Add bpf_rr
scheduler"
13373659: [mptcp-next,v3,8/9] Squash to "selftests/bpf: Add bpf_red
scheduler"
13373660: [mptcp-next,v3,9/9] Squash to "selftests/bpf: Add bpf_burst
scheduler":
      - Series: BPF packet scheduler updates part 4
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=781468&state=*&archive=both

13379155: [mptcp-next,v3] mptcp: add a new sysctl for make after break
timeout:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/fe8c2c5502b7a924bdcba6621486e1e68861f9fd.1694426964.git.pabeni@redhat.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

/


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

13374479: [mptcp-next,v3,1/6] tools: ynl: add uns-admin-perm to
genetlink legacy
13374483: [mptcp-next,v3,2/6] net: mptcp: convert netlink from small_ops
to ops
13374482: [mptcp-next,v3,3/6] Documentation: netlink: add a YAML spec
for mptcp
13374481: [mptcp-next,v3,4/6] uapi: mptcp: use header file generated
from YAML spec
13374484: [mptcp-next,v3,5/6] net: mptcp: rename netlink handlers to
mptcp_pm_nl_<blah>_{doit,dumpit}
13374485: [mptcp-next,v3,6/6] net: mptcp: use policy generated by YAML spec:
      - State: Changes requested
      - Series: mptcp: convert netlink code to use YAML spec
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=781665&state=*&archive=both

13386450: [mptcp-next,v2] ss: mptcp: print out subflows_total counter:
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/3ca520a2ce84c33ad8f9421add0b717091173a22.1694763872.git.geliang.tang@suse.com/
      - New counters to take into acount the initial subflow (and avoid
confusions with 'mptcpi_subflows'

13387087: [v3,mptcp-next,1/3] mptcp: consolidate sockopt synchronization
13387088: [v3,mptcp-next,2/3] mptcp: ignore notsent_lowat setting at the
subflow level.
13387089: [v3,mptcp-next,3/3] mptcp: refactor sndbuf auto-tuning.:
      - State: New
      - Series: mptcp: misc improvement
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=784615&state=*&archive=both
      - issue 437
      - the person who created the ticket didn't have the opportunity to
test them yet (backport issues)
      - This series reveals an race condition, almost impossible to
trigger but now a fix is needed (for -net). Paolo is looking at that as well
      - Pending following: currently we don't handle notsend_lowat
option correctly → probably refactoring needed around forwarding mem
accounting in both direction ; that will help to properly handle
notsend_lowat.

13390713: [mptcp-next,v2,01/30] mptcp: drop useless ssk in
pm_subflow_check_next
13390714: [mptcp-next,v2,02/30] mptcp: use mptcp_check_fallback helper
13390715: [mptcp-next,v2,03/30] mptcp: use mptcp_get_ext helper
13390716: [mptcp-next,v2,04/30] mptcp: use mptcp_wnd_end helper
13390717: [mptcp-next,v2,05/30] mptcp: move sk assignment statement ahead
13390718: [mptcp-next,v2,06/30] mptcp: define more local variables sk
13390719: [mptcp-next,v2,07/30] selftests: mptcp: sockopt: drop
mptcp_connect var
13390720: [mptcp-next,v2,08/30] selftests: mptcp: display simult in
extra_msg
13390721: [mptcp-next,v2,09/30] mptcp: add mptcpi_subflows_total counter
13390722: [mptcp-next,v2,10/30] selftests: mptcp: add chk_subflows_total
helper
13390723: [mptcp-next,v2,11/30] selftests: mptcp: add evts_get_info helper
13390724: [mptcp-next,v2,12/30] selftests: mptcp: update userspace pm
test helpers
13390725: [mptcp-next,v2,13/30] selftests: mptcp: userspace pm remove id
0 subflow
13390726: [mptcp-next,v2,14/30] mptcp: userspace pm allow creating id 0
subflow
13390727: [mptcp-next,v2,15/30] selftests: mptcp: userspace pm create id
0 subflow
13390728: [mptcp-next,v2,16/30] mptcp: userspace pm remove id 0 address
13390729: [mptcp-next,v2,17/30] selftests: mptcp: userspace pm remove id
0 address
13390730: [mptcp-next,v2,18/30] mptcp: add userspace_pm_get_entry helper
13390731: [mptcp-next,v2,19/30] mptcp: add userspace pm addr entry refcount
13390732: [mptcp-next,v2,20/30] mptcp: add netlink pm addr entry refcount
13390733: [mptcp-next,v2,21/30] selftests: mptcp: add userspace pm
fullmesh tests
13390734: [mptcp-next,v2,22/30] selftests: mptcp: add mptcp_lib_kill_wait
13390735: [mptcp-next,v2,23/30] selftests: mptcp: add mptcp_lib_evts_*
13390736: [mptcp-next,v2,24/30] selftests: mptcp: userspace: print
colored results
13390737: [mptcp-next,v2,25/30] selftests: mptcp: add
mptcp_lib_verify_listener_events
13390738: [mptcp-next,v2,26/30] selftests: mptcp: add mptcp_lib_is_v6
13390739: [mptcp-next,v2,27/30] selftests: mptcp: add mptcp_lib_get_counter
13390740: [mptcp-next,v2,28/30] selftests: mptcp: add mptcp_lib_make_file
13390741: [mptcp-next,v2,29/30] selftests: mptcp: add
mptcp_lib_check_transfer
13390742: [mptcp-next,v2,30/30] selftests: mptcp: add
mptcp_lib_wait_local_port_listen:
      - State: New
      - Series: userspace pm enhancements
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=785426&state=*&archive=both
      - Matth will try to look at that




Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 438):

  440  in-kernel PM: re-establish subflows after "network" errors
[enhancement] [pm]:
      - some middleboxes could drop some connections, e.g. NAT → we
could see RST
      - Or timeout (blackhole)
      - It can be interesting to try re-establishing subflows

  439  mptcp vs net.ipv4.tcp_shrink_window:
      - MPTCP cannot work well with tcp_shrink_window
      - This is a netns option, we cannot easily disable it for MPTCP
      - Maybe easier to document it then


    Bugs (opened, flagged as "bug" and assigned)

  435  in-kernel PM: fullmesh: too many paths are being created [bug]
@matttbe
  391  PM: userspace: unable to create additional subflows with the
local addr ID 0 [bug] [pm] @geliangtang
  379  userspace pm: ability to send `RM_ADDR` for all local IDs used (0
included) [bug] [pm] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  438  syzkaller: possible deadlock in `sk_clone_lock` [bug] [syzkaller]
  437  mptcp vs tcp performance over long fat networks [bug]
  420  syzkaller: WARNING in `__mptcp_move_skbs_from_subflow` [bug]
[syzkaller]
  416  No new subflow when removing an endpoint and adding a new one [bug]

  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched]:
      - Suggestion from Geliang:
          - How about invoking __mptcp_push_pending() right after
mptcp_pm_nl_work() in mptcp_worker()?
          → Doesn't seem OK:
              - we don't want to do such thing frmo the mptcp_worker (we
need to limit the work)
              - the scheduler might need to react each time an ACK/RTO
happens: more frequently than when the worker is invoked()

  336  Issues with BPF packet scheduler [bug] [sched] [bpf]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose
server test` are sometimes failing [bug] [selftests]
  318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
cookies [bug] [selftests]
  315  Issues with backup flow [bug]


    In Progress (opened, new feature and assigned)

  432  Rename `mptcp_is_tcpsk()` helper [enhancement] @dcaratti
  428  `mptcp_info`: expose if the initial subflow has been removed /
total number of subflows [enhancement] @geliangtang
  403  userspace pm: local_addr_list: use a refcount per entry
[enhancement] [pm] @geliangtang
  353  sockopt: uniform code to get/set values [enhancement] @matttbe
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang
  340  netlink: switch to YAML Netlink specs [enhancement] @dcaratti
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

  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned assigned)


  440  in-kernel PM: re-establish subflows after "network" errors
[enhancement] [pm]
  439  mptcp vs net.ipv4.tcp_shrink_window
  436  Supports redundant backup transmission of multiple subflows
[enhancement] [sched]
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


    Recently closed (since 2023-09-12)

  430  MPTCP connections are hanging when all subflows have been closed
by timeout [bug] @pabeni
  424  KMemLeak around `__register_sysctl_table` [bug]
  398  syzkaller: memory leak in `subflow_ulp_init` [bug] [syzkaller]




FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.7):
https://github.com/orgs/multipath-tcp/projects/5
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to netdev:

    - Fixes for other trees:

        - [42f2f3c6a998] workqueue: Remove duplicate worqueue attributes
allocation (Catalin Marinas)
        - [331b8093b2e2] rcu: kmemleak: Ignore kmemleak false positives
when RCU-freeing objects (Catalin Marinas):
            - handled somewhere else

    - Fixes for -net: /

    - Fixes for net-next:

        - [117a2f6ab521] bpf: Fix bpf_throw warning on 32-bit arch
(Kumar Kartikeya Dwivedi):
            - handled by the BPF maintainers

    - Features for net-next:

        - [edafb2ce850c] mptcp: add a new sysctl for make after break
timeout (Paolo Abeni):
            - can wait for other patches that are almost ready

    - Features for net-next (next): /

    - Features for other trees:

        - [60cc39e3c8d2] mptcp: add sched_data helpers (Geliang Tang)
        - [baa07787b329] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [a5a1c685012e] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [1af7502e8a97] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [fe1028b08c1a] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [f8613794eb4d] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [a46f84ad893c] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [b986a6850b0e] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [f9a9d190b19f] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [ee7c4f61a226] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [050e52e7a063] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [980f65bc3af3] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [510b3d55bb23] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [3706c644ffb4] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [074165e1df0c] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [2f04ae778ab1] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - waiting for a refactoring of the scheduler API



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - Some new features in run_all.py:
            - limit tests in parallel with -P → it seems to improve the
situation for the CI
            - possibility to capture packets with -c
            - possibility to have more debug from packetdrill with extra -v
            → will upstream them later after some feedback

    - Patchew (Davide):
        - /

    - CI (Matth):
        - better now with packetdrill tests with the -P option
        - recent issue with simult_flow selftest



FOSDEM 24?:
    - could be good to demonstrate what MPTCP can do now that it is
easily accessible:
        - on a smartphone
        - or a laptop?
    - looks difficult to suggest a devroom



Next meeting:
    - /!\ We skip the one of next week (26th of September) /!\
    - Next one on Tuesday, the 3rd of October.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20231003



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
