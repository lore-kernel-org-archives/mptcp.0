Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD60F6128
	for <mptcp@lists.linux.dev>; Tue,  4 Jul 2023 18:55:21 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-98e109525d6so1072708466b.0
        for <mptcp@lists.linux.dev>; Tue, 04 Jul 2023 11:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688496919; x=1691088919;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCb45cv34B4CfWUuJ9f15PP7uTW3LfjHSxzxU+OtUhE=;
        b=p5XRDi4alEI8sZCNm7G6xcp0QxWT0JONL+UjUFzu0s+jybuU5rXobuzu/9SJGarmqR
         SsWzfYzOTSHydNuOWvShx8C8zquuG/EHAWopT3zFw3WuwcQyUmzuFiekJWarnElmV07h
         tBdydKN5eLWPYryZ4mvSII1e/EcuZrlzGAuRq/AZmAbZm21+JRtx9wePKTtY1uJH8J4P
         LkKl/wCgHdk+5TYuMox0bNJX7PyvGSl9cRhIkFuxMNPlkFIG1s0IKC6ImHVXf0CtBKvd
         ejxDOKrImp7CVA8lumAYOr+LJb3CZL+gKZXxd6++3sH2os5mOHKMKRIauohf0wO/cgC8
         JeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688496919; x=1691088919;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FCb45cv34B4CfWUuJ9f15PP7uTW3LfjHSxzxU+OtUhE=;
        b=kTinLsljuLTTZwKByKac7bQqXsgSnD5Dvc/Oc964opEin1M3aWTnKRLxI5hDkOLCV+
         VkqmpN3TG886Gu2FGoFoEFfMnKDxSuwiMY1ObU+3GxyafCI7vOyPzCr10OVBFn81JK18
         1aR4dTvCguaE+CREILUQGuzGsVty3MeXelnmfRvOi2OJcLd4az9RMt03kG8g7WrlAY8a
         PDS+Lw8IL/M11akYY/0u2OW2KEmh0iKcfR5StAkClQt8L/LcumNWNPo4QdrdBjHY/FG1
         Qr70Vc/ViMWd3NAjWO1t56bcQA+7gLP9PpSumKDtE6u5U8bw+hFwPPvOVCVOIJx/9rlf
         B5Tw==
X-Gm-Message-State: ABy/qLbOntexCqTQxpBkaNLC6JzRvouAKy3o+LBlX9IvnkHp/Ytv5+rm
	pKThMp6eiWRsO+tyy6XMTVABynp9LViXubF5Fjylkg==
X-Google-Smtp-Source: APBJJlENYIIWQ0qEqbBTPvIU+AXN6MT+NLgCkOm5X6mF+HHHuyvCqrM4XH6tngdSWHGth+14eVTD4w==
X-Received: by 2002:a17:907:9809:b0:988:8efc:54fa with SMTP id ji9-20020a170907980900b009888efc54famr95265ejc.37.1688496918942;
        Tue, 04 Jul 2023 11:55:18 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:7acd:ebd4:27c4:aac4? ([2a02:578:8593:1200:7acd:ebd4:27c4:aac4])
        by smtp.gmail.com with ESMTPSA id lc1-20020a170906f90100b00988e953a586sm13678972ejb.61.2023.07.04.11.55.18
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 11:55:18 -0700 (PDT)
Message-ID: <e7ea339c-f907-7bd5-cd21-ceaf8e42df97@tessares.net>
Date: Tue, 4 Jul 2023 20:55:17 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 4th of July 2023
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello everyone,

Today, we just had our 248th meeting with... myself (Tessares) :)


Thanks again for this new good meeting!

Here are the minutes of the meeting:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13294516: [5.15.y] mptcp: fix possible divide by zero in recvmsg():
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230627132510.2265333-1-matthieu.baerts@tessares.net/

13294517: [5.15.y] mptcp: consolidate fallback and non fallback state
machine:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230627132557.2266416-1-matthieu.baerts@tessares.net/


    our repo (by: Geliang Tang, Matthieu Baerts, Paolo Abeni):

