Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1E6BA45
	for <mptcp@lists.linux.dev>; Tue,  7 Mar 2023 17:58:33 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id c18so8381465wmr.3
        for <mptcp@lists.linux.dev>; Tue, 07 Mar 2023 09:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678211912;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTXFTjq8fquFDii4ZSGm5lSWyynJeEi83mCcEpvYRdE=;
        b=h0IpyzZSf0dxTRsWRFmtYQvzRxk0PPLH4q+FYoGtRuqty1poa5fycpSMuX6XQG7Hpb
         ZkXXav9MbwrvV5+5UhvRbVHPZzV2bDlidYerGosSntRJ70ElAxG22iibfOE6qq6x8rYk
         E2xYKrvJBLLsJ0VoansiAtAM6Ftn520BB0uqh5jEgOPqVDhaB8fb7cJUUeC9/vqteHsQ
         tqSUWx/IV0OfMCHQWQCpzG/W73+PzjX0eSJIKMUtNdyBt9C0ODDtMfwtcE9gO6GKQTBG
         cINCEkFUiHIn9b7ToNtwo0n5ZKsQP9xZIPoOXSuh72I2j6mcHccyPsPkJmYBtq3RyQ1k
         1uTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678211912;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aTXFTjq8fquFDii4ZSGm5lSWyynJeEi83mCcEpvYRdE=;
        b=mngeeQ8mXh8gAo1YOv3TeWdUsmZreZ9mnTqd19ATodYw5lF1G+J7N5A2THGEvZpW9m
         jtO7kaOnhcCaLwVYX02JUZXyP3/rm8lqybxCnESLab6pzkH7dpGUBTI3eDe9DnI2EhQI
         9CpbtiXbwuT0Vu2PKGu2g39PICotNlzL4mswXvlHjOnyRHYc/6PUC2r5Mpnh8eqolhv/
         7Z+IbC8o9RO+nf79Wlc093YIxhiPY49uDLyNUSxWbWT575QsD09rWiDTePMVwRumceXJ
         LpLlafiJcxEsfTUlxNOT7POyQVchjDcyPaz2DLuNr88pZaDYCXS96654IhQUq+ejOVVz
         +J+Q==
X-Gm-Message-State: AO0yUKVT/MRftdEoOOsrgqqE/MS5iDytBBrUuLXrPMkWn0ca8zlH6Vy1
	CmyUSPOhTHmnqApTG3ykszv6Wz/W+85fDPpycX+bQQ==
X-Google-Smtp-Source: AK7set/NFqs5fVlEyeZbTKy0fj8189B0MojbLT9gdAqMMhDgP1/govMHk3dzykHzzruPzFgLbGNotw==
X-Received: by 2002:a05:600c:3512:b0:3ea:e554:7815 with SMTP id h18-20020a05600c351200b003eae5547815mr14523904wmq.9.1678211911612;
        Tue, 07 Mar 2023 09:58:31 -0800 (PST)
Received: from [192.168.3.222] ([213.211.148.158])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d660a000000b002c70ce264bfsm13211427wru.76.2023.03.07.09.58.31
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 09:58:31 -0800 (PST)
Message-ID: <be947e06-719f-bc0f-6032-07bda593c2f2@tessares.net>
Date: Tue, 7 Mar 2023 18:58:30 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 7th of March 2022
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last week, we had our 232nd meeting with Christoph (Apple), Paolo and
Davide (Red Hat), Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:

Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Paolo Abeni):

13155054: [mptcp-net,1/2] Squash-to: mptcp: use the workqueue to destroy
unaccepted sockets
13155055: [mptcp-net,2/2] Squash-to: "mptcp: fix UaF in listener shutdown":
      - Series: [mptcp-net,1/2] Squash-to: mptcp: use the workqueue to
destroy unaccepted sockets
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=725561&state=*&archive=both

13155809: [v2,mptcp-net,1/2] Squash-to: mptcp: use the workqueue to
destroy unaccepted sockets
13155810: [v2,mptcp-net,2/2] Squash-to: "mptcp: fix UaF in listener
shutdown":
      - Series: [v2,mptcp-net,1/2] Squash-to: mptcp: use the workqueue
