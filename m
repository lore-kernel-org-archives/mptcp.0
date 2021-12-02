Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8758A2C82
	for <mptcp@lists.linux.dev>; Thu,  2 Dec 2021 15:11:00 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id c4so60310203wrd.9
        for <mptcp@lists.linux.dev>; Thu, 02 Dec 2021 07:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=RNr1r5N6x0O53lN1/7bBed59kh/H6pAfdeHaCCp0JJ8=;
        b=ThIcw7dGmwSXSTLCE4MQKMYJ9XLyk+gKW5cYyywStzcFByeQxyuwon+FhE/lD7gU8D
         s0ZDhC6EMSowoRRvNPtHfqkKEjEyD7D2EwjVaf3ctUQuM2vjV0lBnSr1vuCdevkNO/SG
         wHLKbogIJ0XtDisomNapvDbSzb7QsQ1BxCwVpt3zB2VUWIsaFze2T7BT2H+4A7cXLC0I
         mzwp7U41pi29vPeKgxZVHfG3b1OXsCIWnH7Ih18oGQfE74niQDpR57jFvnCmEm7eJTyY
         R8X6X38zJ8ttMzMgV43Vvy25s28fG2wA4hltvPS6bUu+aKRbVby5nfhmULaGMy/6T3aH
         KZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=RNr1r5N6x0O53lN1/7bBed59kh/H6pAfdeHaCCp0JJ8=;
        b=xGk3c41ptQhnSjgmvSLvLQMz1XcfLoy8u99A2XewPjcdLYD9VmiJiRcoIB58BAkQnf
         RFEJ1GTFtRrnF9STvnG6GOX36L77AsoP8Ub9m24QHAPziQu6R5lU+rGCfAXLUNbm42yt
         UDqaAXbsPR3cWj/ufn7BP8LlYpoV6nCyVTM2oYLiZHGonlmVeHGvaTfF2tdDjCbgMQF8
         dXt6GkdMTGiexzre2C3fkwd8v5/8e+UzdxJuflvrkkNriTpYcayi07eL6mgjQDhtKfIr
         +z/4CJ6txNfbkBqQkUlmwFfVX4ff8uE1S5QqsGTewsuLbVRH1oLJQK1kZ6oh7i32iUG0
         w85g==
X-Gm-Message-State: AOAM5339V30Er701zgciSFNAkoH+hmATwYzK/FMU2HDWngjWyZsb62Nd
	yXJ+5NJfxpxQ8yaV/XRzh8NbCTJ9X20JODAH
X-Google-Smtp-Source: ABdhPJzTmKpBi+mcvrIAkeUixnLJSzUuQfvm18QKV1rX2H4J19NVqkD8pcuBU/FPqi8xMomaiLqZ+A==
X-Received: by 2002:adf:fb86:: with SMTP id a6mr15118768wrr.35.1638457857902;
        Thu, 02 Dec 2021 07:10:57 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id j134sm21984wmj.3.2021.12.02.07.10.57
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 07:10:57 -0800 (PST)
Message-ID: <06d1fc76-063a-b521-0f05-197b540fddb5@tessares.net>
Date: Thu, 2 Dec 2021 16:10:57 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 18th of November 2021
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Recently, we had our 173rd meeting with Mat, Ossama, Kishen (Intel),
Paolo, Davide, Florian (Red Hat), Geliang (Suse), Giray (Parkyeri) and
myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Matthieu Baerts):

12616517  [mptcp-next] Squash to "mptcp: sockopt: add SOL_IP freebind &
transpa...
12591669  [mptcp-next,v8,7/8] selftests: mptcp: add infinite map mibs check
12591667  [mptcp-next,v8,6/8] mptcp: add mib for infinite map sending
12591665  [mptcp-next,v8,5/8] mptcp: infinite mapping receiving
12591663  [mptcp-next,v8,4/8] mptcp: infinite mapping sending
12591661  [mptcp-next,v8,3/8] mptcp: track and update contiguous data status
12591659  [mptcp-next,v8,2/8] mptcp: add the fallback check
12591657  [mptcp-next,v8,1/8] mptcp: don't send RST for single subflow



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Davide Caratti):

