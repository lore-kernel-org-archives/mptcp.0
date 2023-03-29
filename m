Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F71AFCB
	for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 08:36:21 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id i9so14809269wrp.3
        for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 01:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680078979;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqKj+T986u4xgoyOCIen6Ezr587k07aBxEPIpiMt+JE=;
        b=L896wkmznRzZQJXBobJ8o8p6s51R62Q9bAo5Cql9YEo7rI83uu5V1Q1azXUDY+phTb
         ddiAuxbGze/jvyFowbkG0GQjJpbMLISqGwbA6BMzYfXRtkCcIEcOxphGfOVyxl1Axf0F
         w5ZeImb5CifZPSIWQ+YTjttPRgqZtUh4reGrg+ptxjagnqm8KRdnt52kMUEuGcpeKsWC
         DQ5mnVvqkN0+Q5HWdFSJcss0GjdD97IUuWRmj+qQrMgqz6k8vU3CvY8R04GAkLvEdwfU
         taM4P0wSVeLAgsAhQBQZhbyL7SZUQMDZi2SA/ZTtvUMMnT0iBplXN6FKgbSB0oj/Sfrr
         0eYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680078979;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pqKj+T986u4xgoyOCIen6Ezr587k07aBxEPIpiMt+JE=;
        b=TMPUMzk2weUH7lhUjBd0tyzx8m1RYLaBZU4qzFehLaGzxlVUSYZLMVi3jw3goymUaB
         yxW676nVn5N3E1jjIzxFKs1O5yrAiF5VFzywVlyn7qsuKHVb+6aEJHE8dFpgx9zzvB44
         OVcx8s4I+mPcbDqTI2yJFH6zovtFjl+86xuV5Paw1ahPNuHDFjj7AzP/XU54A3LVA2yG
         a/ifLpGpuiFgCIzZiz8OfhauXaBr+o0sxmhC1oHmeajGh5hlrN2FkfzMH5jkK3r1Y8H/
         Nc5fSaYoGFxHujHMIJkxAmGr3gYvzxF7wEQLY6eOarUZIqpBmyPc73q65Auq9efWzejV
         hxUw==
X-Gm-Message-State: AAQBX9cQWIKEMS2wckk/CH4iVBOQbioXR6msyJ/WgPVF9LGtyT8jBE0R
	4C7WqmKjJ03YXiFrvZcrzvxw6XnX4RinX4+0eXY2by7X
X-Google-Smtp-Source: AKy350Z+rb0pYPk7Bi2r4GvH5nKUjz7Zk8z3Aat5C1tAxF3rZ4Qkm638LY1+N6Z0nKbNwQN+PYsQ9A==
X-Received: by 2002:adf:fac5:0:b0:2cf:f2f9:df7a with SMTP id a5-20020adffac5000000b002cff2f9df7amr14136098wrs.38.1680078978708;
        Wed, 29 Mar 2023 01:36:18 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:79fe:97a:4a91:5b93? ([2a02:578:8593:1200:79fe:97a:4a91:5b93])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6e82000000b002c55b0e6ef1sm29913184wrz.4.2023.03.29.01.36.18
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:36:18 -0700 (PDT)
Message-ID: <1f2d39a4-af95-030f-b3c7-84407c6b8810@tessares.net>
Date: Wed, 29 Mar 2023 10:36:17 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 28th of March 2023
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Tuesday, we had our 235th meeting with Christoph (Apple), Paolo,
Davide (Red Hat), Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13185977: [6.1,1/2] mptcp: use the workqueue to destroy unaccepted sockets
13185978: [6.1,2/2] mptcp: fix UaF in listener shutdown:
      - Series: mptcp: Stable backports for v6.1
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=733273&state=*&archive=both


    our repo (by: Paolo Abeni):

13186654: [mptcp-net,1/2] mptcp: use mptcp_schedule_work instead of
open-codying it
13186655: [mptcp-net,2/2] mptcp: stricter state check in mptcp_worker:
      - Series: [mptcp-net,1/2] mptcp: use mptcp_schedule_work instead
of open-codying it
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=733502&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: David Howells, Matthieu Baerts):

13187249: [v2,1/2] docs: process: allow Closes tags with links
13187250: [v2,2/2] checkpatch: allow Closes tags with links:
      - Series: docs & checkpatch: allow Closes tags with links
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=733666&state=*&archive=both
      - Matth is working on a v3

13189008: [net-next,v2,1/4] mptcp: avoid unneeded address copy
13189009: [net-next,v2,2/4] mptcp: simplify subflow_syn_recv_sock()
13189010: [net-next,v2,3/4] mptcp: do not fill info not used by the PM
in used
13189011: [net-next,v2,4/4] selftests: mptcp: add mptcp_info tests:
      - State: New
      - Series: mptcp: a couple of cleanups and improvements
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=734103&state=*&archive=both

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
13173790: [mptcp-next,v5,3/7] mptcp: close remote subflow when destroying it
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
      - Status: same as last week

13186986: [mptcp-net] mptcp: stops worker on unaccepted sockets at
listener close:
      - State: New
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/0e9ef531308d693bb8ff32af03de3827e33940fc.1679672048.git.pabeni@redhat.com/
      - To fix #371 (and #375)
      - But another fix is also needed



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 378):

  379  userspace pm: ability to send `RM_ADDR` for all local IDs used (0
included) [bug] [enhancement] [pm]:
      - the userspace pm can only send a RM_ADDR for addresses it has
