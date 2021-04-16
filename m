Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EB86D28
	for <mptcp@lists.linux.dev>; Fri, 16 Apr 2021 07:43:45 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id h10so31072912edt.13
        for <mptcp@lists.linux.dev>; Fri, 16 Apr 2021 00:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=RfkNj4r/xGYnHmHKxnKYk/0ZCnzq73uyk3Egrs7Cd9Q=;
        b=o2KndX07EViUOwGl1nXYHWHUgQ45KL84WSRBj2gwwKp0G/AhZM3D01+q59tD4YG43W
         86YFy9BHpE0DecAEFhffK+/c6mV9eVrhMy6Deih4oMkw9lBWvZ9A/Amin72itsp6BAoN
         zn4RbEAP+2ya2PdnziW+mLU8FfvqQ0fqBeNZExLcwHR3p8yA0YNrzXnRkSQowglse/pj
         wLgQH3VJik6tbLcWuMUsbKRn8ozpIlK8HCCAVWOma96Yrm8jFEz9WFydJwie5r2gd28e
         Ax5AGvvD0x8fpz2Mgha7qj270FF+TdE3VhLLxnaYbyvEGzhefE/BpwQzdHwvUdPgXSGR
         6pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=RfkNj4r/xGYnHmHKxnKYk/0ZCnzq73uyk3Egrs7Cd9Q=;
        b=nBYSlVbhNzBijDaZzRooHBFI1zznVJRnvBVydDbARRV43B9JdeUGPIn0yKS3QBo+ST
         sQ9TYC1X9bvzchJN6zIczAIoJX8OFumfvhFvc/BYp4gWoNE0Ms1EpbvfHdimavavO3zT
         9sATSO7SN/Y7vq7ryaY90AZVqz2OwjsqVrrN7oXJsvn2id7mjGbAkvyoBq+69B0EOgg9
         sBsvEInFjQZBMl0M15xEbkCBYs9mqcNeu+cEdyQKzpoMw9K3AReHLRGxaV/aDy1maf+j
         62gZy5DbblNj1x/WPLfZ504sJzqKKYZj1S46w1YwcYUVThOtEPFh7N6/6qLex8OQIFB3
         ibHQ==
X-Gm-Message-State: AOAM531jGOyNapyReyc3IzISehp7wqu4z2mk9c5pg4WZNrLrIevmSfhr
	Li6k+l2uP3ucav53rVkjTivYbzAbZaEjbQ==
X-Google-Smtp-Source: ABdhPJycdfoR9Ljuoe36bSLnLaHJAa61fifbiIEx5lcQc3IFnm1UPT/G7Nlqmn7D/P4bBGyHgrb1BA==
X-Received: by 2002:a05:6402:5a:: with SMTP id f26mr8518956edu.285.1618559023518;
        Fri, 16 Apr 2021 00:43:43 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:6729:49e:4af6:9df3])
        by smtp.gmail.com with ESMTPSA id e20sm3696421ejy.66.2021.04.16.00.43.43
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 00:43:43 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 15th of April 2021
Message-ID: <3d2b8b36-247d-b4d1-d712-b2a6f80fc593@tessares.net>
Date: Fri, 16 Apr 2021 09:43:42 +0200
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

Yesterday, we had our 144th meeting with Mat and Ossama (Intel), Florian 
and Paolo (RedHat), Geliang (Xiaomi), Maxim Galaganov (Parents helper) 
and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:


     netdev (if mptcp ML is in cc) (/):

/


     our repo (by: Florian Westphal, Geliang Tang, Nico Pache):

1466512  [mptcp-next] mptcp: fix format specifiers for unsigned int

1465840  [mptcp-next,v2,10/10] selftests: mptcp: add packet mark test case
1465839  [mptcp-next,v2,09/10] mptcp: sockopt: add TCP_CONGESTION and 
TCP_INFO
1465838  [mptcp-next,v2,08/10] mptcp: setsockopt: SO_DEBUG and no-op 
options
1465837  [mptcp-next,v2,07/10] mptcp: setsockopt: add SO_INCOMING_CPU
1465836  [mptcp-next,v2,06/10] mptcp: setsockopt: add SO_MARK support
1465835  [mptcp-next,v2,05/10] mptcp: setsockopt: support SO_LINGER
1465834  [mptcp-next,v2,04/10] mptcp: setsockopt: handle receive/send 
buffer a...
1465833  [mptcp-next,v2,03/10] mptcp: setsockopt: handle SO_KEEPALIVE 
and SO_P...
1465832  [mptcp-next,v2,02/10] mptcp: tag sequence_seq with socket state
1465831  [mptcp-next,v2,01/10] mptcp: add skeleton to sync msk socket 
options ...

1462712  [mptcp-next,2/2] mptcp: use mptcp_for_each_subflow in mptcp_close

1466086  [v2,5/6] kunit: mptcp: adhear to KUNIT formatting standard:
     - /!\ a KConfig option has been renamed:
         - MPTCP_KUNIT_TESTS → MPTCP_KUNIT_TEST



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=*


     netdev (if mptcp ML is in cc) (by: /):

/


     our repo (by: Florian Westphal, Geliang Tang, Mat Martineau, Paolo 
Abeni, Yonglong Li):

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
     - When is their window closing?

