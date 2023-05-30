Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF521F93B
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 17:10:37 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-973f78329e3so484233766b.3
        for <mptcp@lists.linux.dev>; Tue, 30 May 2023 10:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685466635; x=1688058635;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUzmHWRmR8gQBqfaDJBL5vm0kbRb1y1K3w3T1Sc+GAc=;
        b=44OibYjc6AT+LF27a6anpjJ5Gyz5POXF7JvmswE8QhvKjSM0Cch7I3B85lHA9/rWvr
         zST8XVD6k/ov4VCkiEZygQimSnD2eb0nUfroXnAobLorCDdb+qY9EC5Z/2oktaDrTcGQ
         /ZFzIm89vN9ImHsc2i/cpmoVoEZgLeHKqFlHcZtTN5DuadhdqG/N65Sp3DI2b93nvu+n
         hMY50J/R5p99rqRSXoNZGX8RkJ1ASBEsBfRfTw/54TujCW2PrGbPhjQuJ1i5H2uKZZKd
         qBkHwgED1kFwm0IbHXAVfKiOxpthDHNgxPpqiirgn2uYxRn/Y/CFoKMvtKxZg2vtYo/y
         AY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685466635; x=1688058635;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fUzmHWRmR8gQBqfaDJBL5vm0kbRb1y1K3w3T1Sc+GAc=;
        b=lFLvcCIectCGTUA/9p070SX+5spIbOG47ikNkPHByEa4iGsfmBvEfJ5FojHw209dJe
         brnZAEgj8qN6ITDtTswtUsZe0sIof+I+m7E7uTiuFR5RDF4IgABDVpcH7hsGbcPgUfH+
         bonsWMa8pCk6sLQvFK3HvfhFopijEIAQHi/xXRM4w2i2PqEzjY+ObgPRDdflxtXbodb+
         eLDg7qZePF3fJfTQrGeFA+RxnQSGkH1IBZSmCg8RgkISBYeCyPar/uGln7mQ9jxG56/M
         wjSxxXvqTYE3g4qqwv6RxtnvvTO/h/eCdzxy5WXBX5CEgMwjYV1PkeuUaKrnGS0EXdzC
         4qeA==
X-Gm-Message-State: AC+VfDxIPwOBU2ybXdTqRH+YrnW76OnR4Fvt4PM+0D4UaLqeXfNmIDBV
	Hb9VtIVt395H6/BboFVj5unZeKIJj/mGbQdGhaE=
X-Google-Smtp-Source: ACHHUZ6tqLOS7cYzx//bsGH/OwnHk/A5Olhb276hIliPIUxSHLQJ19kn1/wLTLypTWj8A+hS0Xt1fg==
X-Received: by 2002:a17:907:1c84:b0:974:32e:7de9 with SMTP id nb4-20020a1709071c8400b00974032e7de9mr3817732ejc.56.1685466634576;
        Tue, 30 May 2023 10:10:34 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id bh25-20020a170906a0d900b0096165b2703asm7515896ejb.110.2023.05.30.10.10.34
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 10:10:34 -0700 (PDT)
Message-ID: <a9be00dc-6c2e-0876-304f-1549bc146b36@tessares.net>
Date: Tue, 30 May 2023 19:10:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 30th of May 2023
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Today, we just had our 243rd meeting with Christoph (Apple), Mat
(Cruise) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13257891: [net,1/8] selftests: mptcp: join: avoid using 'cmp --bytes'
13257892: [net,2/8] selftests: mptcp: connect: skip if MPTCP is not
supported
13257893: [net,3/8] selftests: mptcp: pm nl: skip if MPTCP is not supported
13257894: [net,4/8] selftests: mptcp: join: skip if MPTCP is not supported
13257895: [net,5/8] selftests: mptcp: diag: skip if MPTCP is not supported
13257896: [net,6/8] selftests: mptcp: simult flows: skip if MPTCP is not
supported
13257897: [net,7/8] selftests: mptcp: sockopt: skip if MPTCP is not
supported
13257898: [net,8/8] selftests: mptcp: userspace pm: skip if MPTCP is not
supported:
      - Series: selftests: mptcp: skip tests not supported by old
kernels (part 1)
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=751679&state=*&archive=both


    our repo (by: Geliang Tang, Paolo Abeni):

