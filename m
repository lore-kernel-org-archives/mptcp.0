Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF50224F0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 21:36:17 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-405497850dbso54746305e9.0
        for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 14:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1695677775; x=1696282575; darn=lists.linux.dev;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v41jcJ3XkHK0CLcgKAx23aatr9zQpVhcIu90v6HJqkQ=;
        b=Sr0UZ2CUNQ7MBTgvi+zo13k+47hFKJmmtp9OTpd6NZvYrlpzlXYoqyhBIyO5pzmKer
         yW9OAopYKQP5T+988wTTkN9WsBXVKgYBS4uoHicfs0dPczwSMU/dJwp5Qe8lmoWsIJJp
         jAHwARcqnpXf4Lk/UbY6ytM83d4UWaEgDBJQ1874iW93vxv/xX8sTse2GaUgXdPmd0hU
         dAqPK9LHHKFbY9Cy99KMegic4RbpUE/DcGMCRvfm5QitC9ldtZht05PZA9GU2MivkdWa
         VgJuqWfaRg/B4XI9tahsSWGIR18t/WaHCPMzXaQTsXdFatUfofYXqHloQwiVv2Eb69CE
         OF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695677775; x=1696282575;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v41jcJ3XkHK0CLcgKAx23aatr9zQpVhcIu90v6HJqkQ=;
        b=qdSaiFcQJcEkTHK2/x8JmmxD864pNYIOUrocN4gD81cBZUcVh/NGI9Gp80sEVootDc
         fhqoQu/ZNGo2/smPs+lgOvZjFwGL0XY/VF2ewnq6OxTTGF6FBecTPq22oiOmDJnqyAsZ
         pvAWKy/5sA7sETpItL8k89qIKH4jBibzAkFEdgIntHY5IKvsagRzQom+wDjmpe+poT8i
         IxHIuahmCh+kqEEcYduFF+QS3Q1T3EdveW7LGtEcgGWdFermMYUBAinylfvG5kqe+EHu
         +wq40aLdRxX7e3HnXhPCOeS8d6J2LVHtNVzAq4onsHQfQwSAb50bnRtttPUQNGoM4Mtp
         C+Kw==
X-Gm-Message-State: AOJu0YycirT9qxZoxhRPAbE8+Eu9x1AyL8UKaSdetrzkQy5MDIO7zEI3
	B4qVTMOj9PzsyeaKW3GMbW7OhcnIqYKRi9wRollyKA==
X-Google-Smtp-Source: AGHT+IEmJqBnOJA3B6QJKBSTcAjpkRUHAoyEyvu+k0Sg/Uiucz5oXg3Zk22lWzVlL2WGnpq1GG0N4A==
X-Received: by 2002:a05:600c:3658:b0:405:1bfb:ff14 with SMTP id y24-20020a05600c365800b004051bfbff14mr7732478wmq.9.1695677775077;
        Mon, 25 Sep 2023 14:36:15 -0700 (PDT)
Received: from [10.188.232.98] (cust-west-par-46-193-35-178.cust.wifirst.net. [46.193.35.178])
        by smtp.gmail.com with ESMTPSA id s10-20020a05600c044a00b00405623e0186sm7282055wmb.26.2023.09.25.14.36.14
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 14:36:14 -0700 (PDT)
Message-ID: <fe56f3f1-6b70-4c23-a887-d629d754d50f@tessares.net>
Date: Mon, 25 Sep 2023 23:36:14 +0200
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
Subject: [Weekly meetings] MoM - 22nd of August 2023
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

A few weeks ago, we had our 254th meeting with Christoph (Apple), Paolo
(Redhat), Mat (Cruise) and myself (Tessares).


Thanks again for this new good meeting (and sorry for the delay)!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Matthieu Baerts):

