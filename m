Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE1168
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 14:36:38 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id d187-20020a1c1dc4000000b003474b4b7ebcso5818824wmd.5
        for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 06:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=kACHFIK2BA50ESAFT+K2MP/sRGrkUF2CaN/OMEmHoPg=;
        b=hfDIfXFpMV990QaMGZIW+jgHjds9kSn3u2/G+svd3omp2u503v8BN4RXjN90vPV/3k
         Y2k9l7rj3hVwl/xasiql7cm5TnpKouCEEcZkKnkQ66xUXjz9wHSIpGvUowUuBKkecBIl
         YsKeLqN9NmLwMlGr1z+yfwmN9sGgxIUjCAzBNqkxnzwnCJqVS+xQpCSYNUlYZY34wOWR
         +AEO9cb734/uVPJvd2sgb0k1yNeX7R/y3sdn565WyFQQ4zkqzRpP8Fwfn/iCwHo6zw5A
         xttlPkOAUJGg99YnZOIcHKFHdLEp3EiTRs2e5Ii+5FDVT88tR6AVh+fBrDW6lyGvD4Vq
         aqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=kACHFIK2BA50ESAFT+K2MP/sRGrkUF2CaN/OMEmHoPg=;
        b=1+50neKXi+8rcfT9cp0M4DHiMoUQJq8QD1kR62NFg+lcByIywc1GfbVG6agHYMbYr3
         4Dqk0v6HZ+AjFW5nuPXfgLRQagSKUTna8Q9X06UDshqbJGCYDgSBqDE9Uv4IFLMO/OXq
         wQ3Rv0jmyPpOydy8QTwIcXO3JkPolgggF6HuzD5Qo7SoD9Ai71rzk1+N9fNmAOZPmDkA
         x7vHhC2ws7KYXPvCNe82gMumlSgUzXvc4Uz5IYaDjpzkwsOGpLHuUzgKXTW/pvAM0PVF
         0fydmzLxNNtqDO75qKX+q/X+nZR77T1eDt9V5fMM4KIRZT9dToOIGYZmqt774dhHqVZh
         qTtA==
X-Gm-Message-State: AOAM5312TorvUritvjwdZiEAzb1SYB3F4eM6i5+pAfLx56dZ/cvS5M9I
	Kutk3wke1zO3lJtFkHt01lMmFQ8tsBF+5w==
