Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060772F32
	for <mptcp@lists.linux.dev>; Thu, 23 Mar 2023 12:37:31 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso1078533wms.1
        for <mptcp@lists.linux.dev>; Thu, 23 Mar 2023 05:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1679575049;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXF3er0u7wW69HyBO8vnwup0Abj2hwgwQUEUvBPn9CQ=;
        b=rs3wiuLHcqo1aXqDRZkgKArP4WuRIevqmpiD8hdSMpXH3tWCd9VgxBspbCJrBFCLS+
         sYpEiaTls/zBs02KJoE1yGmfQ931p2Va9zu8n9v74yNNBjEdxydR8ceB6MPlkAqZPczr
         I8Mc72pyRe55uaashiKmHQ57/bJnk8tPPrPAmCUUm6h3kXEMKVJU7J/+SQfoVK5Siwy3
         ONpb8kpnnXDRFyi4ZXlbN1hHDXCJ6i8wF/1z1OmBchXmSxt9K6wvvCFSDyCyRxbJ/M0h
         StKi6/1bdQOrR/8tYhxMN1Esk5ZgTk1v+j0ib+h7OiS5Z90/L/s/Ns/gx1oqiZhAYhss
         v/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679575049;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NXF3er0u7wW69HyBO8vnwup0Abj2hwgwQUEUvBPn9CQ=;
        b=NWOLWr7W1UvbkDAg/l8gjVdEA5DDoKsOGFBdxrrV9Yw/+5GnGqWvnKyZKKSPfkLeuY
         /22GnBb+VcVnY/558ru1Oib+kUiRZ3/z7wShSisWsuyQPCW1D9jKBaxxzn5gqHJ3Mq0D
         uCI1u09hNJQaKIdo7JbRiXmqD23QJooLWoLdyZVi8fr88SshIEmm/8WqTNqF3gfawMr9
         vyh0DPgV85k1AYl+yt3cD5ENYZR//rPsiX23P81H6modOTj485b+CHsP50yDu13XkkLj
         lmLe3psdC+Hn6xhcWnfqO//48IV2sZVP6hgEK4q2MUiHoASD2TkIDNJiTPM0RtbD/lRx
         B/tw==
X-Gm-Message-State: AO0yUKVMpfGW5fCKTjI2Z0bAt9V37pogRBdbz8sxo3a+FOkCTdjLoSDg
	aY9KV3//I14SBqnNc0cZFAbLjCcu8Ntai+YWAZLeqg==
X-Google-Smtp-Source: AK7set87tssAAhHUow04jjtlCkzUi3WEjkW0mN16eDNcVOwXOkOj3wUC5sQ60zfTVSiA4HiKfKLPQA==
X-Received: by 2002:a1c:f303:0:b0:3ed:a5a2:145 with SMTP id q3-20020a1cf303000000b003eda5a20145mr2241318wmq.6.1679575049451;
        Thu, 23 Mar 2023 05:37:29 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:4630:226c:6b5f:eaf7? ([2a02:578:8593:1200:4630:226c:6b5f:eaf7])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c419300b003ee581f37a9sm1780918wmh.10.2023.03.23.05.37.29
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 05:37:29 -0700 (PDT)
Message-ID: <40c4f501-3a56-7bba-0e76-4f9ea21a0606@tessares.net>
Date: Thu, 23 Mar 2023 13:37:28 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 21st of March 2022
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Tuesday, we had our 234th meeting with Christoph (Apple), Paolo
(Red Hat), Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13176633: [net] hsr: ratelimit only when errors are printed:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230315-net-20230315-hsr_framereg-ratelimit-v1-1-61d2ef176d11@tessares.net/
      - not related to MPTCP, linked to a conflict between net and net-next


    our repo (by: /):

/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: David Howells, Matthieu Baerts):

