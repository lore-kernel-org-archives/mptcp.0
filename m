Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C8D468E
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 16:25:31 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id sd10so21869057ejc.2
        for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 09:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=iZiTloXaPHZrCamRjYJGpENtkmtAdUdk8/iqZeUIQ1g=;
        b=xxqN5reyBzDoimRteC9M50SAYGRI+qfq3wxxSDAUS+tWj3sLKFtoZs82wxd0epTSzM
         SU2l12kinD60/r+/U3lV4js3mLIfQRUNvIQBBdgANl+yCCMuqhS4US6nBgtdf+Al2/gc
         88jGV/b2Boq7u8ppFAKjdMZWY2V3HpbNjX9kRX30CT5MT+hFojEeYHuJuExNyAjvML3G
         frXiNC5A2sfoXEFhxlJp7GwdSI1jZnptIoloOtf7wZKFsw4Y+HK9AbylBMImQwoOqzEC
         cEHp0nCmyGeVLrXp0O7Lsua8Rk+mlxG6pYLj0+ERY9LkTZk9PrZqBq1Kqk0pLeer+uM8
         Z/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=iZiTloXaPHZrCamRjYJGpENtkmtAdUdk8/iqZeUIQ1g=;
        b=0mG2RH8nzB2XqreWSy5Tgv2bd6QKc/JE6Gl3qw5JXjiAtKBgdPmfiNbNrNEkyVp6iW
         JS5uFjDBo7kEaf8G23ixEXVHo27/5fFZZHr/wNHtgJqhAT7wEWFhNtLHpxv7xXcw3ooR
         cHlKVN/8dLfb8vbNydvdey4JSFnYRE77ka5SSWFmC7Sag/5gHkRen+bjy/HQfqPrSMFZ
         1Hol2YVJZToK6nxRl+X4D+lO0ap15IvvG1PK6Plt+R3rlnQdLMc0P4/KM6Arrl0/Sc0U
         z2QhgvUiOSGiRCUJc5yfbP8YgAfQr5RLpLZspExSGDxBrLeRnZGszaLBZ6oCp2z75QF4
         51Hw==
X-Gm-Message-State: ACrzQf0goGFxy08ovHkc7CzdJh5OazDhtMU6ygs5PrfjGqhw1UKuKKF7
	hH9omJvy/cmYaC6Ts95UTRMD9Tzx/D7W1UC/RNk=
X-Google-Smtp-Source: AMsMyM5rKGJmR4rw3rvYfcwe+riPMGLuBcEI8wT2v0cnJq8/I9ZfqErsYJKYmSMYwJolZg02kBVqSg==
X-Received: by 2002:a17:907:c25:b0:782:9dc8:eef1 with SMTP id ga37-20020a1709070c2500b007829dc8eef1mr19938687ejc.667.1664295924972;
        Tue, 27 Sep 2022 09:25:24 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:2223:8b8e:70fe:8d48? ([2a02:578:8593:1200:2223:8b8e:70fe:8d48])
        by smtp.gmail.com with ESMTPSA id rn13-20020a170906d92d00b0077a7c01f263sm1002111ejb.88.2022.09.27.09.25.24
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 09:25:24 -0700 (PDT)
Message-ID: <b5cf28d2-e207-d1f6-4857-a477d7c0c317@tessares.net>
Date: Tue, 27 Sep 2022 18:25:23 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 22nd of September 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last week, we had our 210th meeting with Mat, Ossama (Intel), Paolo,
(Redhat), Dmytro (SFR), Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Menglong Dong, Paolo Abeni):

12971252: [mptcp-next,v4,1/3] mptcp: propagate fastclose error.
12971253: [mptcp-next,v4,2/3] mptcp: use fastclose on more edge scenarios.
12971254: [mptcp-next,v4,3/3] selftests: mptcp: update and extend
fastclose test-cases:
      - Series: [mptcp-next,v4,1/3] mptcp: propagate fastclose error.
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=675566&state=*&archive=both
      - Packetdrill tests had to be modified:
          - gtests/net/mptcp/syscalls/connect_close_full.pkt: this one
