Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EB1168
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 18:17:04 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id y22so165491300edq.2
        for <mptcp@lists.linux.dev>; Wed, 05 Jan 2022 10:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=vNuW/DB6q9ucJgpmZezE558Sbjs9MVjrh71NAPYUUd0=;
        b=sJWMMcYqTkkH/80vvSTkhlbrW0RALzvTetqh7oYick5b43Jb13r2hmcjzYT/B+3r3G
         DAGwEil6zGD7ZzB4PbCzCh4j4eS+sI7UhR1BO0eIlIqzhZwXD6gGuwpAF35mjyepl8CI
         L8sJBhDe3exQJDIO+CoXVajwyAYUGGQn6ztfQ1zjDqtNPoyRZxm6VLhyDaM2Yt/BKXsR
         CmWfzzF69NSk2cFjUNPzO6QelGvj+ebPdinPw5blcAz79/i9xq189uJjiWMjdGIfN6GF
         A2W0Nnngl68zWIJTDLqPUQCnVweAmmiwiW/mAqNGxSe4xJD/mBq3y9BzgClfoF3R18/y
         vmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=vNuW/DB6q9ucJgpmZezE558Sbjs9MVjrh71NAPYUUd0=;
        b=Etj0HymKvBQADeA16nbQdMtSlhaRjcEVfGf7mPbXdAvVYV8NBgooKzb7E/e/L043vZ
         X+pW6eKBHW1yFnCD1JGDeJ55EsnlMDEnZ1o4VRIsxE83XE96EmNHq7zvRtJegrLBUcq0
         1Gh9W/aPmGywzvijgw7Si4ShTi3czJFIFTS4fxDsRa7RgpYS7CjtsoOwO2ZtOf11PV2L
         48mfyYKyD3uRdEL0mYpOh8Ub+W/Z18pcNAVnEqO5jHHFT+2BNIonBARIU9QMXl1hLa5W
         plzHJzB/IjjA3YsK+m4dxkVVlUHAuQ0bQJwOvfjO6oO579J/r6DMxxhCtHjQeHyA9RO5
         HlYw==
X-Gm-Message-State: AOAM531z1ABLkXJq4bns5pAB609kIM++fsJPU8seyh1nuIP13/ej1tjd
	5MYf/+Fh9WVAEwdgVTbjhs3cKSIon7ugpASn3qo=
X-Google-Smtp-Source: ABdhPJzOD9J1UqrMgEJutAzisPSZ3a5XxylbmYriZsnmiBI8aMNNaB5LHQpBqwDk5OxTNPsYPnc1Ow==
X-Received: by 2002:a17:906:3e8a:: with SMTP id a10mr43589226ejj.612.1641406622493;
        Wed, 05 Jan 2022 10:17:02 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:c564:5be1:ce1b:8b4f? ([2a02:578:8593:1200:c564:5be1:ce1b:8b4f])
        by smtp.gmail.com with ESMTPSA id nb27sm12396306ejc.136.2022.01.05.10.17.01
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 10:17:02 -0800 (PST)
Message-ID: <f72121dd-ebde-3a73-ec0c-1346636b0335@tessares.net>
Date: Wed, 5 Jan 2022 19:17:01 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 5th of January 2021
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we just had our 178th meeting with Mat, Ossama, Kishen
(Intel) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:


Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Davide Caratti, Mat Martineau, Ma
Xinjian):

12698997  selftests: mptcp: Remove the deprecated config NFT_COUNTER

12685803  [net-next,3/3] mptcp: clean up harmless false expressions
12685799  [net-next,2/3] selftests: mptcp: try to set mptcp ulp mode in
differe...
12685801  [net-next,1/3] mptcp: enforce HoL-blocking estimation

12655357  [iproute2-next] mptcp: add support for changing the backup flag


    our repo (by: Geliang Tang, Paolo Abeni):

12683809  [mptcp-next] Squash to "selftests: mptcp: add tests for
subflow creat...

12683803  [mptcp-next,2/2] mptcp: reuse __mptcp_make_csum in
validate_data_csum
12683801  [mptcp-next,1/2] mptcp: change the parameter of __mptcp_make_csum

12681411  [mptcp-next] Squash-to: "mptcp: cleanup MPJ subflow list handling"

12678143  [v3,mptcp-next] selftests: mptcp: more stable join tests-cases.



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

12674087: RFC: [RFC] mptcp: strict local address ID selection:
    - From Paolo, reviewed by Mat
    - seems to be the right direction to take, big modification in the
selftests but for the best
    - changes requested but the approach seems fine

