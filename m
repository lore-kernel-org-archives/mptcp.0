Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB534C6A
	for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 13:12:28 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id v185-20020a1cacc2000000b003b42e4f278cso4631607wme.5
        for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 06:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=xjsc33Wh6Sj63vwZdUBigFOQ13p18ThokAb6iqxKRAo=;
        b=3fBEf+617qs9a0SYm9ueq46ak8g46oVHXB+bT6vlBaBt5QgynAS3VBC1YhSzmUBEJx
         Q5A1ZBpfuSPlbPjqSSOTLKqnl8BqD+4sX0zm1R7JoY4yJ0Qpc3h5OfMmx0KPM4bnwnbR
         WKYfMzvohwW5xUVaNmWOGgu1EtgQsz/YrDIaEGUM8DaiUnetMXU8qginErfmQR8FiZ9p
         O/rq65Sk8yTGCesYnbtzI1agTBwQ7ZxW5uRAiazJiHZo5sVAP9t126HEmXRjwDoNEFrO
         XaNXAythZZF6iniGm3Exii48AVKnCpqfYLGmd90W/DtpMXCCVy1PZrP3JW8XPbBLC/Xg
         XMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=xjsc33Wh6Sj63vwZdUBigFOQ13p18ThokAb6iqxKRAo=;
        b=LfEFDdD0AvaOr2SIZ9EeLuJR6Oy2izDoNA6rLOVidLk7cAhfPHij76ymQArC5y5yjC
         v2xKmrhD49T9H7MC8RdHgGvhAoz0+Qd8MmjAN7pGiZ288XPQCN0PjIX9TcF5KwJ5QcAh
         l234+eBq0RBY0jUbWVRSyiOijExc1P+cMx+62Dq0a8L9OXITpgU3K+A9P5en2CQ1+epy
         lhUBte/teNyvRz9R2+1ES7EEN4wpAPrqOO+oc11VM+E1OfcDY46RWnQQdDzPCCi8ZRM4
         +TqGBHddequ1aimiLWLqTREcXEuW7997VzuKDu8lg43cqJpBA/0pyDXB4+nqssXihn+l
         uWGg==
X-Gm-Message-State: ACrzQf0vXze3pVQ4RP00EMw2vmaApFERdOlfZGIp8a72VAYgh7r2KlrB
	RGJBq8BypZfcbrAAxjqK8QEzdujOmH7pXA==
X-Google-Smtp-Source: AMsMyM4ZfgNvffYCbY2i2YEhftAFK9TRlYoSA0Yv0V09dPPrgAhFNZ9MqJP0Yub3ycaZN+DE8L+v7w==
X-Received: by 2002:a05:600c:4e15:b0:3b4:a621:b54e with SMTP id b21-20020a05600c4e1500b003b4a621b54emr11967972wmq.47.1663593146104;
        Mon, 19 Sep 2022 06:12:26 -0700 (PDT)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id c9-20020adffb49000000b00228dbf15072sm13993433wrs.62.2022.09.19.06.12.25
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 06:12:25 -0700 (PDT)
Message-ID: <5534f019-40e1-a7f1-c428-d7cb3dfaff12@tessares.net>
Date: Mon, 19 Sep 2022 15:12:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 8th of September 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

*Two* weeks ago, we just had our 208th meeting with Mat, Ossama (Intel),
Paolo (Redhat), Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:


Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Matthieu Baerts):

12967412: [mptcp-net] Documentation: mptcp: fix pm_type formatting:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220906122025.743592-1-matthieu.baerts@tessares.net/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

12967992: [net,1/2] mptcp: fix fwd memory accounting on coalesce
12967993: [net,2/2] Documentation: mptcp: fix pm_type formatting:
      - Series: [net,1/2] mptcp: fix fwd memory accounting on coalesce
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=674612&state=*&archive=both

12968184: [net-next,1/5] mptcp: add mptcp_for_each_subflow_safe helper
12968185: [net-next,2/5] selftests: mptcp: move prefix tests of
addr_nr_ns2 together
12968186: [net-next,3/5] mptcp: add do_check_data_fin to replace copied
12968187: [net-next,4/5] mptcp: allow privileged operations from user
namespaces
12968188: [net-next,5/5] mptcp: account memory allocation in
mptcp_nl_cmd_add_addr() to user:
      - Series: mptcp: allow privileged operations from user ns & cleanup
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=674650&state=*&archive=both


    our repo (by: Benjamin Hesmans, Dmytro SHYTYI, Florian Westphal,
Geliang Tang, Jason Wang, Jiapeng Chong, Matthieu Baerts, Menglong Dong,
Paolo Abeni):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
12321111: mptcp: Remove redundant assignment to remaining:
      - State: RFC
      - Status: same as last week

