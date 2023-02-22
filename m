Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887A68F59
	for <mptcp@lists.linux.dev>; Wed, 22 Feb 2023 17:47:13 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id l1so8344309wry.10
        for <mptcp@lists.linux.dev>; Wed, 22 Feb 2023 09:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W42QeISgVsbxz3IzSEVsRAXlTh/vi1CLJAUmwjKHx+k=;
        b=fXkRXX184HauNZBO546oq0k3NaNsRfwGBx5JT7Eb4P7sulimwPewDeOP7AH01NkoCJ
         DR6FL55duiHYRB8YuVDRYO5shSE3vHni2I2cEhIYmK6YO/YvFzJSDaO82Xg+MOh22IHt
         r8H4Ijxk96GkSCGLQpPhe8PgAk2DZftpBszIhl/jymbox/Zqbdd91QTDbyrE7n1Wrrc/
         GxO6wusQTNO6oWxDRZnWm60UW6B0vQSqzb341V+oEEa4E6rJiXiEqwToOYr2SiHnpJwy
         /aVls4gOXk2HcCB0lzCNQRbTv3RZ4d5hlujRUcFJz7CFSNyBbJjJSx+Sf2jiMjgUZram
         me/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W42QeISgVsbxz3IzSEVsRAXlTh/vi1CLJAUmwjKHx+k=;
        b=XvD5kcMMWmhcZFuye1cuc6VGwkMNszYFruKLGaRaRjWniGaygWWQkgSuUD1pxpbM8C
         vDaZQ8dqEfV7PTH1rFrwtN0rO9l5piXcElrO8pkUNp4I3PMwSvLyrpnzLHiJyrECJrTg
         EZH7FLK0kxwAC4DtOs74l1etZoHDeHh9mqp8q36jsvC73pcU3KB5PGB6+TiwUOeXLIR/
         6yhs5DDmQwwLn+dqXQYqKe1rAUCWvcLsD6feiP9kSKmeULMcRCdCWXjuQBYW07pEXxC7
         lVqAStu+xuWP/ezrVM5b4HJn6DGGD4XxP7uCUgYs+2gnmOqbl4sDUdTTNzwzsWemPotK
         mlVA==
X-Gm-Message-State: AO0yUKWb2O4jLJ2RJgK0LTVQYkOi5bnCK782wCRYPCIJAkGrJPQ2doQU
	EpRoFfF9zfqqaTcN0Y84SpWcljGWkRC7dijhKpTxWw==
X-Google-Smtp-Source: AK7set8FvZ8jR4dBrrM+m6ztwrBZhjMWM+B8Zq2AtnplvQzg429Jy08Ydei5RLRcD4CWDIXB1gHYoQ==
X-Received: by 2002:adf:e84d:0:b0:2c7:760:2539 with SMTP id d13-20020adfe84d000000b002c707602539mr3894826wrn.50.1677088030884;
        Wed, 22 Feb 2023 09:47:10 -0800 (PST)
Received: from [192.168.3.222] ([213.211.148.158])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d654e000000b002c5801aa9b0sm8379811wrv.40.2023.02.22.09.47.10
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 09:47:10 -0800 (PST)
Message-ID: <122c88fc-df4f-4f31-b0ad-e72ab7275aab@tessares.net>
Date: Wed, 22 Feb 2023 18:47:09 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 21th of February 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Yesterday, we had our 230th meeting with Christoph (Apple), Paolo,
Davide (Red Hat), Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:

Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Jason Xing, Matthieu Baerts):

13139352: [v2,net-next] net: no longer support SOCK_REFCNT_DEBUG feature:
      - Submitter: Jason Xing
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230214041410.6295-1-kerneljasonxing@gmail.com/
      - removing a feature from net, one line has been removed on MPTCP side

13140455: [6.1,1/4] mptcp: sockopt: make 'tcp_fastopen_connect' generic
13140456: [6.1,2/4] mptcp: fix locking for setsockopt corner-case
13140457: [6.1,3/4] mptcp: fix locking for in-kernel listener creation
13140458: [6.1,4/4] selftests: mptcp: userspace: fix v4-v6 test in v6.1:
      - Series: mptcp: Stable backports for 6.1.12
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=721763&state=*&archive=both
      - Patch 4/4 is specific for 6.1: fixing a previous backport
      - for the rest: there were small conflicts when backporting them