to destroy unaccepted sockets
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=725766&state=*&archive=both

13156282: [mptcp-net] mptcp: fix possible memory leak on syn_recv race:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/869ca49933fc7983c50a88f2a8b4a680e5eedc5b.1677693276.git.pabeni@redhat.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13153933: [net,1/7] mptcp: fix possible deadlock in subflow_error_report
13153934: [net,2/7] mptcp: refactor passive socket initialization
13153935: [net,3/7] mptcp: use the workqueue to destroy unaccepted sockets
13153936: [net,4/7] mptcp: fix UaF in listener shutdown
13153937: [net,5/7] selftests: mptcp: userspace pm: fix printed values
13153938: [net,6/7] mptcp: add ro_after_init for tcp{,v6}_prot_override
13153939: [net,7/7] mptcp: avoid setting TCP_CLOSE state twice:
      - Series: mptcp: fixes for 6.3
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=725263&state=*&archive=both
      - v2 needed


    our repo (by: Geliang Tang, Jiapeng Chong, Matthieu Baerts, Paolo
Abeni):

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

13127109: [mptcp-next,v3] mptcp: update userspace pm mptcp_info fields:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/7f695489e0ecba3f0951193be81a1620b1f8e6e7.1675410794.git.geliang.tang@suse.com/
      - status: same as last week

13150136: [mptcp-net] mptcp: do not fill info not used by the PM in used:
      - State: Needs ack
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230223-mptcp-diag-info-limits-in-kernel-pm-v1-1-699561f9f9f4@tessares.net/
      - Paolo will have a look

13162145: [mptcp-next,1/2] mptcp: avoid unneeded address copy
13162146: [mptcp-next,2/2] mptcp: simplify subflow_syn_recv_sock():
      - State: Under review
      - Series: mptcp: a couple of cleanups
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=727047&state=*&archive=both
      - can be applied: TODO Matth → done



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 366):

  368  selftests: skip tests not being supported by older kernels [bug]
[selftests]:
      - we can handle some "easy" stuff but not all:
          - easy: check if MPTCP is available, some features (userspace
PM, diag, etc.), etc.
          - hard: what packets the kernel has generated
      - Might be difficult to ask them to change their way of testing
stuff... so some tests will be broken, that's it.
      - Matt can have a look


    Bugs (opened, flagged as "bug" and assigned)

  329  PM: userspace: update `MPTCP_INFO` fields [bug] [pm] @geliangtang:
      - see patches above

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni:
      - see patches in our tree, soon in net-next
      - and see the discussion below


    Bugs (opened and flagged as "bug" and not assigned)

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
  330  PM: in-kernel: `MPTCP_INFO`: document and support
`mptcpi_subflows` for the server side [enhancement] [pm] @geliangtang
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
   61  move msk clone after ctx creation [enhancement]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 2023-02-28)

  367  syzkaller: WARNING in `__mptcp_close_ssk` [bug] [syzkaller]
[reproducer]
  366  syzkaller: WARNING: refcount bug in `inet_csk_listen_stop` [bug]
[syzkaller] [reproducer] [bisected]
  356  syzkaller: memory leak in `subflow_create_ctx` [bug] [syzkaller]



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.4):
https://github.com/orgs/multipath-tcp/projects/2/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [d935baa5c932] mptcp: fix possible deadlock in
subflow_error_report (Paolo Abeni)
        - [8d3df9c2f65d] mptcp: refactor passive socket initialization
(Paolo Abeni)
        - [d5c431b0babf] mptcp: use the workqueue to destroy unaccepted
sockets (Paolo Abeni)
        - [b871d26978ba] mptcp: fix UaF in listener shutdown (Paolo Abeni)
        - [9497187bff5a] selftests: mptcp: userspace pm: fix printed
values (Matthieu Baerts)
        - [ab085c8790b0] mptcp: add ro_after_init for
