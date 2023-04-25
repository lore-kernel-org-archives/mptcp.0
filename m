Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5948279D6
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 16:49:45 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3f09b4a1584so41315025e9.2
        for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682441384; x=1685033384;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3aEF2UlMdWnsQL9joWwLztL3Uz7RzFXeAqgeAuXyKQ=;
        b=pjmx6Vtg/7EapWZ8IxKJzwTV7oMnU0QaUBO9aIN0IWImbXds3Guu5p7J9WE741nS4T
         P0DAa8OGbR4N8O5Xk8QZQLYMjQl3d8YkLTQGWju6zsdQNXyvXQr+K84xBTOeq3xgBjL6
         +uKApOwzixz2LYI35slhqWCcFcJrnE05sw9ID0uoJIKIh+BA1cZK6jY3DPUit8RWwWR2
         1b5ZpnmwRqVqbreC3hdtO7pwOE3ZxewVGPo0Zn9AcwxGAfH+oaLPD5xC4ksd6UPZCjMF
         kA3p/BkRZGuhSvuGIxSEaaowM46NqVDqpJKTW9+K/fOQoMvvjXAcFZRYCl+LDUCzt5Yh
         YtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682441384; x=1685033384;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K3aEF2UlMdWnsQL9joWwLztL3Uz7RzFXeAqgeAuXyKQ=;
        b=du5s5YLc4J5J0hw2UWMcPXjc0tZzkE8zdJ5nG+iMeoVKyNNI/DI0x+t1qFKf+aNFr1
         MeDPb4C2fkE+ONWdqyhm54iKDqXYX2CVOY0pm/nWpyW9qbjZ1QfGEeKj+zWTZ8Lgqjwq
         iL5UYxiTr9oJNlCm0yWl1iPbFx9HqtI35Tt/mF/1Tm8PqH0uOUFgFPoPx8+fCrgZ4oFA
         UMEO6ItXPXlbabzRgpETZ4D8Y/3DbhmDZ+GddSrW0DWVAIQhwsKVTw68zMN79bPj8plF
         4BM5Emzc2Grg21T2JXCQZXvucN9/vzV3OW8ZdzJN6rVaRfWTnHy5K+wHYhqNG12zhdHc
         AEvw==
X-Gm-Message-State: AAQBX9eDIdva0bS9JbojYQRRqYFYymB4ErOFcHpCkaAb6N4ePLI4TJdf
	E9XkCOKeDPhASPES6Ls4nRC09yUDUu93PehTgcQlfg==
X-Google-Smtp-Source: AKy350bWFomG5BxnatRNnNFeFKfNIwkpxKxlsdlWtm7Yrb8Lk3b3zv7r6OTA8I3USzVpH1fX4T1i3Q==
X-Received: by 2002:a1c:7409:0:b0:3f2:4fca:1b0f with SMTP id p9-20020a1c7409000000b003f24fca1b0fmr5227159wmc.24.1682441383671;
        Tue, 25 Apr 2023 09:49:43 -0700 (PDT)
Received: from [10.124.6.89] ([195.181.172.155])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c000900b003f0aa490336sm18757416wmc.26.2023.04.25.09.49.43
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 09:49:43 -0700 (PDT)
Message-ID: <1b1a3b8b-fec8-1bd7-f9cf-42a07e17304c@tessares.net>
Date: Tue, 25 Apr 2023 18:49:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 25th of April 2023
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Today, we just had our 239th meeting with Christoph (Apple), Mat
(Cruise), Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:


Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau, Matthieu Baerts):

13214100: [net,1/2] mptcp: stops worker on unaccepted sockets at
listener close
13214101: [net,2/2] mptcp: fix accept vs worker race:
      - Series: mptcp: fixes around listening sockets and the MPTCP worker
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=740536&state=*&archive=both

13215234: [net] mailmap: add entries for Mat Martineau:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230418-upstream-net-20230418-mailmap-mat-v1-1-13ca5dc83037@tessares.net/

13216233: [net-next] MAINTAINERS: Resume MPTCP co-maintainer role:
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230418231318.115331-1-martineau@kernel.org/


    our repo (by: Matthieu Baerts):

13216614: [mptcp-next] Squash to "security, lsm: Introduce
security_mptcp_add_subflow()":
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230419101714.3347358-1-matthieu.baerts@tessares.net/

