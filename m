Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51262C81
	for <mptcp@lists.linux.dev>; Thu, 14 Oct 2021 10:37:59 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id d3so22275015edp.3
        for <mptcp@lists.linux.dev>; Thu, 14 Oct 2021 03:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=U/6bRhtSOAwbmtgSUK9ECYXzU3m7kXV7v5JicqhicNc=;
        b=solY2lIN5J5wb3snc+TnGqvd0rYImEeMn9WLQVDKQw04icGqhw6U4IWNPBMX0Uz6U4
         d+3MVYHJW104U1KZNsq1sNcQHfLj3bX6cbKFvwaqy6TBMf0EPcm6u35MyWXnVKhdzI86
         o1wnVgFvMFrn5OggvjiAlG4sjBcIb7SwYlIy08CMOCcqoRf6fjsE0EMLpW2W4j/cAOSG
         Mgy4AIbDQnGbaB3Zu4w5xnL1HZ+L2/cBNyVh1j9t9rFnHtW32gLYGJS6fHTCnttLVgmt
         1lSuWVa7nCtpmbKgwx5ZyAZp+9FltX1a5IiTrlYgytWpvfw5TE2m4xN0zm0O6ZQN92cI
         CY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=U/6bRhtSOAwbmtgSUK9ECYXzU3m7kXV7v5JicqhicNc=;
        b=wHJ5tsK55iQmNKYqT9PSZdq50GuMnVZDw4N6c8sIu+Dm+Wm6FFsJv5dj1Th2bMB1RJ
         er1PDHSmHprbNbVfPHNv/NXij2s6OuU+3OOvRdk0jWhQ82Ntct0QgptTfeKmzlIZ7e9e
         IoVeXhUMJT72I1RUWd0vrVxLyP80uCv5WGeFwSxBpgqqsgq4Q6Fyecin+zCN7t0GBgmW
         jI9jAGhjPSoXL+zNKT2C4L2ns7bUQ7d3Pzbh3Mo1Tsn997W98EtKV92c0mTEOmK8wUz/
         9d6nVaMAcXcQIb/6i/Qo8wr9/CUivgBpDmN/zltIaG7M33ICHthbakXJqcCvyJQuZwZP
         doRA==
X-Gm-Message-State: AOAM533AVXESfhde0Yi/ZpGivww4vRXOlwrL+tEJcCiEyuFb8vFk/UoK
	w10NKEN/92S8g9hTj3Bs3xNnVCf/dBWQNQ==
X-Google-Smtp-Source: ABdhPJyIYjei65L0kQC4EL7+DA9rtHt9vt9NUddCfSytTxjcbq6tMsjihl27f8IjX/1vhk3PTyynEQ==
X-Received: by 2002:a17:906:ae14:: with SMTP id le20mr2924176ejb.89.1634207877143;
        Thu, 14 Oct 2021 03:37:57 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id u23sm1681372ejx.99.2021.10.14.03.37.56
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 03:37:56 -0700 (PDT)
Message-ID: <1468e5e5-b021-52cd-ab7b-0fcff2d10da0@tessares.net>
Date: Thu, 14 Oct 2021 12:37:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 7th of October 2021
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 168th meeting with Mat, Ossama, Kishen
(Intel), Florian, Paolo, Poorva (Red Hat), Geliang (Xiaomi), Giray
Pultar (Observer) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: /):

/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Davide Caratti):

12528673  [iproute2] mptcp: unbreak JSON endpoint list


    our repo (by: Geliang Tang, Jiapeng Chong, Kishen Maloor, Mat
Martineau, Matthieu Baerts, Paolo Abeni, Tim Gardner):

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

12476757: RFC: [RFC] selftests: mptcp: tune timeout and delay for
simult_flows cases:
    - WIP

12505753: Changes Requested: [next] mptcp: Avoid NULL dereference in
mptcp_getsockopt_subflow_addrs():
    - Mat will follow up on that
    - We can keep the SoB and send a v2

12524801: Changes Requested: [mptcp-next,v6,1/9] mptcp: don't send RST
for single subflow
12524803: Changes Requested: [mptcp-next,v6,2/9] mptcp: add the fallback
check
12524805: Changes Requested: [mptcp-next,v6,3/9] mptcp: track and update
contiguous data status
12524807: Changes Requested: [mptcp-next,v6,4/9] mptcp: add
last_ack_dss_start in the msk
12524809: Changes Requested: [mptcp-next,v6,5/9] mptcp: infinite mapping
sending
12524811: Changes Requested: [mptcp-next,v6,6/9] mptcp: infinite mapping
receiving
12524813: Changes Requested: [mptcp-next,v6,7/9] mptcp: add mib for
infinite map sending
12524815: Changes Requested: [mptcp-next,v6,8/9] selftests: mptcp: add
infinite map mibs check
12524817: Changes Requested: [mptcp-next,v6,9/9] DO-NOT-MERGE: mptcp:
mp_fail test:
    - WIP

12537245: RFC: [RFC] mptcp: allocate fwd memory separatelly on the rx
and tx path:
    - a new version is expected but it is important to note that the rx
and tx path are cleaner here but still it might be good to do this
separation for maintainability purposes

12540789: New: [RFC,1/6] mptcp: Add a member to mptcp_pm_data to track
kernel vs userspace mode
12540781: New: [RFC,2/6] mptcp: Bypass kernel PM when userspace PM is
enabled
12540783: New: [RFC,3/6] mptcp: Make kernel path manager check for
userspace-managed sockets
12540791: New: [RFC,4/6] mptcp: Add a per-namespace sysctl to set the
default path manager type
12540787: New: [RFC,5/6] DO-NOT-MERGE: debug: mptcp: Warn on use of
in-kernel PM functions
12540779: New: [RFC,6/6] DO-NOT-MERGE: debug: mptcp: Warn on unexpected
events when userspace PM is active:
    - Series: mptcp: Add userspace PM mode to bypass kernel PM
    - one main question: how do we want to mark a socket as "to be
