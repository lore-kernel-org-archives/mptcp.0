Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377A1A93E
	for <mptcp@lists.linux.dev>; Thu, 19 Jan 2023 17:37:07 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id g10so2146359wmo.1
        for <mptcp@lists.linux.dev>; Thu, 19 Jan 2023 09:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmF0uL+E1Fl8L5i+5RMVcmz/jkqnUP6xcLcAtuVahsQ=;
        b=poSrpT5tZETCuj98jNd4yODp1o7GjKX0AMV/VnA4YZHolDrJB7PoQgvrAiVQVrq8J8
         aIDkMgmNYCxfyQ8v7DgxKikNo50qV+VorPnRMBBlyp8KOV4WxKxOluqCoVvUFy4pt8gJ
         vD4ddK8TKO05o0qCdsjfhAgNZ1Q94DSMJiw37QmWiVp5LpInvsDkGV3r53Xh/Sj7TbHR
         IDklYoM6lhmmdE2AYYlFryPFps3VZjAsjnXVOttH5JBoqZSn89WMB31fgtWJnn0JCqEo
         P69f3K3b571Zkn+YXVXIA2f8bJ1EyjzDNEzLwINy44DCLNzK5eP5AXrQe+WIBw4R+zOA
         Ze6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QmF0uL+E1Fl8L5i+5RMVcmz/jkqnUP6xcLcAtuVahsQ=;
        b=YBXqaD/0vqnvO2DdPl8A6JdtAeHvOMVKj0tw7GArSGzJFnehp8+prjM2clV0D/hU8x
         KlVqnQIx0MG2ouqPnBMek8juqZHelDzkdF28Nh1ZLJCDMJBPRL3sBpAi3KCKaP4NEpB9
         4jfMR/C2U3qEEdVBNHefs9wonLCTQJo6tM92/QF8hTN1krrG2YWAJGGZ6OeeRhgaAA0p
         xfKwk4iVw37jJAXanGKn1GMWGVYFUMUcQ9WC6ynyERORy52nmxC//ghmcQIu+QxnJqmv
         t3GV4SAoEMAfFAbVibeBenSD8hSHV9WjeTH6NQJmpYxvDUFttPRiVLWDyQfEdhRi2RtK
         V9NA==
X-Gm-Message-State: AFqh2kq4C4D67LoxV6CX+JgHw4CAr+R/4XoecQ0YikPzLfRVr3ek74h/
	DUx2n9+ZEQ0DBq2lf53gtBE+jFmntcefTP9pynKiKA==
X-Google-Smtp-Source: AMrXdXuzA7/XaE1OCloD13jNyF5SRbSjxRrvKW28p1HL8U+XZS04FkJqyxRJwdRo4oHX8qDQJ1sV+w==
X-Received: by 2002:a05:600c:4f56:b0:3db:1f68:28f with SMTP id m22-20020a05600c4f5600b003db1f68028fmr3085775wmq.24.1674149825635;
        Thu, 19 Jan 2023 09:37:05 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:fc2:dd5c:57f9:31b1? ([2a02:578:8593:1200:fc2:dd5c:57f9:31b1])
        by smtp.gmail.com with ESMTPSA id hu29-20020a05600ca29d00b003db0f4e12c8sm4994769wmb.34.2023.01.19.09.37.05
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 09:37:05 -0800 (PST)
Message-ID: <aa034413-00cb-b26a-c115-acd157496cf8@tessares.net>
Date: Thu, 19 Jan 2023 18:37:04 +0100
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
Subject: [Weekly meetings] MoM - 17th of January 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Tuesday, we had our 225th meeting with Mat, Ossama (Intel),
Christoph (Apple), Paolo, Davide (Red Hat), Dmytro (?), Benjamin and
myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau, Matthieu Baerts):

13091949: [5.10,1/4] mptcp: mark ops structures as ro_after_init
13091950: [5.10,2/4] mptcp: remove MPTCP 'ifdef' in TCP SYN cookies
13091951: [5.10,3/4] mptcp: dedicated request sock for subflow in v6
13091952: [5.10,4/4] mptcp: use proper req destructor for IPv6:
      - Series: mptcp: Stable backports for MPTCP request sock fixes
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=709701&state=*&archive=both

13095307: [iproute2] mptcp: add new listener events:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230110-mptcp-events-listener-net-v1-1-88a946722fe7@tessares.net/

13098514: [net,1/3] mptcp: explicitly specify sock family at subflow
creation time
13098515: [net,2/3] mptcp: netlink: respect v4/v6-only sockets
13098516: [net,3/3] selftests: mptcp: userspace: validate v4-v6 subflows
mix:
      - Series: mptcp: userspace pm: create sockets for the right family
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=711419&state=*&archive=both


    our repo (by: /):

/



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
      - Status: same as last week

13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
      - State: Changes requested
      - Series: BPF redundant scheduler, part 3
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
      - Status: same as last week (see below for the discussions about
the sched API)

13100280: [mptcp-next,v2] mptcp: update userspace pm subflows info:
      - State: New
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/d262f6beb6899f0a79acbeb1d3c8c855e95e098a.1673599496.git.geliang.tang@suse.com/
      - To be reviewed

