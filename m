Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAE22C81
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 17:17:50 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id r12so27911040edt.6
        for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 10:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=Pvkfj0/NN9hnQL+/J0rHGLLj4aVmCsqZ4QEVJLGddl8=;
        b=FMf8QlfpDtfN9OxzyYaLGn22qhw0fW2zq2dk6mFpJS2xDG6pI89L/UqviloVSmXJ+6
         qER5VU7lBq5HjSfepTj2AaGWxUjP/Vv0g2W5nuw/XwQFdZkI/qZu2roEf+HE4Wz52w1s
         AYWMbuBJE/6fBuRo0A9O58tIBh+r+JYml53s1r4jRWbW8ceNORT+IxYO5r2fP2/HAZIy
         oGgysTuUsUeSopfv0oRL3F7eCzZbR7psiNMWks0JN4IA2ixtGxw0OK2VXn5r2fOCUMsu
         SwK8ihRixDWKFn5un5hSHSAaP1SjyqSO82plm0INZjPrWXedPHlH1B4wx3ON5kLuY+UE
         HY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=Pvkfj0/NN9hnQL+/J0rHGLLj4aVmCsqZ4QEVJLGddl8=;
        b=2uNsEdTdoNKsyevhyth4Izw/FoJfTAhUZ9K8rb48p9PEquexj1+buVdW7IBSPtx581
         hZfOWNMCxdjJ7jF071GE1nvyD0eKouYMKENOwu/HR4NSLLMxMOFrOXSvfFEKVxJIU0su
         CXwhbcmYPufHM87cSMAEU+sjMf2bDsdzAkCU8DGAOlV5jtIAshZFAU+aAn/9vmwsA1aq
         jxEdpjo63pS2ipbyLzj0oKroZatYYXYir5ii7pLgjD2nVi3z3Zqwul7bccN/tR4LUmqZ
         6jqO+1uSCVjtiWBfp/RdgNHjF1WgferB7GtXKcD+0Xnu6kowfRzsczE1NPorKxiUuv8F
         PgTw==
X-Gm-Message-State: AOAM532crFZJE48XXrTgzzEHmHID7Nj4zr0LoX812kuq5ZIJ0NyC2VXH
	i0zfzSGHeGIy4/x2Ib6HyOyJ0zDrhW3ZKw==
X-Google-Smtp-Source: ABdhPJw8v6bQU51eb8HGiiq4rWHIjcbzhEmZ0rioMIHVYJYdCcEyuzHPyG6zKypSOAsQHdx9oUgDaQ==
X-Received: by 2002:a50:8744:: with SMTP id 4mr7784351edv.100.1635441468554;
        Thu, 28 Oct 2021 10:17:48 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id o3sm1621672eju.123.2021.10.28.10.17.47
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 10:17:48 -0700 (PDT)
Message-ID: <9e420476-b321-81e5-e85f-952df3f2e9ff@tessares.net>
Date: Thu, 28 Oct 2021 19:17:47 +0200
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
Subject: [Weekly meetings] MoM - 28th of October 2021
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Today, we just had our 171st meeting with Mat, Ossama, Kishen (Intel),
Florian, Paolo, Davide, Poorva (Red Hat), Geliang (Suse), Giray
(Parkyeri) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12586019  [net-next,4/4] mptcp: drop unused sk in mptcp_push_release
12586021  [net-next,3/4] mptcp: allocate fwd memory separately on the rx
and tx...
12586017  [net-next,2/4] net: introduce sk_forward_alloc_get()
12586015  [net-next,1/4] tcp: define macros for a couple reclaim thresholds


    our repo (by: Davide Caratti, Poorva Sonparote):

12588089  [mptcp-next,v4,2/2] Support for IP_TOS for MPTCP setsockopt()
12588085  [mptcp-next,v4,1/2] Exposing __ip_sock_set_tos() in ip.h
    - First patches applied in the kernel, congratulations to Poorva!

12584915  [mptcp-net,v2] mptcp: fix corrupt receiver key in MPC + data +
checks...



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12588751  [net] mptcp: fix corrupt receiver key in MPC + data + checksum:
    - has just been applied in -net!


    our repo (by: Dmytro Shytyi, Florian Westphal, Geliang Tang, Jiapeng
Chong, Kishen Maloor, Mat Martineau, Matthieu Baerts, Paolo Abeni):

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

