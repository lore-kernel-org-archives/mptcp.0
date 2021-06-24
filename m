Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3091470
	for <mptcp@lists.linux.dev>; Thu, 24 Jun 2021 16:11:41 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id c7so9317055edn.6
        for <mptcp@lists.linux.dev>; Thu, 24 Jun 2021 09:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=M6436HmA2ZfmRadQ+l/srj1I/O7uM8IU1sfr54jvbM8=;
        b=Yybtljz6ou2w8gXTJLBNpsKROu4urc4rGicTwa0B+8B2Lv1NVriYzFm7ukJllrNzVR
         kDx848r0846qdMgu40oFKe/CL2MG/3LR4vNqrpYGfujqT1lKR+4U6Y1En5xYSXIPMN11
         EJq/3FdXZGOzfrvkQxxZuGrP7ywKGHbWbDkh5ZfYDD6zVxp03PVwAsnJnjPgBd6qH+c8
         25xlvfsFsM4eTivAsooPox8HNIudQ1i9Ex+xKfjEEIve6MYlnfvWgDtIFaFQubi6Q2XV
         ysSoh/40a3tvSmIx6thhPKXSqGsEsil6jpAl1oM1iOr2Jg2A177Djru6kaFerTUlyKlK
         s3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=M6436HmA2ZfmRadQ+l/srj1I/O7uM8IU1sfr54jvbM8=;
        b=NtUJjXk+xDi7oHH9gw6wG9ZEds8lAhSgxTYX5paOZARi/dkOvrkZOc3HHc47k2Z45i
         YGxfE6HYldaCjCToI9YhIiwKi/lKEUXMcfR+t9LFD5NYf81GWmloEzfDVQq00coRFcgt
         UmHR2K2Fj4lN/i/3Ne8zbMosu2WllR6ZoXxBKJDw2x8XprWzUwteZsmWcFoPHhYz8Md7
         VEDouOw065hJzoq3LZEDqTqjE6A15qoXhnIzXyOYlcAsvRqCLWIjyRVneUZOQ5trY0mN
         P1VvXsqbWPW1FTmD3Fp/k5Aa5L8CyUqXSSiMm+11233vE2aQ2loNvCSoa2LCn6Ih0Bvz
         ez7Q==
X-Gm-Message-State: AOAM531C/XF8EZNNN5t3i61Gcks98VJlDr3lNX9DSEgUlVmuo+/Ae2iH
	uC8es8AVrFgDwduhKBpQRaO6krlkkb6F9uE4Aw6nlQ==
X-Google-Smtp-Source: ABdhPJxBXxKR9HWlwwxP5iDdRb2FRxbVAXkQ+vvHawQJgmWwyYiXWmyhcIMF+wJ7cY1sS1lIibIhtg==
X-Received: by 2002:a05:6402:90b:: with SMTP id g11mr8220710edz.336.1624551099478;
        Thu, 24 Jun 2021 09:11:39 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:4243:be2b:bb35:da12])
        by smtp.gmail.com with ESMTPSA id gx4sm1469769ejc.34.2021.06.24.09.11.39
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 09:11:39 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 24th of June 2021
Message-ID: <6e781761-0a08-746a-0018-ef8ed761bfa1@tessares.net>
Date: Thu, 24 Jun 2021 18:11:38 +0200
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



Today, we just had our 154th meeting with Mat and Ossama (Intel),

Christoph said Hi (Apple), Florian, Paolo and Davide (RedHat), Geliang
(Xiaomi) and myself (Tessares).





Thanks again for this new good meeting!



Here are the minutes of the meeting:







Accepted patches:

    - The list of accepted patches can be seen on PatchWork:

      https://patchwork.kernel.org/project/mptcp/list/?state=3




    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12338401  [net-next,6/6] mptcp: refine mptcp_cleanup_rbuf
12338397  [net-next,5/6] selftests: mptcp: turn rp_filter off on each NIC
12338399  [net-next,4/6] selftests: mptcp: add deny_join_id0 testcases
12338395  [net-next,3/6] mptcp: add deny_join_id0 in mptcp_options_received
12338393  [net-next,2/6] mptcp: add allow_join_id0 in mptcp_out_options
12338391  [net-next,1/6] mptcp: add sysctl allow_join_initial_addr_port

12336171  [net,2/2] mptcp: drop duplicate mptcp_setsockopt() declaration
12336173  [net,1/2] mptcp: avoid race on msk state changes

