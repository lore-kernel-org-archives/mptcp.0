Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0125B15AD8
	for <mptcp@lists.linux.dev>; Tue, 18 Jul 2023 17:44:23 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3fbc656873eso62278315e9.1
        for <mptcp@lists.linux.dev>; Tue, 18 Jul 2023 10:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689702261; x=1692294261;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2ckUfb5BFNHw16DQBHL+O2pW23ZNl8DecrDqsOc4DA=;
        b=uDzXFhlk6scRrxLN+QnzEvITw+lAdDyGvDOvD02jdSOdExOJCgPZPriKiExC0cQoDB
         9uhALfEFb6JsaZVvb3squeF+0WgQIpcBiFSlNwhJmCatI4XvPkZiSNWmSKEXKZMBoGWe
         Er/HJyf8oWB0zsqspjz5iZO5CaBb98oaOySAvvL1mXSkE+BAEJcX7R7Su1DAXQQ9VM3v
         +HNRNMixZaRDyjdkN1/5JJaccr7MYRPRXoIKWd84u9Bbi5zCvPtlm4l/GDlPJ+yvERcX
         zaRO5jRP0HS7ySn9Pf0aB7RIEphe4ZFEkkK9WGmmVpkYGKN/NP7DVmzRwB0QHJKCNMYL
         YPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689702261; x=1692294261;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G2ckUfb5BFNHw16DQBHL+O2pW23ZNl8DecrDqsOc4DA=;
        b=Z+30ttrGQjuBMYJkuGuWW7Wm0PGfHJdxeZAD6n9+Sp4gFeIcNVzzck4qlVxLv4cqxL
         TdaY+XPUlV9W5EmjlOhWepZaQFDp2TgVmG05cVqVxXLsd2NHpt8oeLo7qB60Z40WE7Iv
         23T/aWDvEskHBQ/5EqBiMnMdI+iZn2SgZlW5+fdOtgO/4J1VMasaWkvaUmaO+1UAkvKb
         Fm3DCGuhQeG0w5dnKIGOg0nTSJMca+LMJC8zG42vAIA1748qIF0VhYYbZ8V0VPGmkvoi
         T2R2RnSqVllA/10ZeCBdwoyOUbpNXF257r9IHubYfgJXSyfyn3MgPJj/MBABqb5n/LDF
         A4zA==
X-Gm-Message-State: ABy/qLZvJFqytJEFVomhmrM/QPtuQa7OBeblzpYuPxjpgRyo+ANGY7SH
	USyPg9g0tmhhv4dcfCYJZ4zN9kDdWsHN0Xoy42I=
X-Google-Smtp-Source: APBJJlGafGvu+jeZxSzTufqyOVdrg4pn2Ykay88B9fIDi2+BByB7T3vjAJF2nwFspbuIYgtZo1hQLA==
X-Received: by 2002:a1c:7912:0:b0:3fb:b280:f548 with SMTP id l18-20020a1c7912000000b003fbb280f548mr2809490wme.0.1689702260992;
        Tue, 18 Jul 2023 10:44:20 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:d8f3:d99:c27c:3605? ([2a02:578:8593:1200:d8f3:d99:c27c:3605])
        by smtp.gmail.com with ESMTPSA id z23-20020a1c4c17000000b003fbe791a0e8sm2697275wmf.0.2023.07.18.10.44.20
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 10:44:20 -0700 (PDT)
Message-ID: <7b49e1a0-7e9b-4a8b-688d-2bd8a131eff5@tessares.net>
Date: Tue, 18 Jul 2023 19:44:19 +0200
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
Subject: [Weekly meetings] MoM - 18th of July 2023
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Today, we had our 250th meeting with Christoph (Apple), Paolo, Davide
(Redhat) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13310608: [net-next,1/4] selftests: mptcp: set all env vars as local ones
13310609: [net-next,2/4] selftests: mptcp: add fastclose env var
13310610: [net-next,3/4] selftests: mptcp: add fullmesh env var
13310611: [net-next,4/4] selftests: mptcp: add speed env var:
      - Series: selftests: mptcp: join: pass args in new env vars
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=764951&state=*&archive=both


    our repo (by: Geliang Tang, Matthieu Baerts, Paolo Abeni):

13293682: [mptcp-next,01/10] Squash to "selftests/bpf: Add bpf_first test"
13293683: [mptcp-next,02/10] selftests/bpf: Add bpf_first test
13293684: [mptcp-next,03/10] Squash to "selftests/bpf: Add bpf_bkup test"
13293685: [mptcp-next,04/10] Squash to "selftests/bpf: Add bpf_rr test"
13293686: [mptcp-next,05/10] Squash to "selftests/bpf: Add bpf_red test":
    - Series from Geliang, BPF part 2