12540789: Changes Requested: [RFC,1/6] mptcp: Add a member to
mptcp_pm_data to track kernel vs userspace mode
12540781: Changes Requested: [RFC,2/6] mptcp: Bypass kernel PM when
userspace PM is enabled
12540783: Changes Requested: [RFC,3/6] mptcp: Make kernel path manager
check for userspace-managed sockets
12540791: Changes Requested: [RFC,4/6] mptcp: Add a per-namespace sysctl
to set the default path manager type
12540787: Changes Requested: [RFC,5/6] DO-NOT-MERGE: debug: mptcp: Warn
on use of in-kernel PM functions
12540779: Changes Requested: [RFC,6/6] DO-NOT-MERGE: debug: mptcp: Warn
on unexpected events when userspace PM is active
12540931: Changes Requested: [RFC,1/4] mptcp: pm_netlink: Add
MPTCP_PM_CMD_ANNOUNCE
12540933: Changes Requested: [RFC,2/4] mptcp: selftests:
MPTCP_PM_CMD_ANNOUNCE
12540935: Changes Requested: [RFC,3/4] mptcp: pm_netlink: Add
MPTCP_PM_CMD_REMOVE
12540937: Changes Requested: [RFC,4/4] mptcp: selftests:
MPTCP_PM_CMD_REMOVE:
    - when an ADD_ADDR is sent:
        - if the port is different, we create another listening socket
to accept MP_JOIN to this new port
        - if the port is the same, we rely on the initial listening
socket and we don't do much:
            - so if the app is doing a listen on a specific IP and an
ADD_ADDR (same port) is sent, we will not create an extra listening
socket and we will not accept the MPJ → user's configuration
        → that's the current behaviour on net-next/net/export
        → seems good but maybe not documented enough

    - other than that: WIP

12566305: Changes Requested: [mptcp-next,v7,1/8] mptcp: don't send RST
for single subflow
12566307: Changes Requested: [mptcp-next,v7,2/8] mptcp: add the fallback
check
12566309: Changes Requested: [mptcp-next,v7,3/8] mptcp: track and update
contiguous data status
12566311: Changes Requested: [mptcp-next,v7,4/8] mptcp: infinite mapping
sending
12566313: Changes Requested: [mptcp-next,v7,5/8] mptcp: infinite mapping
receiving
12566315: Changes Requested: [mptcp-next,v7,6/8] mptcp: add mib for
infinite map sending
12566317: Changes Requested: [mptcp-next,v7,7/8] selftests: mptcp: add
infinite map mibs check
12566319: Changes Requested: [mptcp-next,v7,8/8] DO-NOT-MERGE: mptcp:
mp_fail test
12573975: Changes Requested: [mptcp-next] Squash to "mptcp: infinite
mapping receiving"
12589219: New: [mptcp-next,v2] selftests: mptcp: add mp_fail testcases:
    - almost there, just some details with the selftests

    - one last thing to look at is the 'tc' command:
        - we have a kernel message (pr_info) for each packet not matched
by the pedit action
        - better to restrict to TCP packets with ACK flag only
        - and send only in one direction
        - we should not have plenty messages in dmesg/serial causing
other issues

12576993: Changes Requested: [net-next,v1] net: mptcp, Fast Open Mechanism:
    - first review has been done
    - we need to validate everything is OK, even if we only have one side
    - quite a few bits are missing to fully support the client side,
maybe best to have both client and server sides and start the upstream
of one or validate that with packetdrill (initial support already there)

12584373: Under Review: [v2,mptcp-next] mptcp: enforce HoL-blocking
estimation:
    - Discussions are ongoing with Mat and Paolo regarding how to get
the pacing rate
    - But the tests are highly improved: more stable
    - without the patch, we take the raw value but it is not accurate
    - weighted average seems to be good according to the tests and if
the "raw" pacing changes a lot, we are good but what if there is an
error (very high/low abnormal value)?
    - simple moving average? (avg*3<<2 + new<<2) → the proposed version
is already a moving average so should be OK to cope with "error" and
variability?
    - Discussions to continue on the ML

12589667: New: [mptcp-next,v2,1/2] mptcp: sockopt: add SOL_IP freebind &
transparent options
12589669: New: [mptcp-next,v2,2/2] selftests: mptcp: add tproxy test case:
    - Seems good, Mat will have a look at the tests.

