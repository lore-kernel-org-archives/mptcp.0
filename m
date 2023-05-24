Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916F61951F
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 16:06:09 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3f6094cb2ebso9609365e9.3
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 09:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684944367; x=1687536367;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s81DMLYJsqsl5EWwITHPPqQ/+up+pWmXcdNxdZQokAU=;
        b=oQJvnre8ZW8LI8RSWiU+JLsVkLFlCIkaVx1ZVWqWyTO/P/Fr5kGYhYIpmLhK7bK+BI
         nn6Pc1XU+qrWqcO/GhCAjCIF+bCNtutzSKBTPmmgUVLSE+DA0930DoFt0obEsPqscxM6
         yIolYTc5xyfunkuAFXZHhBmfXUJ4J+N6PVCvYZfd8CLFGFJvj8Qm3gbuAYjhJyHkBgYL
         VQa9Q/661KfjrxiS/1y3GRLpZKmEw2aAhfv1TjAXMdBu9NrePDBgfy1VEQqlZk7nLtA1
         2DqcJd/YJse7A6dox6gaNGOcHAkWTt+mZfr9bxcV1F6RRVDixqAQyufeyEGFeLWEuFxO
         NNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684944367; x=1687536367;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s81DMLYJsqsl5EWwITHPPqQ/+up+pWmXcdNxdZQokAU=;
        b=V8gugL7Xp94f1dJMXKBFy+IaKLKuGUl3Uv8njMv/Q/eroMM5zrZ5zPIYumIqAP62oW
         /xnBCXpR/ZO4wO4FjbdwbynKqTWD1lUB2EOWSq/AKQ+PGeAWVM3uhahsR2Qo1uGE1dpH
         j57N2uH3zcrVSjbH9HJFZTdOrN/FoOjxHCbujYQC17obBs32Bkkagbp5lxDny0E+HLeg
         YcoYfFUBZ9dVpHbVVmBORY70GzZVpDSlPem4fHMXO+vk3hbI1IQDCcs/B0xjNc6fdon6
         rpFjI9FDDMN3txSFMq8OWTNDgIwVgnhqkms9eM3fN3c3oMNkR1kpSn9cGYWUeLcIcjIZ
         LrYQ==
X-Gm-Message-State: AC+VfDwKUJTjBZ/weVZArh/1avnflhKN1JuKNO8qweQoCuz6nJqe34i7
	CsmwrGmpHXm4CeTR/6580ZKyqp73kmBswuW1r49Mnw==
X-Google-Smtp-Source: ACHHUZ7Wyti6mBRtZOBsYHNLiDAp4VcIyCSxBpMzPDU2xhAuiVWhDrg/hTM/leY0VfF04f7/fWy8pw==
X-Received: by 2002:a1c:7207:0:b0:3f1:92aa:4eb8 with SMTP id n7-20020a1c7207000000b003f192aa4eb8mr233583wmc.16.1684944366840;
        Wed, 24 May 2023 09:06:06 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f96c:b035:8e06:9e3c? ([2a02:578:8593:1200:f96c:b035:8e06:9e3c])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c021800b003f080b2f9f4sm2748285wmi.27.2023.05.24.09.06.06
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 09:06:06 -0700 (PDT)
Message-ID: <52cff022-1175-e817-b562-167516744a1d@tessares.net>
Date: Wed, 24 May 2023 18:06:05 +0200
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
Subject: [Weekly meetings] MoM - 23rd of May 2023
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Today, we just had our 242nd meeting with Christoph (Apple), Paolo (Red
Hat), Mat (Cruise), Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:


Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau, Matthieu Baerts):

13219019: [LSM,v2,1/2] security, lsm: Introduce security_mptcp_add_subflow()
13219020: [LSM,v2,2/2] selinux: Implement mptcp_add_subflow hook:
      - Series: security: SELinux/LSM label with MPTCP and accept
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=741812&state=*&archive=both

