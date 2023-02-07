Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A37468
	for <mptcp@lists.linux.dev>; Tue,  7 Feb 2023 17:57:21 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso13763969wms.5
        for <mptcp@lists.linux.dev>; Tue, 07 Feb 2023 09:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3wAWyAwrPZ7lYhLcqUlK0iHqw//ma9Hd/MsiWV5r+U=;
        b=OWMOuy4j5Q6ZgLeKw/dmmlG7dm46mRr67Zl1O/XAAah3Kn31i1JDKkMsfnNoirY0uC
         IhwBC+7GqLPrESDkuYJ4aTrlzm5RbrKucNhBPz1MxvGKGiTMw7WhYnrAG6vDv6Sj0IfG
         LzQWWVz1b1dcrGBKH11SDVnWPWUCmTXMF3D5xwAitKpN4/8Dwv5dK+nVmF127X+OwbcH
         +Xe1rV1Feq5jTkgHtP83sUWx7GVfdIbRqa+Ix+qySmJGb0CRPsoaie5LZRujypWTUOwg
         ReyRh6iR0H0dag803wKpiSUIv9GiTncjtw9d/s7S/JH7O0eFPFmG16gBwhW98S5bu1p4
         +V2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y3wAWyAwrPZ7lYhLcqUlK0iHqw//ma9Hd/MsiWV5r+U=;
        b=Pemz05tQ0HgIJfZQt2dvyCp+0eQqY9sTGunf1A6Z/DaL3ySAwkHYL5VBfnhm9QHsj/
         AwqteOfYIALeYqvAZVB5QTXYTamYQo9cXd1+6gJmOQGkCFXx2UeI2mkIapBSdbN+ZUzu
         M7oieM3RbFjD3nhvFFHR2nQaJX65rtOV7NNNvTB1f4bZAQ1mCLu1600Bm4si4wrGNsPl
         UlRDayXZlolBGunhdG9gK7CAE8WyOIU5DSVqozxVO1aLAJKg9dGptInVhxlm4gNLGikP
         /ehDG4D7D+sGiHy70CyftKbVZXK94xMhU1sYdgsvdIHMfIisvPI+mSbqe0skJbzckzbj
         u4Aw==
X-Gm-Message-State: AO0yUKX0/DSy7ywJ6n+KZ8KM4hol5pn7y5U+HtBgDGkumhk3s9Dtb4/Q
	/s/f6rHBpDSZU1ZY53PrhdI8APJ1RIOzHqsV8uIkDQ==
X-Google-Smtp-Source: AK7set+9yRkuMQmRawus0k9iUtAmvq/xu0XQS9VtE/SigiNxRT/PB029z2TKKkX4DkgIQRmTGeUPKg==
X-Received: by 2002:a05:600c:43d5:b0:3d9:e5d3:bf with SMTP id f21-20020a05600c43d500b003d9e5d300bfmr3854423wmn.32.1675792639338;
        Tue, 07 Feb 2023 09:57:19 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:db66:12ad:7fc:aa7b? ([2a02:578:8593:1200:db66:12ad:7fc:aa7b])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c468a00b003e0015c8618sm7250517wmo.6.2023.02.07.09.57.18
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 09:57:19 -0800 (PST)
Message-ID: <24eee674-1a41-ade4-4db0-6694b313ceae@tessares.net>
Date: Tue, 7 Feb 2023 18:57:18 +0100
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
Subject: [Weekly meetings] MoM - 7th of February 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Today, we just had our 228th meeting with Christoph (Apple), Davide (Red
Hat) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Matthieu Baerts):

13122893: [mptcp-net,v2,1/2] selftests: mptcp: allow more slack for slow
test-case
13122894: [mptcp-net,v2,2/2] selftests: mptcp: stop tests earlier:
      - Series: selftests: mptcp: stabilise 'endpoint' Join tests
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=717332&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13131500: [net,1/6] mptcp: do not wait for bare sockets' timeout
13131501: [net,2/6] mptcp: fix locking for setsockopt corner-case
13131502: [net,3/6] mptcp: fix locking for in-kernel listener creation
13131503: [net,4/6] mptcp: be careful on subflow status propagation on
errors
13131504: [net,5/6] selftests: mptcp: allow more slack for slow test-case
13131505: [net,6/6] selftests: mptcp: stop tests earlier:
      - Series: mptcp: fixes for v6.2
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=719492&state=*&archive=both


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