12590075: New: [mptcp-net,1/2] mptcp: fix delack timer
12590077: New: [mptcp-net,2/2] mptcp: use delegate action to schedule
3rd ack retrans:
    - Eric identified an issue with delack timer and suggested the first
patch
    - Paolo found other issues fixed in the 2nd patch but not an easy
way to fix it: we need to use the "delegate action" mechanism for that →
will not be available in the last LTS
    → this explains why we had quite a few MPJ 3rd ack retransmissions
in pcaps



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 236)

  237  can't create backup path  [bug]:
      - config issue + old kernel
      - we should certainly improve the man page/doc about that
      - [TODO] add a note in the ticket about that → Done


    Bugs (opened, flagged as "bug" and assigned)

  234  error in packetdrill when outbound packet contains mpc+datalen
[bug] [packetdrill] @dcaratti:
      - bigger than expected
      - packetdrill needs to understand this new packet (parser, etc.)
      - We can see that more as a new feature: support MPC+DATA+checksum
      - WIP


    Bugs (opened and flagged as "bug" and not assigned)

  237  can't create backup path  [bug]
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

  224  support for `setsockopt(TCP_INQ)` [enhancement] @fw-strlen
  216  The infinite mapping support [enhancement] @geliangtang:
      - See patches above

  186  Add netlink command support [enhancement] @mjmartineau:
      - See patches above

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti
   75  BPF: packet scheduler [enhancement] @geliangtang
   74  BPF: path manager [enhancement] @geliangtang


    For later (opened and not assigned assigned)

  236  Review supported sockopts list [enhancement]
  235  PM: create new subflow after one got closed [enhancement]
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

  233  Receiver key overwritten in a packet with mpc+data [bug] @dcaratti



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.16):
https://github.com/multipath-tcp/mptcp_net-next/projects/11
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - net:
        - maybe "mptcp: fix MPJ 3rd ack retransmissions" series but
still on going
        - "selftests: mptcp: fix proto type in link_failure tests": it
was delayed because the "mptcp: fix corrupt receiver key in MPC + data +
checksum" patch was "more important"

    - net-next:
        - seems good to send: "selftests: mptcp: more stable
simult_flows tests" now



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - Nothing new related with MPTCP
        - has been ran with a couple of different config
(debug/lockproof on and off)
        - CONFIG_PREEMPT should be turn on as well (in some config)

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - patches are queuing build for every modification of the export
branch:
            - they will try to optimise that (all builds with different
kconfig, etc.)

    - packetdrill (Davide):
        - See above

    - Patchew (Davide):
        - Still unclear why it re-pushes patches when new Git "tag"
(Acked-by, etc.) are sent on a patch

    - CI (Matth):
        - now validating checkpatch
        - reports are sent to each patches of the series:
            - individual reports for builds and checkpatches
            - same one for kvm tests
        - from patchwork, you can see the status
        - from there you can click on links to get more details on GH/Cirrus
        - On Github, it you look at details, we now have "sections", e.g.

https://github.com/multipath-tcp/mptcp_net-next/runs/4032785072?check_suite_focus=true



New blog post about MPTCP:
    -
https://developers.redhat.com/articles/2021/10/20/multipath-tcp-rhel-8-one-many-subflows?ts=1635182832561#



Validating sockopts:
    - simple ones like IPv4's TOS:
        - would be good not to modify mptcp_connect (with exceptions)
        - validating them in selftests likely means creating E2E
connections, where we need to send data, having a long enough connection
to check the status in parallel, etc. → quite heavy
        - output of ss might change in the future (or not being the same
in previous versions)
        - so it might be OK to cover "simple" sockopt in packetdrill →
to be checked case by case.

    - more complex ones like MPTCP_INFO:
        - harder to support in packetdrill → makes sense to have it only
in selftests



mptcpd and route check for SF:
    - 2 issues:
        - DHCP doesn't create policy routing (from IP X go to iface Y)
        - an IP is available but the routing rules are not in place yet
    - We should have a way to check we can use IP:
        - route validation → "ip route get from X" is using iface Y?
    - When?
        - Monitor routing events to know when to try?
        - or periodically retrying?



Next meeting:
    - On Thursday, the 4th of October.
    - Usual UTC time: 15:00 UTC (8am PDT, 4pm CST /!\, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20211104



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
