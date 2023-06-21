Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A9AC8D9
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 09:18:20 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-988a2715b8cso596897966b.0
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 02:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687339098; x=1689931098;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYWySbwFQSB5vFMfCpgxkkDjFU8kc/0Cd5NnFDNPn44=;
        b=b3LoShGeg5aqrs1Vd2WdOtEAZEhkhC7Dpf23dgHzNAX7jxY5bn1CmiDmOBDboTwPqZ
         g2GjZTTukwkx2PStnfEoexRMwuGhxUo20+BAhWFdwyc0LNZaUj3zHJR+Fx96Hh4YuX7j
         sVCJc9vluYZHTrJVxAMe2Trn/IAMLXmJ89uarErCV2KBrS+4+ex7Yo3y2FoUdhsv1AGo
         ZFYgm4uoJk8B5AKRoE3fGUdC+C1PvnI/HmvR2aNIYtHou1cH3FK1u5mh6oddwvdeu8dr
         gTq2b+FA62JZJe4AvgHk207cWtAJIWDW5hReyQ+3cSHofGtAgcZ2GlPT3dzd/hyhad9d
         BI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339098; x=1689931098;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nYWySbwFQSB5vFMfCpgxkkDjFU8kc/0Cd5NnFDNPn44=;
        b=Qh/Kcyha1ia4Sa/MIYmUjCmUrGvRJIJZf4pzejksrwZtZ6QR7ZT8734UxB36Ddn6H2
         hDsuzP2yHET5Yh4NxM/uWyhKaJw3NSHrS4/72bIO9LdLwkvJBUIYzldSi8fVzU/YcGp3
         dXxUwheBsZZrKHt0Zz2NuYDJmofRiO0B7Ctr+YOY8ZB9lj54D+GLYjf5LPzBmTpWPzeY
         1O5wtZ9gnyx+oGTtD6CXqVX/tLP1BPMheRcrMLCN5TMQ7iz8XxUeVUG0KmA5tiquX8ow
         bKjJvEbH7nz9OWsF6XbSMp1VDapZ4YpFIm/ldD5h4jonk9NSgNY0vLG7d/q7FLkh6xnF
         ehdQ==
X-Gm-Message-State: AC+VfDwwVBRceU+H1xdtjJvyYEbjI0L0Ndlk/GWmMMnyQPrD62gIlcfV
	bAwb3Y73c2gEDmh+SxnY0F5gms+4mR1eV5vwB0800g==
X-Google-Smtp-Source: ACHHUZ5ZoTOxfw6XCkhuIMfAr6GwkAchbcOaMvNAjO+4SjGhVG0S+INbt1/5NBMBEdTgSq3LZ1teCw==
X-Received: by 2002:a17:907:16a0:b0:988:c571:f24e with SMTP id hc32-20020a17090716a000b00988c571f24emr7113798ejc.15.1687339097564;
        Wed, 21 Jun 2023 02:18:17 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ec58:3685:faff:bbc2? ([2a02:578:8593:1200:ec58:3685:faff:bbc2])
        by smtp.gmail.com with ESMTPSA id v7-20020a170906488700b009880f55ec83sm2792470ejq.45.2023.06.21.02.18.16
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 02:18:17 -0700 (PDT)
Message-ID: <7f75d51e-64bd-8163-e4dc-f7a3d26b38c9@tessares.net>
Date: Wed, 21 Jun 2023 11:18:16 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 20th of June 2023
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Yesterday, we had our 246th meeting with Mat (Cruise) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Paolo Abeni):

13276939: [mptcp-net] mptcp: consolidate fallback and non fallback state
machine:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/f684967fa27c0d051ba3668c45f89ba1ba97a03d.1686584384.git.pabeni@redhat.com/

13276938: [mptcp-next] mptcp: drop legacy code.:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/3bac625cd995fdb3fc6786b599e3c413f00fc6f5.1686584494.git.pabeni@redhat.com/