13351030: [net-next,01/14] mptcp: avoid unneeded mptcp_token_destroy() calls
13351033: [net-next,02/14] mptcp: avoid additional
__inet_stream_connect() call
13351032: [net-next,03/14] mptcp: avoid subflow socket usage in
mptcp_get_port()
13351034: [net-next,04/14] net: factor out inet{,6}_bind_sk helpers
13351035: [net-next,05/14] mptcp: mptcp: avoid additional indirection in
mptcp_bind()
13351036: [net-next,06/14] net: factor out __inet_listen_sk() helper
13351037: [net-next,07/14] mptcp: avoid additional indirection in
mptcp_listen()
13351038: [net-next,08/14] mptcp: avoid additional indirection in
mptcp_poll()
13351039: [net-next,09/14] mptcp: avoid unneeded indirection in
mptcp_stream_accept()
13351040: [net-next,10/14] mptcp: avoid additional indirection in sockopt
13351041: [net-next,11/14] mptcp: avoid ssock usage in
mptcp_pm_nl_create_listen_socket()
13351042: [net-next,12/14] mptcp: change the mpc check helper to return a sk
13351043: [net-next,13/14] mptcp: get rid of msk->subflow
13351044: [net-next,14/14] mptcp: Remove unnecessary test for
__mptcp_init_sock():
      - Series: mptcp: get rid of msk->subflow
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=775397&state=*&archive=both

13354451: [bpf-next,v14,1/4] bpf: Add update_socket_protocol hook
13354452: [bpf-next,v14,2/4] selftests/bpf: Add two mptcp netns helpers
13354453: [bpf-next,v14,3/4] selftests/bpf: Fix error checks of mptcp
open_and_load
13354454: [bpf-next,v14,4/4] selftests/bpf: Add mptcpify test:
      - Series: bpf: Force to MPTCP
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=776456&state=*&archive=both


    our repo (by: Geliang Tang, Kuniyuki Iwashima):

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
      - Series: BPF packet scheduler updates part 3
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=772420&state=*&archive=both

13348618: [v1,mptcp-next] mptcp: Remove unnecessary test for
__mptcp_init_sock().:
      - Submitter: Kuniyuki Iwashima
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230809225918.21523-1-kuniyu@amazon.com/

13353599: [mptcp-next,1/9] Squash to "mptcp: add struct mptcp_sched_ops"
13353600: [mptcp-next,2/9] Squash to "mptcp: add scheduler wrappers"
13353601: [mptcp-next,3/9] Squash to "mptcp: register default scheduler"
13353602: [mptcp-next,4/9] Squash to "selftests/bpf: Add mptcp sched
structs"
13353603: [mptcp-next,5/9] Squash to "selftests/bpf: Add bpf_first
scheduler"
13353604: [mptcp-next,6/9] Squash to "selftests/bpf: Add bpf_bkup scheduler"
13353605: [mptcp-next,7/9] Squash to "selftests/bpf: Add bpf_rr scheduler"
13353606: [mptcp-next,8/9] Squash to "selftests/bpf: Add bpf_red scheduler"
13353607: [mptcp-next,9/9] Squash to "selftests/bpf: Add bpf_burst
scheduler":
      - Series: Update scheduler refactor commits
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=776195&state=*&archive=both

13355945: [mptcp-next] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set":
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/ee69d8a0379e89d8b194d753129d09d986f7e674.1692247869.git.geliang.tang@suse.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

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
      - Status: same as at the last meeting

13294008: [iperf3] add MPTCPv1 support:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/
      - Status: same as at the last meeting

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
      - Status: same as at the last meeting

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
      - Status: same as at the last meeting

13349487: [RFC,mptcp-next,01/11] Squash to "mptcp: add struct
mptcp_sched_ops"
13349488: [RFC,mptcp-next,02/11] Squash to "mptcp: add scheduler wrappers"
13349489: [RFC,mptcp-next,03/11] mptcp: use snd_burst wrappers
13349490: [RFC,mptcp-next,04/11] Squash to "mptcp: register default
scheduler":
    - Rejected: waiting for the refactoring of the sched API

13357448: [mptcp-next,v3,1/5] Squash to "selftests/bpf: Add bpf_bkup
scheduler"
13357449: [mptcp-next,v3,2/5] Squash to "selftests/bpf: Add bpf_rr
scheduler"
13357450: [mptcp-next,v3,3/5] Squash to "selftests/bpf: Add bpf_burst
scheduler"
13357451: [mptcp-next,v3,4/5] selftests/bpf: Add bpf_stale scheduler
13357452: [mptcp-next,v3,5/5] selftests/bpf: Add bpf_stale test:
      - State: New
      - Series: add bpf_stale scheduler
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=777313&state=*&archive=both
      - Needs to be reviewed, Mat will look at that
      - maybe we should add somewhere that it is different from "core"'s