announced (ADD_ADDR)
      - it cannot send a RM_ADDR for ID0 or for created subflows
      - can be seen as a bug


    Bugs (opened, flagged as "bug" and assigned)

  377  BUG: soft lockup in `ip_rcv` [bug] [syzkaller] [reproducer]
@dcaratti:
      - looks like a non MPTCP issue
      - TC issue apparently
      - Davide will double check that
      - probably not a dup of #369

  373  checkpatch: `Closes` tag is no longer accepted [bug] @matttbe:
      - see patches above

  329  PM: userspace: update `MPTCP_INFO` fields [bug] [pm] @geliangtang:
      - see patches above

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni:
      - see patches in our tree


    Bugs (opened and flagged as "bug" and not assigned)

  379  userspace pm: ability to send `RM_ADDR` for all local IDs used (0
included) [bug] [enhancement] [pm]
  378  Very noisy `addr_signal error` [bug]
  376  KASAN: slab-use-after-free Read in `ip_mc_drop_socket` [bug]
[syzkaller]

  375  syzkaller: WARNING: refcount bug in `__mptcp_close` [bug]
[syzkaller]:
      - Paolo is looking at it

  371  syzkaller: WARNING in `inet_csk_listen_stop` [bug] [syzkaller]
[reproducer] [bisected]
  369  syzkaller: BUG: soft lockup in `inet_release` [bug] [syzkaller]
  368  selftests: skip tests not being supported by older kernels [bug]
[selftests]
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


    Recently closed (since 2023-03-21)

  380  MPTCPv1 not working: Configuration issue with ip mptcp on Ubuntu
20.04.5 LTS using Mininet 2.3.0.dev6" [question] @matttbe
  374  syzkaller: divide error in `__tcp_select_window` [bug]
[syzkaller] [reproducer] [bisected]
  364  syzkaller: memory leak in `tcp_get_metrics` [bug] [syzkaller]



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.4):
https://github.com/orgs/multipath-tcp/projects/2/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [3e800c2a129e] mptcp: use mptcp_schedule_work instead of
open-coding it (Paolo Abeni)
        - [e697a9ee2084] mptcp: stricter state check in mptcp_worker
(Paolo Abeni):
            - applied yesterday, can wait
            - probably best to wait for a fix for #371 and #375
            - TODO: Matth: check on Friday

    - Fixes for net-next: /

    - Features for net-next:

        - [964e00f67dbb] mptcp: drop unneeded argument (Paolo Abeni)
        - [a860b28b4a90] mptcp: avoid unneeded __mptcp_nmpc_socket()
usage (Paolo Abeni)
        - [87b0279f4ea6] mptcp: move fastopen subflow check inside
mptcp_sendmsg_fastopen() (Paolo Abeni)
        - [aa5e6ebac474] mptcp: move first subflow allocation at mpc
access time (Paolo Abeni)
        - [80b4fcfaa1f3] mptcp: fastclose msk when cleaning unaccepted
sockets (Paolo Abeni)
        - [61fb32672f69] inet: factor out locked section of
inet_accept() in a new helper (Paolo Abeni)
        - [9aa5f036848e] mptcp: refactor mptcp_stream_accept() (Paolo
Abeni):
            - can wait a bit more, check status next week

        - [2999ad8deb3c] mptcp: avoid unneeded address copy (Paolo Abeni)
        - [2a967c0de776] mptcp: simplify subflow_syn_recv_sock() (Paolo
Abeni)
        - [ec9379313325] mptcp: do not fill info not used by the PM in
used (Matthieu Baerts)
        - [fdecaec578d5] selftests: mptcp: add mptcp_info tests (Geliang
Tang):
            - have been sent on Monday

    - Features for net-next (next):

    - Features for other trees:

        - [cae695d728d6] security, lsm: Introduce
security_mptcp_add_subflow() (Paolo Abeni)
        - [e5e15002b197] selinux: Implement mptcp_add_subflow hook
(Paolo Abeni):
            - depends on patches queued for net-next

        - [a9cc68d7189b] mptcp: refactor push_pending logic (Geliang Tang)
        - [aefe4418b9ff] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [3f9caae475f3] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [b58177835232] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [dfd0d4f1595a] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [c23afe2a2a58] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [d364c67bd53f] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [eb86e9d9287f] mptcp: add scheduler wrappers (Geliang Tang)
        - [6689d47bba9c] mptcp: use get_send wrapper (Geliang Tang)
        - [09c5f0804d37] mptcp: use get_retrans wrapper (Geliang Tang)
        - [23aa5802ffd3] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [da2299601efd] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [db745136e59f] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [80c80b49b9fa] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [350eef9d275c] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [8764459fb169] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [b6d7d0d6afa2] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [8079b4bb2b92] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [a13b153cf5f1] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [2345c2c1f6dc] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [adec5f9cea70] selftests/bpf: Add bpf_red test (Geliang Tang):
            - depends on the refactoring of the sched API



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - When a series is sent without a cover-letter, patchew doesn't
apply the series
            - @Davide will check if there is an option or a known issue
linked to that
            - https://github.com/patchew-project/patchew/issues/86

    - CI (Matth):
        - Mostly green
        - TODO: Matth: add patch from Paolo: sleep 0.5 * 2 in
userspace_pm for listen events → done



Workshop:
    - Pisa:
        - conditions: open to students
    - Belgium:
        - might be easier to get more help / support
    - Travel restrictions in many different big coorp are blocking this:
        - probably best to put this on hold for the moment



Next meeting:
    - Next one on Tuesday, the 4th of April.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230404



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
