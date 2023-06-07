Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DCC35B42
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 10:33:05 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5149429c944so1274838a12.0
        for <mptcp@lists.linux.dev>; Wed, 07 Jun 2023 03:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686133983; x=1688725983;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+zC7YQNNFlorEMtEJjqe7dee92XAhQWz0SkYZ/0nRY=;
        b=jspvySl4RrNw+wX0Yg6JyMHww9eFmSqVL9umJYLoSTP3l65Hn38XMaVKToxOXq2IA+
         swkN/vnOMeq47Kkv234SYbES6nJH60Kj66vsf8ddn1Y6a2A+MTLQ6QzfTwvRQX10TUaa
         ii9mT2zoEusghKRsKZqQOuDF1aH2fCxLW3oisAhGsZ9emah3rWYaEcJ9x5pfgpGTXYbr
         RzpXRVWmZlEX126N7swyvNwpIxeX8LNUqXiZ+1X3vnQELfo52rBRsEobLQYdN6/3vFYR
         4fw6P5MH06Y2lRgHWrLN3iTFac52kEAGvUT5p3/ZjQwdZYd0yEl2fUsiflPRu1adVAJm
         mTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686133983; x=1688725983;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G+zC7YQNNFlorEMtEJjqe7dee92XAhQWz0SkYZ/0nRY=;
        b=Mt0mYSUfKPa05RtqLOMJdOaLNU01R8SVLQm4hK5oylJo1CgfxrLuHASbo6IbiX+a1z
         cnzB8mAUwYuLHnL/4asrisXtDnb5E/qTp/F+wSTH5u9yim1ouaMfsKVjxQKDbyHvqHVP
         VswJLfiMypiQZQDfLpm1lrcWG5GkYWFOPa931NsfsL/7f6mvlzF+XYJjVAYdPoTbK9tB
         wQOkTsoXbfe8ahTbPpgXuI9PTE9Da432FZzyF23mZcgug/crpPUEDVI38DoZ14oNaemz
         0jKz7UeFcoswAh+8luJN7XvIMZ/Jz0OYSCiwmmms1tnMSlhBdXZ4j7B8+YlegdVagQ7Y
         luAQ==
X-Gm-Message-State: AC+VfDwrBgQ65QGDxDMc79ecnOaTLpczSMv1NDNHMOjDPjGgjLFBSjr9
	TOSS0AXHaYOEv8XaULrb3Tp4XKuz5J9HWrF7tyxsew==
X-Google-Smtp-Source: ACHHUZ7KfKuQNsWLFD+t9Q8zKIJb5FeqUB3yGemWUlNVDl1508aAxjxOf5BT2MjF3UOkDu1FA04SAw==
X-Received: by 2002:a50:fc12:0:b0:514:9e26:1f4b with SMTP id i18-20020a50fc12000000b005149e261f4bmr4250274edr.0.1686133983266;
        Wed, 07 Jun 2023 03:33:03 -0700 (PDT)
Received: from [192.168.43.205] ([109.139.221.102])
        by smtp.gmail.com with ESMTPSA id j26-20020aa7ca5a000000b00515c8024cb9sm6078959edt.55.2023.06.07.03.33.02
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 03:33:02 -0700 (PDT)
Message-ID: <1a293916-86a7-e7ff-2226-938d3c506651@tessares.net>
Date: Wed, 7 Jun 2023 12:33:02 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 6th of June 2023
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Yesterday, we had our 244th meeting with Christoph (Apple), Paolo,
Davide (Red Hat), Mat (Cruise) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau, Matthieu Baerts):

13262563: [net,1/6] mptcp: fix connect timeout handling
13262566: [net,2/6] mptcp: add annotations around msk->subflow accesses
13262565: [net,3/6] mptcp: consolidate passive msk socket initialization
13262564: [net,4/6] mptcp: fix data race around msk->first access
13262568: [net,5/6] mptcp: add annotations around sk->sk_shutdown accesses
13262567: [net,6/6] mptcp: fix active subflow finalization:
      - Series: mptcp: Fixes for connect timeout, access annotations,
