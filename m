Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C768492
	for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 13:22:09 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id q5so1214684wmo.4
        for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 06:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681996927; x=1684588927;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEg1OIj/EdEQYiirLnH1jQZ98xhL6xjbd+ZEJ4ljluI=;
        b=vgR/aVEicrXv52z3bR+t6Ui3mTmr9JFYjOKMnLHNxLfNvR4I8/qVRCzVDDdrmli/SD
         VIv1Z5+JBbf2ryyNtHwYkUQyFzn30zZ00p3cMhFdCtsMGpeWnkNdDY7ttjYNKEMRyaph
         9hmlCyiZTWOzqAMyVx5Lx80vWJvQf7YWNMkDKy37WYikR1NNVoZ9zq8nT9vZHs7qhWcR
         5f1NVNg/p0iAo6PSDq6zra8CCebRmRCik4q2FfbXHwoWo8ury5/korC5GE6qfQD+ylb2
         2B3UNJYC212WGS0c9N8cWi2X7hJO0gF0fvhmhdfjD/4/pHno3y6xTqZnIaf5WFhTec2+
         MpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681996927; x=1684588927;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IEg1OIj/EdEQYiirLnH1jQZ98xhL6xjbd+ZEJ4ljluI=;
        b=Dccz38rW0N//9UP3wJHrKdLRVbOiryWGX1e6ZB97Q3vrJn5HIFJG8VW10n3tyDWK5i
         StvPkKOBl6n+OxSzT89CqoAAfJM84957416y+gu6O069br7AbSBAxqy1GH4skHdOqN8N
         8IEvBlMfKwIU0KCH3qp1wHn6iJS/ccFjhvWOTBjAjVRbagNxelkjvGIf46o8fvw5b3cH
         wZgmp2ppvdo6maZc5LiA58ab5cPfGjowD/3PY9TpgL3/Ghdw1TkW++5wCN6fwVs/2lRU
         WGQH/8RH7+epIaSjLHOEvqpm9W9gF3/VgWReyn29p8nLua0UfjIihSwFXbVkh1rD9AfI
         IkQA==
X-Gm-Message-State: AAQBX9cLuCIPBzuk1xvQbk20Kb1JfHFHpQEjS00/wV3j5Em3UiqZsYza
	3RyGU3GzL9O6En7DswzX665yYeUZR00a6pJXlZy4ZDX4
X-Google-Smtp-Source: AKy350ZWf0EGJ/Dgzjh5BRsvqYiWDH3mX0hAzgfpA5BSEo9W8si1MKTLt8a/bYZS1sdvidMqvffJYg==
X-Received: by 2002:a7b:cbc1:0:b0:3f0:8ed8:853c with SMTP id n1-20020a7bcbc1000000b003f08ed8853cmr1287034wmi.37.1681996927019;
        Thu, 20 Apr 2023 06:22:07 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:4d8f:e9b5:dea0:5307? ([2a02:578:8593:1200:4d8f:e9b5:dea0:5307])
        by smtp.gmail.com with ESMTPSA id n20-20020a7bc5d4000000b003f17b96793dsm5326947wmk.37.2023.04.20.06.22.06
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 06:22:06 -0700 (PDT)
Message-ID: <86560282-addd-d93f-92e7-775b9e1ed1ed@tessares.net>
Date: Thu, 20 Apr 2023 15:22:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 18th of April 2023
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Tuesday, we had our 238th meeting with Christoph (Apple), Paolo,
Davide (Red Hat), Mat (Cruise), Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13211554: [net-next,1/5] mptcp: drop unneeded argument
13211553: [net-next,2/5] mptcp: avoid unneeded __mptcp_nmpc_socket() usage
13211555: [net-next,3/5] mptcp: move fastopen subflow check inside
mptcp_sendmsg_fastopen()
13211556: [net-next,4/5] mptcp: move first subflow allocation at mpc
access time
13211557: [net-next,5/5] mptcp: fastclose msk when cleaning unaccepted
sockets:
      - Series: mptcp: refactor first subflow init
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=739870&state=*&archive=both

