Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0AD168
	for <mptcp@lists.linux.dev>; Fri, 21 Jan 2022 18:43:19 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id a18so44255498edj.7
        for <mptcp@lists.linux.dev>; Fri, 21 Jan 2022 10:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=J6rK0g9RyRk0kLEFor30/I7TAllfOYAIgFfiZIMoYU4=;
        b=jdpoej2RbRR5sd4mNCkUZdD/afd++4SEVFpkmVth9YZ33Xf1ut91okSLBXUZUqPDfz
         Gh0eN2kHvqmEHasDxOO6kliXTmQdQvjj+VCdstsEsEfIFmScQ1B08xrh+Nhw2q6BYN4z
         BjboomFmKru4jEnQEK2qllBxE91uc/xnA+i8EakRRVWBQcTP7p8PxWzD33mFzy24S9FQ
         VI076DKVXiAW5kRz9zbNKgnHyltqjm9PIt9nIdxdSyqYkKRgEMphctuNE+m2hk9k+Rqc
         03Nu/hnnjGOyguwtXLZfCUIBm3pDpfDeZkXyWu9iQtTmbbZ9mGwnB6TPA4LuClOaRfSN
         RCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=J6rK0g9RyRk0kLEFor30/I7TAllfOYAIgFfiZIMoYU4=;
        b=NLlDswLvSHVhkc+wC8egiDhbq4OdbGTKSsEnHfhaOY0bnv8Gqd249+dGRui0FS7bEQ
         kk2hx1h0WBVAuIfNT5woUpPPwYBDRtSJsPhPOzn4ZRauVqzl0D6KPKwruUAYpv/xf78z
         4zjCBqowZbhot4U1UracjiXuFdFCUmp0NPGhQjnbQSp1prPV5VDPV7qOj4f1J5LzoSpw
         46kaQxk+3s41tRi9hp+Gx4+x8fh8pAZ9hGr3sNNoALCbhwc0jnRx9DsFhCGDACtWifbi
         WVMXW4e8vL2+uf2JxSdonH/6ZajwxiscF12ub23LN34e8SW57qR1kWDJYCO/GVxs+BPB
         CSMg==
X-Gm-Message-State: AOAM532RLSGLDSx7SuM2vieJvOXCuex4P9MWkr1sHO9RaH8ViNYWo870
	gxlahsSsm8YzItJqWwRAKr0r1+sokGmtfg==
X-Google-Smtp-Source: ABdhPJyikZCTaEpdIeB7WfpclXXINoh2hZsQl8eiXqQsbf+f7zr0MuwLzCQNq46dTuIjWlnf9nDVjg==
X-Received: by 2002:a05:6402:360d:: with SMTP id el13mr5336494edb.201.1642790597364;
        Fri, 21 Jan 2022 10:43:17 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:f295:1df7:e58d:8f73? ([2a02:578:8593:1200:f295:1df7:e58d:8f73])
        by smtp.gmail.com with ESMTPSA id l3sm2265213ejg.44.2022.01.21.10.43.16
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 10:43:16 -0800 (PST)
Message-ID: <dbe87233-5332-049b-3b29-553f2373582a@tessares.net>
Date: Fri, 21 Jan 2022 19:43:16 +0100
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
Subject: [Weekly meetings] MoM - 20th of January 2021
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we just had our 180th meeting with Mat, Ossama, Kishen
(Intel) Paolo, Davide, Florian (Red Hat), Poorva (?), Dmytro Shytyi
(SFR) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Dmytro:
    - SFR employee (French network operator)
    - Working on MPTCP TFO extension



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Paolo Abeni):

12717131  [mptcp-next,v3] selftests: mptcp: add invert check in
check_transfer

12714490  [mptcp-next,v2,10/10] selftests: mptcp: set ip_mptcp in
command line
12714489  [mptcp-next,v2,09/10] selftests: mptcp: add wrapper for
setting flags
12714488  [mptcp-next,v2,08/10] selftests: mptcp: add wrapper for
showing addrs
12714487  [mptcp-next,v2,07/10] selftests: mptcp: add ip mptcp wrappers
12714486  [mptcp-next,v2,06/10] selftests: mptcp: add backup with port
testcase
12714485  [mptcp-next,v2,05/10] selftests: mptcp: add the port argument
for set...
12714484  [mptcp-next,v2,04/10] mptcp: allow to use port and non-signal
in set_...
12714483  [mptcp-next,v2,03/10] selftests: mptcp: add fullmesh setting tests
12714482  [mptcp-next,v2,02/10] selftests: mptcp: set fullmesh flag in
pm_nl_ctl
12714481  [mptcp-next,v2,01/10] mptcp: set fullmesh flag in pm_netlink

12718343  [mptcp-next] Squash to "selftests: mptcp: add wrapper for
setting fla...
12718342  [mptcp-next] Squash to "selftests: mptcp: add backup with port
testca...
12718341  [mptcp-next] Squash to "selftests: mptcp: set fullmesh flag in
pm_nl_...