13247106: [v2,mptcp-net,1/5] mptcp: add annotations around msk->subflow
accesses
13247107: [v2,mptcp-net,2/5] mptcp: consolidate passive msk socket
initialization
13247109: [v2,mptcp-net,3/5] mptcp: fix data race around msk->first access
13247110: [v2,mptcp-net,4/5] mptcp: add annotations around
sk->sk_shutdown accesses
13247111: [v2,mptcp-net,5/5] mptcp: fix active subflow finalization.:
      - Series: mptcp: a bunch of data race fixes
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=748987&state=*&archive=both

13253427: [mptcp-next,v15,1/5] mptcp: only send RM_ADDR in nl_cmd_remove
13253428: [mptcp-next,v15,2/5] selftests: mptcp: update userspace pm
addr tests
13253429: [mptcp-next,v15,3/5] mptcp: add address into userspace pm list
13253430: [mptcp-next,v15,4/5] selftests: mptcp: update userspace pm
subflow tests
13253431: [mptcp-next,v15,5/5] mptcp: update userspace pm infos:
      - Series: update userspace pm mptcp_info fields part 1
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=750531&state=*&archive=both

13254799: [v6,mptcp-next,1/6] mptcp: move snd_una update earlier for
fallback socket.
13254800: [v6,mptcp-next,2/6] mptcp: track some aggregate data counters.
13254802: [v6,mptcp-next,3/6] selftests: mptcp: explicitly tests
aggregate counters
13254804: [v6,mptcp-next,4/6] mptcp: add subflow unique id
13254805: [v6,mptcp-next,5/6] mptcp: introduce MPTCP_FULL_INFO getsockopt
13254803: [v6,mptcp-next,6/6] selftests: mptcp: add MPTCP_FULL_INFO
testcase:
      - Series: mptcp: add some more diag info
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=750868&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Breno Leitao):

13255211: [net-next,v3] net: ioctl: Use kernel memory on protocol ioctl
callbacks:
      - Submitter: Breno Leitao
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230525125503.400797-1-leitao@debian.org/


    our repo (by: Davide Caratti, Geliang Tang, Matthieu Baerts, Paolo
Abeni):

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
      - Status: same as last week

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
      - Status: same as last week

13240606: [mptcp-next,v13,2/7] selftests: mptcp: test userspace pm out
of transfer
13240607: [mptcp-next,v13,3/7] selftests: mptcp: check subflows infos
13240608: [mptcp-next,v13,4/7] selftests: mptcp: check add_addr infos
13240609: [mptcp-next,v13,5/7] mptcp: pass addr to mptcp_pm_alloc_anno_list
13240610: [mptcp-next,v13,6/7] selftests: mptcp: pass fastclose to sflags
13240611: [mptcp-next,v13,7/7] selftests: mptcp: set endpoint out of
transfer:
      - State: Changes requested
      - Series: update userspace pm mptcp_info fields pt 2
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=747379&state=*&archive=both
      - Status: same as last week: blocked by the next series ↓