13306937: [mptcp-next,01/14] mptcp: more accurate NL event generation.
13310145: [mptcp-next,v2,1/3] selftests: mptcp: join: rework detailed report
13310144: [mptcp-next,v2,2/3] selftests: mptcp: join: colored results
13310143: [mptcp-next,v2,3/3] selftests: mptcp: join: only check for
ip6tables if needed:
      - Series: selftests: mptcp: format subtests results in TAP (part 2)
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=764813&state=*&archive=both

13312586: [mptcp-next,v2,1/2] selftests: mptcp: pm_nl_ctl: always look
for errors
13312587: [mptcp-next,v2,2/2] selftests: mptcp: userspace_pm: unmute
unexpected errors:
      - Series: selftests: mptcp: pm_nl_ctl: display errors if any
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=765431&state=*&archive=both

13313519: [v2,mptcp-next,01/13] mptcp: avoid unneeded
mptcp_token_destroy() calls
13313521: [v2,mptcp-next,02/13] mptcp: avoid additional
__inet_stream_connect() call
13313520: [v2,mptcp-next,03/13] mptcp: avoid subflow socket usage in
mptcp_get_port()
13313522: [v2,mptcp-next,04/13] net: factor out inet{,6}_bind_sk helpers
13313523: [v2,mptcp-next,05/13] mptcp: mptcp: avoid additional
indirection in mptcp_bind()
13313524: [v2,mptcp-next,06/13] net: factor out __inet_listen_sk() helper
13313527: [v2,mptcp-next,07/13] mptcp: avoid additional indirection in
mptcp_listen()
13313525: [v2,mptcp-next,08/13] mptcp: avoid additional indirection in
mptcp_poll()
13313526: [v2,mptcp-next,09/13] mptcp: avoid unneeded indirection in
mptcp_stream_accept()
13313528: [v2,mptcp-next,10/13] mptcp: avoid additional indirection in
sockopt
13313529: [v2,mptcp-next,11/13] mptcp: avoid ssock usage in
mptcp_pm_nl_create_listen_socket()
13313530: [v2,mptcp-next,12/13] mptcp: change the mpc check helper to
return a sk
13313531: [v2,mptcp-next,13/13] mptcp: get rid of msk->subflow:
      - Series: mptcp: get rid of msk->subflow
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=765694&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Matthieu Baerts):

13303341: [RFC,bpf-next,v3,1/8] bpf: Add new prog type sockinit
13303342: [RFC,bpf-next,v3,2/8] bpf: Run a sockinit program
13303343: [RFC,bpf-next,v3,3/8] net: socket: run sockinit hooks
13303344: [RFC,bpf-next,v3,4/8] libbpf: Support sockinit hook
13303345: [RFC,bpf-next,v3,5/8] selftests/bpf: Add mptcpify program
13303346: [RFC,bpf-next,v3,6/8] selftests/bpf: use random netns name for
mptcp
13303347: [RFC,bpf-next,v3,7/8] selftests/bpf: add two mptcp netns helpers
13303351: [RFC,bpf-next,v3,8/8] selftests/bpf: Add mptcpify selftest:
      - Series: BPF 'force to MPTCP'
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=762983&state=*&archive=both
      - TODO: Matth: superseded → Done

13312647: [net,1/3] selftests: tc: set timeout to 15 minutes
13312649: [net,2/3] selftests: tc: add 'ct' action kconfig dep
13312650: [net,3/3] selftests: tc: add ConnTrack procfs kconfig:
      - Series: selftests: tc: increase timeout and add missing kconfig
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=765454&state=*&archive=both
      - Not related to MPTCP, issue with b4 when sending the patch, we
can archive it → Done

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
      - Sent yesterday, normal it is in this state


13317405: [RFC,bpf-next,v5] bpf: Force to MPTCP:
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/3076188eb88cca9151a2d12b50ba1e870b11ce09.1689693294.git.geliang.tang@suse.com/

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

13203764: [RFC,mptcp-net-next,1/5] tools: ynl: add uns-admin-perm to
genetlink legacy
13203766: [RFC,mptcp-net-next,2/5] tools: ynl: fix bug in case of
multiple nested attributes of the same type
13203768: [RFC,mptcp-net-next,4/5] mptcp: uapi: add header files
generated from YAML spec
13203769: [RFC,mptcp-net-next,5/5] net/mptcp: use netlink policy
generated from YAML spec:
      - State: Changes requested
      - Series: YAML template for MPTCP netlink API
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=737723&state=*&archive=both
13294657: [RFC,mptcp-next,v2] mptcp: convert netlink from small_ops to ops:
      - State: Needs ack
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/ed9c7f0320bb94a4a147d11c447cefa59f128ee1.1687877390.git.dcaratti@redhat.com/
13301320: [RFC,mptcp-next,v2] Documentation: netlink: add a YAML spec
for mptcp:
      - State: Needs ack
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/d462c557c05d60a217f14ff77cd9702ed3ccf2c5.1688481634.git.dcaratti@redhat.com/
      - New version is expected
      - Matth: TODO: mark all as superseded → done

