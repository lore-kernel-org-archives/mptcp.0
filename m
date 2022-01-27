Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A34629CA
	for <mptcp@lists.linux.dev>; Thu, 27 Jan 2022 17:43:03 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id s13so7551534ejy.3
        for <mptcp@lists.linux.dev>; Thu, 27 Jan 2022 09:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from:to
         :subject:content-transfer-encoding;
        bh=8vfvHZab+titnvqCCPuwqxQ9PLvYLns4tyD9vun7+Rw=;
        b=ExV4OKhRq7fQhNcabeqmfWVK95PzHvs3bN2ztIgSNXM/TVKlPNMXLsit4aRlTDPVID
         VbH7cS/6M1sirb8YS5lQBn/9oyHvua/vmBnVFp2bGasZYPFoP+P+7dIpAdCWxoNpChyP
         WEQF21eR+KKYUxArARwzbY2yp7Og/yKpRz6lwL0WS+gLV1lu7Ghfol3N/jaQe/AqRWcY
         Jy/GJkkDWQWJGDbkQV3tyBIAGxRLFuLjt3dNG3m9sBRpJcI21e/Ses+19wGmQX9R0cw0
         2rDAyKkecB4p3+OYuBmAMuNVf82W21zBJV+3O3tXv9xX7RuwTRp6NcVoRszVnmfWiHcS
         b6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:subject:content-transfer-encoding;
        bh=8vfvHZab+titnvqCCPuwqxQ9PLvYLns4tyD9vun7+Rw=;
        b=y92H5bHYakuZXv9A2dFqv1jvwxo2I8DllIQOjIDGpRxCpm1hdVwqDiITFVCWD+lWgC
         TzizLofibs3mWh+L1j1l2S9YdC72CQw/FJ06tT9JMXe2DGMUH0UweqYkJ2oMzcGRNqph
         NMspAg/Tuja4c8b6LCzFC3kj9dqc9DdIfKP+iOm23lE/OoJb25E4KfKBwFyd1uunbWoT
         saCnQSBWl0uwW6x2Ky2+IRdM1VFMwzKW2cYB1FkHJjbV1w0pgizHPiJh37WCC0YsJs+b
         nF1DhsPac8uOzy6NhGGRowgqmpyN689IRFmQf/HVlI2aP0r8cgDGIsCQrKkiTZeJ2z6h
         ovmg==
X-Gm-Message-State: AOAM531C1J/ClUfP2/9vjLCQKJ4WGMAEfPR8nHO1z81nSR2pAnw17lau
	cCQvaeyG3sAyGT3S8+DKBxKPAQCt6Jlcyg==
X-Google-Smtp-Source: ABdhPJxvDNTV0LwKBfV9Ak7IuDgPNZPDbCkNdish9fiNyD/J8Ve5Ot+GNdnjPOiGJ6lcGXOwpbiVHg==
X-Received: by 2002:a17:907:9488:: with SMTP id dm8mr3696067ejc.73.1643305381327;
        Thu, 27 Jan 2022 09:43:01 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:fe1f:d9d6:8db5:a255? ([2a02:578:8593:1200:fe1f:d9d6:8db5:a255])
        by smtp.gmail.com with ESMTPSA id v23sm9071026ejy.177.2022.01.27.09.43.00
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 09:43:00 -0800 (PST)
Message-ID: <308dfd53-2b4e-8813-5e51-d42603f8e40c@tessares.net>
Date: Thu, 27 Jan 2022 18:43:00 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 27th of January 2021
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we just had our 181st meeting with Mat, Ossama, Kishen
(Intel) Paolo, Florian (Red Hat), Poorva (?), Giray (Parkyeri) and
myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Kees Cook, Mat Martineau):

12719388  mptcp: Use struct_group() to avoid cross-field memset()

12719195  [net,3/3] selftests: mptcp: fix ipv6 routing setup
12719193  [net,2/3] mptcp: fix removing ids bitmap setting
12719194  [net,1/3] mptcp: fix msk traversal in mptcp_nl_cmd_set_flags()

12717425  [V2,08/10] selftests: mptcp: Add the uapi headers include
variable:
    - TODO: Matth: change PW status → Done


    our repo (by: /):

/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Muhammad Usama Anjum):