looked strange: we have the data fin exchange and then we have FastClose
          - probably expected but maybe avoidable
          - Matth: open a ticket about that → Done

12972757: [net,v5,1/2] net: mptcp: factor out __mptcp_close() without
socket lock
12972758: [net,v5,2/2] net: mptcp: fix unreleased socket in accept queue:
      - Series: net: mptcp: fix unreleased socket in accept queue
      - Submitter: Menglong Dong
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=675976&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Benjamin Hesmans, Dmytro Shytyi, Geliang Tang, Jason
Wang, Jiapeng Chong, Matthieu Baerts, Menglong Dong):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
12321111: mptcp: Remove redundant assignment to remaining:
12922458: mptcp: Fix comment typo:
    - Old patches

12971327: [mptcp-next,v11,1/5] Squash to "mptcp: add get_subflow wrappers"
12971328: [mptcp-next,v11,2/5] mptcp: redundant subflows push pending
12971329: [mptcp-next,v11,3/5] mptcp: redundant subflows retrans support
12971330: [mptcp-next,v11,4/5] selftests/bpf: Add bpf_red scheduler
12971331: [mptcp-next,v11,5/5] selftests/bpf: Add bpf_red test:
      - State: Changes requested
      - Series: BPF redundant scheduler
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=675582&state=*&archive=both
      - Status: same as last week

12970164: [RFC,mptcp-next,05/10] mptcp: delay mptcp data_ack calculation
12970163: [RFC,mptcp-next,06/10] mptcp: allow delayed data_ack calculation
12970165: [RFC,mptcp-next,07/10] mptcp: TFO receive: bypass mapping check
12970166: [RFC,mptcp-next,08/10] mptcp: allow data that can not be
DATA_ACKed
12970167: [RFC,mptcp-next,09/10] mptcp: force data_ready
12970168: [RFC,mptcp-next,10/10] mptcp: test TFO:
      - State: RFC
      - Series: TFO: receiver part only
      - Submitter: Benjamin Hesmans
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=679462&state=*&archive=both

12983634: [mptcp-next,v2,1/2] mptcp: introduce 'sk' to replace
'sock->sk' in mptcp_listen()
12983635: [mptcp-next,v2,2/2] mptcp: add statistics for mptcp socket in use:
      - State: Changes requested
      - Series: mptcp: add statistics for mptcp socket in use
      - Submitter: Menglong Dong
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=679017&state=*&archive=both
      - what's left to do: fix a typo, add test(s) in diag.sh

12983703: [RFC,mptcp-next,v9,1/6] mptcp: add mptcp_stream_connect to
protocol.h
12983707: [RFC,mptcp-next,v9,2/6] mptcp: add mptcp_setsockopt_fastopen
12983701: [RFC,mptcp-next,v9,3/6] mptcp: reuse tcp_sendmsg_fastopen()
12983705: [RFC,mptcp-next,v9,4/6] mptcp: fix retrans., add mptfo vars to msk
12983706: [RFC,mptcp-next,v9,5/6] mptcp: add subflow_v(4,6)_send_synack()
12983704: [RFC,mptcp-next,v9,6/6] selftests: mptfo initiator/listener:
      - State: Changes requested (Changes are implemented, in comments
to v9)
      - Series: mptcp: Fast Open Mechanism
      - Submitter: Dmytro Shytyi
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=679033&state=*&archive=both
      - re-order patches to have first the sending part, then the
receiver part (Dmytro: v9 already with reordered commits: 1/6, 2/6 ,3/6
- initiator; 4/6, 5/6 - listener.)

