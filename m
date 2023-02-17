Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274BF9446
	for <mptcp@lists.linux.dev>; Fri, 17 Feb 2023 18:14:55 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id cz7so4065301edb.12
        for <mptcp@lists.linux.dev>; Fri, 17 Feb 2023 10:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMJ/UEHEa6EefRrfru6bU1qizhgwg+36jS/zddGL0kM=;
        b=OQI/CyhtlurLwpNPkYRyRbHaTdJwBnadULQtqMxg/R7vF0zyg0G8QDb/rfZxvf+yan
         b7vrabNqKcO+a8bitRiDrFNVGG7LqdRVjefxsw0E2pw3dBzdwV7JcwnM8eMzWKrbYf09
         Wt59ZAY//EW8vvyz2Ic3zVVpqVZzEDEzXcfdR/7CJZU5FuQt7bK6BAQzOb/txdz7pSyF
         hsJ1MwM/KrPq7Cs7cfK8TFRdbyTDmEdRWgOCw3qFkhCP4zXP2wOrCjZRxhiBfwUx6g8c
         yeIV3dCErZZrDvKJqXqsdivPP7FHzTOfz11XY0M8NrY20PK/DRNNYVB9Z3t7wyhF65y8
         2BBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jMJ/UEHEa6EefRrfru6bU1qizhgwg+36jS/zddGL0kM=;
        b=zE7G6c6nWWMBQBAcIH+nYMjkIhsA3anI/tEkqljiFM8Szc0MYCQQD/uK2kdaCakM+S
         wU0K8xpqMlnCB4Ak02Lj/0xYEOOKqFBIdY0nlXMUhbckJw4McVP88BLyKutoWQtN4uI9
         +yHq1h6h3HUXtHJ/HAqZd7go1DkRXs1Euieqh75Tsru69QhxgIyUuxg2PaqmiZHMMvKu
         qXyv66+yKYREKfpHmGs9pMfScS7w3dOvXAuK13R1kWkPUXonu36w7L/v+4AY/ettw2Lm
         OT6uEZSjrGV07u3+420z7lJXldVTRMqF9ZVcOuRXnSGL8IsI1oF3Qwg+nEJl4ArZnSjm
         E+/g==
X-Gm-Message-State: AO0yUKVow1hb2xFXJxNHitkHhYM5I/FnwAaaGb5if78uyC3hb4mtihLZ
	pIsVF9qNtO+kzTjgKF+EZU2YuBkMxqwQNcThC04=
X-Google-Smtp-Source: AK7set+sERfO8o/xpFI2/zAQHX2Swkd5VmSzZ8pLuVILJB4jDRKijy9D1QM2xSSk68J6mozxTu0BbQ==
X-Received: by 2002:a17:906:e285:b0:878:4a5e:3a56 with SMTP id gg5-20020a170906e28500b008784a5e3a56mr1552305ejb.15.1676657693605;
        Fri, 17 Feb 2023 10:14:53 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:c2b7:fcfc:1e01:3a74? ([2a02:578:8593:1200:c2b7:fcfc:1e01:3a74])
        by smtp.gmail.com with ESMTPSA id qp14-20020a170907206e00b008b126882334sm2391291ejb.39.2023.02.17.10.14.53
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 10:14:53 -0800 (PST)
Message-ID: <ff6cf9f4-2263-7577-65fc-c07f09edc8ed@tessares.net>
Date: Fri, 17 Feb 2023 19:14:52 +0100
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
Subject: [Weekly meetings] MoM - 14th of February 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Tuesday, the 14th of Feb 🧡, we just had our 229th meeting with
Christoph (Apple), Davide, Paolo (Red Hat), Dmytro (?) Benjamin and
myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:


Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


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


    our repo (by: /):

/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

13139352: [v2,net-next] net: no longer support SOCK_REFCNT_DEBUG feature:
      - Submitter: Jason Xing
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230214041410.6295-1-kerneljasonxing@gmail.com/
      - Can be ACKed for MPTCP side: TODO Matth → Done

13140455: [6.1,1/4] mptcp: sockopt: make 'tcp_fastopen_connect' generic
13140456: [6.1,2/4] mptcp: fix locking for setsockopt corner-case
13140457: [6.1,3/4] mptcp: fix locking for in-kernel listener creation
13140458: [6.1,4/4] selftests: mptcp: userspace: fix v4-v6 test in v6.1:
      - Series: mptcp: Stable backports for 6.1.12
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=721763&state=*&archive=both
      - For stable → Done


    our repo (by: Geliang Tang, Jason Xing, Jiapeng Chong, Matthieu
Baerts, Paolo Abeni):

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
      - Status: same as last week: refactoring needed on the scheduler side

13127109: [mptcp-next,v3] mptcp: update userspace pm mptcp_info fields:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/7f695489e0ecba3f0951193be81a1620b1f8e6e7.1675410794.git.geliang.tang@suse.com/
      - v4 expected

13134968: [v2,mptcp-net,1/2] mptcp: use the workqueue to destroy
unaccepted sockets.:
      - Fixes: 58b09919626 ("mptcp: create msk early")