13250526: [mptcp-next,v14,3/5] mptcp: export remove_anno_list_by_saddr
13250845: [mptcp-net,v2,08/37] selftests: mptcp: lib: skip if missing symbol
13250846: [mptcp-net,v2,09/37] selftests: mptcp: lib: skip if not below
kernel version
13250847: [mptcp-net,v2,10/37] selftests: mptcp: connect: skip transp
tests if not supported
13250848: [mptcp-net,v2,11/37] selftests: mptcp: connect: skip
disconnect tests if not supported
13250850: [mptcp-net,v2,12/37] selftests: mptcp: connect: skip TFO tests
if not supported
13250849: [mptcp-net,v2,13/37] selftests: mptcp: diag: skip listen tests
if not supported
13250851: [mptcp-net,v2,14/37] selftests: mptcp: diag: skip inuse tests
if not supported
13250853: [mptcp-net,v2,15/37] selftests: mptcp: pm nl: remove hardcoded
default limits
13250852: [mptcp-net,v2,16/37] selftests: mptcp: pm nl: skip fullmesh
flag checks if not supported
13250854: [mptcp-net,v2,17/37] selftests: mptcp: sockopt: relax expected
returned size
13250855: [mptcp-net,v2,18/37] selftests: mptcp: sockopt: skip
getsockopt checks if not supported
13250856: [mptcp-net,v2,19/37] selftests: mptcp: sockopt: skip TCP_INQ
checks if not supported
13250857: [mptcp-net,v2,20/37] selftests: mptcp: userspace pm: skip if
'ip' tool is unavailable
13250858: [mptcp-net,v2,21/37] selftests: mptcp: userspace pm: skip if
not supported
13250859: [mptcp-net,v2,22/37] selftests: mptcp: userspace pm: skip PM
listener events tests if unavailable
13250860: [mptcp-net,v2,23/37] selftests: mptcp: join: use
'iptables-legacy' if available
13250861: [mptcp-net,v2,24/37] selftests: mptcp: join: helpers to skip tests
13250866: [mptcp-net,v2,25/37] selftests: mptcp: join: skip check if MIB
counter not supported
13250862: [mptcp-net,v2,26/37] selftests: mptcp: join: skip test if
iptables/tc cmds fail
13250863: [mptcp-net,v2,27/37] selftests: mptcp: join: support local
endpoint being tracked or not
13250864: [mptcp-net,v2,28/37] selftests: mptcp: join: skip Fastclose
tests if not supported
13250865: [mptcp-net,v2,29/37] selftests: mptcp: join: support RM_ADDR
for used endpoints or not
13250867: [mptcp-net,v2,30/37] selftests: mptcp: join: skip implicit
tests if not supported
13250868: [mptcp-net,v2,31/37] selftests: mptcp: join: skip backup if
set flag on ID not supported
13250869: [mptcp-net,v2,32/37] selftests: mptcp: join: skip fullmesh
flag tests if not supported
13250870: [mptcp-net,v2,33/37] selftests: mptcp: join: skip userspace PM
tests if not supported
13250872: [mptcp-net,v2,34/37] selftests: mptcp: join: skip fail tests
if not supported
13250871: [mptcp-net,v2,35/37] selftests: mptcp: join: skip MPC backups
tests if not supported
13250873: [mptcp-net,v2,36/37] selftests: mptcp: join: skip PM listener
tests if not supported
13250874: [mptcp-net,v2,37/37] selftests: mptcp: join: skip mixed tests
if not supported:
      - State: Under review
      - Series: selftests: mptcp: skip tests when features are not supported
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=749868&state=*&archive=both
      - Status, see:
https://lore.kernel.org/mptcp/e64bd67a-af85-d573-a0dc-2d8c17837072@tessares.net/
          - The first patches skipping MPTCP if it is not supported have
been applied.
          - check kernel version: what about adding an env var that can
be set to skip the versions check? So it works if a new feature is
backported to an older kernel.
          - get_counter() to get the MIB counters: I can help the stable
team with the backports that will not be difficult I think but will
cause conflicts
          - check nf/tc issues: looks safer just in case a kconfig is