12714403  [iproute2-next,v2] mptcp: add id check for deleting address:
    - TODO: Matth: check if applied → Done: has been applied


    our repo (by: Dmytro SHYTYI, Geliang Tang, Jiapeng Chong, Kishen
Maloor, Matthieu Baerts, Paolo Abeni):

12282219: RFC: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to
tcp.h/mptcp.h
12282221: RFC: [RESEND,RFC,4/4] tcp: parse tcp options contained in
reset packets:
    - RFC

12282223: RFC: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
    - RFC

12282225: RFC: [RESEND,1/5] tcp: make two mptcp helpers available to tcp
stack
12282227: RFC: [RESEND,5/5] mptcp: send fastclose if userspace closes
socket with unread data:
    - RFC

12321111: Changes Requested: mptcp: Remove redundant assignment to
remaining:
    - 'RFC'

12674087: RFC: [RFC] mptcp: strict local address ID selection.:
    - "RFC"

12711986: Changes Requested: [mptcp-next,v2,01/21] mptcp: do not
restrict subflows with non-kernel PMs
12711985: Changes Requested: [mptcp-next,v2,02/21] mptcp: store remote
id from MP_JOIN SYN/ACK in local ctx
12711989: Changes Requested: [mptcp-next,v2,03/21] mptcp: reflect remote
port (not 0) in ANNOUNCED events
12711988: Changes Requested: [mptcp-next,v2,04/21] mptcp: establish
subflows from either end of connection
12711990: Changes Requested: [mptcp-next,v2,05/21] mptcp: netlink: store
per namespace list of refcounted listen socks
12711992: Changes Requested: [mptcp-next,v2,06/21] mptcp: netlink: store
lsk ref in mptcp_pm_addr_entry
12711991: Changes Requested: [mptcp-next,v2,07/21] mptcp: netlink:
process IPv6 addrs in creating listening sockets
12711993: Changes Requested: [mptcp-next,v2,08/21] mptcp: attempt to add
listening sockets for announced addrs
12711994: Changes Requested: [mptcp-next,v2,09/21] mptcp: allow ADD_ADDR
reissuance by userspace PMs
12711995: Changes Requested: [mptcp-next,v2,10/21] mptcp: handle local
addrs announced by userspace PMs
12711996: Changes Requested: [mptcp-next,v2,11/21] mptcp: read
attributes of addr entries managed by userspace PMs
12712001: Changes Requested: [mptcp-next,v2,12/21] mptcp: netlink: split
mptcp_pm_parse_addr into two functions
12711998: Changes Requested: [mptcp-next,v2,13/21] mptcp: netlink: Add
MPTCP_PM_CMD_ANNOUNCE
12711997: Changes Requested: [mptcp-next,v2,14/21] mptcp: selftests:
support MPTCP_PM_CMD_ANNOUNCE
12711999: Changes Requested: [mptcp-next,v2,15/21] mptcp: netlink: Add
MPTCP_PM_CMD_REMOVE
12712000: Changes Requested: [mptcp-next,v2,16/21] mptcp: selftests:
support MPTCP_PM_CMD_REMOVE
12712004: Changes Requested: [mptcp-next,v2,17/21] mptcp: netlink: allow
userspace-driven subflow establishment
12712002: Changes Requested: [mptcp-next,v2,18/21] mptcp: selftests:
support MPTCP_PM_CMD_SUBFLOW_CREATE
12712003: Changes Requested: [mptcp-next,v2,19/21] mptcp: selftests:
support MPTCP_PM_CMD_SUBFLOW_DESTROY
12712005: Changes Requested: [mptcp-next,v2,20/21] mptcp: selftests:
capture netlink events
12712006: Changes Requested: [mptcp-next,v2,21/21] selftests: mptcp:
functional tests for the userspace PM type:
    - Kishen is working on the v3
    - Should come soon, we will continue the discussion when the new
series will be available

12714439: RFC: [net-next,v2] net: mptcp, Fast Open Mechanism:
    - WIP

12719368: Changes Requested: [iproute2-next,v7] mptcp: add the fullmesh
flag setting support:
    - Awaiting upstream → we need the corresponding patch for the kernel
in net-next first