13104255: [mptcp-next,v2,01/13] mptcp: fix locking for setsockopt
corner-case
13104256: [mptcp-next,v2,02/13] mptcp: fix locking for in-kernel
listener creation.
13104257: [mptcp-next,v2,03/13] mptcp: refactor passive socket
initialization.
13104259: [mptcp-next,v2,04/13] mptcp: drop unneeded argument
13104260: [mptcp-next,v2,05/13] mptcp: drop legacy code.
13104258: [mptcp-next,v2,06/13] mptcp: avoid unneeded
__mptcp_nmpc_socket() usage
13104262: [mptcp-next,v2,07/13] mptcp: move fastopen subflow check
inside mptcp_sendmsg_fastopen()
13104261: [mptcp-next,v2,08/13] mptcp: move first subflow allocation at
mpc access time
13104263: [mptcp-next,v2,09/13] mptcp: do not keep around the first
subflow after disconnect.
13104264: [mptcp-next,v2,10/13] mptcp: fastclose msk when cleaning
unaccepted sockets
13104265: [mptcp-next,v2,11/13] mptcp: refactor mptcp_stream_accept()
13104266: [mptcp-next,v2,12/13] security, lsm: Introduce
security_mptcp_add_subflow()
13104267: [mptcp-next,v2,13/13] selinux: Implement mptcp_add_subflow hook:
      - State: New
      - Series: mptcp: refactor first subflow init
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=712638&state=*&archive=both
      - The two first patches can go to -net (the 2nd one is not really
relevant without the refactor but well)
      - the refactor is needed for the LSM fixes (the two last patches
which should not go to netdev)
      - patch 3/13 changes the behaviour at the accept time:
          - the first ADD_ADDR can be sent (because we are in fully
established)
          - https://github.com/multipath-tcp/packetdrill/pull/113c
      - The CI reported other issues with diag and simult_flows: under
investigation
      - if there are no big changes needed, the idea would be to apply
them to have feedback from syzkaller



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 332):

  337  tcp fallback with gstreamer tcp elements [question]:
      - we need more info
      - the additional subflow is not being established with one
application while it works with another one:
          - probably the server has closed the listening socket
          - → yes

  336  Issues with BPF packet scheduler [bug]:
      - some issue with bpf_rr and bpf_red
      - just there as a test but should be working
      - to be investigated
      - Maybe Geliang can have a look?

  335  Server to Client subflows: option to allow joining the initial
address and port [enhancement]
  334  PM: in-kernel: send >1 ADD_ADDR before the establishment of a new
subflow [enhancement]
  333  New MIBs to help understanding issues when PM cannot create new
subflows [enhancement]:
      - all related to ticket #331, discussed last week


    Bugs (opened, flagged as "bug" and assigned)

  329  PM: userspace: update `MPTCP_INFO` fields [bug] @geliangtang:
      - See patch above
      - Are there more fields from MPTCP_INFO to update with the
userspace pm?

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni:
      - see patches above


    Bugs (opened and flagged as "bug" and not assigned)

  336  Issues with BPF packet scheduler [bug]
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

  337  tcp fallback with gstreamer tcp elements [question]
  326  Issue with streaming traffic with MPTCP upstream implementation
[question]


    For later (opened and not assigned assigned)

  335  Server to Client subflows: option to allow joining the initial
address and port [enhancement]
  334  PM: in-kernel: send >1 ADD_ADDR before the establishment of a new
subflow [enhancement]
  333  New MIBs to help understanding issues when PM cannot create new
subflows [enhancement]
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


    Recently closed (since 2023-01-10)

  331  MPTCP in multihoming doesn't announce all endpoints [bug]



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

        - [b4dc4668634a] mptcp: let the in-kernel PM use mixed IPv4 and
IPv6 addresses (Paolo Abeni)
        - [c53dcd4af290] mptcp: propagate sk_ipv6only to subflows
(Matthieu Baerts)
        - [fd33135539b2] selftests: mptcp: add test-cases for mixed
v4/v6 subflows (Paolo Abeni)
        - [dd7d1b84c95d] mptcp: userspace pm: use a single point of exit
(Matthieu Baerts)
        - [285ee4b56f52] selftests: mptcp: userspace: print titles
(Matthieu Baerts)
        - [42bbcf53e0d0] selftests: mptcp: userspace: refactor asserts
(Matthieu Baerts)
        - [0ed2bffeb671] selftests: mptcp: userspace: print error
details if any (Matthieu Baerts)
        - [3e46483753a3] selftests: mptcp: userspace: avoid read errors
(Matthieu Baerts):
            - they depend on patches that are only in -net
            - Need to wait for the sync between the two, so to be sent
