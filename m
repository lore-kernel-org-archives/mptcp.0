Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A504A70
	for <mptcp@lists.linux.dev>; Thu,  1 Apr 2021 16:29:49 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id e7so2607297edu.10
        for <mptcp@lists.linux.dev>; Thu, 01 Apr 2021 09:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=w3ovk51iSeWu1KT1mZOoDnI+O4QIM+gmLyp/HV1/OVQ=;
        b=APLDy76HlxwdjcIQXIlzLsVC2OBp12bX+WyI7bahe8tUvoUAySz0DyjBVpm8DSdAuc
         +8tUkXf3gKyXwlkRydwYsWWQu5fr0Ryhum44aP54xHTUnLm/9xoyU26s1YLytJPt+/6W
         /dITMv1omERhR49SnvwZ9KzUhKD8zwtdFvGam/jhdzsTDWrwgmMyiE7lgXZ+ixnItMny
         TJyFmQH2b28EY9Vzee6GoDRcffeOfLAOl3J2EEoCJQIZhpo1QHs8782io3Q8I9B4wsAH
         waXkUjESEgKh3c+A44/zzvfmfzWKGZkaB3PEfc3Z85u5aYgdYFWN88wuRHhrVisvkU/s
         TAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=w3ovk51iSeWu1KT1mZOoDnI+O4QIM+gmLyp/HV1/OVQ=;
        b=n1iCBE7vjASKGppqmtLlzxuE5asbBMqPQJsL2Y2XT7dm5ABZ6RDXfkpOLcsMTtf/Q1
         alA+V+Wbtn9YdYG3vfy+40/KK9vABz7iGNPWPp5hcBp9c/rVHhlL8KQ3KPm28kdP5nej
         /IHxqIXJnOkD9yR0TFI7NhJY4o1PzCZ/2LgVcWAWqPjYIFKQuRxtj8KsCrekXln0SI96
         KkPkPGn3L3QY0x5pPAcUMlG0RneVDW+DW5gBDNNIrJAznrTYsqagxdWGpB7HH4Aj+K2e
         WOga/4Kq1r2EveCkO0jUT6nH7Tj0tFt/su1n8IlgEJQLJhJAgeOot7IigaRlPzxwRhqY
         WMaA==
X-Gm-Message-State: AOAM531dtGCESgE9L3S96uH/bl944B6uQNVX/4FONKy2cMcKuhv+o883
	qZsLHUmXeG7zkUpL4I1qctMcyYW9RbFbNA==
X-Google-Smtp-Source: ABdhPJyzukj9dX9MvqYgVKDXTlPvT7efYUj/UEUJg9Fr+s1TiZ9BngflzdRQb8cGNnRssSD1qKeB+g==
X-Received: by 2002:aa7:d347:: with SMTP id m7mr10568072edr.260.1617294587430;
        Thu, 01 Apr 2021 09:29:47 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:7e1:37f3:1d27:f09e])
        by smtp.gmail.com with ESMTPSA id f3sm2926909ejd.42.2021.04.01.09.29.47
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 09:29:47 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 1st of April 2021
Message-ID: <c82ad526-4572-8a5a-5f42-e27cf70e8e25@tessares.net>
Date: Thu, 1 Apr 2021 18:29:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hello everyone,

Today, we just had our 142nd meeting with Mat and Ossama (Intel), 
Christoph (Apple), Florian, Paolo and Davide (RedHat), Geliang (Xiaomi) 
and myself (Tessares).


Thanks to our special guest Richard Stallman (FSF) and Linus Torvalds 
(LF) for their presence today in our weekly QUIC meeting.


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3


     netdev (if mptcp ML is in cc) (Mat Martineau):

1234567  [net] mptcp: Switch to QUIC

1460292  [net-next,6/6] selftests: mptcp: remove id 0 address testcases
1460295  [net-next,5/6] selftests: mptcp: add addr argument for del_addr
1460297  [net-next,4/6] selftests: mptcp: avoid calling pm_nl_ctl with 
bad IDs
1460298  [net-next,3/6] mptcp: remove id 0 address
1460296  [net-next,2/6] mptcp: unify RM_ADDR and RM_SUBFLOW receiving
1460293  [net-next,1/6] mptcp: remove all subflows involving id 0 address


     our repo (by: Davide Caratti, Geliang Tang):

1459921  [mptcp-next] Squash to "mptcp: remove id 0 address": reverse 
Xmas tre...
1458044  [RFC,net-next] mptcp: drop all sub-options except ADD_ADDR when 
the e...




Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=*

     netdev (if mptcp ML is in cc) (by: Yonglong Li):

1460888: New: [v3] mptcp: ensure there is unacked data at all subflow:
     - it is possible we don't fix the bug, to be checked with data.
     - maybe it helps for "dead" subflows
     - but probably we impact selftests
     - but we can of course improve retransmissions if needed
     - ideally track subflows with issues/pending data → use a bitmask 