feature with the same name.

13359013: [mptcp-next] Squash to "selftests/bpf: Add bpf_stale
scheduler, v3":
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/03cc6fd8df7127486257bf1dfb2191115b142533.1692588823.git.geliang.tang@suse.com/
      - See above

13358761: [mptcp-next,v5,1/9] selftests: mptcp: update userspace pm add
helpers
13358762: [mptcp-next,v5,2/9] selftests: mptcp: update userspace pm rm
helpers
13358763: [mptcp-next,v5,3/9] selftests: mptcp: userspace pm remove id 0
subflow
13358764: [mptcp-next,v5,4/9] mptcp: userspace pm allow creating id 0
subflow
13358765: [mptcp-next,v5,5/9] selftests: mptcp: userspace pm create id 0
subflow
13358766: [mptcp-next,v5,6/9] mptcp: userspace pm remove id 0 address
13358767: [mptcp-next,v5,7/9] selftests: mptcp: userspace pm remove id 0
address
13358768: [mptcp-next,v5,8/9] selftests: mptcp: simplify checksum_tests
13358769: [mptcp-next,v5,9/9] selftests: mptcp: simplify
deny_join_id0_tests:
      - State: New
      - Series: userspace pm remove id 0 subflow & address
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=777697&state=*&archive=both
      - Matth will review the v5 → TODO

13359578: [mptcp-iproute,1/3] ss: mptcp: display info counters as unsigned
13359580: [mptcp-iproute,2/3] ss: mptcp: display seq related counters as
decimal
13359579: [mptcp-iproute,3/3] ss: mptcp: print missing info counters:
      - State: New
      - Series: ss: mptcp: print new info counters
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=777932&state=*&archive=both
      - Can be sent to netdev → TODO: Done

13360307: [mptcp-net,1/2] mptcp: move __mptcp_error_report in protocol.c
13360308: [mptcp-net,2/2] mptcp: process pending subflow error on close:
      - State: New
      - Series: mptcp: fix missing close transition
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=778115&state=*&archive=both
      - Fixing one of the issues from #427






Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 427):


  428  `mptcp_info`: expose if the initial subflow has been removed /
total number of subflows [enhancement]:
      - Would be good to create one additional subflow, remove the two
subflows and check the counters


    Bugs (opened, flagged as "bug" and assigned)

  391  PM: userspace: unable to create additional subflows with the
local addr ID 0 [bug] [pm] @geliangtang
  379  userspace pm: ability to send `RM_ADDR` for all local IDs used (0
included) [bug] [pm] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  427  possible mptcp regression in v6.4 kernel? [bug]::
      - 2 issues:
          - one is fixed by patches above (missing close transition):
              - should be possible to at least trigger some code path,
maybe not reproducing the issue.
          - the other one needs to be validated with the test patch
Paolo sent only on the GH issue
      - TODO → Matth: split the two issues → Done

  424  KMemLeak around `__register_sysctl_table` [bug]:
      - Maybe linked to issue 398
      - increasing a timeout within kmemleak to allow RCU related memory
to be freeed later might fix the issue

  420  syzkaller: WARNING in `__mptcp_move_skbs_from_subflow` [bug]
[syzkaller]
  416  No new subflow when removing an endpoint and adding a new one [bug]

  398  syzkaller: memory leak in `subflow_ulp_init` [bug] [syzkaller]:
      - Christoph will send a message to KMemleak maintainer (+ cc mm &
mptcp?)

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

   79  allow 'force to MPTCP' mode: BPF [enhancement] [bpf] @geliangtang
      - see patches above
      - TODO: close: Matth → Done

   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang
      - see patches above

   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang


    Assigned Questions (opened, questions and assigned)

None.


    Open questions (opened, questions and not assigned)

  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned assigned)

  428  `mptcp_info`: expose if the initial subflow has been removed /
