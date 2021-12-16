Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C6C2C82
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 15:52:58 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id g14so87584923edb.8
        for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 07:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=qDj7ixvbXcAsqWC165a3JABG8h1h5gK4EECJIoxIcDA=;
        b=oIi+PZWRQ2mgMIKKjO+PKsDpnb4TbSKPNOHyTfX5oSMC5ZNfiSKWX07Ns4WCZNv6mQ
         FEvJI61caE3qNj1ox9eWuo8v63tsU1QLoz6NREiud59mawgbomC0rdgaEXpBmnEt+t8m
         +HrkI0G4Jqp3vr8h8RmJu6KWGeaOWsxTrO9mlXFfg5/KDMP3oP6EIGhiBhInt92lrL9n
         Mtej0ql4XQM3Rv8KKfTK3ynbTCdMP8I8BseUrA2XSaa6VZgGi6M/pz23021vKHIax8yJ
         iwiz66A9Ry0NxRF2llE86r0ANWlwV5n4EkDCrFMmj8afYSxN884Igp6M4optPJkvqSsq
         66XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=qDj7ixvbXcAsqWC165a3JABG8h1h5gK4EECJIoxIcDA=;
        b=cedXl190VQdKZOHYmqeTEb2ZCUlZmtbNjrrCAWxzqCEO4g3B9vbR9zcNf+0njjppUi
         MB4bhEY6HrgTJpL2J5PhfAB4gkB6kJjuBY2e0M2f8PkO6BH2MdYOCOo4k/mXE5AP1Dyx
         UOB0RbQqOs24sXkO0EBNwGc1/JBBq+r9XIVvVewMH+sg0OhYhA1mR6Hoh7SzsIf/Rm34
         duO+J/EdaaUw2qhW+WEGc2rVzfzEpmhS+H9M8UdBCqhXedTeY7LptSaS7FWrga0725nL
         M6+9Ol5D1/22sde1Y4pzZtEkwHwbBHhaATuMKuXIumQqNqCiz7CPpOb9a+8P+l26MkSd
         wPwA==
X-Gm-Message-State: AOAM5335Eg0ZexDRqi2a3JoU/FdgoHelIvf5jc+2Wtd0BPHoV1bPjq+B
	OHw9tcQbGhBZbLHYRtTgzb0Dpb4sKr18dg==
X-Google-Smtp-Source: ABdhPJwt9wzfGnpZpZyGeJxBK8ekiYrrEvUXzboaxeK8w0SqF1BGauXeo7dWbV3zyl4fEdw9FpmzMQ==
X-Received: by 2002:a05:6402:90c:: with SMTP id g12mr21681212edz.36.1639669973869;
        Thu, 16 Dec 2021 07:52:53 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id j5sm1983159ejo.177.2021.12.16.07.52.53
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 07:52:53 -0800 (PST)
Message-ID: <8822cc5b-0573-ddaf-257a-2f796bedc92d@tessares.net>
Date: Thu, 16 Dec 2021 16:52:53 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 9th of December 2021
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we just had our 176th meeting with Mat, Ossama, Kishen
(Intel), Paolo, Davide, Florian (Red Hat), Giray (Parkyeri) and myself
(Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Paolo Abeni, Mat Martineau):

12640381  [iproute2-next] mptcp: add support for fullmesh flag

12655967  [net-next,10/10] mptcp: support TCP_CORK and TCP_NODELAY
12655965  [net-next,09/10] mptcp: expose mptcp_check_and_set_pending
12655963  [net-next,08/10] tcp: expose __tcp_sock_set_cork and
__tcp_sock_set_n...
12655961  [net-next,07/10] selftests: mptcp: check IP_TOS in/out are the
same
12655959  [net-next,06/10] mptcp: getsockopt: add support for IP_TOS
12655955  [net-next,05/10] mptcp: allow changing the "backup" bit by
endpoint id
12655957  [net-next,04/10] selftests: mptcp: add inq test case
12655953  [net-next,03/10] mptcp: add SIOCINQ, OUTQ and OUTQNSD ioctls
12655951  [net-next,02/10] selftests: mptcp: add TCP_INQ support
12655949  [net-next,01/10] mptcp: add TCP_INQ cmsg support


    our repo (by: Florian Westphal, Matthieu Baerts, Maxim Galaganov):

12659719  [v2,1/2] mptcp: clear 'kern' flag from fallback sockets
12658789  [2/2] selftests: mptcp: try to set mptcp ulp mode in different
sk sta...