13280133: [mptcp-net] mptcp: ensure listener is unhashed before updating
the sk status:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/b96e12c9dd08dca94ce2539b01d0e609d472a22a.1686754464.git.pabeni@redhat.com/

13282175: [mptcp-next,v20,01/10] mptcp: pass addr to
mptcp_pm_alloc_anno_list
13282176: [mptcp-next,v20,02/10] selftests: mptcp: test userspace pm out
of transfer
13282177: [mptcp-next,v20,03/10] selftests: mptcp: check subflow and
addr infos
13282178: [mptcp-next,v20,04/10] selftests: mptcp: set FAILING_LINKS in
run_tests
13282179: [mptcp-next,v20,05/10] selftests: mptcp: drop test_linkfail
parameter
13282180: [mptcp-next,v20,06/10] selftests: mptcp: drop addr_nr_ns1/2
parameters
13282181: [mptcp-next,v20,07/10] selftests: mptcp: drop sflags parameter
13282182: [mptcp-next,v20,08/10] selftests: mptcp: add
pm_nl_set_endpoint helper:
      - Series: update userspace pm mptcp_info fields part 2
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=757748&state=*&archive=both
      - Only the 1-8/10 patches


Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Breno Leitao, Christophe JAILLET,
David Howells):

13279920: [RFC,v2,1/4] net: wire up support for file_operations->uring_cmd()
13279921: [RFC,v2,2/4] net: add uring_cmd callback to UDP
13279922: [RFC,v2,3/4] net: add uring_cmd callback to TCP
13279923: [RFC,v2,4/4] net: add uring_cmd callback to raw "protocol":
      - Series: add initial io_uring_cmd support for sockets
      - Submitter: Breno Leitao
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=757068&state=*&archive=both
      - the new version should be different to use internal kernel API
from io_uring and not having to modify each sockets → so good for MPTCP

13283562: [net-next,v2,16/17] sock: Remove ->sendpage*() in favour of
sendmsg(MSG_SPLICE_PAGES)
13283563: [net-next,v2,17/17] net: Kill MSG_SENDPAGE_NOTLAST:
      - Series: -
      - Submitter: David Howells
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=758096&state=*&archive=both
      - some modifications everywhere but fine for us because we use TCP
stuff and the modifications they did are the same as what was done in TCP

13283791: [net-next] mptcp: Reorder fields in 'struct mptcp_pm_add_entry':
      - Submitter: Christophe JAILLET
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/e47b71de54fd3e580544be56fc1bb2985c77b0f4.1687081558.git.christophe.jaillet@wanadoo.fr/
      - Reviewed by Matth, small patch


    our repo (by: Davide Caratti, Geliang Tang, Matthieu Baerts):

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
      - Status is the same as last week

13203764: [RFC,mptcp-net-next,1/5] tools: ynl: add uns-admin-perm to
genetlink legacy
13203766: [RFC,mptcp-net-next,2/5] tools: ynl: fix bug in case of
multiple nested attributes of the same type
13203767: [RFC,mptcp-net-next,3/5] Documentation: netlink: add a YAML
spec for mptcp
13203768: [RFC,mptcp-net-next,4/5] mptcp: uapi: add header files
generated from YAML spec
13203769: [RFC,mptcp-net-next,5/5] net/mptcp: use netlink policy
generated from YAML spec:
      - State: Changes requested
      - Series: YAML template for MPTCP netlink API
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=737723&state=*&archive=both
      - Status is the same as last week

13276229: [mptcp-next,v3] mptcp: convert netlink from small_ops to ops:
      - State: Changes requested
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/c840f47bde581fcf910f24df6d136293618ba1d6.1686564758.git.dcaratti@redhat.com/
      - Status is the same as last week

