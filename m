Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F3529A2
	for <mptcp@lists.linux.dev>; Thu, 13 Apr 2023 10:32:23 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id j11so17364817wrd.2
        for <mptcp@lists.linux.dev>; Thu, 13 Apr 2023 03:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681381941; x=1683973941;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JkSRhhqtl11szXpmspfHlWmIDODprM45LLQdsHCnQw=;
        b=4w/sWkzoAAXaoDk4fJTWMWrMFdwfmXMdE7q7PzBFKcxCiQHY9F4VNOjV2poz/fWBZL
         Z/Rn8fN6LG+OOb7PTjljw+XEQemvq0omg1xa171JLaZ7LsdwOTzNSTVLWQao3KYQ224o
         mlAq5SwsPeo1KFfrVuHqjMBpC8Ni7uV9xEJ+qnwkA/ARik5VrETjzhU5fDkfwRAKmzwp
         aW4pjIqxCVqGbXn3mBTuJqw1bXVOfzpVQdyVSiaYrdBIpDdc0vmnTls7L/9rdXmciuSI
         IX805avdUVbKDsgH8hqy6vnbpsWseGnjHZV6H81azNTNxaP9B6MBrRP0np88IJh5My2K
         4OAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681381941; x=1683973941;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0JkSRhhqtl11szXpmspfHlWmIDODprM45LLQdsHCnQw=;
        b=LuN37q1ioUqFAF4iSSrnFLsxJAihxSeAgU544VuU/6s6htzeP/pC8/c+wFj6jN7DPR
         fvHlSnei0n2uoUT8NAVNX6ZsHQbt8p14YphI5JJ/HYc+TFQFHQKiUlr3BK2RsLi5spFa
         rQAv0vHyb0fgi82sQZXVwL98qPpfftJVZV9SucAKqSkFGvCFsmAR8FHcYgJmu2EjKRGa
         JL2hIvpLcs/gadlyuHr5201fZpGd/WFtOcnMj4fnjDAfroZhjktJNNYmVJVj1xXd2l+i
         oT7cug9ExEyC2PMWsXlbZn7J4+imlm5Zyzpbe+zpx9qAcquUnuEoNyp/4Pv5QoqRG5CW
         dNrw==
X-Gm-Message-State: AAQBX9dyGrvTAc3JONRE2+VE2QR/yDpROfjdA+/0RYZcYw2X4vYB4OLJ
	0h3i1rFcJ8rCohzA2U/6CWcu5pYrUYOQyanT4/c/9w==
X-Google-Smtp-Source: AKy350b30Ptm6SaxauyW7DzPpzVBgyDjR+7WESlRYPvVPS8vPmZL12o3Lb5YONF4lMZTmoZuF9kRbA==
X-Received: by 2002:adf:f205:0:b0:2c5:4ffb:b5d4 with SMTP id p5-20020adff205000000b002c54ffbb5d4mr1062680wro.19.1681381940738;
        Thu, 13 Apr 2023 03:32:20 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:7e3c:a4c8:4fbc:8ec? ([2a02:578:8593:1200:7e3c:a4c8:4fbc:8ec])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d6b09000000b002d97529b3bbsm970776wrw.96.2023.04.13.03.32.20
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 03:32:20 -0700 (PDT)
Message-ID: <55dbada8-1fd1-fba3-34a0-8001fe3ca6a2@tessares.net>
Date: Thu, 13 Apr 2023 12:32:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 11th of April 2023
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Tuesday, we had our 237th meeting with Christoph (Apple), Paolo,
Davide (Red Hat), Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Matthieu Baerts, Paolo Abeni):

13191374: [mptcp-net] selftests: mptcp: userspace pm: uniform verify events:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230328-mptcp-selftests-userspace-sleep-verify-listen-v1-1-2a4adf550084@tessares.net/

13192402: [mptcp-next,1/3] MAINTAINERS: add git trees for MPTCP
13192403: [mptcp-next,2/3] mptcp: remove unused 'remaining' variable
13192404: [mptcp-next,3/3] selftests: mptcp: remove duplicated entries
in usage:
      - Series: mptcp: misc. small cleanups
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=734997&state=*&archive=both

13202636: [mptcp-net,1/2] Squash-to: "mptcp: fix accept vs worker race"
13202635: [mptcp-net,2/2] Squash-to: "mptcp: stops worker on unaccepted
sockets at listener close":
      - Series: mptcp: a couple of fixup
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=737367&state=*&archive=both