13211725: [net-next,1/5] mptcp: make userspace_pm_append_new_local_addr
static
13211727: [net-next,2/5] MAINTAINERS: add git trees for MPTCP
13211728: [net-next,3/5] mptcp: remove unused 'remaining' variable
13211729: [net-next,4/5] selftests: mptcp: remove duplicated entries in
usage
13211730: [net-next,5/5] selftests: mptcp: join: fix ShellCheck warnings:
      - Series: mptcp: various small cleanups
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=739908&state=*&archive=both

13208246: [net,1/4] mptcp: use mptcp_schedule_work instead of open-coding it
13208247: [net,2/4] mptcp: stricter state check in mptcp_worker
13208248: [net,3/4] mptcp: fix NULL pointer dereference on fastopen
early fallback
13208249: [net,4/4] selftests: mptcp: userspace pm: uniform verify events:
      - Series: mptcp: more fixes for 6.3
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=738930&state=*&archive=both


    our repo (by: Matthieu Baerts, Paolo Abeni):

13208345: [mptcp-net] Squash-to: "mptcp: fix accept vs worker race":
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/484c6fbff67a4587215d88e17f3a6688eb2c9ea1.1681256534.git.pabeni@redhat.com/

13208677: [mptcp-net,v3,2/2] selftests: mptcp: join: fix ShellCheck
warnings:
      - Series: mptcp: selftests: join: support BusyBox and ShellCheck
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=739066&state=*&archive=both

13209207: [v2,mptcp-net] Squash-to: "mptcp: fix accept vs worker race":
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/835d24d74d7381f79e994b20d84002ec1b953da8.1681306366.git.pabeni@redhat.com/

13211167: [mptcp-next,1/2] mptcp: bpf: Invoke btf_struct_access()
callback only for writes
13211168: [mptcp-next,2/2] mptcp: bpf: Remove unused arguments from
btf_struct_access():
      - Series: mptcp: bpf: fix compilation errors
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=739779&state=*&archive=both

13214011: [mptcp-next] Squash to "mptcp: fix accept vs worker race":
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230417134134.1636540-1-matthieu.baerts@tessares.net/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts, Pablo Neira Ayuso):

13203043: [net,v2] uapi: linux: restore IPPROTO_MAX to 256 and add
IPPROTO_UAPI_MAX:
      - Submitter: Pablo Neira Ayuso
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230406092558.459491-1-pablo@netfilter.org/
      - IPPROTO_MAX should not be used to limit the protocol version
used when doing a syscall
      - (it should not be used to see the max value the protocol value
in the header should be but OK...)
      - v2 is OK but v3 is expected with another name for the variable
and detail about the comments
      - we can archive it

13214100: [net,1/2] mptcp: stops worker on unaccepted sockets at
listener close
13214101: [net,2/2] mptcp: fix accept vs worker race:
      - Series: mptcp: fixes around listening sockets and the MPTCP worker
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=740536&state=*&archive=both
      - should unblock the 2 last patches queued for net-next, see below

13215234: [net] mailmap: add entries for Mat Martineau:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230418-upstream-net-20230418-mailmap-mat-v1-1-13ca5dc83037@tessares.net/


    our repo (by: Davide Caratti, Geliang Tang, Matthieu Baerts, Paolo
Abeni):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
    - Status unchanged

13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
      - State: Changes requested
      - Series: BPF redundant scheduler, part 3
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
      - Status unchanged

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
      - Possible to remove the "unspec" declaration:
          - UNSPEC is being deprecated so we can remove their
declaration and start from ID 1
       - cmd to send ADD_ADDR/RM_ADDR + subflow creation/deletion:
           - no replies are sent
           - except in case of errors

