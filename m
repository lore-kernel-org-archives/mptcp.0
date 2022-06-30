Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE13EBB
	for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 09:51:51 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id fd6so25775767edb.5
        for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 02:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=i4+MQcfemYL8kwMy13wyaoBrkF/Tlw43VeoQCs6zINw=;
        b=imVhgO49+msEp4ZUkJdzTSZqmUuY9Y2IhYNIhrLyuojON4rCjp14VF1+HVDjYd22RS
         kZaTYAxpO/7v0PtQZoOQUypTUSmETfWjgHHOqPafjxjEBlpnz7qeIWjisIArU1q4vuQd
         AHqwE+LKYJYkSUV+EFu7vq1dffTHfqCWs1Uh7GM9NXpzHJUAHMa/k6uGIJUokTJKZHwg
         5U8IpHiMfzD1AxlqD6TpJj7GcW73+a4BUo2V56KOyHx1tN54gfKu6L+vneNnHbNADsFq
         QBUljvj/zdO5hZ5oFNBsxIW5tzK+4bFwld/Kd0YOAze2X7zu0bf2Ejkko3hxD2RQDQi9
         ZKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=i4+MQcfemYL8kwMy13wyaoBrkF/Tlw43VeoQCs6zINw=;
        b=A/OTFrWw74OILLvJX9nLiVAqzcraNvEKSSN/WlfqPpJRXCiP6wE0+Q9xOXp+KNfNY2
         H5V4d+28o8vpTqzv/GUNAv5VgVCY69vuao2Ard8D4fyY9haI+mWCk4qF0L0sc2QegNrO
         L9HWi02p1R+LZf38KkJWb86Ic/2KaQW7yauDpCrFYgo/rN2YTlZhpJz/ymnB9iTubwlD
         wRcqV+idQr/Pk/YUOOAZehHswwWFvJcH39Kfw13jaFIBrCVNp3bSW33fNjnn8VuxmNMl
         4WOcACuVtFiv2V1LFxqyOeX0hn+GthpKd9sXr7bMcqq9WFGKw4AY+xsTt2VMtgGkwio8
         xxxA==
X-Gm-Message-State: AJIora81o1ohQMsTXyB/te+guAhySnu08gbzD7Y0D1+EISyZwTs68cY6
	oWvBlNMIgxs3SA+SHndtfewhkubRvzVchA==
X-Google-Smtp-Source: AGRyM1uU9eukSaqz9JEJrDK3iwgORd1D7NvZa0I2s3eMp4i/201KnUxp07CnEgEdh6h6VTl5q0bY7w==
X-Received: by 2002:a05:6402:3808:b0:435:5a6c:9dd9 with SMTP id es8-20020a056402380800b004355a6c9dd9mr10454087edb.368.1656582708924;
        Thu, 30 Jun 2022 02:51:48 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6947:dee2:2822:3dc2? ([2a02:578:8593:1200:6947:dee2:2822:3dc2])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709061f1000b0071d3b6ed4eesm8877134ejj.160.2022.06.30.02.51.48
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 02:51:48 -0700 (PDT)
Message-ID: <987093b3-d243-92cd-623f-774e32e9453d@tessares.net>
Date: Thu, 30 Jun 2022 11:51:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 23rd of June 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 199th meeting with Mat, Ossama (Intel), Paolo
(Redhat), Geliang (SUSE), Geray (Parkyeri) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Mat Martineau, Paolo Abeni):

12890418  [mptcp-net] Squash-to: "selftests: mptcp: more stable diag tests"

12889968  [mptcp-next] selftests: mptcp: Initialize variables to quiet
gcc 12 w...:
    - should probably go to -net

12889576  [v5,mptcp-net,6/6] mptcp: fix race on unaccepted mptcp sockets
12889575  [v5,mptcp-net,5/6] mptcp: consistent map handling on failure
12889574  [v5,mptcp-net,4/6] mptcp: fix shutdown vs fallback race
12889573  [v5,mptcp-net,3/6] Squash-to: "mptcp: invoke MP_FAIL response
when ne...
12889572  [v5,mptcp-net,2/6] mptcp: introduce MAPPING_BAD_CSUM
12889571  [v5,mptcp-net,1/6] mptcp: fix error mibs accounting

12889519  [v4,mptcp-next,4/4] net: remove SK_RECLAIM_THRESHOLD and
SK_RECLAIM_C...
12889518  [v4,mptcp-next,3/4] mptcp: refine memory scheduling
12889517  [v4,mptcp-next,2/4] mptcp: drop SK_RECLAIM_* macros
12889516  [v4,mptcp-next,1/4] mptcp: never fetch fwd memory from the subflow

12888641  [mptcp-next] Squash to "selftests: mptcp: userspace pm subflow
tests"
12888640  [mptcp-next] Squash to "selftests: mptcp: userspace pm address
tests"
12883908  [mptcp-next] selftests: mptcp: tweak simult_flows for debug
kernels.
12883411  [mptcp-net] selftests: mptcp: more stable diag tests