12985213: [mptcp-next,v2,1/4] mptcp: add TCP_FASTOPEN_CONNECT socket option
12985215: [mptcp-next,v2,2/4] tcp: export tcp_sendmsg_fastopen
12985214: [mptcp-next,v2,3/4] mptcp: handle defer connect in mptcp_sendmsg
12985216: [mptcp-next,v2,4/4] mptcp: poll allow write call before actual
connect:
      - State: New
      - Series: mptcp: add support for TFO, sender side only
      - Submitter: Benjamin Hesmans
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=679462&state=*&archive=both
      - This series focuses on the sender part, only TCP_FASTOPEN_CONNECT
      - Some disagreements about the ownership of the patches: this
series is only about TCP_FASTOPEN_CONNECT, the author should not be the
one who started to look at the subject but we should see the code
previously shared on the ML
      - Reminder: we are collaborating here, the goal is to have the
best patches and patches can be rejected if they don't go to the right
direction or doesn't fit with upstream vision.
      - Patch 3/4 is specific to TCP_FASTOPEN_CONNECT and linked to
"original" the idea of directly using tcp_sendmsg_fastopen() but OK to
change author if it allows to unblock the situation



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 302):

/

    Bugs (opened, flagged as "bug" and assigned)

None.


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
       - see patches above

   74  BPF: path manager [enhancement] @geliangtang

   59  (MP)TFO support [enhancement] @dmytroshytyi:
       - see patches above


    Assigned Questions (opened, questions and assigned)

None.


    Open questions (opened, questions and not assigned)

  300  Scheduler, pathmanager, congestion control [question]:
      - can be closed next week


    For later (opened and not assigned assigned)

  298  CG Memory accounting for passive MPTCP socket [enhancement]
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

  302  understanding ip-mptcp command behaviour [question]
  295  mptcpize, rsyncd & connection tear down (hangs)? [bug] @pabeni
  293  fail to create a subflow when a listen socket is closed [question]



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.1):
https://github.com/multipath-tcp/mptcp_net-next/projects/16
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - Fixes for other trees: /

    - Fixes for -net:

        - [6e827151a607] mptcp: factor out __mptcp_close() without
socket lock (Menglong Dong)
        - [62b5536f77f6] mptcp: fix unreleased socket in accept queue
(Menglong Dong):
            - can wait a bit more and can be sent beginning of next week

    - Fixes for net-next: /

    - Features for net-next:

        - [ef4a93571133] mptcp: propagate fastclose error (Paolo Abeni)
        - [885cab8b5203] mptcp: use fastclose on more edge scenarios
(Paolo Abeni)
        - [13c82c8b0d9f] selftests: mptcp: update and extend fastclose
test-cases (Paolo Abeni):
            - can wait a bit, Paolo would like to have a look at the
modification on packetdrill side → done

    - Features for net-next (next): /

    - Features for other trees:

        - [a6f9b32c756e] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [bdb7fb1c9857] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [e022ffaedd82] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [5e35ae5e9087] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [1644b4ff42ec] mptcp: add get_subflow wrappers (Geliang Tang)
        - [3515cebd6857] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [b024d176cd5d] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [5b78d813e8e8] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [0ef80f663075] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [d09ef514ef5c] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [d9545056bd5a] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [32372f9eeb61] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [225dc82fee90] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [0af8719e2a94] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - same as last week: there are still some patches in review



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - nothing new related to MPTCP

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - mptcp_join.sh failure but before merging Paolo's changes, to
be monitored.

    - packetdrill (Davide):
        - Modifications from Christoph (ADD_ADDR) and Matth (TFO)

    - Patchew (Davide):
        - Patchew is up again, rebased on top of the latest code,
relying on lore.kernel.org (public mailbox)
        - Feel free to report issues if any
        - https://patchew.org/MPTCP/ → quicker
        - So no hurry to switch to something else, it is working well

    - CI (Matth):
        - Monitor the failing tests



Next meeting:
    - Next one on Thursday, the 29th of September.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220929



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