13205072: [mptcp-net,01/13] selftests: mptcp: connect: skip if MPTCP is
not supported
13205073: [mptcp-net,02/13] selftests: mptcp: pm nl: skip if MPTCP is
not supported
13205074: [mptcp-net,03/13] selftests: mptcp: join: skip if MPTCP is not
supported
13205075: [mptcp-net,04/13] selftests: mptcp: diag: skip if MPTCP is not
supported
13205076: [mptcp-net,05/13] selftests: mptcp: simult flows: skip if
MPTCP is not supported
13205077: [mptcp-net,06/13] selftests: mptcp: sockopt: skip if MPTCP is
not supported
13205078: [mptcp-net,07/13] selftests: mptcp: userspace pm: skip if
MPTCP is not supported
13205079: [mptcp-net,08/13] selftests: mptcp: lib: skip if missing symbol
13205080: [mptcp-net,09/13] selftests: mptcp: connect: skip TFO tests if
not supported
13205081: [mptcp-net,10/13] selftests: mptcp: userspace pm: skip if 'ip'
tool is unavailable
13205082: [mptcp-net,11/13] selftests: mptcp: userspace pm: skip if not
supported
13205084: [mptcp-net,12/13] selftests: mptcp: userspace pm: skip PM
listener events tests if unavailable
13205083: [mptcp-net,13/13] selftests: mptcp: join: skip PM listener
events tests if unavailable:
      - State: Needs ack
      - Series: selftests: mptcp: skip tests when features are not supported
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=738029&state=*&archive=both

13208676: [mptcp-net,v3,1/2] selftests: mptcp: join: avoid using 'cmp
--bytes'
13211134: [mptcp-next,v7,1/7] mptcp: pass addr to mptcp_pm_alloc_anno_list
13211135: [mptcp-next,v7,2/7] mptcp: only remove addrs in nl_cmd_remove
13211136: [mptcp-next,v7,3/7] mptcp: don't clear userspace pm addr id
13211137: [mptcp-next,v7,4/7] mptcp: add addr into userspace pm list
13211138: [mptcp-next,v7,5/7] mptcp: increase userspace pm add_addr_signaled
13211139: [mptcp-next,v7,6/7] mptcp: update userspace pm subflows
13211140: [mptcp-next,v7,7/7] selftests: mptcp: check userspace mptcp_info:
      - State: Changes Requested
      - Series: mptcp: update userspace pm mptcp_info fields
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=739772&state=*&archive=both
      - Reviewed done by Matth
      - Found other issues, see ticket #391 for example

13211590: [v2,mptcp-next,1/3] mptcp: introduces more address related mibs
13211588: [v2,mptcp-next,2/3] selftests: mptcp: add explicit check for
new mibs
13211589: [v2,mptcp-next,3/3] selftests: mptcp: centralize stats dumping:
      - State: New
      - Series: mptcp: add more mibs
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=739876&state=*&archive=both
      - Matth will review that



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 386):

  391  PM: userspace: unable to create additional subflows with the
local addr ID 0 [bug]:
      - it looks like there is no reason not to allow that
      - probably we wanted to make sure the info where filled but 0 is a
correct value

  389  packetdrill: increase coverage for "early `close()`" cases
[enhancement] [packetdrill]:
      - linked to a discussion from the last meeting

  388  sockopt: `MPTCP_TCPINFO`: add a unique ID [enhancement]:
      - linked to a discussion from the last meeting and ticket 385

  387  Address family of server side mismatches with that of client side
[bug]:
      - can probably be closed → Done


    Bugs (opened, flagged as "bug" and assigned)

  377  BUG: soft lockup in `ip_rcv` [bug] [syzkaller] [reproducer]
@dcaratti:
      - not related to MPTCP, a patch has been sent
      - *@Davide:* can you close it when you no longer need it please?

  373  checkpatch: `Closes` tag is no longer accepted [bug] @matttbe:
      - patches have been applied in mm-nonmm-stable, waiting for the sync

  329  PM: userspace: update `MPTCP_INFO` fields [bug] [pm] @geliangtang:
      - see patches above

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni:
      - see patches in our tree
      - @Paolo: what to do with these patches? → sent to Paul Moore
      - See:
https://lore.kernel.org/mptcp/7e905b25-2b44-fd15-93a7-2d45f0b18513@tessares.net/


    Bugs (opened and flagged as "bug" and not assigned)

  391  PM: userspace: unable to create additional subflows with the
local addr ID 0 [bug]
  387  Address family of server side mismatches with that of client side
[bug]

  386  syzkaller: WARNING in `__mptcp_destroy_sock` [bug] [syzkaller]
[reproducer]:
      - should be fixed in the export branch
      - Matth: TODO: close it → done

  384  syzkaller: KCSAN: data-race in `tcp_update_metrics` /
