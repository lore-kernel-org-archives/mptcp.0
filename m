Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C2A18D
	for <mptcp@lists.linux.dev>; Thu, 10 Mar 2022 17:26:46 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id n31-20020a05600c3b9f00b003898fc06f1eso5926093wms.1
        for <mptcp@lists.linux.dev>; Thu, 10 Mar 2022 09:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from:to
         :subject:content-transfer-encoding;
        bh=ETP7beYmbqBBc7idaeeaatRzr0SkQXfy9dVXHazd4oY=;
        b=wbsGgx+vqA8vwoq6bGZ5I8fUW77KPNRUaex/bOBoqW6CUlrH9b3cTkzfREzMvL7zlR
         7tgyEc6/VwY+eVjIT47ygQab05tUgA+UURS8OswfYTPbpWh5PnTdwsld/ab1PB7SotGL
         1KsKMKN15iayNLmI4BaL5vpmZR6wz8f3Vo3Ly4Hool6lceiSOomcAxHQjVJLSR8p7lM+
         PFsMggLVG2BviDb9XIzlxp6xy5u+s8jsuNp9U4/qdpMQnVAXCGIBsEcyLPRap1sQOZrs
         n2cPH6IKOTfx3rjwtWBdqeGS514NvF4zLpUWNXy+gAKaey/5FS0E0jkHYmUCjsX56Qaf
         So9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:subject:content-transfer-encoding;
        bh=ETP7beYmbqBBc7idaeeaatRzr0SkQXfy9dVXHazd4oY=;
        b=DoboyvZVkwYF5f3GNG2oUXHSp9gaRm6jqmZHsMml/3AjDKAIK9tQdXFR4eiSRDEvB2
         pvg5XzGgm9+vZm4B+Vb6HAYpmej8SpWcBQkK1gRX6xIG/1SFv6qeK9Fk+PwtPSKJIaRQ
         +UKcpOUESy9raBzaDKwOnz0cUvZRlv7YcbOZ5zwOsF3zfBZUQjMVzjTDg49kAL6pqjwa
         8tgFejnvF1P5wNEIFijV8H3XqubUp32kzTcMzjA5rCwPmBdVWi6N2UOkqKD66ujs7jsX
         CL+AoJ0/t5VVFMUGrojQcRlMncXs6h0Gt6R3rDehBRbgyu2D6zACkDqAAgKiiaS7Mudq
         WbWg==
X-Gm-Message-State: AOAM533fXjDrsG6ds8DXBYjEIcFnfaxWQQmEnQuoBehtfaDNVY2A4FPJ
	ZWWM3d90qV6wxX0EnrvHFOsHEX6uzqm37A==
X-Google-Smtp-Source: ABdhPJzEEKYwTXCNXyb+MipPe9+bkasrVVQQcwr+brFWnMpEhJJ7DIE8kdxs73E2qUhkoi+KODShJg==
X-Received: by 2002:a05:600c:1d29:b0:389:81d6:f499 with SMTP id l41-20020a05600c1d2900b0038981d6f499mr4315844wms.137.1646933203882;
        Thu, 10 Mar 2022 09:26:43 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id ay24-20020a05600c1e1800b00389a420e1ecsm5113492wmb.37.2022.03.10.09.26.43
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 09:26:43 -0800 (PST)
Message-ID: <75c7803c-89c6-9e93-8f58-d2c6f3e24360@tessares.net>
Date: Thu, 10 Mar 2022 18:26:43 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 10th of March 2022
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This Thursday, we had our 187th meeting with Mat, Ossama, Kishen (Intel)
Paolo, Davide (Red Hat), and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12772340  [net-next,9/9] mptcp: add fullmesh flag check for adding address
12772339  [net-next,8/9] selftests: mptcp: add implicit endpoint test case
12772338  [net-next,7/9] mptcp: strict local address ID selection
12772337  [net-next,6/9] mptcp: introduce implicit endpoints
12772336  [net-next,5/9] mptcp: more careful RM_ADDR generation
12772335  [net-next,4/9] selftests: mptcp: Rename wait function
12772334  [net-next,3/9] selftests: mptcp: join: allow running -cCi
12772333  [net-next,2/9] mptcp: use MPTCP_SUBFLOW_NODATA
12772332  [net-next,1/9] mptcp: add tracepoint in mptcp_sendmsg_frag