and subflow init
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=752821&state=*&archive=both

13264985: [net-next] ipv6: lower "link become ready"'s level message:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230601-net-next-skip_print_link_becomes_ready-v1-1-7ff2b88dc9b8@tessares.net/

13266867: [net,1/5] mptcp: only send RM_ADDR in nl_cmd_remove
13266870: [net,2/5] selftests: mptcp: update userspace pm addr tests
13266868: [net,3/5] mptcp: add address into userspace pm list
13266869: [net,4/5] selftests: mptcp: update userspace pm subflow tests
13266871: [net,5/5] mptcp: update userspace pm infos:
      - Series: mptcp: Fixes for address advertisement
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=753897&state=*&archive=both


    our repo (by: Geliang Tang, Paolo Abeni):

13256270: [mptcp-next,v2,1/4] mptcp: export local_address
13256271: [mptcp-next,v2,2/4] mptcp: unify pm get_local_id interfaces
13256272: [mptcp-next,v2,3/4] mptcp: unify pm get_flags_and_ifindex_by_id
13256273: [mptcp-next,v2,4/4] mptcp: unify pm set_flags interfaces:
      - Series: unify PM interfaces
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=751208&state=*&archive=both

13258600: [v2,mptcp-net,1/2] mptcp: handle correctly disconnect() failures
13258601: [v2,mptcp-net,2/2] mptcp: fix possible divide by zero in
recvmsg():
      - Series: [v2,mptcp-net,1/2] mptcp: handle correctly disconnect()
failures
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=751861&state=*&archive=both

13267229: [mptcp-net,1/2] squash-to: "mptcp: track some aggregate data
counters"
13267230: [mptcp-net,2/2] Squash-to: "mptcp: fix possible divide by zero
in recvmsg()":
      - Series: [mptcp-net,1/2] squash-to: "mptcp: track some aggregate
data counters"
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=754006&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


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
      - While working on that, Davide noticed that it is recommended to
switch from global to per-op which would allow to automatically ensure
the policy is respected (all mandatory attributes set, etc.) without
breaking the API

13262347: [mptcp-net,v3,01/32] selftests: mptcp: lib: skip if missing symbol
13262349: [mptcp-net,v3,02/32] selftests: mptcp: lib: skip if not below
kernel version
13262351: [mptcp-net,v3,03/32] selftests: mptcp: connect: skip transp
tests if not supported
13262350: [mptcp-net,v3,04/32] selftests: mptcp: connect: skip
disconnect tests if not supported
13262352: [mptcp-net,v3,05/32] selftests: mptcp: connect: skip TFO tests
if not supported
13262354: [mptcp-net,v3,06/32] selftests: mptcp: diag: skip listen tests
if not supported
13262353: [mptcp-net,v3,07/32] selftests: mptcp: diag: skip inuse tests
if not supported
13262355: [mptcp-net,v3,08/32] selftests: mptcp: pm nl: remove hardcoded
default limits
13262356: [mptcp-net,v3,09/32] selftests: mptcp: pm nl: skip fullmesh
flag checks if not supported
13262357: [mptcp-net,v3,10/32] selftests: mptcp: sockopt: relax expected
returned size
13262359: [mptcp-net,v3,11/32] selftests: mptcp: sockopt: skip
getsockopt checks if not supported
13262358: [mptcp-net,v3,12/32] selftests: mptcp: sockopt: skip TCP_INQ
checks if not supported
13262361: [mptcp-net,v3,13/32] selftests: mptcp: userspace pm: skip if
'ip' tool is unavailable
13262360: [mptcp-net,v3,14/32] selftests: mptcp: userspace pm: skip if
not supported
13262362: [mptcp-net,v3,15/32] selftests: mptcp: userspace pm: skip PM
listener events tests if unavailable
13262363: [mptcp-net,v3,16/32] selftests: mptcp: join: use
'iptables-legacy' if available
13262364: [mptcp-net,v3,17/32] selftests: mptcp: join: helpers to skip tests
13262366: [mptcp-net,v3,18/32] selftests: mptcp: join: skip check if MIB
counter not supported
13262365: [mptcp-net,v3,19/32] selftests: mptcp: join: skip test if
iptables/tc cmds fail
13262367: [mptcp-net,v3,20/32] selftests: mptcp: join: support local
endpoint being tracked or not
13262369: [mptcp-net,v3,21/32] selftests: mptcp: join: skip Fastclose
tests if not supported
13262368: [mptcp-net,v3,22/32] selftests: mptcp: join: support RM_ADDR
for used endpoints or not
13262370: [mptcp-net,v3,23/32] selftests: mptcp: join: skip implicit
tests if not supported
13262372: [mptcp-net,v3,24/32] selftests: mptcp: join: skip backup if
set flag on ID not supported
13262371: [mptcp-net,v3,25/32] selftests: mptcp: join: skip fullmesh
flag tests if not supported
13262373: [mptcp-net,v3,26/32] selftests: mptcp: join: skip userspace PM
tests if not supported
13262374: [mptcp-net,v3,27/32] selftests: mptcp: join: skip fail tests
if not supported
13262375: [mptcp-net,v3,28/32] selftests: mptcp: join: skip MPC backups
tests if not supported
13262376: [mptcp-net,v3,29/32] selftests: mptcp: join: skip PM listener
tests if not supported
13262378: [mptcp-net,v3,30/32] selftests: mptcp: join: uniform listener
tests
13262377: [mptcp-net,v3,31/32] selftests: mptcp: join: skip mixed tests
if not supported
13262379: [mptcp-net,v3,32/32] Squash to "selftests: mptcp: add
MPTCP_FULL_INFO testcase":
      - State: New
      - Series: selftests: mptcp: skip tests when features are not supported
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=752764&state=*&archive=both
      - Not great but we need something
      - Matth: TODO: apply → Done

