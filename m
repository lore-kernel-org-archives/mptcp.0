Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76CC3C23
	for <mptcp@lists.linux.dev>; Tue, 25 Jul 2023 16:33:57 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so8886172e87.3
        for <mptcp@lists.linux.dev>; Tue, 25 Jul 2023 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690302835; x=1690907635;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJEGxn/Hvq4MouWBRTBG3ViPSSbPzMNKOzs1D/4lr90=;
        b=pHgP8rFS6ijXZSL8bO4cxiLaPOhOL4hT4Ebbc5WcF/YbGqG/EMfAwnMIspLC+4Z0Vp
         4mTqIUG6o6w48U552RC2s3mc7Tyvefif1g1Jvpq29ay9SCqm+/7K1ge06Q8oEYayb/F+
         Os1o5WC8+dR2hup3voJl5LyLeOEmJZWSBAmEVyK8epYf19uoik5dCt+JUCaMIUPYEWqA
         pO/peSpImHVIFPSRE7fOKtB8N0ll8Eb5hJSnuWIH8xHTk7JD6fvPN187bq9z/zXYLHOa
         EObjIa2/ETZfAtsR/vYy0mHSSRWVLQGA4uJY9zCmC3P0BZ5UFQyAunnGkGgECJBbNIkh
         8eCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690302835; x=1690907635;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vJEGxn/Hvq4MouWBRTBG3ViPSSbPzMNKOzs1D/4lr90=;
        b=j6B/qW55qQvo8CIwU3JruwT2nUcAA1zh7lJwZEwcIXOE1gXaeH89dN7YY2JU6N8SqD
         G+K57t0WIuX59d3HiPYSZWfrctLZUX7R4BXtt7+6ALqMshd6Avp4wIUXRVmEaxYpVb3B
         +I+9uymIeZymCWf3lpjOtigjaTzfj50c16/3lCdOTyDxKJVivXhmNtji3LgO6zLwKa8/
         2AFR6irsmc7A++ht+SwOr7Kekz1vbVgZIHbdgZXDRfcE4IAXiuxEpWLtCu1TGzBUlcyV
         JfeNH1ABePPWINYHhy5CNNcdp+XRkDBGmcXPuKU13H/ganRBUFTahqwFOm5W6z8JFRhZ
         Gs5A==
X-Gm-Message-State: ABy/qLZOWlpEREMqEfUy2plxZZyOUOuNA+FCmS9I14lEtDSqSN6+8F52
	aCqMeuAoCivplrMQJCcPLHFMyXKNv+zzjNhqXnQ=
X-Google-Smtp-Source: APBJJlF/9YkChkKrYqb8xK8TfIhZxUn/9MROR02t9DofPE8LnBvb8RQu0BYdlieJFK9NQjj+TnQORw==
X-Received: by 2002:a05:6512:3089:b0:4fb:978e:95b8 with SMTP id z9-20020a056512308900b004fb978e95b8mr9317442lfd.59.1690302834814;
        Tue, 25 Jul 2023 09:33:54 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:2dc1:7d15:b014:ac2? ([2a02:578:8593:1200:2dc1:7d15:b014:ac2])
        by smtp.gmail.com with ESMTPSA id w7-20020a5d4047000000b00313f61889ecsm16857059wrp.66.2023.07.25.09.33.54
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 09:33:54 -0700 (PDT)
Message-ID: <65fe37fd-583a-a756-0ffe-609feb21141f@tessares.net>
Date: Tue, 25 Jul 2023 18:33:53 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 25th of July 2023
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Today, we had our 251st meeting with Christoph (Apple), Paolo (Redhat),
Mat (Cruise) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13315711: [net-next,01/13] selftests: mptcp: connect: don't stop if error
13315712: [net-next,02/13] selftests: mptcp: userspace pm: don't stop if
error
13315713: [net-next,03/13] selftests: mptcp: userspace_pm: fix
shellcheck warnings
13315714: [net-next,04/13] selftests: mptcp: userspace_pm: uniform
results printing
13315715: [net-next,05/13] selftests: mptcp: userspace_pm: reduce dup
code around printf
13315716: [net-next,06/13] selftests: mptcp: lib: format subtests
results in TAP
13315717: [net-next,07/13] selftests: mptcp: connect: format subtests
results in TAP
13315718: [net-next,08/13] selftests: mptcp: pm_netlink: format subtests
results in TAP
13315719: [net-next,09/13] selftests: mptcp: join: format subtests
results in TAP
13315720: [net-next,10/13] selftests: mptcp: diag: format subtests
results in TAP
13315721: [net-next,11/13] selftests: mptcp: simult flows: format
subtests results in TAP
13315722: [net-next,12/13] selftests: mptcp: sockopt: format subtests
results in TAP
13315723: [net-next,13/13] selftests: mptcp: userspace_pm: format
subtests results in TAP:
      - Series: selftests: mptcp: format subtests results in TAP
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=766499&state=*&archive=both