X-Google-Smtp-Source: ABdhPJy78LBgTh6nHJiz2NK4xazGnMTSsHwEaCSl9adZFmdRwPY+0B7svKIsmMaX12qheVgq33PM4Q==
X-Received: by 2002:a17:906:7315:: with SMTP id di21mr7337623ejc.700.1642170995736;
        Fri, 14 Jan 2022 06:36:35 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:e62e:56dc:2d31:6b1a? ([2a02:578:8593:1200:e62e:56dc:2d31:6b1a])
        by smtp.gmail.com with ESMTPSA id t9sm2452918edd.94.2022.01.14.06.36.34
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 06:36:34 -0800 (PST)
Message-ID: <84c9d20d-c4ca-ff9f-d388-9cdef2de4f4f@tessares.net>
Date: Fri, 14 Jan 2022 15:36:34 +0100
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
Subject: [Weekly meetings] MoM - 13th of January 2021
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we just had our 179th meeting with Mat, Ossama, Kishen
(Intel) Paolo, Davide, Florian (Red Hat), Giray (Parkyeri) and myself
(Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:


Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12706990  [net-next,3/3] mptcp: reuse __mptcp_make_csum in
validate_data_csum
12706988  [net-next,2/3] mptcp: change the parameter of __mptcp_make_csum
12706989  [net-next,1/3] selftests: mptcp: more stable join tests-cases

12705988  [net-next,13/13] mptcp: avoid atomic bit manipulation when
possible
12705987  [net-next,12/13] mptcp: cleanup MPJ subflow list handling
12705985  [net-next,11/13] selftests: mptcp: add tests for subflow
creation fai...
12705986  [net-next,10/13] mptcp: do not block subflows creation on errors
12705984  [net-next,09/13] mptcp: keep track of local endpoint still
available ...
12705982  [net-next,08/13] mptcp: clean-up MPJ option writing
12705980  [net-next,07/13] mptcp: fix per socket endpoint accounting
12705979  [net-next,06/13] selftests: mptcp: add disconnect tests
12705983  [net-next,05/13] mptcp: implement support for user-space
disconnect
12705981  [net-next,04/13] mptcp: cleanup accept and poll
12705976  [net-next,03/13] mptcp: full disconnect implementation
12705977  [net-next,02/13] mptcp: implement fastclose xmit path
12705975  [net-next,01/13] mptcp: keep snd_una updated for fallback socket

12705862  [net,3/3] mptcp: Check reclaim amount before reducing allocation
12705863  [net,2/3] mptcp: fix a DSS option writing error
12705861  [net,1/3] mptcp: fix opt size when sending DSS + MP_FAIL


    our repo (by: Geliang Tang, Mat Martineau, Matthieu Baerts, Paolo
Abeni):

12709806  [mptcp-net] mptcp: fix msk traversal in mptcp_nl_cmd_set_flags()

12709438  [mptcp-next,v2] mptcp: fix removing ids bitmap setting

12708483  [mptcp-next,v9,4/5] mptcp: print out reset infos of MP_RST
12708482  [mptcp-next,v9,3/5] mptcp: clarify when options can be used
12708481  [mptcp-next,v9,2/5] mptcp: reduce branching when writing
MP_FAIL opti...
12708480  [mptcp-next,v9,1/5] mptcp: move the declarations of ssk and
subflow

12704986  [mptcp-net,v2] mptcp: Check reclaim amount before reducing
allocation

12704506  [mptcp-next,v8,3/8] mptcp: fix a DSS option writing error
12704509  [mptcp-next,v8,2/8] mptcp: fix opt size when sending DSS + MP_FAIL
12704505  [mptcp-next,v8,1/8] Squash to "mptcp: implement fastclose xmit
path"



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/

    our repo (by: Dmytro Shytyi, Geliang Tang, Jiapeng Chong, Kishen
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
    - TODO

12576993: Changes Requested: [net-next,v1] net: mptcp, Fast Open Mechanism:
    - WIP

12674087: RFC: [RFC] mptcp: strict local address ID selection.:
    - parked for the moment, a lot of modifications are ongoing on the
selftests side (by Geliang)

12703315: Rejected: [iproute2-next,2/3] mptcp: add the addr flag fullmesh
12703316: Rejected: [iproute2-next,3/3] mptcp: add the backup flag setting:
    - wrong repo, feature already there, all good

12706420: Changes Requested: [mptcp-next] Squash to "selftests: mptcp:
more stable join tests-cases":
    - Paolo will send a patch later, no longer a "squash-to" patch as
the mentioned one is now in net-next → done

12708484: Under Review: [mptcp-next,v9,5/5] selftests: mptcp: add
mp_fail testcases:
    - it looks like there are two issues in the kernel code:
        - one likely with TC, *Mat* will share the kconfig with Davide
        - one in MPTCP
    - but also in the selftests itself: data transfer in both direction
causing a lot of warnings from tc (pure ACK) visible in the serial,
slowing down everything

12709454: Awaiting Upstream: [iproute2-next,v3] mptcp: add id check for
deleting address:
    - This one can be sent upstream to netdev ML with iproute2-next
maintainers in cc (and mptcp list in cc as well)
    - @Geliang: is it OK for you to do that?

12711074: New: [mptcp-next,v4,1/4] mptcp: set fullmesh flag in pm_netlink
12711075: New: [mptcp-next,v4,2/4] selftests: mptcp: set fullmesh flag
in pm_nl_ctl
12711076: New: [mptcp-next,v4,3/4] selftests: mptcp: add fullmesh
setting tests
12711077: New: [iproute-next,v4,4/4] mptcp: add the fullmesh flag
setting support:
    - fullmesh flag setting support
    - OK for Paolo
    - Mat will have a look as well as he started to look at it yesterday
    - Note: best not to include 'iproute2-next' patches in the series
otherwise the CI (patchew) doesn't run the tests as it cannot apply al
the patches.

12711986: New: [mptcp-next,v2,01/21] mptcp: do not restrict subflows
with non-kernel PMs
12711985: New: [mptcp-next,v2,02/21] mptcp: store remote id from MP_JOIN
SYN/ACK in local ctx
12711989: New: [mptcp-next,v2,03/21] mptcp: reflect remote port (not 0)
in ANNOUNCED events
12711988: New: [mptcp-next,v2,04/21] mptcp: establish subflows from
either end of connection
12711990: New: [mptcp-next,v2,05/21] mptcp: netlink: store per namespace
list of refcounted listen socks
12711992: New: [mptcp-next,v2,06/21] mptcp: netlink: store lsk ref in
mptcp_pm_addr_entry
12711991: New: [mptcp-next,v2,07/21] mptcp: netlink: process IPv6 addrs
in creating listening sockets
12711993: New: [mptcp-next,v2,08/21] mptcp: attempt to add listening
sockets for announced addrs
12711994: New: [mptcp-next,v2,09/21] mptcp: allow ADD_ADDR reissuance by
userspace PMs
12711995: New: [mptcp-next,v2,10/21] mptcp: handle local addrs announced
by userspace PMs
12711996: New: [mptcp-next,v2,11/21] mptcp: read attributes of addr
entries managed by userspace PMs
12712001: New: [mptcp-next,v2,12/21] mptcp: netlink: split
mptcp_pm_parse_addr into two functions
12711998: New: [mptcp-next,v2,13/21] mptcp: netlink: Add
MPTCP_PM_CMD_ANNOUNCE
12711997: New: [mptcp-next,v2,14/21] mptcp: selftests: support
MPTCP_PM_CMD_ANNOUNCE
12711999: New: [mptcp-next,v2,15/21] mptcp: netlink: Add MPTCP_PM_CMD_REMOVE
12712000: New: [mptcp-next,v2,16/21] mptcp: selftests: support
MPTCP_PM_CMD_REMOVE
12712004: New: [mptcp-next,v2,17/21] mptcp: netlink: allow
userspace-driven subflow establishment
12712002: New: [mptcp-next,v2,18/21] mptcp: selftests: support
MPTCP_PM_CMD_SUBFLOW_CREATE
12712003: New: [mptcp-next,v2,19/21] mptcp: selftests: support
MPTCP_PM_CMD_SUBFLOW_DESTROY
12712005: New: [mptcp-next,v2,20/21] mptcp: selftests: capture netlink
events
12712006: New: [mptcp-next,v2,21/21] selftests: mptcp: functional tests
for the userspace PM type:
    - addressing most comments reported in v1:
        - check for 3rd ACK related to Paolo's comments
        - a few minor things: formatting, etc.
    - we need to be careful with the complexity we might introduce by
accepting subflows created by the "server" and create more listen sockets:
        - Kishen replied to different comments in the ML
        - On the other hand, we unify the way the client and server act
(both can create/accept subflows)
        - would help to let the userspace PM to maintain a certain policy
    - probably best to check Kishen's replies (before holidays) and the
v2 to start discussions about new features added here that "look scary"
but are maybe fine.

12712865: New: [mptcp-next,v2,1/3] mptcp: allow to use port and
non-signal in set_flags
12712866: New: [mptcp-next,v2,2/3] selftests: mptcp: add the port
argument for set_flags
12712867: New: [mptcp-next,v2,3/3] selftests: mptcp: add backup with
port testcase:
    - series: "set_flags port support"
    - to be reviewed

12712869: New: [mptcp-next,v5,1/5] selftests: mptcp: add ip mptcp wrappers
12712870: New: [mptcp-next,v5,2/5] selftests: mptcp: new approach of
getting ID
12712871: New: [mptcp-next,v5,3/5] selftests: mptcp: add wrapper for
showing addrs
12712872: New: [mptcp-next,v5,4/5] selftests: mptcp: add wrapper for
setting flags
12712873: New: [mptcp-next,v5,5/5] selftests: mptcp: set ip_mptcp in
command line:
    - use 'ip mptcp' in selftests
    - idea is to be able to check with 'ip mptcp' instead of the PM
internal tool
    - but not by default as we still want other CIs to run tests without
having to depend on a too recent version of iproute2





Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 252):
        /

    Bugs (opened, flagged as "bug" and assigned) :

  250  [syzkaller] Use-after-free in subflow_state_change [bug]
[syzkaller] @pabeni
      - we need a fix for 'stable'. -net and net-next are OK
      - only happened once without a reproducer but it looks like we can
still have it in -stable
      - doesn't look urgent then

  245  Packetdrill: Injected ADD_ADDR echo doesn't have the right info
[bug] [packetdrill] @dcaratti
      - first blocked by another issue (flow from another socket)

  203  PM: server: accept subflows [bug] @kmaloor
      - see above


    Bugs (opened and flagged as "bug" and not assigned)

  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]
  225  selftests: join: "remove subflows and signal" is unstable [bug]
