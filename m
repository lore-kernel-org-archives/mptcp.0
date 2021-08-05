Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9F70
	for <mptcp@lists.linux.dev>; Thu,  5 Aug 2021 18:42:32 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id x90so9729521ede.8
        for <mptcp@lists.linux.dev>; Thu, 05 Aug 2021 11:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=fXjQEi56uacMHP7y/wT7Jyfb8LZxRISQKbTZ/LRn6jM=;
        b=zVrzEisENcvZ9bW/t9l6nSuQ4exDno3NsLhgq9We6QazdYXcS5PuUYJJEmN/62g3Co
         eNBC58lv++OdZw8mMmW/zdYYeVoxSOwdBSxYnHWRPDHM7vnIK9sempeQQwUpe2REYJ24
         YjT/Zfkd3VhjkJR4hnCUNvT9DXjFFDWII4+X2hG3iqfrvVTY5pj8QACdeRk/N2F8juYt
         TfMQ+MPDDjRboUXhBtQoDF9Uu9YgDmMrg7y1meWhcendNph4fuvJ7SoMwx0KRgbRN2d1
         Eh8bFN4IZKWbqzDX3cVAJb/nLrMsWRVCw5nZYHZ4UW2gbAQIMwjDC3hg44ck/LSYa9BW
         sACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=fXjQEi56uacMHP7y/wT7Jyfb8LZxRISQKbTZ/LRn6jM=;
        b=A8nTN0bF9GJwWUs2ubQFYkyK7jEYZwQXFEZEhZuwsmLKiusF2NujE+EeawqKkhKhib
         ivuK4d7lcBCI0UQEnPN18axxufPmx8SR0VeXkkjgIyNFSbMoE7pamNrKguN2VftSB884
         6SRGv/btyeM+sNgVlyUXJKj6Ugs05fnLVdEyamM3CfpVxD2iXP30IpJzf5yRnN8TfOY1
         jw+FkWDB3If33pTa6D/zejC1ZbnmB5nNxRhLaPRyLsNsIxZOkrMpQRs5zDbgGCPmJYaL
         fbXlijLSJjKPRuzyKXVGCOpO7MIGiXIe2IrqmYCc14VuwKb3MwkvBCqSEkEFDGI6tEtd
         tLAg==
X-Gm-Message-State: AOAM533TYNKtTqfOdYuot140sHVZgTkux7K+wGQYh6Wt6hoHV+x/wp+i
	B4EaUlEWFBqaMZZgRSJhpUaFaesSdx1QxbWF
X-Google-Smtp-Source: ABdhPJzLxP4ff2EsGyNdGumNSt6wxzrV+3MGdmyoSM+v/KUMvcgqC0uIO0DafN+x/TPr1Vr9nM5KXA==
X-Received: by 2002:a05:6402:3512:: with SMTP id b18mr8472943edd.364.1628188950718;
        Thu, 05 Aug 2021 11:42:30 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.102.61.dyn.edpnet.net. [94.105.102.61])
        by smtp.gmail.com with ESMTPSA id f15sm2667397edd.54.2021.08.05.11.42.30
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 11:42:30 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 5th of August 2021
Message-ID: <a3a0bf7d-3647-a5ed-e3a8-43bf09a48831@tessares.net>
Date: Thu, 5 Aug 2021 20:42:29 +0200
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

Today, we had our 159th meeting with Mat and Ossama (Intel), Florian and
Paolo (RedHat), Geliang (Xiaomi) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Yajun Deng):

12416657  [net] mptcp: drop unused rcu member in mptcp_pm_addr_entry


    our repo (by: Geliang Tang, Matthieu Baerts):

12418007  [mptcp-next] Squash to "mptcp: remote addresses fullmesh"

12417989  [mptcp-next] Squash to "selftests: mptcp: add fullmesh testcases

12408461  [v4,mptcp-next] Squash to "mptcp: drop flags and ifindex
arguments"

12408121  [v7,mptcp-next,5/5] selftests: mptcp: add MP_FAIL mibs check
12408119  [v7,mptcp-next,4/5] mptcp: add the mibs for MP_FAIL
12408117  [v7,mptcp-next,3/5] mptcp: send out MP_FAIL when data checksum
fails
12408115  [v7,mptcp-next,2/5] mptcp: MP_FAIL suboption receiving
12408113  [v7,mptcp-next,1/5] mptcp: MP_FAIL suboption sending

