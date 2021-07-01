Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D930A70
	for <mptcp@lists.linux.dev>; Thu,  1 Jul 2021 20:43:00 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id s15so10181088edt.13
        for <mptcp@lists.linux.dev>; Thu, 01 Jul 2021 13:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=R/ylaQKWFerDFOMYoB1snyekW8JQDM5fkVVmbaLyqKw=;
        b=BZTSO8WDfl2rqxp3mCvGpYeEXR1iAoQX5tIZXwkA/M3EMPj9EzMRrdX+e64baHl85y
         DPdgJ2c+lcxXhaHYN5gb53WPcloiEtbaQzsU1XCSgsPSamejWzMICDRZJB3+VjsSvJL1
         FUqs4iTxxPlmwD096N62rxqSAg/E5Cuw7ywGV0wtj0X6YWERkZMOeW/7dg4D3lr+4ggI
         xAm6Qa/hZam3Dhj/fmYLBht9pAlBkDrbeiBs4NPsNKX58S66M3op4GCWm9mW8WX7widD
         Ct5VmzYVhoDeOZlXfHMlnf7B/V7vF5sOl0E/mACCQ/+N24iQnnKk7Nm0jHVOLnV2eP/E
         RLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=R/ylaQKWFerDFOMYoB1snyekW8JQDM5fkVVmbaLyqKw=;
        b=OWOP0tr5mffiJMopIltx5+/D0JdEg2KzcCDxfxyy9flV6fRsePTSmpqM9mUsTz13kz
         Gt/vtMTamKQ+7vQbCMtkMBzqKgo21Zt3dCsIY5hSWtobhvNaPtOFaPdzB87bP5gYo3AR
         6ETKEdU/FqPdrDWOZOFZqtG7p5TgMB5EsThykHoEaVUVEStPL7lLSSqLn9zLsjmZTFW3
         BNqQm+6IDYL0ZTdl7TyNwecTICsM4pHyxXIKa1LuTijrfqGp7CVymCjWN5D64DhQEN3p
         k5qiHgdMjWtW+Zh6byb59slTFzhCGBVbwB9aQslhRV430zSB3DVflp88SiRSW/mx7Bty
         o5YA==
X-Gm-Message-State: AOAM533nEcS34v5rGucoe5n3T9kfFWpMxv/BMnyE6vQRgpA41N+xByoS
	00t6rjSQ/G5Zo+g6tzMjSnTQXz08fZKp6++G
X-Google-Smtp-Source: ABdhPJzm6pLpwStlYaUYD5Ay4qQOC3pCspdFiV7nQ3rq1h/rHZ23uSBkwnhxYIRvmefuZx1Lc4rY0g==
X-Received: by 2002:a50:fb01:: with SMTP id d1mr2211663edq.347.1625172178527;
        Thu, 01 Jul 2021 13:42:58 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:7977:56ce:9f5c:d088])
        by smtp.gmail.com with ESMTPSA id x21sm380551eds.38.2021.07.01.13.42.58
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 13:42:58 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 1st of July 2021
Message-ID: <5ed5e309-d1eb-4016-698c-3cb9f9b73f04@tessares.net>
Date: Thu, 1 Jul 2021 22:42:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
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

Today, we just had our 155th meeting with Ossama (Intel), Florian,
Paolo, Davide, Poorva (RedHat) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:






Poorva:

    - New member!

    - Working on packetdrill, e.g.:
 adding support on new sockoptions, etc.



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12345927  [net-next] mptcp: fix 'masking a bool' warning


    our repo (by: Jianguo Wu, Matthieu Baerts, Paolo Abeni ):

12346345  [mptcp-net,v8,5/5] selftests: mptcp: fix case multiple
subflows limit...
12346351  [mptcp-net,v8,4/5] mptcp: avoid processing packet if a subflow
reset
12346347  [mptcp-net,v8,3/5] mptcp: fix syncookie process if mptcp can
not_acce...
12346349  [mptcp-net,v8,2/5] mptcp: remove redundant req destruct in
subflow_ch...
12346341  [mptcp-net,v8,1/5] mptcp: fix warning in __skb_flow_dissect()
when do...

12344879  [mptcp-next] mptcp: fix 'masking a bool' warning

12316361  [RFC] tcp: consistently disable header prediction for mptcp



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Paolo Abeni, Y.b. Lu ):

12351833  [net] tcp: consistently disable header prediction for mptcp

12351509  [net-next,v5,08/11] net: sock: extend SO_TIMESTAMPING for PHC
binding


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
    - Waiting for a v2

12347221: New: [v3,mptcp-next,1/8] mptcp: MP_FAIL suboption sending
12347223: New: [v3,mptcp-next,2/8] mptcp: MP_FAIL suboption receiving
12347225: New: [v3,mptcp-next,3/8] mptcp: send out MP_FAIL when data
checksum fail
12347227: New: [v3,mptcp-next,4/8] mptcp: add the mibs for MP_FAIL
12347229: New: [v3,mptcp-next,5/8] selftests: mptcp: add MP_FAIL mibs check
12347231: New: [v3,mptcp-next,6/8] mptcp: infinite mapping sending
12347233: New: [v3,mptcp-next,7/8] mptcp: infinite mapping receiving
12347235: New: [v3,mptcp-next,8/8] mptcp: add a mib for the infinite
mapping sending:
    - v3 addressing comments from Mat
    - no urgency, we can wait for Mat to be back to see if the diff
between v2/v3