[selftests]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]


    In Progress (opened, new feature and assigned)

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @dcaratti
      - Poorva would like to work on this one

  216  The infinite mapping support [enhancement] @geliangtang:
      - see above, modification in selftests and kernel code needed

  186  Add netlink command support [enhancement] @kmaloor:
      - see above

  171  iproute2: support removing ID 0 [enhancement] [iproute2]
@geliangtang:
      - patch ready to be sent

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
    - Current/Coming merge window (5.17):
https://github.com/multipath-tcp/mptcp_net-next/projects/12
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4
    - TODO: update ChangeLog 5.17 + project 5.18 → Done



Patches to send to netdev:
    - net:
        - mptcp: fix removing ids bitmap setting
        - mptcp: fix msk traversal in mptcp_nl_cmd_set_flags()
        - these two patches have just been applied, can be sent next week

    - net-next:
        - closed



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - New option now available in Linus tree: CONFIG_KCSAN_WEAK_MEMORY
        - now re-running with this new option, new hits in TCP but
doesn't seem to be related to MPTCP

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - still some issues with missed RM_ADDR, still the same

    - packetdrill (Davide):
        - See above (issues)

    - Patchew (Davide):
        - A migration to another DC is planned for more network stabilities
        - should be done next week or the week after
        - probably best not to include iproute2 tests in the series
because some patches are not applied

    - CI (Matth):
        - iproute2 has been updated to 5.16
        - seems more stable but still instabilities with mptcp_join.sh
(missed RM_ADDR)



IPRoute2:
    - do we need to maintain a repo for MPTCP?
    - For the moment the author sends the patches
    - We don't have tests → we could integrate that in the kernel tests
we have but some refactoring needed for that
    - same for the packetdrill repo
    - for the moment, we don't really need an importer in Patchew
    - But we can also have a fork of iproute2 in multipath-tcp account
if needed and periodically sync it with GitHub Action.



Perf tests:
    - by Paolo
    - comparing MPTCP one subflow vs TCP
    - with MPTCP, we have a very high number of TCP fast retransmit
    - probably the TCP stack does that because the of ACK generated in
mptcp_cleanup_rbuf
    - this can increase MPTCP seq number but also on the TCP side (ACK /
windows size)
    - this can likely trigger TCP fast retransmit from the other side
    - Paolo is debugging this trying to validate this guess
    - Paolo is going to open a new ticket later. → Done #253



Next meeting:
    - Next one on Thursday, the 20th of January.
    - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220120



Feel free to comment on these points and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
