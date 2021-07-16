Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A82D70
	for <mptcp@lists.linux.dev>; Fri, 16 Jul 2021 10:41:18 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id dj21so12460049edb.0
        for <mptcp@lists.linux.dev>; Fri, 16 Jul 2021 03:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+M+eU6tvaGod0pXjTmy8vHIiO9jIc0fP75WTS8y7Wzc=;
        b=GEQRCZeCu7wxpR2EfDF1n0fIOyAHCyGY3mUSzcvqnUKix60ZuEXVvnoUk+A14C2McW
         KYUi+BDtovM2+4ZPRFtEYNcILnfgk7kRA1l9WJ3rMY7ONMf2Kq2tg41okzp8loYKQTak
         NcFvGC49z2R+mCY9AhzThVTKA+khiN/3Pq+3/aL6WoSDnfw+cGQL2f5Jz1ZcnZToJGif
         dY35j6+AEHs7R9KXdqpNjKIrlx8LqDRPZCyr+TsG3RJUqjqp4zODoUhgG7TcDug8NiYB
         mdYT5r9MWX617rXmYBHFKtCf6Bkj6zvQLE1CfsAcA9foboxViOlpzDS86LXLzlTiM5Ms
         SWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+M+eU6tvaGod0pXjTmy8vHIiO9jIc0fP75WTS8y7Wzc=;
        b=JOj4SOKEMtGvi9h12ou4M3D//qgWooDxphkn7XaQIj5pdOM7EDwibnFEfVDRcg9oUz
         mDW7fP2W8DBjtcPz42C+bGPmakjkMX2ITdfCDfPUTl9P2GTCxqTRGEYaoDHjWqlTA9kI
         iBSjvr/HPJ5uBRoW2bqh2WX7xScsG3imDxsr49xBJ0OXiIeQc/glMQmcxHVIa5sT8nK+
         eWMFmwbGyzLq4gkeA5OgUZ6POGjH/X5skNN3x3BHMORuujZtpFYatguLBVFAo8F4fBHC
         aVHDHh8B00V2/xkUyHJvq4tVByyqpJvf81pLMxoQ1z7ihSq8ygiA1YB5njBqdwCFVNaK
         FPvg==
X-Gm-Message-State: AOAM531Fjd5A9a8is8vuo8/LZb4MChaaTrLx5g0+dcjmX85dvWq8QMWg
	hWmrZq4Oqrr/T9wcTyr3LTjdVkCiOo4b4w==
X-Google-Smtp-Source: ABdhPJwmTyk/nmqoLbX1vMg+csNfxXQfoY9LS+KTEB7bHohIdr0fhldR7k8nDBUh7hsg5PMrz3DD5Q==
X-Received: by 2002:a05:6402:221c:: with SMTP id cq28mr7042820edb.115.1626432076632;
        Fri, 16 Jul 2021 03:41:16 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:b258:fe9e:46f7:ea69])
        by smtp.gmail.com with ESMTPSA id l18sm3537794eds.72.2021.07.16.03.41.16
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 03:41:16 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 15th of July 2021
Message-ID: <08770b8c-6218-ae2d-f5ba-e33a0dee572e@tessares.net>
Date: Fri, 16 Jul 2021 12:41:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
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

Today, we just had our 157th meeting with Mat and Ossama (Intel),
Florian, Paolo and Davide (RedHat), Geliang (Xiaomi) and myself
(Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3

    netdev (if mptcp ML is in cc) (by: Mat Martineau, Yajun Deng):

12368163  [net,6/6] mptcp: properly account bulk freed memory
12368159  [net,5/6] selftests: mptcp: fix case multiple subflows limited
by ser...
12368157  [net,4/6] mptcp: avoid processing packet if a subflow reset
12368169  [net,3/6] mptcp: fix syncookie process if mptcp can not_accept
new su...
12368165  [net,2/6] mptcp: remove redundant req destruct in
subflow_check_req()
12368161  [net,1/6] mptcp: fix warning in __skb_flow_dissect() when do
syn cook...

12372727  [v2] net: Use nlmsg_unicast() instead of netlink_unicast()


    our repo (by: /):

/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*

    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Jiapeng Chong, Matthieu Baerts, Paolo
Abeni, Yonglong Li):