13287750: [mptcp-next,01/18] selftests: mptcp: connect: fail if nft
supposed to work
13287754: [mptcp-next,02/18] selftests: mptcp: sockopt: use
'iptables-legacy' if available
13287752: [mptcp-next,03/18] selftests: mptcp: sockopt: return error if
wrong mark
13287753: [mptcp-next,04/18] selftests: mptcp: userspace_pm: use correct
server port
13287755: [mptcp-next,05/18] selftests: mptcp: userspace_pm: report
errors with 'remove' tests
13287756: [mptcp-next,06/18] selftests: mptcp: connect: don't stop if error
13287757: [mptcp-next,07/18] selftests: mptcp: userspace pm: don't stop
if error
13287758: [mptcp-next,08/18] selftests: mptcp: userspace_pm: fix
shellcheck warnings
13287760: [mptcp-next,09/18] selftests: mptcp: userspace_pm: uniform
results printing
13287759: [mptcp-next,10/18] selftests: mptcp: userspace_pm: reduce dup
code around printf
13287761: [mptcp-next,11/18] selftests: mptcp: lib: format subtests
results in TAP
13287762: [mptcp-next,12/18] selftests: mptcp: connect: format subtests
results in TAP
13287763: [mptcp-next,13/18] selftests: mptcp: pm_netlink: format
subtests results in TAP
13287765: [mptcp-next,14/18] selftests: mptcp: join: format subtests
results in TAP
13287764: [mptcp-next,15/18] selftests: mptcp: diag: format subtests
results in TAP
13287766: [mptcp-next,16/18] selftests: mptcp: simult flows: format
subtests results in TAP
13287767: [mptcp-next,17/18] selftests: mptcp: sockopt: format subtests
results in TAP
13287768: [mptcp-next,18/18] selftests: mptcp: userspace_pm: format
subtests results in TAP:
      - Series: selftests: mptcp: format subtests results in TAP
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=759227&state=*&archive=both

13295586: [mptcp-net] mptcp: do not rely on implicit state check in
mptcp_listen():
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/9a42270be1b4d109351b22ad0331bab8051803fb.1687951613.git.pabeni@redhat.com/

13297522: [mptcp-next,v2,1/4] selftests: mptcp: set all env vars as
local ones
13297523: [mptcp-next,v2,2/4] selftests: mptcp: add fastclose env var
13297524: [mptcp-next,v2,3/4] selftests: mptcp: add fullmesh env var
13297525: [mptcp-next,v2,4/4] selftests: mptcp: add speed env var:
      - Series: update userspace pm mptcp_info fields part 3
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=761392&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Andrea Claudi, Davide Caratti, Geliang Tang, Matthieu
Baerts, Paolo Abeni):

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
      - Status: same as last week

13282183: [mptcp-next,v20,09/10] selftests: mptcp: pass fastclose to sflags
13282184: [mptcp-next,v20,10/10] selftests: mptcp: set endpoint out of
transfer:
      - State: Changes requested
      - Series: update userspace pm mptcp_info fields part 2
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=757748&state=*&archive=both
      - can be archived

13290474: [net,1/2] selftests: mptcp: join: fix 'delete and re-add' test
13290475: [net,2/2] selftests: mptcp: join: fix 'implicit EP' test:
      - State: Changes requested
      - Series: selftests: fix mptcp_join test
      - Submitter: Andrea Claudi
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=759793&state=*&archive=both
      - Status: same as last week

13293650: [mptcp-next,v11,01/11] Squash to "mptcp: drop last_snd and
MPTCP_RESET_SCHEDULER"
13293651: [mptcp-next,v11,02/11] Squash to "mptcp: add struct
mptcp_sched_ops"
13293652: [mptcp-next,v11,03/11] Squash to "mptcp: add
sched_data_set_contexts helper"
13293653: [mptcp-next,v11,04/11] mptcp: register default scheduler
13293654: [mptcp-next,v11,05/11] Squash to "bpf: Add bpf_mptcp_sched_ops"
13293655: [mptcp-next,v11,06/11] Squash to "bpf: Add
bpf_mptcp_sched_kfunc_set"
13293656: [mptcp-next,v11,07/11] Squash to "selftests/bpf: Add mptcp
sched structs"
13293657: [mptcp-next,v11,08/11] Squash to "selftests/bpf: Add bpf_first
scheduler"
13293658: [mptcp-next,v11,09/11] Squash to "selftests/bpf: Add bpf_bkup
scheduler"
13293659: [mptcp-next,v11,10/11] Squash to "selftests/bpf: Add bpf_rr
scheduler"
13293660: [mptcp-next,v11,11/11] Squash to "selftests/bpf: Add bpf_red
scheduler":
      - State: Queued
      - Series: BPF packet scheduler updates part 1
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=760451&state=*&archive=both
      - can be applied
      - TODO: Matth

13293682: [mptcp-next,01/10] Squash to "selftests/bpf: Add bpf_first test"
13293683: [mptcp-next,02/10] selftests/bpf: Add bpf_first test
13293684: [mptcp-next,03/10] Squash to "selftests/bpf: Add bpf_bkup test"
13293685: [mptcp-next,04/10] Squash to "selftests/bpf: Add bpf_rr test"
13293686: [mptcp-next,05/10] Squash to "selftests/bpf: Add bpf_red test"
13293687: [mptcp-next,06/10] selftests/bpf: Add bpf_stale scheduler
13293688: [mptcp-next,07/10] selftests/bpf: Add bpf_stale test
13293689: [mptcp-next,08/10] bpf: Export more bpf_burst related functions
13293690: [mptcp-next,09/10] selftests/bpf: Add bpf_burst scheduler
13293691: [mptcp-next,10/10] selftests/bpf: Add bpf_burst test:
      - State: Needs ack
      - Series: BPF packet scheduler updates part 2
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=760457&state=*&archive=both