12335921  [net-next,6/6] selftests: mptcp: display proper reason to
abort tests
12335919  [net-next,5/6] mptcp: add MIB counter for invalid mapping
12335917  [net-next,4/6] mptcp: drop redundant test in move_skbs_to_msk()
12335915  [net-next,3/6] mptcp: don't clear MPTCP_DATA_READY in
sk_wait_event()
12335911  [net-next,2/6] mptcp: use fast lock for subflows when possible
12335913  [net-next,1/6] mptcp: drop tx skb cache

12332229  [net,2/2] mptcp: fix 32 bit DSN expansion
12332231  [net,1/2] mptcp: fix bad handling of 32 bit ack wrap-around

12329815  [net-next,16/16] selftests: mptcp: enable checksum in
mptcp_join.sh
12329811  [net-next,15/16] selftests: mptcp: enable checksum in
mptcp_connect.sh
12329813  [net-next,14/16] mptcp: dump csum fields in mptcp_dump_mpext
12329809  [net-next,13/16] mptcp: add a new sysctl checksum_enabled
12329807  [net-next,12/16] mptcp: add the mib for data checksum
12329803  [net-next,11/16] mptcp: tune re-injections for csum enabled mode
12329805  [net-next,10/16] mptcp: validate the data checksum
12329801  [net-next,09/16] mptcp: receive checksum for DSS
12329797  [net-next,08/16] mptcp: receive checksum for MP_CAPABLE with data
12329799  [net-next,07/16] mptcp: add csum_reqd in mptcp_options_received
12329829  [net-next,06/16] mptcp: add sk parameter for mptcp_get_options
12329825  [net-next,05/16] mptcp: send out checksum for DSS
12329827  [net-next,04/16] mptcp: send out checksum for MP_CAPABLE with
data
12329823  [net-next,03/16] mptcp: add csum_reqd in mptcp_out_options
12329819  [net-next,02/16] mptcp: generate the data checksum
12329817  [net-next,01/16] mptcp: add csum_enabled in mptcp_sock


    our repo (by: Paolo Abeni):

12331855  [mptcp-net] mptcp: drop duplicate mptcp_setsockopt() declaration

12328933  [v2,mptcp-net] mptcp: avoid race on msk state changes


Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Jianguo Wu, Jiapeng Chong, Matthieu
Baerts, Paolo Abeni, Yonglong Li):

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

12316361: RFC: [RFC] tcp: consistently disable header prediction for mptcp:
    - Waiting for feedback from Florian
    - a similar patch was already sent upstream and was accepted
    - but there were some regressions there in some test cases
    - this patch avoids (a lot of) additional checks in TCP code
    - it is unclear what is the impact of that on TCP itself: so it
should be OK for MPTCP. For TCP, that will require more tests (check why
it has been reverted)
    - TODO: *Matth* apply it in our tree → Done
    - TODO: *Paolo* send it upstream

12321111: Changes Requested: mptcp: Remove redundant assignment to
remaining:
    - No news from the author

12336787: Under Review: [mptcp-net] mptcp: properly account bulk freed
memory:
    - Mat did a review and has some questions
    - Not urgent, discussions can continue on the ML

12324763: Changes Requested: [v5,1/4] mptcp: fix warning in
__skb_flow_dissect() when do syn cookie for subflow join
12324761: Changes Requested: [v5,2/4] mptcp: remove redundant req
destruct in subflow_check_req()
12324765: Changes Requested: [v5,3/4] mptcp: fix syncookie process if
mptcp can not_accept new subflow
12324767: Changes Requested: [v5,4/4] mptcp: avoid processing packet if
a subflow reset:
    - Series: Fix some mptcp syncookie process bugs
    - v6 is required
    - maybe a confirmation is needed for patch 4/4? → Paolo sent a reply

12336423: Under Review: [v5,1/4] mptcp: fix ADD_ADDR and RM_ADDR maybe
flush addr_signal each other
12336425: Under Review: [v5,2/4] mptcp: make MPTCP_ADD_ADDR_SIGNAL and
MPTCP_ADD_ADDR_ECHO separate
12336427: Under Review: [v5,3/4] mptcp: build ADD_ADDR/echo-ADD_ADDR
option according pm.add_signal
12336429: Under Review: [v5,4/4] mptcp: remove MPTCP_ADD_ADDR_IPV6 and
MPTCP_ADD_ADDR_PORT:
    - series: "mptcp: fix conflicts when using pm.add_signal in
ADD_ADDR/echo and RM_ADDR process"
    - Under review

