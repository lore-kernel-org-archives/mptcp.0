Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675232C9D
	for <mptcp@lists.linux.dev>; Thu,  2 Dec 2021 17:42:30 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id o20so1044955eds.10
        for <mptcp@lists.linux.dev>; Thu, 02 Dec 2021 09:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=Y8tNSGvm7//GYTHTv6FUkMG01FwKWZ8esfZEwpR5/JY=;
        b=5GfIw3NxYWfTxfakW1wYUZf/nUPZQgrEidvpH7sOsMjhJ0l7ohrmz5tfEFqoXAi6OG
         dw3qL9FI/GFESAfRyFAeFjN7kZ8cqrSsyCUqoxNmXE+AnvpztF9P/2i1dH54aHQZ/Nb9
         FpeWdHscM1K2ViszwUtU6u2sYyfsm3n+JSAkCkbGn4wFDhYDIy63h2wGFVoXK3VGK5Sm
         gky4SMfyZVxx95TXx1fSQSTOUR/B9rNnTHY5l3M6dtO8SdNm+Utqu6t/Wo7pc7bkLyh9
         wSZLqaeijtLopSF2v2i2rlooNPN2guXdYhGjdI/Me4zRCj1Omh2vGkME8ObXyLdaZtkc
         EEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=Y8tNSGvm7//GYTHTv6FUkMG01FwKWZ8esfZEwpR5/JY=;
        b=3JjN8PJxaijdpNWyxdo9yhfBBl8eREPNSmRsefH5nr6+6Vx+osPoDZpPK91dtWihTf
         dw5JCorskU+rvLJ+osTovoHgemIcR3Jlh4oO7GZEGJPjBUv5LjfhbHTJpzGFOe8UBuCO
         /KMlsa7IsP6nihRtyqRXJ/t6WZeZdLJ7s6wF+cgeLihxk3BJl4clsO0QrvVQh45mFKbC
         SO8sE2V3ZtXQ27k4HYKf0YL1OsQrtdrCugvWtDZP2VTOuC5Ec7cEFtTay6Ev60OpgOpn
         7+FOQmGwTE9X/tmRSkwmOMfkYxh/4GCh0YZCaJdOibbAmSiGHMBuLyapvNPBDPregcce
         owKg==
X-Gm-Message-State: AOAM532vT4kY9NMdzdo0pncq0Axjn42sWy/UnwmuYAOfzKzELPx9iYuK
	HT87CYGNoM6sht3KolfnbdTYTaJTu95lEzk0DMc=
X-Google-Smtp-Source: ABdhPJy16ummyqTjhtX9pHBQJG+7Y+sctixUAYTQLbOGhogUGwvC9EvmWAuFXUM+p3fyyFXAlYMVTQ==
X-Received: by 2002:a17:907:1626:: with SMTP id hb38mr17128589ejc.481.1638466948226;
        Thu, 02 Dec 2021 09:42:28 -0800 (PST)
Received: from [192.168.178.33] ([213.211.142.51])
        by smtp.gmail.com with ESMTPSA id sa17sm327413ejc.123.2021.12.02.09.42.27
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 09:42:27 -0800 (PST)
Message-ID: <2391147c-2480-5188-d538-595727e01b05@tessares.net>
Date: Thu, 2 Dec 2021 18:42:27 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 2nd of December 2021
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Today, we just had our 175th meeting with Mat, Ossama, Kishen (Intel),
Paolo, Davide, Florian (Red Hat), Giray (Parkyeri) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Maxim Galaganov):

12633583  [mptcp-next,3/3] mptcp: support TCP_CORK and TCP_NODELAY
12633585  [mptcp-next,2/3] mptcp: expose mptcp_check_and_set_pending
12633517  [mptcp-next,1/3] tcp: expose __tcp_sock_set_cork and
__tcp_sock_set_n...



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Paolo Abeni):

12640381  [iproute2-next] mptcp: add support for fullmesh flag:
    - probably normal if it takes a bit more time for upstream to review it


    our repo (by: Davide Caratti, Dmytro Shytyi, Geliang Tang, Jiapeng
Chong, Kishen Maloor, Mat Martineau, Matthieu Baerts, Maxim Galaganov,
Paolo Abeni):

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
    - v1 should come soon with selftests

12576993: Changes Requested: [net-next,v1] net: mptcp, Fast Open Mechanism:
    - WIP?

12640309: Changes Requested: [iproute2-next] mptcp: add support for
changing the backup flag:
    - Davide will send it upstream

12640583: Changes Requested: [v2,mptcp-next,1/4] mptcp: clean-up MPJ
option writing.
12640587: Changes Requested: [v2,mptcp-next,2/4] mptcp: keep track of
used local endpoint
12640589: Changes Requested: [v2,mptcp-next,3/4] mptcp: do not block
subflows creation on errors
12640591: Changes Requested: [v2,mptcp-next,4/4] selftests: mptcp: add
tests for subflow creation failure:
    - root cause is in counters linked to this patch
    - Paolo is working on a v3

12647781: Queued: [mptcp-net] mptcp: add missing documented NL params:
    - TODO Matth: to apply

