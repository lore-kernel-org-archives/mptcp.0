Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788911C01
	for <mptcp@lists.linux.dev>; Tue,  2 May 2023 17:38:23 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-50be0d835aaso153535a12.3
        for <mptcp@lists.linux.dev>; Tue, 02 May 2023 10:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1683049101; x=1685641101;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/QZ3q/i5XLd+tVwCy+zGblyxV7UlRzFUldDqxDzjcw=;
        b=XDhJeoqmXV//kdmnC7XHR4VGLQcNA5ZuWqveV2x906D8KWQctpe2ByF56Hu8Ish+3s
         VkgzQ25vPxy4PzqrivZRlLgmLd5Iy3olqB6PZAI0fu9cq7WH9jcLmXWhHcZyaEGcG7zi
         4/TxDee7UZW/EzrG8RPBtBLNOwmNtme6FcsPopcHkvshbGi6Y1ke6J0kl+3pfrdaeYpF
         QgMkSsuVNApsSOjSNQvyvRhEsThMLVc10NuNnMBLbJreIwP2Ow7LlEgJXBnXSi3tEExx
         56rztlP3LqSyqAbueFElQyRC+vmoBfYGIgepCZVrH8CmNWm/Rkz9a9oX5w4zN1utrALt
         7TVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683049101; x=1685641101;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A/QZ3q/i5XLd+tVwCy+zGblyxV7UlRzFUldDqxDzjcw=;
        b=XnvZwydT6+0JIvmHJYwMpsqsf0tzusWPHub3bVcoH0IZEM1UvLMUeA1XHiU7JyRmD7
         GS6bcTB4LjYsGFpNbDVl7AA9+v8LwyFC43WAXZvzyjdaDeAclDl0QBFhwDoQ8xx0lLgZ
         TqtnPYz5Y0K1LCdCzk/jp/YI6p+CCUqnUPG907cPh7o3c0t1O9Hp8lReFT/vTFc7Dtod
         tqrggsWZrY6gyGNk+1XPAxeq8WbF2eA46CeFs2zudZnDMn1pB+pHLRTBkuit16E150uC
         WrYLKvQfFQCJzHy3mL406uq2mzSHsKdbgTCFHvsA8nux9ThieWVmbkK4GIV2uy0fd8+i
         nw+w==
X-Gm-Message-State: AC+VfDw7jcj74ZMsgDfdXIDCwnXNbWod3xLSx32l47EjRPoz70Vk8AQ1
	rV1szA01ky3JoSOVOhU9WoUS/rPP0eXtcUNdYwM=
X-Google-Smtp-Source: ACHHUZ5LwK8WHk0s6zxWKKk1AiuifmNZ/V0mfQ7221KqutHXKXiSaI3fOQESfYav76669edXUGPT+A==
X-Received: by 2002:a05:6402:44a:b0:504:b511:1a39 with SMTP id p10-20020a056402044a00b00504b5111a39mr8779341edw.12.1683049100868;
        Tue, 02 May 2023 10:38:20 -0700 (PDT)
Received: from [10.44.2.5] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id i18-20020aa7c9d2000000b0050bd245d39esm904325edt.6.2023.05.02.10.38.20
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 10:38:20 -0700 (PDT)
Message-ID: <38db136f-417b-3c0c-2802-57356b405b26@tessares.net>
Date: Tue, 2 May 2023 19:38:20 +0200
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
Subject: [Weekly meetings] MoM - 2nd of May 2023
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Today, we just had our 240th meeting with Christoph (Apple), Paolo,
Davide (Red Hat), Mat (Cruise) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:


Accepted patches:


    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

13222236: [6.1,1/2] mptcp: stops worker on unaccepted sockets at
listener close
13222237: [6.1,2/2] mptcp: fix accept vs worker race:
      - Series: mptcp: Stable backports for v6.1.26
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=742759&state=*&archive=both
      - backports that got conflicts

13226162: [5.15] selftests: mptcp: join: fix "invalid address, ADD_ADDR
timeout":
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230428-upstream-stable-20230428-mptcp-addaddrdropmib-v1-1-51bca8b26c22@tessares.net/
      - specific patch for v5.15, for the selftests


    our repo (by: /):

/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13219019: [LSM,v2,1/2] security, lsm: Introduce security_mptcp_add_subflow()
13219020: [LSM,v2,2/2] selinux: Implement mptcp_add_subflow hook:
      - Series: security: SELinux/LSM label with MPTCP and accept
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=741812&state=*&archive=both
      - need to wait for after the merge window.


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
      - status: same as last week
      - new version is in preparation, fixing the different reported issues

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
      - State: Changes requested
      - Series: selftests: mptcp: skip tests when features are not supported
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=738029&state=*&archive=both