to avoid retransmitting data over these subflows.
     - *Paolo* will document this in a new GH issue later.


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

1426554: Changes Requested: [PATCHi,iproute2] mptcp: add support for 
event monitoring:
     - WIP

1450496: RFC: [RFC,2/2] mptcp: add MP_FAIL support:
     - WIP

1455059: Rejected: [v2,mptcp-next] Squash to "bpf:selftests: add MPTCP 
test base":
     - See Github issue #176 → follow-up work

1457879: Changes Requested: [RFC,mptcp-next,v2,1/8] mptcp: add skeleton 
to sync msk socket options to subflows
1457878: Changes Requested: [RFC,mptcp-next,v2,2/8] mptcp: setsockopt: 
handle SO_KEEPALIVE and SO_PRIORITY
1457880: Changes Requested: [RFC,mptcp-next,v2,3/8] mptcp: setsockopt: 
handle receive/send buffer and device bind
1457881: Changes Requested: [RFC,mptcp-next,v2,4/8] mptcp: setsockopt: 
support SO_LINGER
1457882: Changes Requested: [RFC,mptcp-next,v2,5/8] mptcp: setsockopt: 
add SO_MARK support
1457883: Changes Requested: [RFC,mptcp-next,v2,6/8] mptcp: setsockopt: 
add SO_INCOMING_CPU
1457884: Changes Requested: [RFC,mptcp-next,v2,7/8] mptcp: setsockopt: 
SO_DEBUG and no-op options
1457885: Changes Requested: [RFC,mptcp-next,v2,8/8] mptcp: sockopt: add 
TCP_CONGESTION and TCP_INFO:
     - Florian will tests and provide some modifications discussed with 
Paolo
     - New version will be shared later when ready

1459518: Changes Requested: [v2,mptcp-next,01/16] mptcp: add 
csum_enabled in mptcp_sock
1459520: Changes Requested: [v2,mptcp-next,02/16] mptcp: generate the 
data checksum
1459519: Changes Requested: [v2,mptcp-next,03/16] mptcp: add csum_reqd 
in mptcp_out_options
1459521: Changes Requested: [v2,mptcp-next,04/16] mptcp: send out 
checksum for MP_CAPABLE with data
1459522: Changes Requested: [v2,mptcp-next,05/16] mptcp: send out 
checksum for DSS
1459523: Changes Requested: [v2,mptcp-next,06/16] mptcp: add csum_reqd 
in mptcp_options_received
1459524: Changes Requested: [v2,mptcp-next,07/16] mptcp: add sk 
parameter for mptcp_parse_option
1459525: Changes Requested: [v2,mptcp-next,08/16] mptcp: receive 
checksum for MP_CAPABLE with data
1459526: Changes Requested: [v2,mptcp-next,09/16] mptcp: receive 
checksum for DSS
1459527: Changes Requested: [v2,mptcp-next,10/16] mptcp: validate the 
data checksum
1459528: Changes Requested: [v2,mptcp-next,11/16] mptcp: add the mib for 
data checksum
1459529: Changes Requested: [v2,mptcp-next,12/16] mptcp: add a new 
sysctl checksum_enabled
1459530: Changes Requested: [v2,mptcp-next,13/16] mptcp: add 
mptcpi_csum_enabled in mptcp_info
1459531: Changes Requested: [v2,mptcp-next,14/16] mptcp: add trace event 
for data checksum
1459532: Changes Requested: [v2,mptcp-next,15/16] selftests: mptcp: 
enable checksum in mptcp_connect.sh
1459533: Changes Requested: [v2,mptcp-next,16/16] selftests: mptcp: 
enable checksum in mptcp_join.sh:
     - Geliang is working on a v3
     - Biggest point to pay attention at is the handling of packets with 
bad checksum or missing one (if required)
     - We might have to fallback to TCP (only one subflow) or remove one 
subflow (+ MP_FAIL)
     - Difficult part ↑ that will require attention

1460366: New: [v4,mptcp-next,1/5] mptcp: export mptcp_subflow_active
1460367: New: [v4,mptcp-next,2/5] mptcp: add tracepoint in 
mptcp_subflow_get_send
1460368: New: [v4,mptcp-next,3/5] mptcp: add tracepoint in 
get_mapping_status
1460369: New: [v4,mptcp-next,4/5] mptcp: add tracepoint in ack_update_msk
1460370: New: [v4,mptcp-next,5/5] mptcp: add tracepoint in 
subflow_check_data_avail:
     - We can apply these 5 patches with Paolo's ACK
     - *Matth* : to apply + change status → Done

1461028: New: [mptcp-next] Squash to "mptcp: add tracepoint in 
mptcp_subflow_get_send":
     - space after 'return' → yes
     - Can we even do a "return" there?
     - Might not be allowed in the macro?
     - → but it seems to work
     - *Geliang* will also check the "return" statement



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last week: 175)

   176  BPF selftest got "fallback to TCP" and "Attempt to release TCP 
