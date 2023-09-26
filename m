Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E278107B3
	for <mptcp@lists.linux.dev>; Tue, 26 Sep 2023 10:55:29 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9936b3d0286so1066182366b.0
        for <mptcp@lists.linux.dev>; Tue, 26 Sep 2023 03:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1695725727; x=1696330527; darn=lists.linux.dev;
        h=content-transfer-encoding:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nEGFX42T5VvYcyodObRo+mx+mB/HmMXmAV4wtq/U/Q=;
        b=Q268C+kiASv+ss02xoLz5Z+iLyQvZgw/WPkv9JNhrPxC8bw+f1VUqvIcCPGosIFLKe
         cLsnFJxGb+yuPDxK0+aTx6yVLmLwudNJSdA3Bzs6xzMN0bwzWSAmKZAD2Ns0WasocEzj
         X6J6dabJjhOwW4dh70Ax/Ho/YigVVH9B15xl+22WaR8/twfPjAIJ/zF0z9iMxRxOqbFT
         3dqfS3ossQFnN1iwZh/ghVD20YXvL56d1EFbitngYiAZBs1lkanaftMWBcE9Xh0KDEZQ
         naD8aQCPEeQGua9lJmUYC/RxUszM6XN1iWE4bb2cGIgZe8g+zZ4Py1kN9Z1O8RWg8NJn
         HnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695725727; x=1696330527;
        h=content-transfer-encoding:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nEGFX42T5VvYcyodObRo+mx+mB/HmMXmAV4wtq/U/Q=;
        b=FyKkUknjPbCYI1sawkqV0CNgr1xhKUzc852i/Jo5q6Ak6G2p00Taz4NWyFu/wnprWE
         57IeZqYYTrl4OHPYthZ8C6UXRMXwlWnX4bDgKaL5g8yyGPf7HAzH5vFgnGrIXwFbOrFZ
         Je2auRnp5w+QTr3nuHex5jJy8EAl/JRC644oQd3NS5i88TQy/bd69kdd4mUzO0WYtgiB
         ycBDbPdj5l/AXbqkE5gtYA3sjo+wJxKMle1pAIxlqebRdjgS7F0U9+b+fff/ss4Y3LW6
         rCridzIx84UVMbpHEAsUBcdyLdZcvSy94m1+6KobrVBiK+LgqHtr1LaGB4mYXiaEHJ4g
         2Zlw==
X-Gm-Message-State: AOJu0YydhyhPP5xSBByTzWtM2CY7zEYuZp615COx22lBsIk6Vq6crcnz
	PU3miQjiGNvacyojntUUuBLBSYrobXDdz8dDr8Li76JA
X-Google-Smtp-Source: AGHT+IHlQibiknxQM7NHuzhdMSuJ/sl9pGF+3z+2uM8szGk0/K17zVXhkrj0q1yDC6rYNZHQSmvCkA==
X-Received: by 2002:a17:906:cc0c:b0:9af:4561:591d with SMTP id ml12-20020a170906cc0c00b009af4561591dmr8673576ejb.18.1695725727050;
        Tue, 26 Sep 2023 03:55:27 -0700 (PDT)
Received: from [100.65.141.57] ([149.36.51.146])
        by smtp.gmail.com with ESMTPSA id z15-20020a170906944f00b00993928e4d1bsm7592018ejx.24.2023.09.26.03.55.26
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 03:55:26 -0700 (PDT)
Message-ID: <cfe429a6-3634-4d47-b60e-5e051b9e921b@tessares.net>
Date: Tue, 26 Sep 2023 12:55:26 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 12th of September 2023
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

A few weeks ago, we had our 256th meeting with Christoph (Apple), Paolo,
Davide (Redhat), Mat (Cruise) and myself (Tessares).


Thanks again for this new good meeting (and sorry for the delay)!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Paolo Abeni):

13357448: [mptcp-next,v3,1/5] Squash to "selftests/bpf: Add bpf_bkup
scheduler"
13357449: [mptcp-next,v3,2/5] Squash to "selftests/bpf: Add bpf_rr
scheduler"
13357450: [mptcp-next,v3,3/5] Squash to "selftests/bpf: Add bpf_burst
scheduler"