13144699: [5.15] mptcp: do not wait for bare sockets' timeout:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230214-upstream-stable-20230214-linux-5-15-94-rc1-mptcp-fixes-v1-1-fc57df3fbda0@tessares.net/
      - there was small conflicts when backporting it


    our repo (by: Paolo Abeni):

13134968: [v2,mptcp-net,1/2] mptcp: use the workqueue to destroy
unaccepted sockets.
13134969: [v2,mptcp-net,2/2] mptcp: fix UaF in listener shutdown:
      - Series: [v2,mptcp-net,1/2] mptcp: use the workqueue to destroy
unaccepted sockets.
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=720441&state=*&archive=both
      - fixing:
          - 347: syzkaller: KASAN: use-after-free Read in
`__token_bucket_busy`
          - 346: syzkaller: KASAN: use-after-free Write in
`subflow_error_report`
      - moved to export (net-next) because they depend on one patch in
the export branch → (EDIT: back to -net)
      - Christoph will check if it is possible to reproduce them on top
of net-next (or net)

13146511: [mptcp-net] mptcp: fix possible deadlock in subflow_error_report:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/c2265383cb2190247f7dec66fb67182e558bf5a1.1676889543.git.pabeni@redhat.com/

13146512: [mptcp-next] Squash-to: mptcp: refactor passive socket
initialization:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/29f3677f2032145ac2b1c1a90ec96ef0d61e4269.1676889558.git.pabeni@redhat.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*

    netdev (if mptcp ML is in cc) (by: Hangbin Liu):

13145800: [PATCHv2,bpf-next] selftests/bpf: run mptcp in a dedicated netns:
      - Submitter: Hangbin Liu
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230219070124.3900561-1-liuhangbin@gmail.com/

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

13142838: [mptcp-next] selftests: mptcp: userspace pm: fix printed values:
      - State: New
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230216-mptcp-selftests-userspace-pm-typo-expected-v1-1-e004734154d6@tessares.net/
      - Need review but can also be applied like that

13146706: [mptcp-net] Revert "mptcp: fix locking for in-kernel listener
creation":
      - State: Changes requested
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/1cde3460ddf2e5fa7be0e81dd2c3060a663d4ccc.1676909181.git.pabeni@redhat.com/
      - goal is to fix a lockdep false error:
          - no real deadlock here but would be good to fix that for
syzkaller to find real bug and not stop on that error
      - but it is causing other issues
      - solution: maybe adding annotation: but just for MPTCP
      - solution: refactoring not to do the release when owning the msk:
quite consequent



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 355):

  362  make sure `tcp_done()` is not called on already closed sockets
[enhancement] [selftests]:
      - recently, Paolo noticed `tcp_done()` was done on a already
closed socket
      - could be good to have the CI doing this check:
          - only for the export branch, a DO-NOT-MERGE patch
          - in tcp_done(), safer
      - → Squash-to patch for a recent patch
      - Matth can look at that → See shared patches

  360  syzkaller: INFO: rcu detected stall in `mptcp_pm_add_timer` [bug]
[syzkaller]:
      - no reproducer yet
      - not clues so far

  358  `getsockopt(SOL_MPTCP, ...)` on a MPTCP->TCP fallback connection
returns `EOPNOTSUPP` in IPv4 and `ENOPROTOOPT` in IPv6 [bug]:
      - best to keep current IPv4/IPv6 behaviour
      - can be closed: was useful for the documentation

  356  syzkaller: memory leak in `subflow_create_ctx` [bug] [syzkaller]:
      - no reproducer yet
      - not clues so far


    Bugs (opened, flagged as "bug" and assigned)

  329  PM: userspace: update `MPTCP_INFO` fields [bug] [pm] @geliangtang:
      - see patches above

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni:
      - see patches in our tree


    Bugs (opened and flagged as "bug" and not assigned)

  360  syzkaller: INFO: rcu detected stall in `mptcp_pm_add_timer` [bug]
[syzkaller]
  358  `getsockopt(SOL_MPTCP, ...)` on a MPTCP->TCP fallback connection
returns `EOPNOTSUPP` in IPv4 and `ENOPROTOOPT` in IPv6 [bug]
  356  syzkaller: memory leak in `subflow_create_ctx` [bug] [syzkaller]
  354  syzkaller: possible deadlock in `tcp_close` [bug] [syzkaller]
[reproducer] [bisected]
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

   75  BPF: packet scheduler [enhancement] [sched] @geliangtang:
       - see patches above and in our tree

   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

  307  TCP performance better than MPTCP [question] @matttbe


    Open questions (opened, questions and not assigned)

  326  Issue with streaming traffic with MPTCP upstream implementation