12348239: New: [v2,mptcp-net] mptcp: properly account bulk freed memory:
    - v2  addressing comments from Mat
    - no urgency, we can wait for Mat to be back to see if the diff
between v1/v2

12348297: New: [mptcp-next,1/7] mptcp: more accurate timeout
12348299: New: [mptcp-next,2/7] mptcp: less aggressive retransmission
stragegy
12348291: New: [mptcp-next,3/7] mptcp: handle pending data on closed
subflow
12348293: New: [mptcp-next,4/7] mptcp: faster active backup recovery
12348301: New: [mptcp-next,5/7] mptcp: add mibs for stale subflows
processing
12348295: New: [mptcp-next,6/7] mptcp: backup flag from incoming MPJ ack
option
12348305: New: [mptcp-next,7/7] selftests: mptcp: add testcase for
active-back:
    - Series: "mptcp: refactor active backup"
    - Waiting for reviews
    - If we want a new sysctl, we need to update the Doc
    - Opened question: should we have a sysctl or a PM parameter:
        - no strong opinion
        - sysctl might be better because it is related to the packet
scheduler
    - maybe some functions can be renamed when they are more related to
the packet scheduler than the PM
    - when we talk about MPTCP "retransmissions", maybe clearer to talk
about "reinjections" not to think we talk about TCP retransmissions.

12351801: Changes Requested: [v7,1/5] mptcp: fix ADD_ADDR and RM_ADDR
maybe flush addr_signal each other
12351799: Changes Requested: [v7,2/5] mptcp: make MPTCP_ADD_ADDR_SIGNAL
and MPTCP_ADD_ADDR_ECHO separate
12351803: Changes Requested: [v7,3/5] mptcp: build
ADD_ADDR/echo-ADD_ADDR option according pm.add_signal
12351805: Changes Requested: [v7,4/5] mptcp: remove some double-check
12351807: Changes Requested: [v7,5/5] mptcp: remove MPTCP_ADD_ADDR_IPV6
and MPTCP_ADD_ADDR_PORT:
    - v7 addressing comments from Geliang and Mat
    - Geliang did a review on the v7 and suggested a few other small
modifications: almost there!

12351927: New: [mptcp-next] Squash to "mptcp: send out MP_FAIL when data
checksum fail":
    - Needs review
    - Linked to the MP_FAIL series.



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 212)

  213  add MPTCP man page [enhancement]:
      - target: sysadmin and app devs
      - Kernel doc is maybe more for specific stuff
      - man page seems more accessible
      - we can still mark in the man page that something is available
from a certain version
      - could be good to introduce how to create an MPTCP socket, how to
interact with it, configure the PM, etc.
      - might need to be started/well reviewed by English natives people
      - HowTo: https://www.kernel.org/doc/man-pages/


    Bugs (opened, flagged as "bug" and assigned)

  211  mptcp connection stalls when mptcp retransmission are disabled
[bug] @pabeni:
      - See above: "mptcp: refactor active backup"

  191  Could you please let me know how to use "ip mptcp end points
backup"? [bug] [question] @matttbe:
      - Same status as last week
      - Paolo fixed backup flag handling on the outgoing connections
      - Paolo didn't change how the flag is handled when we set the
backup flag on one side but not on the other side: in this case, the
host where we put the flag will not consider the subflow as a backup
one. → We might want to change that: likely the client knows one subflow
should be backup and be the only one to set the flag.


    Bugs (opened and flagged as "bug" and not assigned)

  203  PM: server: accept subflows [bug]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]
  137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable
[bug]
   65  clearing properly the status in listen() [bug]


    In Progress (opened and assigned)

  206  MPTCP-level retransmission strategy is probably too aggressive.
[enhancement] @pabeni
  194  Round-robin packet scheduler support [enhancement] @geliangtang
  193  Fullmesh path manager support [enhancement] @geliangtang
  189  Wireshark / TCPDump doesn't understand option subtype 8
(MP_TCPRST) [enhancement] @dcaratti
  186  Add netlink command support [enhancement] @mjmartineau
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti
   52  MP_FAIL support [enhancement] @geliangtang


    Recently closed (since last week)

  200  fallback rx path is broken [bug] @pabeni



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.14):
https://github.com/multipath-tcp/mptcp_net-next/projects/9
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4
    - TODO: Matth: new project for 5.15 + update changelog, etc.



Patches to send to netdev:
    - net:
        - One patch from Paolo has already been sent
        - "Fix some mptcp syncookie process bugs" series: maybe best to
wait a bit to have more coverage before sending them

    - net-next:
        - /



Extra tests:
    - news about Syzkaller? (Mat):
        - /

    - news about interop with mptcp.org? (Mat):
        - /

    - news about Intel's kbuild? (Mat):
        - /

    - packetdrill (Davide):
        - Davide is working on a setup where we can have multiple MPJ in
different directions:
            - needed for MP_PRIO
        - Poorva found that SOL_IP was not working at all:
            - not working as expected compared to its usage with TCP
            - we need a kernel patch for that

    - Patchew (Davide):
        - We will need new accounts, even for Davide
        - Best to have one for Mat and Matth (at least) just in case
        - Davide will check with Paolo Bonzini
        - It should be OK to use our accounts for the CI
        - There are also different levels of permissions and we need the
good ones

    - CI (Matth):
        - switched to latest version of tcpdump and iproute2



Next meeting:
    - On Thursday, the 8th of July.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210708



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