13375370: [mptcp-net,v5,1/2] mptcp: rename timer related helper to less
confusing names
13375371: [mptcp-net,v5,2/2] mptcp: fix dangling connection hang-up:
      - Series: mptcp: fix another close hang-up
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=781903&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Luis Chamberlain):

13369556: [GIT,PULL] sysctl changes for v6.6-rc1:
      - Submitter: Luis Chamberlain
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/ZO5Yx5JFogGi/cBo@bombadil.infradead.org/


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
      - Status: same as at the last meeting

13294008: [iperf3] add MPTCPv1 support:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com/
      - Status: same as at the last meeting

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
      - Status: same as at the last meeting

13357451: [mptcp-next,v3,4/5] selftests/bpf: Add bpf_stale scheduler
13357452: [mptcp-next,v3,5/5] selftests/bpf: Add bpf_stale test:
13362024: [mptcp-next,v2] Squash to "selftests/bpf: Add bpf_stale
scheduler, v3":
      - State: Changes requested
      - Series: add bpf_stale scheduler
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=777313&state=*&archive=both
      - It looks like we don't need them: what was interesting has been
put in other bpf tests
      - Regarding the 'stale' feature, we need to have some refactoring
on the sched API side.

13367522: [mptcp-next,v7,1/7] selftests: mptcp: add evts_get_info helper
13367523: [mptcp-next,v7,2/7] selftests: mptcp: update userspace pm test
helpers
13367524: [mptcp-next,v7,3/7] selftests: mptcp: userspace pm remove id 0
subflow
13367525: [mptcp-next,v7,4/7] mptcp: userspace pm allow creating id 0
subflow
13367526: [mptcp-next,v7,5/7] selftests: mptcp: userspace pm create id 0
subflow
13367527: [mptcp-next,v7,6/7] mptcp: userspace pm remove id 0 address
13367528: [mptcp-next,v7,7/7] selftests: mptcp: userspace pm remove id 0
address:
13368779: [mptcp-next] Squash to "selftests: mptcp: update userspace pm
test helpers, v7":
      - State: Needs ack
      - Series: userspace pm remove id 0 subflow & address
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=779802&state=*&archive=both
      - Matth will try to look at that.

13373652: [mptcp-next,v3,1/9] Squash to "bpf: Export more bpf_burst
related functions"
13373653: [mptcp-next,v3,2/9] Squash to "mptcp: add sched_data helpers"
13373654: [mptcp-next,v3,3/9] Squash to "bpf: Add bpf_mptcp_sched_ops"
13373655: [mptcp-next,v3,4/9] Squash to "selftests/bpf: Add mptcp sched
structs"
13373656: [mptcp-next,v3,5/9] Squash to "selftests/bpf: Add bpf_first
scheduler"
13373657: [mptcp-next,v3,6/9] Squash to "selftests/bpf: Add bpf_bkup
scheduler"
13373658: [mptcp-next,v3,7/9] Squash to "selftests/bpf: Add bpf_rr
scheduler"
13373659: [mptcp-next,v3,8/9] Squash to "selftests/bpf: Add bpf_red
scheduler"
13373660: [mptcp-next,v3,9/9] Squash to "selftests/bpf: Add bpf_burst
scheduler":
      - State: New
      - Series: BPF packet scheduler updates part 4
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=781468&state=*&archive=both
      - Mat will look at that

13374479: [mptcp-next,v3,1/6] tools: ynl: add uns-admin-perm to
genetlink legacy
13374483: [mptcp-next,v3,2/6] net: mptcp: convert netlink from small_ops
to ops
13374482: [mptcp-next,v3,3/6] Documentation: netlink: add a YAML spec
for mptcp
13374481: [mptcp-next,v3,4/6] uapi: mptcp: use header file generated
from YAML spec
13374484: [mptcp-next,v3,5/6] net: mptcp: rename netlink handlers to
mptcp_pm_nl_<blah>_{doit,dumpit}
13374485: [mptcp-next,v3,6/6] net: mptcp: use policy generated by YAML spec:
      - State: New
      - Series: mptcp: convert netlink code to use YAML spec
      - Submitter: Davide Caratti
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=781665&state=*&archive=both
      - @Paolo: are you able to look at that?