13320997: [net-next] mptcp: fix rcv buffer auto-tuning:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230720-upstream-net-next-20230720-mptcp-fix-rcv-buffer-auto-tuning-v1-1-175ef12b8380@tessares.net/
      - fix needed because of a recent modification on TCP side


    our repo (by: Paolo Abeni):

13319838: [mptcp-next,1/2] Squash-to: "mptcp: avoid unneeded
mptcp_token_destroy() call"
13319840: [mptcp-next,2/2] Squash-to: "mptcp: avoid additional
__inet_stream_connect() call":
      - Series: mptcp: subflow removal follow-ups
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=767642&state=*&archive=both

13320724: [mptcp-next,v2] mptcp: fix rcv buffer auto-tuning.:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/35589ab7fe16f915945f6402e28adb82f34a8287.1689868234.git.pabeni@redhat.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang):

13317405: [RFC,bpf-next,v5] bpf: Force to MPTCP:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/3076188eb88cca9151a2d12b50ba1e870b11ce09.1689693294.git.geliang.tang@suse.com/
      - TODO: ask what will be next: back to the previous version? Matth

    our repo (by: Andrea Claudi, Davide Caratti, Geliang Tang, Matthieu
Baerts):

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

13290474: [net,1/2] selftests: mptcp: join: fix 'delete and re-add' test
13290475: [net,2/2] selftests: mptcp: join: fix 'implicit EP' test:
      - State: Changes requested
      - Series: selftests: fix mptcp_join test
      - Submitter: Andrea Claudi
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=759793&state=*&archive=both
      - status: same as last week

13294008: [iperf3] add MPTCPv1 support:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/
      - status: same as last week

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
      - status: same as last week

13316705: [mptcp-next,v2,01/13] Squash to "bpf: Add bpf_mptcp_sched_ops"
13316706: [mptcp-next,v2,02/13] Squash to "selftests/bpf: Add bpf
scheduler test"
13316707: [mptcp-next,v2,03/13] Squash to "selftests/bpf: Add bpf_first
test"
13316708: [mptcp-next,v2,04/13] Squash to "selftests/bpf: Add bpf_bkup
scheduler"
13316709: [mptcp-next,v2,05/13] Squash to "selftests/bpf: Add bpf_bkup test"
13316710: [mptcp-next,v2,06/13] Squash to "selftests/bpf: Add bpf_rr test"
13316711: [mptcp-next,v2,07/13] Squash to "selftests/bpf: Add bpf_red test"
13316712: [mptcp-next,v2,08/13] mptcp: add subflow_set_stale helper
13316713: [mptcp-next,v2,09/13] selftests/bpf: Add bpf_stale scheduler
13316714: [mptcp-next,v2,10/13] selftests/bpf: Add bpf_stale test
13316715: [mptcp-next,v2,11/13] bpf: Export more bpf_burst related functions
13316716: [mptcp-next,v2,12/13] selftests/bpf: Add bpf_burst scheduler
13316717: [mptcp-next,v2,13/13] selftests/bpf: Add bpf_burst test:
      - State: Needs ack
      - Series: BPF packet scheduler updates part 2
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=766762&state=*&archive=both
      - Addressing Mat's comments
      - Mat will look at the v2

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
      - Davide will look at sending a v2 later



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 419):

  423  syzkaller: BUG: unable to handle kernel NULL pointer dereference
