Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985BB28FE
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 14:10:17 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id q17so4154316edd.4
        for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 06:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=JBf6gWXaFiKQmtHMq/52HJkbRtZ5asNuis8WNHLhP8U=;
        b=xVCDdPOMOuWMpeSbGQKOTZtXfqBgCPdnPqxh2WRma70R35oXjCmdYGSeAzDa6hKwWc
         aEToYgxYE/3Y4x2B75Y4R3GkqWKLVB8lFsdSZMLMHVHoJjMWrI7yu9NwzA+l63LPFX4A
         xqvBwBHc1E/TPkFgrH2NQVNf611X265rr85xjfKrHE35d/+yAVrEDraD0F6e4S1YVZ2H
         scg8vh6KuWbX91gB8lwYvMhfpgJKGrHddU/jR9r45NX+NSLDzGYIeLqoc4TZUqosoM1S
         xGnDBvgo4FXketPK6AIqoOMTmGSpxTzwYnAj2Jleetgt8pyinximwoUSgysXmTw1Wwl3
         GuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=JBf6gWXaFiKQmtHMq/52HJkbRtZ5asNuis8WNHLhP8U=;
        b=fzEwDO1FYLGTZ4/cYUjd19RhGgEACq2B936qWfugYGFooq98lnJM1jrJ8TfRmnxBlI
         Er48JpkE0X5/hyBep6SCEBgtBouaDm2AILHDjPRGnDWW+whqyyXMvHg7sl0WLM5qQz31
         5mUOTOBwlIeQdHknKZG201JrpcYZlogE3k+wKtvzErjPiuBeehkuOBfwieG5UK1PNU/t
         n2Qn0zk0apiixqnMJ5CbhfxCSwF/1e7aWXkficwSwygzXfiJpwwigBT7ebwIyjzCY98a
         gFSx/qZsUncA0Ut8mLICmKg5LYK+IFtN8BeQ/KGOO/Xw+AJurJwVV6Y7GYGcJpYD8mmM
         PKtg==
X-Gm-Message-State: AOAM530H6fxwLJ5q0muvSs0z1Uhv/2flhKIzU4uqdZoPjxrgiF3IDBNZ
	NQDd9CIfykD8KwrQCoOmRf+3W08FlFE52Q==
X-Google-Smtp-Source: ABdhPJyXa14jmDvL4f+shDovs9A4qowsWz//xSHaedq+ak51I6t0EnMN/iN8Ah6cx4Pokj56tHqRow==
X-Received: by 2002:aa7:cc82:0:b0:410:d2b0:1a07 with SMTP id p2-20020aa7cc82000000b00410d2b01a07mr3101007edt.359.1645020614942;
        Wed, 16 Feb 2022 06:10:14 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:f860:24ec:64c5:373a? ([2a02:578:8593:1200:f860:24ec:64c5:373a])
        by smtp.gmail.com with ESMTPSA id v30sm3500463ejv.76.2022.02.16.06.10.14
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 06:10:14 -0800 (PST)
Message-ID: <f1492c99-9e88-b64b-2146-2503cdd56735@tessares.net>
Date: Wed, 16 Feb 2022 15:10:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 3rd of February 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday (almost 2 weeks ago), we had our 182nd meeting with Mat,
Ossama, Kishen (Intel) Florian, Paolo, Davide (Red Hat), Geliang (Suse),
Giray (Parkyeri) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Mat Martineau,
Muhammad Usama Anjum):

12733708  [net-next,7/7] selftests: mptcp: add fullmesh setting tests
12733705  [net-next,6/7] selftests: mptcp: set fullmesh flag in pm_nl_ctl
12733707  [net-next,5/7] mptcp: set fullmesh flag in pm_netlink
12733704  [net-next,4/7] mptcp: print out reset infos of MP_RST
12733706  [net-next,3/7] mptcp: clarify when options can be used
12733703  [net-next,2/7] mptcp: reduce branching when writing MP_FAIL option
12733702  [net-next,1/7] mptcp: move the declarations of ssk and subflow
 - Upstreaming started for 5.18

