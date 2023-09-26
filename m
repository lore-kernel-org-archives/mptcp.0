Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25B71A5AF
	for <mptcp@lists.linux.dev>; Tue, 26 Sep 2023 10:51:16 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-99357737980so1031090066b.2
        for <mptcp@lists.linux.dev>; Tue, 26 Sep 2023 03:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1695725474; x=1696330274; darn=lists.linux.dev;
        h=content-transfer-encoding:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJbKzAuexqOAQPw5Hr6Fjw/x3QT/LyAQOev+FoO1nZw=;
        b=SbvrEDDtuSFkZNAxwztemhe2AaimqUV1tPRVyHbPeQUFOe6c3UXdV38X8ugbshURS3
         rEHLJ69+VZEdbDziSaD8E6I0OtU6BPUl1UQQUFiVor1sJGve/mlmfRrWyuCHQ1DjZsz4
         nMsymYxyP+6Gt+lPCThi8HG9uzw0ILqPiOmm3Uqp+aXAcTPKwtJFNcknI1pFXA3mos+7
         chBMS2/BmzyKyBngzP+3mx14L8W7d6abZd5dRAgpAlIeX+7ZnxZBYzc1yg0iT5nyPozi
         /kRXMIGspkgJapFQJs/ncOBYXgt1x4YeJ5MnPwTF6+0M884MzorM6TbdsvmTa5IjzL0l
         Rdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695725474; x=1696330274;
        h=content-transfer-encoding:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJbKzAuexqOAQPw5Hr6Fjw/x3QT/LyAQOev+FoO1nZw=;
        b=mAHEaXe+dwxFH0s22V+/1yLecUTarRAVocjwjedQUFdbE42UKO3ZAfAu96mS5zhmcm
         awXxPW5tp3KGZdwrM16qNcC+WxkmChI6nFFThEE1eHjgF/dXWo7MPXepIKJrO0oRdfnK
         mw1ZS/V6cTaFv6ih4xaKxYDrRD3/CmXbSiUJ6S+BZvd/i6X8zdtSIkJhGEyvgTZK/TxV
         rDEBeeU0/jFon3GcsQHRNLIf48WsIpWbOOlKnSCt9oEhbyTa4BNc40pvylt1BUnHsHPX
         EwBF4m7xERk4pmdVcPs4237kc8V+r8406W9aG/+hQKwjGLeMmB9iUq2wOJOVV//Vners
         x7UA==
X-Gm-Message-State: AOJu0YwKrsV01iasKS07Gw67MYHvGF8Mvaz1ehT/wQoKfwgbxp9HXm5F
	LFgZeb9FX3cQbn8FEYXYnS5jUxQ1e3dbcaoZ3dLSJx2a
X-Google-Smtp-Source: AGHT+IFtmoi5HtViDhJ5tVCidDXXIbpvd+71nWAzUUzcjSk1OXCKED6e82QOo5mVtKlwcYs7E2qWsw==
X-Received: by 2002:a17:907:3d94:b0:9a1:edfd:73bb with SMTP id he20-20020a1709073d9400b009a1edfd73bbmr10084788ejc.47.1695725474293;
        Tue, 26 Sep 2023 03:51:14 -0700 (PDT)
Received: from [10.125.30.26] ([194.110.115.70])
        by smtp.gmail.com with ESMTPSA id w27-20020a17090633db00b009a2235ed496sm7757500eja.141.2023.09.26.03.51.13
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 03:51:13 -0700 (PDT)
Message-ID: <03478d60-9738-41b6-aa86-cfcb4f87c286@tessares.net>
Date: Tue, 26 Sep 2023 12:51:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 29th of August 2023
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

A few weeks ago, we had our 255th meeting with Paolo, Davide (Redhat),
Mat (Cruise) and myself (Tessares).


Thanks again for this new good meeting (and sorry for the delay)!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau, Matthieu Baerts):

13359867: [net-next,01/10] mptcp: refactor push_pending logic
13359870: [net-next,02/10] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
13359868: [net-next,03/10] mptcp: add struct mptcp_sched_ops
13359869: [net-next,04/10] mptcp: add a new sysctl scheduler
13359873: [net-next,05/10] mptcp: add sched in mptcp_sock
13359872: [net-next,06/10] mptcp: add scheduled in mptcp_subflow_context
13359871: [net-next,07/10] mptcp: add scheduler wrappers
13359876: [net-next,08/10] mptcp: use get_send wrapper
13359875: [net-next,09/10] mptcp: use get_retrans wrapper
13359874: [net-next,10/10] mptcp: register default scheduler:
      - Series: mptcp: Prepare MPTCP packet scheduler for BPF extension
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=778020&state=*&archive=both