missing or an issue with nf/tc but can be removed if you prefer (still I
don't think we should exit in the middle of a test)
          - one check per block of tests around the same theme: it would
indeed avoid re-doing the same check 2 or 3 times but it would break the
IDs (+maybe less obvious a test might be skipped when reviewing code)
          - backports: at the end, we just need all these new checks to
be backported on the last stable kernel (6.3) because that's what is
used by the different CIs. It is fine if it is not backported after.
(but still I can help with the backports, I'm used to :) )
      - It looks like TC tests can report subtests, not sure how,
doesn't seem to be TAP 13 compliant but enough for us → to be checked
with Linaro testers

13250875: [mptcp-next] net: skip printing "link become ready" v6 msg:
      - State: Changes requested
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230522-mptcp-skip_print_link_becomes_ready-v1-1-9d5f28f19440@tessares.net/
      - Matth: TODO: seems OK to send it to netdev as it is as a RFC

13256270: [mptcp-next,v2,1/4] mptcp: export local_address
13256271: [mptcp-next,v2,2/4] mptcp: unify pm get_local_id interfaces
13256272: [mptcp-next,v2,3/4] mptcp: unify pm get_flags_and_ifindex_by_id
13256273: [mptcp-next,v2,4/4] mptcp: unify pm set_flags interfaces:
      - State: New
      - Series: unify PM interfaces
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=751208&state=*&archive=both
      - Matth: TODO: review the v2

13258600: [v2,mptcp-net,1/2] mptcp: handle correctly disconnect() failures
13258601: [v2,mptcp-net,2/2] mptcp: fix possible divide by zero in
recvmsg():
      - State: New
      - Series: [v2,mptcp-net,1/2] mptcp: handle correctly disconnect()
failures
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=751861&state=*&archive=both
      - Fixing issue 404 (which exists!)
      - On top of a patch for TCP, recently applied in net:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=4faeee0cf8a5d88d63cdbc3bab124fb0e6aed08c

13260021: [mptcp-next,v3,01/15] Squash to "mptcp: add struct
mptcp_sched_ops"
13260022: [mptcp-next,v3,02/15] Squash to "mptcp: add sched in mptcp_sock"
13260023: [mptcp-next,v3,03/15] Squash to "mptcp: add scheduler wrappers"
13260024: [mptcp-next,v3,04/15] mptcp: add last_snd in sched_data
13260025: [mptcp-next,v3,05/15] mptcp: add snd_burst in sched_data
13260026: [mptcp-next,v3,06/15] mptcp: register default scheduler
13260044: [mptcp-next,v3,07/15] mptcp: rename __mptcp_set_timeout for
bpf_burst
13260045: [mptcp-next,v3,08/15] mptcp: add two wrappers for bpf_burst
13260046: [mptcp-next,v3,09/15] mptcp: add three helpers for bpf_burst
13260047: [mptcp-next,v3,10/15] Squash to "bpf: Add bpf_mptcp_sched_ops"
13260048: [mptcp-next,v3,11/15] Squash to "bpf: Add
bpf_mptcp_sched_kfunc_set"
13260049: [mptcp-next,v3,12/15] Squash to "selftests/bpf: Add mptcp
sched structs"
13260050: [mptcp-next,v3,13/15] Squash to "selftests/bpf: Add bpf_rr
scheduler"
13260051: [mptcp-next,v3,14/15] selftests/bpf: Add bpf_burst scheduler
13260052: [mptcp-next,v3,15/15] selftests/bpf: Add bpf_burst test:
      - State: New
      - Series: save sched_data at mptcp_sock
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=752233&state=*&archive=both
      - Mat will have a look
      - Build issues might be due to squash-to patches introducing a
function that is not used directly or something similar?




Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 403):

  404  syzkaller: divide error in `__tcp_select_window` [bug] [syzkaller]:
      - Not Found?!
      - See patches (v2) above
      - Christoph validated the v1, validation of the v2 is coming


    Bugs (opened, flagged as "bug" and assigned)

  368  selftests: skip tests not being supported by older kernels [bug]
[selftests] @matttbe:
      - see patches above


    Bugs (opened and flagged as "bug" and not assigned)

  404  syzkaller: divide error in `__tcp_select_window` [bug] [syzkaller]:
      - see patches above, assigned to Paolo

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
      - See patches above

  340  netlink: switch to YAML Netlink specs [enhancement] @dcaratti
      - See patches above

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] [sched] @geliangtang
      - See patches above

   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

  381  Why does total throughput increase when the delay on one of the
paths increases? [question] @matttbe


    Open questions (opened, questions and not assigned)

  395  If MPTCP primary flow is over tun interface, no subflow gets
created [question]
  392  Problem attempting to use all my interfaces (subflows)  [question]


    For later (opened and not assigned assigned)

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


    Recently closed (since 2023-05-23)

  402  syzkaller: BUG: KCSAN: data-race in `__mptcp_nmpc_socket` /
`mptcp_stream_accept` [bug] [syzkaller]
  401  syzkaller: BUG: KCSAN: data-race in `mptcp_check_for_eof` /
`mptcp_poll` [bug] [syzkaller]
  388  sockopt: `MPTCP_TCPINFO` and `MPTCP_SUBFLOW_ADDRS`: add a unique
ID [enhancement] @pabeni
  385  ` MPTCP_INFO`: get metrics about sent/received bytes, etc. for
the MPTCP connections [enhancement] @pabeni
  329  PM: userspace: update `MPTCP_INFO` fields [bug] [pm] @geliangtang
  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.5):
https://github.com/orgs/multipath-tcp/projects/3/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [049c34bf3106] selftests: mptcp: join: avoid using 'cmp
--bytes' (Matthieu Baerts)
        - [dc46d8bbcbd0] selftests: mptcp: connect: skip if MPTCP is not
supported (Matthieu Baerts)
        - [bbfa1d787984] selftests: mptcp: pm nl: skip if MPTCP is not
supported (Matthieu Baerts)
        - [4cb0ab9c7301] selftests: mptcp: join: skip if MPTCP is not