in `mptcp_stream_accept` [bug] [syzkaller] [reproducer]:
      - Paolo is not able to reproduce it but Christoph can → neither of
them can reproduce it. Close it?
      - debug patch has been shared

  422  syzkaller: BUG: soft lockup in `inet_stream_connect` [bug]
[syzkaller]:
      - can be closed, fixed by Paolo's last squash-to patches → Done
  421  syzkaller: BUG: soft lockup in `NF_HOOK` [bug] [syzkaller]:
      - can be closed, fixed by Paolo's last squash-to patches → Done

  420  syzkaller: WARNING in `__mptcp_move_skbs_from_subflow` [bug]
[syzkaller]


    Bugs (opened, flagged as "bug" and assigned)

  417  Verifier blocks access to tcp_sock fields [bug] [bpf] @geliangtang

  400  packetdrill: data are retransmitted after the `close()` [bug]
[packetdrill] @matttbe:
      - issue in 9p

  290  Not possible to `connect()` after a disconnect for a passive
socket [bug] @pabeni


    Bugs (opened and flagged as "bug" and not assigned)

  423  syzkaller: BUG: unable to handle kernel NULL pointer dereference
in `mptcp_stream_accept` [bug] [syzkaller] [reproducer]
  422  syzkaller: BUG: soft lockup in `inet_stream_connect` [bug]
[syzkaller]
  421  syzkaller: BUG: soft lockup in `NF_HOOK` [bug] [syzkaller]
  420  syzkaller: WARNING in `__mptcp_move_skbs_from_subflow` [bug]
[syzkaller]
  419  selftests: `mptcp_connect.sh`: disconnect: MPTCP → TCP:
Unexpected revents: `POLLERR/POLLNVAL(19)` [bug] [selftests]
  416  No new subflow when removing an endpoint and adding a new one [bug]
  398  syzkaller: memory leak in `subflow_ulp_init` [bug] [syzkaller]
  391  PM: userspace: unable to create additional subflows with the
local addr ID 0 [bug]
  379  userspace pm: ability to send `RM_ADDR` for all local IDs used (0
included) [bug] [pm]
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched]
  336  Issues with BPF packet scheduler [bug]
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

   79  allow 'force to MPTCP' mode: BPF [enhancement] @geliangtang:
      - see patches above

   75  BPF: packet scheduler [enhancement] [sched] @geliangtang:
      - see patches above

   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

None.


    Open questions (opened, questions and not assigned)

  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned assigned)

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


    Recently closed (since 2023-07-18)

None.


FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.6):
https://github.com/orgs/multipath-tcp/projects/4/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1



Patches to send to netdev:

    - Fixes for other trees:

        - [5964cd41ff28] Revert "Merge tag '9p-6.4-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs" (Matthieu Baerts)

    - Fixes for -net:

        - [054ec9520c7c] selftests: mptcp: join: only check for
ip6tables if needed (Matthieu Baerts)
        - [c3531a2dd8f2] mptcp: more accurate NL event generation (Paolo
Abeni):
            - can be sent: Mat will do that

    - Fixes for net-next: /

    - Features for net-next:

        - [02713bb9d0d7] selftests: mptcp: join: rework detailed report
(Matthieu Baerts)
        - [6ac6ac914de2] selftests: mptcp: join: colored results
(Matthieu Baerts)
        - [98a0648f545d] selftests: mptcp: pm_nl_ctl: always look for