12720671: Queued: [mptcp-net,1/2] mptcp: mptcp_parse_option is no longer
exported
12720672: Queued: [mptcp-net,2/2] selftests: mptcp: add missing join check:
    - series: "selftests: avoid confusions around 'signal invalid
addresses'"
    - to be applied

12723703: Changes Requested: [mptcp-next,1/3] Squash to "mptcp: infinite
mapping sending"
12723704: Changes Requested: [mptcp-next,2/3] Squash to "mptcp: infinite
mapping receiving"
12723705: Changes Requested: [mptcp-next,3/3] selftests: mptcp: add
mp_fail testcases
12724765: Changes Requested: [mptcp-next] Squash to "mptcp: infinite
mapping sending" part 2
    - Mat had a few questions
    - Geliang shared some pcaps to confirm everything is working as expected
    - Selftests starts to look good
    - needs to check how to avoid all the messages printed in dmesg for
this new selftest: on the public CI, they are printed in the serial and
it impacts the perfs and makes the test fails:
        - either change the selftests to avoid sending data on one side:
            - to avoid pure ACKs from the other side causing warning in TC
            - best solution but easy to implement?
        - change printk level just for this test
            - but we could miss stuff
        - patch TC to remove the warning
            - not idea to maintain that kind of patch but effective.
        - check with TC devs if the warning makes sense / if there is a
better solution.
        - (find another solution)

12726101: Queued: [mptcp-next,v2] Squash to "mptcp: infinite mapping
sending" - fix csum:
    - not dependant on the prev series, can be applied

12724499: Queued: [mptcp-next,v5,1/2] selftests: mptcp: add the id
argument for set_flags
12724500: Queued: [mptcp-next,v5,2/2] selftests: mptcp: add set_flags
tests in pm_netlink.sh:
    - series: add the id argument for set_flags
    - can be applied


Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 253)

  256  BUG: KASAN: use-after-free in inet_twsk_kill
(net/ipv4/inet_timewait_sock.c:46) [bug]:
      - bug upstream, introduced and fixed by Eric
      - closed

  255  selftests: connect: checksum failed [bug]:
      - Paolo tried to reproduce the issue but he was not able to
      - @Geliang: was there anything else applied on top of the export
branch?
      - TODO Matth: add info in the ticket → Done

  254  selftests: join: `signal invalid addresses` is unstable [bug]:
      - TCP dup ACK are dropped by TCP
      - Paolo is looking at a fix but it modifies TCP stack, to be
discussed with upstream.
      - it might be useful to have a packetdrill test to confirm this theory
      - TODO: assign the ticket to Paolo → Done


    Bugs (opened, flagged as "bug" and assigned)

  245  Packetdrill: Injected ADD_ADDR echo doesn't have the right info
[bug] [packetdrill] @dcaratti:
      - WIP

  203  PM: server: accept subflows [bug] @kmaloor:
      - WIP


    Bugs (opened and flagged as "bug" and not assigned)

  255  selftests: connect: checksum failed [bug]
  254  selftests: join: `signal invalid addresses` is unstable [bug] →
now assigned to Paolo
  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]
  225  selftests: join: "remove subflows and signal" is unstable [bug]
[selftests]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]


    In Progress (opened, new feature and assigned)

  246  Netlink PM events: add one attribute about the connection type
(connect/accept) [enhancement] @kmaloor:
      - See above

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva

  216  The infinite mapping support [enhancement] @geliangtang:
      - See above

  186  Add netlink command support [enhancement] @kmaloor:
      - See above

  171  iproute2: support removing ID 0 [enhancement] [iproute2]
@geliangtang:
      - to be closed
      - TODO Matth → Done

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
  253  high number of unneeded retransmissions in bulk transfer [bug]
@pabeni
  250  [syzkaller] Use-after-free in subflow_state_change [bug]
[syzkaller] @pabeni



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.18):
https://github.com/multipath-tcp/mptcp_net-next/projects/13
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - nothing for -net:
        - (pending patches in review / to be applied)

    - Features for net-next:

        - [0051542358e3] mptcp: don't send RST for single subflow
(Geliang Tang)
        - [133843310aac] mptcp: add the fallback check (Geliang Tang)
        - [a0558b675383] mptcp: track and update contiguous data status