13208676: [mptcp-net,v3,1/2] selftests: mptcp: join: avoid using 'cmp
--bytes':
    - Mat did a review
    - TODO: apply

13211590: [v2,mptcp-next,1/3] mptcp: introduces more address related mibs
13211588: [v2,mptcp-next,2/3] selftests: mptcp: add explicit check for
new mibs
13211589: [v2,mptcp-next,3/3] selftests: mptcp: centralize stats dumping:
      - State: Changes requested
      - Series: mptcp: add more mibs
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=739876&state=*&archive=both
      - Can be applied as it is (without the typos maybe):
          - we cannot rename the existing counters (somehow part of the
uAPI)
          - Matth can do the suggested modifications after
          - TODO: apply

13224265: [mptcp-next,v10,1/6] mptcp: only send RM_ADDR in nl_cmd_remove
13224266: [mptcp-next,v10,2/6] selftests: mptcp: update userspace pm
addr tests
13224267: [mptcp-next,v10,3/6] mptcp: add addr into userspace pm list
13224268: [mptcp-next,v10,4/6] mptcp: export remove_anno_list_by_saddr
13224269: [mptcp-next,v10,5/6] mptcp: add addr into pm anno_list
13224270: [mptcp-next,v10,6/6] selftests: mptcp: update userspace pm
subflow tests:
      - State: New
      - Series: update userspace pm mptcp_info fields, pt 1
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=743269&state=*&archive=both
      - Matth will review the v10





Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 395):

  397  Doc and guidance for users [enhancement] [documentation]:
      - linked to a discussion we had last week: doc for "end users"
      - we can also modify mptcpd, e.g. mptcpize to check the paths, etc.:
          - check the different endpoints and check if the routes are
OK: ip route get <ip> from <iface>
          - check if we get an ADD_ADDR by just opening a new connection
(to have more subflows established, we need to get data)
          - TODO: put on the ticket → done

  396  ci: periodically run selftests from the export branch on stable
kernels [enhancement] [selftests]:
      - linked to a discussion we had last week: check there is no
regressions with the new selftests


    Bugs (opened, flagged as "bug" and assigned)

  373  checkpatch: `Closes` tag is no longer accepted [bug] @matttbe:
      - should be closed automatically when net/net-next will sync with
Linus' tree

  368  selftests: skip tests not being supported by older kernels [bug]
[selftests] @matttbe:
      - see patches above

  329  PM: userspace: update `MPTCP_INFO` fields [bug] [pm] @geliangtang:
      - see patches above

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni:
      - see patches in our tree


    Bugs (opened and flagged as "bug" and not assigned)

  391  PM: userspace: unable to create additional subflows with the
local addr ID 0 [bug]
  384  syzkaller: KCSAN: data-race in `tcp_update_metrics` /
`tcp_update_metrics` [bug] [syzkaller] [reproducer]
  379  userspace pm: ability to send `RM_ADDR` for all local IDs used (0
included) [bug] [pm]
  378  Very noisy `addr_signal error` [bug]
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

  388  sockopt: `MPTCP_TCPINFO`: add a unique ID [enhancement]:
      - might be easier to add a new sockopt but we might not want to
have plenty sockopt each time we need to change something
      - maybe OK to have a new sockopt with both TCP_INFO and ADDR + ID?
(ID is optional then)
      - BPF maybe?
      - getsockopt:
          - add two new fields in mptcp_subflow_data: size for the
kernel and userspace to be able to add more stuff per subflow, e.g. ID,
status from MPTCP point of view, even addresses, etc.
            __u32           size_2_kernel;
            __u32           size_2_user;

  385  ` MPTCP_INFO`: get metrics about sent/received bytes, etc. for
the MPTCP connections [enhancement]:
      - these two tickets seem needed for "real use-cases"

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


    Recently closed (since 2023-04-25)

  376  KASAN: slab-use-after-free Read in `ip_mc_drop_socket` [bug]
[syzkaller]




FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.5):
https://github.com/orgs/multipath-tcp/projects/3/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1



Patches to send to netdev:
    - net-next is closed



Extra tests:
    - news about Syzkaller? (Christoph):
        - closing old issues not happening anymore

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - /



Next meeting:
    - /!\ We will skip the next one (9th of May!)
    - Next one on Tuesday, the 16th of May.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230516



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