[question]


    For later (opened and not assigned assigned)

  362  make sure `tcp_done()` is not called on already closed sockets
[enhancement] [selftests]
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


    Recently closed (since 2023-02-14)

  361  net: use-after-free in `mptcp_worker` (net/mptcp/protocol.h:528)
[bug]
  359  syzkaller: KCSAN: data-race in `tick_nohz_next_event` /
`tick_sched_do_timer` [bug] [syzkaller] [reproducer]
  357  syzkaller: WARNING: refcount bug in `inet_csk_listen_stop` [bug]
[syzkaller] [reproducer] [bisected]
  355  syzkaller: possible deadlock in `subflow_error_report` [bug]
[syzkaller] [reproducer] [bisected]
  347  syzkaller: KASAN: use-after-free Read in `__token_bucket_busy`
[bug] [syzkaller] [reproducer]
  346  syzkaller: KASAN: use-after-free Write in `subflow_error_report`
[bug] [syzkaller] [reproducer]
  294  Clear way for userspace to know if the connection fell back to
TCP [enhancement] @matttbe



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.3):
https://github.com/multipath-tcp/mptcp_net-next/projects/18
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4
    - TODO: Matth: prepare next version → Done, with ChangeLog



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [82a94ab3eeb1] mptcp: fix possible deadlock in
subflow_error_report (Paolo Abeni):
            - TODO: can be sent by the end of the week → planned

    - Fixes for net-next: /

    - Features for net-next:

        - [dae78722a972] mptcp: use mptcp_schedule_work() instead of
open-coding it (Paolo Abeni)
        - [9c2ae48c13ae] mptcp: refactor passive socket initialization
(Paolo Abeni)
        - [9d9a88b45fc9] mptcp: drop unneeded argument (Paolo Abeni)
        - [b958b13e351c] mptcp: drop legacy code (Paolo Abeni)
        - [fe49697a6e2a] mptcp: use the workqueue to destroy unaccepted
sockets (Paolo Abeni)
        - [042a4b6309c0] mptcp: fix UaF in listener shutdown (Paolo Abeni)
        - [b9f90cea7d48] mptcp: avoid unneeded __mptcp_nmpc_socket()
usage (Paolo Abeni)
        - [aea0b34e4eff] mptcp: move fastopen subflow check inside
mptcp_sendmsg_fastopen() (Paolo Abeni)
        - [41e59e4a4f56] mptcp: move first subflow allocation at mpc
access time (Paolo Abeni)
        - [cab9cb917602] mptcp: fastclose msk when cleaning unaccepted
sockets (Paolo Abeni)
        - [930fe4f4f55f] inet: factor out locked section of
inet_accept() in a new helper (Paolo Abeni)
        - [e9bd4d21c011] mptcp: refactor mptcp_stream_accept() (Paolo
Abeni):
            - net-next is closed

    - Features for net-next (next):


    - Features for other trees:

        - [20beb6b26767] security, lsm: Introduce
security_mptcp_add_subflow() (Paolo Abeni)
        - [40cafefc43b3] selinux: Implement mptcp_add_subflow hook
(Paolo Abeni):
            - same as last week: wait next versions

        - [cd50eba2b3f8] mptcp: refactor push_pending logic (Geliang Tang)
        - [2cb52a3c706e] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [46932b7d75dc] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [5694dbdeed20] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [7040e823c97e] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [dd9e5588c68e] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [85d9edd62e5c] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [acd8c24b858e] mptcp: add scheduler wrappers (Geliang Tang)
        - [c12df7867812] mptcp: use get_send wrapper (Geliang Tang)
        - [0ac3c219d74d] mptcp: use get_retrans wrapper (Geliang Tang)
        - [2c481e6d3cdd] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [f3e2d0081b04] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [0a6ed9bc0429] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [7a2998cc26f1] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [f533c6eebd7e] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [9c5064165ba5] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [322c823aae0a] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [aa3848b643d8] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [677ebd83edcf] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [479bd99812d9] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [60e6f1348a81] selftests/bpf: Add bpf_red test (Geliang Tang):
            - same as last week: we wait (WIP)



Extra tests:
    - news about Syzkaller? (Christoph):
        - (lot of) new tickets

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - Still working

    - CI (Matth):
        - Green, some ("rare") known issues:
            - packetdrill: packet for another socket
            - mptcp_join.sh: see opened tickets



Next meeting:
    - Next one on Tuesday, the 28th of February.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230228



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
