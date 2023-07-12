Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D47414F74
	for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 17:09:19 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso11820727e87.0
        for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 10:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689181757; x=1691773757;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fc6Tx7F7tZgsuZHDpQcaMr8UqCT4N5cte+3aQQsxqRM=;
        b=R7y8ytiFLdCLfy99fqU4FCY7g3LJPz2uDgsCZNW32vMj2tZIZ7e8dH2ygYwOeJpJPJ
         Tuy97tu6vMTacf8CUV7a6c6cYLBEZhtqUgK8FqcXqOhJyZgqLO8IdzyHOXXRSb978Oy5
         j+6K6sqN2NVavFYDy0hykf5jPZdjOnQXyICDeduRj4IhuFrqK/V7mpUF1U8Me7xef4e/
         BEW1AXorQJcRrPUCafDkKNn8JLjPaK8DiseFbeg4Er5TraN0O9IboWE5D9fyfS5Ga3fq
         VTt4HFRbwLw1dN7vE6nl+VlHBKKeBlcgVdJFn4s7Fl3yFr38Qs+14zpD4lC2HKE1iduB
         woDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689181757; x=1691773757;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fc6Tx7F7tZgsuZHDpQcaMr8UqCT4N5cte+3aQQsxqRM=;
        b=hGxqSWIeKJfjkRg4zAvl3Nyfvb7mx2Pv6LO6EgGB0PWVPuzTTGYccssFnUptt++eDt
         5+oBTvGUdfunKvEayaYd5c2O8k3b+cF8artZvmqAEmILGsOKSPUn2re1CiUORjPjyv6N
         9JdRImKB2cp9U92OT1bmByhG2R2Tpmez6P5MQyBY9rBZ12Wr5Z1rRLSz5LOqTbhzSBlD
         sseCunWymQ2Ti+6b3WSNOoIBE6tnFZ2vvRvDA+Eq0yOaUBCq/kptRKKYMfiBIQ5pddbZ
         7loLx2CCcqvmHNSR+jBQxjFCIj2TcEHF1sA6bzxHhuV9vdmJT0GnFrvqvV6agP9P9rj4
         XPUQ==
X-Gm-Message-State: ABy/qLZexF0JzOiQFaqHvzmw+OutBhB9s9uocv39hAqoeCJiIeN48vuC
	9Xu4j6fAWoLJzZBc4WhvvlzCfMSqiE0JpqBTA/UeMMTz
X-Google-Smtp-Source: APBJJlGr/QI35BSe23HLCY4GCMEJYGO25en9n+OeJKmgKkJNUBMJS/OMqHgksUGBKSqEwosnpEobtw==
X-Received: by 2002:a2e:7008:0:b0:2b6:e78e:1e58 with SMTP id l8-20020a2e7008000000b002b6e78e1e58mr15822249ljc.5.1689181757271;
        Wed, 12 Jul 2023 10:09:17 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ef4b:f9b8:e94a:ea27? ([2a02:578:8593:1200:ef4b:f9b8:e94a:ea27])
        by smtp.gmail.com with ESMTPSA id la16-20020a170906ad9000b0098d2261d189sm2858957ejb.19.2023.07.12.10.09.16
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 10:09:16 -0700 (PDT)
Message-ID: <6abb36cc-81c0-06fd-b746-9497c48b791c@tessares.net>
Date: Wed, 12 Jul 2023 19:09:16 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 11th of July 2023
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Yesterday, we had our 249th meeting with Christoph (Apple), Paolo
(Redhat), Mat (Cruise) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13301565: [net,1/9] mptcp: ensure subflow is unhashed before cleaning
the backlog
13301566: [net,2/9] mptcp: do not rely on implicit state check in
mptcp_listen()
13301567: [net,3/9] selftests: mptcp: connect: fail if nft supposed to work
13301568: [net,4/9] selftests: mptcp: sockopt: use 'iptables-legacy' if
available
13301570: [net,5/9] selftests: mptcp: sockopt: return error if wrong mark
13301569: [net,6/9] selftests: mptcp: userspace_pm: use correct server port
13301571: [net,7/9] selftests: mptcp: userspace_pm: report errors with
'remove' tests
13301572: [net,8/9] selftests: mptcp: depend on SYN_COOKIES
13301573: [net,9/9] selftests: mptcp: pm_nl_ctl: fix 32-bit support:
      - Series: mptcp: fixes for v6.5
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=762471&state=*&archive=both


    our repo (by: Geliang Tang, Matthieu Baerts):

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
      - Series: BPF packet scheduler updates part 1
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=760451&state=*&archive=both

