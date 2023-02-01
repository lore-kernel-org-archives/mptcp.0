Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE08363B3
	for <mptcp@lists.linux.dev>; Wed,  1 Feb 2023 15:29:04 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so1662607wmb.4
        for <mptcp@lists.linux.dev>; Wed, 01 Feb 2023 07:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnjD2cEIA5dTtGaXg7BlLDAmFu4xjto0Xaf6CWWPi4o=;
        b=APx8ZpxNGu9gLzMmzEXSzfDEJptRAssGq2ZdlSvXX+5u1SfGN712TlwYVOyumLQ7Mc
         ZsY2RAcxITmzh/uB7ES0qDY3y5QMhr9DHJ4hbiOuA8Rl/ZOPFHosvkDiRvyxXwbZlS3E
         S+Kgv4CmuayNm+UD0ub/IJ50XjGZRis5mJajBnsHesXFgnc4gNhWS1sWQ8ka284ASrDr
         lhXJWAL2Uq5jIpjGzvkxh1iLnEjqS9Ly64nX2OY7WirRR1NWTB5kCP1GM6dlH40Lw5mu
         UJ9PujTmnUNuEqCBC5Vqss1Co2JqRNqet1eUKGgCil+scujmKWoI+Re8a679dxg9BW+2
         C+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gnjD2cEIA5dTtGaXg7BlLDAmFu4xjto0Xaf6CWWPi4o=;
        b=Gj6qzDvrg/NtrC4gyeHQYzFKW5vrZRGUj1HM7YA138ETsE9X17NH43OH48yKff+/zn
         Pdh/YbNcdeDILN026eLyOoFwrYd72RNMjopoC60haIXBTlLg7rttaPAuzF6cDMkF7Z07
         Ikba9uSJkPLCeNTG4aljqb0/0qTB0/SLUaI2ExENS3NtqmwZeKTzfgcRW7XcYtyX7Gt6
         cO8OcLuG2+RX5ZXyxuCYKLXAY88Vh1hnYmRhwoJFcaYKCrmOjecAvQ26+B2pGil1cXV9
         1cqlI6pdVdxBzLdwtIz2PkR29P/+UY92CVfdlt4fQpT1ChWqmJ9Wz6pccEA1YC1hXGpI
         XFjg==
X-Gm-Message-State: AO0yUKWOAS5G17YCtTbRVAa+ueRgw58AQ4ZDhQ9rwIk4zj5y5Z1i9RDt
	xZnHY8GpYcRGvTV2NFpLuqLXYdYqikMOsLgCYyY=