13290474: [net,1/2] selftests: mptcp: join: fix 'delete and re-add' test
13290475: [net,2/2] selftests: mptcp: join: fix 'implicit EP' test:
      - State: Changes requested
      - Series: selftests: fix mptcp_join test
      - Submitter: Andrea Claudi
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=759793&state=*&archive=both
      - A new version is expected

13294008: [iperf3] add MPTCPv1 support:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/
      - Geliang will open a new PR later

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
      - Matth will send a v2 addressing Paolo's comments

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
      - State: New
      - Series: BPF packet scheduler updates part 2
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=766762&state=*&archive=both
      - Addressing Mat's comments, I guess Mat will look at the v2



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 418):

  419  selftests: `mptcp_connect.sh`: disconnect: MPTCP → TCP:
Unexpected revents: `POLLERR/POLLNVAL(19)` [bug] [selftests]:
      - Not easy to reproduce
      - Matth can do reproduce it but still it is unreliable
      - this technique can be used to get more debug info but not to do
a git bisect


    Bugs (opened, flagged as "bug" and assigned)

  417  Verifier blocks access to tcp_sock fields [bug] [bpf] @geliangtang

  400  packetdrill: data are retransmitted after the `close()` [bug]
[packetdrill] @matttbe:
      - due to 9p

  290  Not possible to `connect()` after a disconnect for a passive
socket [bug] @pabeni


    Bugs (opened and flagged as "bug" and not assigned)

  419  selftests: `mptcp_connect.sh`: disconnect: MPTCP → TCP:
Unexpected revents: `POLLERR/POLLNVAL(19)` [bug] [selftests]
  416  No new subflow when removing an endpoint and adding a new one [bug]

  398  syzkaller: memory leak in `subflow_ulp_init` [bug] [syzkaller]:
      - *Christoph* will draft an email and share it
      - Then send it to people behind KMemleak project but not clear who
is in charge

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

  353  sockopt: uniform code to get/set values [enhancement] @matttbe
      - see patches above

  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang
      - see patches above

  340  netlink: switch to YAML Netlink specs [enhancement] @dcaratti
      - see patches above

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
      - see patches above

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   79  allow 'force to MPTCP' mode: BPF [enhancement] @geliangtang:
      - see patches above

   75  BPF: packet scheduler [enhancement] [sched] @geliangtang
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


    Recently closed (since 2023-07-11)

  418  Packet scheduler , Path Manager and Congestion Control [question]
  413  Question: Transport Converters for non-MPTCP end devices [question]
  395  If MPTCP primary flow is over tun interface, no subflow gets
created [question]
  392  Problem attempting to use all my interfaces (subflows)  [question]
  381  Why does total throughput increase when the delay on one of the
paths increases? [question] @matttbe



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.6):
https://github.com/orgs/multipath-tcp/projects/4/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1



Patches to send to netdev:

    - Fixes for other trees:

        - [7e05691bbf1c] Revert "Merge tag '9p-6.4-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs" (Matthieu
Baerts):
            - for 9p bug

    - Fixes for -net:

        - [3cee9018e659] selftests: mptcp: join: only check for
ip6tables if needed (Matthieu Baerts)
        - [3d9ee5ecd412] mptcp: more accurate NL event generation (Paolo
Abeni):
            - can be sent but fine to wait a bit (a bit of congestion on
netdev side)

    - Fixes for net-next: /

    - Features for net-next:

        - [5577bbc609a1] selftests: mptcp: connect: don't stop if error
(Matthieu Baerts)
        - [64e49d26e559] selftests: mptcp: userspace pm: don't stop if
error (Matthieu Baerts)
        - [3b9c7d8e4b49] selftests: mptcp: userspace_pm: fix shellcheck
warnings (Matthieu Baerts)
        - [47f58abc1dd8] selftests: mptcp: userspace_pm: uniform results
printing (Matthieu Baerts)
        - [83a058d8b0e6] selftests: mptcp: userspace_pm: reduce dup code
around printf (Matthieu Baerts)
        - [38fc9c86524f] selftests: mptcp: lib: format subtests results
in TAP (Matthieu Baerts)
        - [7f0c3ea19f2b] selftests: mptcp: connect: format subtests
results in TAP (Matthieu Baerts)
        - [0684c4d68b28] selftests: mptcp: pm_netlink: format subtests
results in TAP (Matthieu Baerts)
        - [b4f39da7a43a] selftests: mptcp: join: format subtests results
in TAP (Matthieu Baerts)
        - [0e229baf119f] selftests: mptcp: diag: format subtests results