12614499  [iproute2] mptcp: fix JSON output when dumping endpoints by id
(accepted in iproute2.git 9bd5ab0f0913)



    our repo (by: Davide Caratti, Dmytro Shytyi, Florian Westphal,
Geliang Tang, Jiapeng Chong, Kishen Maloor, Mat Martineau, Matthieu
Baerts, Paolo Abeni):

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

12540931: Changes Requested: [RFC,1/4] mptcp: pm_netlink: Add
MPTCP_PM_CMD_ANNOUNCE
12540933: Changes Requested: [RFC,2/4] mptcp: selftests:
MPTCP_PM_CMD_ANNOUNCE
12540935: Changes Requested: [RFC,3/4] mptcp: pm_netlink: Add
MPTCP_PM_CMD_REMOVE
12540937: Changes Requested: [RFC,4/4] mptcp: selftests:
MPTCP_PM_CMD_REMOVE:
    - Kishen is working on it with selftests

12576993: Changes Requested: [net-next,v1] net: mptcp, Fast Open Mechanism:
    - Dmytro is working on it

12591671: Changes Requested: [mptcp-next,v8,8/8] selftests: mptcp: add
mp_fail testcases
12592523: Changes Requested: [mptcp-next] Squash to "selftests: mptcp:
add mp_fail testcases":
    - Geliang is working on a new version

12615445: Queued: [v2,mptcp-next,1/7] mptcp: keep snd_una updated for
fallback socket
12615449: Queued: [v2,mptcp-next,2/7] mptcp: never allow the PM to close
a listener subflow
12615451: Queued: [v2,mptcp-next,3/7] mptcp: implement fastclose xmit path
12615453: Queued: [v2,mptcp-next,4/7] mptcp: full disconnect implementation
12615455: Queued: [v2,mptcp-next,5/7] mptcp: cleanup accept and poll
12615457: Queued: [v2,mptcp-next,6/7] mptcp: implement support for
user-space disconnect
12615459: Queued: [v2,mptcp-next,7/7] mptcp: add disconnect selftests:
    - series: "mptcp: improve accept() and disconnect()"
    - needs to be applied after "TCP_INQ support" series

12622403: Queued: [mptcp-next,v3,1/4] mptcp: add TCP_INQ cmsg support
12622401: Queued: [mptcp-next,v3,2/4] selftests: mptcp: add TCP_INQ support
12622405: Queued: [mptcp-next,v3,3/4] mptcp: add SIOCINQ, OUTQ and
OUTQNSD ioctls
12622407: Queued: [mptcp-next,v3,4/4] selftests: mptcp: add inq test case:
    - series: "TCP_INQ support" series
    - do we keep or drop changelog entries?
    - could be confusing on netdev for other maintainers but we might
want to keep credits
    - reviewed-by tag + drop changelog?

12625823: New: [mptcp-next,1/6] mptcp: Remove redundant assignments in
path manager init
12625831: New: [mptcp-next,2/6] mptcp: Add a member to mptcp_pm_data to
track kernel vs userspace mode
12625825: New: [mptcp-next,3/6] mptcp: Bypass kernel PM when userspace
PM is enabled
12625827: New: [mptcp-next,4/6] mptcp: Make kernel path manager check
for userspace-managed sockets
12625829: New: [mptcp-next,5/6] mptcp: Add a per-namespace sysctl to set
the default path manager type
12625833: New: [mptcp-next,6/6] selftests: mptcp: Add tests for
userspace PM type:
    - mptcp: Add userspace PM mode to bypass kernel PM
    - new version after the RFC one
    - Needs to be reviewed

12626855: New: [iproute2-next] mptcp: add support for fullmesh flag:
    - Needs to be reviewed
    - Good time to improve the man page about the Netlink PM and how the
different parameters work

12627073: New: [mptcp-next,v2] mptcp: allow changing the "backup" bit by
endpoint id:
    - Needs to be reviewed



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 239)

  241  Force fallback to TCP [question]:
      - Use case: some networks would not be "allowed" to use MPTCP, a