13245577: [net-next,1/5] inet: factor out locked section of
inet_accept() in a new helper
13245578: [net-next,2/5] mptcp: refactor mptcp_stream_accept()
13245579: [net-next,3/5] mptcp: introduces more address related mibs
13245581: [net-next,4/5] selftests: mptcp: add explicit check for new mibs
13245580: [net-next,5/5] selftests: mptcp: centralize stats dumping:
      - Series: mptcp: Refactor inet_accept() and MIB updates
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=748618&state=*&archive=both


    our repo (by: Geliang Tang, Matthieu Baerts):

13245813: [mptcp-next,v4,1/6] selftests/bpf: use random netns name for mptcp
13245815: [mptcp-next,v4,2/6] selftests/bpf: add two mptcp netns helpers
13245814: [mptcp-next,v4,3/6] Squash to "selftests/bpf: Add bpf_first test"
13245816: [mptcp-next,v4,4/6] Squash to "selftests/bpf: Add bpf_bkup test"
13245817: [mptcp-next,v4,5/6] Squash to "selftests/bpf: Add bpf_rr test"
13245818: [mptcp-next,v4,6/6] Squash to "selftests/bpf: Add bpf_red test":
      - Series: run sched tests in a dedicated ns
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=748677&state=*&archive=both

13250838: [mptcp-net,v2,01/37] selftests: mptcp: connect: skip if MPTCP
is not supported
13250839: [mptcp-net,v2,02/37] selftests: mptcp: pm nl: skip if MPTCP is
not supported
13250840: [mptcp-net,v2,03/37] selftests: mptcp: join: skip if MPTCP is
not supported
13250842: [mptcp-net,v2,04/37] selftests: mptcp: diag: skip if MPTCP is
not supported
13250841: [mptcp-net,v2,05/37] selftests: mptcp: simult flows: skip if
MPTCP is not supported
13250843: [mptcp-net,v2,06/37] selftests: mptcp: sockopt: skip if MPTCP
is not supported
13250844: [mptcp-net,v2,07/37] selftests: mptcp: userspace pm: skip if
MPTCP is not supported
      - Series: selftests: mptcp: skip tests when features are not supported
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=749868&state=*&archive=both


Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Breno Leitao):

13250638: [v2] net: ioctl: Use kernel memory on protocol ioctl callbacks:
      - Submitter: Breno Leitao
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230522134735.2810070-1-leitao@debian.org/
      - not directly linked to MPTCP but touching MPTCP code
      - similar modifications are done in TCP code too


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

13240605: [mptcp-next,v13,1/7] mptcp: update userspace pm infos
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
      - Status is the same as last week: blocked by part 1

13247106: [v2,mptcp-net,1/5] mptcp: add annotations around msk->subflow
accesses
13247107: [v2,mptcp-net,2/5] mptcp: consolidate passive msk socket
initialization
13247109: [v2,mptcp-net,3/5] mptcp: fix data race around msk->first access
13247110: [v2,mptcp-net,4/5] mptcp: add annotations around
sk->sk_shutdown accesses
13247111: [v2,mptcp-net,5/5] mptcp: fix active subflow finalization.:
      - State: New
      - Series: mptcp: a bunch of data race fixes
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=748987&state=*&archive=both
      - Mat will have a look → Done

13250524: [mptcp-next,v14,1/5] mptcp: only send RM_ADDR in nl_cmd_remove
13250525: [mptcp-next,v14,2/5] selftests: mptcp: update userspace pm
addr tests
13250526: [mptcp-next,v14,3/5] mptcp: export remove_anno_list_by_saddr
13250527: [mptcp-next,v14,4/5] mptcp: add address into userspace pm list
13250528: [mptcp-next,v14,5/5] selftests: mptcp: update userspace pm
subflow tests:
      - State: Changes requested
      - Series: update userspace pm mptcp_info fields part 1
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=749775&state=*&archive=both
      - it looks like there is no need to send a RM_ADDR after having
closed a subflow
      - this should simplify the code and the interactions between the
userspace and the kernelspace

