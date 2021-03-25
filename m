Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3E85F
	for <mptcp@lists.linux.dev>; Thu, 25 Mar 2021 20:00:22 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id jy13so4955014ejc.2
        for <mptcp@lists.linux.dev>; Thu, 25 Mar 2021 13:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=rjTUlqjF7VSAwLj6Rxvd/ot0pptHT6iT3fAcKx6PNkE=;
        b=mXATfCFq3piePwIj5I2JFFxqOYFnn/OUjCDkI652I6afuI9Ir1dx694NHJTevMkYOu
         Bagn/jB7I668CKUT8ea316gf3FRNnScHYM6QFT/xGfP6TCdzMLWjHexuGe4A3jnHD/HX
         HBvRSvapnStL9zI9HT+K5Wu5FzETS1YWuxfq+3BDaMxUvzc97ZtVRqG/ntblWpIdsU6L
         TviPgE1hVBl/YTFMitJlLF3Cbfm90MS4BGwxq2I0jMUMtlHFBpQl56wSxWcbUHztGgXM
         7DtH1xgyc99z8+sE8gxAXJ11tqnDhvniflcK+9SToATpWemUDdNGHREA82Ys/bGnyNxk
         81Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=rjTUlqjF7VSAwLj6Rxvd/ot0pptHT6iT3fAcKx6PNkE=;
        b=rPp4BtkkuC/UhD+c+/JSYUYZ8SvoSU7//lUtjhgAhS9yl2ErYs72eRho7XvzyxQTyJ
         vONQ6t3BKlo3aub8UyydAX6s5Q39BVP6C+bvytANOCumWwR+algYKW2A8M9MiffA/YAb
         TlrM36PHoM+rUoN5D7dDVD5WRJhToYgdVPlmnG8mE2CsqVNciMdLhzf+XBjox3Hjyq0i
         RFamVqaZm9w1WTJBNM+ink+V5N0p4qC6ViSHsHvWsB0QyykJq5Z/K0ytrrjtuhP9PGHl
         4+KnppSgnZQxImrdJdnkGOfLqFklF2kuu1OkNy2UXCzz5amg0ChvN4noWkbwDYmzGag8
         x5+g==
X-Gm-Message-State: AOAM532aXbehF/iqrq2AVOqHTrw39kH8Kp/8d/t3DGMCCp9YtigluLRT
	2FjjsSwVixRAcJMmKYt6vfJwgHg06fB7sxUD
X-Google-Smtp-Source: ABdhPJyFFv8xD3NlqitOTAgAiqNXRt0pn7UWfN66E20dLoR176xNmFzr+0zFd23rv9/Ztg9ZU0CseA==
X-Received: by 2002:a17:906:b747:: with SMTP id fx7mr11656563ejb.474.1616702420653;
        Thu, 25 Mar 2021 13:00:20 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:28b2:37f8:b9fb:f482])
        by smtp.gmail.com with ESMTPSA id r19sm2914710ejr.55.2021.03.25.13.00.20
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 13:00:20 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 25th of March 2021
Message-ID: <0eaca071-7b8e-e8fc-9409-7d43a6d56978@tessares.net>
Date: Thu, 25 Mar 2021 21:00:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hello everyone,

Today, we just had our 141st meeting with Mat and Ossama (Intel), 
Florian and Davide (RedHat), Geliang (Xiaomi) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3


     netdev (if mptcp ML is in cc) (Mat Martineau):

[net] mptcp: Change mailing list address


     our repo (by: Geliang Tang, Matthieu Baerts):

1456733  [mptcp-next,3/3] Squash to "mptcp: drop MPTCP_ADDR_IPVERSION_4/6"
1456732  [mptcp-next,2/3] Squash to "mptcp: use mptcp_addr_info in 
mptcp_optio...
1456734  [mptcp-next,1/3] Squash to "mptcp: use mptcp_addr_info in 
mptcp_out_o...

1455664  [mptcp-next] Squash to "mptcp: use mptcp_addr_info in 
mptcp_out_optio...

