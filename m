Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67BC28FB
	for <mptcp@lists.linux.dev>; Tue,  7 Jun 2022 16:01:14 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso2967194wms.3
        for <mptcp@lists.linux.dev>; Tue, 07 Jun 2022 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=w/68bx2NuhMr6FgiK2eO6mmjqQhbR7zojL91MegAGWg=;
        b=Du8HStGHD93wD4jLfE9Ch9VlwEdT+yBSvbhUtnCBoqtkWHNeQApCVlHgcr6PfYXQip
         9k2b5lzdY2T4Pt9ehbwFNf41v6dnz+i0XuCiqAUeOlc6noUPsJaDU1/QmnOGZCzzn3Az
         IN2Xf8IDr1EsLDSo72AB3IC1WeE5e+nPwi624LbPs+Du6sUWE6zqDvdmaHWI7gkBH04r
         HYhV2ymscOqiYishE2Y5T4UNAXzrdKH0aBHR2wnBKQxQQvQNcp5/15A4peQtWoyQNo4f
         PXGcFDNqEj1BFMwWuoqZN/n83yHJpJOaAI2fHJqtDhRK9EWH7gYkMzzTFgoJ54m8OD1x
         XCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=w/68bx2NuhMr6FgiK2eO6mmjqQhbR7zojL91MegAGWg=;
        b=pBA7Zp9sF3JV2uFfkNsntisIzObufjJbq3feyHlHbrJw+nfsEt3gZcNIcrq+Mh2hly
         ZHWuI3kV6LlXWJYWzhGymkPiTw98jJutpJUcpmfLEgODtrZoHV0Ekgf6lC+6Yx5NVByp
         Pyx9RLj0gR8yva6IZTOjX95hh5G5Hi9GPCxccVrl4bCbcScFhK14oNW4aLHs4FFfBRfG
         HZQjCtYZiKE9j7HtW0UjAp+fHXs5Qhxb39vP1iwDrcDZh6smaYYPDhhMxWoOnVldYQyb
         CWsP85WzZ/utZofNfUNnAg06H1qNpTUEqXUh9kpqUTXPEn2aLPMa6IGwvt/Ids3YEkiH
         03WQ==
X-Gm-Message-State: AOAM533qq0OcEZPdBS+pzaMmEPmOlKdci+K8Fo7bdFuUCjkW6OFp8BTT
	0ZeDMNQbjKwjPhzA/JsFy4JSJ1VZFnMgXg==
X-Google-Smtp-Source: ABdhPJwTCqv0+joB7SV7/M63xyBmI5i7wF8sltjcxstLAFnIC5sdRd/ZD/3DQUlAQlHctxsb/6Ys/Q==
X-Received: by 2002:a05:600c:3511:b0:397:7b1b:8a44 with SMTP id h17-20020a05600c351100b003977b1b8a44mr58247190wmq.46.1654617672341;
        Tue, 07 Jun 2022 09:01:12 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d5045000000b0020d07d90b71sm18051523wrt.66.2022.06.07.09.01.11
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 09:01:11 -0700 (PDT)
Message-ID: <11987faa-c7a4-0ea1-2157-f816d4a8d8e8@tessares.net>
Date: Tue, 7 Jun 2022 18:01:10 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 2nd of June 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 197th meeting with Mat (Intel), Geliang
(SUSE), Geray (Parkyeri) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: /):

/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Dmytro SHYTYI, Geliang Tang, Jiapeng Chong, Matthieu
Baerts):

12282219: RFC: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to
tcp.h/mptcp.h
12282221: RFC: [RESEND,RFC,4/4] tcp: parse tcp options contained in
reset packets
12282223: RFC: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support
12282225: RFC: [RESEND,1/5] tcp: make two mptcp helpers available to tcp
stack
12282227: RFC: [RESEND,5/5] mptcp: send fastclose if userspace closes
socket with unread data
12321111: RFC: mptcp: Remove redundant assignment to remaining:
    - RFC

12858306: Changes Requested: [RFC,mptcp-next,v3] mptcp: Fast Open Mechanism:
    - new version but still early RFC and not easy to review