errors (Matthieu Baerts)
        - [fb4a2edee9b7] selftests: mptcp: userspace_pm: unmute
unexpected errors (Matthieu Baerts):
            - can be sent: Matth will do that: TODO

        - [749dca21c24d] mptcp: avoid unneeded mptcp_token_destroy()
calls (Paolo Abeni)
        - [042e1e339f47] mptcp: avoid additional __inet_stream_connect()
call (Paolo Abeni)
        - [8be0dc1da1b9] mptcp: avoid subflow socket usage in
mptcp_get_port() (Paolo Abeni)
        - [b5d4067367e2] net: factor out inet{,6}_bind_sk helpers (Paolo
Abeni)
        - [fd490d7ee1de] mptcp: mptcp: avoid additional indirection in
mptcp_bind() (Paolo Abeni)
        - [058f1982de53] net: factor out __inet_listen_sk() helper
(Paolo Abeni)
        - [5abd88a01f94] mptcp: avoid additional indirection in
mptcp_listen() (Paolo Abeni)
        - [6e5dc87fb2c5] mptcp: avoid additional indirection in
mptcp_poll() (Paolo Abeni)
        - [e4ad13d0b5e4] mptcp: avoid unneeded indirection in
mptcp_stream_accept() (Paolo Abeni)
        - [2d659ae7ca2e] mptcp: avoid additional indirection in sockopt
(Paolo Abeni)
        - [20b3608a9693] mptcp: avoid ssock usage in
mptcp_pm_nl_create_listen_socket() (Paolo Abeni)
        - [ea8123f51ba0] mptcp: change the mpc check helper to return a
sk (Paolo Abeni)
        - [c5bab4ecaed1] mptcp: get rid of msk->subflow (Paolo Abeni):
            - can wait a bit ((maybe?) some issues spot by syzkaller)

    - Features for net-next (next): /

    - Features for other trees:

        - [0631f2b15b90] mptcp: refactor push_pending logic (Geliang Tang)
        - [0d56cbb7775c] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [47b06e0992db] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [01dfef755ae9] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [0561f9aaa370] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [6bb2c58ff6f8] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [e66819985871] mptcp: add sched_data helpers (Geliang Tang)
        - [c3dfb0e084c3] mptcp: add scheduler wrappers (Geliang Tang)
        - [fa5ebc0e1ab5] mptcp: use get_send wrapper (Geliang Tang)
        - [ed2afde2a766] mptcp: use get_retrans wrapper (Geliang Tang)
        - [4782641f15a2] mptcp: register default scheduler (Geliang Tang)
        - [2cfa830af41f] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [4d080a03cf95] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [c2e1f4513d72] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [9bc0468131f8] selftests/bpf: use random netns name for mptcp
(Geliang Tang)
        - [cd845c2a05c4] selftests/bpf: add two mptcp netns helpers
(Geliang Tang)
        - [fbd93f25a95f] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [1b3fb882a7cb] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [744642a358ec] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [7bb9551aa687] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [3c0248ffaaf4] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [cca85a258c50] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [f9caa80ab560] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [49d4ac87ea04] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [49b97062b572] selftests/bpf: Add bpf_red test (Geliang Tang):
            - status is the same as last week: WIP
            - but we will look at upstreaming some of them this merge
window, at least the ones only modifying MPTCP code



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - Davide reviewed the last PR, thanks!
        - (but we need to wait before applying it)

    - Patchew (Davide):
        - /

    - CI (Matth):
        - a few kmemleaks but not directly related to MPTCP, when
creating the netns:

https://api.cirrus-ci.com/v1/artifact/task/5822552300322816/summary/summary.txt
        - TODO: check if it has been reported on netdev → Matth


Other topics:
    - Marek from Cloudflare is testing mptcp:
        - https://github.com/multipath-tcp/mptcpd/issues/281
        - Paolo is going to reply



Next meeting:
    - Next one on Tuesday, the 1st of August.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230801



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
