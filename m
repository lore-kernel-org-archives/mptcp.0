Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4549CA4A
	for <mptcp@lists.linux.dev>; Wed,  4 Jan 2023 17:29:30 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so30113232wma.1
        for <mptcp@lists.linux.dev>; Wed, 04 Jan 2023 09:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGqUgm16mNd6O6HTeJxU073U8Cx6Q5Dj9kpK98lF8yI=;
        b=R9Hsq60ZGW61nY0fbQXbC0hmh+fgZ1yr8azOVdYM1KOnr18iGu34tfVlHXit+eGhdf
         O+AwxAJEEKtTKfYg3tS1+TrXUuAD2TX+nHWPK7QGJbqR52kNyMfmUMxL0BVum017XDTJ
         8AYbH+K0WXp8F9OiRA/iQZvftOUkMu8phMqAFfHjTorHJdqwzZI0/zYvMsxx29TaAme9
         ftPvkbcxQDrT82+FdGsftgBi0cFOVl+ZeTx8BTGFAgZvwpdqdE5DxgcsCx1zXXaVOZpD
         x7uCBetsAgsBUVriQ2R1eyW89PYu4eyPmV5OnuGEguyD0WviH4ff4zgQ0Oumm91xtzuy
         8v5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HGqUgm16mNd6O6HTeJxU073U8Cx6Q5Dj9kpK98lF8yI=;
        b=gqqVro5E1f49L/xslZsib10E3rAegS7BrsWhpZFWCc+9d43tAOTqZ5GPhYu6Dh185B
         ZU4pWDRlE1wlZjtzeJG6CwcPAQ8ezrX2XlRDjJHyVyVVD237ELgjwofsKXvLPOFQSgzm
         uh76HbHInW4y9pFaE4z7nbC1PsDwNIaBZzROXlxJLc9SfASGT2hsLdl3ORot5Oe8iVy0
         DITOY5KQ9VbOFwMyjjjsnsXhSmD4l7PysTWHCbMEG3seiPoNiYx+2/hMWWR3AokjCcci
         Fn5cUBBGZh+qLanuu6AkUhkofQuzwM0R6RTy6JUOjDSKe7ZpdrVbnPJb41o4lL3YQUbZ
         cFFg==
X-Gm-Message-State: AFqh2koUoEXSylWNOwwONwVnQdRh1sEu6VmRVAIYlsJ5g040WlqtJkB5
	kjugH7DNzEUZEVZBz87gRKdzoexsWDT2bMpaaig=
X-Google-Smtp-Source: AMrXdXs8splHAfAdxuuyIeGi4cag+lz5a7Krc6ZBmjalFWnRRdcX0NGxB7+eNNhs48Z08veK/a+nMw==
X-Received: by 2002:a05:600c:3b91:b0:3d1:e710:98ec with SMTP id n17-20020a05600c3b9100b003d1e71098ecmr42858602wms.21.1672853367866;
        Wed, 04 Jan 2023 09:29:27 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:540d:f562:8a82:61fa? ([2a02:578:8593:1200:540d:f562:8a82:61fa])
        by smtp.gmail.com with ESMTPSA id q7-20020adff947000000b002426d0a4048sm33806738wrr.49.2023.01.04.09.29.27
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 09:29:27 -0800 (PST)
Message-ID: <d01f9328-3469-2ea8-d207-f5ea24b341e7@tessares.net>
Date: Wed, 4 Jan 2023 18:29:26 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 3rd of January 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello everyone,

Yesterday, we had our 222nd meeting with Mat, Ossama (Intel), Christoph
(Apple), Dmytro (?), Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

13078145: [net,1/2] mptcp: fix deadlock in fastopen error path
13078146: [net,2/2] mptcp: fix lockdep false positive:
      - Series: mptcp: Locking fixes
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=706038&state=*&archive=both


    our repo (by: Geliang Tang):