on Friday or later

    - Features for net-next (next): /

    - Features for other trees:

        - [04d521804815] mptcp: refactor push_pending logic (Geliang Tang)
        - [cb5209862183] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [74c8dc5009f8] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [d4912e23eb39] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [612bf72232c7] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [d57b7c9c7a64] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [433b2a02c64e] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [238ca776be77] mptcp: add scheduler wrappers (Geliang Tang)
        - [3e344e0aa05a] mptcp: use get_send wrapper (Geliang Tang)
        - [32b546801ee8] mptcp: use get_retrans wrapper (Geliang Tang)
        - [1e6134498cbd] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [f7318a6afa7c] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [df8e2999c579] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [384e14e27c7a] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [db412eacf5ad] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [a3e843c67874] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [fd314ff6360e] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [7ee013cd9438] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [43bdf6253f4d] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [db0930a81f71] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [3c85d1aebf5a] selftests/bpf: Add bpf_red test (Geliang Tang):
            - Status: same as the previous weeks: still work in progress



Scheduler API:
    - (Thanks to Tim Froidcoeur for his help to create this list!)

    - requirements:
        - Variables:
            - Access socket/TCP/MPTCP info:
                - e.g. tp->snd_cwnd, tp->snd_ssthresh,
tcp_packets_in_flight(), etc.
                - BPF: should be OK

            - Store additional info per msk or ssk:
                - e.g. timestamps (last opti, max/min rtt, etc.)
                - BPF: hashmap using the pointer as a key
                - note that the msk has some bytes in the structures
that are not used, e.g. the ones related to the CC:
                    - we could let write access to this area
                - we can also expend the subflow struct context size to
have some space per subflow:
                    - like the previous one: can be seen as an opti for
later

            - Update subflow info:
                - e.g. tp->snd_cwnd, tp->snd_ssthresh: opti rbuf
                - maybe not the best way to do that, see below


        - features:
            - limit the number of packets (or bytes?) to send:
                - motivation: don't waste all of the available receive
window on a single (bufferbloated?) flow (see below)
                - having an "overlay congestion control"?

            - force a reinjection:
                - equivalent of a fast retransmit: (see below)
                    - we need to be called quicker (RTO)
                - currently in the upstream kernel, the scheduler is
called when:
                    - the cwnd is being (re)opened
                    - new data are being pushed by the userspace

            - schedule probing:
                - for example, probe unused subflow to get rtt updates
(see below)
                - reinject just one packet (ideally the last one sent)
on a different subflow


    - examples of optimisations
        - mptcp_rcv_buf_optimization(): from mptcp.org:
            -
https://github.com/multipath-tcp/mptcp/blob/825b62d597b5b623a0cb9ad7490bf3701898f9d3/net/mptcp/mptcp_sched.c#L286-L362
            - it does two things:
                - penalization: Halve the cwnd of the slow flows (once
per RTT):
                    - looks like a hack: the CC will potentially reset
the modification quickly after
                    - maybe we need another kind of limitation: a max
number of "in-flight" packets
                    - see "overlay congestion control" below
                - retransmit without waiting:
                    - this could be handled by the core eventually

        - probing:
            - Use case: subflows flagged as "too bad to be used for the
moment" (e.g. too high RTT according to the scheduler):
                - it is then required to probe them from time to time
                - by reinjecting the last sent data on this specific subflow
                - (max one per RTT)
            - How to do that with the upstream API:
                - flag MPTCP_WORK_RTX / MPTCP_RETRANSMIT?, defer to a
specific subflow
                - but: we need to do that after having scheduled the
"fast" subflow: for something that has already been sent
                - and: we only want to reinject one packet, not the full
RTX queue and not something new:
                    - as a probe for example for rtt updates -> only one
packet in flight, only an already sent packet
                - idea: a new flag specific to the probing, handled by
the core?

        - "overlay congestion control":
            - limit the number of packets in flight
            - or in general: limit the number of packets/bytes to send
            - MPTCP has a view of all the different subflow, e.g.:
                - one subflow is "bad"
                - we are limited by the buffers
                - we have to use the limited resources the best way
                - etc.
            - need: additional limits/constraint, on top of TCP CC per
subflow
            - solution:
                - new way to tell the CC there are more stuff to take
into account (acceptable?)
                - or having new dedicated CC (not nice)
    
        - schedule when ACK (+ RTO) is received on another subflow:
            - In case of probing, we will receive the ACK after the fast
subflow
            - maybe no need to re-schedule but maybe needed to update
info, probe another one, etc.

        - backup: use subflow even if there are non-backup subflows
available:
            - and even if these non-backup subflows are not considered
as "staled" (linked to stale_loss_cnt)
            - some schedulers might decide to react faster than what the
core is currently doing with stale_loss_cnt (or responsibility of the core?)
            - some schedulers might use the backup flag to consider a
subflow as "lower priority"

    - conclusion
        - just selecting the next subflow is not enough
        - it seems important to have a way, from the scheduler side, to:
            - limit the number of packets (penalize some subflows:
"overlay congestion control")
            - force a reinjection (switch to a new subflow or probing)
            - make sure we are called when there are new info on MPTCP
and subflow level



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - one soft lockup in tcp orphan update, maybe not related to MPTCP
        - Mat will investigate

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - /

    - packetdrill (Davide):
        - new PR for kernel patches in review

    - Patchew (Davide):
        - /

    - CI (Matth):
        - /



Next meeting:
    - Next one on *Tuesday*, the 24th of January.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230124



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
