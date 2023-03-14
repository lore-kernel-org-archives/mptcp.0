Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD35A939
	for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 19:01:49 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id ek18so35015765edb.6
        for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 12:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678820508;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh6qWuhLoVvBR8zo6ghV+4QR2YR43pM4zkJ23hqB5tM=;
        b=MuYD4lpkgbofpXm8LygvVC14tzcG55HkMTJ7+U7KTCci+VdC8gbi0NQsUrirHMqTqv
         6UFrhaMezK58Us/fjD3vr3myPCmgu9YtVYfgh3sNY9Et6l5x2ga7HH3jcnM1BHOgZZrj
         F/hvZeRc8dcw8VROJlKpBGc6w1uDArgZR3NC9Et8gZow8wxeP28zovHDXLdT24YJVZgS
         1LuE9dJGrr4s6uFfFg0mXRVcRZT5eG7nB+Akxr8nTPnchpjGGXkTdyD0FPGSu1nRsUWr
         Ur/8tc+BmC4S4S+jSMIirCviI2HBRKbuCqulpgDKoAPMqMfJaghueFUw5+SR0eGJQV5b
         S8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678820508;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zh6qWuhLoVvBR8zo6ghV+4QR2YR43pM4zkJ23hqB5tM=;
        b=u0G0ff8wnwYMUI7kq1qdFJ7gTs8gop6KEcs78cexNz/qo3PFxKrVVsFiCOZVwu2P07
         g/px4xG7tyFLRAJnN/LwNXhwMlya2y2FUhrjUE3FHOjJdaV8xKCNlaBPQO+XSwC/7UmC
         fZGp/ELsgm90QIpb1QfFjonyCkJVNHJXodugfXxWhXJiese1TQqidGCglzeMNINrhYBh
         WlriI3yTVBpT4W3N6aIzWgFo3C7Qp5vU0Cz9PLuljYyBY9NiUnilvIguhuLIeDaWtR/n
         sz0lfBpnG75Ot+ehFsHx9QDKvf+7WhlZlfyq53IoG1QoHiceZyNfnMsSaz/wNEj3KCAI
         i6NQ==
X-Gm-Message-State: AO0yUKW01kH6h3EHAMhsqsNX8YmkgNU2jGokwdu4Yp+G6EEs/LI4Es+2
	kqEtBsysITfNKGnuN674d1K3yos+7v1xEdAAIYs=
X-Google-Smtp-Source: AK7set+8mTlxKFpk1zaNT5fFEBgMRNkTj9uW/DPh6vI4Nz6+I3QxsyqPuHZkuZLp1cHnzgLis3XoBQ==
X-Received: by 2002:a17:906:3ada:b0:900:a150:cea3 with SMTP id z26-20020a1709063ada00b00900a150cea3mr3826753ejd.9.1678820507649;
        Tue, 14 Mar 2023 12:01:47 -0700 (PDT)
Received: from [192.168.3.222] ([213.211.148.158])
        by smtp.gmail.com with ESMTPSA id dr9-20020a170907720900b008ca52f7fbcbsm1497614ejc.1.2023.03.14.12.01.47
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 12:01:47 -0700 (PDT)
Message-ID: <f0b90a7b-032a-f9a2-f5c5-f38eef2bb1b0@tessares.net>
Date: Tue, 14 Mar 2023 20:01:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 14th of March 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Today, we just had our 233rd meeting with Christoph (Apple), Davide (Red
Hat), Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13167662: [net,v2,1/8] mptcp: fix possible deadlock in subflow_error_report
13167663: [net,v2,2/8] mptcp: refactor passive socket initialization
13167664: [net,v2,3/8] mptcp: use the workqueue to destroy unaccepted
sockets
13167665: [net,v2,4/8] mptcp: fix UaF in listener shutdown
13167666: [net,v2,5/8] selftests: mptcp: userspace pm: fix printed values
13167667: [net,v2,6/8] mptcp: add ro_after_init for tcp{,v6}_prot_override
13167668: [net,v2,7/8] mptcp: avoid setting TCP_CLOSE state twice
13167669: [net,v2,8/8] mptcp: fix lockdep false positive in
mptcp_pm_nl_create_listen_socket():
      - Series: mptcp: fixes for 6.3
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=728303&state=*&archive=both


    our repo (by: Geliang Tang, Matthieu Baerts, Paolo Abeni):