13074155: [mptcp-next,v25,1/5] mptcp: add scheduler wrappers
13074156: [mptcp-next,v25,2/5] mptcp: use get_send wrapper
13074157: [mptcp-next,v25,3/5] mptcp: use get_retrans wrapper
13074158: [mptcp-next,v25,4/5] selftests/bpf: Add bpf_red scheduler
13074159: [mptcp-next,v25,5/5] selftests/bpf: Add bpf_red test:
      - Series: BPF redundant scheduler, part 2
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=704762&state=*&archive=both

13077497: [mptcp-next] Squash to "mptcp: use get_send wrapper, v25":
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/db6dc5629093dea02dd3b6c1088f8efdf78ea03a.1671507997.git.geliang.tang@suse.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Jiapeng Chong, Matthieu Baerts, Paolo
Abeni):

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
      - status: same as last week
      - TODO: list what is needed to solve some corner cases for the
scheduler

13076926: [v2,1/2] security, lsm: Introduce security_mptcp_add_subflow()
13076927: [v2,2/2] selinux: Implement mptcp_add_subflow hook:
      - State: Changes requested
      - Series: lsm: introduce and use security_mptcp_add_subflow()
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=705673&state=*&archive=both
      - v2 has been sent but waiting for feedback from LSM devs

13081722: [mptcp-iproute2] mptcp: add new listener events:
      - State: New
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221226093558.599103-1-matthieu.baerts@tessares.net/
      - just to agree on the names to pick

13082841: [mptcp-net,v4,01/12] mptcp: explicitly specify sock family at
subflow creation time
13082842: [mptcp-net,v4,02/12] mptcp: netlink: respect v4/v6-only sockets
13082845: [mptcp-net,v4,03/12] selftests: mptcp: userspace: validate
v4-v6 subflows mix
13082843: [mptcp-next,v4,04/12] mptcp: let the in-kernel PM use mixed
IPv4 and IPv6 addresses
13082844: [mptcp-next,v4,05/12] mptcp: propagate sk_ipv6only to subflows
13082846: [mptcp-next,v4,06/12] selftests: mptcp: add test-cases for
mixed v4/v6 subflows
13082847: [mptcp-next,v4,07/12] mptcp: remove assigned but unused value
13082849: [mptcp-next,v4,08/12] mptcp: userspace pm: use a single point
of exit
13082848: [mptcp-next,v4,09/12] selftests: mptcp: userspace: print titles
13082851: [mptcp-next,v4,10/12] selftests: mptcp: userspace: refactor
asserts
13082850: [mptcp-next,v4,11/12] selftests: mptcp: userspace: print error
details if any
13082852: [mptcp-next,v4,12/12] selftests: mptcp: userspace: avoid read
errors:
      - State: New
      - Series: mptcp: add support for mixed v4/v6
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=707295&state=*&archive=both
      - split in two parts:
          - one for -net (3 first patches): fixes for the netlink PM
          - one for net-next (the rest): but patch 1/12 is needed for
net-next as well



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 331):

  332  scheduler: implement a "opportunistic retransmission" [enhancement]:
      - Linked to the discussions from the last meeting


    Bugs (opened, flagged as "bug" and assigned)

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni:
      - v2 has been sent but waiting for feedback from LSM devs


    Bugs (opened and flagged as "bug" and not assigned)

  331  MPTCP in multihoming doesn't announce all endpoints [bug]
  329  PM: userspace: update `MPTCP_INFO` fields [bug]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: test 98 `fastclose test` is sometimes
failing [bug] [selftests]
  323  selftests: `mptcp_join`: test 111 `delete and re-add` is often
failing [bug] [selftests]
  318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
cookies [bug] [selftests]
  315  Issues with backup flow [bug]
  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]


    In Progress (opened, new feature and assigned)

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe

  269  Allow having a mix of v4/v6 subflows for the same socket