13218966: [mptcp-next,1/2] Squash to "security, lsm: Introduce
security_mptcp_add_subflow()"
13218967: [mptcp-next,2/2] Squash to "selinux: Implement
mptcp_add_subflow hook":
      - Series: Squash to "security: SELinux/LSM label with MPTCP and
accept "
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=741799&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13219019: [LSM,v2,1/2] security, lsm: Introduce security_mptcp_add_subflow()
13219020: [LSM,v2,2/2] selinux: Implement mptcp_add_subflow hook:
      - Series: security: SELinux/LSM label with MPTCP and accept
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=741812&state=*&archive=both

13222236: [6.1,1/2] mptcp: stops worker on unaccepted sockets at
listener close
13222237: [6.1,2/2] mptcp: fix accept vs worker race:
      - Series: mptcp: Stable backports for v6.1.26
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=742759&state=*&archive=both


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
      - status is the same as last week

13203764: [RFC,mptcp-net-next,1/5] tools: ynl: add uns-admin-perm to
genetlink legacy
13203766: [RFC,mptcp-net-next,2/5] tools: ynl: fix bug in case of
multiple nested attributes of the same type
13203767: [RFC,mptcp-net-next,3/5] Documentation: netlink: add a YAML
spec for mptcp
13203768: [RFC,mptcp-net-next,4/5] mptcp: uapi: add header files
generated from YAML spec
13203769: [RFC,mptcp-net-next,5/5] net/mptcp: use netlink policy
generated from YAML spec:
      - State: Changes requested
      - Series: YAML template for MPTCP netlink API
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=737723&state=*&archive=both
      - status is the same as last week

13205072: [mptcp-net,01/13] selftests: mptcp: connect: skip if MPTCP is
not supported
13205073: [mptcp-net,02/13] selftests: mptcp: pm nl: skip if MPTCP is
not supported
13205074: [mptcp-net,03/13] selftests: mptcp: join: skip if MPTCP is not
supported
13205075: [mptcp-net,04/13] selftests: mptcp: diag: skip if MPTCP is not
supported
13205076: [mptcp-net,05/13] selftests: mptcp: simult flows: skip if
MPTCP is not supported
13205077: [mptcp-net,06/13] selftests: mptcp: sockopt: skip if MPTCP is
not supported
13205078: [mptcp-net,07/13] selftests: mptcp: userspace pm: skip if
MPTCP is not supported
13205079: [mptcp-net,08/13] selftests: mptcp: lib: skip if missing symbol
13205080: [mptcp-net,09/13] selftests: mptcp: connect: skip TFO tests if
not supported
13205081: [mptcp-net,10/13] selftests: mptcp: userspace pm: skip if 'ip'
tool is unavailable
13205082: [mptcp-net,11/13] selftests: mptcp: userspace pm: skip if not
supported
13205084: [mptcp-net,12/13] selftests: mptcp: userspace pm: skip PM
listener events tests if unavailable
13205083: [mptcp-net,13/13] selftests: mptcp: join: skip PM listener
events tests if unavailable:
      - State: Changes requested
      - Series: selftests: mptcp: skip tests when features are not supported
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=738029&state=*&archive=both
      - Mat had a first look
      - Matth is working on a v2, supporting the last 2 LTS (v6.1 and v5.15)
      - v5.10 looks hard to support and probably not having enough
features to be used in prod
      - each skip will be marked as "failed" when executing the tests in
our CI because we expect to have all supported features
      - TODO: new ticket to have a CI job checking that we don't have
regressions on LTS versions → Done: #396

13208676: [mptcp-net,v3,1/2] selftests: mptcp: join: avoid using 'cmp
--bytes':
    - State: Needs review
    - Submitter: Matthieu Baerts
    - Mat will have a look

13211590: [v2,mptcp-next,1/3] mptcp: introduces more address related mibs
13211588: [v2,mptcp-next,2/3] selftests: mptcp: add explicit check for
new mibs
13211589: [v2,mptcp-next,3/3] selftests: mptcp: centralize stats dumping:
      - State: Changes requested
      - Series: mptcp: add more mibs
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=739876&state=*&archive=both