12682877: Changes Requested: [mptcp-next,01/21] mptcp: do not restrict
subflows with non-kernel PMs
12682875: Changes Requested: [mptcp-next,02/21] mptcp: store remote id
from MP_JOIN SYN/ACK in local ctx
12682881: Changes Requested: [mptcp-next,03/21] mptcp: reflect remote
port (not 0) in ANNOUNCED events
12682883: Changes Requested: [mptcp-next,04/21] mptcp: establish
subflows from either end of connection
12682885: Changes Requested: [mptcp-next,05/21] mptcp: netlink: store
per namespace list of refcounted listen socks
12682889: Changes Requested: [mptcp-next,06/21] mptcp: netlink: store
lsk ref in mptcp_pm_addr_entry
12682887: Changes Requested: [mptcp-next,07/21] mptcp: netlink: process
IPv6 addrs in creating listening sockets
12682893: Changes Requested: [mptcp-next,08/21] mptcp: attempt to add
listening sockets for announced addrs
12682891: Changes Requested: [mptcp-next,09/21] mptcp: allow ADD_ADDR
reissuance by userspace PMs
12682895: Changes Requested: [mptcp-next,10/21] mptcp: handle local
addrs announced by userspace PMs
12682897: Changes Requested: [mptcp-next,11/21] mptcp: read attributes
of addr entries managed by userspace PMs
12682905: Changes Requested: [mptcp-next,12/21] mptcp: netlink: split
mptcp_pm_parse_addr into two functions
12682901: Changes Requested: [mptcp-next,13/21] mptcp: netlink: Add
MPTCP_PM_CMD_ANNOUNCE
12682899: Changes Requested: [mptcp-next,14/21] mptcp: selftests:
support MPTCP_PM_CMD_ANNOUNCE
12682907: Changes Requested: [mptcp-next,15/21] mptcp: netlink: Add
MPTCP_PM_CMD_REMOVE
12682903: Changes Requested: [mptcp-next,16/21] mptcp: selftests:
support MPTCP_PM_CMD_REMOVE
12682915: Changes Requested: [mptcp-next,17/21] mptcp: netlink: allow
userspace-driven subflow establishment
12682909: Changes Requested: [mptcp-next,18/21] mptcp: selftests:
support MPTCP_PM_CMD_SUBFLOW_CREATE
12682911: Changes Requested: [mptcp-next,19/21] mptcp: selftests:
support MPTCP_PM_CMD_SUBFLOW_DESTROY
12682913: Changes Requested: [mptcp-next,20/21] mptcp: selftests:
capture netlink events
12682917: Changes Requested: [mptcp-next,21/21] selftests: mptcp:
functional tests for the userspace PM type:
    - From Kishen, reviewed by Paolo and Matth
    - some discussions needed:

        - is it OK to open additional listening sockets?:
            - Or has to be explicitly asked by the userspace?
            - Or an option for the in-kernel PM?
            - Can be on be default?
            - → Might help for the end user experience when using apps
creating TCP sockets
            - at the end, if there is already a listening socket (e.g.
listening to all interfaces), nothing new is created
            - maybe having a parameter in the ADD_ADDR CMD not to create
a listening socket implicitly might be a good compromised?

        - opening connections from the server to the client side:
            - "advanced" behaviour with "advanced policy" could be
managed by the userspace PM daemon
            - maybe having a dedicated NL CMD? There is already an API
for that (not in the PM)
            - at the end, listening socket only created if ADD_ADDR are sent

        - these cover new UCs but don't break existing ones:
            - maybe best to take a step back and check if it is really
an issue

    - probably best to discuss about that ↑ again later when Paolo will
be there and email will be re-read.

    - some other minor issues can be fixed easily, Kishen will do that


12703314: New: [RESEND,iproute2-next,1/3] mptcp: add id check for
deleting address
12703315: New: [iproute2-next,2/3] mptcp: add the addr flag fullmesh
12703316: New: [iproute2-next,3/3] mptcp: add the backup flag setting:
    - Need review

12703319: Changes Requested: [mptcp-next,1/4] selftests: mptcp: use 'ip
mptcp' in mptcp_join.sh
12703320: Changes Requested: [mptcp-next,2/4] selftests: mptcp: use 'ip
mptcp' in mptcp_sockopt.sh
12703321: Changes Requested: [mptcp-next,3/4] selftests: mptcp: use 'ip
mptcp' in pm_netlink.sh
12703322: Changes Requested: [mptcp-next,4/4] selftests: mptcp: use 'ip
mptcp' in simult_flows.sh:
    - on one hand, good to use "ip mptcp":
        - more real

    - but on the other hand, requiring a recent or a development version
might be an issues:
        - some CI might not have the proper tool and would skip the test

    - maybe not good to fallback to pm_nl_ctl: we would potentially not