13379155: [mptcp-next,v3] mptcp: add a new sysctl for make after break
timeout:
      - State: New
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/fe8c2c5502b7a924bdcba6621486e1e68861f9fd.1694426964.git.pabeni@redhat.com/
      - Addressing comments from Mat
      - Mat will look at it (done)





Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 432):

  438  syzkaller: possible deadlock in `sk_clone_lock` [bug] [syzkaller]:
      - quite strange: splat is confusing
      - maybe a side effect of a previous memory corruption
      - we "hope" it is a bug elsewhere corrupting lockdeps meta-data
      - KASAN was not enabled so that's maybe why the corruption happened
      - it only happened once
      - TODO: add recap on the ticket → Done

  437  mptcp vs tcp performance over long fat networks [bug]:
      - some issues with low latency settings and tcp_notsent_lowat
      - BBR seems not to run well with tcp_notsent_lowat
      - still needed to address the low latency issues
      - if needed, we can create "sub-issues"

  436  Supports redundant backup transmission of multiple subflows
[question] [sched]:
      - convert to "new feature" (even if there is maybe not a lot of
interest to have that with MPTCP, to be studied)

  435  in-kernel PM: fullmesh: too many paths are being created [bug]
@matttbe:
      - linked to a discussion we had at the last meeting

  434  in-kernel PM: increase subflows limit [pm] @matttbe:
      - linked to a discussion we had at the last meeting
      - with the future BPF packet schedulers, we will have arrays with
the number of subflows, we cannot have a too high number → to be checked
later, maybe fine to have a limit of ~16 subflows when using the BPF
packet sched.


    Bugs (opened, flagged as "bug" and assigned)

  435  in-kernel PM: fullmesh: too many paths are being created [bug]
@matttbe:
      - see above

  391  PM: userspace: unable to create additional subflows with the
local addr ID 0 [bug] [pm] @geliangtang:
      - see patches above

  379  userspace pm: ability to send `RM_ADDR` for all local IDs used (0
included) [bug] [pm] @geliangtang:
      - see patches above


    Bugs (opened and flagged as "bug" and not assigned)

  438  syzkaller: possible deadlock in `sk_clone_lock` [bug] [syzkaller]
      - see above

  437  mptcp vs tcp performance over long fat networks [bug]
      - see above

  420  syzkaller: WARNING in `__mptcp_move_skbs_from_subflow` [bug]
[syzkaller]:
      - hard to reproduce but real

  416  No new subflow when removing an endpoint and adding a new one [bug]
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched]
  336  Issues with BPF packet scheduler [bug] [sched] [bpf]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose
server test` are sometimes failing [bug] [selftests]
  318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
cookies [bug] [selftests]
  315  Issues with backup flow [bug]


    In Progress (opened, new feature and assigned)

  432  Rename `mptcp_is_tcpsk()` helper [enhancement] @dcaratti
  403  userspace pm: local_addr_list: use a refcount per entry
[enhancement] [pm] @geliangtang
  353  sockopt: uniform code to get/set values [enhancement] @matttbe
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang
  340  netlink: switch to YAML Netlink specs [enhancement] @dcaratti
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang
   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang


    Assigned Questions (opened, questions and assigned)

None.


    Open questions (opened, questions and not assigned)

  436  Supports redundant backup transmission of multiple subflows
[question] [sched]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned assigned)

  428  `mptcp_info`: expose if the initial subflow has been removed /
total number of subflows [enhancement]
  426  selftests: validate listener sockets with multiple accepts
[enhancement] [selftests]
  425  syzkaller: validate all MPTCP Netlink API [enhancement] [syzkaller]
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
[enhancement] [pm]
  335  Server to Client subflows: option to allow joining the initial
address and port [enhancement] [pm]
  334  PM: in-kernel: send >1 ADD_ADDR before the establishment of a new
subflow [enhancement] [pm]
  333  New MIBs to help understanding issues when PM cannot create new
subflows [enhancement] [pm]
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
   76  [gs]etsockopt per subflow: BPF [enhancement] [bpf]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 20230829)

  433  `BUG: KASAN: slab-use-after-free in kernfs_test_super