12713053  [mptcp-net] selftests: mptcp: fix ipv6 routing setup



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Muhammad Usama Anjum):

12717425  [V2,08/10] selftests: mptcp: Add the uapi headers include variable

12714403  [iproute2-next,v2] mptcp: add id check for deleting address


    our repo (by: Dmytro SHYTYI, Geliang Tang, Jiapeng Chong, Kishen
Maloor, Matthieu Baerts, Paolo Abeni):

12282219: RFC: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to
tcp.h/mptcp.h
12282221: RFC: [RESEND,RFC,4/4] tcp: parse tcp options contained in
reset packets:
    - WIP

12282223: RFC: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
    - WIP

12282225: RFC: [RESEND,1/5] tcp: make two mptcp helpers available to tcp
stack
12282227: RFC: [RESEND,5/5] mptcp: send fastclose if userspace closes
socket with unread data:
    - WIP

12321111: Changes Requested: mptcp: Remove redundant assignment to
remaining:
    - TODO (anyone?)

12674087: RFC: [RFC] mptcp: strict local address ID selection.:
    - WIP
    - (waiting for big modifications in selftests to be done)

12708484: Changes Requested: [mptcp-next,v9,5/5] selftests: mptcp: add
mp_fail testcases:
    - status is the same as last week: new version needed + fix in the
kernel side
    - "selftests: mptcp: add invert check in check_transfer" patch is
linked to this one

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
    - idea is to split the series in smaller chunks (2 or 3):
modifications for both the in-kernel and userspace PM

    - and add configuration options:
        - for issues/203, having an option seems to fix the issue:
            - at least we would have a way to accept new subflows
            - fix with a new flag, not a general option (sysctl)
            - (issue 203: application close the listening socket not to
accept new connections but then it also don't accept new subflow → new
subflow for an existing connection != new connection)

12714254: Awaiting Upstream: [iproute2-next,v6] mptcp: add the fullmesh
flag setting support:
    - waiting for the linked kernel patch to land in net-next first

12714439: RFC: [net-next,v2] net: mptcp, Fast Open Mechanism:
    - useful to split into different small chunks: preparation first, etc.

    - Length: we have restricted space with MPTCP: in MPC+SYN, there are
8 bytes left

    - we might need to remove some options to save space:
        - e.g. to remove TCP_TIMESTAMPS for the SYN+ACK
        - an additional option arg to mptcp_synack_options() (to be
checked) can be added to clear the option → &opts->options

    - what about re-using TCP code?:
        - fine to export / refactor / etc. as long as there is no impact
in term of perf for plain TCP (without MPTCP)
        - so fine if it is justified and not causing regressions for
plain TCP

    - selftests:
        - very important
        - of course the current ones should still be OK
        - dedicated ones are needed

    - if we can write up to 8 bytes, we should not have to modify the
TCP code (except the export of course), only on MPTCP side where we
would need to make sure we send the correct DSS.

    - Dmytro is working on something with the 2nd ACK, sorry I didn't
get that but it will be easier to understand with the code.



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 252)

  253  high number of unneeded retransmissions in bulk transfer [bug]
@pabeni:
      - can be reproduced with plain TCP
      - solution is to increase NIC recv ring buff
      - it is normal with MPTCP, see explanation on the ticket
      - can be closed
      - could be good to have a note in the wiki → TODO Matth → Done
      - TODO: Matth: close the ticket → Done by Paolo


    Bugs (opened, flagged as "bug" and assigned)

  253  high number of unneeded retransmissions in bulk transfer [bug]
@pabeni:
      - See above

  250  [syzkaller] Use-after-free in subflow_state_change [bug]
[syzkaller] @pabeni:
      - We probably need a fix for stable but it was not seen before
      - probably fine not to look at that → close TODO Matth → done by Paolo

  245  Packetdrill: Injected ADD_ADDR echo doesn't have the right info
[bug] [packetdrill] @dcaratti:
      - not blocking our selftests
      - first checking why MPJ doesn't add the proper endpoint.

  203  PM: server: accept subflows [bug] @kmaloor:
      - See patches above


    Bugs (opened and flagged as "bug" and not assigned)

  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]

  225  selftests: join: "remove subflows and signal" is unstable [bug]
[selftests]:
      - still happening on the public CI, at Tessares and also saw by
Mat on his side (not a lot on KBuild)
      - We can also see some packetdrill tests failing because the
ADD_ADDR is seen later than expected
      - maybe linked? in this case a "real" issue?

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]


    In Progress (opened, new feature and assigned)

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @dcaratti:
      - re-assigned to Poorva

  216  The infinite mapping support [enhancement] @geliangtang:
      - See above

  186  Add netlink command support [enhancement] @kmaloor:
      - See above

  171  iproute2: support removing ID 0 [enhancement] [iproute2]