have the same behaviour depending on the host

    - one solution is maybe to have dedicated tests using 'ip mptcp'
that we would be skip if 'ip' is not available (or too old version)

    - or: a parameter to the Bash scripts to use one or the other tool →
might be good to check for regressions in this tool as well and ask only
our CI to run those?

    - note: it looks like no other selftests tool is depending on a
specific IPRoute2 version

12704505: New: [mptcp-next,v8,1/8] Squash to "mptcp: implement fastclose
xmit path"
12704509: New: [mptcp-next,v8,2/8] mptcp: fix opt size when sending DSS
+ MP_FAIL
12704506: New: [mptcp-next,v8,3/8] mptcp: fix a DSS option writing error
12704507: New: [mptcp-next,v8,4/8] mptcp: reduce branching when writing
MP_FAIL option
12704508: New: [mptcp-next,v8,5/8] mptcp: clarify when options can be used
12704510: New: [mptcp-next,v8,6/8] mptcp: allow sending both ADD_ADDR
and RM_ADDR
12704511: New: [mptcp-next,v8,7/8] mptcp: print out reset infos of MP_RST
12704512: New: [mptcp-next,v8,8/8] selftests: mptcp: add mp_fail testcases:
    - the Squash-to should unblock the linked series to be sent upstream

    - followed by 2 fixes for -net:
        - first one should not be an issue as it is possible we were not
sending a DSS+MP_FAIL before (to be checked)
        - 2nd might be needed when we want to send a DSS + something
else: MP_PRIO or RM_ADDR → might be important for -net
        - maybe easier to send both to -net

    - last patch seems to still have issues → blocking MP_FAIL series


Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 250)
  252 [syzkaller] WARNING in page_counter_cancel:
      - also forwarded to us by Andrew Morton
      - Mat has a patch but was not tested by syzbot due to removed
trailing whitespaces making the patch not valid


    Bugs (opened, flagged as "bug" and assigned)

  245  Packetdrill: Injected ADD_ADDR echo doesn't have the right info
[bug] [packetdrill] @dcaratti


    Bugs (opened and flagged as "bug" and not assigned)

  252 [syzkaller] WARNING in page_counter_cancel

  250  [syzkaller] Use-after-free in subflow_state_change [bug] [syzkaller]:
      - could be good to have a patch for -net
      - *@Paolo*: did you work on a patch for this?

  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]
  225  selftests: join: "remove subflows and signal" is unstable [bug]
[selftests]

  203  PM: server: accept subflows [bug]:
      - TODO Matt: assign Kishen → done:
      - See patches above

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]


    In Progress (opened, new feature and assigned)

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @dcaratti
  216  The infinite mapping support [enhancement] @geliangtang:
      - See patches above

  186  Add netlink command support [enhancement] @mjmartineau:
      - TODO Matt: assign Kishen → done:
      - See patches above

  171  iproute2: support removing ID 0 [enhancement] [iproute2]
@geliangtang:
      - See patches above

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


    Recently closed (since last meeting)

  251   The best way to analyse MPTCPv1 performance?   [QUESTION] [question]
  242  Unexpected subflow management behaviour, following endpoint add
after subflow failure [bug] @pabeni
  235  PM: create new subflow after one got closed [enhancement] @pabeni
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.17):
https://github.com/multipath-tcp/mptcp_net-next/projects/12
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - net:
        - probably best to send:
            - mptcp: fix opt size when sending DSS + MP_FAIL
            - mptcp: fix a DSS option writing error → but we might need
to change
        - But if they are accepted after the last PR from Net maintainer
to Linus would delay stuff.
        - So if we don't want to rush to look at the tests, we can also
send to net-next for the future -net (to be check which tree is merged
in which one first?
          (net-next is proposed to be merged in Linus tree then -net is
merged with Linus tree and net-next is merged with -net)

    - net-next:
        - patches from Paolo could go there, fixing issues, see GH
issues/250:
            - *@Paolo*: OK for you?

        - + checksum fixes probably

        - best to skip MP_FAIL series for now as we don't have a stable
selftest yet

        - and no need to send Mat's series as it is linked to new
features in the Netlink PM part, not ready yet



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - running the last couple of weeks, didn't find anything related
to MPTCP in the export branch
        - issue /252 from syzbot

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - looks like we still have the same issue, probably with RM_ADDR

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - still applying patches, all good

    - CI (Matth):
        - KFENCE has been enabled, didn't spot anything so far



Github:
    - Kishen has been added in the team: we can assign ticket to him,
quick go!



Next meeting:
    - /!\ We are back on Thursday as before
    - Next one on Thursday, the 13th of January.
    - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220113



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday next week,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
