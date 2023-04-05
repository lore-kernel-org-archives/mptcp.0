Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6743C37
	for <mptcp@lists.linux.dev>; Wed,  5 Apr 2023 14:27:42 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id v1so36409561wrv.1
        for <mptcp@lists.linux.dev>; Wed, 05 Apr 2023 07:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680704860;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAqJE5iRdqyxNoYq6tUB9bWXs3ubFj/dBrzHMlTLDxo=;
        b=JkkFrlQOnu4uOSx57GKCdoZY4v7oqSaBvvAmUxMGA2NhhRBZ/LwNv59+EZhtLC3+WM
         C5en8LHGFM1gWq3VHNU7j6zfoxq0x0oM5vaoR+FDU4XW1eXZtzAjElsnrYk9wfqld0QA
         6Vt4KFGqfWekUJOmeDb+cQ6+m3R0cYZSyX/CG9HXE7CMFXEjfptwBs2AjpjG4nOuFOTi
         fwIcdx1S4/UiTBUcFtVwKxvca+6RIbrsslU08aBpMAl2TFu9iispwONMRDdrdS9dEsBh
         +s3cS3AkGq12Q9zuJsbJIRGGHNVqovAQrwPfRrL9w4lYvhbCu/AJl3ygYm1fatYaleWo
         QpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680704860;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WAqJE5iRdqyxNoYq6tUB9bWXs3ubFj/dBrzHMlTLDxo=;
        b=whcUHT/ORm98HVatuEn3RRSIOnAfpw6tuMS+W49g9U1P+YygnWqkLPaM7tBfE2iJO9
         533hOgn4IzgEzrdekvNBak9ie1IqQdTgK5JCD427o3EvGXarw1g12HRA+SB8FZytQHIP
         su8360YdiQspWMNgSsgKvEJKmmfgc31CSKdTIvCL0wo2rkPwxYbmpznU1zB1GY46mnIl
         gRFVnT6+O+Rm+s4DkLyFvXrYWrOXHvZD9VF5qE02hjbno4RRpUvDx0PPdqDw5jDpOFUy
         99tEj4BY8/dqjqqqGiH4/ST5MHv81LjDbk672sfsWlWA245v2YZAnuF+ks5X4HFdTlmd
         gG+g==
X-Gm-Message-State: AAQBX9eNN9D0PCoPxquqKZB1SIRXjzxk/AFph0SDvpr5qax1lj/37PMk
	od6cCMg+EVVhuTScNSWZc27euPXclaxloUsuZOCRair1
X-Google-Smtp-Source: AKy350ZgybwM/9gI73rbYXcG9fzSCBxR91y6bGV64beJrnz1aveGXF6SdDY+vFkeBcR8NQErbx9j9g==
X-Received: by 2002:adf:dd87:0:b0:2cf:e87b:5c52 with SMTP id x7-20020adfdd87000000b002cfe87b5c52mr4401446wrl.18.1680704859792;
        Wed, 05 Apr 2023 07:27:39 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f67e:9347:5b88:82e5? ([2a02:578:8593:1200:f67e:9347:5b88:82e5])
        by smtp.gmail.com with ESMTPSA id r8-20020adfdc88000000b002de99432fc8sm15198336wrj.49.2023.04.05.07.27.38
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 07:27:39 -0700 (PDT)
Message-ID: <51528bb2-bd3d-c807-3047-d5537931bdf1@tessares.net>
Date: Wed, 5 Apr 2023 16:27:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 4th of April 2023
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Tuesday, we had our 236th meeting with Christoph (Apple), Paolo,
Davide (Red Hat) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13189008: [net-next,v2,1/4] mptcp: avoid unneeded address copy
13189009: [net-next,v2,2/4] mptcp: simplify subflow_syn_recv_sock()
13189010: [net-next,v2,3/4] mptcp: do not fill info not used by the PM
in used
13189011: [net-next,v2,4/4] selftests: mptcp: add mptcp_info tests:
      - Series: mptcp: a couple of cleanups and improvements
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=734103&state=*&archive=both


    our repo (by: Geliang Tang, Paolo Abeni):

13194772: [v3,mptcp-net,1/2] mptcp: stops worker on unaccepted sockets
at listener close
13194774: [v3,mptcp-net,2/2] mptcp: fix accept vs worker race:
      - Series: mptcp: a couple of fixes
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=735545&state=*&archive=both

13195545: [mptcp-next] mptcp: make userspace_pm_append_new_local_addr
static:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/0f4d10f41b5a51353cc4738d6b5d63b9aed8b1f7.1680252220.git.geliang.tang@suse.com/