13250668: [mptcp-next,v2,1/6] mptcp: add subflow unique id
13250669: [mptcp-next,v2,2/6] mptcp: introduce MPTCP_FULL_INFO getsockopt
13250673: [mptcp-next,v2,3/6] mptcp: move snd_una update earlier for
fallback socket.
13250670: [mptcp-next,v2,4/6] mptcp: track some aggregate data counters.
13250671: [mptcp-next,v2,5/6] selftests: mptcp: explicitly tests
aggregate counters
13250672: [mptcp-next,v2,6/6] selftests: mptcp: add MPTCP_FULL_INFO
testcase:
      - State: Under review
      - Series: mptcp: add some more diag info
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=749798&state=*&archive=both
      - Matth is looking at it, remaining patch is the 2/6
      - It means the size of "struct mptcp_subflow_addrs" cannot be modified
      - Now that we have a unique subflow ID, we could also pass that in
netlink events but we need to be careful:
        - here the first subflow has ID 1 (and next ones can go up to 2³²)
        - while on the wire, it has ID 0 (and the address IDs are
limited to 2⁸)

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

      - Replies to Paolo's review:

         - check kernel version:
             - not ideal, if we find something else, better to do that
             - but still better than accepting the feature is not there?:
                 - otherwise the test can never fail
                 - but we still have
SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES to avoid regressions
             - but we need something because:
                 - when one sub-test fails, the whole selftest is marked
as failed
                 → making all the other sub-test useless
                 → we can only track the result of the whole selftest
             - To support kernels backporting new features:
                 - we can also add a new env var to skip this check
                 → always returning that the version is recent enough
                 - on these kernels, only the selftests from the same
kernel version is used I guess

         - get_counter() to get the MIB counters:
             - use everywhere for uniformity and check typo, avoid
getting two counters
             - to be backported and should not be difficult to backport:
where there will be conflicts is probably because the MIB counter is not
available in older versions

         - check nf/tc issues:
             - safer, in case kconfig are missing or issue on nf/tc side
             - not to exit in the middle or ignore issues with these rules

         - one check per block of tests around the same theme, e.g. at
the beginning of fastclose_tests():
             - it breaks the feature to check only some specific test, e.g.:
                 ./mptcp_join.sh 42
                 ./mptcp_join.sh "fastclose test"
             - the ID of the tests will be different on the different
kernels which might make the tracking of the different issues more
difficult.

         - Backports:
             - for the patches adding a check to run only on some
kernels, it is enough to backport that to the last stable kernel
             - at the end all that work is there to be able to run the
MPTCP selftests from the last stable version on older kernels.

         - the main issue we have is that we cannot report a status per
sub-tests:
             - switch to TAPv14?
             - have a helper to run each individual subtest separately:
                 - mptcp_join_<name_of_the_test>.sh → symlink to a
helper looking at the name of the test and invoking mptcp_join.sh "name
of the test"


13250875: [mptcp-next] net: skip printing "link become ready" v6 msg:
      - State: New
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230522-mptcp-skip_print_link_becomes_ready-v1-1-9d5f28f19440@tessares.net/
      - Mat will have a look → done




Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 400):

  403  userspace pm: local_addr_list: use a refcount per entry
[enhancement] [pm]:
    - Linked to patch "mptcp: add address into userspace pm list"
    - we need a refcount not to remove an entry used by multiple subflows

  402  syzkaller: BUG: KCSAN: data-race in `__mptcp_nmpc_socket` /
`mptcp_stream_accept` [bug] [syzkaller]:
    - See Paolo's patches above: mptcp: a bunch of data race fixes

  401  syzkaller: BUG: KCSAN: data-race in `mptcp_check_for_eof` /
`mptcp_poll` [bug] [syzkaller]
    - See Paolo's patches above: mptcp: a bunch of data race fixes


    Bugs (opened, flagged as "bug" and assigned)

  368  selftests: skip tests not being supported by older kernels [bug]
[selftests] @matttbe
    - See patches above

  329  PM: userspace: update `MPTCP_INFO` fields [bug] [pm] @geliangtang:
    - See patches above

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni
    - Patches have been accepted in SELinux tree: can be closed?


    Bugs (opened and flagged as "bug" and not assigned)

  402  syzkaller: BUG: KCSAN: data-race in `__mptcp_nmpc_socket` /