12279739: RFC: [RFC,3/4] mptcp: move the whole rx path under msk socket
lock protection:
    - WIP

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
    - Someone else wants to do a v2?

12363073: Changes Requested: [v8,1/4] mptcp: make MPTCP_ADD_ADDR_SIGNAL
and MPTCP_ADD_ADDR_ECHO separate
12363059: Changes Requested: [v8,2/4] mptcp: fix ADD_ADDR and RM_ADDR
maybe flush addr_signal each other
12363061: Changes Requested: [v8,3/4] mptcp: build
ADD_ADDR/echo-ADD_ADDR option according pm.add_signal
12363063: Changes Requested: [v8,4/4] mptcp: remove MPTCP_ADD_ADDR_IPV6
and MPTCP_ADD_ADDR_PORT
12369213: Changes Requested: [mptcp-next] Squash to "mptcp: make
MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO separate"
12372957: Changes Requested: [v2,mptcp-next] Squash to "mptcp: fix
ADD_ADDR and RM_ADDR maybe flush addr_signal each other"
12372959: Changes Requested: [v2,mptcp-next] Squash to "mptcp: build
ADD_ADDR/echo-ADD_ADDR option according pm.add_signal"
12372961: Changes Requested: [mptcp-next] Squash to "mptcp: remove
MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT":
    - Geliang is going to send a v9 → done
    - v9 is under test

12367145: Under Review: [mptcp-next,1/9] mptcp: add a new sysctl
path_manager
12367147: Under Review: [mptcp-next,2/9] mptcp: add fullmesh path manager
12367149: Under Review: [mptcp-next,3/9] mptcp: add fullmesh worker
12367151: Under Review: [mptcp-next,4/9] mptcp: register ipv4 addr notifier
12367153: Under Review: [mptcp-next,5/9] mptcp: register ipv6 addr notifier
12367155: Under Review: [mptcp-next,6/9] mptcp: add netdev up event handler
12367157: Under Review: [mptcp-next,7/9] mptcp: add netdev down event
handler
12367159: Under Review: [mptcp-next,8/9] mptcp: add proc file
mptcp_fullmesh
12367161: Under Review: [mptcp-next,9/9] selftests: mptcp: add fullmesh
testcases:
    - We had a more global discussion about how we want to maintain
different path-managers (and packets schedulers) in this upstream kernel
    - It is difficult to cover all cases from the kernel side
    - Supporting most cases is the priority
    - We are ready to add complexity around there to extend the current
path-manager:
        - more commands to control MPTCP connections
        - more flags to set for a global management
        - eventually ease extensions with BPF (maybe more for the
packets scheduler side)
    - mptcp.org's fullmesh PM is also somehow limited: how to react when
a subflow fails (timeout, reset, etc.), blacklist some IPs/iface, how to
avoid "cross path" or only use one path per interface, etc. Easier if we
can control that via the Netlink API.
    - Geliang is interested by a in-kernel PM because on Android
platform, it is not easy (practicality/security-wise) to inject eBPF
code. It is easier when everything is handled by the kernel.
    - Maybe a good alternative is to allow the userspace to change the
default behaviour of the current netlink PM, e.g. an "endpoint" could
have a flag to allow establishing subflows to all available paths.

12367219: Queued: [mptcp-next] mptcp: drop unuse rcu in mptcp_pm_addr_entry:
    - Reviewed by Mat
    - to apply → Done