13222999: [mptcp-next,v9,1/6] mptcp: only send RM_ADDR in nl_cmd_remove
13223000: [mptcp-next,v9,2/6] selftests: mptcp: update userspace pm addr
tests
13223001: [mptcp-next,v9,3/6] mptcp: add addr into userspace pm list
13223002: [mptcp-next,v9,4/6] mptcp: export remove_anno_list_by_saddr
13223003: [mptcp-next,v9,5/6] mptcp: add addr into pm anno_list
13223004: [mptcp-next,v9,6/6] selftests: mptcp: update userspace pm
subflow tests:
      - State: Changes requested
      - Series: update userspace pm mptcp_info fields, pt 1
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=742963&state=*&archive=both



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 391):

  395  If MPTCP primary flow is over tun interface, no subflow gets
created [question]:
      - Probably an issue with the (configuration of the) PM
      - waiting for more details

  394  selftests: ability to track subtests [enhancement] [selftests]:
      - TAP 13 is used in the kselftests and it doesn't support
subtests: if one subtest fails, all the selftest is marked as failed, we
don't track subtests
      - Switch kselftests to TAP 14?
      - Or ask kselftests maintainer what to do?

  392  Problem attempting to use all my interfaces (subflows)  [question]:
      - still not clear what's wrong, waiting to get more details


    Bugs (opened, flagged as "bug" and assigned)

  373  checkpatch: `Closes` tag is no longer accepted [bug] @matttbe:
      - patches should be applied in v6.4 (see Andrew Morton's tree)

  329  PM: userspace: update `MPTCP_INFO` fields [bug] [pm] @geliangtang:
      - See patches above

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni:
      - See patches in our tree (+ sent to LSM maintainers)


    Bugs (opened and flagged as "bug" and not assigned)

  391  PM: userspace: unable to create additional subflows with the
local addr ID 0 [bug]
  384  syzkaller: KCSAN: data-race in `tcp_update_metrics` /
`tcp_update_metrics` [bug] [syzkaller] [reproducer]
  379  userspace pm: ability to send `RM_ADDR` for all local IDs used (0
included) [bug] [pm]

  378  Very noisy `addr_signal error` [bug]:
      - See patches above

  376  KASAN: slab-use-after-free Read in `ip_mc_drop_socket` [bug]
[syzkaller]

  368  selftests: skip tests not being supported by older kernels [bug]
[selftests]:
      - See patches above

  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched]
  336  Issues with BPF packet scheduler [bug]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: test 98 `fastclose test` is sometimes
failing [bug] [selftests]
  318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
cookies [bug] [selftests]
  315  Issues with backup flow [bug]
  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]


    In Progress (opened, new feature and assigned)

  353  sockopt: uniform code to get/set values [enhancement] @matttbe

  340  netlink: switch to YAML Netlink specs [enhancement] @dcaratti:
      - See patches above

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] [sched] @geliangtang:
       - see patches above

   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

  381  Why does total throughput increase when the delay on one of the
paths increases? [question] @matttbe


    Open questions (opened, questions and not assigned)

  395  If MPTCP primary flow is over tun interface, no subflow gets
created [question]
  392  Problem attempting to use all my interfaces (subflows)  [question]


    For later (opened and not assigned assigned)

  394  selftests: ability to track subtests [enhancement] [selftests]
  389  packetdrill: increase coverage for "early `close()`" cases
[enhancement] [packetdrill]
  388  sockopt: `MPTCP_TCPINFO`: add a unique ID [enhancement]
  385  ` MPTCP_INFO`: get metrics about sent/received bytes, etc. for
the MPTCP connections [enhancement]
  383  TCP_KEEPIDLE, TCP_KEEPINTVL, TCP_KEEPCNT are not implemented in
mptcp_setsockopt_sol_tcp [enhancement]
  350  scheduler: API changes (tasks) [enhancement] [sched]
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
  348  scheduler: frequently probe "stale" subflow with reinjected data
[enhancement] [sched]
  345  scheduler: "penalise" some subflows by sending less than their
cwnd [enhancement] [sched]
  344  scheduler: new callback to initiate optimisations [enhancement]
[sched]
  342  scheduler: area in the socket structures reserved for schedulers
[enhancement] [sched]
  337  in-kernel PM: listen socket: support "behind a NAT" use case
[enhancement]
  335  Server to Client subflows: option to allow joining the initial
