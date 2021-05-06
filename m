Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C5272
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 20:01:38 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id m12so10135781eja.2
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 13:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=cQwriYJXenHDunsHB+ngBNloFlto+fj0IhsjqmHkc0Q=;
        b=W35yGo7cs78aobFZGgp/oViCWmY+M9xosliASf3f7GujktS7ZKTFWq9Mix0FL3/k/T
         cxZHaZ62djqhWQI+vZotnCDpJkTRe0TuBh7V7YSDDouKd0aosvO+uFEZLE4BwXlo+nBk
         Fi/DtwkKk5Ekq8EGFhVffO9OrnCmzjxetRW9NHbTMqjRe6LJCTRnhPCC/DgjfgL9Sno6
         kYCzukwIGlzhP1r0N805TB/3d5CIXf1rDu0hC1fcetQckiP+eKX3O8rYpP08bazszHgj
         YruQyBRlRbkkEZexisQF8zVDDtMchp/WooLz1G4GMktzLNWmUXE4xb5KZhhToaSQhvkJ
         LtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=cQwriYJXenHDunsHB+ngBNloFlto+fj0IhsjqmHkc0Q=;
        b=RBeNdzNch1zEM2cvYQ9pqGK7WHHIdoiAG85G2QRs3H+mUFwJFrIHrCXh8n7/uoPuYr
         TKJNdf+zgF405veCoQys4uHU1YshIs9WYITMaWckABG777HJiQBnWspTAtmgKQBjrgnA
         8tDLveTVy2GC8xScYlvIAsHk95BrGfO+VioPrGJ966nNwma76cMYJCryRpa68EtC+F/Q
         OXW+8WwfluorDEFa1MJSr7teGR/aTdWpVLrIojMYYznzUmBpkcB57sDzxVfdRH54oKCr
         7VFTaILm4mVgfHqJwML/O7vPfIvFtAY8nmeZGYm3PnR6HjLsmLTr3nh3gyTGcmSZjKTT
         IomA==
X-Gm-Message-State: AOAM530rmlpXhzVCSGt/R10qG8rehpIo/2F7By/D7LZXx1Fv+JuYNggR
	nH7/R6EKMal4ZlJ3gkSoMmzOrA3v6+WRj1hSVno=
X-Google-Smtp-Source: ABdhPJwPVAX7wtN4cr5tN8DMOB+Jjxkkx7qnP060U5j3/HlOg9oEt2AMWCYXvPyIPqFfkZ1E5R8F5w==
X-Received: by 2002:a17:907:1181:: with SMTP id uz1mr6328195ejb.194.1620331296807;
        Thu, 06 May 2021 13:01:36 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:2955:d350:566e:2ff2])
        by smtp.gmail.com with ESMTPSA id n15sm2080674eje.118.2021.05.06.13.01.36
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 13:01:36 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 6th of May 2021
Message-ID: <80aa7f05-56f6-6031-0b4a-045268060578@tessares.net>
Date: Thu, 6 May 2021 22:01:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hello everyone,