12717425  [V2,08/10] selftests: mptcp: Add the uapi headers include variable
12714403  [iproute2-next,v2] mptcp: add id check for deleting address


    our repo (by: Geliang Tang, Kishen Maloor, Matthieu Baerts):

12728144  [mptcp-next] mptcp: use MPTCP_SUBFLOW_NODATA
12728076  [mptcp-next] mptcp: drop unused sk in mptcp_get_options
12727702  [mptcp-net,v3] mptcp: netlink: process IPv6 addrs in creating
listeni...
12726101  [mptcp-next,v2] Squash to "mptcp: infinite mapping sending" -
fix csum
12724500  [mptcp-next,v5,2/2] selftests: mptcp: add set_flags tests in
pm_netli...
12724499  [mptcp-next,v5,1/2] selftests: mptcp: add the id argument for
set_fla...
12720672  [mptcp-net,2/2] selftests: mptcp: add missing join check
12720671  [mptcp-net,1/2] mptcp: mptcp_parse_option is no longer exported



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12732470  [mptcp-stable] mptcp: fix msk traversal in
mptcp_nl_cmd_set_flags()


    our repo (by: Dmytro SHYTYI, Geliang Tang, Jiapeng Chong, Kishen
Maloor, Matthieu Baerts, Paolo Abeni):

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
12674087: RFC: [RFC] mptcp: strict local address ID selection.
12714439: RFC: [net-next,v2] net: mptcp, Fast Open Mechanism:
    - WIP

12719368: Awaiting Upstream: [iproute2-next,v7] mptcp: add the fullmesh
flag setting support:
    - Can be sent upstream now that the kernel patches are in net-next →
Done

12723703: Changes Requested: [mptcp-next,1/3] Squash to "mptcp: infinite
mapping sending"
12723704: Changes Requested: [mptcp-next,2/3] Squash to "mptcp: infinite
mapping receiving"
12723705: Changes Requested: [mptcp-next,3/3] selftests: mptcp: add
mp_fail testcases
12724765: Changes Requested: [mptcp-next] Squash to "mptcp: infinite
mapping sending" part 2:
    - Mat reviewed, some modifications needed

12730676: Under Review: [mptcp-next] mptcp: use nla_parse_nested:
    - probably we cannot change (uAPI break)
    - Paolo will look at that after the meeting → Done

12733383: RFC: [mptcp-next] selftests: mptcp: fix diag instability:
    - Working well
    - But even better if we avoid a "blind sleep".

12733865: New: [mptcp-next,v5,1/8] mptcp: bypass in-kernel PM
restrictions for non-kernel PMs
12733864: New: [mptcp-next,v5,2/8] mptcp: store remote id from MP_JOIN
SYN/ACK in local ctx
12733867: New: [mptcp-next,v5,3/8] mptcp: reflect remote port (not 0) in
ANNOUNCED events
12733866: New: [mptcp-next,v5,4/8] mptcp: establish subflows from either
end of connection
12733868: New: [mptcp-next,v5,5/8] mptcp: netlink: store per namespace
list of refcounted listen socks
12733869: New: [mptcp-next,v5,6/8] mptcp: netlink: store lsk ref in
mptcp_pm_addr_entry
12733870: New: [mptcp-next,v5,7/8] mptcp: attempt to add listening
sockets for announced addrs
12733871: New: [mptcp-next,v5,8/8] mptcp: expose server_side attribute
in MPTCP netlink events:
    - series: mptcp: fixes and enhancements related to path management
    - Paolo will continue the review

    - Remaining important discussion
    - risk of raise condition:
        - userspace → listen(fd, port A)
        - userspace → accept() + close(fd)
        - kernel create listening socket
        - userspace cannot re-open the listening socket

    - → there is a risk of breaking existing connections even if we
don't have examples
    - on the other hand, it is also to align with the "with port" behaviour:
        - when there is a port, we would do a listen but not when there
is no port
        - but we also have different behaviour because the with the
port, the listen is created at a different time
        - hard to guess what's the most common case
        - it could be nice to have a uniformity between the different PM
about what is the default behaviour, e.g.:
            - we don't have a way to accept a subflow on a different