1450496: RFC: [RFC,2/2] mptcp: add MP_FAIL support:
     - WIP

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
     - seems more complex than expected
     - critical part is queuing the data from the subflow received queue 
with DSS granularity → we need a full DSS coverage before validating the 
checksum
     - Paolo is helping Geliang

1460888: Changes Requested: [v3] mptcp: ensure there is unacked data at 
all subflow:
     - it seems we are not going to have a v4 there
     - we can archive it
     - follow-up ticket: 
https://github.com/multipath-tcp/mptcp_net-next/issues/177

1462554: RFC: [RFC,mptcp-next] mptcp: Retransmit DATA_FIN:
     - Mat is working on a v1

1466292: Changes Requested: [mptcp-next] mptcp: ignore unsupported msg 
flags:
     - Some discussions on the ML with Florian
     - v2 expected
     - v2 will conflict with MSG_PEEK patch ↓ but not big conflicts and 
easy to resolve

1466461: Changes Requested: [v2,1/2] mptcp: add MSG_PEEK support
1466462: Changes Requested: [v2,2/2] selftests: mptcp: add a test case 
for MSG_PEEK:
     - Review has been done by Paolo




Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/


     Recently opened (latest from last week: 178)

/


     Bugs (opened, flagged as "bug" and assigned)

   178  Server hang when proxying over multiple subflows [bug] [v5.11] 
[v5.12]:
       - Maxim reported a nice and complete bug report
       - Paolo suggested a workaround that seems to avoid the issue
       - But the patch is not "upstreamable" → will increase mem usage
       - We need to understand the root cause
       - Probably a use-after-free but hidden to KASAN (pfrag)
       - Paolo is looking at a patch adding some poisoning hoping to 
have KASAN finding the issue
       - After meeting note: What could also help:
           - strace of the server before the crash

   176  BPF selftest got "fallback to TCP" and "Attempt to release TCP 
socket in state 8" errors [bug] @geliangtang

   146  DATA_FIN is not retransmitted on timeout [bug] @mjmartineau:
       - See above


     Bugs (opened and flagged as "bug" and not assigned)

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


     In Progress (opened and assigned):

   167  packetdrill: add coverage for RM_ADDR [enhancement] 
[packetdrill] @dcaratti
   158  iproute2: change backup mode (MP_PRIO) for active connections 
[enhancement] [iproute2] @dcaratti
   143  Packetdrill: ADD_ADDR for v6 only socket should only contain v6 
addresses [enhancement] [packetdrill] @dcaratti
   134  Checksum support [enhancement] @geliangtang
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
         - Maybe the last week to push stuff
         - 3 series are pending:
             - sockopt from Paolo:
                 - They have been stressed by syzkaller
                 - *@Christoph:* nothing to report?
             - tracepoint support from Geliang:
                 - seems OK to be sent upstream
             - sockopt from Florian:
                 - seems OK to be sent? To be stressed first maybe?
                 - Should be OK without
                 - can be sent with Paolo's series



Extra tests:
     - news about Syzkaller? (Christoph):
         - /

     - news about interop with mptcp.org? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - some progress but no summary email yet
         - apparently no issues on our side

     - packetdrill (Davide):
         - /

     - CI (Matth):
         - The notification on IRC is currently reporting two things:
             - Task successfully finished! → it means no crash, 
compilation error, global timeout
             - tests_ok → current broken: it will always report false
             - But we can check on the provided link to open the 
"summary" file and see the result
         - *Matth* will look at that


mptcpd: new release: v0.7:
     - https://github.com/intel/mptcpd/releases/tag/v0.7
     - MPTCP path management generic netlink events recently added to 
the upstream Linux kernel are now supported, and propagated to mptcpd 
plugins.  The same API is also found in the multipath-tcp.org kernel. 
Differences between the two kernels are transparent to mptcpd plugins.
     - Mptcpd now supports the upstream Linux kernel server-oriented 
MPTCP_PM_CMD_SET_FLAGS generic netlink command through the new 
mptcpd_pm_set_flags() function.  It allows the user to set MPTCP flags 
for a specific local IP address.
     - An incorrect buffer size calculation when calling 
mptcpd_pm_add_addr() when using an IPv6 addresses on platforms running 
the upstream Linux kernel was corrected.
     - An "operation not supported" error that occurred when attempting 
to retrieve MPTCP resource limits through the mptcpd_pm_get_limits() 
function was fixed.
     - A network interface lookup problem in the "sspi" plugin was 
corrected.
     - Building mptcpd against ELL 0.39 is now supported.



Load Balancer:
     - Florian would like to improve LB's support
     - Any paper/thesis/... to look at to know what's important to support?
     - Or feedback from existing deployments?
     - *@Christoph* maybe? :)

     - https://www.rfc-editor.org/rfc/rfc8684.html#section-3.1-20.6
     - 
https://datatracker.ietf.org/doc/draft-duchene-mptcp-load-balancing/01/
     - If each server behind the firewall can have a dedicated IP that 
can be announced, we can have a stateless LB on the "initial subflow" 
side. No LB needed on the other IP, only accepting MPJoin
     - Still could be good to have ConnTrack being able to say that one 
flow (e.g. MPJ) is belonging to another connection.



Next meeting:
     - On Thursday, the 22th of April.
     - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20210422



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
