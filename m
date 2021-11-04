Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132032C99
	for <mptcp@lists.linux.dev>; Thu,  4 Nov 2021 20:01:37 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id j21so25243366edt.11
        for <mptcp@lists.linux.dev>; Thu, 04 Nov 2021 13:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=zk0T4plUN6Bx0OzWxdNDX/dJVP0RDMtmt83V+maG0gk=;
        b=IGn/R/4H63XxFOf+DZV9J5azTSwb+9a3gARdHjhgLWux8ke6jWTY2kAiqX20l3jK3c
         h9Fk3Y5WnVoIH7pKtcA4P0GRcSF80uv/nk/Q2r2HplRFN9BRJG84Bugry+rtozaqVJLN
         GRNi6DWs37j9HBj7HI9Y9Om/nfe3BbS3FlXV8QaCpuc8lKqmRDpaPlajI9ij9yZz1Fnk
         5xDdYxyLZor7TaRXTBuQlBji9SwtMt92ILBcyvsKLZz6CXHMxFT43Af03ZiW275KFGe6
         rDKkYDXLPuXI2vEgVhAVG8ZJJva2queVEhdJTss8qoGYuFjAZXpm+MKnh09tKILSrJFD
         CzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=zk0T4plUN6Bx0OzWxdNDX/dJVP0RDMtmt83V+maG0gk=;
        b=Btes8jIcDKL/KAAN31PL7L0JsTraBODOmHs5OaWmqN6pIda5s9QQnR51eZ6nHivFuy
         IOKkzqX76Swt9XyIN+bBOz4iSHS/JS9dxUSKorYvWBZ+Xrut1dFQDfJdT4/HgJ2fIB5e
         SQpbAN9H+XvkWnNNP+yWZA6CziHbLnoLRu4Jx1AKVW+/1UCialC+6VGsYcOTC8A5umk3
         CqqG4rDHbtV53ZMAwY7VubVj5GQkCe7iL5uae+MzO3SEygTUSDjHcIvp00oy+a+9UIyK
         dCuG5z83ZcpXQGdFG23jDS2peToIMKlF4DN8fMpztTPjHw7NGt5mTW7GCkZHd4Q+rxg6
         KvVg==
X-Gm-Message-State: AOAM530Y3xot/pKRo7u8gFBmkLQP2JVIMm5xpNBNvvlxFDiBoZnt6169
	DPBUWzt3bBwmemAWrqrCTbJatFaeVVVie5Ak
X-Google-Smtp-Source: ABdhPJwLBa+Fem/e7CvmFaQq6T4UG0W2Ink4DQ52k/emEL1lVgte0VSxE+ifbwnWU20Nu97dSRunEA==
X-Received: by 2002:aa7:c444:: with SMTP id n4mr3799992edr.6.1636056095463;
        Thu, 04 Nov 2021 13:01:35 -0700 (PDT)
Received: from ?IPV6:2a02:578:85b0:e00:48e3:13c2:9c24:de29? ([2a02:578:85b0:e00:48e3:13c2:9c24:de29])
        by smtp.gmail.com with ESMTPSA id hc10sm3017380ejc.99.2021.11.04.13.01.34
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 13:01:35 -0700 (PDT)
Message-ID: <bde06dc1-cb55-ee32-3711-b13391fb150b@tessares.net>
Date: Thu, 4 Nov 2021 21:01:33 +0100
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
Subject: [Weekly meetings] MoM - 4th of November 2021
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Today, we just had our 172nd meeting with Mat, Ossama, Kishen (Intel),
Paolo, Davide (Red Hat), Geliang (Suse), Giray (Parkyeri) and myself
(Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12594007  [net-next,2/2] selftests: mptcp: more stable simult_flows tests
12594005  [net-next,1/2] selftests: mptcp: fix proto type in
link_failure tests


    our repo (by: Florian Westphal, Paolo Abeni):

12599657  [v2,mptcp-net,2/2] mptcp: use delegate action to schedule 3rd
ack ret...
12599653  [v2,mptcp-net,1/2] mptcp: fix delack timer

12592521  [mptcp-next,v3,2/2] selftests: mptcp: add tproxy test case
12592519  [mptcp-next,v3,1/2] mptcp: sockopt: add SOL_IP freebind &
transparent...

12584373  [v2,mptcp-next] mptcp: enforce HoL-blocking estimation



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Dmytro Shytyi, Geliang Tang, Jiapeng Chong, Kishen
Maloor, Mat Martineau, Matthieu Baerts, Paolo Abeni):

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
    - Series: PM Netlink CMD
    - WIP

12576993: Changes Requested: [net-next,v1] net: mptcp, Fast Open Mechanism:
    - /