13297167: [mptcp-net] selftests: mptcp: depend on SYN_COOKIES:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230629170551.3043312-1-matthieu.baerts@tessares.net/

13300566: [mptcp-next] Squash to 'Squash to "selftests/bpf: Add
bpf_rrscheduler" v11':
13301752: [mptcp-next,v4,6/7] Squash to "selftests/bpf: add two mptcp
netns helpers"
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/0b57bf87dc30e15782ba1fe2e925a7ce6ef0fc90.1688434547.git.geliang.tang@suse.com/

13301448: [mptcp-next] selftests: mptcp: pm_nl_ctl: fix 32-bit support:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230704-mptcp-issue-368-selftests-32-bits-v1-1-f4262dc1b07b@tessares.net/


Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang):

13303341: [RFC,bpf-next,v3,1/8] bpf: Add new prog type sockinit
13303342: [RFC,bpf-next,v3,2/8] bpf: Run a sockinit program
13303343: [RFC,bpf-next,v3,3/8] net: socket: run sockinit hooks
13303344: [RFC,bpf-next,v3,4/8] libbpf: Support sockinit hook
13303345: [RFC,bpf-next,v3,5/8] selftests/bpf: Add mptcpify program
13303346: [RFC,bpf-next,v3,6/8] selftests/bpf: use random netns name for
mptcp
13303347: [RFC,bpf-next,v3,7/8] selftests/bpf: add two mptcp netns helpers
13303351: [RFC,bpf-next,v3,8/8] selftests/bpf: Add mptcpify selftest:
      - Series: BPF 'force to MPTCP'
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=762983&state=*&archive=both
      - We got one suggestion, does it look OK?
      - @Geliang: recheck the question and see if we can say something:
          - https://lore.kernel.org/mptcp/ZKbzs7foUw+eeNnn@google.com/T/
          - Matt will send a message to Geliang just in case he didn't
see the reply.


    our repo (by: Andrea Claudi, Davide Caratti, Geliang Tang, Matthieu
Baerts, Paolo Abeni):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptcp-next] mptcp: add ooo prune support:
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

13290474: [net,1/2] selftests: mptcp: join: fix 'delete and re-add' test
13290475: [net,2/2] selftests: mptcp: join: fix 'implicit EP' test:
      - State: Changes requested
      - Series: selftests: fix mptcp_join test
      - Submitter: Andrea Claudi
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=759793&state=*&archive=both
      - status is the same as last week

13293682: [mptcp-next,01/10] Squash to "selftests/bpf: Add bpf_first test"
13293683: [mptcp-next,02/10] selftests/bpf: Add bpf_first test
13293684: [mptcp-next,03/10] Squash to "selftests/bpf: Add bpf_bkup test"
13293685: [mptcp-next,04/10] Squash to "selftests/bpf: Add bpf_rr test"
13293686: [mptcp-next,05/10] Squash to "selftests/bpf: Add bpf_red test":
    - can be applied: TODO: Matth → Done

13293687: [mptcp-next,06/10] selftests/bpf: Add bpf_stale scheduler
13293688: [mptcp-next,07/10] selftests/bpf: Add bpf_stale test
13293689: [mptcp-next,08/10] bpf: Export more bpf_burst related functions
13293690: [mptcp-next,09/10] selftests/bpf: Add bpf_burst scheduler
13293691: [mptcp-next,10/10] selftests/bpf: Add bpf_burst test:
      - State: Changes requested
      - Series: BPF packet scheduler updates part 2
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=760457&state=*&archive=both
      - Some questions from Mat

13294008: [iperf3] add MPTCPv1 support:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/
      - TODO: Matth: ask what Geliang is going to do with this patch → Done

13294657: [RFC,mptcp-next,v2] mptcp: convert netlink from small_ops to ops:
      - State: Needs ack
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/ed9c7f0320bb94a4a147d11c447cefa59f128ee1.1687877390.git.dcaratti@redhat.com/
      - See below

13301320: [RFC,mptcp-next,v2] Documentation: netlink: add a YAML spec
for mptcp:
      - State: Needs ack
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/d462c557c05d60a217f14ff77cd9702ed3ccf2c5.1688481634.git.dcaratti@redhat.com/
      - some binary diff with the API but Davide said it is OK
      - Paolo asked him for additional tests just to be sure it is OK
      - Davide will get back to us when everything looks OK

13295886: [mptcp-next,1/2] selftests: mptcp: join: rework detailed report
13295887: [mptcp-next,2/2] selftests: mptcp: join: colored results:
      - State: Needs ack
      - Series: selftests: mptcp: format subtests results in TAP (part 2)
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=760963&state=*&archive=both
      - can be reviewed, Paolo will try to have a look