12901431: [mptcp-next,v10,1/5] Squash to "mptcp: add get_subflow wrappers"
12901432: [mptcp-next,v10,2/5] mptcp: redundant subflows push pending
12901433: [mptcp-next,v10,3/5] mptcp: redundant subflows retrans support
12901434: [mptcp-next,v10,4/5] selftests/bpf: Add bpf_red scheduler
12901435: [mptcp-next,v10,5/5] selftests/bpf: Add bpf_red test:
      - State: Changes requested
      - Status: same as last week

12922458: mptcp: Fix comment typo:
      - State: Changes requested
      - Status: same as last week

12933347: [RFC,mptcp-next,v4] mptcp: Fast Open Mechanism:
      - State: RFC
      - Status: same as last week

12947468: [RFC] net: tcp: prevent transition to FIN_WAIT2 when mptcp has
unacked data_fin:
      - State: Rejected
      - Submitter: Florian Westphal
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220818162123.30198-1-fw@strlen.de/
      - Rejected after the meeting last week
      - There is no issues in fact

12963007: [v3,mptcp-next,1/3] mptcp: propagate fastclose error.
12963008: [v3,mptcp-next,2/3] mptcp: use fastclose on more edge scenarios.
12963009: [v3,mptcp-next,3/3] selftests: mptcp: update and extend
fastclose test-cases:
      - State: Changes requested
      - Series: [v3,mptcp-next,1/3] mptcp: propagate fastclose error.
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=673342&state=*&archive=both
      - Patch 1/3 and 2/3 are OK
      - Paolo will send a v4 → Done

12968860: [net,v3] net: mptcp: fix unreleased socket in accept queue:
      - State: New
      - Submitter: Menglong Dong
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220907111132.31722-1-imagedong@tencent.com/
      - A warning has been reported by the CI but that's a false positive
      - Some annotations are needed so a new version is needed (2
different patches)

12970158: [RFC,mptcp-next,01/10] mptcp: add TCP_FASTOPEN_CONNECT socket
option
12970160: [RFC,mptcp-next,02/10] tcp: export tcp_sendmsg_fastopen
12970161: [RFC,mptcp-next,03/10] mptcp: handle defer connect in
mptcp_sendmsg
12970162: [RFC,mptcp-next,04/10] mptcp: poll allow write call before
actual connect
12970164: [RFC,mptcp-next,05/10] mptcp: delay mptcp data_ack calculation
12970163: [RFC,mptcp-next,06/10] mptcp: allow delayed data_ack calculation
12970165: [RFC,mptcp-next,07/10] mptcp: TFO receive: bypass mapping check
12970166: [RFC,mptcp-next,08/10] mptcp: allow data that can not be
DATA_ACKed
12970167: [RFC,mptcp-next,09/10] mptcp: force data_ready
12970168: [RFC,mptcp-next,10/10] mptcp: test TFO:
      - State: New
      - Series: Implement TCP_FASTOPEN_CONNECT for mptcp
      - Submitter: Benjamin Hesmans
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=675258&state=*&archive=both
      - Split sending/receiving
      - Goal: have patches that are more "upstreamable" + a new approach
for the receiving part.
      - Some parts are missing for TFO support, the sending part but
this has already been implemented by Dmytro
      - Idea is to focus on the sending part for this merge window and
discuss about the different approaches for the receiving part after.



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 297)

  299  several kernel warnings about mptcp [bug]:
      - probably good to ask to reproduce it on top of our export branch
(just in case we fixed something linked to that recently)
      - Matth: TODO → done

  298  Memory accounting for passive MPTCP socket [bug]:
      - we don't have any CG Memory accounting for passive MPTCP sockets


    Bugs (opened, flagged as "bug" and assigned)

  295  mptcpize, rsyncd & connection tear down (hangs)? [bug] @pabeni:
      - see patches above "propagate fastclose error"

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug] @fw-strlen:
      - has been closed: not a bug


    Bugs (opened and flagged as "bug" and not assigned)

  299  several kernel warnings about mptcp [bug]
  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]
  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]


    In Progress (opened, new feature and assigned)

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  294  Clear way for userspace to know if the connection fell back to
TCP [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang:
       - See patches above

   74  BPF: path manager [enhancement] @geliangtang

   59  (MP)TFO support [enhancement] @dmytroshytyi:
       - See patches above


    Assigned Questions (opened, questions and assigned)

None.


    Open questions (opened, questions and not assigned)

  293  fail to create a subflow when a listen socket is closed [question]


    For later (opened and not assigned assigned)

  298  Memory accounting for passive MPTCP socket [bug]
  289  mptcp: audit comments for non inclusive language [enhancement]
  273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement] [packetdrill]
  269  Allow having a mix of v4/v6 subflows for the same socket