X-Google-Smtp-Source: AK7set+f0cJIbMGE41sLV9rb8wqLaHN4TGrA6Daq7ZrxD5b8uzVN68+RRh5BKHN12+nP44SZ+ker3w==
X-Received: by 2002:a05:600c:3554:b0:3de:e8c5:d830 with SMTP id i20-20020a05600c355400b003dee8c5d830mr2016336wmq.28.1675265342323;
        Wed, 01 Feb 2023 07:29:02 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:68a8:390b:e45:9cd0? ([2a02:578:8593:1200:68a8:390b:e45:9cd0])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b003daf6e3bc2fsm3720192wms.1.2023.02.01.07.29.01
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 07:29:01 -0800 (PST)
Message-ID: <3f7e032d-4baa-1129-9efd-3f52b7bb834d@tessares.net>
Date: Wed, 1 Feb 2023 16:29:01 +0100
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
Subject: [Weekly meetings] MoM - 31st of January 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Tuesday, we had our 227th meeting with Mat, Ossama (Intel),
Christoph (Apple), Florian, Paolo, Davide (Red Hat), Benjamin and myself
(Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13115500: [net-next,1/8] mptcp: let the in-kernel PM use mixed IPv4 and
IPv6 addresses
13115501: [net-next,2/8] mptcp: propagate sk_ipv6only to subflows
13115502: [net-next,3/8] selftests: mptcp: add test-cases for mixed
v4/v6 subflows
13115503: [net-next,4/8] mptcp: userspace pm: use a single point of exit
13115504: [net-next,5/8] selftests: mptcp: userspace: print titles
13115505: [net-next,6/8] selftests: mptcp: userspace: refactor asserts
13115506: [net-next,7/8] selftests: mptcp: userspace: print error
details if any
13115507: [net-next,8/8] selftests: mptcp: userspace: avoid read errors:
      - Series: mptcp: add mixed v4/v6 support for the in-kernel PM
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=715462&state=*&archive=both


    our repo (by: Matthieu Baerts, Paolo Abeni):

13117402: [mptcp-next] mptcp: do not wait for bare sockets' timeout:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/1f0aa2feba9240d202a087e60013c6ff8039897c.1674747837.git.pabeni@redhat.com/

13117782: [v3,mptcp-next,01/15] mptcp: use mptcp_schedule_work() instead
of open-codying it
13117779: [v3,mptcp-next,02/15] mptcp: fix locking for setsockopt
corner-case
13117780: [v3,mptcp-next,03/15] mptcp: fix locking for in-kernel
listener creation.
13117781: [v3,mptcp-next,04/15] mptcp: refactor passive socket
initialization.
13117783: [v3,mptcp-next,05/15] mptcp: drop unneeded argument
13117784: [v3,mptcp-next,06/15] mptcp: drop legacy code.
13117785: [v3,mptcp-next,07/15] mptcp: avoid unneeded
__mptcp_nmpc_socket() usage
13117786: [v3,mptcp-next,08/15] mptcp: move fastopen subflow check
inside mptcp_sendmsg_fastopen()
13117787: [v3,mptcp-next,09/15] mptcp: move first subflow allocation at
mpc access time
13117788: [v3,mptcp-next,10/15] mptcp: do not keep around the first
subflow after disconnect.
13117789: [v3,mptcp-next,11/15] mptcp: fastclose msk when cleaning
unaccepted sockets
13117790: [v3,mptcp-next,12/15] inet: factor out locked section of
inet_accept() in a new helper
13117791: [v3,mptcp-next,13/15] mptcp: refactor mptcp_stream_accept()
13117792: [v3,mptcp-next,14/15] security, lsm: Introduce
security_mptcp_add_subflow()
13117793: [v3,mptcp-next,15/15] selinux: Implement mptcp_add_subflow hook:
      - Series: mptcp: refactor first subflow init
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=716019&state=*&archive=both

13120889: [mptcp-others-next] mptcp: bpf: Pass const struct bpf_prog *
to .check_member:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230130102608.1278837-1-matthieu.baerts@tessares.net/

13121420: [mptcp-net,v3] mptcp: be careful on subflow status propagation
on errors:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/b9cfd415281fc206300a3adbcdbd36047facb31c.1675095773.git.pabeni@redhat.com/



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
      - status: same as last week: see MPTCP sched discussions ↓

13100280: [mptcp-next,v2] mptcp: update userspace pm subflows info:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/d262f6beb6899f0a79acbeb1d3c8c855e95e098a.1673599496.git.geliang.tang@suse.com/
      - patch is OK but other counters need to be updated as well (more
patches needed before closing the linked story)

13122893: [mptcp-net,v2,1/2] selftests: mptcp: allow more slack for slow
test-case
13122894: [mptcp-net,v2,2/2] selftests: mptcp: stop tests earlier:
      - State: New
      - Series: selftests: mptcp: stabilise 'endpoint' Join tests
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=717332&state=*&archive=both
      - Patch 2/2: to be reviewed (someone else than Matth)



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 338):

  340  netlink: switch to YAML Netlink specs [enhancement]:
      - linked to the discussion we had last week


    Bugs (opened, flagged as "bug" and assigned)

  329  PM: userspace: update `MPTCP_INFO` fields [bug] @geliangtang:
      - see patches above

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni:
      - see patches above


    Bugs (opened and flagged as "bug" and not assigned)

  336  Issues with BPF packet scheduler [bug]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: test 98 `fastclose test` is sometimes