Today, we had our 147th meeting with Mat and Ossama (Intel), Christoph
(Apple), Paolo, Florian and Davide (RedHat), Geliang (Xiaomi) and myself
(Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:


Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.ozlabs.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (Jianguo Wu, Masahiro Yamada):

1471945  [v2] kbuild: replace LANG=C with LC_ALL=C
1469539  [iproute2] mptcp: make sure flag signal is set when add addr
with port


    our repo (by: Florian Westphal, Geliang Tang, Matthieu Baerts, Paolo
Abeni):

1474997  [mptcp-next] Squash to "mptcp: dump csum fields in
mptcp_dump_mpext"
1474908  [mptcp-next] Squash to "mptcp: add a new sysctl checksum_enabled"

1474835  [v2,mptcp-next,5/5] Squash to "selftests: mptcp: enable
checksum in m...
1474834  [v2,mptcp-next,4/5] mptcp: dump csum fields in mptcp_dump_mpext
1474833  [v2,mptcp-next,3/5] Squash to "mptcp: add a new sysctl
checksum_enabl...
1474832  [v2,mptcp-next,2/5] Squash to "mptcp: add the mib for data
checksum"
1474830  [v2,mptcp-next,1/5] Squash to "mptcp: add csum_reqd in
mptcp_out_opti...

1474037  [v6,mptcp-next,22/22] selftests: mptcp: enable checksum in
mptcp_join...
1474036  [v6,mptcp-next,21/22] selftests: mptcp: enable checksum in
mptcp_conn...
1474035  [v6,mptcp-next,20/22] mptcp: add a new sysctl checksum_enabled
1474034  [v6,mptcp-next,19/22] mptcp: add the mib for data checksum
1474033  [v6,mptcp-next,18/22] mptcp: tune re-injections for csum
enabled mode.
1474032  [v6,mptcp-next,17/22] mptcp: cleanup error path in
subflow_check_data...
1474030  [v6,mptcp-next,16/22] Squash-to: mptcp: validate the data checksum
1474031  [v6,mptcp-next,15/22] mptcp: validate the data checksum
1474028  [v6,mptcp-next,14/22] Squash-to: "mptcp: receive checksum for DSS"
1474029  [v6,mptcp-next,13/22] mptcp: receive checksum for DSS
1474027  [v6,mptcp-next,12/22] Squash-to: "mptcp: receive checksum for
MP_CAPA...
1474026  [v6,mptcp-next,11/22] mptcp: receive checksum for MP_CAPABLE
with data
1474025  [v6,mptcp-next,10/22] mptcp: add csum_reqd in
mptcp_options_received
1474024  [v6,mptcp-next,09/22] mptcp: add sk parameter for
mptcp_parse_option
1474023  [v6,mptcp-next,08/22] Squash-to "mptcp: send out checksum for DSS"
1474022  [v6,mptcp-next,07/22] mptcp: send out checksum for DSS
1474021  [v6,mptcp-next,06/22] Squash-to: "mptcp: send out checksum for
MP_CAP...
1474020  [v6,mptcp-next,05/22] mptcp: send out checksum for MP_CAPABLE
with da...
1474018  [v6,mptcp-next,04/22] mptcp: add csum_reqd in mptcp_out_options
1474019  [v6,mptcp-next,03/22] Squash-to: "mptcp: generate the data
checksum"
1474017  [v6,mptcp-next,02/22] mptcp: generate the data checksum
1474015  [v6,mptcp-next,01/22] mptcp: add csum_enabled in mptcp_sock

1473120  mptcp: fix splat when closing unaccepted socket

1471752  [mptcp-next] mptcp: support SYSCTL only if enabled



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.ozlabs.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Florian Westphal, Geliang Tang):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets:
    - WIP

1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support:
    - WIP

1395128: RFC: [1/5] tcp: make two mptcp helpers available to tcp stack
1395133: RFC: [5/5] mptcp: send fastclose if userspace closes socket
with unread data:
    - WIP

1450496: RFC: [RFC,2/2] mptcp: add MP_FAIL support:
    - TODO: superseded → done

1471287: Changes Requested: Squash to "mptcp: add sysctl
allow_join_initial_addr_port":
    - superseded

1474803: New: [v4,mptcp-next,1/4] mptcp: add sysctl
allow_join_initial_addr_port
1474804: New: [v4,mptcp-next,2/4] mptcp: add allow_join_id0 in
mptcp_out_options
1474805: New: [v4,mptcp-next,3/4] mptcp: add deny_join_id0 in
mptcp_options_received
1474806: New: [v4,mptcp-next,4/4] selftests: mptcp: add deny_join_id0
testcases:
    - Needs reviewed

1474821: New: [mptcp-next,1/3] mptcp: MP_FAIL suboption sending
1474822: New: [mptcp-next,2/3] mptcp: MP_FAIL suboption receiving
1474823: New: [mptcp-next,3/3] mptcp: send out MP_FAIL when data
checksum fail:
1474938: New: [mptcp-next] Squash to "mptcp: add sysctl
allow_join_initial_addr_port"
    - Has been rebased on top of latest export branch with csum support
    - Needs reviewed

1474900: New: [mptcp-next,1/8] mptcp: enable busypoll from mptcp receive
path
1474899: New: [mptcp-next,2/8] sock: expose so_timestamp options for mptcp
1474901: New: [mptcp-next,3/8] sock: expose so_timestamping options for
mptcp
1474902: New: [mptcp-next,4/8] mptcp: sockopt: propagate timestamp
request to subflows
1474903: New: [mptcp-next,5/8] mptcp: setsockopt: handle SOL_SOCKET in
one place only
1474904: New: [mptcp-next,6/8] tcp: export timestamp helpers for mptcp
1474905: New: [mptcp-next,7/8] mptcp: receive path cmsg support
1474906: New: [mptcp-next,8/8] selftests: mptcp_connect: add
SO_TIMESTAMPNS cmsg support:
    - one part is missing to export <?> in TCP option
    - Need to be adapted for MPTCP
    - But that's fine, this series can be merged without this patch



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 185)

  190  Wireshark doesn't understand MP_CAPABLE C flag:
      - Because it is MPTCP v1 specific
      - TODO: add label → done

  189  Wireshark / TCPDump doesn't understand option subtype 8
