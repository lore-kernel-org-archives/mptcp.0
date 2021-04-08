Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDD46D00
	for <mptcp@lists.linux.dev>; Thu,  8 Apr 2021 19:50:50 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id n2so5019481ejy.7
        for <mptcp@lists.linux.dev>; Thu, 08 Apr 2021 12:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+q7dMhyjApXHD9VZnZapBLGHd6QpBRTEUTOknk8MUEY=;
        b=XYEzEOSvtXa8so9us/n+lobER9V85/TtkqIDcDD+aKef7ZRixpjXvjcDm2TeEwnlhX
         fkGCCYqL3MDOUos6eHgCauH7dveRBmNuBgdOM1qemy+VeLudxySpwzSDai0Dmv61ObaB
         BBar3YO3stEH7PG1ztoHrxwRvj4PPpQba6fHsljcV8e9w0Z905f5Lh4DVFC93QlGTCSr
         q3DNh5H/e0pcF+Qq3z2Nxn2XYSEkXKPqxYXqZDAoBxPMDlsrAPOJXkHvsCbosV8LMOet
         ksmGYHcpeh0/jsrvpj3xtIjbhsA7p1ONchZxZA4wjLQko89rQjfTXrj4/Ffy6YWnCxQj
         +ePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+q7dMhyjApXHD9VZnZapBLGHd6QpBRTEUTOknk8MUEY=;
        b=cXCvAhZDaxJGActULaK3qpp8MDawOV6H84ppL/5RM9fBNuNSwCgFcT7WnxqPrmqfbB
         AK0obsqXf0dKMPt7Yc2wblS3GPhjNpZWcAHFHx9VbftM8G8gOxUD7TN6+qc3clNZ3jFx
         WqCaAxU+IXCVvlvHT+3QAoinUQFChSBJV6Prl+PJ84c+wG4MasuYKWsg6MhCN3PsfS9A
         2Ssnc+4z38XwBrP1BRZe1BqOWhhZdWBn0CYMvfif/bBzODsQsL737hgSpL+MdW/AB/4H
         OprGpewaFbUI3GjIoxSVpcWCeeows4PS3DIJrswDIJN68uHrwIy6p1Bip5q0zBOgPfBY
         YeLg==
X-Gm-Message-State: AOAM531xFkECE9aJwNTCuo+DxyZ4svWQKJ18epGKkfBSWn3h+SAFMftP
	zHi2k+oQFKwY/eSNYNIV779eWIgd343zPA==
X-Google-Smtp-Source: ABdhPJyEEPg4yfAyljiiDkaooJWzeliCJknusDIQ4AWzuv6/qlLhVQFjBgJsYK6k5BPecIK1+CNFPA==
X-Received: by 2002:a17:906:d9cf:: with SMTP id qk15mr12947208ejb.415.1617911448517;
        Thu, 08 Apr 2021 12:50:48 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:7e71:193d:b71f:64fd])
        by smtp.gmail.com with ESMTPSA id bm21sm168732ejb.36.2021.04.08.12.50.47
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 12:50:48 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 8th of April 2021
Message-ID: <050482ae-aed1-6c0d-8955-586483df3ce0@tessares.net>
Date: Thu, 8 Apr 2021 21:50:47 +0200
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