`tcp_update_metrics` [bug] [syzkaller] [reproducer]:
      - didn't see it recently, we can wait a bit before closing it

  379  userspace pm: ability to send `RM_ADDR` for all local IDs used (0
included) [bug] [pm]
  378  Very noisy `addr_signal error` [bug]

  376  KASAN: slab-use-after-free Read in `ip_mc_drop_socket` [bug]
[syzkaller]:
      - didn't see it recently, we can wait a bit before closing it

  369  syzkaller: BUG: soft lockup in `inet_release` [bug] [syzkaller]:
      - not reproduced, closed

  368  selftests: skip tests not being supported by older kernels [bug]
[selftests]

  363  syzkaller: BUG: soft lockup in `mptcp_retransmit_timer` [bug]
[syzkaller]:
      - not reproduced, closed

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
      - see patches above

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] [sched] @geliangtang:
       - see patches above

   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

  381  Why does total throughput increase when the delay on one of the
paths increases? [question] @matttbe


    Open questions (opened, questions and not assigned)

/

    For later (opened and not assigned assigned)

  389  packetdrill: increase coverage for "early `close()`" cases
[enhancement] [packetdrill]
  388  sockopt: `MPTCP_TCPINFO`: add a unique ID [enhancement]
  385  ` MPTCP_INFO`: get metrics about sent/received bytes, etc. for
the MPTCP connections [enhancement]
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


    Recently closed (since 2023-04-11)

  390  MPTCP Enviroment Set Up [question] @matttbe
  338  ip mptcp monitor reports: [SF_CLOSED]  error=111
  309  selftests: `mptcp_join`: test 33: `remove addresses` failing
occasionally  [bug] [selftests]




FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.4):
https://github.com/orgs/multipath-tcp/projects/2/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [9e95aeb8cec8] mptcp: stops worker on unaccepted sockets at
listener close (Paolo Abeni)
        - [2e3ec0a2e121] mptcp: fix accept vs worker race (Paolo Abeni):
            - have been sent, waiting to be applied → done

    - Fixes for net-next: /

    - Features for net-next:

        - [ea61ca054069] inet: factor out locked section of
inet_accept() in a new helper (Paolo Abeni)
        - [f4d9cb118160] mptcp: refactor mptcp_stream_accept() (Paolo
Abeni):
            - depending on the fixes for -net that have been sent but
not applied yet
            - TODO: Matth: check at the end of the week if we can send them

    - Features for net-next (next): /

    - Features for other trees:

        - [1763cb15e66b] security, lsm: Introduce
security_mptcp_add_subflow() (Paolo Abeni)
        - [4fb168f2b414] selinux: Implement mptcp_add_subflow hook
(Paolo Abeni):
            - See question there:
https://lore.kernel.org/mptcp/7e905b25-2b44-fd15-93a7-2d45f0b18513@tessares.net/
            - TODO: Matth: send the patches to Paul Moore explaining the
situation: they depend on some patches that are in net-next, is he
interested by reviewing them now and maybe accepting them even if it is
a bit late? → done

        - [d600bb3789d2] mptcp: refactor push_pending logic (Geliang Tang)
        - [48a1d512fcb6] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [15a4f2aee907] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [bc822b98a935] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [461a7431b598] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [6d5fb2a986cc] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [96d3e1f69c2a] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [2a1914d9513b] mptcp: add scheduler wrappers (Geliang Tang)
        - [82f84eebc799] mptcp: use get_send wrapper (Geliang Tang)
        - [984706b14b0b] mptcp: use get_retrans wrapper (Geliang Tang)
        - [5094ca3b7c0f] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [49d11078b039] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [93a4fd26722f] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [0b5c4b53d7e0] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [786b4fafd212] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [c85141913cb5] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [cb3ab6baedc5] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [a5eef1b226e1] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [cfa4416e6a43] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [8000aaf784fa] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [fd7b7b64b6d8] selftests/bpf: Add bpf_red test (Geliang Tang):
            - waiting for the refactoring on the scheduler side



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
        - mostly green, good



GO:
    - part 2 has been accepted and merged
    - https://github.com/golang/go/issues/59166
    - https://go-review.googlesource.com/c/go/+/471140



Maintainer:
    - Mat is back as co-maintainer! \o/
    - Thanks Cruise for allowing that!



Next meeting:
    - Next one on Tuesday, the 25th of April.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230425



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