tcp{,v6}_prot_override (Geliang Tang)
        - [93e2fca10406] mptcp: avoid setting TCP_CLOSE state twice
(Matthieu Baerts)
        - [1ac48c1356d2] mptcp: fix lockdep false positive in
mptcp_pm_nl_create_listen_socket() (Paolo Abeni)
        - [1aac13cb96cc] mptcp: fix possible memory leak on syn_recv
race (Paolo Abeni):
            - can be sent by the end of the week: TODO Matth → scheduled
on Thursday

    - Fixes for net-next: /

    - Features for net-next:

        - [94188af1225f] mptcp: use mptcp_schedule_work() instead of
open-coding it (Paolo Abeni)
        - [1d61335466b8] mptcp: drop unneeded argument (Paolo Abeni)
        - [ae193b3778d7] mptcp: drop legacy code (Paolo Abeni)
        - [832ae0583dea] mptcp: avoid unneeded __mptcp_nmpc_socket()
usage (Paolo Abeni)
        - [1ee0de051c98] mptcp: move fastopen subflow check inside
mptcp_sendmsg_fastopen() (Paolo Abeni)
        - [9ccab3e974e0] mptcp: move first subflow allocation at mpc
access time (Paolo Abeni)
        - [211a93eefb11] mptcp: fastclose msk when cleaning unaccepted
sockets (Paolo Abeni)
        - [d73177075f72] inet: factor out locked section of
inet_accept() in a new helper (Paolo Abeni)
        - [90bc34c46f7d] mptcp: refactor mptcp_stream_accept() (Paolo
Abeni):
            - some of them depend on patches that are for -net here above
            - so best to wait for the ones for net to be accepted then
they can be sent

    - Features for net-next (next): /

    - Features for other trees:

        - [a36ed9fbab14] security, lsm: Introduce
security_mptcp_add_subflow() (Paolo Abeni)
        - [d87e6844fc4d] selinux: Implement mptcp_add_subflow hook
(Paolo Abeni):
            - Paolo will send an email to Paul Moore to check what's the
best to do here:
                - either we wait for the patches above to be in Linus
tree (6.4)
                - or these 2 patches are carried in net-next with the rest

        - [8ea3dca41b80] mptcp: refactor push_pending logic (Geliang Tang)
        - [705f374f8609] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [8f453b49d629] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [4176ff0dd0af] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [461e42275523] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [cf99052095e7] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [dffdad71947f] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [868f223d6d3d] mptcp: add scheduler wrappers (Geliang Tang)
        - [ed8e5e3e4499] mptcp: use get_send wrapper (Geliang Tang)
        - [6e460d956343] mptcp: use get_retrans wrapper (Geliang Tang)
        - [ee1ddd2edc5d] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [fa412466b6a8] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [e0bed03f7f90] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [5ba4bb2f9ad6] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [d49e8f6d6aec] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [407c6840e5e1] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [ce17c59c32bf] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [16faa1769609] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [ef445b026e57] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [d2d2f259ac04] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [412fec910301] selftests/bpf: Add bpf_red test (Geliang Tang):
            - status: same as last week: waiting for the modifications
on the scheduler side



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
        - still mostly green
        - on Linaro side, most selftests are passing except some in
mptcp_join.sh because "cmp --bytes" is not supported
        - maybe "head --bytes X | cmp" is supported?
        - TODO: Matth: check with Linaro guy



MPTCP Workshop:
    - Could be good to list different topics/tracks:
        - MPTCP use cases
        - scheduler
        - PM
        - data exposed to userspace
        - etc.

    - What would be the target:
        - kernel dev
        - userspace dev
        - companies
        - researchers
        - students

    - Could be good to start listing conferences or other events where
we could be linked to:
        - Netdev:
            - next one when? End of the year?
            - Where? North America?
        - IETF:
            - next in March, then July (SF), then November (Prague)

        - DevConf (cz):
            - mid of June

    - would be good to ask our different companies what they think about
that and how they can contribute (financially and/or by hosting it)



Next meeting:
    - Next one on Tuesday, the 14th of March.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230314



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