1454539  [v3,mptcp-next,7/7] selftests: mptcp: add the net device name 
testcase
1454538  [v3,mptcp-next,6/7] mptcp: unify add_addr(6)_generate_hmac
1454537  [v3,mptcp-next,5/7] mptcp: drop MPTCP_ADDR_IPVERSION_4/6
1454536  [v3,mptcp-next,4/7] mptcp: use mptcp_addr_info in 
mptcp_options_recei...
1454535  [v3,mptcp-next,3/7] mptcp: drop OPTION_MPTCP_ADD_ADDR6
1454534  [v3,mptcp-next,2/7] mptcp: use mptcp_addr_info in 
mptcp_out_options
1454533  [v3,mptcp-next,1/7] mptcp: move flags and ifindex out of 
mptcp_addr_i...




Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=*


     netdev (if mptcp ML is in cc) (by: /):

/


     our repo (by: Davide Caratti, Florian Westphal, Geliang Tang):

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

1455059: Changes Requested: [v2,mptcp-next] Squash to "bpf:selftests: 
add MPTCP test base":
     - Geliang will have a look at the comments from Matt

1456514: Changes Requested: [mptcp-next,1/6] mptcp: add a new sysctl 
checksum_enabled
1456516: Changes Requested: [mptcp-next,2/6] mptcp: add csum_enabled in 
mptcp_out_options
1456517: Changes Requested: [mptcp-next,3/6] mptcp: add the csum_reqd 
fields
1456518: Changes Requested: [mptcp-next,4/6] mptcp: add the DSS checksum 
sending
1456519: Changes Requested: [mptcp-next,5/6] mptcp: add the DSS checksum 
receiving
1456520: Changes Requested: [mptcp-next,6/6] mptcp: add trace event for 
DSS checksum:
     - Mat and Paolo have commented
     - Geliang will have a look
     - Tricky part (to explain and implement :) ) is the checksum 
verification
     - When we get a mapping, it should be in order, that should help

1457793: New: [v2,mptcp-next,1/5] mptcp: export mptcp_subflow_active
1457794: New: [v2,mptcp-next,2/5] mptcp: add tracepoint in 
mptcp_subflow_get_send
1457795: New: [v2,mptcp-next,3/5] mptcp: add tracepoint in 
get_mapping_status
1457797: New: [v2,mptcp-next,4/5] mptcp: add tracepoint in ack_update_msk
1457798: New: [v2,mptcp-next,5/5] mptcp: add tracepoint in 
subflow_check_data_avail:
     - new version after Paolo's comments on v1
     - waiting for reviews

1457879: New: [RFC,mptcp-next,v2,1/8] mptcp: add skeleton to sync msk 
socket options to subflows
1457878: New: [RFC,mptcp-next,v2,2/8] mptcp: setsockopt: handle 
SO_KEEPALIVE and SO_PRIORITY
1457880: New: [RFC,mptcp-next,v2,3/8] mptcp: setsockopt: handle 
receive/send buffer and device bind
1457881: New: [RFC,mptcp-next,v2,4/8] mptcp: setsockopt: support SO_LINGER
1457882: New: [RFC,mptcp-next,v2,5/8] mptcp: setsockopt: add SO_MARK 
support
1457883: New: [RFC,mptcp-next,v2,6/8] mptcp: setsockopt: add 
SO_INCOMING_CPU
1457884: New: [RFC,mptcp-next,v2,7/8] mptcp: setsockopt: SO_DEBUG and 
no-op options
1457885: New: [RFC,mptcp-next,v2,8/8] mptcp: sockopt: add TCP_CONGESTION 
and TCP_INFO:
     - A draft related to sockopts per subflow: 
https://tools.ietf.org/html/draft-hesmans-mptcp-socket-03 :
         - We can get a list of subflow and apply setsockopt per subflows
         - More for later but it gives more control to the userspace app 
if it can know what's going on per subflow.
         - Not in mptcp.org but often asked.
         - Never merged in mptcp.org (had to be polished more) 
https://github.com/bhesmans/mptcp

     - Alternative is to do get/setsockopt via BPF but... what if there 
are multiple BPF apps, etc. + split from the app

     - TODO: change status → Done

1458044: New: [RFC,net-next] mptcp: drop all sub-options except ADD_ADDR 
when the echo bit is set:
     - Detected with Packetdrill
     - Mat reviewed that, looks good
     - For Packetdrill, we will need different tests for v4 and v6 
because the behaviour is different
     - TODO: change status → Done




Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/


     Recently opened (latest from last week: 174)

/


     Bugs (opened, flagged as "bug" and assigned)

   146  DATA_FIN is not retransmitted on timeout [bug] @mjmartineau


     Bugs (opened and flagged as "bug" and not assigned)

   174  [syzkaller] memory leak in tcp_md5_do_add [bug] [syzkaller]
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
[packetdrill] @dcaratti:
       - Depends on others (e.g. IPv6 support for ADD_ADDR)

   158  iproute2: change backup mode (MP_PRIO) for active connections 