13176459: [1/2] docs: process: allow Closes tags with links
13176460: [2/2] checkpatch: allow Closes tags with links:
      - Series: docs & checkpatch: allow Closes tags with links
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=730449&state=*&archive=both
      - Supported by Konstantin (IT director @LF) for the new Bugzilla bot
      - Linus is not against it but he thinks it can be misused

13177878: [RFC,28/28] sock: Remove ->sendpage*() in favour of
sendmsg(MSG_SPLICE_PAGES):
      - Series: -
      - Submitter: David Howells
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=730864&state=*&archive=both
      - removing sendpage() from everywhere, not just MPTCP:
          - we rely on TCP for that anyway


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
      - Status: same as last week

13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
      - State: Changes requested
      - Series: BPF redundant scheduler, part 3
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
      - Status: same as last week

13173788: [mptcp-next,v5,1/7] mptcp: don't clear userspace pm addr id
13173789: [mptcp-next,v5,2/7] mptcp: add addr into userspace pm list
13173790: [mptcp-next,v5,3/7] mptcp: close remote subflow when
destroying it:
    - if the userspace PM is managing the connection, it is up to the
userspace daemon to send the remove address
    - the userspace PM can only remove addresses that have been announced:
        - it makes sense on the other hand...
        - (can we remove ID 0? TODO check: Matth → no we cannot: #379)
        - except if a subflow got "rejected" or the IP got lost before
having been able to send the FIN packets
    - does the in-kernel PM send RM addresses while it is not needed?:
        - it does but it sends them when the whole endpoint is removed,
it makes more sense there to cover all cases

13173791: [mptcp-next,v5,4/7] mptcp: increase userspace pm add_addr_signaled
13173792: [mptcp-next,v5,5/7] mptcp: update userspace pm subflows
13173793: [mptcp-next,v5,6/7] mptcp: make
userspace_pm_append_new_local_addr static
13173794: [mptcp-next,v5,7/7] selftests: mptcp: check userspace mptcp_info:
      - State: Changes requested
      - Series: mptcp: update userspace pm mptcp_info fields
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=729763&state=*&archive=both
      - See discussions on patch 3/7



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 372):

  378  Very noisy `addr_signal error` [bug]:
      - should probably be tracked by a MIB counter instead
      - can happen when:
          - we try to remove multiple addresses but we only do once at a
time
          - we suppose it is only happening with the in-kernel PM
          - the RM_ADDR will all be sent at some points
      - we should track the error but in a less impacting way

  377  BUG: soft lockup in `ip_rcv` [bug] [syzkaller]:
      - maybe linked to an issue with qdisc

  376  KASAN: slab-use-after-free Read in `ip_mc_drop_socket` [bug]
[syzkaller]
  375  syzkaller: WARNING: refcount bug in `__mptcp_close` [bug] [syzkaller]
  374  syzkaller: divide error in `__tcp_select_window` [bug]
[syzkaller] [reproducer] [bisected]:

  373  checkpatch: `Closes` tag is no longer accepted [bug] @matttbe:
      - see patches above


    Bugs (opened, flagged as "bug" and assigned)

  373  checkpatch: `Closes` tag is no longer accepted [bug] @matttbe:
      - see patches above

  329  PM: userspace: update `MPTCP_INFO` fields [bug] [pm] @geliangtang:
      - see patches above

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni:
      - see patches in our tree


    Bugs (opened and flagged as "bug" and not assigned)

  378  Very noisy `addr_signal error` [bug]
  377  BUG: soft lockup in `ip_rcv` [bug] [syzkaller]
  376  KASAN: slab-use-after-free Read in `ip_mc_drop_socket` [bug]
[syzkaller]
  375  syzkaller: WARNING: refcount bug in `__mptcp_close` [bug] [syzkaller]

  374  syzkaller: divide error in `__tcp_select_window` [bug]
[syzkaller] [reproducer] [bisected]:
      - Paolo is looking at that one

  371  syzkaller: WARNING in `inet_csk_listen_stop` [bug] [syzkaller]