in TAP (Matthieu Baerts)
        - [a5051f403857] selftests: mptcp: simult flows: format subtests
results in TAP (Matthieu Baerts)
        - [ef88dad6c8c3] selftests: mptcp: sockopt: format subtests
results in TAP (Matthieu Baerts)
        - [335e7a640953] selftests: mptcp: userspace_pm: format subtests
results in TAP (Matthieu Baerts):
            - have been sent

        - [508e4f1bc600] selftests: mptcp: join: rework detailed report
(Matthieu Baerts)
        - [79d125531006] selftests: mptcp: join: colored results
(Matthieu Baerts)
        - [8c7faea0b84c] selftests: mptcp: pm_nl_ctl: always look for
errors (Matthieu Baerts)
        - [1fdf28c3b988] selftests: mptcp: userspace_pm: unmute
unexpected errors (Matthieu Baerts):
            - can be sent after the previous ones

        - [b23c8baf3c73] mptcp: avoid unneeded mptcp_token_destroy()
calls (Paolo Abeni)
        - [158ef8eb8851] mptcp: avoid additional __inet_stream_connect()
call (Paolo Abeni)
        - [9d79b0ba9dcd] mptcp: avoid subflow socket usage in
mptcp_get_port() (Paolo Abeni)
        - [a59d758498c7] net: factor out inet{,6}_bind_sk helpers (Paolo
Abeni)
        - [d1515f542bec] mptcp: mptcp: avoid additional indirection in
mptcp_bind() (Paolo Abeni)
        - [11979ffb88f0] net: factor out __inet_listen_sk() helper
(Paolo Abeni)
        - [925bfd07f6e4] mptcp: avoid additional indirection in
mptcp_listen() (Paolo Abeni)
        - [c3137a1ae313] mptcp: avoid additional indirection in
mptcp_poll() (Paolo Abeni)
        - [e2434d5f6fe5] mptcp: avoid unneeded indirection in
mptcp_stream_accept() (Paolo Abeni)
        - [1a3ce0f1ec0c] mptcp: avoid additional indirection in sockopt
(Paolo Abeni)
        - [f36092147fca] mptcp: avoid ssock usage in
mptcp_pm_nl_create_listen_socket() (Paolo Abeni)
        - [905cbb2a6809] mptcp: change the mpc check helper to return a
sk (Paolo Abeni)
        - [bc79e19d2c4a] mptcp: get rid of msk->subflow (Paolo Abeni):
            - can wait to have some feedback from syzkaller

    - Features for net-next (next): /

    - Features for other trees:

        - [1be746b10d62] mptcp: refactor push_pending logic (Geliang Tang)
        - [5a1cc37598de] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [d0227fa83da4] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [664a06f0d355] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [8238e78a7eb5] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [6e72b047d485] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [d5c5003b0b4e] mptcp: add sched_data helpers (Geliang Tang)
        - [99ceb0918aae] mptcp: add scheduler wrappers (Geliang Tang)
        - [dfc31fcdd134] mptcp: use get_send wrapper (Geliang Tang)
        - [824f6d5a8c9d] mptcp: use get_retrans wrapper (Geliang Tang)
        - [c69732301234] mptcp: register default scheduler (Geliang Tang)
        - [df6137e6f5ac] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [10f742ca8e00] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [db22bddc5b6b] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [1131e0c5d62e] selftests/bpf: use random netns name for mptcp
(Geliang Tang)
        - [3090894e1f47] selftests/bpf: add two mptcp netns helpers
(Geliang Tang)
        - [ed73b45ea66b] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [7b336362cf31] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [bb6c25833250] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [cc754b07838d] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [34885d9e5c3e] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [924704901ce1] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [f4b31ef575cc] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [8913f28c4bca] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [aa7f3b27d913] selftests/bpf: Add bpf_red test (Geliang Tang):
            - status: same as last week: work ongoing + refactoring
needed on sched side
            - we will check to send some of them during this merge window



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - one new PR open:
            - https://github.com/multipath-tcp/packetdrill/pull/116
            - can be reviewed but not merged yet because the kernel
patches have not been applied yet

    - Patchew (Davide):
        - /

    - CI (Matth):
        - TODO: check the status on lkft side, especially regarding
mptcp_connect.sh
        - a few "rare" issues, already identified and tracked on github



MPTCP on RPi:
    - https://github.com/raspberrypi/linux/pull/5487
    - At least we have CONFIG_MPTCP on recent PI
    - But not CONFIG_MPTCP_IPV6 because CONFIG_IPV6=m and costly (in
term of RAM utilisation) to have it inline
    - (but likely the IPV6 module will be loaded anyway)



Next meeting:
    - Next one on Tuesday, the 25th of July.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230725



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