12867496: Queued: [mptcp-next,v7,01/13] Squash to "mptcp: add struct
mptcp_sched_ops"
12867497: Queued: [mptcp-next,v7,02/13] Squash to "mptcp: add sched in
mptcp_sock"
12867498: Queued: [mptcp-next,v7,03/13] mptcp: add scheduled in
mptcp_subflow_context
12867499: Queued: [mptcp-next,v7,04/13] Squash to "mptcp: add
get_subflow wrappers"
12867500: Queued: [mptcp-next,v7,05/13] Squash to "mptcp: add
bpf_mptcp_sched_ops"
12867501: Queued: [mptcp-next,v7,06/13] bpf: Add bpf_mptcp_sched_kfunc_set
12867502: Queued: [mptcp-next,v7,07/13] selftests/bpf: Add mptcp sched
structs
12867503: Queued: [mptcp-next,v7,08/13] Squash to "selftests/bpf: add
bpf_first scheduler"
12867504: Queued: [mptcp-next,v7,09/13] Squash to "selftests/bpf: add
bpf_first test"
12867505: Queued: [mptcp-next,v7,10/13] selftests/bpf: Add bpf_bkup
scheduler
12867506: Queued: [mptcp-next,v7,11/13] selftests/bpf: Add bpf_bkup test
12867507: Queued: [mptcp-next,v7,12/13] selftests/bpf: Add bpf_rr scheduler
12867508: Queued: [mptcp-next,v7,13/13] selftests/bpf: Add bpf_rr test:
    - v7 looks OK, can be applied


Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 278)

  279  [syzkaller] Warning in icsk_get_port [bug] [syzkaller]:
      - there is a patch, looks like it is fixing the issue but it is in
review → new version requested


    Bugs (opened, flagged as "bug" and assigned)

  264  selftests: diag: failing on the public CI with the new
debug.config [bug] [selftests] @matttbe:
      - some confusions were made: a few tests are failing with a debug
kconfig: diag, join (95) and simult_flows.
      - I reproduced the simult_flows one instead of the diag one...
      - I just opened separated tickets for join (95) and simult_flows.

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug] @mjmartineau


    Bugs (opened and flagged as "bug" and not assigned)

  279  [syzkaller] Warning in icsk_get_port [bug] [syzkaller]
  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]


    In Progress (opened, new feature and assigned)

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang:
       - See patches above ↑

   74  BPF: path manager [enhancement] @geliangtang


    For later (opened and not assigned assigned)

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


    Recently closed (since the last meeting)

  278  selftests: WARNING: possible circular locking dependency
detected: `sk_stream_wait_memory` vs `__mptcp_push_pending` [bug]
  277  selftests: warning in net/core/skbuff.c:775 kfree_skb_reason
[selftests]
  276  <linux/mptcp.h> conflict with <netinet/in.h> in C library [bug]
  275  csum: bad encoding  [bug]
  216  The infinite mapping support: kernel side [enhancement] @geliangtang



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.20/6.0):
https://github.com/multipath-tcp/mptcp_net-next/projects/15
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4

    - ChangeLog has been updated:
https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog=
    - Wiki update? :)



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net: /

    - Fixes for net-next:
        - [e17ac507294a] mptcp: fix conflict with <netinet/in.h> (Ossama
Othman):
            - Can probably be sent to -net
            - (was initially added to "fixes for net-next" because
net-next was about to close

    - Features for net-next:
        - [a7acbff1dd53] mptcp: move MPTCPOPT_HMAC_LEN to net/mptcp.h
(Geliang Tang):
            - net-next is closed

    - Features for net-next (next): /

    - Features for other trees:

        - [d05130d0ac59] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [6cd0f441db1c] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [7e308e1503de] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [031194492680] mptcp: add get_subflow wrappers (Geliang Tang)
        - [a24606f340ea] mptcp: add bpf_mptcp_sched_ops (Geliang Tang)
        - [e57f0a19ad30] selftests/bpf: add bpf_first scheduler (Geliang
Tang)
        - [9ce0423f9f0a] selftests/bpf: add bpf_first test (Geliang Tang):
            - there are pending Squash-to patches
            - anyway, better to wait, probably more Squash-to patches
coming and we clearly need more tests
            - Geliang is still working in that area and there are still
uncertainties



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - Mat opened a ticket (279 Warning in icsk_get_port) not related
to MPTCP
        - Matthieu is re-using a temp server to validate syzkaller but has:
            SYZFAIL: failed to write(kmemleak, "scan")
        - Not clear why, I can do 'echo scan >
/sys/kernel/debug/kmemleak' without error

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - building again on both export and export-net
        - (but no update from our side)
        - seeing the same issues as the ones reported by the public CI

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - Still updating patches
        - Server is quite slow: https://patchew.org/MPTCP/

    - CI (Matth):
        - BPF maintainers modify commits titles, breaking auto sync → fixed
        - IPRoute has been updated



Linux Plumbers:
    - Mat would like to suggest a new talk: what's new in MPTCP (PM +
BPF scheduler)
    - Anybody is planning to go? Maybe Matth and Paolo?
    - Same for Netdev



Next meeting:
    - Next one on Thursday, the 9th of June.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220609



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