13279467: [mptcp-next,v9,01/23] Squash to "mptcp: drop last_snd and
MPTCP_RESET_SCHEDULER"
13279468: [mptcp-next,v9,02/23] Squash to "mptcp: add struct
mptcp_sched_ops"
13279469: [mptcp-next,v9,03/23] Squash to "mptcp: add
sched_data_set_contexts helper"
13279470: [mptcp-next,v9,04/23] mptcp: add mptcp_subflow_ctx_by_pos helper
13279471: [mptcp-next,v9,05/23] Squash to "mptcp: add scheduler wrappers"
13279472: [mptcp-next,v9,06/23] mptcp: add last_snd in sched_data
13279473: [mptcp-next,v9,07/23] mptcp: add snd_burst in sched_data
13279474: [mptcp-next,v9,08/23] mptcp: register default scheduler
13279475: [mptcp-next,v9,09/23] Squash to "bpf: Add bpf_mptcp_sched_ops"
13279476: [mptcp-next,v9,10/23] Squash to "bpf: Add
bpf_mptcp_sched_kfunc_set"
13279477: [mptcp-next,v9,11/23] Squash to "selftests/bpf: Add mptcp
sched structs"
13279478: [mptcp-next,v9,12/23] Squash to "selftests/bpf: Add bpf_first
scheduler"
13279479: [mptcp-next,v9,13/23] Squash to "selftests/bpf: Add bpf_bkup
scheduler"
13279480: [mptcp-next,v9,14/23] Squash to "selftests/bpf: Add bpf_rr
scheduler"
13279481: [mptcp-next,v9,15/23] Squash to "selftests/bpf: Add bpf_red
scheduler"
13279482: [mptcp-next,v9,16/23] mptcp: add two wrappers needed by bpf_burst
13279483: [mptcp-next,v9,17/23] bpf: Add bpf_burst write accesses
13279484: [mptcp-next,v9,18/23] bpf: Export more bpf_burst related functions
13279485: [mptcp-next,v9,19/23] selftests/bpf: Add bpf_burst scheduler
13279486: [mptcp-next,v9,20/23] selftests/bpf: Add bpf_burst test
13279487: [mptcp-next,v9,21/23] bpf: Add subflow bit flags write accesses
13279488: [mptcp-next,v9,22/23] selftests/bpf: Add bpf_stale scheduler
13279489: [mptcp-next,v9,23/23] selftests/bpf: Add bpf_stale test:
13279511: [mptcp-next] Squash to "mptcp: add mptcp_subflow_ctx_by_pos
helper":
13279642: [mptcp-next] selftests: bpf: Add time metrics for sched tests:
      - State: Changes requested
      - Series: BPF packet scheduler updates
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=756923&state=*&archive=both
      - discussions ongoing about how info are being stored: it might be
easier and clearer to use bpf map that can be set from the BPF app and
even accessed by the core if the key is shared (e.g. using a pointer).
      - At least now, it would be easier to do that than sharing some
data on the socket. We could reserve some place in the socket structure
as an optimisation later (if justified).

13282183: [mptcp-next,v20,09/10] selftests: mptcp: pass fastclose to sflags
13282184: [mptcp-next,v20,10/10] selftests: mptcp: set endpoint out of
transfer:
      - State: Changes requested
      - Series: update userspace pm mptcp_info fields part 2
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=757748&state=*&archive=both



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 413):

  415  ss: display new counters from v6.5 [enhancement] [iproute2]:
      - linked to "mptcp: track some aggregate data counters"
      - new counters for the retransmissions and the bytes that have
been transferred
      - should be easy to add but certainly better to do that after the
release of the v6.4 after the sync of the headers, etc.
      - (and the patch above has not been applied upstream yet)

  414  syzkaller: divide error in `__tcp_select_window` [bug] [syzkaller]:
      - similar to 404 issue?

    Bugs (opened, flagged as "bug" and assigned)

  368  selftests: skip tests not being supported by older kernels [bug]