12342057: New: [v2,mptcp-next,1/5] mptcp: MP_FAIL suboption sending
12342059: New: [v2,mptcp-next,2/5] mptcp: MP_FAIL suboption receiving
12342061: New: [v2,mptcp-next,3/5] mptcp: send out MP_FAIL when data
checksum fail
12342063: New: [v2,mptcp-next,4/5] mptcp: add the mibs for MP_FAIL
12342065: New: [v2,mptcp-next,5/5] selftests: mptcp: add MP_FAIL mibs check:
    - Mat will have a look at it



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 208)

  211  mptcp connection stalls when mptcp retransmission are disabled
[bug] @pabeni:
      - Paolo already sent a patch: "mptcp: properly account bulk freed
memory"
      - v2 is under test
      - will be part of a series with other fixes
      - stabilising "simult_flows.sh" but something else might be needed
to fix issues/137:
          - the scheduler might pick the slow subflow, sending a lot of
data and blocking the faster one
          - we might need an implementation like "BLEST" not to block
the faster one by picking the slow path

  210  Accept new subflows when the listening socket is closed or bind
to one IP? [enhancement]:
      - linked to discussions we had last week

  209  Quicker use of backup subflows [enhancement]:
      - linked to discussions we had last week: should vs must
      - Paolo is looking at marking subflows that doesn't seem
functional: didn't see a ACK for a "long" time (number of RTOs)
      - the scheduler could then take decisions based on that ↑ and the
backup flag


    Bugs (opened, flagged as "bug" and assigned)

  211  mptcp connection stalls when mptcp retransmission are disabled
[bug] @pabeni:
      - See above

  200  fallback rx path is broken [bug] @pabeni:
      - Can be closed when "tcp: consistently disable header prediction
for mptcp" is applied → Done

  191  Could you please let me know how to use "ip mptcp end points
backup"? [bug] [question] @matttbe:
      - Matth: To check


    Bugs (opened and flagged as "bug" and not assigned)

  203  PM: server: accept subflows [bug]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]

  137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable
[bug]:
    - Failing almost constantly on the public CI

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

  212  MPTCP v5.13 kernel compilation Fail to load/boot  [question]
  205  Checksum interop problem with mptcp_trunk
  204  wrong handling of 32bit ack wrap-around [bug] @pabeni
  120  [interop] netnext is dropping packets, causing MPTCP-level
retransmissions on mptcp.org [bug]
   56  msk connection state set without msk lock [bug]



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.14):
https://github.com/multipath-tcp/mptcp_net-next/projects/9
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches for (MPTCP)-net or (MPTCP)-next?:
    - new feature: for net-next (mptcp-next first)
    - if it deserves a "Fixes" tag → for net? (if the mentioned commit
is in -net of course)
    - if there is a "Fixes" tag, it is going to be backported anyway, no?:
        - Yes but only when net-next is merged in Linus tree.
    - it deserves a "Fixes" if it fixes any bug introduced by a previous
commit
    - exception: fixes that don't have any impacts (e.g. in selftests if
we add something special) and are part of a series adding a new feature.
    - What about fixes/optimisations: what can be seen as an
optimisations even if it fixes something but can affect perf/behaviour:
        - to check case by case (hard to be clear then :-/)
    - We should copy the same behaviour as the one for netdev
(-net/net-next): Mat will check
    - Maybe the behaviour has changed since stable stuff is only handled
by Greg and Sasha



Patches to send to netdev:
    - net:
        - / → nothing pending

    - net-next:
        - / → nothing pending
        - window merge might close this WE



Extra tests:
    - news about Syzkaller? (Mat):
        - Running but nothing related to MPTCP
        - frequently synced with the export branch

    - news about interop with mptcp.org? (Mat):
        - one patch has been shared (linked to issue 205) but not fixing
all issues
        - someone else has opened an issue on mptcp.org tracker →
similar to what Mat saw
        - https://github.com/multipath-tcp/mptcp/issues/427
        - (the person who opened this ticket is trying to interop with
MPTCPv1 using a custom stack but no more details have been share)
        - more work needed there (mptcp.org)

    - news about Intel's kbuild? (Mat):
        - no error on the export branch
        - good that they are also testing patches sent to our ML (a bit
of lag but that's normal)

    - packetdrill (Davide):
        - /

    - CI (Matth):
        - /



Patchew:
    - Davide is checking issues with maintainers




Next meeting:

    - On Thursday, the 1st of July.

    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)

    - Still open to everyone!

    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210701





Feel free to comment on these points and propose new ones for the next

meeting!



Talk to you on Thursday,

Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