13361726: [iproute2,1/3] ss: mptcp: display info counters as unsigned
13361727: [iproute2,2/3] ss: mptcp: display seq related counters as decimal
13361728: [iproute2,3/3] ss: mptcp: print missing info counters:
      - Series: ss: mptcp: print new info counters
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=778453&state=*&archive=both


    our repo (by: /):

/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

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

13321790: [mptcp-next,1/5] tools: ynl: add uns-admin-perm to genetlink
legacy
13321794: [mptcp-next,2/5] mptcp: convert netlink from small_ops to ops
13321791: [mptcp-next,3/5] Documentation: netlink: add a YAML spec for mptcp
13321792: [mptcp-next,4/5] mptcp: uapi: use header file generated from
YAML spec
13321793: [mptcp-next,5/5] net: mptcp: use policy generated by YAML spec:
      - State: Changes requested
      - Series: convert MPTCP to use YAML spec
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=768188&state=*&archive=both
      - Status: same as last week

13357448: [mptcp-next,v3,1/5] Squash to "selftests/bpf: Add bpf_bkup
scheduler"
13357449: [mptcp-next,v3,2/5] Squash to "selftests/bpf: Add bpf_rr
scheduler"
13357450: [mptcp-next,v3,3/5] Squash to "selftests/bpf: Add bpf_burst
scheduler"
13357451: [mptcp-next,v3,4/5] selftests/bpf: Add bpf_stale scheduler
13357452: [mptcp-next,v3,5/5] selftests/bpf: Add bpf_stale test:
      - State: Needs ack
      - Series: add bpf_stale scheduler
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=777313&state=*&archive=both
13362024: [mptcp-next,v2] Squash to "selftests/bpf: Add bpf_stale
scheduler, v3":
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/bc154bf23639cfb4c59e6b1f593cbd0772095603.1692787403.git.geliang.tang@suse.com/
      - Status: to be reviewed

13361788: [mptcp-net] mptcp: fix bogus receive window shrinkage with
multiple subflows:
      - State: Queued
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/0c7094b27ef199973d1fb3a8c5b29ebe0b48a659.1692778671.git.pabeni@redhat.com/
      - TODO: Matth: apply it → Done

13361799: [v2,mptcp-net,1/2] mptcp: move __mptcp_error_report in protocol.c
13361800: [v2,mptcp-net,2/2] mptcp: process pending subflow error on close:
      - State: Queued
      - Series: mptcp: fix missing close transition
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=778482&state=*&archive=both
      - TODO: Matth: apply them → Done

13362132: [RFC,mptcp-next,v2,1/2] mptcp: add set/get params wrappers
13362133: [RFC,mptcp-next,v2,2/2] mptcp: add bpf_burst set/get params:
      - State: New
      - Series: BPF packet scheduler updates part 4
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=778574&state=*&archive=both
13364233: [mptcp-next,v2] Squash to "mptcp: add bpf_burst set/get params":
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/ea7a8cdb1b7f606503998bd156e2732815c2d528.1692885554.git.geliang.tang@suse.com/
      - To be checked: maybe it doesn't fit with the scheduler
refactoring we have discussed before?
      - We can also organise a meeting at a different time if it is
easier for Geliang to discuss about his plans

13367522: [mptcp-next,v7,1/7] selftests: mptcp: add evts_get_info helper
13367523: [mptcp-next,v7,2/7] selftests: mptcp: update userspace pm test
helpers
13367524: [mptcp-next,v7,3/7] selftests: mptcp: userspace pm remove id 0
subflow
13367525: [mptcp-next,v7,4/7] mptcp: userspace pm allow creating id 0
subflow
13367526: [mptcp-next,v7,5/7] selftests: mptcp: userspace pm create id 0
subflow
13367527: [mptcp-next,v7,6/7] mptcp: userspace pm remove id 0 address
13367528: [mptcp-next,v7,7/7] selftests: mptcp: userspace pm remove id 0
address:
      - State: New
      - Series: userspace pm remove id 0 subflow & address
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=779802&state=*&archive=both
13368779: [mptcp-next] Squash to "selftests: mptcp: update userspace pm
test helpers, v7":
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/013071003d63b701c3529ce344d70578d22b5fef.1693303834.git.geliang.tang@suse.com/
      - Matth will look at the new version

13367817: [mptcp-next,1/2] mptcp: rename timer related helper to less
confusing names
13367818: [mptcp-next,2/2] mptcp: implement connection level timeout.:
      - State: New
      - Series: mptcp: fix another close hang-up
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=779909&state=*&archive=both
      - Fixing issue 430 & 431
      - There is a packetdrill test but it takes 1 minute to wait for