(fs/kernfs/mount.c:286)` [bug] [invalid]
  431  new mptcp connections stuck in SYN-SENT [bug] @pabeni
  430  MPTCP connections are hanging when all subflows have been closed
by timeout [bug] @pabeni
  429  Missing close transition [bug] @pabeni
  427  connections hanging after a long transfer [bug] @pabeni
  424  KMemLeak around `__register_sysctl_table` [bug]
  413  Question: Transport Converters for non-MPTCP end devices [question]
  398  syzkaller: memory leak in `subflow_ulp_init` [bug] [syzkaller]
  247  see mptcp options when running iperf locally [question]
   79  allow 'force to MPTCP' mode: BPF [enhancement] [bpf] @geliangtang



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.7):
https://github.com/orgs/multipath-tcp/projects/5
    - For later: https://github.com/orgs/multipath-tcp/projects/1
    - TODO: Changelog + project → Done



Patches to send to netdev:

    - Fixes for other trees:

        - [b5179c16c60d] workqueue: Remove duplicate worqueue attributes
allocation (Catalin Marinas)
        - [c13bc02d2f67] rcu: kmemleak: Ignore kmemleak false positives
when RCU-freeing objects (Catalin Marinas)

    - Fixes for -net:

        - [53459fb597b3] mptcp: fix bogus receive window shrinkage with
multiple subflows (Paolo Abeni)
        - [5236635ab2b2] mptcp: move __mptcp_error_report in protocol.c
(Paolo Abeni)
        - [df123dcc20bd] mptcp: process pending subflow error on close
(Paolo Abeni)
        - [5a3f7f307975] mptcp: rename timer related helper to less
confusing names (Paolo Abeni)
        - [d2142e17790d] mptcp: fix dangling connection hang-up (Paolo
Abeni):
            - Can be sent on Friday or Monday
            - TODO: Matth → Done

    - Fixes for net-next: /

    - Features for net-next: /

    - Features for net-next (next): /

    - Features for other trees:

        - [be876585fa2c] mptcp: add sched_data helpers (Geliang Tang)
        - [60ff69197178] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [8b5601c1f98e] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [9cdcfbb702c6] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [35d0bce2cade] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [1a64fc9c5e7a] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [76a2cff76f4b] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [ff8025a4ad0e] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [85db5ee13f22] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [26cc3a316771] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [2d43ea5f7745] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [efed5b9d41ad] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [32d0db419b43] selftests/bpf: Add bpf_red test (Geliang Tang)
        - [311e339c1de7] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [63079d14925b] selftests/bpf: Add bpf_burst scheduler (Geliang
Tang)
        - [2a86c323a520] selftests/bpf: Add bpf_burst test (Geliang Tang):
            - waiting for a refactoring of the sched API



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - https://github.com/multipath-tcp/packetdrill/pull/116 →
waiting for a kernel patch
        - https://github.com/multipath-tcp/packetdrill/pull/117 → merged
        - https://github.com/multipath-tcp/packetdrill/pull/118 →
waiting for a kernel patch

    - Patchew (Davide):
        - /

    - CI (Matth):
        - reduce usage:
            - number of cores: 4 → 2
            - detect issues to boot (not after a 1h timeout)
            - running 2 times a week instead of everyday.
        - we frequently have: "packet is not for expected socket":
            - maybe we can retry?
            - it looks like we cannot easily tweak packetdrill to avoid
such issues: limitation of packetdrill with MPTCP: packet matched
against the socket immediately
            - TODO retry? ↑ maybe?
            - also, maybe it might be due to the test itself and we
could find workaround to avoid having packets being sent almost at the
same time by adding latency, etc. → TODO Matth: identify tests which
regularly fail and check with Christoph → "Done": reducing the number of
tests running in // helped.


Matth's email address:
    - Matth will start using his @kernel.org address like most of the
other maintainers, a bit short than the current one and easier to split
Upstream vs other work.



Next meeting:
    - /!\ We skip the one of next week (5th of September) /!\
    - Next one on Tuesday, the 12th of September.
    - 15:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230912



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