@geliangtang:
      - See above

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   75  BPF: packet scheduler [enhancement] @geliangtang
   74  BPF: path manager [enhancement] @geliangtang


    For later (opened and not assigned assigned)

  246  Netlink PM events: add one attribute about the connection type
(connect/accept) [enhancement]
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

None.


FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.18):
https://github.com/multipath-tcp/mptcp_net-next/projects/13 (new project)
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4
    - ChangeLog has been updated



Patches to send to netdev:

    - Fixes for -net:

        - [0c13169919f3] mptcp: fix msk traversal in
mptcp_nl_cmd_set_flags() (Paolo Abeni)
        - [3889a8ba6730] mptcp: fix removing ids bitmap setting (Geliang
Tang)
        - [9eaaa7c10b01] selftests: mptcp: fix ipv6 routing setup (Paolo
Abeni)
        - Mat will send these three patches → Done

    - Features for net-next: net-next is closed for the moment

        - [b524271e6869] mptcp: don't send RST for single subflow
(Geliang Tang)
        - [925af3c9dd38] mptcp: add the fallback check (Geliang Tang)
        - [cb5fe03ff76e] mptcp: track and update contiguous data status
(Geliang Tang)
        - [7aea6ce25016] mptcp: infinite mapping sending (Geliang Tang)
        - [a42506c37a45] mptcp: infinite mapping receiving (Geliang Tang)
        - [17bd2b82f5e3] mptcp: add mib for infinite map sending
(Geliang Tang)
        - [2941247fc507] selftests: mptcp: add invert check in
check_transfer (Geliang Tang)
        - [a06bd1432875] selftests: mptcp: add infinite map mibs check
(Geliang Tang):
            - → waiting for the selftests (and fix in the code, see above)

        - [8ee76725dc62] mptcp: Remove redundant assignments in path
manager init (Mat Martineau)
        - [3da5ec4a8ea8] mptcp: Add a member to mptcp_pm_data to track
kernel vs userspace mode (Mat Martineau)
        - [a6fa6439f522] mptcp: Bypass kernel PM when userspace PM is
enabled (Mat Martineau)
        - [850c99a6c642] mptcp: Make kernel path manager check for
userspace-managed sockets (Mat Martineau)
        - [f33deedadc86] mptcp: Add a per-namespace sysctl to set the
default path manager type (Mat Martineau)
        - [86c9517d9f75] selftests: mptcp: Add tests for userspace PM
type (Mat Martineau):
            - Linked to Kishen's patches (in review)
            - They seem ready: it looks like we don't need to modify
them for Kishen' series
            - but Kishen's patches are not ready so if we can wait, fine
to wait

        - [d8629c5e11a2] mptcp: move the declarations of ssk and subflow
(Geliang Tang)
        - [972742207bf0] mptcp: reduce branching when writing MP_FAIL
option (Matthieu Baerts)
        - [8d6e82efafc1] mptcp: clarify when options can be used
(Matthieu Baerts)
        - [a0af835cb92b] mptcp: print out reset infos of MP_RST (Geliang
Tang):
            - Can be sent when net-next will re-open, no urgency

        - [1bc88f86afff] mptcp: set fullmesh flag in pm_netlink (Geliang
Tang)
        - [2a149fd63f5e] selftests: mptcp: set fullmesh flag in
pm_nl_ctl (Geliang Tang)
        - [80a649c04474] selftests: mptcp: add fullmesh setting tests
(Geliang Tang)
        - [5c4ecb79e0c6] mptcp: allow to use port and non-signal in
set_flags (Geliang Tang)
        - [d6cd78f8efa4] selftests: mptcp: add the port argument for
set_flags (Geliang Tang)
        - [03f59f719d7f] selftests: mptcp: add backup with port testcase
(Geliang Tang)
        - [873dfc1bf143] selftests: mptcp: add ip mptcp wrappers
(Geliang Tang)
        - [54f87104b434] selftests: mptcp: add wrapper for showing addrs
(Geliang Tang)
        - [54451c2582af] selftests: mptcp: add wrapper for setting flags
(Geliang Tang)
        - [ae7fd17adb34] selftests: mptcp: set ip_mptcp in command line
(Geliang Tang):
            - Just applied, can wait



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - export branch didn't change a lot (net-next is closed)
        - nothing new has been seen

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - pretty stable, less hits for issue 225

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - Still some instabilities with mptcp_join.sh (missing
ADD_ADD/RM_ADDR)



NET_NS_REFCNT_TRACKER:
    - Does it make sense to enable it in our kbuild?
    - maybe for mptcp_napi_dev?
    - or to check subflow?
    - just in the debug build → TODO Matth → Done



mptcpd:
    - Matth started to look at packaging:
        - TODO: share lintian output → Done
    - Ossama is looking at creating a new release soon



Next meeting:
    - Next one on Thursday, the 27th of January.
    - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220127



Feel free to comment on these points and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