the timeout:
          - could be configurable but involved other stuffs: not for net




Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 428):

  432  Rename `mptcp_is_tcpsk()` helper [enhancement]:
      - linked to a patch from Eric Dumazet looking at places where
sock->ops is modified
      - This helper can modify it but it is strange to do this
modification with this name
      - Linked to that, it might be interesting to do some refactoring
around mptcp_accept() and mptcp_stream_accept() but not trivial before
one has to be done after having acquired a lock and not the other one.

  431  new mptcp connections stuck in SYN-SENT:
      - basically the same as #430 except that the status is in SYN-SENT
but the required fix is the same
      - TODO: marked as duplicated? → Done

  430  MPTCP connections are hanging when all subflows have been closed
by timeout [bug]:
      - see patches above: mptcp: fix another close hang-up
      - the patches are a bit invasive but we don't see any other
solutions for stable without breaking the ability to create new subflows
after the removal of the last one.

  429  Missing close transition [bug] @pabeni:
      - was part of #427 but a different issue
      - see patches: mptcp: fix missing close transition


    Bugs (opened, flagged as "bug" and assigned)

  429  Missing close transition [bug] @pabeni:
      - see ↑

  427  connections hanging after a long transfer [bug] @pabeni:
      - see patch above: mptcp: fix bogus receive window shrinkage with
multiple subflows

  391  PM: userspace: unable to create additional subflows with the
local addr ID 0 [bug] [pm] @geliangtang:
      - See patches above

  379  userspace pm: ability to send `RM_ADDR` for all local IDs used (0
included) [bug] [pm] @geliangtang:
      - See patches above


    Bugs (opened and flagged as "bug" and not assigned)

  430  MPTCP connections are hanging when all subflows have been closed
by timeout [bug]:
      - see ↑
      - TODO: assign to Paolo → Done

  424  KMemLeak around `__register_sysctl_table` [bug]:
      - the public CI had this issue this week, last time was 3 weeks ago

  420  syzkaller: WARNING in `__mptcp_move_skbs_from_subflow` [bug]
[syzkaller]
  416  No new subflow when removing an endpoint and adding a new one [bug]

  398  syzkaller: memory leak in `subflow_ulp_init` [bug] [syzkaller]:
      - TODO: ask Christoph if he asked KMemleak maintainer about that →
Done

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

  403  userspace pm: local_addr_list: use a refcount per entry
[enhancement] [pm] @geliangtang

  353  sockopt: uniform code to get/set values [enhancement] @matttbe:
      - See patches above

  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang:
      - See patches above

  340  netlink: switch to YAML Netlink specs [enhancement] @dcaratti:
      - See patches above

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe:
      - See patches above

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang
      - See patches above

   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang


    Assigned Questions (opened, questions and assigned)

None.


    Open questions (opened, questions and not assigned)

  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned assigned)

  432  Rename `mptcp_is_tcpsk()` helper [enhancement]
  428  `mptcp_info`: expose if the initial subflow has been removed /
total number of subflows [enhancement]
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


    Recently closed (since 2023-08-22)

  415  ss: display new counters from v6.5 [enhancement] [iproute2]
  413  Question: Transport Converters for non-MPTCP end devices [question]
   79  allow 'force to MPTCP' mode: BPF [enhancement] [bpf] @geliangtang



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.6):
https://github.com/orgs/multipath-tcp/projects/4/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1
    - TODO: Matth: update changelog and next project → Done



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net: /

    - Fixes for net-next: /

    - Features for net-next: /

    - Features for net-next (next): /

    - Features for other trees:

        - [b7e792d19d16] mptcp: add sched_data helpers (Geliang Tang)
        - [6e4503b48eed] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [954b1ac62b1e] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [128443034b40] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [ae7d4d62a81d] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [1d261e9556f3] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [1c7a896edbb0] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [43b47cd6876b] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [be273f3dbec0] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [7262f3f0a004] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [a24cc09f771d] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [127b218a4b79] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [52318dc89229] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [ff4b86905da5] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [ffe58ab09a22] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [27ac983ba28d] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - wait for a refactoring of the packet scheduler API first
before sending them




Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - New PR: looks good but waiting for kernel patches to be
applied first

    - Patchew (Davide):
        - /

    - CI (Matth):
        - TODO: Matth: do the modifications asked last week → done
        - Quick fix: reduce the frequency we launch the "nightly" sync +
build → 2 to 3 times a week → TODO Matth → done



Next meeting:
    - /!\ We skip the one of next week (5th of September) /!\
    - Next one on Tuesday, the 12th of September.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230912



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