12657251  mptcp: remove tcp ulp setsockopt support

12653185  [mptcp-next,2/2] Squash to "selftests: mptcp: add inq test case"
12653183  [mptcp-next,1/2] Squash to "selftests: mptcp: check IP_TOS
in/out are...

12651125  [mptcp-net] mptcp: fix deadlock in __mptcp_push_pending()

12647781  [mptcp-net] mptcp: add missing documented NL params



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Davide):


12655357: Awaiting Upstream: [iproute2-next] mptcp: add support for
changing the backup flag:
    - do not forget to add MPTCP ML in cc ;-)


    our repo (by: Davide Caratti, Dmytro Shytyi, Geliang Tang, Jiapeng
Chong, Jεan Sacren, Kishen Maloor, Mat Martineau, Matthieu Baerts, Paolo
Abeni):

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
    - TODO: anyone?

12540931: Changes Requested: [RFC,1/4] mptcp: pm_netlink: Add
MPTCP_PM_CMD_ANNOUNCE
12540933: Changes Requested: [RFC,2/4] mptcp: selftests:
MPTCP_PM_CMD_ANNOUNCE
12540935: Changes Requested: [RFC,3/4] mptcp: pm_netlink: Add
MPTCP_PM_CMD_REMOVE
12540937: Changes Requested: [RFC,4/4] mptcp: selftests:
MPTCP_PM_CMD_REMOVE:
    - WIP

12576993: Changes Requested: [net-next,v1] net: mptcp, Fast Open Mechanism:
    - WIP

12651433: Changes Requested: [mptcp-next,v2,1/6] mptcp: Remove redundant
assignments in path manager init
12651437: Changes Requested: [mptcp-next,v2,2/6] mptcp: Add a member to
mptcp_pm_data to track kernel vs userspace mode
12651435: Changes Requested: [mptcp-next,v2,3/6] mptcp: Bypass kernel PM
when userspace PM is enabled
12651441: Changes Requested: [mptcp-next,v2,4/6] mptcp: Make kernel path
manager check for userspace-managed sockets
12651439: Changes Requested: [mptcp-next,v2,5/6] mptcp: Add a
per-namespace sysctl to set the default path manager type
12651443: Changes Requested: [mptcp-next,v2,6/6] selftests: mptcp: Add
tests for userspace PM type:
    - series "mptcp: Add userspace PM mode to bypass kernel PM"
    - Tested by Geliang
    - Commented by Paolo
    - v3 is in preparation

12655369: Changes Requested: [mptcp-next,v4,1/5] mptcp: fix per socket
endpoint accounting.
12655373: Changes Requested: [mptcp-next,v4,2/5] mptcp: clean-up MPJ
option writing.
12655377: Changes Requested: [mptcp-next,v4,3/5] mptcp: keep track of
local endpoint still available for each msk
12655375: Changes Requested: [mptcp-next,v4,4/5] mptcp: do not block
subflows creation on errors
12655379: Changes Requested: [mptcp-next,v4,5/5] selftests: mptcp: add
tests for subflow creation failure:
    - series: "mptcp: improve subflow creation on errors"
    - this series is not really introducing behaviour changes but makes
sure we don't take into account a subflow that is not supposed to be
taken into account → we should see that as a bug fix
    -
https://elixir.bootlin.com/linux/v5.15.7/source/net/mptcp/pm_netlink.c#L939
:
        - if an ID is not found, we create an entry to be able to track it.
        - Or should not not allow that? But a few selftests are going to
fail that because we rely on that
        - Or allow a way to forbid that on some systems?
        - Paolo will try to see the impact if this is forbidden

12657649: Changes Requested: [mptcp-next,v6,1/2] Squash to "mptcp:
implement fastclose xmit path"
12657651: Changes Requested: [mptcp-next,v6,2/2] mptcp: print out reset
infos of MP_RST:
    - Series: "send MP_FAIL with MP_RST and others"
    - Matth: start a new email thread about what we allow to send with
what + code:
        - https://paste.debian.net/1222706/

net/mptcp/options.c: In function ‘mptcp_write_options’:
net/mptcp/options.c:1469:3: error: a label can only be part of a
statement and a declaration is not a statement
   const struct sock *ssk = (const struct sock *)tp;
   ^~~~~
net/mptcp/options.c:1470:3: error: expected expression before ‘struct’
   struct mptcp_subflow_context *subflow;
   ^~~~~~