(Geliang Tang)
        - [3f4a1360c4c9] mptcp: infinite mapping sending (Geliang Tang)
        - [78a3a4df1736] mptcp: infinite mapping receiving (Geliang Tang)
        - [1799e47d2710] mptcp: add mib for infinite map sending
(Geliang Tang)
        - [cf6c461290fb] selftests: mptcp: add invert check in
check_transfer (Geliang Tang)
        - [e36096667df2] selftests: mptcp: add infinite map mibs check
(Geliang Tang):
            - waiting for patches that are in review

        - [6b3e621eb343] mptcp: Remove redundant assignments in path
manager init (Mat Martineau)
        - [35c735d98d9d] mptcp: Add a member to mptcp_pm_data to track
kernel vs userspace mode (Mat Martineau)
        - [0bb82afe37aa] mptcp: Bypass kernel PM when userspace PM is
enabled (Mat Martineau)
        - [3a2228018759] mptcp: Make kernel path manager check for
userspace-managed sockets (Mat Martineau)
        - [1333dd1ce838] mptcp: Add a per-namespace sysctl to set the
default path manager type (Mat Martineau)
        - [afff1f77fbcb] selftests: mptcp: Add tests for userspace PM
type (Mat Martineau):
            - we can wait a little longer, e.g. for Kishen's v3

        - [236c974aa1b3] mptcp: move the declarations of ssk and subflow
(Geliang Tang)
        - [6b0adebf2f7c] mptcp: reduce branching when writing MP_FAIL
option (Matthieu Baerts)
        - [ebeb6b05a9e7] mptcp: clarify when options can be used
(Matthieu Baerts)
        - [9c08ccb9dfeb] mptcp: print out reset infos of MP_RST (Geliang
Tang):
            - can be sent (if no dependences)

        - [60fb7a0a54b3] mptcp: set fullmesh flag in pm_netlink (Geliang
Tang)
        - [a925550995e3] selftests: mptcp: set fullmesh flag in
pm_nl_ctl (Geliang Tang)
        - [b2e59872f5fd] selftests: mptcp: add fullmesh setting tests
(Geliang Tang):
            - can be sent (if no dependences)

        - [4aaee55df53f] mptcp: allow to use port and non-signal in
set_flags (Geliang Tang)
        - [9b1afaaa9542] selftests: mptcp: add the port argument for
set_flags (Geliang Tang)
        - [b130738fcd13] selftests: mptcp: add backup with port testcase
(Geliang Tang)
        - [7aaa1fbe08f4] selftests: mptcp: add ip mptcp wrappers
(Geliang Tang)
        - [5eb4448cd5f1] selftests: mptcp: add wrapper for showing addrs
(Geliang Tang)
        - [534ddc6b244c] selftests: mptcp: add wrapper for setting flags
(Geliang Tang)
        - [e064d6cd3dc3] selftests: mptcp: set ip_mptcp in command line
(Geliang Tang):
            - probably best to wait for the 2 other patches linked to
set_flags and in review



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - nothing related to MPTCP (not the issue 256)

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - seems OK

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - it might be interesting to use the new debug.config:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/configs/debug.config?id=0aaa8977acbf3996d351f51b3b15295943092f63
        - Currently we enable these kconfig for our DEBUG mode:

-e KASAN -e KASAN_OUTLINE -d TEST_KASAN
-e PROVE_LOCKING -e DEBUG_LOCKDEP
-e PREEMPT -e DEBUG_PREEMPT
-e DEBUG_SLAVE -e DEBUG_PAGEALLOC -e DEBUG_MUTEXES -e DEBUG_SPINLOCK -e
DEBUG_ATOMIC_SLEEP
-e PROVE_RCU -e DEBUG_OBJECTS_RCU_HEAD
-e NET_NS_REFCNT_TRACKER
-d KFENCE

        - Probably best to use this debug.config, more future proof
        - and also in Mat's setup (syzkaller and others)



mptcpd:
    - preparing a v0.9 release
    - should help debian packaging
    - last things to look at is a fix to skip unit tests requiring a
kernel supporting MPTCP if not available/disabled/... (ease packaging)



Next meeting:
    - Next one on Thursday, the 3rd of February.
    - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220203



Feel free to comment on these points and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