[selftests] @matttbe:
      - Matth is adding subtests support
      - Some tests stop when an error is detected (mptcp_connect.sh
after each group of test and userspace_pm.sh after each test):
          - maybe we can remove that?


    Bugs (opened and flagged as "bug" and not assigned)

  414  syzkaller: divide error in `__tcp_select_window` [bug] [syzkaller]:
      - see above

  400  packetdrill: data are retransmited after the `close()` [bug]
[packetdrill]
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
  324  selftests: `mptcp_join`: test 98 `fastclose test` is sometimes
failing [bug] [selftests]
  318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
cookies [bug] [selftests]
  315  Issues with backup flow [bug]
  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]


    In Progress (opened, new feature and assigned)

  403  userspace pm: local_addr_list: use a refcount per entry
[enhancement] [pm] @geliangtang
  353  sockopt: uniform code to get/set values [enhancement] @matttbe
  342  scheduler: area in the socket structures reserved for schedulers
[enhancement] [sched] @geliangtang:
      - see patches above

  340  netlink: switch to YAML Netlink specs [enhancement] @dcaratti
      - see patches above

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] [sched] @geliangtang
      - see patches above

   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

  381  Why does total throughput increase when the delay on one of the
paths increases? [question] @matttbe


    Open questions (opened, questions and not assigned)

  413  Question: Transport Converters for non-MPTCP end devices [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]:
      - issues with a v5.15 kernel
      - maybe fixed in v5.15.xxx?
      - or a fix not backported to v5.15?
      - waiting for reproducing the issue on a newer kernel

  411  Problem with IPROTO [question]
  395  If MPTCP primary flow is over tun interface, no subflow gets
created [question]
  392  Problem attempting to use all my interfaces (subflows)  [question]


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
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
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


    Recently closed (since 2023-06-13)

  407  syzkaller: possible deadlock in `inet_sk_diag_fill` [bug]
[syzkaller] [reproducer] [bisected] @pabeni



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.5):
https://github.com/orgs/multipath-tcp/projects/3/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1



Patches to send to netdev:

    - Fixes for other trees:

        - [03e636df673d] Revert "Merge tag '9p-6.4-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs" (Matthieu
Baerts):
            - just for our CI, tracked by regzbot:

https://linux-regtracking.leemhuis.info/regzbot/regression/855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net/

    - Fixes for -net:

        - [75793be31e10] mptcp: handle correctly disconnect() failures
(Paolo Abeni)
        - [301548487100] mptcp: fix possible divide by zero in recvmsg()
(Paolo Abeni)
        - [0db0a66d01cb] mptcp: fix possible list corruption on passive
MPJ (Paolo Abeni)
        - [423248a9cda3] mptcp: consolidate fallback and non fallback
state machine (Paolo Abeni)
        - [e51d1232f2f1] mptcp: drop legacy code around RX EOF (Paolo Abeni)
        - [ac1511f14d3f] mptcp: ensure listener is unhashed before
updating the sk status (Paolo Abeni):
            - @Christoph: no other issues than #414?
            - Should be fine to send them: TODO Matth → Done

    - Fixes for net-next:

        - [ae0194e55bf9] selftests: mptcp: join: skip check if MIB
counter not supported (part 2) (Matthieu Baerts):
            - can be sent as a single patch or part of another series
            - TODO: Matth: send them today → Done

        - [c54768218250] mptcp: Reorder fields in 'struct
mptcp_pm_add_entry' (Christophe JAILLET):
            - sent to net-next directly

    - Features for net-next:

        - [69172e07c206] mptcp: move snd_una update earlier for fallback
socket (Paolo Abeni)
        - [af6b0f2a6221] mptcp: track some aggregate data counters
(Paolo Abeni):
            - it needs "mptcp: ensure listener is unhashed before
updating the sk status" to avoid possible reports from syzkaller but the
bug was already there before and not directly related
            - OK to send now and add a note in the cover-letter? yep
            - TODO: Matth: send them today → Done

        - [e704e9820c30] selftests: mptcp: explicitly tests aggregate
