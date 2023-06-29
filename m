Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D1B2565
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 13:14:41 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4fb7589b187so1055111e87.1
        for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 06:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688044480; x=1690636480;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3yhqPkYR1Q+2QjghsjyWpyhPmynDEXt4QG4NHTC9aE=;
        b=VY7PDYjJu1CgVRvnyQGmF7RyyMw7rDzyofSSYxXXAv5e8iwM3M/3QSwYoWZkcoyW+o
         ErX7Wfw6GWEV17+G8IUCw7gwG83GM/BFvfZ+UvI0S73AetnVvw41Z3SSsoTKwa/AyeUm
         xcXDyuFm9uU0H4/Ocj1tOIsdJ+ozYMIVXbNq7pVhRPIzxXZJucqiuHMhFeSUYTANGAGO
         L8uwG7B4Eu27BPDq9hQQxFA65pqk25b5/kVFUIfV3HPAdlIY/wmzg7GsY9c9KHJbIvV2
         Y7YFr/2pFb2UmO+6KKLmW7u6blDtLbt4aDtSEzLzDWtbf8uEhENpz9k2nWqsgORwzmyW
         kclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688044480; x=1690636480;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W3yhqPkYR1Q+2QjghsjyWpyhPmynDEXt4QG4NHTC9aE=;
        b=bkG52JP6bv/hJDfr/R4evIjAz9u9oC2QKWcHVsKE6F9nqn/YzWL+AfYAWkhw6sQbsL
         du1lkhvy/u3YTKkqaCfsPJj/DIm+XWgKk6vQTDjzSrX+5K8GFtSiUtHu+A109dmGDQ21
         jdaFGEE3C7hi6nu82PAo7oLhjHWpCngbOz6M92Evyh7ZnvFIvVRAPukEpgFuXc9H82mQ
         HQiWYfymDiqlQ4UbqDV4Ki0qyUPdOyzjMDn+axe9G4tKX0ezKgOuGO7tk1L3onB33T7s
         VlSGaBzqA1+eHKmyQhBpx19cO90QeKV4HKdDTyupVHOcTHUnBbo7ozh5Dt4BknZb+JFX
         bijA==
X-Gm-Message-State: AC+VfDzdTegvR/U8j/PkYnTX0pFLa8oVK4wYY+e7uzZyyCYWQbeS2lx+
	x8diaGem0d61SKhaqEzYtLUhh5kx4j/chzzXaJGWOw==
X-Google-Smtp-Source: ACHHUZ69J1j09SFB9mOSVIR/1UrCQ3BH1K37geygtLyO42YHAOaa7+EgI2qFw2LriJWQhXPlXqooeg==
X-Received: by 2002:a05:6512:401e:b0:4f9:b31b:db6 with SMTP id br30-20020a056512401e00b004f9b31b0db6mr10223951lfb.9.1688044479246;
        Thu, 29 Jun 2023 06:14:39 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:1b84:4392:4d8d:653c? ([2a02:578:8593:1200:1b84:4392:4d8d:653c])
        by smtp.gmail.com with ESMTPSA id p2-20020adfe602000000b00307c8d6b4a0sm15772747wrm.26.2023.06.29.06.14.38
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 06:14:38 -0700 (PDT)
Message-ID: <fddc96c7-eb5d-0a6a-c0b7-76d3a1e41519@tessares.net>
Date: Thu, 29 Jun 2023 15:14:38 +0200
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
Subject: [Weekly meetings] MoM - 27th of June 2023
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Yesterday, we had our 247th meeting with Paolo, Davide (Redhat), Mat
(Cruise) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Christophe JAILLET, David
Howells, Mat Martineau, Matthieu Baerts):

13283791: [net-next] mptcp: Reorder fields in 'struct mptcp_pm_add_entry':
      - Submitter: Christophe JAILLET
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/e47b71de54fd3e580544be56fc1bb2985c77b0f4.1687081558.git.christophe.jaillet@wanadoo.fr/

13286133: [net,1/6] mptcp: handle correctly disconnect() failures
13286134: [net,2/6] mptcp: fix possible divide by zero in recvmsg()
13286135: [net,3/6] mptcp: fix possible list corruption on passive MPJ
13286136: [net,4/6] mptcp: consolidate fallback and non fallback state
machine
13286137: [net,5/6] mptcp: drop legacy code around RX EOF
13286138: [net,6/6] mptcp: ensure listener is unhashed before updating
the sk status:
      - Series: mptcp: fixes for 6.4
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=758772&state=*&archive=both