13302424: [mptcp-next,1/2] selftests: mptcp: pm_nl_ctl: always look for
errors
13302425: [mptcp-next,2/2] selftests: mptcp: userspace_pm: unmute
unexpected errors:
      - State: New
      - Series: selftests: mptcp: pm_nl_ctl: display errors if any
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=762779&state=*&archive=both

13305089: [mptcp-next,1/6] mptcp: sockopt: move tcp_inq code to a
dedicated function
13305091: [mptcp-next,2/6] mptcp: sockopt: update supported list
13305093: [mptcp-next,3/6] mptcp: sockopt: get val in a generic way
13305090: [mptcp-next,4/6] mptcp: sockopt: add missing getsockopt() options
13305094: [mptcp-next,5/6] mptcp: sockopt: set val in a generic way
13305092: [mptcp-next,6/6] mptcp: sockopt: support IP_TTL &
IPV6_UNICAST_HOPS:
      - State: New
      - Series: mptcp: sockopt: uniform code to get/set values
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=763505&state=*&archive=both
      - looks OK with the current code, just some minor stuff to modify
      - for the suggestions:
          - TCP: what is done when a setsockopt() is done on a TCP
connection should not change so fine to duplicate code (we could look at
what has been done on the first subflows maybe?)
          - sync: for the moment it works, probably risks to change...
check if there is really a need.

13306937: [mptcp-next,01/14] mptcp: more accurate NL event generation.
13306939: [mptcp-next,02/14] mptcp: avoid unneeded mptcp_token_destroy()
calls
13306940: [mptcp-next,03/14] mptcp: avoid additional
__inet_stream_connect() call
13306941: [mptcp-next,04/14] mptcp: avoid subflow socket usage in
mptcp_get_port()
13306942: [mptcp-next,05/14] net: factor out inet{,6}_bind_sk helpers
13306943: [mptcp-next,06/14] mptcp: mptcp: avoid additional indirection
in mptcp_bind()
13306944: [mptcp-next,07/14] net: factor out __inet_listen_sk() helper
13306945: [mptcp-next,08/14] mptcp: avoid additional indirection in
mptcp_listen()
13306946: [mptcp-next,09/14] mptcp: avoid additional indirection in
mptcp_poll()
13306947: [mptcp-next,10/14] mptcp: avoid unneeded indirection in
mptcp_stream_accept()
13306948: [mptcp-next,11/14] mptcp: avoid additional indirection in sockopt
13306949: [mptcp-next,12/14] mptcp: avoid ssock usage in
mptcp_pm_nl_create_listen_socket()
13306950: [mptcp-next,13/14] mptcp: change the mpc check helper to
return a sk
13306951: [mptcp-next,14/14] mptcp: get rid of msk->subflow:
      - State: New
      - Series: mptcp: get rid of msk->subflow
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=764039&state=*&archive=both
      - A few reasons:
          - https://github.com/multipath-tcp/mptcp_net-next/issues/290
          - a few syscalls fail with different errors depending if it is
a passive or active sockets (e.g. failures with bind)
          - also reduce the memory footprint
          - but also clean the code and make stuff clearer!
          - (possible follow-up: allocating the struct sock only
instead of the struct socket (+ struct sock) but is quite a bit more
invasive in the net-core area)
      - Mat will have a look
      - They will need to be validated by syzkaller once they are applied



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 417):

/


    Bugs (opened, flagged as "bug" and assigned)

  400  packetdrill: data are retransmitted after the `close()` [bug]
[packetdrill] @matttbe
     - issue in 9p


    Bugs (opened and flagged as "bug" and not assigned)

  416  No new subflow when removing an endpoint and adding a new one [bug]
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
socket [bug]:
      - See patches above


    In Progress (opened, new feature and assigned)

  403  userspace pm: local_addr_list: use a refcount per entry
[enhancement] [pm] @geliangtang

  353  sockopt: uniform code to get/set values [enhancement] @matttbe:
      - see patches above

  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang:

  340  netlink: switch to YAML Netlink specs [enhancement] @dcaratti:
      - see patches above

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe:
      - see patches above

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   79  allow 'force to MPTCP' mode: BPF [enhancement] @geliangtang

   75  BPF: packet scheduler [enhancement] [sched] @geliangtang:
      - see patches above

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
  392  Problem attempting to use all my interfaces (subflows)  [question]:
      - TODO: Matth: check if they can be closed → Done


    For later (opened and not assigned assigned)

  417  Verifier blocks access to tcp_sock fields
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


    Recently closed (since 2023-07-04)

  418  Packet scheduler , Path Manager and Congestion Control [question]
  342  scheduler: area in the socket structures reserved for schedulers