12375113: Queued: [v2,mptcp-next,1/8] mptcp: more accurate timeout
12375115: Queued: [v2,mptcp-next,2/8] mptcp: less aggressive
retransmission stragegy
12375117: Queued: [v2,mptcp-next,3/8] mptcp: handle pending data on
closed subflow
12375119: Queued: [v2,mptcp-next,4/8] mptcp: cleanup sysctl data and
helpers
12375123: Queued: [v2,mptcp-next,5/8] mptcp: faster active backup recovery
12375121: Queued: [v2,mptcp-next,6/8] mptcp: add mibs for stale subflows
processing
12375125: Queued: [v2,mptcp-next,7/8] mptcp: backup flag from incoming
MPJ ack option
12375127: Queued: [v2,mptcp-next,8/8] selftests: mptcp: add testcase for
active-back
12376299: Queued: [mptcp-next] Squash-to: "mptcp: faster active backup
recovery":
    - Series: "mptcp: refactor active backup"
    - Reviewed by Mat
    - to apply → Done

12376673: New: [v4,mptcp-next,1/5] mptcp: MP_FAIL suboption sending
12376675: New: [v4,mptcp-next,2/5] mptcp: MP_FAIL suboption receiving
12376677: New: [v4,mptcp-next,3/5] mptcp: send out MP_FAIL when data
checksum fail
12376679: New: [v4,mptcp-next,4/5] mptcp: add the mibs for MP_FAIL
12376681: New: [v4,mptcp-next,5/5] selftests: mptcp: add MP_FAIL mibs check:
    - "MP_FAIL support"
    - Infinite mapping is no longer part of the series
    - MPTCP Option structure size has increased:
        - memset of each ingress packet even if there is no MPTCP
        - We need to be careful and it is certainly time to shrink it
        - Paolo is looking at that:
            - some options are (almost) mutually exclusive
            - if we always send ADD_ADDR (without port) without DSS, we
can reduce even more the structure (and simplify packetdrill tests)



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 215)

  216  The infinite mapping support [enhancement] @geliangtang:
      - related to MP_FAIL series
      - ideally we need kselftests and packetdrill tests (with Poorva's
support)


    Bugs (opened, flagged as "bug" and assigned)

  191  Could you please let me know how to use "ip mptcp end points
backup"? [bug] [question] @matttbe


    Bugs (opened and flagged as "bug" and not assigned)

  203  PM: server: accept subflows [bug]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]
  137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable
[bug]
   65  packetdrill/fixes: clearing properly the status in
listen()/disconnect [bug]


    In Progress (opened and assigned)

  216  The infinite mapping support [enhancement] @geliangtang
  206  MPTCP-level retransmission strategy is probably too aggressive.
[enhancement] @pabeni:
      - linked to patches above

  194  Round-robin packet scheduler support [enhancement] @geliangtang

  193  Fullmesh path manager support [enhancement] @geliangtang:
      - linked to patches above

  186  Add netlink command support [enhancement] @mjmartineau
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti

   52  MP_FAIL support [enhancement] @geliangtang:
      - linked to patches above


    Recently closed (since last week)

  189  Wireshark / TCPDump doesn't understand option subtype 8
(MP_TCPRST) [enhancement] @dcaratti



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.15):
https://github.com/multipath-tcp/mptcp_net-next/projects/10
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4
    - Wiki has been updated: ChangeLog for 5.14



Patches to send to netdev:
    - net:
        - no patch to send in our tree (everything has already been applied)

    - net-next:
        - still closed



Extra tests:
    - news about Syzkaller? (Mat):
        - nothing related to MPTCP

    - news about interop with mptcp.org? (Mat):
        - /

    - news about Intel's kbuild? (Mat):
        - quickly found an issue in a patch sent on the ML

    - packetdrill (Davide):
        - /

    - Patchew:
        - Davide was supposed to be fixed but some issues
        - Davide will check with Matth to see where the problem is

    - CI (Matth):
        - /



Next meeting:
    - On Thursday, the 22th of July.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210722



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