13267061: [mptcp-next,v16,1/5] mptcp: pass addr to mptcp_pm_alloc_anno_list
13267062: [mptcp-next,v16,2/5] selftests: mptcp: test userspace pm out
of transfer
13267063: [mptcp-next,v16,3/5] selftests: mptcp: check subflows infos
13267064: [mptcp-next,v16,4/5] selftests: mptcp: check add_addr infos
13267065: [mptcp-next,v16,5/5] selftests: mptcp: add pm_nl_set_endpoint
helper:
      - State: New
      - Series: update userspace pm mptcp_info fields part 2
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=753960&state=*&archive=both
      - TODO: Matth: review

13268731: [mptcp-next,v6,01/18] Squash to "mptcp: add struct
mptcp_sched_ops"
13268737: [mptcp-next,v6,02/18] Squash to "mptcp: add sched in mptcp_sock"
13268738: [mptcp-next,v6,03/18] Squash to "mptcp: add scheduler wrappers"
13268739: [mptcp-next,v6,04/18] mptcp: add last_snd in sched_data
13268740: [mptcp-next,v6,05/18] mptcp: add snd_burst in sched_data
13268741: [mptcp-next,v6,06/18] mptcp: register default scheduler
13268742: [mptcp-next,v6,07/18] Squash to "bpf: Add bpf_mptcp_sched_ops"
13268743: [mptcp-next,v6,08/18] Squash to "selftests/bpf: Add mptcp
sched structs"
13268744: [mptcp-next,v6,09/18] Squash to "selftests/bpf: Add bpf_rr
scheduler"
13268745: [mptcp-next,v6,10/18] mptcp: rename __mptcp_set_timeout
13268746: [mptcp-next,v6,11/18] mptcp: add two wrappers needed by bpf_burst
13268747: [mptcp-next,v6,12/18] bpf: Add bpf_burst write accesses
13268748: [mptcp-next,v6,13/18] bpf: Export more bpf_burst related functions
13268749: [mptcp-next,v6,14/18] selftests/bpf: Add bpf_burst scheduler
13268750: [mptcp-next,v6,15/18] selftests/bpf: Add bpf_burst test
13268751: [mptcp-next,v6,16/18] bpf: Add subflow flags write access
13268752: [mptcp-next,v6,17/18] selftests/bpf: Add bpf_stale scheduler
13268753: [mptcp-next,v6,18/18] selftests/bpf: Add bpf_stale test:
13268944: [mptcp-next] Squash to "selftests/bpf: Add bpf_burst scheduler
& test, v6":
      - State: New
      - Series: BPF packet scheduler updates
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=754345&state=*&archive=both
      - Mat is going to look at it
      - It looks like some data are being moved around but not sure if