address and port [enhancement]
  334  PM: in-kernel: send >1 ADD_ADDR before the establishment of a new
subflow [enhancement]
  333  New MIBs to help understanding issues when PM cannot create new
subflows [enhancement]
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
   79  allow 'force to MPTCP' mode: BPF [enhancement]
   78  notify the application (userspace) when a subflow is
added/removed [enhancement]
   77  [gs]etsockopt: forward to new/existing SF [enhancement]
   76  [gs]etsockopt per subflow: BPF [enhancement]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 2023-04-18)

  393  Backup function in BPF schedulers [question]
  387  Address family of server side mismatches with that of client side
[question] @matttbe
  386  syzkaller: WARNING in `__mptcp_destroy_sock` [bug] [syzkaller]
[reproducer]
  377  BUG: soft lockup in `ip_rcv` [bug] [syzkaller] [reproducer] @dcaratti
  369  syzkaller: BUG: soft lockup in `inet_release` [bug] [syzkaller]
  363  syzkaller: BUG: soft lockup in `mptcp_retransmit_timer` [bug]
[syzkaller]




FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.5):
https://github.com/orgs/multipath-tcp/projects/3/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1
    - The ChangeLog has been updated:
https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog



Patches to send to netdev:

    - Fixes for other trees: /


    - Fixes for -net: /


    - Fixes for net-next: /


    - Features for net-next:

        - [a72768c63623] inet: factor out locked section of
inet_accept() in a new helper (Paolo Abeni)
        - [7db49e7f67de] mptcp: refactor mptcp_stream_accept() (Paolo
Abeni):
            - net-next is closed

    - Features for net-next (next): /


    - Features for other trees:

        - [bcf75e108f77] security, lsm: Introduce
security_mptcp_add_subflow() (Paolo Abeni)
        - [90dcc5d50ffb] selinux: Implement mptcp_add_subflow hook
(Paolo Abeni):
            - has been sent for v6.5, not applied yet

        - [255fcd9e65a1] mptcp: refactor push_pending logic (Geliang Tang)
        - [3f24af390fb3] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [ecb755f774ff] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [3fb42ed8d849] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [5cefe6fed238] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [e8e70dd34242] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [1044021480bd] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [7c8b03b7ece1] mptcp: add scheduler wrappers (Geliang Tang)
        - [e39d185c1d04] mptcp: use get_send wrapper (Geliang Tang)
        - [28c1410e0111] mptcp: use get_retrans wrapper (Geliang Tang)
        - [702ee9e574c4] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [913cde4308a1] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [81c3747d8b6c] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [04b4bb259ce7] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [256ca88b23dd] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [0d76f4438ac6] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [b7f354e8222f] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [7c5740ff4ca8] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [ec358204f2cc] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [c605044c6691] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [a518e533ef7d] selftests/bpf: Add bpf_red test (Geliang Tang):
            - status: same as last week, waiting for rework of the
scheduler API



Extra tests:
    - news about Syzkaller? (Christoph):
        - Closing tickets!

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - /


Documentation for user:
    - It is missing, also when looking at the recent tickets we got from
users
    - update https://mptcp.dev?
    - What to do to have MPTCP working:
        - app using IPPROTO_MPTCP or mptcpize (+ go)
        - configure routing (+ why) on both the client and the server
for each additional address (if not LAN)
        - add MPTCP endpoints (+ why) for each additional address on
both the client and the server
    - What to look at in case of problems:
        - `ss -Menita` → subflows > 0 == additional subflows
        - ip mptcp endpoint
        - ip mptcp limits
        - ip rule
        - tcpdump
    - Explanations about path manager vs packet scheduler:
        - concept: we can re-use schema from slides, e.g. page 20 and 21
from
https://fosdem.org/2023/schedule/event/mptcp_upstream/attachments/slides/5786/export/events/attachments/mptcp_upstream/slides/5786/FOSDEM_23_MPTCP_Upstream.pdf
        - how it is controlled:
            - in-kernel PM vs userspace PM
            - default vs WIP BPF packet scheduler
    - Issue: using templates?
    - New ticket to track that? → TODO Matth → Done #397
    - Anybody interested by looking at that? :)



Next meeting:
    - Next one on Tuesday, the 2nd of May.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230502



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