total number of subflows [enhancement]
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


    Recently closed (since 2023-08-15)

None.


mptcpd issues:
    - https://github.com/multipath-tcp/mptcpd/issues/281:
        - TODO: add one issue to change default config not to add LL
IPv6 addresses → Done: #283
        - main issue: when an IP is removed, the linked endpoint is not
removed → dedicated issue in #282



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

    - Features for net-next: /

    - Features for net-next (next): /

    - Features for other trees:

        - [e147c987aa95] mptcp: refactor push_pending logic (Geliang Tang)
        - [5bd99c7858a4] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [64476f992273] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [b13f1cc896bc] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [bf0c5c3e908b] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [ff1ad7cc9007] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [bb554e5b0750] mptcp: add scheduler wrappers (Geliang Tang)
        - [44cfa49cca3a] mptcp: use get_send wrapper (Geliang Tang)
        - [3e6db34dd1cd] mptcp: use get_retrans wrapper (Geliang Tang)
        - [c4085b4cec1d] mptcp: register default scheduler (Geliang Tang):
            - Mat sent them ↑ to netdev

        - [b85ba0611fea] mptcp: add sched_data helpers (Geliang Tang)
        - [43588bb9cc28] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [2e5e8a58206a] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [73a05deb2997] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [6a301d54bb0f] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [b5f5b708cbff] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [69657472c2bc] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [b46125f43c4d] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [baec0174800e] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [b8be3db23ce1] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [e0930f8260de] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [f25f49d21e0a] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [bd5e765453f7] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [b116b8d6d926] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [501efd53d493] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [48b8c89ee201] selftests/bpf: Add bpf_burst test (Geliang Tang)




Extra tests:
    - news about Syzkaller? (Christoph):
        - Christoph is adding coverage for the new sockopt and netlink
commands
        - it is possible to extract the token from previous connections
and "inject" netlink commands that makes sense

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - Cirrus free usage limits starting in September:
https://cirrus-ci.org/blog/2023/07/17/limiting-free-usage-of-cirrus-ci/
        - 60 credits but we use 240-280
        - reduce number of CPUs (mainly used to build, we have the
cache) from 4 to 2?
        - and reduce the global timeout in case some tests stall
        - (split in two projects: one for export*/* tags, one for patchew/*)
        - local resources?
        - pay credits?
        - move?
        - might not be enough...
        - → idea: try running the tests on GH Actions → TODO Matth



max number of subflows:
    - currently limited to 8 by the in-kernel PM (like the add-addr)
    - limiting endpoints to 8 makes sense (arrays are used) but not subflows
    - Matth was going to suggest to increase this limit but
MPTCP_SUBFLOWS_MAX in packet sched in BPF...
    - limit to 64 subflows, not UINT8 → operations in bottom half, 8x8
    - add test using 64 subflows

in-kernel PM: Fullmesh: one extra subflow?
    - 3x3:
        - from 10.0.1.2 to 10.0.1.1
        - limit 255
        - endpoints:
            - ns1:
                - 10.0.2.1 id 1 signal
                - 10.0.3.1 id 2 signal
            - ns2:
                - 10.0.1.2 id 1 subflow fullmesh
                - 10.0.2.2 id 2 subflow fullmesh
                - 10.0.3.2 id 3 subflow fullmesh
        - 1 MPC:
            - 10.0.1.2 > 10.0.1.1
        - 10 MPJ are seen:
            - 10.0.1.2 > 10.0.2.1
            - 10.0.2.2 > 10.0.2.1
            - 10.0.3.2 > 10.0.2.1
            - 10.0.2.2 > 10.0.1.1
            - 10.0.2.2 > 10.0.2.1 # dup
            - 10.0.3.2 > 10.0.1.1
            - 10.0.3.2 > 10.0.2.1 # dup
            - 10.0.1.2 > 10.0.3.1
            - 10.0.2.2 > 10.0.3.1
            - 10.0.3.2 > 10.0.3.1
    - → TODO: new issue for this dup config → Done



Next meeting:
    - Next one on Tuesday, the 29th of August.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230829



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
