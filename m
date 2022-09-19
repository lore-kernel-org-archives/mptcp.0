Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2467C
	for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 15:05:23 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id z6so15502383wrq.1
        for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 08:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=ues67A1Zrwiis7sOPYdKphnH/AvwBurOtlFLt+IiKbs=;
        b=ZssKp8Y2pFL63MLRVZ10jOsalT4HiafoiFDlnnz0IaY44BzgmSUBi3sT1pYwwL8x2h
         uzgoJl3m5kaoDPXNWnY+A7f34f3IMpP/XT8ryajKiUOhS6cdUzzgvLAaU1sci5Thxrft
         JwKWmX9RzhnZtl0Tjk1UZ6Fz1/shshh6HdL1+Nz68aqM6ToLtNLosifHybOh19hOnf1r
         hxS572jPxJ6whZQvTeMozpyPDD9GN6P7rIjEJ9Jn//UNoK6l28P1EJXMttEm1BPF2u80
         b2licRW1qqkv2Yx/IlAiq1pZYvxcwVwHa6MTcgPRSqjqPNn00QsLUVHV3dZEFkbArLAN
         6rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=ues67A1Zrwiis7sOPYdKphnH/AvwBurOtlFLt+IiKbs=;
        b=19rmmc3Cwlkrc3kYFJ2CBQESP8ELlNNQn8PlqNd7WK7fbpArEV7okiXxKCKCPA+X31
         iJ+K++8oQSUGLPhmVhZKnPb7F5byQue28WvWgs2LID9IsenyS6cIp8zANNbxS45pUg+1
         UkAg9CCyh/8+fiPP3l4x0/c261FdwJUhcwplv3ASRGno8derrykfG+VAjii3pjZzjoF0
         lbeM6Y0QDVIu3/zEKhyYN4GF4+gydClG5LyacNOwBZnw4pqOJCPFUpOvHsnsNA5Bt1KP
         DRMy4HXPM41UTGWmb+r2a4+NfQTrV+W0gh2U2QVZ4Ycx8+1AUqcvsKNqizsX9XkUSNkn
         c07Q==
X-Gm-Message-State: ACrzQf0q7NAiI8YhX8/bZxmmluRFAUHI0/SP2uqjOV4ZRwbayfXvVmfP
	s9kRun8g88jsH6DcN4pBwR+STanfrYJmYg==
X-Google-Smtp-Source: AMsMyM6VAfazwnGXE2pMt/eHpRM8gViFpXBZZTgJVEaGNyiScmWG5/kBpuCM1Cra7KdBdscKigAE0A==
X-Received: by 2002:a05:6000:1a8d:b0:228:acb0:e7be with SMTP id f13-20020a0560001a8d00b00228acb0e7bemr11105770wry.680.1663599921422;
        Mon, 19 Sep 2022 08:05:21 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c4f8d00b003b47e75b401sm15122329wmq.37.2022.09.19.08.05.20
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 08:05:20 -0700 (PDT)
Message-ID: <d5c65f9f-3d76-2fbd-d4cb-91517f8a761f@tessares.net>
Date: Mon, 19 Sep 2022 17:05:20 +0200
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
Subject: [Weekly meetings] MoM - 15th of September 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last week, we had our 209th meeting with Ossama (Intel), Dmytro (SFR),
Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


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


    our repo (by: /):

/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Benjamin Hesmans, Dmytro Shytyi, Geliang Tang, Jason
Wang, Jiapeng Chong, Matthieu Baerts, Menglong Dong, Paolo Abeni):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
12321111: mptcp: Remove redundant assignment to remaining:
12922458: mptcp: Fix comment typo:
    - state is the same as last week

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
    - Same as last week, see comments below with Dmytro's series

12971252: [mptcp-next,v4,1/3] mptcp: propagate fastclose error.
12971253: [mptcp-next,v4,2/3] mptcp: use fastclose on more edge scenarios.
12971254: [mptcp-next,v4,3/3] selftests: mptcp: update and extend
fastclose test-cases:
      - State: Queued
      - Series: [mptcp-next,v4,1/3] mptcp: propagate fastclose error.
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=675566&state=*&archive=both
      - Packetdrill tests need to be modified because the behaviour has
changed
      - Best to wait to have these modifications ready not to cause
issues in tests

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
      - Mat looked at them and it looks like there are modifications needed
      - Some new tests are failing

12971679: [mptcp-next] tcp: Add mss zero checks to avoid divide errors:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/48ba286b429284accc457e34c6580efcdec593c4.1662725968.git.geliang.tang@suse.com/
      - Should not be needed: bug elsewhere
      - to be archived

12972757: [net,v5,1/2] net: mptcp: factor out __mptcp_close() without
socket lock
12972758: [net,v5,2/2] net: mptcp: fix unreleased socket in accept queue:
      - State: New
      - Series: net: mptcp: fix unreleased socket in accept queue
      - Submitter: Menglong Dong
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=675976&state=*&archive=both
      - Paolo reviewed the previous patches, the new version should
address these issues.