13134969: [v2,mptcp-net,2/2] mptcp: fix UaF in listener shutdown:
      - Fixes: 6aeed9045071 ("mptcp: fix race on unaccepted mptcp sockets")
      - State: New
      - Series: [v2,mptcp-net,1/2] mptcp: use the workqueue to destroy
unaccepted sockets.
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=720441&state=*&archive=both
      - "Fixes" tags missing, see above
      - Code should be ready, can be reviewed: TODO: Matth → Done



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 351):

  355  syzkaller: possible deadlock in `subflow_error_report` [bug]
[syzkaller]
  354  syzkaller: possible deadlock in `tcp_close` [bug] [syzkaller]:
      - just opened, probably a false positive for 354: more annotations
needed?

  353  sockopt: uniform code to get/set values [enhancement]:
      - different ways to handle [gs]etsockopt
      - is it OK to uniform that with the proposed code?
      - some socket option are a bit particular, e.g.:
          - FREEBIND and TRANSPARENT only makes sense before the
establishment of the connection
          - some makes sense to be applied on all subflows, some only on
the first one
          - to be reviewed case by case
          - Matth will look at that


    Bugs (opened, flagged as "bug" and assigned)

  329  PM: userspace: update `MPTCP_INFO` fields [bug] [pm] @geliangtang:
      - See patches above

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni:
      - Patches have been applied but waiting


    Bugs (opened and flagged as "bug" and not assigned)

  347  syzkaller: KASAN: use-after-free Read in `__token_bucket_busy`
[bug] [syzkaller]
  346  syzkaller: KASAN: use-after-free Write in `subflow_error_report`
[bug] [syzkaller]
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

  340  netlink: switch to YAML Netlink specs [enhancement] @dcaratti
  330  PM: in-kernel: `MPTCP_INFO`: document and support
`mptcpi_subflows` for the server side [enhancement] [pm] @geliangtang
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

  353  sockopt: uniform code to get/set values [enhancement]
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


    Recently closed (since 2023-02-07)

  352  syzkaller: WARNING in `mptcp_accept` [bug] [syzkaller]
  351  Userspace PM in 5.15 LTS [question] [pm]
  341  syzkaller: WARNING in `sk_stream_kill_queues` [bug] [syzkaller]



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.3):
https://github.com/multipath-tcp/mptcp_net-next/projects/18
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net: /

    - Fixes for net-next: /

    - Features for net-next:

        - [027d030567b9] mptcp: use mptcp_schedule_work() instead of
open-coding it (Paolo Abeni)
        - [e75d5cb2c6f0] mptcp: refactor passive socket initialization
(Paolo Abeni)
        - [331a94219bb2] mptcp: drop unneeded argument (Paolo Abeni)
        - [379b59aa188e] mptcp: drop legacy code (Paolo Abeni)
        - [de3bb095cea1] mptcp: avoid unneeded __mptcp_nmpc_socket()
usage (Paolo Abeni)
        - [024fc751b766] mptcp: move fastopen subflow check inside
mptcp_sendmsg_fastopen() (Paolo Abeni)
        - [2fdf319be3ee] mptcp: move first subflow allocation at mpc
access time (Paolo Abeni)
        - [8649884d40ef] mptcp: fastclose msk when cleaning unaccepted
sockets (Paolo Abeni)
        - [08dbbac52557] inet: factor out locked section of
inet_accept() in a new helper (Paolo Abeni)
        - [de31d4216596] mptcp: refactor mptcp_stream_accept() (Paolo
Abeni):
            - same as last week: wait

    - Features for net-next (next): /

    - Features for other trees:

        - [ff83b128d6df] security, lsm: Introduce
security_mptcp_add_subflow() (Paolo Abeni)
        - [d0f4d06f8f4f] selinux: Implement mptcp_add_subflow hook
(Paolo Abeni):
            - same as last week: wait

        - [44da1a0f5a79] mptcp: refactor push_pending logic (Geliang Tang)
        - [39df95b4af1a] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [91dca3933538] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [d290a335e589] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [c050b3e92b48] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [3065e30c77a5] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [6e1e74780793] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [a841173ff7ec] mptcp: add scheduler wrappers (Geliang Tang)
        - [431301c9a714] mptcp: use get_send wrapper (Geliang Tang)
        - [18c249dca789] mptcp: use get_retrans wrapper (Geliang Tang)
        - [3a976363ed64] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [211dfbdf21c2] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [4f5ceea6c946] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [16ce6a770860] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [7a5359d944db] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [4c8d1fd6b352] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [05493825a1b6] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [6a4498ebb5f9] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [ecc59662a204] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [a8ee8a31565f] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [8fe6c6a3e057] selftests/bpf: Add bpf_red test (Geliang Tang):
            - same as last week: wait



Extra tests:
    - news about Syzkaller? (Christoph):
        - A lot of TCP errors
        - Could be good to validate them on net-next
        - new machines to validate different kernel config on top of the
export branch

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - Recent patches from Matth are not in patchew (fixes for 6.1.12)
        - It seems the importer was stuck, DNS issues, fixed now

    - CI (Matth):
        - Greener!
        - Thanks for the effort stabilising it, making it really useful!



Next meeting:
    - Next one on Tuesday, the 21st of February.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230221



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