12651125: Queued: [mptcp-net] mptcp: fix deadlock in __mptcp_push_pending():
    - TODO Matth: to apply

12651433: New: [mptcp-next,v2,1/6] mptcp: Remove redundant assignments
in path manager init
12651437: New: [mptcp-next,v2,2/6] mptcp: Add a member to mptcp_pm_data
to track kernel vs userspace mode
12651435: New: [mptcp-next,v2,3/6] mptcp: Bypass kernel PM when
userspace PM is enabled
12651441: New: [mptcp-next,v2,4/6] mptcp: Make kernel path manager check
for userspace-managed sockets
12651439: New: [mptcp-next,v2,5/6] mptcp: Add a per-namespace sysctl to
set the default path manager type
12651443: New: [mptcp-next,v2,6/6] selftests: mptcp: Add tests for
userspace PM type:
    - few small changes with v1 + rebase
    - To be reviewed

12651839: New: [mptcp-next,v5,1/2] Squash to "mptcp: implement fastclose
xmit path"
12651841: New: [mptcp-next,v5,2/2] mptcp: print out reset infos of MP_RST:
    - Can we have DSS and MP_FAIL?
    - Or does it make sense?
    - maybe best to stick with v4?

12652215: New: [mptcp-next,v3] selftests: mptcp: add mp_fail testcases:
    - To be reviewed


Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 242)

  246  Netlink PM events: add one attribute about the connection type
(connect/accept) [enhancement]:
      - Linked to a previous discussion we had: the userspace PM might
needs to know if a new connection/subflow is an incoming or outgoing one.

  245  Packetdrill: Injected ADD_ADDR echo doesn't have the right info
[bug] [packetdrill] @dcaratti:
      - It looks like an issue on Packetdrill side, currently not
affecting the tests (maybe a sign we don't test that properly :) )

  244  Deadlock in mptcp_sockopt_sync_all():
      - linked to "mptcp: fix deadlock in __mptcp_push_pending()" patch


    Bugs (opened, flagged as "bug" and assigned)

  245  Packetdrill: Injected ADD_ADDR echo doesn't have the right info
[bug] [packetdrill] @dcaratti:
      - See above

  242  Unexpected subflow management behaviour, following endpoint add
after subflow failure [bug] @pabeni:
      - Linked to "mptcp: improve subflow creation on errors" series

  239  [syzkaller] general protection fault in inet_csk_accept (called
by mptcp_accept) [bug] @pabeni:
      - No reproducer or new case found
      - Matth: TODO: to be closed → Done


    Bugs (opened and flagged as "bug" and not assigned)

  225  selftests: join: "remove subflows and signal" is unstable [bug]
[selftests]

  203  PM: server: accept subflows [bug]:
      - Kishen looked at it
      - Easier to discuss about that with Kishen or with the patches

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]
   65  packetdrill/fixes: clearing properly the status in
listen()/disconnect [bug]


    In Progress (opened, new feature and assigned)

  235  PM: create new subflow after one got closed [enhancement] @pabeni
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @dcaratti

  216  The infinite mapping support [enhancement] @geliangtang:
      - See above

  186  Add netlink command support [enhancement] @mjmartineau:
      - See above

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti:
      - See above
      - When the patch is sent to netdev, *Davide* will close the ticket

   75  BPF: packet scheduler [enhancement] @geliangtang
   74  BPF: path manager [enhancement] @geliangtang


    For later (opened and not assigned assigned)

  246  Netlink PM events: add one attribute about the connection type
(connect/accept) [enhancement]
  244  Deadlock in mptcp_sockopt_sync_all()
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

  243  sockopt: support TCP_CORK and TCP_NODELAY [enhancement]
  237  can't create backup path  [enhancement] [documentation]
   18  allow 'force to MPTCP' mode: sysctl [enhancement]



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.17):
https://github.com/multipath-tcp/mptcp_net-next/projects/12
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - net:
        - 2 patches are pending (to be applied)
        - Can be sent early next week

    - net-next:
        - infinite mapping support:
            - 2nd test missing, best to wait
        - not "mptcp: implement fastclose xmit path":
            - pending Squash-to patch
        - We can send the new sockopt:
            - from Florian and Maxime


TODO: Matth:
    - rename "mptcp: add disconnect selftests" to "selftests: mptcp: add
disconnect tests"
    - Done: fe66338c3cd8: tg:msg: add 'selftests' prefix


Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - Was running with KCSAN
        - Didn't find anything related to MPTCP (but found a lot of
other ones)
        - Now running without KCSAN

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - Saw one mptcp_join.sh failure but probably already seen by the
public CI (unstable test)


    - packetdrill (Davide):
        - See above

    - Patchew (Davide):
        - workaround in place

    - CI (Matth):
        - Enable KFENCE → supposed to be cheap → maybe in the "non
debug" build as "KASAN" should be better
        - And KMEMLEAK but only in "debug":
            - explicitly enable some options → make menuconfig to see
the different options, e.g. enable at boot time
            - + start a scan at the end and read the scan
        -  https://www.kernel.org/doc/html/latest/dev-tools/kmemleak.html
        - CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=n



Next meeting:
    - On Thursday, the 9th of December.
    - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20211209



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