13294008: [iperf3] add MPTCPv1 support:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/

13294657: [RFC,mptcp-next,v2] mptcp: convert netlink from small_ops to ops:
      - State: Needs ack
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/ed9c7f0320bb94a4a147d11c447cefa59f128ee1.1687877390.git.dcaratti@redhat.com/

13294844: [mptcp-net] mptcp: fix bogus socket state update:
      - State: Rejected
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/4e3c5d0b8d30cd8aa36ba591be38e5ca8958edf9.1687886219.git.pabeni@redhat.com/

13295886: [mptcp-next,1/2] selftests: mptcp: join: rework detailed report
13295887: [mptcp-next,2/2] selftests: mptcp: join: colored results:
      - State: New
      - Series: selftests: mptcp: format subtests results in TAP (part 2)
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=760963&state=*&archive=both

13297167: [mptcp-net] selftests: mptcp: depend on SYN_COOKIES:
      - State: New
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230629170551.3043312-1-matthieu.baerts@tessares.net/
      - can be probably applied

13299615: [mptcp-next,v3,1/5] Squash to "selftests/bpf: add two mptcp
netns helpers"
13299616: [mptcp-next,v3,2/5] net: socket: add socket_create wrapper
13299617: [mptcp-next,v3,3/5] bpf: Add bpf_mptcpify helper
13299618: [mptcp-next,v3,4/5] selftests/bpf: Test bpf_mptcpify helper
13299634: [mptcp-next,v3,5/5] selftests/bpf: Add mptcpify selftest:
      - State: New
      - Series: BPF 'force to MPTCP'
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=761906&state=*&archive=both
      - What if bpf_mptcpize() is called from the wrong hook?

13300566: [mptcp-next] Squash to 'Squash to "selftests/bpf: Add
bpf_rrscheduler" v11':
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/0b57bf87dc30e15782ba1fe2e925a7ce6ef0fc90.1688434547.git.geliang.tang@suse.com/
      - Addressing Paolo's comment

13301320: [RFC,mptcp-next,v2] Documentation: netlink: add a YAML spec
for mptcp:
      - State: New
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/d462c557c05d60a217f14ff77cd9702ed3ccf2c5.1688481634.git.dcaratti@redhat.com/



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from the last meeting: 416):

  417  Verifier blocks access to tcp_sock fields:
     - To be replied


    Bugs (opened, flagged as "bug" and assigned)

None.


    Bugs (opened and flagged as "bug" and not assigned)

  400  packetdrill: data are retransmitted after the `close()` [bug]
[packetdrill]:
     - Issue with 9p, Matth is tracking it

  398  syzkaller: memory leak in `subflow_ulp_init` [bug] [syzkaller]
  391  PM: userspace: unable to create additional subflows with the
local addr ID 0 [bug]
  379  userspace pm: ability to send `RM_ADDR` for all local IDs used (0
included) [bug] [pm]
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched]
  336  Issues with BPF packet scheduler [bug]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose
server test` are sometimes failing [bug] [selftests]
  318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
cookies [bug] [selftests]
  315  Issues with backup flow [bug]
  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]


    In Progress (opened, new feature and assigned)

  403  userspace pm: local_addr_list: use a refcount per entry
[enhancement] [pm] @geliangtang
  353  sockopt: uniform code to get/set values [enhancement] @matttbe
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang
  342  scheduler: area in the socket structures reserved for schedulers
[enhancement] [sched] @geliangtang
  340  netlink: switch to YAML Netlink specs [enhancement] @dcaratti
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   79  allow 'force to MPTCP' mode: BPF [enhancement] @geliangtang
   75  BPF: packet scheduler [enhancement] [sched] @geliangtang
   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

  381  Why does total throughput increase when the delay on one of the
paths increases? [question] @matttbe


    Open questions (opened, questions and not assigned)

  413  Question: Transport Converters for non-MPTCP end devices [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]
  395  If MPTCP primary flow is over tun interface, no subflow gets
created [question]
  392  Problem attempting to use all my interfaces (subflows)  [question]


    For later (opened and not assigned assigned)

  417  Verifier blocks access to tcp_sock fields
  416  reestablishment on reconnecting mainflow ifaces and tap ifaces
  415  ss: display new counters from v6.5 [enhancement] [iproute2]
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


    Recently closed (since 2023-06-27)

  414  syzkaller: divide error in `__tcp_select_window` [bug] [syzkaller]
  368  selftests: skip tests not being supported by older kernels [bug]
[selftests] @matttbe



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.6):
https://github.com/orgs/multipath-tcp/projects/4/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1



Patches to send to netdev:

    - Fixes for other trees:

        - [d5fd185ae4a3] sysctl: fix unused proc_cap_handler() function
warning (net) (Arnd Bergmann):
            - new fix already applied in Linus' tree but not in -net yet

        - [02c843a41bad] Revert "Merge tag '9p-6.4-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs" (Matthieu
Baerts):
            - still under investigation by a 9p maintainer

    - Fixes for -net:

        - [2715d61049f5] mptcp: ensure subflow is unhashed before
cleaning the backlog (Paolo Abeni)
        - [9bdda48f8015] mptcp: do not rely on implicit state check in
mptcp_listen() (Paolo Abeni)
        - [63cb6fd295d4] selftests: mptcp: connect: fail if nft supposed
to work (Matthieu Baerts)
        - [c22f9b0d51bb] selftests: mptcp: sockopt: use
'iptables-legacy' if available (Matthieu Baerts)
        - [3eb2195485ea] selftests: mptcp: sockopt: return error if
wrong mark (Matthieu Baerts)
        - [f93fa9292460] selftests: mptcp: userspace_pm: use correct
server port (Matthieu Baerts)
        - [36068d190ced] selftests: mptcp: userspace_pm: report errors
with 'remove' tests (Matthieu Baerts):
            - TODO: Matth: send them

    - Fixes for net-next: /

    - Features for net-next: (net-next is closed)

        - [beab49752604] selftests: mptcp: set all env vars as local
ones (Geliang Tang)
        - [b72f1c9304cb] selftests: mptcp: add fastclose env var
(Geliang Tang)
        - [10fad33fddc0] selftests: mptcp: add fullmesh env var (Geliang
Tang)
        - [3c0394eb50c4] selftests: mptcp: add speed env var (Geliang Tang)
        - [4ea789ff2d48] selftests: mptcp: connect: don't stop if error
(Matthieu Baerts)
        - [3c2b1e960b8c] selftests: mptcp: userspace pm: don't stop if
error (Matthieu Baerts)
        - [ab2a14c42688] selftests: mptcp: userspace_pm: fix shellcheck
warnings (Matthieu Baerts)
        - [0d6701f6e5e3] selftests: mptcp: userspace_pm: uniform results
printing (Matthieu Baerts)
        - [e05b7f68723d] selftests: mptcp: userspace_pm: reduce dup code
around printf (Matthieu Baerts)
        - [4c43087cd91c] selftests: mptcp: lib: format subtests results
in TAP (Matthieu Baerts)
        - [36e313a615bf] selftests: mptcp: connect: format subtests
results in TAP (Matthieu Baerts)
        - [9b7813a1de3d] selftests: mptcp: pm_netlink: format subtests
results in TAP (Matthieu Baerts)
        - [02e178a771e3] selftests: mptcp: join: format subtests results
in TAP (Matthieu Baerts)
        - [ca87864963fa] selftests: mptcp: diag: format subtests results
in TAP (Matthieu Baerts)
        - [7c5743fd78e6] selftests: mptcp: simult flows: format subtests
results in TAP (Matthieu Baerts)
        - [1b5839cc2803] selftests: mptcp: sockopt: format subtests
results in TAP (Matthieu Baerts)
        - [0c61d6192992] selftests: mptcp: userspace_pm: format subtests
results in TAP (Matthieu Baerts)

    - Features for net-next (next): /

    - Features for other trees:

        - [1f303634fa48] mptcp: refactor push_pending logic (Geliang Tang)
        - [7e3f3e7d2e20] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [9d110fa68f4a] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [81697eb4c3fd] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [c1aaa9f8fa1b] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [b52002dfe058] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [a5d64728d655] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [354928b01dad] mptcp: add scheduler wrappers (Geliang Tang)
        - [fc5e7097efc7] mptcp: use get_send wrapper (Geliang Tang)
        - [5463dd1ef962] mptcp: use get_retrans wrapper (Geliang Tang)
        - [7cb75016d05f] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [f65b0bb57f77] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [1613e026ab1e] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [965ed315b4e4] selftests/bpf: use random netns name for mptcp
(Geliang Tang)
        - [e56d3e8828ba] selftests/bpf: add two mptcp netns helpers
(Geliang Tang)
        - [5f9a5578cf81] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [7a41aceaed3f] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [bd3b6c204d01] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [0b06ae7158c1] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [4d1527c772d5] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [968706e19fe5] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [b7e8632bd650] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [31ed8bedcd29] selftests/bpf: Add bpf_red test (Geliang Tang)


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
        - /



LKML results:
    - it looks like there is an issue in 32-bit arch, Matth will send a fix.


Next meeting:
    - Next one on Tuesday, the 11th of July.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230711



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