supported (Matthieu Baerts)
        - [eb2ef3dfe0a1] selftests: mptcp: diag: skip if MPTCP is not
supported (Matthieu Baerts)
        - [8e9eb0c50601] selftests: mptcp: simult flows: skip if MPTCP
is not supported (Matthieu Baerts)
        - [654d18564b49] selftests: mptcp: sockopt: skip if MPTCP is not
supported (Matthieu Baerts)
        - [3b0a67b759c4] selftests: mptcp: userspace pm: skip if MPTCP
is not supported (Matthieu Baerts):
            - Have been applied a few hours ago, not sync yet

        - [cac87b222f5f] mptcp: fix connect timeout handling (Paolo Abeni)
        - [cef483c0aa9e] mptcp: add annotations around msk->subflow
accesses (Paolo Abeni)
        - [e52ccd422513] mptcp: consolidate passive msk socket
initialization (Paolo Abeni)
        - [d141673331e1] mptcp: fix data race around msk->first access
(Paolo Abeni)
        - [4227edb53977] mptcp: add annotations around sk->sk_shutdown
accesses (Paolo Abeni)
        - [30b72bf0175b] mptcp: fix active subflow finalization (Paolo
Abeni)
        - [9ca76d9fedb6] mptcp: only send RM_ADDR in nl_cmd_remove
(Geliang Tang)
        - [a0d37625e42d] selftests: mptcp: update userspace pm addr
tests (Geliang Tang)
        - [c00725165575] mptcp: add address into userspace pm list
(Geliang Tang)
        - [8467eeff69da] selftests: mptcp: update userspace pm subflow
tests (Geliang Tang)
        - [b77c9749e92a] mptcp: update userspace pm infos (Geliang Tang):
            - syzkaller seems happy, all these patches can be sent
            - can be sent in 2 different series: Mat will do that

    - Fixes for net-next: /

    - Features for net-next:

        - [c7740ced75e3] mptcp: move snd_una update earlier for fallback
socket (Paolo Abeni)
        - [182d2a98c6f1] mptcp: track some aggregate data counters
(Paolo Abeni)
        - [65b4d7cdf329] selftests: mptcp: explicitly tests aggregate
counters (Paolo Abeni)
        - [e06cf96ffa3f] mptcp: add subflow unique id (Paolo Abeni)
        - [20b1483d572e] mptcp: introduce MPTCP_FULL_INFO getsockopt
(Paolo Abeni)
        - [7eb274a52ba9] selftests: mptcp: add MPTCP_FULL_INFO testcase
(Paolo Abeni):
            - have been applied recently, best to wait
            - also best to wait to get some feedback from the person who
opened the ticket to see if there is any issue with the new getsockopt
and fields from MPTCP_INFO

    - Features for net-next (next): /

    - Features for other trees:

        - [d0a544994231] security, lsm: Introduce
security_mptcp_add_subflow() (Paolo Abeni)
        - [861b5e2b19a5] selinux: Implement mptcp_add_subflow hook
(Paolo Abeni):
            - Applied in SELinux tree

        - [27c721d05183] mptcp: refactor push_pending logic (Geliang Tang)
        - [d0cf36cd6b6f] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [11ac0f166261] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [85dfab7ffed1] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [14883db1e397] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [68cc2de5a2cd] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [fe7d0e8bc044] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [024db78c7115] mptcp: add scheduler wrappers (Geliang Tang)
        - [e12ca0391160] mptcp: use get_send wrapper (Geliang Tang)
        - [20110fc46389] mptcp: use get_retrans wrapper (Geliang Tang)
        - [73ae0d2c4072] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [0c1aa53923af] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [31f65005b845] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [e081e169f0b2] selftests/bpf: use random netns name for mptcp
(Geliang Tang)
        - [301dc3496996] selftests/bpf: add two mptcp netns helpers
(Geliang Tang)
        - [d1e137d4e89f] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [de306d69865b] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [e04ae25641d4] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [f457d1560ecb] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [2c7d44153892] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [6bbc9fa016a3] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [f40c3940881b] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [cbbe8320a7ee] selftests/bpf: Add bpf_red test (Geliang Tang):
            - Status: same as last week (waiting for the modif in the
sched API)


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
        - instabilities with unknown root cause (since switch to v6.4-rc1)



Next meeting:
    - Next one on Tuesday, the 6th of June.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230606



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
