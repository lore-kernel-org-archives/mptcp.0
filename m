Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA71D20CAF
	for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 16:21:31 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso10267045e9.0
        for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691684489; x=1692289289;
        h=content-transfer-encoding:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgfRDyso46E4fDx4qQHwWmsrQ9Lon+rhPU3rGUhj5Uo=;
        b=yr1hGg5YnX1jtva6sHOv1Ow3/LNKuqf+pP/zUPYh8F0Ki9CbLnN5UPgWo7eQoEPl0G
         UEheCZhzPUwZ28wXh30Y8Ar3QsVK1TtiJUd3JZxrEaAq7AoDZyG8qoBZVUsD+ptXFpjq
         kRLSmh01aIhYfzg18vBj4tgmrUC3YVofEXdVb4MtdH+1aY2dwt8qyNdbkXncrckYNdFY
         IE+uwl2uGjwMpfSf3O81LMPodDLYjdA7Kn5KRYDNbAnV78VHqswEjxLy1ffQXVFkBCkT
         lbGUS2hbz+DhqlHUFxlv2ahP30lrJVsaZE5b6fxoCY3dkRwgMuRwFXeVNEQCAJLYvy5r
         tGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691684489; x=1692289289;
        h=content-transfer-encoding:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UgfRDyso46E4fDx4qQHwWmsrQ9Lon+rhPU3rGUhj5Uo=;
        b=lCV8jl/VRklbS7MIaQxgmet1tfma1lCSn2X4tXecP1kz02jpeGTzAgIHtOfMhK6nrf
         KZ/NadKA+wsJ6EXkkF/BgE5U6WynV7l9bODMUOgyjKwvwJsUUKMr4zsIONGTpNrgBCBg
         SPqup5uD/AVxpqggl6bCD4fCu64P74++a0KNoa8IzFawMTzAP+UGIii4rtffxizNzgrH
         o+fpASYPfyGuPibZyuIfCmZFIK13esT/vtT5H5J1RV304Mv8Rnr244jQxBAkavUtgWjx
         BuhHW3Xy8VOEbwhLMmA1oifpA+YUHYZwEDmvHQYq2GnZuLw6Gp/2kaZoLtcHNLlDqx+g
         fZoQ==
X-Gm-Message-State: AOJu0YwCdl/NQmdt1dwgdjpswwpiGjMERHJn6QTrQtfnUMqTk1i8TiYS
	e3AN0DpsVqQA8h4FRhIAlEnuVwO1txUsNBntgFw=
X-Google-Smtp-Source: AGHT+IEB3yrTsNB1G6JhMegaxJsZUs2RMUUOYfDVh41oSvSkgWR7SxQwxPkMR6SJ9odTkPtkokuxsQ==
X-Received: by 2002:a7b:c3d6:0:b0:3fc:e00:5275 with SMTP id t22-20020a7bc3d6000000b003fc0e005275mr2311088wmj.2.1691684489092;
        Thu, 10 Aug 2023 09:21:29 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:9609:9964:25d3:6050? ([2a02:578:8593:1200:9609:9964:25d3:6050])
        by smtp.gmail.com with ESMTPSA id e9-20020a05600c218900b003fe195cecb3sm5508541wme.38.2023.08.10.09.21.28
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 09:21:28 -0700 (PDT)
Message-ID: <dd5ca99a-df4b-4253-ae45-367e881a5eb4@tessares.net>
Date: Thu, 10 Aug 2023 18:21:27 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 8th of August 2023
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Today, we had our 253rd meeting with Mat (Cruise) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts, Xiang Yang):

13339375: [-next] mptcp: fix the incorrect judgment for msk->cb_flags:
      - Submitter: Xiang Yang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230803072438.1847500-1-xiangyang3@huawei.com/

13340301: [net,1/4] selftests: mptcp: join: fix 'delete and re-add' test
13340302: [net,2/4] selftests: mptcp: join: fix 'implicit EP' test
13340303: [net,3/4] mptcp: avoid bogus reset on fallback close
13340304: [net,4/4] mptcp: fix disconnect vs accept race:
      - Series: mptcp: more fixes for v6.5
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=772730&state=*&archive=both


    our repo (by: Geliang Tang):

13337640: [mptcp-next,1/3] Squash to "bpf: Add bpf_mptcp_sched_ops"
13337815: [mptcp-next] bpf: Add accesses to bpf_skc_to_tcp_sock:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/322ae693257df0c5fcd8f9254e062f394fbeab88.1690963606.git.geliang.tang@suse.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Joel Granados):

13333856: [v2,11/14] networking: Update to register_net_sysctl_sz:
     - Archive? → Done

