Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E003209
	for <mptcp@lists.linux.dev>; Wed, 11 Jan 2023 16:36:57 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id tz12so38251191ejc.9
        for <mptcp@lists.linux.dev>; Wed, 11 Jan 2023 08:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzyiUrPOjskblpQhoVXeWn4IHMID41WywTdI71T7moY=;
        b=kph62yehZ2M0UhT3tFvcNkengqXuFC+aEn/SKzi5vZJqpdHD62TjGAJ7j5mnuUj/4x
         5J11OMwGnC5zjK+Upxd+6TPpYvM7QggWT6CM1ekGWVdzc90UvXThLb/He5yTa3ymOsFQ
         ek4f+7lTMbp0h4eZAc5cfdqlTfX2NwxfbRwKBA8Gwmu40xUAflpqgb2t1lUvmX0EMF9I
         0VnJ4bpKwIBUPvgpF0fo30LVQSCBUaC8n8iv5Q4AuldeSAFb4mr67Ru9ga3aBAGaMDxx
         cUW0w4drQjy805I5uzpTmBG5TcMVMk3kyutStyCUChaZpHi0MqXkdrK0uqgE9HRnopZ5
         YN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UzyiUrPOjskblpQhoVXeWn4IHMID41WywTdI71T7moY=;
        b=ILGJDWNYw6yogfMAkOq3yLQ6UBb8Zense8RSMLEb5qybOl/D/AguTtdtGD40QPlscV
         Ljd5i+vuREdukiQl84i8VE74rANJ+uCAYc9yCZO8e16XLtDjeeQZDLKvjxF9Ynv0cVx/
         wYrJurCIodVxOHxj5S8pRJIGbkIbcIyWuLKB0ZAnDICdAo2RwzJ6JS3GmnSbm5YeRHke
         OnRSKfc58xt9Ac9l9rcI0fO5bLRtLA4kzjy89Dvw7K2W24685X8R5OGiM1d29iQCVQSp
         bv9cRqVwOEkLyLJTfXzgbRGRjD6w3ogx+3lLs+rQqS7P1nLK/8SEmQfdHwnrYGRK1WQr
         qjLg==
X-Gm-Message-State: AFqh2kqK5r2oo1xXWsOsRzQiFmDrk0cGSKxZkfKNLqzEUcKwXLgEjV+/
	KVEP+vskUwZx4ifrTZ7HPzdhoHgfe3X44QwPEoU=
X-Google-Smtp-Source: AMrXdXvMT2z/tPe8iej3V1dO7uRn2w2ICJBggg16CbZ0UNR/JKQcPoG/Fvb3ShoGmvTzTqjjvitECA==
X-Received: by 2002:a17:907:180c:b0:83d:61f8:3c with SMTP id lg12-20020a170907180c00b0083d61f8003cmr64699517ejc.3.1673455015657;
        Wed, 11 Jan 2023 08:36:55 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:2022:e1d1:1d3d:1feb? ([2a02:578:8593:1200:2022:e1d1:1d3d:1feb])
        by smtp.gmail.com with ESMTPSA id bg14-20020a170906a04e00b007c094d31f35sm6425651ejb.76.2023.01.11.08.36.55
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 08:36:55 -0800 (PST)
Message-ID: <42ad52b9-1eab-dbdc-5d89-06bf3713b9fd@tessares.net>
Date: Wed, 11 Jan 2023 17:36:54 +0100
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
Subject: [Weekly meetings] MoM - 10th of January 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Yesterday, we had our 224th meeting with Mat, Ossama (Intel), Paolo,
Davide (Red Hat) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

13089223: Patch "mptcp: remove MPTCP 'ifdef' in TCP SYN cookies" has
been added to the 5.15-stable tree (fwd):
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/83ca6b33-db3f-3c38-ea63-05db4e18d265@linux.intel.com/

13091709: [net-next,1/9] mptcp: use msk_owned_by_me helper
13091710: [net-next,2/9] mptcp: use net instead of sock_net
13091711: [net-next,3/9] mptcp: use local variable ssk in write_options
13091712: [net-next,4/9] mptcp: introduce 'sk' to replace 'sock->sk' in
mptcp_listen()
13091713: [net-next,5/9] mptcp: init sk->sk_prot in build_msk()
13091716: [net-next,6/9] mptcp: rename 'sk' to 'ssk' in
mptcp_token_new_connect()
13091715: [net-next,7/9] mptcp: add statistics for mptcp socket in use
13091714: [net-next,8/9] selftest: mptcp: exit from copyfd_io_poll()
when receive SIGUSR1
13091717: [net-next,9/9] selftest: mptcp: add test for mptcp socket in use:
      - Series: mptcp: Protocol in-use tracking and code cleanup
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=709627&state=*&archive=both