13286140: [net-next,1/9] mptcp: move snd_una update earlier for fallback
socket
13286141: [net-next,2/9] mptcp: track some aggregate data counters
13286142: [net-next,3/9] selftests: mptcp: explicitly tests aggregate
counters
13286148: [net-next,4/9] mptcp: add subflow unique id
13286143: [net-next,5/9] mptcp: introduce MPTCP_FULL_INFO getsockopt
13286144: [net-next,6/9] selftests: mptcp: add MPTCP_FULL_INFO testcase
13286145: [net-next,7/9] selftests: mptcp: join: skip check if MIB
counter not supported (part 2)
13286146: [net-next,8/9] mptcp: consolidate transition to TCP_CLOSE in
mptcp_do_fastclose()
13286147: [net-next,9/9] mptcp: pass addr to mptcp_pm_alloc_anno_list:
      - Series: mptcp: expose more info and small improvements
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=758773&state=*&archive=both

13289330: [6.1.y] selftests: mptcp: join: fix "userspace pm add & remove
address":
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230622154307.3362179-1-matthieu.baerts@tessares.net/
      - only needed in v6.1 because mptcp_join.sh is creating listening
sockets in v4: the parsing of the address is then different

13290847: [net-next,1/8] selftests: mptcp: test userspace pm out of transfer
13290846: [net-next,2/8] selftests: mptcp: check subflow and addr infos
13290848: [net-next,3/8] selftests: mptcp: set FAILING_LINKS in run_tests
13290850: [net-next,4/8] selftests: mptcp: drop test_linkfail parameter
13290849: [net-next,5/8] selftests: mptcp: drop addr_nr_ns1/2 parameters
13290851: [net-next,6/8] selftests: mptcp: drop sflags parameter
13290853: [net-next,7/8] selftests: mptcp: add pm_nl_set_endpoint helper
13290852: [net-next,8/8] selftests: mptcp: connect: fix comment typo:
      - Series: selftests: mptcp: Refactoring and minor fixes
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=759868&state=*&archive=both

13291466: [net-next,v5,15/16] sock: Remove ->sendpage*() in favour of
sendmsg(MSG_SPLICE_PAGES)
13291467: [net-next,v5,16/16] net: Kill MSG_SENDPAGE_NOTLAST:
      - Series: -
      - Submitter: David Howells
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=759933&state=*&archive=both
      - Not specific to MPTCP, part of a cross-subsystem modification


    our repo (by: Paolo Abeni, Yueh-Shun Li):

13288136: [7/8] selftests: mptcp: connect: fix comment typo

13290772: [mptcp-net] mptcp: ensure subflow is unhashed before cleaning
the backlog:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/73f793566f58e53e7c132711cd75fa7ea211d6f4.1687531836.git.pabeni@redhat.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Joel Granados):

13286945: [06/11] sysctl: Add size to register_net_sysctl function
13287069: [09/11] sysctl: Remove the end element in sysctl table arrays
      - Not specific to MPTCP, part of a cross-subsystem modification


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
      - status is the same as last week

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
      - status is the same as last week

13279511: [mptcp-next] Squash to "mptcp: add mptcp_subflow_ctx_by_pos
helper":
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/cadb420a03c98ac7099fd2228745262626f8ec9c.1686713645.git.geliang.tang@suse.com/
      - superseded

13279642: [mptcp-next] selftests: bpf: Add time metrics for sched tests:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/c369b42c70b6c7a0c7d534ab3f4872af3ea8868f.1686727613.git.geliang.tang@suse.com/
      - Superseded

13282183: [mptcp-next,v20,09/10] selftests: mptcp: pass fastclose to sflags
13282184: [mptcp-next,v20,10/10] selftests: mptcp: set endpoint out of
transfer:
      - State: Changes requested
      - Series: update userspace pm mptcp_info fields part 2
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=757748&state=*&archive=both

13287750: [mptcp-next,01/18] selftests: mptcp: connect: fail if nft
supposed to work
13287754: [mptcp-next,02/18] selftests: mptcp: sockopt: use
'iptables-legacy' if available
13287752: [mptcp-next,03/18] selftests: mptcp: sockopt: return error if
wrong mark
13287753: [mptcp-next,04/18] selftests: mptcp: userspace_pm: use correct
server port
13287755: [mptcp-next,05/18] selftests: mptcp: userspace_pm: report
errors with 'remove' tests
13287756: [mptcp-next,06/18] selftests: mptcp: connect: don't stop if error
13287757: [mptcp-next,07/18] selftests: mptcp: userspace pm: don't stop
if error
13287758: [mptcp-next,08/18] selftests: mptcp: userspace_pm: fix
shellcheck warnings
13287760: [mptcp-next,09/18] selftests: mptcp: userspace_pm: uniform
results printing
13287759: [mptcp-next,10/18] selftests: mptcp: userspace_pm: reduce dup
code around printf
13287761: [mptcp-next,11/18] selftests: mptcp: lib: format subtests
results in TAP
13287762: [mptcp-next,12/18] selftests: mptcp: connect: format subtests
results in TAP
13287763: [mptcp-next,13/18] selftests: mptcp: pm_netlink: format
subtests results in TAP
13287765: [mptcp-next,14/18] selftests: mptcp: join: format subtests
results in TAP
13287764: [mptcp-next,15/18] selftests: mptcp: diag: format subtests
results in TAP
13287766: [mptcp-next,16/18] selftests: mptcp: simult flows: format
subtests results in TAP
13287767: [mptcp-next,17/18] selftests: mptcp: sockopt: format subtests
results in TAP
13287768: [mptcp-next,18/18] selftests: mptcp: userspace_pm: format
subtests results in TAP:
      - State: New
      - Series: selftests: mptcp: format subtests results in TAP
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=759227&state=*&archive=both
      - a bit of a workaround but the only thing I found to be able to