Today, we just had our 143rd meeting with Mat (Intel), Christoph 
(Apple), Florian, Paolo and Davide (RedHat), Geliang (Xiaomi) and myself 
(Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:

     netdev (if mptcp ML is in cc) (Mat Martineau, Paolo Abeni):

1463069  [net-next,8/8] mptcp: drop all sub-options except ADD_ADDR when 
the e...
1463070  [net-next,7/8] selftests: mptcp: add the net device name testcase
1463068  [net-next,6/8] mptcp: unify add_addr(6)_generate_hmac
1463067  [net-next,5/8] mptcp: drop MPTCP_ADDR_IPVERSION_4/6
1463065  [net-next,4/8] mptcp: use mptcp_addr_info in 
mptcp_options_received
1463066  [net-next,3/8] mptcp: drop OPTION_MPTCP_ADD_ADDR6
1463064  [net-next,2/8] mptcp: use mptcp_addr_info in mptcp_out_options
1463062  [net-next,1/8] mptcp: move flags and ifindex out of 
mptcp_addr_info

1461430  [net-next,7/7] selftests: mptcp: dump more info on mpjoin errors
1461429  [net-next,6/7] selftests: mptcp: init nstat history
1461428  [net-next,5/7] selftests: mptcp: launch mptcp_connect with timeout
1461434  [net-next,4/7] mptcp: add mptcp reset option support
1461427  [net-next,3/7] mptcp: remove unneeded check on first subflow
1461433  [net-next,2/7] mptcp: add active MPC mibs
1461432  [net-next,1/7] mptcp: add mib for token creation fallback

1461195  [net,2/2] mptcp: revert "mptcp: provide subflow aware release 
functio...
1461194  [net,1/2] mptcp: forbit mcast-related sockopt on MPTCP sockets


     our repo (by: Geliang Tang):

1461192  [v3,mptcp-next] Squash to "mptcp: add tracepoint in 
mptcp_subflow_get...

1460370  [v4,mptcp-next,5/5] mptcp: add tracepoint in 
subflow_check_data_avail
1460369  [v4,mptcp-next,4/5] mptcp: add tracepoint in ack_update_msk
1460368  [v4,mptcp-next,3/5] mptcp: add tracepoint in get_mapping_status
1460367  [v4,mptcp-next,2/5] mptcp: add tracepoint in 
mptcp_subflow_get_send
1460366  [v4,mptcp-next,1/5] mptcp: export mptcp_subflow_active




Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=*

     netdev (if mptcp ML is in cc) (by: /):

/


     our repo (by: Florian Westphal, Geliang Tang, Mat Martineau, 
Yonglong Li):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets:
     - Same status as last week, WIP

1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support:
     - Same status as last week, WIP

1395128: RFC: [1/5] tcp: make two mptcp helpers available to tcp stack
1395133: RFC: [5/5] mptcp: send fastclose if userspace closes socket 
with unread data:
     - Same status as last week, WIP

1426554: Changes Requested: [PATCHi,iproute2] mptcp: add support for 
event monitoring:
     - Same status as last week, WIP

1450496: RFC: [RFC,2/2] mptcp: add MP_FAIL support:
     - Same status as last week, WIP

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
     - Same status as last week, WIP

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
     - Same status as last week, WIP

1460888: Changes Requested: [v3] mptcp: ensure there is unacked data at 
all subflow:
     - Same status as last week

1462554: RFC: [RFC,mptcp-next] mptcp: Retransmit DATA_FIN:
     - A few topics to discuss / to do in the cover-letter
     - First look from Paolo: seems good, *Paolo* will try to look at 
this in more details later
     - Retransmission rate:
         - not sure if it is normal
         - we are in shutdown phase, maybe normal to be quick to retransmit
         - exponential backoff? → function for that, *Mat* will check
     - We do need packetdrill to validate that

1462711: Rejected: [mptcp-next,1/2] mptcp: add mptcp_for_each_msk helper
1462712: Rejected: [mptcp-next,2/2] mptcp: use mptcp_for_each_subflow in 
mptcp_close:
     - maybe not a good idea to declare new vars in a macro
     - seems OK not to have it
     - *EDIT* this makes sense for patch 1/2. Patch 2/2 is not using the 
new macro.



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/


     Recently opened (latest from last week: 176)

   178  Server hang when proxying over multiple subflows [bug] [v5.11] 
[v5.12]:
       - visible on v5.11 & v5.12
       - but not on v5.10
       - apparently easy to repro
       - would be interesting to validate that with latest net-next / 
export branch
       - Matth: TODO: reply that we will check → done

   177  improve retransmit subflow selection [enhancement]:
       - Paolo opened this after the discussion we had at the last meeting
       - related to the patch: "mptcp: ensure there is unacked data at 
all subflow"


     Bugs (opened, flagged as "bug" and assigned)

   176  BPF selftest got "fallback to TCP" and "Attempt to release TCP 
socket in state 8" errors [bug] @geliangtang

   146  DATA_FIN is not retransmitted on timeout [bug] @mjmartineau:
       - See above


     Bugs (opened and flagged as "bug" and not assigned)

   178  Server hang when proxying over multiple subflows [bug] [v5.11] 
[v5.12]:
       - See above

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
[enhancement] [iproute2] @dcaratti:
       - with the current implem:
           - we need to use addr+port but not the ID like the others → 
why is backup different? Probably an inconsistency, not on purpose
           - do we need something similar to pm_nl or something different?:
               → we can do something different
               - pm_nl was for the tests only, it might not fit with 
real use cases
     - Davide will do some propositions on Github

   143  Packetdrill: ADD_ADDR for v6 only socket should only contain v6 
addresses [enhancement] [packetdrill] @dcaratti
   134  Checksum support [enhancement] @geliangtang
    96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe
    53  MP_TCPRST support [enhancement] @fw-strlen
    52  MP_FAIL support [enhancement] @geliangtang


     Recently closed (since last week)

   175  [5.10] mptcp: put subflow sock on connect error [bug]
   174  [syzkaller] memory leak in tcp_md5_do_add [bug] [syzkaller]
   131  replace some/most pr_debug with trace events [enhancement] 
@geliangtang



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current/Coming merge window (5.13): 
https://github.com/multipath-tcp/mptcp_net-next/projects/8
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
     - net:
         - /

     - net-next:
         - 2 series in our export branch:
             - sockopt: we need to wait for a sync with -net tree to 
avoid a conflict
             - tracepoints: best to wait to have more feedback + 
squash-to patches might come + some related patches in the checksum series



Extra tests:
     - news about Syzkaller? (Christoph):
         - didn't find any new MPTCP issues
         - restarting now with latest export branch

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - last week: got a timeout with the selftests
         - some issues but not related to MPTCP (but with eBPF)

     - packetdrill (Davide):
         - *Davide* is looking for a support for subflow endpoints:
             - adding the possibility to allow MPJ even if an ADD_ADDR 
was not exchanged
             - for the moment, we allow MPJ if an ADD_ADDR was exchanged
             - → probably best to extract the IP from the script but not 
easy to do with inbound addresses:
                 - no address at the moment
                 - source IP is OK
                 - but dest IP might be difficult
                 - maybe we would need to add an option: v4/v6
                 - or call iproute/netlink to get the endpoints
                 - for the server.sh script, we read env vars in this 
script and set a new endpoint → but not possible to do that for injected 
packets without real socket.

     - CI (Matth):
         - See below



CI: new job to validate tests:
     - e.g.:
         - "normal": https://cirrus-ci.com/task/5464962844852224
         - "debug": https://cirrus-ci.com/task/6590862751694848

     - A "Summary" file should always be produced, e.g.:
 
https://api.cirrus-ci.com/v1/artifact/task/6590862751694848/summary/.virtme/results/debug/summary.txt

     - Notification on IRC
     - Triggered when a new tag is created: new export branch, useful 
later for Patchew.

     - But: Unstable, e.g.
         - 
https://api.cirrus-ci.com/v1/artifact/task/6590862751694848/tap_result/.virtme/results/debug/selftest_mptcp_join.tap
         - 
https://api.cirrus-ci.com/v1/artifact/task/6590862751694848/tap_result/.virtme/results/debug/selftest_simult_flows.tap

     - Probably because the server can be used for other tasks and we 
get what is left.
     - Tests should probably cope with that, e.g.
         - wait for an action (new IP available) instead of wait for a 
fixed time.
         - being more tolerant for simult flows test case (except if 
there is really a bug?)



LPC 2021:
     - Networking and BPF Track CFP → now open
     - 
https://lore.kernel.org/bpf/6d225920-9ecc-ef24-2bf8-848ca86c7fb0@iogearbox.net/T/
     - Open until August:
         - we have time to know more about how it will be organised
         - and what subject we might want to propose



Next meeting:
     - On Thursday, the 15th of April.
     - *Usual* UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20210415



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