socket in state 8" errors [bug] @geliangtang:
       - maybe due to a timeout set in the BPF test
       - BPF selftests are not easy to test :)


     Bugs (opened, flagged as "bug" and assigned)

   176  BPF selftest got "fallback to TCP" and "Attempt to release TCP 
socket in state 8" errors [bug] @geliangtang:
       - see above

   146  DATA_FIN is not retransmitted on timeout [bug] @mjmartineau:
       - Paolo can help reviewing early versions
       - This issue is visible in some tests, can be important but we 
still have time


     Bugs (opened and flagged as "bug" and not assigned)

   174  [syzkaller] memory leak in tcp_md5_do_add [bug] [syzkaller]:
       - Christoph didn't see this one with the export branch → Done

   172  WARNING in sk_stream_kill_queues [bug]
   162  sendmsg()/recvmsg() fail when an unknown CMSG argument is 
provided [bug]
   137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable 
[bug]
   120  [interop] netnext is dropping packets, causing MPTCP-level 
retransmissions on mptcp.org [bug]
   107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]
    65  clearing properly the status in listen() [bug]
    56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

   167  packetdrill: add coverage for RM_ADDR [enhancement] 
[packetdrill] @dcaratti
   158  iproute2: change backup mode (MP_PRIO) for active connections 
[enhancement] [iproute2] @dcaratti

   143  Packetdrill: ADD_ADDR for v6 only socket should only contain v6 
addresses [enhancement] [packetdrill]:
       - Can we assign Davide on this one?
       - For the moment, we need two different scripts for the server 
part because in v4, DSS is included in the ADD_ADDR, not in v6
       - Davide is looking at the possibility to have MP_JOIN without 
having to send ADD_ADDR
       - → we could then have dedicated tests just for ADD_ADDR (one for 
v4, one for v6)
       - → other tests would be unified, without ADD_ADDR → and also 
shorter!
       I think it's done @all, anything missing (apart capability of 
testing subflow endpoints)?

   134  Checksum support [enhancement] @geliangtang:
       - See above

   131  replace some/most pr_debug with trace events [enhancement] 
@geliangtang
    96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe
    53  MP_TCPRST support [enhancement] @fw-strlen
    52  MP_FAIL support [enhancement] @geliangtang


     Recently closed (since last week)

None.



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current/Coming merge window (5.13): 
https://github.com/multipath-tcp/mptcp_net-next/projects/8
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
     - net:
         - /

     - net-next:
         - fixes for sockopt:
             - first a blacklist for -net:
                 - Series: RFC version "mptcp: fix deadlock in 
mptcp{,6}_release"
             - then revert the first patch (mptcp: forbit mcast-related 
sockopt on MPTCP sockets) on net-next
             - and add the whitelist part after when we can

         - in //, *Mat* will continue to send patches that are in our 
export branch



Extra tests:
     - news about Syzkaller? (Christoph):
         - Not finding anything → good!

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - start sending build results again
         - some issues with mptcp_join.sh but no details for unknown reason
         - Matth got an issue with "36 add multiple addresses IPv6 → got 
1 ADD_ADDR echo[s] expected 2"

     - packetdrill (Davide):
         - See above

     - CI (Matth):
         - "build" part: see below
         - kvm tests: in progress → we need to change the architecture 
to fit with public CI (Cirrus CI)



CI scripts (build):
     - CI can sync with net-next (disabled for the moment while kvm 
tests are not elsewhere)
     - Build new tags
     - Build "stable/*" branches
     - For builds on the official repo, IRC notifications are sent
     - Fork: Build any branches on fork repo *except* TopGit ones, 
included 'for-review' and 'export'
     - → In other words, simply push new branches on your forked GH repo 
to have some tests started. (Check the Action tag on GH)



Patchwork:
     - Now we can send patches to the new ML (linux.dev)
     - an auto-reply is going to be added on the old one, just in case 
some people still use it.



Announced Window: never "shrink"?:
     - Some middleboxes reset connections if there is a "shrink"
     - For MPTCP, announced subflows are shared, "right edge" window can 
move → not "normal" for TCP but OK for MPTCP
     - It has been observed but difficult to know if it is frequent
     - We can probably ignore that for the moment
     - how to deal with if we want to?:
         - 2 subflows, each can use max half of the total window?
         - but what about connections with many subflows
         - and with very asymmetrical links (diff BDP)
     - → needs to be checked ubt maybe on net-next, we are OK with these 
middleboxes, *Paolo* ?



Next meeting:
     - On Thursday, the 8th of April.
     - *Usual* UTC time: 15:00 UTC (8am PDT, /!\ 5pm CEST, 11pm CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20210408



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