13203995: [mptcp-net] Squash-to: "mptcp: fix accept vs worker race":
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/a0b61938d72605d35cd4d988ac533b88f45d7f89.1680810015.git.pabeni@redhat.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Breno Leitao, Matthieu Baerts,
Pablo Neira Ayuso):

13203043: [net,v2] uapi: linux: restore IPPROTO_MAX to 256 and add
IPPROTO_UAPI_MAX:
      - Submitter: Pablo Neira Ayuso
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230406092558.459491-1-pablo@netfilter.org/
      - Should be safe for MPTCP except if this IPPROTO_MAX is used to
limit the protocol number before calling the socket syscall... hard to know
      - code there for 3 years now
      - Maybe best to wait for a reply from Pablo → Done

13203742: [RFC] io_uring: Pass whole sqe to commands:
      - Submitter: Breno Leitao
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230406165705.3161734-1-leitao@debian.org/
      - modifying a bit MPTCP but the modif is similar to what is done
in TCP
      - discussing about the architecture, we can wait
      - TODO: drop from our patchwork → Done


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

13199661: [mptcp-next,1/3] mptcp: introduces more address related mibs
13199662: [mptcp-next,2/3] selftests: mptcp: add explicit check for new mibs
13199663: [mptcp-next,3/3] selftests: mptcp: centralize stats dumping:
      - State: Changes requested
      - Series: mptcp: add more mibs
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=736792&state=*&archive=both
      - new version will come after the fixes ↓

13200567: [mptcp-next,v2,1/2] selftests: mptcp: join: avoid using 'cmp
--bytes'
13200568: [mptcp-next,v2,2/2] selftests: mptcp: join: fix ShellCheck
warnings:
      - State: Under review
      - Series: mptcp: selftests: join: support BusyBox and ShellCheck
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=736884&state=*&archive=both
      - TODO: Matth: remove file in the cleanup step → done

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
      - Reviewed by Paolo and CI seems to have issues with ip tool
      - maybe the first field (called "unspec") can be skipped from the
definition

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
      - State: New
      - Series: selftests: mptcp: skip tests when features are not supported
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=738029&state=*&archive=both
      - Tried to minimise the modifications in the bash scripts
      - a new "lib.sh" file to share code!
      - would be better to check the error returned by syscall etc. but
harder and not always possible
      - To be reviewed



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 382):

  386  syzkaller: WARNING in `__mptcp_destroy_sock` [bug] [syzkaller]:
      - Paolo already has a patch
      - Only a syzkaller repro which is not easy to reproduce
      - new Packetdrill tests needed here:
          - one example:
              - MPC Handshake
              - close MPC + remote close + same on MPJ
              - (to quick, ask Paolo :) )
          - another:
              - response to a SYN+MPC with a RST

  385  ` MPTCP_INFO`: get metrics about sent/received bytes, etc. for
the MPTCP connections [enhancement]:
      - With MPTCP_TCP_INFO, we loose info when a subflow is destroyed
by the kernel
      - We could add and expose counters from the MPTCP connection level
(bytes, etc.):
          - We need such counters first
      - Also, we cannot easily identify the subflow:
          - We should have at least an integer per subflow
          - But then we need to modify the API somehow:
              - maybe let the userspace set a new field in the MPTCP
part and then after we would put for each subflow:
                  - ID
                  - TCP_INFO
          - TODO: create a separated issue for that → done

  384  syzkaller: KCSAN: data-race in `tcp_update_metrics` /
`tcp_update_metrics` [bug] [syzkaller] [reproducer]:
      - maybe an issue with the KCSAN config, Christoph will investigate
      - we keep the ticket open for the moment but we can ignore it
      - TODO: update info → Done

  383  TCP_KEEPIDLE, TCP_KEEPINTVL, TCP_KEEPCNT are not implemented in
mptcp_setsockopt_sol_tcp [enhancement]:
      - indeed, they need to be implemented
      - might be easier to do that after #353:
          - https://github.com/multipath-tcp/mptcp_net-next/issues/353


    Bugs (opened, flagged as "bug" and assigned)

  377  BUG: soft lockup in `ip_rcv` [bug] [syzkaller] [reproducer]
@dcaratti:

  373  checkpatch: `Closes` tag is no longer accepted [bug] @matttbe:
      - patches have been applied
      - TODO: add info on ticket → done

  329  PM: userspace: update `MPTCP_INFO` fields [bug] [pm] @geliangtang:
      - see patches above

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni:
      - see patches in our tree


    Bugs (opened and flagged as "bug" and not assigned)

  386  syzkaller: WARNING in `__mptcp_destroy_sock` [bug] [syzkaller]
  384  syzkaller: KCSAN: data-race in `tcp_update_metrics` /