failing [bug] [selftests]

  323  selftests: `mptcp_join`: test 115 `delete and re-add` is often
failing [bug] [selftests]:
      - see patches above

  318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
cookies [bug] [selftests]:
      - still appearing in the public CI
      - not easy to reproduce
      - might help to stress the host and lower prio of the VM
      - maybe a sysctl to reduce the timeout → didn't find any
      - + add losses? → maybe

  315  Issues with backup flow [bug]


    In Progress (opened, new feature and assigned)

  330  `MPTCP_INFO`: document and support `mptcpi_subflows` for the
server side [enhancement] @geliangtang
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang:
      - See patches above

   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

  307  TCP performance better than MPTCP [question] @matttbe


    Open questions (opened, questions and not assigned)

  326  Issue with streaming traffic with MPTCP upstream implementation
[question]


    For later (opened and not assigned assigned)

  340  netlink: switch to YAML Netlink specs [enhancement]
  337  in-kernel PM: listen socket: support "behind a NAT" use case
[enhancement]
  335  Server to Client subflows: option to allow joining the initial
address and port [enhancement]
  334  PM: in-kernel: send >1 ADD_ADDR before the establishment of a new
subflow [enhancement]
  333  New MIBs to help understanding issues when PM cannot create new
subflows [enhancement]
  332  scheduler: implement a "opportunistic retransmission" [enhancement]
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


    Recently closed (since 2023-01-24)

  339  selftests: diag: failing: found msk after flush while expected
none [bug] [selftests] @pabeni
  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]
  269  Allow having a mix of v4/v6 subflows for the same socket
[enhancement] @pabeni



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.3):
https://github.com/multipath-tcp/mptcp_net-next/projects/18
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - Fixes for other trees: /

    - Fixes for -net:

        - [80b7821256d6] mptcp: do not wait for bare sockets' timeout
(Paolo Abeni)
        - [4d4269f3e7be] mptcp: fix locking for setsockopt corner-case
(Paolo Abeni)
        - [4eda52f8aeb1] mptcp: fix locking for in-kernel listener
creation (Paolo Abeni)
        - [fffc47c3e4dc] mptcp: be careful on subflow status propagation
on errors (Paolo Abeni):
            - better to wait a bit more
            - can be sent by the end of the week with the 2 other fixes
that are pending

    - Fixes for net-next: /

    - Features for net-next:

        - [a0e82f11fb99] mptcp: use mptcp_schedule_work() instead of
open-coding it (Paolo Abeni)
        - [fd5c29ff1f34] mptcp: refactor passive socket initialization
(Paolo Abeni)
        - [42c581b79e4f] mptcp: drop unneeded argument (Paolo Abeni)
        - [dd1b3cb74f1b] mptcp: drop legacy code (Paolo Abeni)
        - [f6a16ead2d5b] mptcp: avoid unneeded __mptcp_nmpc_socket()
usage (Paolo Abeni)
        - [f52b15ba44f5] mptcp: move fastopen subflow check inside
mptcp_sendmsg_fastopen() (Paolo Abeni)
        - [7122479b846e] mptcp: move first subflow allocation at mpc
access time (Paolo Abeni)
        - [50ebf048b443] mptcp: do not keep around the first subflow
after disconnect (Paolo Abeni)
        - [9ba9c1a4e057] mptcp: fastclose msk when cleaning unaccepted
sockets (Paolo Abeni)
        - [8cc90eaa1ac9] inet: factor out locked section of
inet_accept() in a new helper (Paolo Abeni)
        - [eeab9a31c0a5] mptcp: refactor mptcp_stream_accept() (Paolo
Abeni):
            - it looks like it is too late to have these patches in the
current merge window:
                - they depends on patches above that need to be sent to -net
                - important to have them tested by syzkaller and more
                - best to avoid sending a lot of patches at the end of
the merge window
                - we are on rc6, an rc8 is expected, final release in