12976044: [RFC,mptcp-next,v5,01/10] mptcp: Fast Open Mechanism
12976039: [RFC,mptcp-next,v5,02/10] Initiator: MSG_FASTOPEN in sendto
triggers the mptcp_sendsmg_fastopen. It requests a MPTFO cookie.
Suggestion @palbeni(JAN 17): 'split the patch in several small one,
clearly documenting in the individual commit message what each
12976036: [RFC,mptcp-next,v5,03/10] Initiator: mptcp_sendmsg_fastopen.
Usage of lock_sock() / release_sock() leads to hangup'
12976040: [RFC,mptcp-next,v5,04/10] Treat a socket option TCP_FASTOPEN
on Lister side. Suggestion @mmartineau(MAY 22): 'Need to use ssk instead
of sk in these several lines' (1 AUG): 'Since fastopen is only relevant
for the initial subflow (and never with MP_JOIN).
12976043: [RFC,mptcp-next,v5,05/10] This fixes the unexpected value of
subflow->map_seq for the second packet that leads to packet discard and
further retransmit
12976037: [RFC,mptcp-next,v5,06/10] This commit introduces mptfo
variables for msk and options. Also fixes the infinite retransmissions
in the end of second session. Suggestion @palbeni (SEP 1) during the
meting to 'look at data_ack'
12976042: [RFC,mptcp-next,v5,07/10] Add the received skb on the listener
side to msk and set flag mptfo to 1 to treat some parts only in MPTFO
case. This function is called from the functions presented in the next patch
12976038: [RFC,mptcp-next,v5,08/10] This is temporary modification and
will be adressed in the new version of the patch: Remove OPTIONS_TS from
the options. See disscusion in the mailing list (JAN 18) [PATCH v2]
fastopen with @palbeni:
12976045: [RFC,mptcp-next,v5,09/10] These 2 functions are from
protocol.c. Cannot import as not in protocol.h. Should I leave them like
this? Or add prototypes in protocol.h and reuse?
12976041: [RFC,mptcp-next,v5,10/10] MPTFO tests: these are examples that
probably are going to be integrated to the mptcp_connect.* selftests:
      - State: New
      - Submitter: Dmytro Shytyi
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220914113151.9898-8-dmytro@shytyi.net/
      - Dmytro presented the modifications:
          - Slides:
https://drive.google.com/file/d/1uSnjpIdx2LrtaU6eXDIv3lubkiMWi5yz/view
          - for next time:
              - git: limit Git title to ~50 chars + 'mptcp' prefix
              - git: add cover-letter with changelog
              - this series doesn't modify TCP code at all
              - but it is allowed to do modifications as long as it
doesn't modify TCP perfs (especially on the fast path)
              - in most situations, it is best to share code to ease the
maintenance and avoid the same issues we have with mptcp.org where we
have to check what has changed on TCP side and do the same on TCP side.
      - next steps, idea: focus on the sending part + selftests
      - Dmytro will send a new version fixing the 2 git issues



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 299)

  302  understanding ip-mptcp command behaviour [question]:
      - Some confusions with what mptcpd is doing
      - Can be closed? (Matth TODO) → asked
      - Matth: TODO: open ticket NM 1.40.0 vs mptcpd → done
      - Matth: TODO: open ticket to (maybe) change the default behaviour
about adding IPv6 LL addresses as endpoints → done
      - Matth: TODO: open a ticket about IP no longer assigned to any
interfaces but still present when doing "ip mptcp endpoint" → done

  300  Scheduler, pathmanager, congestion control [question]:
      - Diff with mptcp.org
      - Can be closed? (TODO Matth) → asked


    Bugs (opened, flagged as "bug" and assigned)

  295  mptcpize, rsyncd & connection tear down (hangs)? [bug] @pabeni:
      - Patches are ready but packetdrill tests need to be adapted


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
       - TODO Matth: add summary from LPC → done

   74  BPF: path manager [enhancement] @geliangtang

   59  (MP)TFO support [enhancement] @dmytroshytyi:
       - See patches above


    Assigned Questions (opened, questions and assigned)

None.


    Open questions (opened, questions and not assigned)

  302  understanding ip-mptcp command behaviour [question]
  300  Scheduler, pathmanager, congestion control [question]
  293  fail to create a subflow when a listen socket is closed [question]:
      - TODO Matth: close? → asked


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

  301  how to get mptcp subflow info  [question]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug] @fw-strlen



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.1):
https://github.com/multipath-tcp/mptcp_net-next/projects/16
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net: /

    - Fixes for net-next: /

    - Features for net-next:

        - [058fcc6acef2] mptcp: add mptcp_for_each_subflow_safe helper
(Matthieu Baerts)
        - [3f3473da56ca] selftests: mptcp: move prefix tests of
addr_nr_ns2 together (Geliang Tang)
        - [bb9823ec781b] mptcp: allow privileged operations from user
namespaces (Thomas Haller)
        - [89c970df702e] mptcp: account memory allocation in
mptcp_nl_cmd_add_addr() to user (Thomas Haller)
        - [08f7c9f12f58] mptcp: add do_check_data_fin to replace copied
(Geliang Tang):
            - Sent and applied today

    - Features for net-next (next): /

    - Features for other trees:

        - [71da09aee188] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [5977d69aee08] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [a955dc103238] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [c561efd91803] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [19caf9b9c4fd] mptcp: add get_subflow wrappers (Geliang Tang)
        - [9287af5907fc] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [bd3520e18a3d] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [ddd346eebacd] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [47c4898ca533] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [9c5e57d3739b] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [022fca209cdf] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [4dd9c1f24530] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [94f28193864c] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [a876bbd8b289] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - Same as last week: can wait



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - /

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - It looks like the patches are not applied if there is no
cover-letter

    - CI (Matth):
        - mptcp_join seems quite unstable



Next meeting:
    - Next one on Thursday, the 22nd of September.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220922



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