counters (Paolo Abeni)

        - [9b6998f54a82] mptcp: add subflow unique id (Paolo Abeni)
        - [de4406beacaf] mptcp: introduce MPTCP_FULL_INFO getsockopt
(Paolo Abeni)
        - [1f043844ec79] selftests: mptcp: add MPTCP_FULL_INFO testcase
(Paolo Abeni)

        - [e5ea470df90f] mptcp: consolidate transition to TCP_CLOSE in
mptcp_do_fastclose() (Paolo Abeni):
            - in our tree for a bit of time, can be sent
            - TODO: Matth: send them today → Done

        - [4a630f8a4a27] mptcp: pass addr to mptcp_pm_alloc_anno_list
(Geliang Tang):
            - a simple refactoring, can be sent as well just to leave
the modifications below in the selftests for later?
            - TODO: Matth: send them today → Done

        - [24f2ac52b94e] selftests: mptcp: test userspace pm out of
transfer (Geliang Tang)
        - [2aed679d0ada] selftests: mptcp: check subflow and addr infos
(Geliang Tang)
        - [38cfe4f88152] selftests: mptcp: set FAILING_LINKS in
run_tests (Geliang Tang)
        - [0a6a33b19453] selftests: mptcp: drop test_linkfail parameter
(Geliang Tang)
        - [e5c8f62ad738] selftests: mptcp: drop addr_nr_ns1/2 parameters
(Geliang Tang)
        - [c313db45f562] selftests: mptcp: drop sflags parameter
(Geliang Tang)
        - [4f177ee00d5c] selftests: mptcp: add pm_nl_set_endpoint helper
(Geliang Tang):
             - maybe too late for v6.5?
             - or check by the end of the week if other MPTCP patches
have been applied?
             - Mat will check on Friday.

    - Features for net-next (next): /

    - Features for other trees:

        - [53f62e9d9a62] security, lsm: Introduce
security_mptcp_add_subflow() (Paolo Abeni)
        - [9400a9929759] selinux: Implement mptcp_add_subflow hook
(Paolo Abeni)
        - [af9b344a2276] mptcp: refactor push_pending logic (Geliang Tang)
        - [b7f21b201d3c] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [6f683ad21503] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [dd6b7d08f541] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [6fd0bbca8839] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [bb357b30f55f] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [e4865b776029] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [1f1ba108d1ae] mptcp: add scheduler wrappers (Geliang Tang)
        - [5038c0dc3cf4] mptcp: use get_send wrapper (Geliang Tang)
        - [e97f4b795f4d] mptcp: use get_retrans wrapper (Geliang Tang)
        - [31a129a1d1e4] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [4df8d7a8ca2a] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [fb50a3abd3fe] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [f2fd804cdd0c] selftests/bpf: use random netns name for mptcp
(Geliang Tang)
        - [0ff416a5f786] selftests/bpf: add two mptcp netns helpers
(Geliang Tang)
        - [521c0ea8c7d9] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [3e2e375f60fb] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [33af308cc532] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [6a9a874a1581] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [8fb1528b25c7] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [c84ba9f3f61e] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [5ed35d616639] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [97ba6f218d74] selftests/bpf: Add bpf_red test (Geliang Tang):
            - status: same as last week



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - @Paolo: can we merge
https://github.com/multipath-tcp/packetdrill/pull/115 ?

    - Patchew (Davide):
        - /

    - CI (Matth):
        - /


6.4-rc7:
    - From Linus: "Nothing particular stands out in the rc this week,
unless you count the mptcp selftest changes that are about making the
tests work on stable kernels too. That accounts for almost a quarter of
the patch..." :-D
    -
https://lore.kernel.org/lkml/CAHk-=wjtPpxeR0t980F8P+pkQ-wNLiH2fpyjxUFJNWGMYRmnuA@mail.gmail.com/



Next meeting:
    - Next one on Tuesday, the 27th of June.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230627



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