controlled by the userspace PM":
        - for the moment: sysctl for the default behaviour for future
socket of a net NS
        - also in ↓ series, when a command is used, we force the socket
to be marked as "controlled by the userspace PM"
        - maybe later a socket option to be controlled by the app
(restricted to some socket attributes?)
    - do we want to keep the DO-NOT-MERGE or use tools to check that? We
can also have it conditional
    - sysctl:
        - maybe best to prefix with "pm" to "categorise" sysctl
        - maybe best not to document it as a boolean: just in case we
want new choices later, e.g. a BPF PM

12540931: New: [RFC,1/4] mptcp: pm_netlink: Add MPTCP_PM_CMD_ANNOUNCE
12540933: New: [RFC,2/4] mptcp: selftests: MPTCP_PM_CMD_ANNOUNCE
12540935: New: [RFC,3/4] mptcp: pm_netlink: Add MPTCP_PM_CMD_REMOVE
12540937: New: [RFC,4/4] mptcp: selftests: MPTCP_PM_CMD_REMOVE:
    - Linked to the previous series
    - Series: mptcp: Update netlink interface for userspace PM
    - Two commands added to get some feedback: linked to ADD_ADDR, RM_ADDR
    - Note: Florian looked at these as well:
        - Similar decisions were taken there so it seems we are taking
the right way
        - Florian would like to have a support in packetdrill to let it
easily ask the kernel to send the ADD_ADDR, etc.
        - Mat will look at merging the two series
    - Kishen will look at the other comments
    - About testing:
        - having a way to packetdrill to validate this would be very
good: we could have more extensive tests. Florian can look at that:
            - env var can be used to set the token with an external script
        - but also have some basic tests implemented in selftests:
            - tested by others
            - we can use ss (or others) to retrieve the token and inject
it with pm_nl_ctl
        - we can also add the same support in iproute2:
            - quite simple to add
            - can be useful, also us for debugging
            - seems normal to duplicate this support in both pm_nl_ctl
and iproute2 not to depend on a too recent version of iproute2 for the
selftests ran by others

12540797: New: [mptcp-next] mptcp: Make mptcp_pm_nl_mp_prio_send_ack()
static:
    - just not clear if we need a Fixes tag for such patch
    - Mat will follow-up on this on IRC
    - TODO: Matth: Ask stable Maintainers → Done



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 232)

  234  error in packetdrill when outbound packet contains mpc+datalen
  233  Receiver key overwritten in a packet with mpc+data [bug] @spoorva:
      - both are linked to a discussion we had last week
      - one issue in packetdrill (234) and one in the kernel (233)
      - 233 is in v5.15, best not to wait too long before sending a fix


    Bugs (opened, flagged as "bug" and assigned)

  233  Receiver key overwritten in a packet with mpc+data [bug] @spoorva:
      - See above (prev category)

  231  Static analysis - possible NULL dereference in
mptcp_get_sub_addrs() [bug] @mjmartineau:
      - See above (pending patches)


    Bugs (opened and flagged as "bug" and not assigned)

  225  selftests: join: "remove subflows and signal" is unstable [bug]
[selftests]
  203  PM: server: accept subflows [bug]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]
  137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable
[bug]
   65  packetdrill/fixes: clearing properly the status in
listen()/disconnect [bug]


    In Progress (opened, new feature and assigned)

  216  The infinite mapping support [enhancement] @geliangtang
  186  Add netlink command support [enhancement] @mjmartineau
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti
   75  BPF: packet scheduler [enhancement] @geliangtang


    For later (opened and not assigned assigned)

  234  error in packetdrill when outbound packet contains mpc+datalen
  224  support for `setsockopt(TCP_INQ)` [enhancement]
  222  Netlink event API: add SUBFLOW_CREATED event [enhancement]
  220  support for setsockopt(SOL_IP) [enhancement]
  217  Support `IP_TRANSPARENT` [enhancement]
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
   74  BPF: path manager [enhancement]
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

  232  Kernel Compilation failed  [question]
  230  selftests: mptcp_connect: poll timed_out [bug] [selftests]
  194  Round-robin packet scheduler support [enhancement] @geliangtang




FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.16):
https://github.com/multipath-tcp/mptcp_net-next/projects/11
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - net:
        - we can send "mptcp: fix possible stall on recvmsg()"
        - Mat will do it

    - net-next:
        - /



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - didn't see anything new related to MPTCP

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - Has some internal issues, not related to MPTCP
        - Mat will double-check if it is not because an upstream patch
is missing in our tree

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - Two questions for Davide:
            - What is the "Testing configuration" option?
            - And "Email notification"?
            - → not useful for us to publish tests results from GH
Action and send a notification to the ML when it is done?

    - CI (Matth):
        - /


Patchwork:
    - New status: `Handled Elsewhere`: use it instead of "Deferred"?:
        - More relevant!
        - We can drop Deferred one
    - TODO: Matth: adapt scripts + Wiki → Done



mptcpd:
    - hard to maintain support for both mptcp.org and upstream kernel at
run time
    - it could be a config option later
    - it would make sense to drop mptcp.org support later, e.g. when the
upstream kernel supports the commands



Next meeting:
    - On Thursday, the 14th of October.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20211014



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