`mptcp_stream_accept` [bug] [syzkaller]
  401  syzkaller: BUG: KCSAN: data-race in `mptcp_check_for_eof` /
`mptcp_poll` [bug] [syzkaller]:
    - See patches above

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

  353  sockopt: uniform code to get/set values [enhancement] @matttbe

  340  netlink: switch to YAML Netlink specs [enhancement] @dcaratti:
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
  403  userspace pm: local_addr_list: use a refcount per entry
[enhancement] [pm]
  397  Doc and guidance for users [enhancement] [documentation]
  396  ci: periodically run selftests from the export branch on stable
kernels [enhancement] [selftests]
  394  selftests: ability to track subtests [enhancement] [selftests]
  389  packetdrill: increase coverage for "early `close()`" cases
[enhancement] [packetdrill]
  388  sockopt: `MPTCP_TCPINFO` and `MPTCP_SUBFLOW_ADDRS`: add a unique
ID [enhancement]
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


    Recently closed (since 2023-05-16)

/



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.5):
https://github.com/orgs/multipath-tcp/projects/3/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [efb1cf044f5c] selftests: mptcp: join: avoid using 'cmp
--bytes' (Matthieu Baerts)
        - [838d9506e958] mptcp: fix connect timeout handling (Paolo Abeni):
            - best to wait to have more input from syzkaller

        - [10dcd4c2b91e] selftests: mptcp: connect: skip if MPTCP is not
supported (Matthieu Baerts)
        - [c7abfa76e11e] selftests: mptcp: pm nl: skip if MPTCP is not
supported (Matthieu Baerts)
        - [d0e2ccf43347] selftests: mptcp: join: skip if MPTCP is not
supported (Matthieu Baerts)
        - [dc29eb0e6d95] selftests: mptcp: diag: skip if MPTCP is not
supported (Matthieu Baerts)
        - [517536262c75] selftests: mptcp: simult flows: skip if MPTCP
is not supported (Matthieu Baerts)
        - [4eaa58231b76] selftests: mptcp: sockopt: skip if MPTCP is not
supported (Matthieu Baerts)
        - [c2bfa6a1f644] selftests: mptcp: userspace pm: skip if MPTCP
is not supported (Matthieu Baerts):
            - could be sent not to block the next ones (+ the first of
the list)

    - Fixes for net-next: /

    - Features for net-next:

        - [d374cad9be1f] selftests: mptcp: add explicit check for new
mibs (Paolo Abeni):
            - TODO: Matth: not normal this patch is there: check if it
should not be removed → Done

    - Features for net-next (next): /

    - Features for other trees:

        - [6ed235059a15] security, lsm: Introduce
security_mptcp_add_subflow() (Paolo Abeni)
        - [23c6527c52ed] selinux: Implement mptcp_add_subflow hook
(Paolo Abeni):
            - In SELinux tree

        - [a474c737914a] mptcp: refactor push_pending logic (Geliang Tang)
        - [9047019ce127] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [46d1108524f3] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [f2ed372bd0a5] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [589c09012db9] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [ce19bebf102b] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [37597eec2ac3] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [defe19e0eada] mptcp: add scheduler wrappers (Geliang Tang)
        - [4ef71ebd975f] mptcp: use get_send wrapper (Geliang Tang)
        - [fae12555a400] mptcp: use get_retrans wrapper (Geliang Tang)
        - [e25903c76ff8] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [bd225eae79d6] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [cd3621dfabba] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [362e188d02c4] selftests/bpf: use random netns name for mptcp
(Geliang Tang)
        - [2c11df98d0cb] selftests/bpf: add two mptcp netns helpers
(Geliang Tang)
        - [0870cbd36a7e] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [e5b8db1bbfaa] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [30f3fb8499b0] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [5fe89fe00b36] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [400f88bbf96a] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [e6970883784b] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [93693fff76fb] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [6710931541a7] selftests/bpf: Add bpf_red test (Geliang Tang):
            - Blocked by Sched API refactoring



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - still working

    - CI (Matth):
        - still the same unstable tests since we switched to v6.4-rc1



Next meeting:
    - Next one on Tuesday, the 30th of May.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230530



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