[enhancement]
  266  Packetdrill: add MP_FAIL coverage [packetdrill]
  236  Review supported sockopts list [enhancement]
  222  Netlink event API: add SUBFLOW_CREATED event [enhancement]
  215  TCP Urgent pointer and MPTCP [enhancement]
  213  add MPTCP man page [enhancement]
  208  better handing of ssk memory pressure in the TX path [enhancement]
  202  Add sendmsg support for ancillary data [enhancement]
  197  more mibs needed [enhancement]
  180  Get an update when MPTCP fall back to TCP [enhancement]
  177  improve retransmit subflow selection [enhancement]
  169  packetdrill: add coverage for ADD_ADDR and MP_JOIN on a different
port [enhancement] [packetdrill]
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
   61  move msk clone after ctx creation [enhancement]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since last week)

None.



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.1):
https://github.com/multipath-tcp/mptcp_net-next/projects/16
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [390a5331e679] mptcp: fix fwd memory accounting on coalesce
(Paolo Abeni)
        - [2db3e92f8dfc] Documentation: mptcp: fix pm_type formatting
(Matthieu Baerts):
            - These 2 patches have already been sent, pending on netdev
→ Done

    - Fixes for net-next: /

    - Features for net-next:

        - [b0ae1f010f8f] mptcp: add mptcp_for_each_subflow_safe helper
(Matthieu Baerts)
        - [213dc7e36055] selftests: mptcp: move prefix tests of
addr_nr_ns2 together (Geliang Tang)
        - [7edab524064a] mptcp: allow privileged operations from user
namespaces (Thomas Haller)
        - [1fe26877e6e4] mptcp: account memory allocation in
mptcp_nl_cmd_add_addr() to user (Thomas Haller)
        - [012d3e21afa7] mptcp: add do_check_data_fin to replace copied
(Geliang Tang):
            - These 5 patches have already been sent, pending on netdev
→ Done

    - Features for net-next (next): /

    - Features for other trees:

        - [45ee74868873] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [be6ef08f8bfd] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [037e43390ec6] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [4a35a4b9b8f9] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [92c0c10fb477] mptcp: add get_subflow wrappers (Geliang Tang)
        - [b11ee153bbee] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [b0c57572aec7] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [0ec87b8282db] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [20eebfa51824] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [9278aaac1443] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [90f350a89137] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [08ddf88d8cd2] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [fe88061267e5] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [ab065dbf694f] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - Patches related to them are pending in review



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - Nothing related to MPTCP with the export branch from one month ago

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - Looks good, just one test failure with MPTCP but needs more
investigations, maybe something else

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - Patchew didn't apply 2 series recently but it seems back
online now

    - CI (Matth):
        - a few mptcp join tests fail from time to time (invalid address
related one)
        -  probably rely on some sleep and the expected event happens
just after
        - the proper fix would be to wait for an event and not a fixed time
        - See that other people noticed 5 test failures:
https://patchwork.kernel.org/project/mptcp/patch/20220907111132.31722-1-imagedong@tencent.com/

     5 failure(s) has(ve) been detected:

            - 27: invalid address, ADD_ADDR timeout

            - 34: remove invalid addresses

            - 102: userspace pm no echo w/o daemon

            - 103: userspace pm type rejects join

            - 105: userspace pm type prevents mp_prio



mptcp-apps:
    - Olivier Bonaventure (Professor at UCL Belgium) created a new
dedicated Github project for MPTCP Apps: https://github.com/mptcp-apps
    - The goal is to modify some apps to add MPTCP support natively,
without using mptcpize.
    - This summer, some students (and him) started to modify some apps
(OpenSSH, OpenVPN, cURL, etc.) and tried to upstream some of them.
    - Recently, Olivier added a new repo to give some examples:
https://github.com/mptcp-apps/mptcp-hello
Do not hesitate to report issues and ideas ;-)
    - Could be nice to modify Apache and NGinx to support MPTCP



mptcp.dev:
    - anybody for a short one-pager? :)
      - Mat volunteered
    - we can use Github Pages for that:
        - Matth: create a repo and link it to mptcp.dev → Done
    - we can also have subdomains to point to test servers: http, https,
iperf, etc.
    - e.g. http://test.multipath-tcp.org/



Next meeting:
    - Next one on Thursday, the 15th of September.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220915



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