(MP_TCPRST) [enhancement]:
      - Because it is MPTCP v1 specific

  188  Netlink events for MP_TCPRST [enhancement]:
      - to see them with 'ip mptcp monitor'

  187  add recvmsg support for ancillary data [enhancement] @fw-strlen:
      - linked to "add cmsg support to receive path" patch series

  186  Add netlink command support [enhancement] @mjmartineau:
      - We have the events, we need the commands for a userspace PM


    Bugs (opened, flagged as "bug" and assigned)

  178  Server hang when proxying over multiple subflows [bug] [v5.11]
[v5.12] @pabeni:
      - Help needed:
          - other eyes needed
          - more debug patches
      - Root cause is still unknown
      - reporter was really helpful
      - even found reproducers (#172) for other issues :):
          - Note Paolo was not able to repro #172 with the C program

  176  BPF selftest got "fallback to TCP" error [bug] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  182  [syzkaller] KASAN: slab-out-of-bounds Write in
tcp_init_congestion_control [bug] [syzkaller]:
      - Paolo has a patch

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]

  172  WARNING in sk_stream_kill_queues [bug]:
      - Note Paolo was not able to repro #172 with the C program from #178

  137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable
[bug]
  120  [interop] netnext is dropping packets, causing MPTCP-level
retransmissions on mptcp.org [bug]
  107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]
   65  clearing properly the status in listen() [bug]
   56  msk connection state set without msk lock [bug]

    In Progress (opened and assigned)

  187  add recvmsg support for ancillary data [enhancement] @fw-strlen:
      - linked to "add cmsg support to receive path" series

  186  Add netlink command support [enhancement] @mjmartineau

  183  MP_CAPABLE 'C' flag is ignored [enhancement] @geliangtang:
       - Patches have been shared!

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti
  143  Packetdrill: ADD_ADDR for v6 only socket should only contain v6
addresses [enhancement] [packetdrill] @dcaratti

  134  Checksum support [enhancement] @geliangtang:
      - Can be closed!

   96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe

   53  MP_TCPRST support [enhancement] @fw-strlen:
      - Can be closed!

   52  MP_FAIL support [enhancement] @geliangtang:
       - Patches have been shared!


    Recently closed (since last week)

  185  kernel warning when processes exit with unaccepted connections in
the backlog [bug] @fw-strlen



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.14):
https://github.com/multipath-tcp/mptcp_net-next/projects/9
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4
    - TODO: Matth: update changelog wiki page



Checksum:
    - RFC compliance: mptcp.org csum implementation might not respect
RFC 8684?
    - All good, everything OK in both implementations
    - interop tests could be nice



Patches to send to netdev:
    - net:
        - Mat is going to send: "mptcp: fix splat when closing
unaccepted socket"

    - net-next:
        - / closed



Extra tests:
    - news about Syzkaller? (Christoph):
        - Has just been updated to today's export branch
        - Christoph might not be able to look at the results for the
next few weeks

    - news about interop with mptcp.org? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - no new failures
        - still testing the export branch → spot an issue (after GH but
that's good :) )
        - Mat: check not to send emails to the previous ML

    - packetdrill (Davide):
        - Davide sent a new PR:
            - same server test for v4 and v6 instead of duplicating them
            - Matth will look at reviewing it
        - Davide has a script to add at any point more endpoints /
signal / ...
        - We can increase the coverage thanks to that!
        - MP_RST → found an issue but it needs more investigation

    - CI (Matth):
        - /



Patchew:
    - discussions have been started
    - Paolo Bonzini is going to create a new MPTCP account
    - Davide will look at populating the DB
    - Matth will look at publishing results once tests have been started



Patchwork:
    - move to kernel.org?:
        - email add-ons:
https://addons.thunderbird.net/fr/thunderbird/addon/seams/
        - find a patch: git-pw / pwclient
        - link with lore: link at the top
        - newer version: 2.2.2 vs 2.2.0
        - faster: for some people
    - Mat will ask if we can be hosted on kernel.org
    - patchwork.ozlab.org can be used in "read" mode



Allow apps to use MPTCP without modifying them:
    - Could be nice to include something in mptcpd:
        - using systemd to do the LD_PRELOAD
        - if it is in mptcpd, it would be easier to distribute (already
packaged in Fedora)
        - OK for Ossama

    - Other possibility:
        - sysctl to force all TCP sockets to be used MPTCP
        - would be good to have it in the export branch to ease testing
        - Florian is going to look at that



Next meeting:
    - On Thursday, the 13th of May.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210513



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