12883327  [mptcp-next,v3,5/5] selftests: mptcp: update pm_nl_ctl usage
header
12883326  [mptcp-next,v3,4/5] selftests: mptcp: avoid Terminated
messages in us...
12883325  [mptcp-next,v3,3/5] selftests: mptcp: userspace pm subflow tests
12883324  [mptcp-next,v3,2/5] selftests: mptcp: userspace pm address tests
12883319  [mptcp-next,v3,1/5] mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy

12874836  [mptcp-next] Squash to "selftests/bpf: Add bpf_first test"



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12874585  [net-next,2/2] mptcp: move MPTCPOPT_HMAC_LEN to net/mptcp.h
12874584  [net-next,1/2] mptcp: fix conflict with <netinet/in.h>:
    - need to be re-sent

    our repo (by: Dan Carpenter, Dmytro SHYTYI, Florian Westphal,
Geliang Tang, Jiang Biao, Jiapeng Chong, Kishen Maloor, Mat Martineau,
Matthieu Baerts, Paolo Abeni, Yonglong Li):

12279739: RFC: [RFC,3/4] mptcp: move the whole rx path under msk socket
lock protection
12279741: RFC: [RFC,4/4] mptcp: cleanup mem accounting.
12282219: RFC: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to
tcp.h/mptcp.h
12282221: RFC: [RESEND,RFC,4/4] tcp: parse tcp options contained in
reset packets
12282223: RFC: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support
12282225: RFC: [RESEND,1/5] tcp: make two mptcp helpers available to tcp
stack
12282227: RFC: [RESEND,5/5] mptcp: send fastclose if userspace closes
socket with unread data
12858306: Changes Requested: [RFC,mptcp-next,v3] mptcp: Fast Open Mechanism:
    - WIP

12891609: Queued: [mptcp-net,v2,1/2] mptcp: netlink: issue MP_PRIO
signals from userspace PMs
12891610: Queued: [mptcp-net,v2,2/2] selftests: mptcp: userspace PM
support for MP_PRIO signals:
    - v2 is adding one sleep
    - Can be applied (post-meeting update: change required to netlink
attributes so individual subflows can have priority modified)
    - For -net because it is an important feature missing from Netlink
series
    - Not a new command but modifying the behaviour of the CMD one to
allow MP_PRIO signals for established subflow:
        - @Paolo: is it OK for -net -> let me see the patches first!
    - Not a new command for 'ip mptcp' but more for a userspace PM like
mptcpd
    - not related to that:
        - Geliang reported that the "dump addresses" command is broken →
best to report a new issue.
        - *@Geliang* can you do that please?

12892830: New: [mptcp-next,v9,1/6] Squash to "mptcp: add get_subflow
wrappers"
12892831: New: [mptcp-next,v9,2/6] mptcp: accept right edge of mapping
validating
12892832: New: [mptcp-next,v9,3/6] mptcp: redundant subflows push pending
12892833: New: [mptcp-next,v9,4/6] mptcp: redundant subflows retrans support
12892834: New: [mptcp-next,v9,5/6] selftests/bpf: Add bpf_red scheduler
12892835: New: [mptcp-next,v9,6/6] selftests/bpf: Add bpf_red test:
    - series: BPF redundant scheduler
    - v7 was in good progress, Mat will check v9
    - The CI reported some issues with it



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 282)

  287  selftests: `mptcp_join.sh`: `userspace pm add & remove address`:
WARNING `sock_owned_by_me()` in `mptcp_sched_get_send()` [bug] [selftests]:
      - WARNING triggered by a new test
      - Stacktrace has been added

  286  Make MPTCP_PM_CMD_SET_FLAGS usable with the userspace PM [bug]
@kmaloor:
      - See patches above

  285  Excluding the initial connecting interface? [question]:
      - is in fact a bug → we cannot change the priority (backup) for ID
0 (initial subflow)
      - it only looks at the list of extra subflows but not the initial one
      - for the first subflow, we cannot set the backup flag directly:
          - not handled by the protocol in MPCapable
          - but the PM should probably send it after the establishment
of the connection:
              - when fully established
          - the first subflow is a bit particular (ID 0): it is not
linked to an endpoint from the in-kernel PM
          - there is currently no way in the API to set the backup flag
for ID 0:
              - the in-kernel PM could have a default behaviour for the ID0
      - would be good to modify the ticket to make it clearer on what
needs to be done:
          - *@Paolo* will try to do that

  284  combine to WAN's via two Wiregate Connections [question]:
      - is MPTCP used?
      - if not: -> issues/178

  283  Cleanup following TCP changes to forward allocation @pabeni:
      - Already closed, see patches above


    Bugs (opened, flagged as "bug" and assigned)

  286  Make MPTCP_PM_CMD_SET_FLAGS usable with the userspace PM [bug]
@kmaloor:
      - See patches above

  279  [syzkaller] Warning in icsk_get_port [bug] [syzkaller] @mjmartineau:
      - the patches introducing the issue have been reverted
      - Mat just closed this ticket

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug] @mjmartineau


    Bugs (opened and flagged as "bug" and not assigned)

  287  selftests: `mptcp_join.sh`: `userspace pm add & remove address`:
WARNING `sock_owned_by_me()` in `mptcp_sched_get_send()` [bug] [selftests]:
      - just been opened

  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]


    In Progress (opened, new feature and assigned)

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang:
       - See patches above

   74  BPF: path manager [enhancement] @geliangtang


    For later (opened and not assigned assigned)

  285  Excluding the initial connecting interface? [question]
  284  combine to WAN's via two Wiregate Connections [question]
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
   59  (MP)TFO support [enhancement]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since last week)

  283  Cleanup following TCP changes to forward allocation @pabeni
  282  selftests: `simult_flows`: failing with debug kernel: transfer
slower than expected [bug] [selftests] @pabeni
  280  support of ndiffport [question]
  264  selftests: diag: failing on the public CI with the new
debug.config [bug] [selftests] @pabeni



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.20/6.0):
https://github.com/multipath-tcp/mptcp_net-next/projects/15
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees: /


    - Fixes for -net:
        - [9187f59fcf76] mptcp: fix error mibs accounting (Paolo Abeni)
        - [9b5c48a2c155] mptcp: introduce MAPPING_BAD_CSUM (Paolo Abeni)
        - [c81afcd7c9b3] mptcp: invoke MP_FAIL response when needed
(Geliang Tang)
        - [b8a9af086a90] mptcp: fix shutdown vs fallback race (Paolo Abeni)
        - [5fbf8dcb1487] mptcp: consistent map handling on failure
(Paolo Abeni)
        - [55f4ef78229d] mptcp: fix race on unaccepted mptcp sockets
(Paolo Abeni)
        - [018d2f16d544] selftests: mptcp: more stable diag tests (Paolo
Abeni):
            - Applied recently, probably best to wait a bit (next week)


    - Fixes for net-next:
        - [c20568e1d4f8] mptcp: fix conflict with <netinet/in.h> (Ossama
Othman):
            - this is in fact for -net


    - Features for net-next:
        - [3bdd1b9e0319] mptcp: move MPTCPOPT_HMAC_LEN to net/mptcp.h
(Geliang Tang):
            - has to be re-sent


        - [68003ca13a6f] selftests: mptcp: tweak simult_flows for debug
kernels (Paolo Abeni):
            - it looks like we also had the same issue with the public
CI without a debug kernel
            - probably best to wait and see how often we have this issue
on the public ci
            - workaround is to modify the script when the CI is doing
the tests

        - [f1eb3f2cb4d2] mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy
(Geliang Tang)
        - [f3c5dde10031] selftests: mptcp: userspace pm address tests
(Geliang Tang)
        - [92378ff55152] selftests: mptcp: userspace pm subflow tests
(Geliang Tang)
        - [1908a4ccaa2c] selftests: mptcp: avoid Terminated messages in
userspace_pm (Geliang Tang)
        - [bac5548c7c47] selftests: mptcp: update pm_nl_ctl usage header
(Geliang Tang):
            - are OK to be sent, applied a few days ago

        - [efdd161d452f] mptcp: never fetch fwd memory from the subflow
(Paolo Abeni)
        - [31b85342665d] mptcp: drop SK_RECLAIM_* macros (Paolo Abeni)
        - [b846ca72c717] mptcp: refine memory scheduling (Paolo Abeni)
        - [78f0912127b3] net: remove SK_RECLAIM_THRESHOLD and
SK_RECLAIM_CHUNK (Paolo Abeni):
            - probably best to wait a bit
            - also upstream, a regression has been reported in sctp in
the patches from Eric linked to SK_RECLAIM_*
            - best to wait to get a clearer view about this regression


        - [b2ccb6a27761] selftests: mptcp: Initialize variables to quiet
gcc 12 warnings (Mat Martineau):
            - can be sent to '-net' with a 'Fixes' tag (even if it is
introduced by a new compiler)


    - Features for net-next (next): /


    - Features for other trees:
        - [4e3ab75acdac] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [6654b1085907] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [db3be898e969] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [ee54afef4ecf] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [f31fa75643a6] mptcp: add get_subflow wrappers (Geliang Tang)
        - [b90fc0c86616] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [dcc7d193254b] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [87fade60a74c] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [e5b8af95d247] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [bcb7f244fb28] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [367da0a71d20] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [10619a9693fb] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [fe81a842b0ea] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [1e7bb19e7659] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - some patches are in review and related to that, best to wait



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - nothing related to MPTCP

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - running and mostly succeeding.
        - failure are linked to the ones seen by the public CI

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - /



Applying patches:
    - now with b4 with signature checks



Linux Plumber:
    - we might have Mat and Paolo but to be confirmed
    -
https://lpc.events/blog/2022/index.php/2022/06/22/registration-still-sold-out-but-there-is-now-a-waitlist/
    - Matth might go if possible
    - Mat would like to talk about MPTCP extensions. Matth might help if
he can go




Next meeting:
    - Next one on Thursday, the 30th of June.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220630



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