12769850  [net-next,11/11] selftests: mptcp: update output info of chk_rm_nr
12769859  [net-next,10/11] selftests: mptcp: add more arguments for
chk_join_nr
12769858  [net-next,09/11] selftests: mptcp: add invert check in
check_transfer
12769857  [net-next,08/11] selftests: mptcp: add fastclose testcase
12769856  [net-next,07/11] selftests: mptcp: reuse linkfail to make
given size ...
12769855  [net-next,06/11] selftests: mptcp: add extra_args in do_transfer
12769854  [net-next,05/11] selftests: mptcp: add the MP_RST mibs check
12769853  [net-next,04/11] mptcp: add the mibs for MP_RST
12769851  [net-next,03/11] selftests: mptcp: add the MP_FASTCLOSE mibs check
12769849  [net-next,02/11] mptcp: add the mibs for MP_FASTCLOSE
12769852  [net-next,01/11] selftests: mptcp: adjust output alignment for
more t...


    our repo (by: /):

/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12775482  [net-next,10/10] selftests: mptcp: join: make it shellcheck
compliant
12775481  [net-next,09/10] selftests: mptcp: join: avoid backquotes
12775479  [net-next,08/10] selftests: mptcp: join: clarify local/global vars
12775483  [net-next,07/10] selftests: mptcp: join: helper to filter TCP
12775480  [net-next,06/10] selftests: mptcp: join: list failure at the end
12775478  [net-next,05/10] selftests: mptcp: join: alt. to exec specific
tests
12775477  [net-next,04/10] selftests: mptcp: join: option to execute
specific t...
12775476  [net-next,03/10] selftests: mptcp: join: reset failing links
12775475  [net-next,02/10] selftests: mptcp: join: define tests groups once
12775474  [net-next,01/10] selftests: mptcp: drop msg argument of
chk_csum_nr


    our repo (by: Dmytro SHYTYI, Florian Westphal, Geliang Tang, Jiapeng
Chong, Kishen Maloor, Mat Martineau, Matthieu Baerts, Yonglong Li):

12282219: RFC: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to
tcp.h/mptcp.h
12282221: RFC: [RESEND,RFC,4/4] tcp: parse tcp options contained in
reset packets
12282223: RFC: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support
12282225: RFC: [RESEND,1/5] tcp: make two mptcp helpers available to tcp
stack
12282227: RFC: [RESEND,5/5] mptcp: send fastclose if userspace closes
socket with unread data
12321111: RFC: mptcp: Remove redundant assignment to remaining
12714439: RFC: [net-next,v2] net: mptcp, Fast Open Mechanism:
    - RFC

12733808: Changes Requested: [mptcp-next,v4,01/13] mptcp: allow ADD_ADDR
reissuance by userspace PMs
12733811: Changes Requested: [mptcp-next,v4,02/13] mptcp: handle local
addrs announced by userspace PMs
12733810: Changes Requested: [mptcp-next,v4,03/13] mptcp: read
attributes of addr entries managed by userspace PMs
12733817: Changes Requested: [mptcp-next,v4,04/13] mptcp: netlink: split
mptcp_pm_parse_addr into two functions
12733812: Changes Requested: [mptcp-next,v4,05/13] mptcp: netlink: Add
MPTCP_PM_CMD_ANNOUNCE
12733813: Changes Requested: [mptcp-next,v4,06/13] mptcp: selftests:
support MPTCP_PM_CMD_ANNOUNCE
12733814: Changes Requested: [mptcp-next,v4,07/13] mptcp: netlink: Add
MPTCP_PM_CMD_REMOVE
12733815: Changes Requested: [mptcp-next,v4,08/13] mptcp: selftests:
support MPTCP_PM_CMD_REMOVE
12733821: Changes Requested: [mptcp-next,v4,09/13] mptcp: netlink: allow
userspace-driven subflow establishment
12733816: Changes Requested: [mptcp-next,v4,10/13] mptcp: selftests:
support MPTCP_PM_CMD_SUBFLOW_CREATE
12733818: Changes Requested: [mptcp-next,v4,11/13] mptcp: selftests:
support MPTCP_PM_CMD_SUBFLOW_DESTROY
12733819: Changes Requested: [mptcp-next,v4,12/13] mptcp: selftests:
capture netlink events
12733820: Changes Requested: [mptcp-next,v4,13/13] selftests: mptcp:
functional tests for the userspace PM type
12733865: Changes Requested: [mptcp-next,v5,1/8] mptcp: bypass in-kernel
PM restrictions for non-kernel PMs
12733864: Changes Requested: [mptcp-next,v5,2/8] mptcp: store remote id
from MP_JOIN SYN/ACK in local ctx
12733867: Changes Requested: [mptcp-next,v5,3/8] mptcp: reflect remote
port (not 0) in ANNOUNCED events
12733866: Changes Requested: [mptcp-next,v5,4/8] mptcp: establish
subflows from either end of connection
12733868: Changes Requested: [mptcp-next,v5,5/8] mptcp: netlink: store
per namespace list of refcounted listen socks
12733869: Changes Requested: [mptcp-next,v5,6/8] mptcp: netlink: store
lsk ref in mptcp_pm_addr_entry
12733870: Changes Requested: [mptcp-next,v5,7/8] mptcp: attempt to add
listening sockets for announced addrs
12733871: Changes Requested: [mptcp-next,v5,8/8] mptcp: expose
server_side attribute in MPTCP netlink events:
    - Waiting for the refactoring around the listening sockets ↓