13150136: [mptcp-net] mptcp: do not fill info not used by the PM in used:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230223-mptcp-diag-info-limits-in-kernel-pm-v1-1-699561f9f9f4@tessares.net/

13162145: [mptcp-next,1/2] mptcp: avoid unneeded address copy
13162146: [mptcp-next,2/2] mptcp: simplify subflow_syn_recv_sock():
      - Series: mptcp: a couple of cleanups
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=727047&state=*&archive=both

13167349: [mptcp-next,v4] selftests: mptcp: add mptcp_info tests:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/4b8fae0280f74cb4678677a112113bbbc2b27d5a.1678365107.git.geliang.tang@suse.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Jiapeng Chong, Matthieu Baerts):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
12321111: mptcp: Remove redundant assignment to remaining:
      - State: RFC
      - Series: mptcp: Remove redundant assignment to remaining
      - Submitter: Jiapeng Chong
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=500495&state=*&archive=both
      - status: same as last week

13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
      - State: Changes requested
      - Series: BPF redundant scheduler, part 3
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
      - status: same as last week

13173788: [mptcp-next,v5,1/7] mptcp: don't clear userspace pm addr id
13173789: [mptcp-next,v5,2/7] mptcp: add addr into userspace pm list
13173790: [mptcp-next,v5,3/7] mptcp: close remote subflow when destroying it
13173791: [mptcp-next,v5,4/7] mptcp: increase userspace pm add_addr_signaled
13173792: [mptcp-next,v5,5/7] mptcp: update userspace pm subflows
13173793: [mptcp-next,v5,6/7] mptcp: make
userspace_pm_append_new_local_addr static
13173794: [mptcp-next,v5,7/7] selftests: mptcp: check userspace mptcp_info:
      - State: New
      - Series: mptcp: update userspace pm mptcp_info fields
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=729763&state=*&archive=both
      - it needs reviews
      - Matt can look at them



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 368):

  371  syzkaller: WARNING in `inet_csk_listen_stop` [bug] [syzkaller]:
      - but no reproducers

  369  syzkaller: BUG: soft lockup in `inet_release` [bug] [syzkaller]:
      - but no reproducers


    Bugs (opened, flagged as "bug" and assigned)

  329  PM: userspace: update `MPTCP_INFO` fields [bug] [pm] @geliangtang:
      - see patches above

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni:
      - see patches in our tree (and discussions below)


    Bugs (opened and flagged as "bug" and not assigned)

  371  syzkaller: WARNING in `inet_csk_listen_stop` [bug] [syzkaller]
  369  syzkaller: BUG: soft lockup in `inet_release` [bug] [syzkaller]
  368  selftests: skip tests not being supported by older kernels [bug]
[selftests]
  364  syzkaller: memory leak in `tcp_get_metrics` [bug] [syzkaller]
  363  syzkaller: BUG: soft lockup in `mptcp_retransmit_timer` [bug]
[syzkaller]
  360  syzkaller: INFO: rcu detected stall in `mptcp_pm_add_timer` [bug]
[syzkaller]
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
  340  netlink: switch to YAML Netlink specs [enhancement] @dcaratti
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   75  BPF: packet scheduler [enhancement] [sched] @geliangtang
   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

  307  TCP performance better than MPTCP [question] @matttbe


    Open questions (opened, questions and not assigned)

  326  Issue with streaming traffic with MPTCP upstream implementation
[question]


    For later (opened and not assigned assigned)

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


    Recently closed (since 2023-03-07)

  372  WARN: `drivers/net/veth.c:1265` suspicious
`rcu_dereference_check()` usage! [bug] [selftests]
  370  export-net: WARNING at `lib/debugobjects.c:509`
(`debug_print_object()`) [bug]
  356  syzkaller: memory leak in `subflow_create_ctx` [bug] [syzkaller]
  330  PM: in-kernel: `MPTCP_INFO`: document and support
`mptcpi_subflows` for the server side [enhancement] [pm] @geliangtang
   61  move msk clone after ctx creation [enhancement]



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.4):
https://github.com/orgs/multipath-tcp/projects/2/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1