it really changes the scheduler API as discussed? → Mat will focus on
the refactoring ones first.
      - Maybe there are some patches only doing preparation works
(refactoring) that could be sent to net-next (not the ones related to
the API or BPF: we need to have the refactoring of the scheduler part
before sending that not to break the API)

13269383: [mptcp-next] Revert "Merge tag '9p-6.4-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs":
      - State: New
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230606-mptcp-revert-9p-features-v1-1-1d7ea4b3749d@tessares.net/
      - These patches from 9p are causing the instabilities reported by
our CI, see #400



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 404):

  412  shadowsocks-libev not working, need guidance for PM configuration:
      - To be checked

  411  Problem with IPROTO [question]:
      - Paolo replied
      - We can close next week if there is no more activity

          - we may want to investigate supporting TCP_MAXSEG sockopt and
possibly others


  406  Compile and run mptcp bpf selftests in CI [enhancement] [selftests]:
      - Good idea, to be implemented


    Bugs (opened, flagged as "bug" and assigned)

  368  selftests: skip tests not being supported by older kernels [bug]
[selftests] @matttbe:
      - See patches above


    Bugs (opened and flagged as "bug" and not assigned)

  400  packetdrill: data are retransmited after the `close()` [bug]
[packetdrill]:
      - See patch above: issue with 9p

  398  syzkaller: memory leak in `subflow_ulp_init` [bug] [syzkaller]:
      - Paolo is looking at it but hard to debug
      - Happening once or twice a week, no reproducer

  391  PM: userspace: unable to create additional subflows with the
local addr ID 0 [bug]
  379  userspace pm: ability to send `RM_ADDR` for all local IDs used (0
included) [bug] [pm]
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched]
  336  Issues with BPF packet scheduler [bug]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: test 98 `fastclose test` is sometimes
failing [bug] [selftests]
  318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
cookies [bug] [selftests]

  315  Issues with backup flow [bug]:
      - some activities on this issue where backup subflows are not used
after having disabling the interfaces used by the non backup subflows.

  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]


    In Progress (opened, new feature and assigned)

  403  userspace pm: local_addr_list: use a refcount per entry
[enhancement] [pm] @geliangtang
  353  sockopt: uniform code to get/set values [enhancement] @matttbe

  342  scheduler: area in the socket structures reserved for schedulers
[enhancement] [sched] @geliangtang:
      - See patches above

  340  netlink: switch to YAML Netlink specs [enhancement] @dcaratti:
      - See patches above

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] [sched] @geliangtang:
      - See patches above

   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

  381  Why does total throughput increase when the delay on one of the
paths increases? [question] @matttbe


    Open questions (opened, questions and not assigned)

  411  Problem with IPROTO [question]
  395  If MPTCP primary flow is over tun interface, no subflow gets
created [question]
  392  Problem attempting to use all my interfaces (subflows)  [question]


    For later (opened and not assigned assigned)

  412  shadowsocks-libev not working, need guidance for PM configuration
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
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
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


    Recently closed (since 2023-05-30)

  410  Compiling MPTCP v1 with Linux Kernel v6.1 [question]
  409  Compiling this kernel for Raspberry pi OS latest version
[question] @matttbe
  408  syzkaller: BUG: sleeping function called from invalid context in
`__lock_sock_fast` [bug] [syzkaller] @pabeni
  407  syzkaller: possible deadlock in `inet_sk_diag_fill` [bug]
[syzkaller] [reproducer] [bisected] @pabeni
  405  Question: MPTCP with GStreamer [question] @matttbe
  404  syzkaller: divide error in `__tcp_select_window` [bug]