[enhancement] [sched] @geliangtang



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.6):
https://github.com/orgs/multipath-tcp/projects/4/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1



Patches to send to netdev:

    - Fixes for other trees:

        - [0f1d7c247838] Revert "Merge tag '9p-6.4-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs" (Matthieu Baerts)

    - Fixes for -net: /

    - Fixes for net-next: /

    - Features for net-next:

        - [d06959e1985a] selftests: mptcp: set all env vars as local
ones (Geliang Tang)
        - [ceb391ff1faa] selftests: mptcp: add fastclose env var
(Geliang Tang)
        - [948b8e51f7c2] selftests: mptcp: add fullmesh env var (Geliang
Tang)
        - [f76866f17c38] selftests: mptcp: add speed env var (Geliang Tang):
            - can be sent: TODO: Matth → Done

        - [bd83712a6868] selftests: mptcp: connect: don't stop if error
(Matthieu Baerts)
        - [f619298ffc38] selftests: mptcp: userspace pm: don't stop if
error (Matthieu Baerts)
        - [326c161ac379] selftests: mptcp: userspace_pm: fix shellcheck
warnings (Matthieu Baerts)
        - [dbdd6bdaf6c7] selftests: mptcp: userspace_pm: uniform results
printing (Matthieu Baerts)
        - [5dc131db946f] selftests: mptcp: userspace_pm: reduce dup code
around printf (Matthieu Baerts)
        - [68b55d7e2249] selftests: mptcp: lib: format subtests results
in TAP (Matthieu Baerts)
        - [03ab55cc82b1] selftests: mptcp: connect: format subtests
results in TAP (Matthieu Baerts)
        - [d5a28b13644c] selftests: mptcp: pm_netlink: format subtests
results in TAP (Matthieu Baerts)
        - [d4d70465bade] selftests: mptcp: join: format subtests results
in TAP (Matthieu Baerts)
        - [715f53f4f084] selftests: mptcp: diag: format subtests results
in TAP (Matthieu Baerts)
        - [6ffbe87d5c9d] selftests: mptcp: simult flows: format subtests
results in TAP (Matthieu Baerts)
        - [bd3fa395233a] selftests: mptcp: sockopt: format subtests
results in TAP (Matthieu Baerts)
        - [98b94a36e0e0] selftests: mptcp: userspace_pm: format subtests
results in TAP (Matthieu Baerts):
            - can be sent: TODO: Matth → after the prev one


    - Features for net-next (next): /

    - Features for other trees:

        - [214d9e7125ae] mptcp: refactor push_pending logic (Geliang Tang)
        - [5fc52dd0ec8e] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [b1c9f3851ab2] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [103ec9f332d6] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [561a8185d064] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [4bc16e31d115] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [21a30fa2a7ec] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [76920adcc346] mptcp: add scheduler wrappers (Geliang Tang)
        - [572f244d1d09] mptcp: use get_send wrapper (Geliang Tang)
        - [2e1076675dc7] mptcp: use get_retrans wrapper (Geliang Tang)
        - [3ab2a891adde] mptcp: register default scheduler (Geliang Tang):
            - could be good to send some of these ones only preparing
the field on MPTCP side.
            - Mat will check later during this merge window (for net-next)

        - [a989ea3cde7b] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [f970bf60198a] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang):
        - [7e1b3f42757d] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [fddbbd09c8a1] selftests/bpf: use random netns name for mptcp
(Geliang Tang)
        - [f7acfd2155b9] selftests/bpf: add two mptcp netns helpers
(Geliang Tang)
        - [702b8f0f0cf9] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [3c6b4350245d] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [c062acd4865c] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [dc4f3a91466a] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [579f8cd7a623] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [a692e13bb05b] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [90b462095d5a] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [19b3dfd06cf2] selftests/bpf: Add bpf_red test (Geliang Tang)


Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - TODO: Matth: send tests for IP_TTL and v6 → Done:
https://github.com/multipath-tcp/packetdrill/pull/116

    - Patchew (Davide):
        - /

    - CI (Matth):
        -
https://api.cirrus-ci.com/v1/artifact/task/6516652167135232/summary/summary.txt
        - To be monitored: TODO Matth → done: new ticket
https://github.com/multipath-tcp/mptcp_net-next/issues/419



MP-DCCP:
    - DCCP is getting deprecated but there is an out-of-tree in-kernel user
    - https://github.com/telekom/mp-dccp
    - Very similar to MPTCP but for tunnels (not on top of TCP but DCCP
obviously)



Next meeting:
    - Next one on Tuesday, the 18th of July.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230718



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