13195616: [mptcp-net] mptcp: fix NULL pointer dereference on fastopen
early fallback:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/07059bdc844f97430ff5c92afc548485b1c20d74.1680253474.git.pabeni@redhat.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: David Howells, Matthieu Baerts):

13196217: [v3,55/55] sock: Remove ->sendpage*() in favour of
sendmsg(MSG_SPLICE_PAGES):
      - Series: -
      - Submitter: David Howells
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=735888&state=*&archive=both
      - similar to v2

13198415: [v4,1/5] docs: process: allow Closes tags with links
13198413: [v4,2/5] checkpatch: don't print the next line if not defined
13198414: [v4,3/5] checkpatch: use a list of "link" tags
13198416: [v4,4/5] checkpatch: allow Closes tags with links
13198417: [v4,5/5] checkpatch: check for misuse of the link tags:
      - Series: docs & checkpatch: allow Closes tags with links
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=736457&state=*&archive=both
      - compared to last week:
          - Closes tag should now be used if the URL is a bug report
          - now checking with Link and Closes are followed by http(s)://
          - Patches applied in Andrew Morton's tree, hopefully this
means they have been accepted (at least by checkpatch's maintainer: Joe
Perches)


    our repo (by: Geliang Tang, Matthieu Baerts, Paolo Abeni):

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
      - status: same as last week

13173788: [mptcp-next,v5,1/7] mptcp: don't clear userspace pm addr id
13173789: [mptcp-next,v5,2/7] mptcp: add addr into userspace pm list
13173790: [mptcp-next,v5,3/7] mptcp: close remote subflow when destroying it
13173791: [mptcp-next,v5,4/7] mptcp: increase userspace pm add_addr_signaled
13173792: [mptcp-next,v5,5/7] mptcp: update userspace pm subflows
13173794: [mptcp-next,v5,7/7] selftests: mptcp: check userspace mptcp_info:
      - State: Changes requested
      - Series: mptcp: update userspace pm mptcp_info fields
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=729763&state=*&archive=both
      - status: same as last week

13191374: [mptcp-net] selftests: mptcp: userspace pm: uniform verify events:
      - State: Queued
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230328-mptcp-selftests-userspace-sleep-verify-listen-v1-1-2a4adf550084@tessares.net/
      - can be applied, reviewed by Paolo → Done

13192402: [mptcp-next,1/3] MAINTAINERS: add git trees for MPTCP
13192403: [mptcp-next,2/3] mptcp: remove unused 'remaining' variable
13192404: [mptcp-next,3/3] selftests: mptcp: remove duplicated entries
in usage:
      - State: New
      - Series: mptcp: misc. small cleanups
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=734997&state=*&archive=both
      - just some small cleanup, nothing important
      - to be reviewed (not by Matt)

13199661: [mptcp-next,1/3] mptcp: introduces more address related mibs
13199662: [mptcp-next,2/3] selftests: mptcp: add explicit check for new mibs
13199663: [mptcp-next,3/3] selftests: mptcp: centralize stats dumping:
      - State: Changes requested
      - Series: mptcp: add more mibs
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=736792&state=*&archive=both
      - v2 is expected

13200342: [mptcp-next,1/2] selftests: mptcp: join: avoid using 'cmp --bytes'
13200343: [mptcp-next,2/2] selftests: mptcp: join: fix ShellCheck warnings:
      - State: New
      - Series: mptcp: selftests: join: support BusyBox and ShellCheck
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=736853&state=*&archive=both
      - the first patch is for net, to have the tests succeeding when
lkft is validating kernel 6.2.
      - to be reviewed (not by Matt)



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 380):

  382  Question: Different path manager rules for different MPTCP
connections [question]:
      - replied but no feedback yet → re-asked

  381  Why does total throughput increase when the delay on one of the
paths increases? [question]:
      - linked to missing optimisations in the packet scheduler, see
issue #350 → can be closed?


    Bugs (opened, flagged as "bug" and assigned)

  377  BUG: soft lockup in `ip_rcv` [bug] [syzkaller] [reproducer]
@dcaratti:
      - not related to MPTCP, also failing with "plain" TCP
      - a bug in TC, maybe a loop in the refs of the RB tree
      - can be closed but Davide is continuing to look at that to have a
fix for TC

  373  checkpatch: `Closes` tag is no longer accepted [bug] @matttbe:
      - See patches ↑

  329  PM: userspace: update `MPTCP_INFO` fields [bug] [pm] @geliangtang
      - See patches ↑

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni
      - See patches in our tree.


    Bugs (opened and flagged as "bug" and not assigned)

  379  userspace pm: ability to send `RM_ADDR` for all local IDs used (0
included) [bug] [pm]
  378  Very noisy `addr_signal error` [bug]
  376  KASAN: slab-use-after-free Read in `ip_mc_drop_socket` [bug]