12758809: Needs ACK: [mptcp-next,1/4] mptcp: prefer ip address in syn
skb instead of listen sk bound address
12758808: Needs ACK: [mptcp-next,2/4] tcp: add mptcp join demultiplex hooks
12758810: Needs ACK: [mptcp-next,3/4] mptcp: handle join requests via
pernet listen socket
12758811: Needs ACK: [mptcp-next,4/4] mptcp: remove per-address
listening sockets:
12765701: RFC: [5/4] mptcp: handle join requests early:
    - series: mptcp: replace per-addr listener sockets

    - Kishen found a couple of possible issues (bind race conditions)

    - Paolo gave his view of the situation:
        - initial need:
https://github.com/multipath-tcp/mptcp_net-next/issues/203
        - (who opened that really...)
        - need: accept new subflows for existing connections but where
the listening socket has been closed

        - 2 approaches have been taken:
            - Kishen: create listening sockets (from the PM, with
options not to do that, etc;)
            - Florian: accept MPJ without having to create additional
sockets
        - these 2 approaches have pros and cons.

    - Issue 203 is a nice to have, maybe not even a bug depending on the
point of view

    - → probably not a good idea to add too much complexity in the
kernel, important bugs might come

    - → maybe easier to let the userspace PM to create listening socket
and not let the kernel doing that all the time.

    - → the complexity to addresses races discussed on the ML would be
managed from the userspace and maybe not even visible if opening
listening would be done only in specific cases

    - → idea would be to let the userspace PM (mptcpd) to do the bind +
listen:
        - not to have the complexity on the kernel side where we cannot
change the behaviour
        - having the kernel creating so many listening sockets "doesn't
smell good", we will likely have complex issues to fix
        - if we can do it from the userspace, probably best to let it do
that
        - 203 can then be fixed with mptcpd by creating listening
sockets if needed


12759420: RFC: [RFC,mptcp-next,1/4] mptcp: Move some symbols to be
visible outside the MPTCP subsystem
12759421: RFC: [RFC,mptcp-next,2/4] tcp: Allow tcp_check_req() to return
more status values
12759422: RFC: [RFC,mptcp-next,3/4] tcp: Check for the presence of a
MP_JOIN option
12759423: RFC: [RFC,mptcp-next,4/4] tcp: Add TCP hooks for detecting
MP_JOIN on a regular TCP listener:
    - linked to the previous series

12774701: Queued: [mptcp-next,v10,1/5] Revert "selftests: bpf: add
bpf_mptcp_sock() verifier tests"
12774702: Queued: [mptcp-next,v10,2/5] Revert "bpf: add 'bpf_mptcp_sock'
structure and helper"
12774703: Queued: [mptcp-next,v10,3/5] bpf: add bpf_skc_to_mptcp_sock_proto
12774704: Queued: [mptcp-next,v10,4/5] Squash to "selftests: bpf: add
MPTCP test base"
12774705: Queued: [mptcp-next,v10,5/5] selftests: bpf: test
bpf_skc_to_mptcp_sock:
    - Can be applied and sent to BPF maintainers

12774895: Queued: mptcp: Fix crash due to tcp_tsorted_anchor was
initialized before release skb:
    - Can be applied in -net

12776017: New: [mptcp-next,v4,1/4] mptcp: add MP_FAIL response support
12776018: New: [mptcp-next,v4,2/4] mptcp: reset subflow when MP_FAIL
doesn't respond
12776019: New: [mptcp-next,v4,3/4] selftests: mptcp: check MP_FAIL
response mibs
12776020: New: [mptcp-next,v4,4/4] selftests: mptcp: print extra msg in
chk_csum_nr:
    - "MP_FAIL echo and retrans"
    - new version sent today, to be reviewed



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 263)

  264  selftests: diag: failing on the public CI with the new