`tcp_update_metrics` [bug] [syzkaller] [reproducer]
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
       - see patches above and in our tree

   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

  381  Why does total throughput increase when the delay on one of the
paths increases? [question] @matttbe


    Open questions (opened, questions and not assigned)

/

    For later (opened and not assigned assigned)

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


    Recently closed (since 2023-04-04)

  382  Question: Different path manager rules for different MPTCP
connections [question] @matttbe
  371  syzkaller: WARNING in `inet_csk_listen_stop` [bug] [syzkaller]
[reproducer] [bisected]
  360  syzkaller: INFO: rcu detected stall in `mptcp_pm_add_timer` [bug]
[syzkaller]
  326  Issue with streaming traffic with MPTCP upstream implementation
[question]
  307  TCP performance better than MPTCP [question] @matttbe



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.4):
https://github.com/orgs/multipath-tcp/projects/2/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [880846e9297c] mptcp: use mptcp_schedule_work instead of
open-coding it (Paolo Abeni)
        - [615e7f35ade5] mptcp: stricter state check in mptcp_worker
(Paolo Abeni):
            - can be sent

        - [bbea5a635ed0] mptcp: stops worker on unaccepted sockets at
listener close (Paolo Abeni)
        - [99c0c0da764b] mptcp: fix accept vs worker race (Paolo Abeni):
            - see issues #386

        - [5f5d9cb21394] mptcp: fix NULL pointer dereference on fastopen
early fallback (Paolo Abeni)
        - [72e403a935bc] selftests: mptcp: userspace pm: uniform verify
events (Matthieu Baerts):
            - could be sent

    - Fixes for net-next: /

    - Features for net-next:

        - [bc0fcdceb0dc] mptcp: drop unneeded argument (Paolo Abeni)
        - [c81e061480c4] mptcp: avoid unneeded __mptcp_nmpc_socket()
usage (Paolo Abeni)
        - [fc6b29fa011e] mptcp: move fastopen subflow check inside
mptcp_sendmsg_fastopen() (Paolo Abeni)
        - [be43f29f9a2f] mptcp: move first subflow allocation at mpc
access time (Paolo Abeni)
        - [e2fcee6ed347] mptcp: fastclose msk when cleaning unaccepted
sockets (Paolo Abeni):
            - check if they depends on the ones above ↑

        - [89918a340663] inet: factor out locked section of
inet_accept() in a new helper (Paolo Abeni)
        - [e0ef8854a112] mptcp: refactor mptcp_stream_accept() (Paolo
Abeni):
            - depends "mptcp: fix accept vs worker race"

        - [6af4fa73a45b] mptcp: make userspace_pm_append_new_local_addr
static (Geliang Tang)
        - [9f62bb6e3463] MAINTAINERS: add git trees for MPTCP (Matthieu
Baerts)
        - [6c7fab5bc242] mptcp: remove unused 'remaining' variable
(Matthieu Baerts)
        - [49331059cfbf] selftests: mptcp: remove duplicated entries in
usage (Matthieu Baerts):
            - can be sent in //

    - Features for net-next (next): /

    - Features for other trees:

        - [f30f2ba5e69b] security, lsm: Introduce
security_mptcp_add_subflow() (Paolo Abeni)
        - [190726638549] selinux: Implement mptcp_add_subflow hook
(Paolo Abeni):
            - wait for the next window

        - [870f98132854] mptcp: refactor push_pending logic (Geliang Tang)
        - [946b775f52e1] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [b32eb08a3ba2] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [ab020c687f64] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [311cca1136d7] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [d05b8cd17a2a] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [42aadc44dc7f] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [d84575e91967] mptcp: add scheduler wrappers (Geliang Tang)
        - [70cf569f5943] mptcp: use get_send wrapper (Geliang Tang)
        - [4919f8048e7b] mptcp: use get_retrans wrapper (Geliang Tang)
        - [3fbdff98063c] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [6cf718b041fd] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [bedfd80a0c1e] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [e7512d570b43] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [c6d2a94b0574] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [95bbccd3ef47] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [d339cbe13f1a] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [7a28f0b4817b] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [ebf7a210349e] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [aef199e86c93] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [a694d6086a9e] selftests/bpf: Add bpf_red test (Geliang Tang):
            - Status: same as last week: depends on Sched API refactoring



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
        - still mostly green
        - scripts in mptcp selftests dir without the exec rights are no
longer executed (good for the new lib.sh file)



Next meeting:
    - Next one on Tuesday, the 18th of April.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230418



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