port without listening socket (but does it make sense not to have the
kernel creating a listening socket for that case where we want subflows
on a different port?)

    - it might then make sense to have both a LISTEN and a NO_LISTEN
flag and decide what is the default behaviour for the in-kernel PM →
Paolo will think about that

    - how do we want to treat that? to "fix" the issue #203 → to fix it,
we need to change the behaviour but that's not something that is forbidden.

    - Florian is going to investigate alternative to listen sockets,
similar to what is done in mptcp.org, only modifying the err path of
TCP, should be OK for TCP Maintainers



12733808: New: [mptcp-next,v4,01/13] mptcp: allow ADD_ADDR reissuance by
userspace PMs
12733811: New: [mptcp-next,v4,02/13] mptcp: handle local addrs announced
by userspace PMs
12733810: New: [mptcp-next,v4,03/13] mptcp: read attributes of addr
entries managed by userspace PMs
12733817: New: [mptcp-next,v4,04/13] mptcp: netlink: split
mptcp_pm_parse_addr into two functions
12733812: New: [mptcp-next,v4,05/13] mptcp: netlink: Add
MPTCP_PM_CMD_ANNOUNCE
12733813: New: [mptcp-next,v4,06/13] mptcp: selftests: support
MPTCP_PM_CMD_ANNOUNCE
12733814: New: [mptcp-next,v4,07/13] mptcp: netlink: Add MPTCP_PM_CMD_REMOVE
12733815: New: [mptcp-next,v4,08/13] mptcp: selftests: support
MPTCP_PM_CMD_REMOVE
12733821: New: [mptcp-next,v4,09/13] mptcp: netlink: allow
userspace-driven subflow establishment
12733816: New: [mptcp-next,v4,10/13] mptcp: selftests: support
MPTCP_PM_CMD_SUBFLOW_CREATE
12733818: New: [mptcp-next,v4,11/13] mptcp: selftests: support
MPTCP_PM_CMD_SUBFLOW_DESTROY
12733819: New: [mptcp-next,v4,12/13] mptcp: selftests: capture netlink
events
12733820: New: [mptcp-next,v4,13/13] selftests: mptcp: functional tests
for the userspace PM type:
    - Blocked by the prev series


Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 256)

  258  selftests: `diag.sh` is regularly failing [bug] [selftests]:
      - Paolo is working on it

  257  selftests: `mptcp_join.sh`: "multi subflows, fair usage on close"
is unstable [bug] [selftests]:
      - Mat also saw issues with this one on kbuild.


    Bugs (opened, flagged as "bug" and assigned)

  254  selftests: join: `signal invalid addresses` is unstable [bug]
@pabeni:
      - it looks like some packets are dropped somewhere but strange in
the setup (veth) and without having other counter increased
      - Paolo will check how to add more debug at interesting places.

  203  PM: server: accept subflows [bug] @kmaloor


    Bugs (opened and flagged as "bug" and not assigned)

  258  selftests: `diag.sh` is regularly failing [bug] [selftests]
  257  selftests: `mptcp_join.sh`: "multi subflows, fair usage on close"
is unstable [bug] [selftests]
  255  selftests: connect: checksum failed [bug]
  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]
  225  selftests: join: "remove subflows and signal" is unstable [bug]
[selftests]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]


    In Progress (opened, new feature and assigned)

  246  Netlink PM events: add one attribute about the connection type
(connect/accept) [enhancement] @kmaloor
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  216  The infinite mapping support [enhancement] @geliangtang
  186  Add netlink command support [enhancement] @kmaloor
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

  256  BUG: KASAN: use-after-free in inet_twsk_kill
(net/ipv4/inet_timewait_sock.c:46) [bug]
  245  Packetdrill: Injected ADD_ADDR echo doesn't have the right info
[bug] [packetdrill] @dcaratti
  171  iproute2: support removing ID 0 [enhancement] [iproute2] @geliangtang



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.18):
https://github.com/multipath-tcp/mptcp_net-next/projects/13
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches for netdev:

    - Fixes for -net:

        - [47f49aff389f] selftests: mptcp: add missing join check