net/mptcp/options.c:1472:3: error: ‘subflow’ undeclared (first use in
this function); did you mean ‘skb_cow’?
   subflow = mptcp_subflow_ctx(ssk);
   ^~~~~~~
   skb_cow
net/mptcp/options.c:1472:3: note: each undeclared identifier is reported
only once for each function it appears in
make[2]: *** [scripts/Makefile.build:287: net/mptcp/options.o] Error 1
make[2]: *** Waiting for unfinished jobs....

        - https://paste.centos.org/view/a66c3306

12657653: Changes Requested: [mptcp-next,v4] selftests: mptcp: add
mp_fail testcases:
    - still one important point: the test is showing that if a wrong
checksum is detected, we still need to drop what has been read and drop
the subflow (multiples subflows) or fallback (one subflow)
    - also some points linked to the test itself: not to print errors
that are not really errors

12659195: Queued: [mptcp-next,1/2] mptcp: cleanup MPJ subflow list handling
12659197: Queued: [mptcp-next,2/2] mptcp: avoid atomic bit manipulation
when possible:
    - Depends on "mptcp: improve subflow creation on errors"
    - series: "mptcp: a couple of cleanups"

12663849: Changes Requested: [net-next] net: mptcp: clean up harmless
false expressions:
    - small suggestion has been sent
    - Jean is working on a v2



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 246)

  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]:
      - Seems nobody else saw it
      - To be investigated

  247  see mptcp options when running iperf locally [question]:
      - probably a configuration issue, not a bug
      - Matth will follow up on that
      - Note: there is a pull request to add proper MPTCP (upstream)
support: https://github.com/esnet/iperf/pull/1166 (from Paolo)


    Bugs (opened, flagged as "bug" and assigned)

  245  Packetdrill: Injected ADD_ADDR echo doesn't have the right info
[bug] [packetdrill] @dcaratti:

  242  Unexpected subflow management behaviour, following endpoint add
after subflow failure [bug] @pabeni:
      - linked to "mptcp: improve subflow creation on errors" series,
see above


    Bugs (opened and flagged as "bug" and not assigned)

  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]
  225  selftests: join: "remove subflows and signal" is unstable [bug]
[selftests]
  203  PM: server: accept subflows [bug]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]
   65  packetdrill/fixes: clearing properly the status in
listen()/disconnect [bug]


    In Progress (opened, new feature and assigned)

  235  PM: create new subflow after one got closed [enhancement] @pabeni
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @dcaratti

  216  The infinite mapping support [enhancement] @geliangtang:
      - see patches above

  186  Add netlink command support [enhancement] @mjmartineau:
      - see patches above

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti
   75  BPF: packet scheduler [enhancement] @geliangtang
   74  BPF: path manager [enhancement] @geliangtang


    For later (opened and not assigned assigned)

  247  see mptcp options when running iperf locally [question]
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
  171  iproute2: support removing ID 0 [enhancement] [iproute2]
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

  244  Deadlock in mptcp_sockopt_sync_all() [bug]
  239  [syzkaller] general protection fault in inet_csk_accept (called
by mptcp_accept) [bug] @pabeni
  237  can't create backup path  [enhancement] [documentation]



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.17):
https://github.com/multipath-tcp/mptcp_net-next/projects/12
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - net:
        - mptcp: clear 'kern' flag from fallback sockets
        - mptcp: remove tcp ulp setsockopt support
        - mptcp: fix deadlock in __mptcp_push_pending()

    - net-next:
        - mptcp: enforce HoL-blocking estimation:
            - there were some discussions but clearly it is an
improvement and seems ready for net-next
        - infinite mapping support:
            - best to wait for the test to be ready
        - selftests: mptcp: try to set mptcp ulp mode in different sk
states:
            - could be sent but it depends on the patch for -net → and
possible conflicts in case of rebase
        - mptcp: implement fastclose xmit path:
            - there is a pending squash-to patch for this
        - maybe the "disconnect" patches if they don't depend on ↑?:
            - it was part of the same series so probably yes
            -
https://lore.kernel.org/mptcp/cover.1636647623.git.pabeni@redhat.com/



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - no new MPTCP failures \o/

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - some instabilities with one RM_ADDR test, also reported by
other CI

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - the importer VM might have to migrate elsewhere but a detail

    - CI (Matth):
        - KFENCE & KMEMLEAK supports are in progress



Next meeting:
    - On Thursday, the 16th of December.
    - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20211216



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