Patches to send to netdev:

    - Fixes for other trees:

        - [c1f1d2bc0afd] veth: fix WARNING: suspicious RCU usage
(Matthieu Baerts):
            - to fix an issue in veth used by our selftests


    - Fixes for -net: /

    - Fixes for net-next: /

    - Features for net-next:

        - [1f9c072c9b6b] mptcp: use mptcp_schedule_work() instead of
open-coding it (Paolo Abeni)
        - [cc252789d48c] mptcp: drop unneeded argument (Paolo Abeni)
        - [d98a2cd4bc7f] mptcp: avoid unneeded __mptcp_nmpc_socket()
usage (Paolo Abeni)
        - [8e4bc2df5ec9] mptcp: move fastopen subflow check inside
mptcp_sendmsg_fastopen() (Paolo Abeni)
        - [8571da31edac] mptcp: move first subflow allocation at mpc
access time (Paolo Abeni)
        - [8baf32b39aeb] mptcp: fastclose msk when cleaning unaccepted
sockets (Paolo Abeni)
        - [3542be39dab4] inet: factor out locked section of
inet_accept() in a new helper (Paolo Abeni)
        - [bfe75236961a] mptcp: refactor mptcp_stream_accept() (Paolo Abeni)
        - [19ee5b9747df] mptcp: avoid unneeded address copy (Paolo Abeni)
        - [7a9157bef328] mptcp: simplify subflow_syn_recv_sock() (Paolo
Abeni)
        - [743a6aad3870] mptcp: do not fill info not used by the PM in
used (Matthieu Baerts)
        - [68b6e957e745] selftests: mptcp: add mptcp_info tests (Geliang
Tang):
            - some patches here (the ones from Paolo) depend on patches
currently only in -net:
                - we need to wait for the end of the week to send them
                - TODO: Matth: send them on Friday → scheduled

            - the two last patches can be sent "now" (or we wait for the
others → can wait)


    - Features for net-next (next): /

    - Features for other trees:

        - [bf01c776baab] security, lsm: Introduce
security_mptcp_add_subflow() (Paolo Abeni)
        - [5673f20abae1] selinux: Implement mptcp_add_subflow hook
(Paolo Abeni):
            - @Paolo: did you get any feedback from Paul Moore about that?

        - [22be96d7cf6e] mptcp: refactor push_pending logic (Geliang Tang)
        - [55e42234a74e] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [a3e308098ce7] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [a90cc7dde518] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [88e8f8d0074c] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [e2bba112bda1] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [3503d14796ab] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [cb0ea87da905] mptcp: add scheduler wrappers (Geliang Tang)
        - [78a026559374] mptcp: use get_send wrapper (Geliang Tang)
        - [f9af71bd8fbf] mptcp: use get_retrans wrapper (Geliang Tang)
        - [e452bbbc4f19] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [3f2fe85975bf] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [f8e162440d39] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [55bb18f2219c] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [ffbdf382f6b0] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [21f17b4abb96] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [b450fd67ad3b] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [dffb809665ae] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [851a3952f95a] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [d95f751262be] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [1877949e7e78] selftests/bpf: Add bpf_red test (Geliang Tang):
            - Status: same as last week: depends on the scheduler API
refactoring



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - still working
        - People from TC might be interested to have their patches being
tested by a CI like we do
        - https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
can be extended to support other components
        - e.g. to override the path to the "config" instead of the one
from MPTCP selftests or to run other selftests

    - CI (Matth):
        - /


Workshop:
    - devconf cz:
        - CfP has been extended
        - but only ~80 minutes for a workshop: short!

    - could be good to co-locate it with netdev:
        - good to have more people joining than a dedicated event?
        - but we still don't know when it will be
        - but we are not in a hurry
        - TODO: Matth: send an email to Jamal → done

    - Tessares can host the event:
        - we can have big enough meeting rooms
        - (and fries, beers, waffles, chocolate, etc.)
        - but it might not be co-located with other big events (FOSDEM?)
        - is it a blocking point?


Other topics:
    - TODO: Matt change time in the US → Done



Next meeting:
    - Next one on Tuesday, the 21st of March.
    - 16:30 UTC (9.30am PDT, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230314



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