13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
      - State: Changes requested
      - Series: BPF redundant scheduler, part 3
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
      - Blocked by the discussion about the packet scheduler, see ticket
#350

13127109: [mptcp-next,v3] mptcp: update userspace pm mptcp_info fields:
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/7f695489e0ecba3f0951193be81a1620b1f8e6e7.1675410794.git.geliang.tang@suse.com/
      - To be reviewed: Matth will do that



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: *340*)

  351  Userspace PM in 5.15 LTS [question] [pm]:
      - two things:
          - backport a new feature to LTS: no
          - the in-kernel PM doesn't re-establish subflows that got
disconnected:
              - not sure the reason yet
              - Matth will follow up on that and maybe create a specific
ticket for this 2nd issue → closed

  350  scheduler: API changes (tasks) [enhancement] [sched]
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
  348  scheduler: frequently probe "stale" subflow with reinjected data
[enhancement] [sched]
  345  scheduler: "penalise" some subflows by sending less than their
cwnd [enhancement] [sched]
  344  scheduler: new callback to initiate optimisations [enhancement]
[sched]
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched]
  342  scheduler: area in the socket structures reserved for schedulers
[enhancement] [sched]:
      - linked to the discussions we had last week
      - could be nice to have a plan for that

  347  syzkaller: KASAN: use-after-free Read in `__token_bucket_busy`
[bug] [syzkaller]
  346  syzkaller: KASAN: use-after-free Write in `subflow_error_report`
[bug] [syzkaller]:
      - not bisected (yet)
      - decode_stacktrace: is ongoing but some issues, maybe because of
DWARF5

  341  syzkaller: WARNING in `sk_stream_kill_queues` [bug] [syzkaller]:
      - Not related to MPTCP: can be closed
      -
https://lore.kernel.org/netdev/39725AB4-88F1-41B3-B07F-949C5CAEFF4F@icloud.com/


    Bugs (opened, flagged as "bug" and assigned)

  329  PM: userspace: update `MPTCP_INFO` fields [bug] @geliangtang:
      - See patches above

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni:
      - In our tree
      - @Paolo: can we close it or do you prefer to keep it to track it
as we need to wait a bit before upstreaming them?


    Bugs (opened and flagged as "bug" and not assigned)

  347  syzkaller: KASAN: use-after-free Read in `__token_bucket_busy`
[bug] [syzkaller]
  346  syzkaller: KASAN: use-after-free Write in `subflow_error_report`
[bug] [syzkaller]
  341  syzkaller: WARNING in `sk_stream_kill_queues` [bug] [syzkaller]:
    - see above

  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched]:
    - see above

  336  Issues with BPF packet scheduler [bug]:
    - @Geliang: do you mind looking at it please? :)

  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: test 98 `fastclose test` is sometimes
failing [bug] [selftests]
  318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
cookies [bug] [selftests]
  315  Issues with backup flow [bug]


    In Progress (opened, new feature and assigned)

  340  netlink: switch to YAML Netlink specs [enhancement] @dcaratti:
      - Davide is going to look at that, thanks!
      - Mostly to improve the doc

  330  `MPTCP_INFO`: document and support `mptcpi_subflows` for the
server side [enhancement] @geliangtang:
      - See patches above

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

  351  Userspace PM in 5.15 LTS [question] [pm]:
     - closed

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


    Recently closed (since 2023-01-31)

  339  selftests: diag: failing: found msk after flush while expected
none [bug] [selftests] @pabeni
  323  selftests: `mptcp_join`: test 115 `delete and re-add` is often
failing [bug] [selftests] @pabeni
   82  improve packet scheduler for asymmetric links [enhancement]