12407893  [v7,mptcp-next,6/6] selftests: mptcp: delete uncontinuous
removing ids
12407891  [v7,mptcp-next,5/6] selftests: mptcp: add fullmesh testcases
12407889  [v7,mptcp-next,4/6] selftests: mptcp: set and print the
fullmesh flag
12407887  [v7,mptcp-next,3/6] mptcp: local addresses fullmesh
12407885  [v7,mptcp-next,2/6] mptcp: remote addresses fullmesh
12407883  [v7,mptcp-next,1/6] mptcp: drop flags and ifindex arguments



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12417747  [net-next,v2] net: Modify sock_set_keepalive() for more scenarios


    our repo (by: Florian Westphal, Jiapeng Chong, Matthieu Baerts,
Paolo Abeni):

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
    - TODO

12394261: RFC: [RFC] mptcp: add MPTCP_INFO getsockopt:
    - Discussions continued on the ML
    - Florian almost restarted from scratch
    - Added tests cases, more coverage
    - Will send a version later to have more discussions.



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 218)

  223  [syzkaller] Memory leak in mptcp_nl_cmd_add_addr:
      - there is a reproducer, seems easy to repro, maybe due to recent
changes
      - Geliang will look at that
      - TODO: assign Geliang on it → Done

  222  Netlink event API: add SUBFLOW_CREATED event [enhancement]:
      - linked to the discussion from last week: the userspace needs an
event when the subflow is created to be able to interact with it (get
the final 5-tuple) if it is not established.

  221  selftests: join: "backup flow used, multi links fail" is unstable
[bug] [selftests]:
      - We miss additional MP_JOIN
      - e.g. it should create 2 additional SF but only created one
      - maybe related to the fact we now have all ADD_ADDR in a
dedicated TCP (pure) ACK
      - there is also an MP_JOIN HMAC error that looks suspicious
      - Matth: TODO: check if it is linked

  220  support for setsockopt(SOL_IP) [enhancement]:
      - Linked to a discussion from last week
      - Poorva is looking at that
      - TODO: Matth: assign Poorva → Poorva needs to accept joining the
MPTCP team first.

  219  [syzkaller] divide error in tcp_write_xmit [bug] [syzkaller]:
      -  Opened during the meeting last week


    Bugs (opened, flagged as "bug" and assigned)

/


    Bugs (opened and flagged as "bug" and not assigned)

  221  selftests: join: "backup flow used, multi links fail" is unstable
[bug] [selftests]:
      - See above

  219  [syzkaller] divide error in tcp_write_xmit [bug] [syzkaller]
  203  PM: server: accept subflows [bug]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]
  137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable
[bug]
   65  packetdrill/fixes: clearing properly the status in
listen()/disconnect [bug]


    In Progress (opened and assigned)

  218  Add support for MPTCP_INFO, similar to TCP_INFO [enhancement]
@fw-strlen:
      - See discussions above

  216  The infinite mapping support [enhancement] @geliangtang
  194  Round-robin packet scheduler support [enhancement] @geliangtang
  186  Add netlink command support [enhancement] @mjmartineau
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti


    Recently closed (since last week)

  206  MPTCP-level retransmission strategy is probably too aggressive.
[enhancement] @pabeni
  193  Fullmesh path manager support [enhancement] @geliangtang
   52  MP_FAIL support [enhancement] @geliangtang



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.15):
https://github.com/multipath-tcp/mptcp_net-next/projects/10
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - net:
        - /

    - net-next:
        - scheduler refactoring (Paolo):
            - maybe best to wait to have more coverage? see issues 219
and 221 and 223
        - ADD_ADDR/RM_ADDR refactoring (Yonglong & Geliang):
            - maybe best to wait to have more coverage? see issues 219
and 221 and 223
        - mptcp_out_options refactor (Paolo):
            - maybe best to wait to have more coverage? see issues 219
and 221 and 223
        - Fullmesh support (Geliang):
            - has just been merged in our tree, maybe best to wait mid
of week
        - MP_FAIL (Geliang):
            - has just been merged in our tree, maybe best to wait mid
of week
            - but depends on "mptcp_out_options refactor"



Extra tests:
    - news about Syzkaller? (Mat & Christoph):
        - Mat's Syzkaller found 2 issues: 223 and one on IRC, already
fixed by Paolo (not in MPTCP code)
        - Mat will relaunch it on latest export branch

    - news about interop with mptcp.org? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - some issues not related to MPTCP last week
        - now pretty stable
        - just one deadlock when trying to remove a virtual device,
probably not related to MPTCP.

    - packetdrill (Davide):
        - some modifications due to behaviour changes in the kernel
(Paolo) → merged
        - some reviews for Poorva have been done

    - Patchew:
        - /

    - CI (Matth):
        - the join selftests are quite unstable for the moment with a
debug kernel: see issue 221



Next meeting:
    - On Thursday, the 12th of August.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210812



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