less than 3 weeks


    - Features for net-next (next):/

    - Features for other trees:

        - [aa7640655582] security, lsm: Introduce
security_mptcp_add_subflow() (Paolo Abeni)
        - [fcde89fba294] selinux: Implement mptcp_add_subflow hook
(Paolo Abeni):
            - need to wait to have some dependences in Linus tree first

        - [c8ad2a868f6b] mptcp: refactor push_pending logic (Geliang Tang)
        - [e03468a34818] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [36bab2e0ad58] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [53a5320fb9c0] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [faaf0bb47122] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [2289a2aa67d8] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [1c9e04054ff4] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [0fcc7005f1de] mptcp: add scheduler wrappers (Geliang Tang)
        - [e7942534501c] mptcp: use get_send wrapper (Geliang Tang)
        - [2edbb9d222b4] mptcp: use get_retrans wrapper (Geliang Tang)
        - [e46187ec7b26] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [a29a1b8fab0c] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [213d45dab44b] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [3b358a5fbd70] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [8e96b4339581] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [da3383358ca3] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [b1306ecbfb7d] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [d51de165b562] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [dc484fd9f61f] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [b9b2cac1e165] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [c7e7857220a3] selftests/bpf: Add bpf_red test (Geliang Tang):
            - status: same as last week



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - nothing new for MPTCP

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - /
        - TODO: remove the section (Matth) → Done

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - /



mptcpd:
    - 0.12 has been tagged
    - transfer has been done: https://github.com/multipath-tcp/mptcpd
    - website moved: https://mptcpd.mptcp.dev
    - but not announced on the ML yet:
        - Ossama will do that → Done



MPTCP Scheduler API:
    - from the last meeting:
        - a new callback each time a ACK is received is required
        - penalisation: keep state per sf to send a fraction of the cwnd
        - be able to re-inject quicker from the scheduler (see below)
        - the default sched should do ↑

    - opportunistic reinjection:
        - is it complex to put in place with the current architecture?
        - additional hooking needed for the MPTCP sched:
            - currently there are only hooks for the MPTCP RTO
            - the packet sched should be able to get more info:
                - MPTCP cwnd close or the seq num has increased
                - (max allowed MPTCP level seq num to be sent == last
ack + (...))
            - typically: a RTO at subflow level:
                - hooking at TCP window level changes should be enough:
                    - maybe too frequent?
                    - might affect perf?
                - or hook in MPTCP options to do more checks there?:
                    - quite heavy, the core should filter events
        - do we ever significantly queue more than what the cwnd of a
subflow would accept?:
            - currently, the in-kernel only accepts to queue up to the
MPTCP level cwnd
            - (a few more bytes due to rounding)
            - do we have enough hook / missing events?
            → can be checked with packetdrill: a ACK is received at TCP
level and the scheduler might not send anything while it should.

    - about "a new callback each time a ACK is received is required":
        - just to be sure:
            - when a TCP ACK is received (at subflow level)?
            - not when an "MPTCP ACK" is received (at MPTCP level)?
        - see above

    - probing:
        - extend the "stale" logic?
        - if a subflow is marked as "stale", a probing should be done:
            - already there if there is data to be sent at TCP level
            - if there is no data, no probing done
            - something more is needed, e.g. (periodically) force a
reinjection (last data sent but not ACKed yet - we don't want to send
"new" data only on this subflow as the chance is high the subflow is
currently "bad")
        - the sched should be able to (un)mark a subflow:
            - it should be possible to do that with BPF by modifying the
'stale' bit

    - some area in the socket structure reserved for the scheduler:
        - a refactoring is probably needed not to increase the size too much
        - at MPTCP level and subflow level

    - next steps:
        - document ↑ in (a) new ticket(s) → TODO Matt
        - packetdrill for the scenario mentioned above



Other topics:
    - Mat & Ossama will probably no longer be able to join the following
meetings
    - Thank you for having led the different projects so well!
    - Good luck with your new projects!



Next meeting:
    - Next one on Tuesday, the 7th of February.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230207



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