(Matthieu Baerts)
        - [922e2ace7cdd] mptcp: netlink: process IPv6 addrs in creating
listening sockets (Kishen Maloor):
            - Mat: maybe we should add the Cc: stable tag?:
                - to follow the doc
                - but nobody else is doing that in -net, no?
                - and they will (likely) be picked up anyway thanks to
the Fixes tag
                - so? :)
                - stable will be cc for important issues
                - Fixes will be used when a patch fixes something

    - Features for net-next:

        - [6cf416f33c76] mptcp: don't send RST for single subflow
(Geliang Tang)
        - [ef6e0bad70fa] mptcp: add the fallback check (Geliang Tang)
        - [fe9dd53abda6] mptcp: track and update contiguous data status
(Geliang Tang)
        - [8cb214219b24] mptcp: infinite mapping sending (Geliang Tang)
        - [1e4cb430a7ed] mptcp: infinite mapping receiving (Geliang Tang)
        - [febb5857919d] mptcp: add mib for infinite map sending
(Geliang Tang)
        - [e0c44dff5ae8] selftests: mptcp: add invert check in
check_transfer (Geliang Tang)
        - [8c02b27129b5] selftests: mptcp: add infinite map mibs check
(Geliang Tang):
            - patches in review for that

        - [2022a4deb06f] mptcp: Remove redundant assignments in path
manager init (Mat Martineau)
        - [2a4b8ea7905a] mptcp: Add a member to mptcp_pm_data to track
kernel vs userspace mode (Mat Martineau)
        - [7f9ab97f357f] mptcp: Bypass kernel PM when userspace PM is
enabled (Mat Martineau)
        - [763984a19e7b] mptcp: Make kernel path manager check for
userspace-managed sockets (Mat Martineau)
        - [245e9597d5c1] mptcp: Add a per-namespace sysctl to set the
default path manager type (Mat Martineau)
        - [5e44e1063a21] selftests: mptcp: Add tests for userspace PM
type (Mat Martineau):
            - linked to Kishen's series

        - [825df810e4e0] mptcp: allow to use port and non-signal in
set_flags (Geliang Tang)
        - [343b3982d130] selftests: mptcp: add the port argument for
set_flags (Geliang Tang)
        - [7686c76b48b4] selftest: up with port testcase (Geliang Tang):
            - can be sent? (if no dep.)

        - [a80f4b51229f] selftests: mptcp: add ip mptcp wrappers
(Geliang Tang)
        - [c19b6e3d5d34] selftests: mptcp: add wrapper for showing addrs
(Geliang Tang)
        - [b34883cbb1c2] selftests: mptcp: add wrapper for setting flags
(Geliang Tang)
        - [0474c748dfa1] selftests: mptcp: add the id argument for
set_flags (Geliang Tang)
        - [fe7ad41c24a7] selftests: mptcp: add set_flags tests in
pm_netlink.sh (Geliang Tang)
        - [e0fc60f4ec52] selftests: mptcp: set ip_mptcp in command line
(Geliang Tang)
        - [93799ed32246] mptcp: mptcp_parse_option is no longer exported
(Matthieu Baerts)
        - [892d745320b0] mptcp: drop unused sk in mptcp_get_options
(Geliang Tang)
        - [311748ab7d7e] mptcp: use MPTCP_SUBFLOW_NODATA (Geliang Tang):
            - same


Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - /

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - a couple of temp. failure (unstable tests) with mptcp_join.sh,
11th test, see issue #257

    - packetdrill (Davide):
        - Packetdrill: Injected ADD_ADDR echo doesn't have the right
info [bug] [packetdrill] @dcaratti

    - Patchew (Davide):
        - is there a way to tell patchew a series depends on another one
(not applied yet)
        - base-commit of something applied by patchew?
        - to be tested

    - CI (Matth):
        - /



mptcpd:
    - 0.9 has been released
    - see the announcement on GitHub
    - hopefully in the next release we should have more fixes but also
support for Kishen's series + DBus support



Next meeting:
    - Next one on Thursday, the 10th of February.
    - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220210



Feel free to comment on these points and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