fallback would then be forced from the PM
      - Looks like it should not be done from the PM, out of scope.
      - That's typically the job of a firewall (netfilter rules)
      - Still: why MPTCP would be a problem in some "untrusted" networks?:
      - except if this network is known to alter MPTCP connections.
      - Matth: taking care of that → Done


    Bugs (opened, flagged as "bug" and assigned)

  239  [syzkaller] general protection fault in inet_csk_accept (called
by mptcp_accept) [bug] @pabeni:
      - hard to debug more, we need a reproducer


    Bugs (opened and flagged as "bug" and not assigned)

  225  selftests: join: "remove subflows and signal" is unstable [bug]
[selftests]
  203  PM: server: accept subflows [bug]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]
   65  packetdrill/fixes: clearing properly the status in
listen()/disconnect [bug]


    In Progress (opened, new feature and assigned)

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @dcaratti

  224  support for `setsockopt(TCP_INQ)` [enhancement] @fw-strlen:
      - See above

  216  The infinite mapping support [enhancement] @geliangtang:
      - See above

  186  Add netlink command support [enhancement] @mjmartineau:
      - See above

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti
   75  BPF: packet scheduler [enhancement] @geliangtang
   74  BPF: path manager [enhancement] @geliangtang


    For later (opened and not assigned assigned)

  241  Force fallback to TCP [question]
  237  can't create backup path  [enhancement] [documentation]
  236  Review supported sockopts list [enhancement]

  235  PM: create new subflow after one got closed [enhancement]:
      - Phil Greenland found some issues and confusing behaviours and
explained them on the ML
      - Paolo would like to have a look at these issues
      - Ideally we would need more feedback from Phil and create 2 new
tickets

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
   59  TFO support [enhancement]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   48  MP_FASTCLOSE support (send part remaining) [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]
   18  allow 'force to MPTCP' mode: sysctl [enhancement]


    Recently closed (since last week)

   240  Infinite retransmission on the first failed packet



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.17):
https://github.com/multipath-tcp/mptcp_net-next/projects/12
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - net:
        - mptcp: fix delack timer:
            - Paolo will do that

    - net-next:
        - support of new socket options (IP_TOS, freebind, transparent):
            - Mat will look at that



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - Some new warning in the network stack but it looks like they
are not related to MPTCP
        - A lot of traces but Mat will double check if MPTCP is involved
or not
        - could be interesting to enable KCSAN config → it conflicts
with KASAN

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - Getting build report, seems all good
        - Some reports are sent to MPTCP ML:
            - do we want to keep them?
            - or only to some people?

    - packetdrill (Davide):
        - Davide is working on different PR
        - Main point is about "packets not belonging to one socket",
annoying error

    - Patchew (Davide):
        - one pending item: not re-applying patches + recreate tags when
a Git tag is sent in a reply (Acked-by, etc.)
        - Matth will send a patch:
https://github.com/patchew-project/patchew/blob/master/mods/git.py#L109
        - Patchew importer has crashed this week but now restarted

    - CI (Matth):
        - enable KCSAN config? maybe not as it conflicts with KASAN or a
3rd build?
        - good it detects issues when CONFIG_SYSCTL is not set (not the
first time)



Netlink PM events:
    - Add info (new netlink attribute) about the type of connection
(connect/accept)
    - The userspace PM might want to react differently for servers and
clients and it is not "nice" to retrieve this info via another channel
while it could be useful
    - TODO: Matth: create a new ticket for that → issues/246
    - Linked to https://github.com/multipath-tcp/mptcp/issues/451


OpenEuler Summit 2021:
    -
https://live.issmart.com.cn/Live/issmart_live/#/pc?eventId=5482&liveId=0a15532b&lang=cn&utm_source=live
    - There are 8 topics in it, all in Chinese, and my talk
(Introduction to MPTCP) was the first one, about 20 minutes.
    - TODO: Matth: add it to the wiki page → Done
    - Many Chinese companies seem interested and would like to use it



Next meeting:
    - On Thursday, the 25th of November.
    - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20211125



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