[sched] @pabeni



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.3):
https://github.com/multipath-tcp/mptcp_net-next/projects/18
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:


    - Fixes for other trees: /

    - Fixes for -net:

        - [7784f84ebcfa] mptcp: do not wait for bare sockets' timeout
(Paolo Abeni)
        - [3123b3d528d2] mptcp: fix locking for setsockopt corner-case
(Paolo Abeni)
        - [f2ef0877ad5e] mptcp: fix locking for in-kernel listener
creation (Paolo Abeni)
        - [619c64f13a96] mptcp: be careful on subflow status propagation
on errors (Paolo Abeni)
        - [88412b24a363] selftests: mptcp: allow more slack for slow
test-case (Paolo Abeni)
        - [018dfe39de2e] selftests: mptcp: stop tests earlier (Matthieu
Baerts):
            - have been sent to netdev

    - Fixes for net-next: /

    - Features for net-next:

        - [07ff217586b8] mptcp: use mptcp_schedule_work() instead of
open-coding it (Paolo Abeni)
        - [689775c2bde8] mptcp: refactor passive socket initialization
(Paolo Abeni)
        - [474fdaafd338] mptcp: drop unneeded argument (Paolo Abeni)
        - [32e66b07ce0c] mptcp: drop legacy code (Paolo Abeni)
        - [a5530db5ba70] mptcp: avoid unneeded __mptcp_nmpc_socket()
usage (Paolo Abeni)
        - [ad608dc4676d] mptcp: move fastopen subflow check inside
mptcp_sendmsg_fastopen() (Paolo Abeni)
        - [93b27546712e] mptcp: move first subflow allocation at mpc
access time (Paolo Abeni)
        - [18b3637d080b] mptcp: do not keep around the first subflow
after disconnect (Paolo Abeni)
        - [33e56704e543] mptcp: fastclose msk when cleaning unaccepted
sockets (Paolo Abeni)
        - [61104df3c9df] inet: factor out locked section of
inet_accept() in a new helper (Paolo Abeni)
        - [03d51c2addcc] mptcp: refactor mptcp_stream_accept() (Paolo
Abeni):
            - probably wait for the next merge window

    - Features for net-next (next): /

    - Features for other trees:

        - [b9354728aab6] security, lsm: Introduce
security_mptcp_add_subflow() (Paolo Abeni)
        - [158c7ee55946] selinux: Implement mptcp_add_subflow hook
(Paolo Abeni):
            - Depends on ↑

        - [b9a19862cbab] mptcp: refactor push_pending logic (Geliang Tang)
        - [b3350c84d7b7] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [4c5155abc285] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [347110c1673c] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [5e371075c2e1] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [e3aa536c6cb8] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [4bc248a6f443] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [c490d47e43bb] mptcp: add scheduler wrappers (Geliang Tang)
        - [3fa80d32bff7] mptcp: use get_send wrapper (Geliang Tang)
        - [08b1955965ea] mptcp: use get_retrans wrapper (Geliang Tang)
        - [e71bb904e667] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [5d0d2142a536] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [e445b2dfbc74] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [eddd2067cbc3] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [a6b6d260e97b] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [cdefd34e2e11] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [ef4631a5d39d] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [fd8472daae00] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [813f0f44759b] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [274699e2eedd] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [3a7fdc76fb96] selftests/bpf: Add bpf_red test (Geliang Tang):
            - same as last week: wait, discussion on going




Extra tests:
    - news about Syzkaller? (Christoph):
        - quite a few new hits that seem to be linked to MPTCP:
            - soft lockup, etc.
            - strange we didn't see them before with Mat's setup and syzbot
            - or memory corruptions?
                - Christoph is investigating that
        - decode_stacktrace is ongoing but some issues, maybe because of
DWARF5
        - If a switch to DWARF4 is needed, recompilation will be
required, bugs will need to be re-reproduced

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - greener \o/



FOSDEM talk:
    - Slides and video recordings are available online:
        - https://fosdem.org/2023/schedule/event/mptcp_upstream
    - PS: yes, we cannot hear them but a few people laughed, there were
no long and embarrassing silences after each joke 😛



Next meeting:
    - Next one on Tuesday, the 14th of February. <3
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230214



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
