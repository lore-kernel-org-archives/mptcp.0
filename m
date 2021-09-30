Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0E772
	for <mptcp@lists.linux.dev>; Thu, 30 Sep 2021 17:04:53 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id dn26so24652850edb.13
        for <mptcp@lists.linux.dev>; Thu, 30 Sep 2021 10:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=IM3adpfnOnm7U7qvr9bQAokPWUxePDw3L3p9tS+cKRI=;
        b=chnftYx+lPx/FXozVmYcmQEA0QImY16zE5l3FJszDfkRwG7cpY1LoPvz3ps50JkHxy
         7x1qVxG5EWUHv7aqANEjwml5zzhwReI9R4MHiRD7a38EYSqTNWmmrVGGlZ1ul/X39Mss
         lYfToBJY4BqtRbeetYuEssma3q4803IPJPOBlP6tQKtJT/n0yUlDi1/DcRYm7JQlXPu3
         eEFxtqmHb6z2PEcIddbyd0hiEQBJUv9IYEEAm5KSJH3RVjrkO3FCta8oiQgYu+Rjrwld
         /ctpYp72kcQpMVIeJMqRfkmWLCYZaRIFA/Z+d31qwAdqwKCd79QFz9QguHNdHLdHnhDP
         weKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=IM3adpfnOnm7U7qvr9bQAokPWUxePDw3L3p9tS+cKRI=;
        b=DLEEjVd6Rux94lWkGEpkSYWj9yvdJV81D8ZaionvmlAg9sK2VAL/W6GcjwZmbcW4Mr
         iOHQTWuN+8Uw72Il6ba0s+d+9U1rm8URc57llPcUrFnd+c1n7OATJ5xiC1PpMY/LaJvs
         bP392pUKC25pun2ukh/9f7otGTrkqBXBRqAEOYtuNdwzHeezO3JBrEi6DGr93wmPbHtH
         BHWabGdCu2UdTxL8h9GnmaVDbokS4390seBtultp+8UrRpEesfXQznaY8hqT7N6szs7U
         hkACcoYfvsWn3/Zhbh33HH3no078VOESaCO28Xf7PLpHgD44DD5/WMXafRDM7m0xnNJH
         fqww==
X-Gm-Message-State: AOAM531oXsXZb8UehyXXm8+IaIktO73lou03ZrsJKDvTsDAdtQ4okQg+
	b0gos1QYM2DsxL5eodmTcQwwEDeVwZMsWg==
X-Google-Smtp-Source: ABdhPJyR8FL/yEqCNu2uuuo641nsDAXpwV5iventuPdMawYuYoMawbnpSbVh+sLCtyUY+gbmNhE9AA==
X-Received: by 2002:a50:cf4d:: with SMTP id d13mr8350703edk.50.1633021491652;
        Thu, 30 Sep 2021 10:04:51 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.102.72.dyn.edpnet.net. [94.105.102.72])
        by smtp.gmail.com with ESMTPSA id o3sm1700472eju.123.2021.09.30.10.04.51
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 10:04:51 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 30th of September 2021
Message-ID: <a95ba730-0ece-595b-01c4-e4ac6f285b08@tessares.net>
Date: Thu, 30 Sep 2021 19:04:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 167th meeting with Mat, Ossama, Kishen
(Intel), Florian, Paolo, Davide, Poorva (Red Hat), Geliang (Xiaomi) and
myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau, Paolo Abeni):

12525181  [net] net: introduce and use lock_sock_fast_nested()

12516843  [net-next,5/5] mptcp: re-arm retransmit timer if data is pending
12516841  [net-next,4/5] mptcp: remove tx_pending_data
12516835  [net-next,3/5] mptcp: use lockdep_assert_held_once() instead
of open-...
12516839  [net-next,2/5] mptcp: use OPTIONS_MPTCP_MPC
12516837  [net-next,1/5] mptcp: do not shrink snd_nxt when recovering

12513785  [net,2/2] mptcp: allow changing the 'backup' bit when no
sockets are ...
12513787  [net,1/2] mptcp: don't return sockets in foreign netns



    our repo (by: Davide Caratti, Paolo Abeni):

12515579  [v2,mptcp-net] net: introduce and use lock_sock_fast_nested()