[syzkaller]
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

  340  netlink: switch to YAML Netlink specs [enhancement] @dcaratti:
      - Davide is looking at that
      - More patches to modify the tool than to switch to the new
architecture
      - Davide will share patches on the ML (or a git repo)

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   75  BPF: packet scheduler [enhancement] [sched] @geliangtang
   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

  307  TCP performance better than MPTCP [question] @matttbe:
    → asked for last status


    Open questions (opened, questions and not assigned)

  382  Question: Different path manager rules for different MPTCP
connections [question]
  381  Why does total throughput increase when the delay on one of the
paths increases? [question]
  326  Issue with streaming traffic with MPTCP upstream implementation
[question]:
    → asked for last status


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


    Recently closed (since 2023-03-28)

  375  syzkaller: WARNING: refcount bug in `__mptcp_close` [bug]
[syzkaller] [reproducer] @pabeni
  371  syzkaller: WARNING in `inet_csk_listen_stop` [bug] [syzkaller]
[reproducer] [bisected]



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.4):
https://github.com/orgs/multipath-tcp/projects/2/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [3c6f28166cc1] mptcp: use mptcp_schedule_work instead of
open-coding it (Paolo Abeni)
        - [45aea73656a1] mptcp: stricter state check in mptcp_worker
(Paolo Abeni)
        - [212639fddaab] mptcp: stops worker on unaccepted sockets at
listener close (Paolo Abeni)
        - [419ac2275a50] mptcp: fix accept vs worker race (Paolo Abeni)
        - [6d50552a4d9b] mptcp: fix NULL pointer dereference on fastopen
early fallback (Paolo Abeni):
            - best to wait to get some feedback from Syzkaller (Christoph)

    - Fixes for net-next: /

    - Features for net-next:

        - [0fc9acefe5a6] mptcp: drop unneeded argument (Paolo Abeni)
        - [b14f4b458f26] mptcp: avoid unneeded __mptcp_nmpc_socket()
usage (Paolo Abeni)
        - [9cb37e268ade] mptcp: move fastopen subflow check inside
mptcp_sendmsg_fastopen() (Paolo Abeni)
        - [b0da74b7145e] mptcp: move first subflow allocation at mpc
access time (Paolo Abeni)
        - [707124049cab] mptcp: fastclose msk when cleaning unaccepted
sockets (Paolo Abeni)
        - [70c74fc9659d] inet: factor out locked section of
inet_accept() in a new helper (Paolo Abeni)
        - [799f4477df5b] mptcp: refactor mptcp_stream_accept() (Paolo
Abeni):
            - blocked by the patches from -net

        - [9d35e604aaef] mptcp: make userspace_pm_append_new_local_addr
static (Geliang Tang):
            - could be sent but best to wait for others

    - Features for net-next (next): /

    - Features for other trees:

        - [a0726f072b6d] security, lsm: Introduce
security_mptcp_add_subflow() (Paolo Abeni)
        - [42118de5e769] selinux: Implement mptcp_add_subflow hook
(Paolo Abeni):
            - blocked by the patches from -net and net-next

        - [0af24780496b] mptcp: refactor push_pending logic (Geliang Tang)
        - [aa90e7d7fbf6] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [9f3eb599eeb0] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [e0035afcab9a] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [49921dcd7d34] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [5cc0282f74d6] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [976db31840ba] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [43f6db8a34c2] mptcp: add scheduler wrappers (Geliang Tang)
        - [b127283fdcea] mptcp: use get_send wrapper (Geliang Tang)
        - [3c8096bbd9d1] mptcp: use get_retrans wrapper (Geliang Tang)
        - [ff7e1fdd050c] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [69a364f5e68d] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [65b95930d090] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [08a6b225146c] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [ca7c1c9cb0c2] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [6c9995403ff3] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [41de5258ab17] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [b65869f35d2c] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [e53075ed7a2f] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [5b7b9ce94456] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [0ee1360b464e] selftests/bpf: Add bpf_red test (Geliang Tang):
            - status: same as last week: wait for new Sched API



Extra tests:
    - news about Syzkaller? (Christoph):
        - Did Christoph validate the export branch from Friday?
            → launched now

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - still working
        - it looks they will soon support series with > 1 patch but no
cover-letter (no ETA)
            - https://github.com/patchew-project/patchew/issues/86

    - CI (Matth):
        - packetdrill is now "pre-heated": it happens that the first
tests being executed failed because the environment is very slow. Now a
first test is launched and its results are discarded, just to avoid
being impacted by being the first test to be executed.



Next meeting:
    - Next one on Tuesday, the 11th of April.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230411



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