debug.config [bug] [selftests]:
      - waiting longer (increasing the timeout) should help, to be tested
      - may be good to:
          - have two timeouts:
              - after the first one, we emit a warning (e.g. 1sec)
              - after the second one, we mark the test as failed (e.g.
10sec) and we don't continue
            → it would help understanding what's wrong.


    Bugs (opened, flagged as "bug" and assigned)

  203  PM: server: accept subflows [bug] @kmaloor:
      - see above


    Bugs (opened and flagged as "bug" and not assigned)

  264  selftests: diag: failing on the public CI with the new
debug.config [bug] [selftests]:
      - see above

  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]


    In Progress (opened, new feature and assigned)

  261  MP_FAIL echo and retrans [enhancement] @geliangtang
  246  Netlink PM events: add one attribute about the connection type
(connect/accept) [enhancement] @kmaloor:
      - see above

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva

  216  The infinite mapping support [enhancement] @geliangtang
      - see above

  186  Add netlink command support [enhancement] @kmaloor
      - see above

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   75  BPF: packet scheduler [enhancement] @geliangtang
   74  BPF: path manager [enhancement] @geliangtang


    For later (opened and not assigned assigned)

  236  Review supported sockopts list [enhancement]
  222  Netlink event API: add SUBFLOW_CREATED event [enhancement]
  215  TCP Urgent pointer and MPTCP [enhancement]
  213  add MPTCP man page [enhancement]
  210  Accept new subflows when the listening socket is closed or bind
to one IP? [enhancement]
  208  better handing of ssk memory pressure in the TX path [enhancement]
  202  Add sendmsg support for ancillary data [enhancement]
  197  more mibs needed [enhancement]
  180  Get an update when MPTCP fall back to TCP [enhancement]
  177  improve retransmit subflow selection [enhancement]
  169  packetdrill: add coverage for ADD_ADDR and MP_JOIN on a different
port [enhancement] [packetdrill]
  163  allow ss dumping msk socket in TCP_LISTEN status [enhancement]
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
   59  (MP)TFO support [enhancement]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   48  MP_FASTCLOSE support (send part remaining) [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]

    Recently closed (since last week)

  263  selftests: join: missing MP_JOINs but ADD_ADDR OK with `multiple
flows, signal, link failure` [bug] [selftests]



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.18):
https://github.com/multipath-tcp/mptcp_net-next/projects/13
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - Fixes for -net:

       (one waiting to be applied)

    - Fixes for net-next:


    - Features for net-next:

8583f658626a mptcp: don't send RST for single subflow
e68686013fa7 mptcp: add the fallback check
a1729315e147 mptcp: track and update contiguous data status
bade273f02cc mptcp: infinite mapping sending
e5ec5aa2d93f mptcp: infinite mapping receiving
5542732ea6bf mptcp: add mib for infinite map sending
9226f94980dc mptcp: dump infinite_map field in mptcp_dump_mpext
19900af3ae0f selftests: mptcp: add infinite map mibs check
540e4856010f selftests: mptcp: add the MP_FAIL testcases:
    - Still issues to be fixed

1d9bdf1f4a8a mptcp: Remove redundant assignments in path manager init
907029160396 mptcp: Add a member to mptcp_pm_data to track kernel vs
userspace mode
c204fc521c59 mptcp: Bypass kernel PM when userspace PM is enabled
d0384a2e1357 mptcp: Make kernel path manager check for userspace-managed
sockets
6be3ca00f894 mptcp: Add a per-namespace sysctl to set the default path
manager type
456614f13477 selftests: mptcp: Add tests for userspace PM type:
    - waiting for the modifications related to the PM

        - [7ebc86d1121b] mptcp: send ADD_ADDR echo before create
subflows (Yonglong Li)
    - can be sent



Updating the export branch:
    - What takes time is to update all scripts:
        - for Github CI to do the sync automatically
        - for Matth when applying patches
        - other utility patches to maintain our tree



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - /

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - broken again :)

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - See above



Documentation:
    - Seems needed: https://blog.benjojo.co.uk/post/multipath-without-mptcp
    - best to discuss about that next week



Next meeting:
    - Next one on Thursday, the 17th of March.
    - Usual UTC time /!\ except in the US: 16:00 UTC (9am PST, 5pm CET,
12am CST)
    - We suggest to switch to 15:00 UTC the week after
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220317



Feel free to comment on these points and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