13091938: [5.15,1/2] mptcp: dedicated request sock for subflow in v6
13091939: [5.15,2/2] mptcp: use proper req destructor for IPv6:
      - Series: mptcp: use proper req destructor for IPv6
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=709694&state=*&archive=both


    our repo (by: Matthieu Baerts):

13088789: [mptcp-net,v5,01/12] mptcp: explicitly specify sock family at
subflow creation time
13088790: [mptcp-net,v5,02/12] mptcp: netlink: respect v4/v6-only sockets
13088796: [mptcp-net,v5,03/12] selftests: mptcp: userspace: validate
v4-v6 subflows mix
13088791: [mptcp-next,v5,04/12] mptcp: let the in-kernel PM use mixed
IPv4 and IPv6 addresses
13088792: [mptcp-next,v5,05/12] mptcp: propagate sk_ipv6only to subflows
13088793: [mptcp-next,v5,06/12] selftests: mptcp: add test-cases for
mixed v4/v6 subflows
13088794: [mptcp-next,v5,07/12] mptcp: remove assigned but unused value
13088795: [mptcp-next,v5,08/12] mptcp: userspace pm: use a single point
of exit
13088797: [mptcp-next,v5,09/12] selftests: mptcp: userspace: print titles
13088800: [mptcp-next,v5,10/12] selftests: mptcp: userspace: refactor
asserts
13088799: [mptcp-next,v5,11/12] selftests: mptcp: userspace: print error
details if any
13088798: [mptcp-next,v5,12/12] selftests: mptcp: userspace: avoid read
errors:
      - Series: mptcp: add support for mixed v4/v6
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=708864&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Mat Martineau, Matthieu Baerts):

13091949: [5.10,1/4] mptcp: mark ops structures as ro_after_init
13091950: [5.10,2/4] mptcp: remove MPTCP 'ifdef' in TCP SYN cookies
13091951: [5.10,3/4] mptcp: dedicated request sock for subflow in v6
13091952: [5.10,4/4] mptcp: use proper req destructor for IPv6:
      - Series: mptcp: Stable backports for MPTCP request sock fixes
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=709701&state=*&archive=both
      - Pending on stable mailing list

13095307: [iproute2] mptcp: add new listener events:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230110-mptcp-events-listener-net-v1-1-88a946722fe7@tessares.net/


    our repo (by: Geliang Tang, Jiapeng Chong, Matthieu Baerts, Paolo
Abeni, Shigeru Yoshida):

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
      - Status: same as last week

13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
      - State: Changes requested
      - Series: BPF redundant scheduler, part 3
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
      - Status: same as last week
      - Matth will work on listing what is needed for the Scheduler API
this week, starting from UC → TODO

13076926: [v2,1/2] security, lsm: Introduce security_mptcp_add_subflow()
13076927: [v2,2/2] selinux: Implement mptcp_add_subflow hook:
      - State: Changes requested
      - Series: lsm: introduce and use security_mptcp_add_subflow()
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=705673&state=*&archive=both
      - v3 is needed but quite a bit of changes are needed:
          - plan is now to have a one liner fix in MPTCP for the moment
          - in //, do some refactoring in MPTCP side to better support
LSM (but also maybe fix other issues)
          - this will probably require 2 versions: one for the
modification in LSM and one for the modification in netdev (MPTCP)

13090433: mptcp: Fix deadlock in mptcp_sendmsg():
      - State: Rejected
      - Series: mptcp: Fix deadlock in mptcp_sendmsg()
      - Submitter: Shigeru Yoshida
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=709270&state=*&archive=both




Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 332):

/


    Bugs (opened, flagged as "bug" and assigned)

  329  PM: userspace: update `MPTCP_INFO` fields [bug] @geliangtang

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni:
      - See patches above


    Bugs (opened and flagged as "bug" and not assigned)

  331  MPTCP in multihoming doesn't announce all endpoints [bug]:
      - Some MIBs are missing, best to track that in a separate issue:
TODO Matth → Done: #333
      - regarding join v0, it might be good to have a different
behaviour for the client and server side:
          - net.mptcp.allow_join_initial_addr_port: current situation,
one sysctl
          - idea would be:
              - net.mptcp.allow_join_initial_addr_port = 0: always disable
              - net.mptcp.allow_join_initial_addr_port = 1: only for the
server side
              - net.mptcp.allow_join_initial_addr_port = 2: allow v0 for
the client side
              - or a bit field if we need to have accept for both
server/client (if it makes sense)
          - update/new ticket: TODO → Done: #335
      - a third request from this ticket:
          - being able to announce all addresses and not announcing more
addresses after the establishment of new subflows
          - the PM could announce new addresses once previous ones have
been echoed
          - TODO: maybe clearer with a dedicated ticket for that as well
→ Done: #334

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

  330  `MPTCP_INFO`: document and support `mptcpi_subflows` for the
server side [enhancement] @geliangtang
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang:
       - See patches above

   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

  307  TCP performance better than MPTCP [question] @matttbe


    Open questions (opened, questions and not assigned)

  326  Issue with streaming traffic with MPTCP upstream implementation
[question]


    For later (opened and not assigned assigned)

  332  scheduler: implement a "opportunistic retransmission" [enhancement]
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


    Recently closed (since 2023-01-03)

  269  Allow having a mix of v4/v6 subflows for the same socket
[enhancement] @pabeni



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.3):
https://github.com/multipath-tcp/mptcp_net-next/projects/18
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [a0d92ca6e90d] mptcp: explicitly specify sock family at
subflow creation time (Paolo Abeni)
        - [d395829ddaf2] mptcp: netlink: respect v4/v6-only sockets
(Matthieu Baerts)
        - [1cb055f0ed75] selftests: mptcp: userspace: validate v4-v6
subflows mix (Matthieu Baerts):
            - just been applied, can wait a bit more:
                - Matth can do that on Thursday/Friday: TODO

    - Fixes for net-next: /

    - Features for net-next:

        - [39413461e6de] mptcp: let the in-kernel PM use mixed IPv4 and
IPv6 addresses (Paolo Abeni)
        - [0cd443733fac] mptcp: propagate sk_ipv6only to subflows
(Matthieu Baerts)
        - [e5c81625bddb] selftests: mptcp: add test-cases for mixed
v4/v6 subflows (Paolo Abeni)
        - [2fa579f47744] mptcp: userspace pm: use a single point of exit
(Matthieu Baerts)
        - [297487f0434e] selftests: mptcp: userspace: print titles
(Matthieu Baerts)
        - [dec07c39fef4] selftests: mptcp: userspace: refactor asserts
(Matthieu Baerts)
        - [439339099fa3] selftests: mptcp: userspace: print error
details if any (Matthieu Baerts)
        - [a9c3724f9cf3] selftests: mptcp: userspace: avoid read errors
(Matthieu Baerts):
            - just been applied, can wait a bit more:
                - they depend on the ones for -net, we need to wait one
more week

    - Features for net-next (next): /

    - Features for other trees:

        - [f0bcebe79baa] mptcp: refactor push_pending logic (Geliang Tang)
        - [6c4731b3a8f3] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [406e65c13501] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [d93b1cf1438e] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [a76053524cce] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [d89bd217562e] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [3fc6d694e1c7] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [3309803203e9] mptcp: add scheduler wrappers (Geliang Tang)
        - [6a5a1cd758e8] mptcp: use get_send wrapper (Geliang Tang)
        - [1013d96c2dbb] mptcp: use get_retrans wrapper (Geliang Tang)
        - [0af6382a7b19] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [2b1b5c46796a] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [5216f7e67e8b] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [072f8f686031] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [912cd0bc4d9d] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [a81cde7af149] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [f51555b8e702] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [1a31dac74ecc] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [08a6d3467054] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [347dd1681073] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [a8057a47bf7c] selftests/bpf: Add bpf_red test (Geliang Tang):
            - status: same as last week: waiting for discussions around
the scheduler API



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - Anything related to MPTCP

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - some progress on the automation part but still some issues
(not related to MPTCP)

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - still working well

    - CI (Matth):
        - now the builds with a debug kernel config are OK: more RAM
were needed for the compilation phase.
        - Still some instabilities, to be re-listed



Next meeting:
    - Next one on *Tuesday*, the 17th of January.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230117



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