[enhancement] [iproute2] @dcaratti

   134  Checksum support [enhancement] @geliangtang:
       - See patches above

   131  replace some/most pr_debug with trace events [enhancement] 
@geliangtang:
       - See patches above

    96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe
    53  MP_TCPRST support [enhancement] @fw-strlen
    52  MP_FAIL support [enhancement] @geliangtang


     Recently closed (since last week)

   175  [5.10] mptcp: put subflow sock on connect error [bug] v5.10.y 2 ‡
   173  "remove invalid addresses" testcase fail [bug] @geliangtang
   119  [syzkaller] memory leak in __get_filter [bug] [syzkaller]



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current/Coming merge window (5.13): 
https://github.com/multipath-tcp/mptcp_net-next/projects/8
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
     - net:
         - /

     - net-next:
         - Paolo's fixes for sockopt (acceptance list):
             - Maybe best to wait for Florian patches also linked to sockopt
         - Mat will look at sending others in the "features for 
net-next" section (if they don't conflict with Paolo's fixes for sockopt 
that are earlier in the tree)



Backports:
     - Wrong backported commit: 
https://github.com/multipath-tcp/mptcp_net-next/issues/175

     - Cherry-pick have failed:
         - in v5.11:
             - mptcp: fix missing wakeup
             - mptcp: reset last_snd on subflow close
         - in v5.10: LTS
             - mptcp: reset last_snd on subflow close
         - What should we do about that?
         - → now stable branches are managed by Greg and Sasha
         - → we should look patch by patch
         - → some might be more important if it fixes issues for an LTS 
version



CI for stable:
     - we will need to validate new branches (builds + tests)
     - for the build, it should be easy, not a lot of variations
     - for the tests, some tests would fail if you try to execute them 
on a previous kernel version, e.g. packetdrill validating features not 
available in a kernel version
     - but we should introduce the ability to skip some tests
     - TODO: Matth: think about that



Extra tests:
     - news about Syzkaller? (Christoph):
         - /

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - build server is running, logs are back
         - but no results for the tests: it looks like others are 
failing making ours not being executed
         - Mat will have a look

     - packetdrill (Davide):
         - https://github.com/multipath-tcp/packetdrill/pull/49 → don't 
always assume IPv4 for ADD_ADDR

     - CI (Matth):
         - Build is in place: 
https://github.com/multipath-tcp/mptcp_net-next/actions/runs/686389076

         - For the moment:
             - builds are started when the "export" branch is modified → 
on the official repo and any fork having the latest export branch!
             - if commits are put on top of the "export" branch (after 
"DO-NOT-MERGE: mptcp: enabled by default" commit), only these commits 
are being validated
             - else: each commit on top of net-next are being validated.
             - easy to add more conditions to start a test, e.g. when a 
new specific tag is pushed, e.g. refs/tags/patchew/*

         - Next steps:
             - IRC notification
             - test part (using another CI)



Mailing list:
     - switched done! Except Patchwork
     - Because of Patchwork:
         - We still need to continue sending patches to the previous list
         - No auto-reply to say the list is no longer valid.



Patchwork:
     - still OK with ozlab?
     - or move to kernel.org?:
         - follow workflow used by many others now
         - linked with lore
         - maybe new features in the future? (e.g. patchwork bot)
         - maybe faster for some people?

     - Mat will email Jeremy again and check if it would not be better 
to switch to kernel.org



LPC 2021:
     - In September in Dublin
     - Net is not open yet
     - Not sure if it will be virtual only or not



Patchew:
     - 4 components:
         - database
         - WebUI
         - Importer node:
             - look for new emails in a ML
             - try to apply the patch
             - create a tag (patchew/...) in a repo
         - Tester nodes:
             - periodically check for new patches in the DB and run tests
             - example: running 'checkpatch'

     - We might only need the Importer node (+ WebUI and database):
         - when a new patch is send to a repo, tests could be ran 
automatically
         - we would only need to get results for these tests
         - Note that if we can also have 'checkpatch' ran automatically 
because this is already there for other projects, why not :-)

     - Matth: check with Davide what can be done



Next meeting:
     - On Thursday, the 1st of April.
     - *Usual* UTC time: 15:00 UTC (8am PDT, /!\ 5pm CEST, 11pm CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20210401



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