13343077: [mptcp-next,v12,1/5] bpf: Add update_socket_protocol hook
13343078: [mptcp-next,v12,2/5] selftests/bpf: Use random netns name for
mptcp
13343079: [mptcp-next,v12,3/5] selftests/bpf: Add two mptcp netns helpers
13343080: [mptcp-next,v12,4/5] selftests/bpf: Fix error checks of mptcp
open_and_load
13343081: [mptcp-next,v12,5/5] selftests/bpf: Add mptcpify test:
      - Series: bpf: Force to MPTCP
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=773505&state=*&archive=both
      - Addressing comments from BPF maintainers, hopefully the last version


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
      - Status: same as last week

13294008: [iperf3] add MPTCPv1 support:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/
      - Status: same as last week
      - (at least we didn't see anything there:
https://github.com/esnet/iperf/pulls?q=is%3Apr+mptcp )

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

13339231: [mptcp-next,v3,1/6] Squash to "mptcp: add sched_data helpers"
13339232: [mptcp-next,v3,2/6] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
13339233: [mptcp-next,v3,3/6] Squash to "selftests/bpf: add two mptcp
netns helpers"
13339234: [mptcp-next,v3,4/6] Squash to "selftests/bpf: Add bpf_rr
scheduler"
13339235: [mptcp-next,v3,5/6] Squash to "bpf: Export more bpf_burst
related functions"
13339236: [mptcp-next,v3,6/6] Squash to "selftests/bpf: Add bpf_burst
scheduler":
      - State: New
      - Series: BPF packet scheduler updates part 3
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=772420&state=*&archive=both
      - Can be applied → TODO

13339312: [mptcp-next,v2,1/2] selftests/bpf: Add bpf_stale scheduler
13339313: [mptcp-next,v2,2/2] selftests/bpf: Add bpf_stale test:
      - State: New
      - Series: add bpf_stale scheduler
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=772447&state=*&archive=both
      - Maybe we should rename it because 'stale' might be confusing:
different from the "stale" bit used in the core

13345703: [mptcp-next,1/4] mptcp: allow creating id 0 subflow
13345704: [mptcp-next,2/4] mptcp: remove id 0 subflow & address
13345705: [mptcp-next,3/4] selftests: mptcp: add id argument for dsf
13345706: [mptcp-next,4/4] selftests: mptcp: remove id 0 subflow & address:
      - State: New
      - Series: userspace pm remove id 0 subflow & address
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=773933&state=*&archive=both
      - Matth can have a look
      - CI is complaining: the new test is not passing



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/
    TODO: check no label/project

https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+no%3Alabel

https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+no%3Aproject+-label%3Aquestion+-label%3Abug

    Recently opened (latest from the last meeting: 424):

  427  possible mptcp regression in v6.4 kernel?:
      - on one side, a bit of unusual setup where both host can be
client/server → PM issue, maybe best to create a new dedicated issue for
that
      - main issue: rsync stalls after a bit of time
      - not related to issues with fallback sockets
      - to be investigated
      → TODO: flag as bug → Done

  426  selftests: validate listener sockets with multiple accepts
[enhancement] [selftests]:
      - related to a discussion we had last week

  425  syzkaller: validate all MPTCP Netlink API [enhancement] [syzkaller]:
      - related to a discussion we had last week
      - a few netlink commands for the in-kernel PM might be missing
      - would be good to validate more: userspace PM
      - and use valid commands to try more (e.g. with and without a
valid token)


    Bugs (opened, flagged as "bug" and assigned)

  391  PM: userspace: unable to create additional subflows with the
local addr ID 0 [bug] [pm] @geliangtang
  379  userspace pm: ability to send `RM_ADDR` for all local IDs used (0
included) [bug] [pm] @geliangtang:
      - see patches above


    Bugs (opened and flagged as "bug" and not assigned)

  424  KMemLeak around `__register_sysctl_table` [bug]:
      - the CI got that again last week
      - maybe a false positive from kmemleak?
      - Maybe related to #398?

  420  syzkaller: WARNING in `__mptcp_move_skbs_from_subflow` [bug]
[syzkaller]
  416  No new subflow when removing an endpoint and adding a new one [bug]
  398  syzkaller: memory leak in `subflow_ulp_init` [bug] [syzkaller]
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
      - see patches above

  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang:
      - see patches above

  340  netlink: switch to YAML Netlink specs [enhancement] @dcaratti:
      - see patches above

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe:
      - see patches above

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   79  allow 'force to MPTCP' mode: BPF [enhancement] [bpf] @geliangtang:
      - see patches above

   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang:
      - see patches above

   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang


    Assigned Questions (opened, questions and assigned)

None.

    Open questions (opened, questions and not assigned)

  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned assigned)

  427  possible mptcp regression in v6.4 kernel?
  426  selftests: validate listener sockets with multiple accepts