track the subtests.
      - print the test name earlier: TODO Matth: can be interesting → Done

13290474: [net,1/2] selftests: mptcp: join: fix 'delete and re-add' test
13290475: [net,2/2] selftests: mptcp: join: fix 'implicit EP' test:
      - State: New
      - Series: selftests: fix mptcp_join test
      - Submitter: Andrea Claudi
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=759793&state=*&archive=both
      - a v2 is needed

13293650: [mptcp-next,v11,01/11] Squash to "mptcp: drop last_snd and
MPTCP_RESET_SCHEDULER"
13293651: [mptcp-next,v11,02/11] Squash to "mptcp: add struct
mptcp_sched_ops"
13293652: [mptcp-next,v11,03/11] Squash to "mptcp: add
sched_data_set_contexts helper"
13293653: [mptcp-next,v11,04/11] mptcp: register default scheduler
13293654: [mptcp-next,v11,05/11] Squash to "bpf: Add bpf_mptcp_sched_ops"
13293655: [mptcp-next,v11,06/11] Squash to "bpf: Add
bpf_mptcp_sched_kfunc_set"
13293656: [mptcp-next,v11,07/11] Squash to "selftests/bpf: Add mptcp
sched structs"
13293657: [mptcp-next,v11,08/11] Squash to "selftests/bpf: Add bpf_first
scheduler"
13293658: [mptcp-next,v11,09/11] Squash to "selftests/bpf: Add bpf_bkup
scheduler"
13293659: [mptcp-next,v11,10/11] Squash to "selftests/bpf: Add bpf_rr
scheduler"
13293660: [mptcp-next,v11,11/11] Squash to "selftests/bpf: Add bpf_red
scheduler":
      - State: New
      - Series: BPF packet scheduler updates part 1
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=760451&state=*&archive=both
      - would be good to apply these patches even if they are not ready
to ease Geliang's work: hopefully take a decision by the ind of the week
      - v11 looks good in term on how the BPF scheduler can store data
(with ska_storage)

13293682: [mptcp-next,01/10] Squash to "selftests/bpf: Add bpf_first test"
13293683: [mptcp-next,02/10] selftests/bpf: Add bpf_first test
13293684: [mptcp-next,03/10] Squash to "selftests/bpf: Add bpf_bkup test"
13293685: [mptcp-next,04/10] Squash to "selftests/bpf: Add bpf_rr test"
13293686: [mptcp-next,05/10] Squash to "selftests/bpf: Add bpf_red test"
13293687: [mptcp-next,06/10] selftests/bpf: Add bpf_stale scheduler
13293688: [mptcp-next,07/10] selftests/bpf: Add bpf_stale test
13293689: [mptcp-next,08/10] bpf: Export more bpf_burst related functions
13293690: [mptcp-next,09/10] selftests/bpf: Add bpf_burst scheduler
13293691: [mptcp-next,10/10] selftests/bpf: Add bpf_burst test:
      - State: New
      - Series: BPF packet scheduler updates part 2
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=760457&state=*&archive=both

13294008: [iperf3] add MPTCPv1 support:
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/
      - A new version for https://github.com/esnet/iperf/pull/1166
      - Matth will have a look

13294516: [5.15.y] mptcp: fix possible divide by zero in recvmsg():
      - State: New
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230627132510.2265333-1-matthieu.baerts@tessares.net/

13294517: [5.15.y] mptcp: consolidate fallback and non fallback state
machine:
      - State: New
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230627132557.2266416-1-matthieu.baerts@tessares.net/

13294657: [RFC,mptcp-next,v2] mptcp: convert netlink from small_ops to ops:
      - State: New
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/ed9c7f0320bb94a4a147d11c447cefa59f128ee1.1687877390.git.dcaratti@redhat.com/
      - a new version addressing Paolo comments (I guess, there is no
changelog :) )
      - an intermediate version before switching to yanl
      - there are other issues with yanl but Davide will share more