[enhancement] @pabeni:
      - see patches above

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang:
       - see patches above

   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

  307  TCP performance better than MPTCP [question] @matttbe


    Open questions (opened, questions and not assigned)

  326  Issue with streaming traffic with MPTCP upstream implementation
[question]


    For later (opened and not assigned assigned)

  332  scheduler: implement a "opportunistic retransmission" [enhancement]
  330  `MPTCP_INFO`: document and support `mptcpi_subflows` for the
server side [enhancement]
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


    Recently closed (since 2022-12-20)

  328  Problem using REDIRECT/MASQUERADE/TPROXY with MPTCP [question]
  319  kmemleak: 6 new suspected memory leaks in -net [bug]:



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

        - [760b7619015e] mptcp: use msk_owned_by_me helper (Geliang Tang)
        - [2d1f1999916a] mptcp: use net instead of sock_net (Geliang Tang)
        - [7d1a091c596d] mptcp: use local variable ssk in write_options
(Geliang Tang)
        - [017ea57bcf09] mptcp: introduce 'sk' to replace 'sock->sk' in
mptcp_listen() (Menglong Dong)
        - [944e5425715a] mptcp: init sk->sk_prot in build_msk()
(Menglong Dong)
        - [cb22370bcc5a] mptcp: rename 'sk' to 'ssk' in
mptcp_token_new_connect() (Menglong Dong)
        - [647661f97d3f] mptcp: add statistics for mptcp socket in use
(Menglong Dong)
        - [a39c64febbd5] selftest: mptcp: exit from copyfd_io_poll()
when receive SIGUSR1 (Menglong Dong)
        - [2f1882aa4aca] selftest: mptcp: add test for mptcp socket in
use (Menglong Dong):
            - can be sent but net-next is still closed
            - Note: net-next has been re-opened a few hours after the
meeting

    - Features for net-next (next): /

    - Features for other trees:

        - [849b7b2dae95] mptcp: refactor push_pending logic (Geliang Tang)
        - [0cd7e1f5ab64] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [7494dedf030f] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [91b5f6d9ea6d] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [241a7d2f64e9] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [2749034c3af7] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [87a6780b286b] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [b9fc6b7a0bfb] mptcp: add scheduler wrappers (Geliang Tang)
        - [8727cf2fbe64] mptcp: use get_send wrapper (Geliang Tang)
        - [727f469f3c2d] mptcp: use get_retrans wrapper (Geliang Tang)
        - [39f9b6c01a56] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [3d90526cc6d8] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [94ad9a143f80] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [3bc2ba34a10c] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [f138a444aa69] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [f86b699c6163] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [51dcc09cf1ca] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [8495a14bbfe6] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [5fd8aaaab30d] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [db44f7759481] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [c1becbef39ad] selftests/bpf: Add bpf_red test (Geliang Tang):
            - same as last week: still some work in progress around that



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - nothing related to MPTCP

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - some issues elsewhere so no results for the moment

    - packetdrill (Davide):
        - Apple's test suites:
            - PR on packetdrill_mptcp
            - next steps:
                - Update the PR and apply it
                - switch to Davide's version (the one we use) with the
fork kernel
                - run the test suite on the upstream kernel

    - Patchew (Davide):
        - still working as expected

    - CI (Matth):
        - diag.sh:
            - some rare issues on Tessares side
            - also seen on Intel side, more frequently
            - maybe because something is happening quicker than expected
        - the CI with the debug kernel config is failing:
            - because it cannot create vmlinux.o
            - LD is killed
            - Maybe OOM?
            - Visible since the switch to v6.2-rc:
                - maybe fixed on Linus tree?
                - TODO: Matth: start a build with a merge
                - Done: https://cirrus-ci.com/build/6256738874163200
                - Was due to OOM: now fixed!
                -
https://github.com/multipath-tcp/mptcp_net-next/commit/94077c87a715



Next meeting:
    - Next one on *Tuesday*, the 10th of January.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230110



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