[syzkaller] @pabeni



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.5):
https://github.com/orgs/multipath-tcp/projects/3/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1



Non-fixes patches backported to stable:
    - 617612316953 ("mptcp: avoid unneeded __mptcp_nmpc_socket() usage"):
        - needed for: 5b825727d087 ("mptcp: add annotations around
msk->subflow accesses")
        - to 6.3 and 6.1
        - should be OK
    - 2bb9a37f0e19 ("mptcp: avoid unneeded address copy"):
        - needed for: 7e8b88ec35ee ("mptcp: consolidate passive msk
socket initialization")
        - to 6.3 and 6.1
        - should be OK
    - a88d0092b24b ("mptcp: simplify subflow_syn_recv_sock()"):
        - needed for: 7e8b88ec35ee ("mptcp: consolidate passive msk
socket initialization")
        - to 6.3 and 6.1
        - maybe a bit too invasive but apparently OK



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [a1397061c9a9] mptcp: handle correctly disconnect() failures
(Paolo Abeni)
        - [9c959acc76cf] mptcp: fix possible divide by zero in recvmsg()
(Paolo Abeni):
            - wait one more week to be sufficiently tested

    - Fixes for net-next: /

    - Features for net-next:

        - [798238d81d09] mptcp: move snd_una update earlier for fallback
socket (Paolo Abeni)
        - [66b38451e5b5] mptcp: track some aggregate data counters
(Paolo Abeni)
        - [261026dff24c] selftests: mptcp: explicitly tests aggregate
counters (Paolo Abeni)
        - [23489266bd8c] mptcp: add subflow unique id (Paolo Abeni)
        - [6f11fc8782f2] mptcp: introduce MPTCP_FULL_INFO getsockopt
(Paolo Abeni)
        - [7476699f7d82] selftests: mptcp: add MPTCP_FULL_INFO testcase
(Paolo Abeni):
            - Can be sent: TODO: Matth → delayed by one week
            - Note: depends on new patches for -net

        - [0fe971e5b502] mptcp: export local_address (Geliang Tang)
        - [fedff08f99d2] mptcp: unify pm get_local_id interfaces
(Geliang Tang)
        - [4a6a55e4dfc3] mptcp: unify pm get_flags_and_ifindex_by_id
(Geliang Tang)
        - [ec939336dbbc] mptcp: unify pm set_flags interfaces (Geliang
Tang):
            - Can be sent: TODO: Matth
            - Should be OK to send them

    - Features for net-next (next): /

    - Features for other trees:

        - [80edd8c7dcd7] security, lsm: Introduce
security_mptcp_add_subflow() (Paolo Abeni)
        - [5bdaffc3cbc4] selinux: Implement mptcp_add_subflow hook
(Paolo Abeni):
            - In SELinux tree

        - [de5755900849] mptcp: refactor push_pending logic (Geliang Tang)
        - [54e5de64a9d3] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [02e7261233a2] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [ced03af08613] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [27957881084f] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [af9a4cb35f0d] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [eabc15e39184] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [5bdfac3c6a14] mptcp: add scheduler wrappers (Geliang Tang)
        - [01bf651b0e76] mptcp: use get_send wrapper (Geliang Tang)
        - [f2ec2872dc97] mptcp: use get_retrans wrapper (Geliang Tang)
        - [f883d2f8e334] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [9ac885e16c3d] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [dd2ffc6e0673] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [62b48c0a0815] selftests/bpf: use random netns name for mptcp
(Geliang Tang)
        - [80e355fefbb8] selftests/bpf: add two mptcp netns helpers
(Geliang Tang)
        - [8570334141b8] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [a5247a10b366] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [db178a9f945f] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [066b415f2605] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [2a9b501041cc] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [2cb67beed25e] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [046ab9823db9] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [f25798c0633e] selftests/bpf: Add bpf_red test (Geliang Tang):
            - Same as last week: wait for sched refact



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - still working

    - CI (Matth):
        - should be better with the revert, see above



Next meeting:
    - Next one on Tuesday, the 13th of June.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230613



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