details later
      - the current spec has the same "nested policy" shared between
many commands: we cannot have "easy" validations the same way for all
commands (e.g. maybe the ID is mandatory for one and not for another
one) and we cannot change the API :)
      - so a bit less advantages to do the switch but OK (and yanl might
need to support that case)




Extra, just in case



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from the last meeting: 415):

  416  reestablishment on reconnecting mainflow ifaces and tap ifaces:
       - New question to answer, TODO

    Bugs (opened, flagged as "bug" and assigned)

  368  selftests: skip tests not being supported by older kernels [bug]
[selftests] @matttbe:
       - See patches above


    Bugs (opened and flagged as "bug" and not assigned)

  414  syzkaller: divide error in `__tcp_select_window` [bug] [syzkaller]:
      - probably already fixed? (→ EDIT: no)
      - mptcp fastclose changed the struct socket state (for the ops
level) instead of the struct sock state
      - but it should be fixed thanks to a patch Paolo is going to send:
"mptcp: fix bogus socket state update"

  400  packetdrill: data are retransmitted after the `close()` [bug]
[packetdrill]
  398  syzkaller: memory leak in `subflow_ulp_init` [bug] [syzkaller]:
      - report issue to kmemleak devs?

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
  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]


    In Progress (opened, new feature and assigned)

  403  userspace pm: local_addr_list: use a refcount per entry
[enhancement] [pm] @geliangtang
  353  sockopt: uniform code to get/set values [enhancement] @matttbe

  342  scheduler: area in the socket structures reserved for schedulers
[enhancement] [sched] @geliangtang:
       - see patches above

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

  413  Question: Transport Converters for non-MPTCP end devices [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]
  395  If MPTCP primary flow is over tun interface, no subflow gets
created [question]
  392  Problem attempting to use all my interfaces (subflows)  [question]


    For later (opened and not assigned assigned)

  416  reestablishment on reconnecting mainflow ifaces and tap ifaces
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


    Recently closed (since 2023-06-20)

None.




FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.5):
https://github.com/orgs/multipath-tcp/projects/3/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1
    - TODO: Matth: update Changelog in the wiki + project → Done



Patches to send to netdev:

    - Fixes for other trees:

        - [27d617aecfed] Revert "Merge tag '9p-6.4-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs" (Matthieu
Baerts):
            - was just for the CI

    - Fixes for -net:

        - [b5cc099e1e96] mptcp: ensure subflow is unhashed before
cleaning the backlog (Paolo Abeni):
            - maybe wait for "mptcp: fix bogus socket state update"?
            - check by the end of the week.

    - Fixes for net-next:

        - [3f43614d64ed] perf trace: fix MSG_SPLICE_PAGES build error
(Matthieu Baerts)

    - Features for net-next: /


    - Features for net-next (next): /


    - Features for other trees:

        - [1ae4a8aba37c] security, lsm: Introduce
security_mptcp_add_subflow() (Paolo Abeni)
        - [b1a4dbb7cd51] selinux: Implement mptcp_add_subflow hook
(Paolo Abeni):
            - should be applied soon in Linus tree

        - [2b2d5778b637] mptcp: refactor push_pending logic (Geliang Tang)
        - [8e6b6a1ddd9e] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [a155ff4f8a2c] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [bb8826f127d7] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [69cd1046395d] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [b94c463638fc] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [101480f14c11] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [6078d4d7527c] mptcp: add scheduler wrappers (Geliang Tang)
        - [d5f993df645e] mptcp: use get_send wrapper (Geliang Tang)
        - [412bf919140b] mptcp: use get_retrans wrapper (Geliang Tang)
        - [ad731857c587] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [4e0bcf53548d] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [0459d9099022] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [82b10a968162] selftests/bpf: use random netns name for mptcp
(Geliang Tang)
        - [f0e7e7ea574b] selftests/bpf: add two mptcp netns helpers
(Geliang Tang)
        - [cd42753659cf] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [979115ed6b9b] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [7102a42b5361] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [2af72583745f] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [06e5d6de54eb] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [5da59881b1d6] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [f264f62ca7b8] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [c650a27a5ad2] selftests/bpf: Add bpf_red test (Geliang Tang):
            - status is the same as last week




Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - https://github.com/multipath-tcp/packetdrill/pull/115:
            - can we apply it? TODO: yes

    - Patchew (Davide):
        - /

    - CI (Matth):
        - /



Patches sent by "occasional" contributors include Netdev maintainers and
list:
    - Modify the MAINTAINERS file to exclude Netdev maintainers and list
when someone sends a patch?
    - just occasionnal patches, it doesn't seem to annoy Netdev
maintainers, we can continue like that



Next meeting:
    - Next one on Tuesday, the 4th of July.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230704



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