[enhancement] [selftests]
  425  syzkaller: validate all MPTCP Netlink API [enhancement] [syzkaller]
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


    Recently closed (since 2023-08-01)

  423  syzkaller: BUG: unable to handle kernel NULL pointer dereference
in `mptcp_stream_accept` [bug] [syzkaller] [reproducer]
  417  Verifier blocks access to tcp_sock fields [bug] [sched] [bpf]
@geliangtang
  400  packetdrill: data are retransmitted after the `close()` [bug]
[packetdrill] @matttbe
  290  Not possible to `connect()` after a disconnect for a passive
socket [bug] @pabeni




FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.6):
https://github.com/orgs/multipath-tcp/projects/4/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net: /

    - Fixes for net-next: /

    - Features for net-next:

        - [c13aaf4670e3] mptcp: avoid unneeded mptcp_token_destroy()
calls (Paolo Abeni)
        - [63ff4d60ee35] mptcp: avoid additional __inet_stream_connect()
call (Paolo Abeni)
        - [b011dad67c6d] mptcp: avoid subflow socket usage in
mptcp_get_port() (Paolo Abeni)
        - [640411fb7190] net: factor out inet{,6}_bind_sk helpers (Paolo
Abeni)
        - [7ce51cbd734d] mptcp: mptcp: avoid additional indirection in
mptcp_bind() (Paolo Abeni)
        - [15444640b317] net: factor out __inet_listen_sk() helper
(Paolo Abeni)
        - [2395888c08f5] mptcp: avoid additional indirection in
mptcp_listen() (Paolo Abeni)
        - [9229ddf71f2c] mptcp: avoid additional indirection in
mptcp_poll() (Paolo Abeni)
        - [ff9282534ef2] mptcp: avoid unneeded indirection in
mptcp_stream_accept() (Paolo Abeni)
        - [b1a921c2516c] mptcp: avoid additional indirection in sockopt
(Paolo Abeni)
        - [08b7c0b36990] mptcp: avoid ssock usage in
mptcp_pm_nl_create_listen_socket() (Paolo Abeni)
        - [5a70484410b8] mptcp: change the mpc check helper to return a
sk (Paolo Abeni)
        - [027b34ca4828] mptcp: get rid of msk->subflow (Paolo Abeni):
            - best to wait for the sync between net and net-next
            - → to be sent at the end of the week → TODO Matth → on Friday

    - Features for net-next (next): /

    - Features for other trees:

        - [d627333533b4] mptcp: refactor push_pending logic (Geliang Tang)
        - [6c82fef59c01] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [e34214022d50] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [1a9a9a5e01f5] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [e7e924381b00] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [7ef0a0657704] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [f03f04926ad1] mptcp: add sched_data helpers (Geliang Tang)
        - [354bd4e094bb] mptcp: add scheduler wrappers (Geliang Tang)
        - [44505f900b4e] mptcp: use get_send wrapper (Geliang Tang)
        - [037427cc1f31] mptcp: use get_retrans wrapper (Geliang Tang)
        - [1644cb7a1faf] mptcp: register default scheduler (Geliang Tang):
            - move "mptcp: add sched_data helpers" lower → TODO
            - Mat will check if it is OK to send them
            - Idea is to send them next week if possible

        - [a26499d6c1d4] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [0cb39f5a527c] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [69201ac53a3d] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [1189f65405ee] selftests/bpf: use random netns name for mptcp
(Geliang Tang)
        - [30e23259aad2] selftests/bpf: add two mptcp netns helpers
(Geliang Tang)
        - [7ed2143f019b] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [bd76ea9aa88a] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [6f999f8474c6] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [6b82b5cbb98e] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [940903c68660] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [956a035f51f0] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [a6371739267d] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [ae26762764ae] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [9127a7da264d] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [64ba9dd8b1c9] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [05c1de9d5247] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [60bc1394816f] selftests/bpf: Add bpf_burst test (Geliang Tang)



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
        - 9p revert has been removed
        - sometimes there is no activity for 90m after having started
the VM to get the prompt then we quickly hit the 2h timeout (it took a
bit of time to clone + compile the kernel and other tools)
        - maybe time to switch to virtme-ng? But still in development
apparently



Other topics:
    - mptcpd: https://github.com/multipath-tcp/mptcpd/issues/281:
        - a few issues but main one seems to be that endpoints are not
removed when ifaces are removed?
        - to be rechecked -> TODO → ticket has been updated

    - perf regressions: setup?

Next meeting:
    - Next one on Tuesday, the 22nd of August.
    - /!\ We skip the one of next week (15th of August) /!\
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230822



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday (not next week but the week after),
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