12591657: Changes Requested: [mptcp-next,v8,1/8] mptcp: don't send RST
for single subflow
12591659: Changes Requested: [mptcp-next,v8,2/8] mptcp: add the fallback
check
12591661: Changes Requested: [mptcp-next,v8,3/8] mptcp: track and update
contiguous data status
12591663: Changes Requested: [mptcp-next,v8,4/8] mptcp: infinite mapping
sending
12591665: Changes Requested: [mptcp-next,v8,5/8] mptcp: infinite mapping
receiving
12591667: Changes Requested: [mptcp-next,v8,6/8] mptcp: add mib for
infinite map sending
12591669: Changes Requested: [mptcp-next,v8,7/8] selftests: mptcp: add
infinite map mibs check
12591671: Changes Requested: [mptcp-next,v8,8/8] selftests: mptcp: add
mp_fail testcases:
12592523: Changes Requested: [mptcp-next] Squash to "selftests: mptcp:
add mp_fail testcases":
    - There are still discussions on the last patch (8/8)
    - Apply 1->7?:
        - it looks like some more modifications will be needed here,
c.f. discussions with Mat and Christoph on the ML on v7 to drop more
data from the receive queue.
        - we can either apply all first 7 patches or wait for a v9
        - Matth will apply the first 7 patches.

12601389: Rejected: [mptcp-net] mptcp: fix race between close() and
accept():
    - attempt to fix issue 239
    - but not OK because the issue is not caused by the race reported in
the patch (not possible to have that)
    - Paolo is looking for other possible causes and looking for ideas
    - It might help to improve the current mptcp_accept() function:
        - not to acquire 3 locks instead of 1
        - not changing up and down refcounts (ensure that the listener
socket is never deleted before the msk socket itself)
        - not to use BIT for to mark the listener mptcp socket as
readable (e.g. use the listener socket queue instead)
        → it might help to fix such racing issues reported by syzkaller
(disconnected while listening/accepting a connection)
        → also because simpler → faster → easier to maintain
    - separate issue: it looks like the PM could close the listening
socket while closing one subflow:
        - Paolo will create a new issue about that



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 237)

  239  [syzkaller] general protection fault in inet_csk_accept (called
by mptcp_accept) [bug] @pabeni:
      - See above

  238  Packetdrill: Add coverage for setsockopt(SOL_IP, IP_TOS):
      - PR: 71 on Github


    Bugs (opened, flagged as "bug" and assigned)

  239  [syzkaller] general protection fault in inet_csk_accept (called
by mptcp_accept) [bug] @pabeni


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
      - Florian is looking at that
      - There is a packetdrill script test in the repo that will need to
be update:
          - it is there just to make sure an error is properly reported
for an unsupported socktopt

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

  238  Packetdrill: Add coverage for setsockopt(SOL_IP, IP_TOS)
  237  can't create backup path  [enhancement] [documentation]
  236  Review supported sockopts list [enhancement]
  235  PM: create new subflow after one got closed [enhancement]
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

  220  support for setsockopt(SOL_IP) [enhancement]
  217  Support `IP_TRANSPARENT` and `IP_FREEBIND` (TProxy use-case)
[enhancement] @fw-strlen
  137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable
[bug] @pabeni



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.16):
https://github.com/multipath-tcp/mptcp_net-next/projects/11
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4
    - TODO: support 5.17 → Done



Patches to send to netdev:
    - net:
        - "mptcp: fix MPJ 3rd ack retransmissions" series:
            - Probably best to wait a bit more just to check the impact
            - Paolo will send them next week if everything is OK!

    - net-next:
        - / → closed for the moment



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - Issue 239 but no reproducer nor reproduced a second time
        - Now running with CONFIG_PREEMPT.

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - Didn't see any new failures there

    - packetdrill (Davide):
        - Davide is working on supporting MPC+data+checksum

        - PR: mptcp: Add coverage for setsockopt(SOL_IP, IP_TOS):
            - See above: to be reviewed

        - PR: Add explicit test for MPJ 3rd ack retransmission enhancement:
            - Paolo will have a look at the comments there

    - Patchew (Davide):
        - Would be nice to avoid the re-push thing
        - Davide will fill a new issue to know if it is normal and if
not, we will see what we can do
        - Maybe enough to never have this condition:
https://github.com/patchew-project/patchew/blob/master/mods/git.py#L109
        - Similar to
https://github.com/patchew-project/patchew/commit/57132f54a211345d77d72ecb2232d0ea8c604b61

    - CI (Matth):
        - Public CI looks more stable
        - switch to latest IPRoute version 5.15.0



Next meetings:
    - We will be back at 1600 UTC
    - Is it blocking anybody to participate to these meetings?
    - Next meeting will happen in 2 weeks:
        - the one of the 11th of November has been cancelled
        - too many 1 that day... 211111



Next meeting:
    - On Thursday, the /!\ 18th of November.
    - Usual UTC time: /!\ 16:00 UTC (8am PST, 5pm CET, /!\ 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20211118



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday (in 2 weeks),
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