12510723  [mptcp-net,v2] mptcp: allow changing the 'backup' bit when no
sockets...

12507729  [mptcp-next,v2,3/3] tcp: make tcp_build_frag() static
12507725  [mptcp-next,v2,2/3] Squash-to: "mptcp: stop relying on
tcp_tx_skb_cac...
12507727  [mptcp-next,v2,1/3] Squash-to: "tcp: expose the
tcp_mark_push() and s...



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Jiapeng Chong, Matthieu Baerts, Paolo
Abeni, Tim Gardner):

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
    - TODO → see ticket #231

12523681: Queued: [v3,mptcp-net] mptcp: fix possible stall on recvmsg():
    - Matth: TODO → Done

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
    - The infinite mapping support
    - New version expected
    - v7 is nearly ready, but it will be delayed because of National Day
holiday next week.



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 231)

  232  Kernel Compilation failed:
      - Not related to MPTCP
      - TODO: Matth: Can be closed, the fix will land soon in net-next →
Done
      - (or we can add it in export branch if blocking)


    Bugs (opened, flagged as "bug" and assigned)

  231  Static analysis - possible NULL dereference in
mptcp_get_sub_addrs() [bug] @mjmartineau:
      - Paolo gave some advices
      - Mat will look at that


    Bugs (opened and flagged as "bug" and not assigned)

  230  selftests: mptcp_connect: poll timed_out [bug] [selftests]
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

  194  Round-robin packet scheduler support [enhancement] @geliangtang:
      - TODO: Matth: close this one, see notes from last week → Done

  186  Add netlink command support [enhancement] @mjmartineau:
      - for ADD_ADDR, we need to handle ECHO ones
      - for the moment, we only handle the retransmission of one ADD_ADDR:
          - either we have a new events to tell the userspace when to
send the next one (when the echo has been received)
          - or the userspace is in charge of the retransmissions
          - or we keep a list of ADD_ADDR to retransmit (can be done as
a second step)
      - We decided to let the kernel managing that: no need to add a new
event for that
      - (if needed, managing a list of ADD_ADDR can be done later)

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti

    For later (opened and not assigned assigned)

  232  Kernel Compilation failed
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
   75  BPF: packet scheduler [enhancement]
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

None.


PM: default settings:
    - Would be good to increase the default values for additional
subflows allowed
    - Not the announced add-address and how to react when we receive one
    - for both client and server
    - → Paolo will look at that


FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.16):
https://github.com/multipath-tcp/mptcp_net-next/projects/11
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4
    - TODO: changelog: Matth



Patches to send to netdev:
    - net:
        - /

    - net-next:
        - /



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - Syzkaller found something but not clear if it is related to
MPTCP (subflow) or not.
        - Mat will look at that

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - Some issues on kbuild's side but not related to MPTCP
        - Looks like first build in some time is in progress but has
stalled in non-MPTCP selftests

    - packetdrill (Davide):
        - One issue fixed by Davide, found by the public CI
        - Some issues with ADD_ADDR, Davide is looking at that, maybe we
need to allow more delay
        - Davide is looking at the RM_ADDR handling but facing
        - MPC with data and checksum (outbound packets):
            - the server key is overwritten → kernel issue
            - the TCP option are not aligned → packetdrill issue
            - → Poorva is going to open 2 separated tickets for that

    - Patchew (Davide):
        - Migrated to the official repo
        - Patchew is showing when the tag applied (+ link)
        - If you follow the link, on Github you can see the test results

        - For Cirrus:
            - if tests are failing, the build will likely be marked as
success (except if there is a crash or compilation issue, etc.)
            - In this case, it should report unstable tests but it
doesn't always work
            - Best to look at the "summary" file for the moment.

        - Next steps:
            - We need a GH Action to set the test results on Patchew
            - and it should also send a notification, e.g. an email on
the ML
            - but we also need to fix tests...

    - CI (Matth):
        - Had warning before applying "net: introduce and use
lock_sock_fast_nested()"
        - But that's normal: bug visible since the introduction of
another patch, see commit message of ↑



mptcpd 0.8:
    - New release \o/
    - Paolo tested it with an upstream kernel and it seems working well



Next meeting:
    - On Thursday, the 7th of October.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20211007



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