[reproducer] [bisected]:
      - Paolo is looking at that one

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

   75  BPF: packet scheduler [enhancement] [sched] @geliangtang:
       - See patches above

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


    Recently closed (since 2023-03-14)

None.



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.4):
https://github.com/orgs/multipath-tcp/projects/2/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net: /

    - Fixes for net-next: /

    - Features for net-next:

        - [a9fab80f14a5] mptcp: use mptcp_schedule_work() instead of
open-coding it (Paolo Abeni)
        - [ab390d6617e6] mptcp: drop unneeded argument (Paolo Abeni)
        - [69061b7bfe9f] mptcp: avoid unneeded __mptcp_nmpc_socket()
usage (Paolo Abeni)
        - [50e55071bb76] mptcp: move fastopen subflow check inside
mptcp_sendmsg_fastopen() (Paolo Abeni)
        - [dc7723f41605] mptcp: move first subflow allocation at mpc
access time (Paolo Abeni)
        - [46805dd809e0] mptcp: fastclose msk when cleaning unaccepted
sockets (Paolo Abeni)
        - [50934ea2ceb7] inet: factor out locked section of
inet_accept() in a new helper (Paolo Abeni)
        - [3a244d816683] mptcp: refactor mptcp_stream_accept() (Paolo Abeni)
        - [6bb6106f5795] mptcp: avoid unneeded address copy (Paolo Abeni)
        - [6f7a877ea1a3] mptcp: simplify subflow_syn_recv_sock() (Paolo
Abeni):
            - can wait a bit: maybe issues reported by syzkaller are
linked to these ones

        - [75d2efd3a0f4] mptcp: do not fill info not used by the PM in
used (Matthieu Baerts)
        - [33bc2fe3e569] selftests: mptcp: add mptcp_info tests (Geliang
Tang):
            - can be sent

    - Features for net-next (next): /

    - Features for other trees:

        - [35b8c988783d] security, lsm: Introduce
security_mptcp_add_subflow() (Paolo Abeni)
        - [99e09105772e] selinux: Implement mptcp_add_subflow hook
(Paolo Abeni):
            - depends on patches that are queued for net-next
            - Paolo will check with Paul Moore

        - [675d7d05739e] mptcp: refactor push_pending logic (Geliang Tang)
        - [84edc1a5a693] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [38460a641f4d] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [029f8f223fbd] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [d271868cf06a] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [57a8b361d475] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [9bdfa4a53c4c] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [dc712a6fa324] mptcp: add scheduler wrappers (Geliang Tang)
        - [cc984d6225da] mptcp: use get_send wrapper (Geliang Tang)
        - [4d1768966062] mptcp: use get_retrans wrapper (Geliang Tang)
        - [77edbc8cfa2b] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [21e752eeaa77] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [ff7c87f53efc] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [d73289041c8a] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [fb7b4cca2fa3] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [895d211a43f7] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [15e8350175de] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [5605fa4e4508] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [265d592334f3] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [66b7873c7561] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [ec90bb8bf926] selftests/bpf: Add bpf_red test (Geliang Tang):
            - wait for the rework of the sched API



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



Workshop:
    - It might be difficult to pick a place that is good for everybody
due to travel budget restrictions in many different companies
    - Maybe easier/better to have it in Europe for the first edition to
hopefully have more people coming?
    - Locations might be:
        - Belgium (Louvain-la-Neuve)
        - Italy (Pisa)



Tests @Linero:
    - issues with Busybox:
        - they can fix that, we can report it to them
    - run the selftests from the same kernel version as the one being
tested?:
        - not what they do for the moment
        - it seems they don't want to change that
        - hard for us:
            - maintenance / complexity to have that in place
            - checking behaviour and not interface/feature: hard to
detect everything
            - if not all tests can succeed or be skipped, it makes the
tests results useless
    - selftests with >100 subtests: if one fails, everything is marked
as failed:
        - use TAP features to track subtests? TODO



Next meeting:
    - Next one on Tuesday, the 28th of March.
    - /!\ at a different UTC time!!!
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230328



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
