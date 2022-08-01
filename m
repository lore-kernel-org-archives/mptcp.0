Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E557F
	for <mptcp@lists.linux.dev>; Mon,  1 Aug 2022 16:10:56 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso7677694wma.2
        for <mptcp@lists.linux.dev>; Mon, 01 Aug 2022 09:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=ZwvtxMX/BQVAAYANOcmjwVuVG09P/Yoy7wXq7jIHwM8=;
        b=bPUTlJo/PiSeaRiIp+2q7GTFe13wx55tB2TqROO69VnMFyTCylMZcqBEruaCeyBK+2
         hVzO2iLsqZ4RpobBTt5X+KNe3N8u8mF/hJgiVaAHlYkWTLnvZ3yL+AiWp2feuEbpVKpE
         OYcXL3Nb9uS0MHxCUrMkWjCr3D2q2y1wowjrnqxXv7dABdf/+KBNb9u8v5cr/S9nlZa5
         HXoa9mM9fO2qZGXRizgInPvKXVopwQozev9rX00JZJV90DFXcaIAeOM/ihF77HX+EkKw
         UHieJ4L3l4/0xeS1vLW8t8uVmMYUaQFrZy4bClrHSeP2eMZ9ylXhPPim0y7MfwrCgvnM
         s5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=ZwvtxMX/BQVAAYANOcmjwVuVG09P/Yoy7wXq7jIHwM8=;
        b=uB1DA9oNSK8Kcg5EkLjCupP2KxDy8AtJNHfUvYM5sqy2keo/8X8btj0d4GzwB/iITN
         NHZVPXCcUtQjhbTAG4CzZLI5Jepa/qDYRyyTlyNxIdxYGC5ySrVsUGIO6Ej2VGwjkXGg
         neopyCGjHitKpme/iXGCOJrqHV9y0IbkvrfhGSGuAM378zQtpgj4kdvmFNv3P1esOoyG
         B0jLFR0aYKMm+Pi0VkbNv5UMRJgpaKwmed6Eqb5zFIgpvJ9+qYHgE8RS5OpinKPBjGGE
         88TPTpWtdWsyJ2aszneT+UzCeZzk64p0cKfbjCgnPxKac4sGLvxfjfYJrlyAAH1W3ZpE
         736g==
X-Gm-Message-State: AJIora+gpW0afCNPegjnTRLR6zOy7kTKjMXUBNYr+trVqprIXr1f8ev6
	J7IH578l4vvputd50hBY6qjuDo82PvVGiTRT
X-Google-Smtp-Source: AGRyM1sW2GdOqDPiFrQxJNGUJlRQ9TemciOchDlK+KtFedlTT84nMf+TTS16veZ2QHLgTOsPcffLRw==
X-Received: by 2002:a05:600c:1987:b0:3a3:2db1:d35b with SMTP id t7-20020a05600c198700b003a32db1d35bmr10904997wmq.14.1659370254678;
        Mon, 01 Aug 2022 09:10:54 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id n185-20020a1ca4c2000000b003a37b7e0780sm15158377wme.8.2022.08.01.09.10.54
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 09:10:54 -0700 (PDT)
Message-ID: <e3d022bd-4168-55c8-4e25-01236b955555@tessares.net>
Date: Mon, 1 Aug 2022 18:10:53 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 14th of July 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

On the 14th of July, we had our 202nd meeting with Mat, Ossama (Intel),
Paolo, Davide (Redhat) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau, Matthieu Baerts):

12911557: [net-next,1/6] mptcp: move MPTCPOPT_HMAC_LEN to net/mptcp.h
12911558: [net-next,2/6] selftests: mptcp: tweak simult_flows for debug
kernels
12911559: [net-next,3/6] selftests: mptcp: userspace pm address tests
12911560: [net-next,4/6] selftests: mptcp: userspace pm subflow tests
12911561: [net-next,5/6] selftests: mptcp: avoid Terminated messages in
userspace_pm
12911562: [net-next,6/6] selftests: mptcp: update pm_nl_ctl usage header:
      - Series: mptcp: Self test improvements and a header tweak
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=657961&state=*&archive=both

12911979: [net,1/2] mptcp: fix subflow traversal at disconnect time
12911978: [net,2/2] selftests: mptcp: validate userspace PM tests by
default:
      - Series: mptcp: Disconnect and selftest fixes
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=658074&state=*&archive=both

12913082: [bpf-next,v2] bpf: Fix 'dubious one-bit signed bitfield' warnings:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220711081200.2081262-1-matthieu.baerts@tessares.net/

12914161: [net-next,1/5] mptcp: introduce and use mptcp_pm_send_ack()
12914162: [net-next,2/5] mptcp: address lookup improvements
12914163: [net-next,3/5] mptcp: allow the in kernel PM to set MPC
subflow priority
12914164: [net-next,4/5] mptcp: more accurate MPC endpoint tracking
12914165: [net-next,5/5] selftests: mptcp: add MPC backup tests:
      - Series: mptcp: Support changes to initial subflow priority
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=658666&state=*&archive=both


    our repo (by: Matthieu Baerts):

12915271: [mptcp-next] mptcp: add mptcp_for_each_subflow_safe helper:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220712160236.3668376-1-matthieu.baerts@tessares.net/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/

    our repo (by: Dmytro SHYTYI, Geliang Tang, Jiapeng Chong, Jiri Olsa,
Matthieu Baerts):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
12321111: mptcp: Remove redundant assignment to remaining:
12858306: [RFC,mptcp-next,v3] mptcp: Fast Open Mechanism:

12901431: [mptcp-next,v10,1/5] Squash to "mptcp: add get_subflow wrappers"
12901432: [mptcp-next,v10,2/5] mptcp: redundant subflows push pending
12901433: [mptcp-next,v10,3/5] mptcp: redundant subflows retrans support
12901434: [mptcp-next,v10,4/5] selftests/bpf: Add bpf_red scheduler
12901435: [mptcp-next,v10,5/5] selftests/bpf: Add bpf_red test:
      - State: Changes requested
      - Series: BPF redundant scheduler
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=655328&state=*&archive=both

12913752: [bpf-next] mptcp: Add struct mptcp_sock definition when
CONFIG_MPTCP is disabled:
      - State: Changes requested
      - Submitter: Jiri Olsa
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220711130731.3231188-1-jolsa@kernel.org/



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 288)

  291  [syzkaller] memory leak in inet6_create  [bug] [syzkaller]:
      - from 2020 but reproduced recently:

https://syzkaller.appspot.com/bug?id=9623d77a6280008dc6f9d85261fbdf16090a35e2
      - We should try to reproduce it on our side first
      - there is a syz-repro and a c-repro
      - logs:
https://syzkaller.appspot.com/text?tag=CrashReport&x=16ac8c60080000
      - it looks like the patch shared by the issue reporter might not help:
          - it tries to fix a race but it doesn't look to be tested by
the syzbot
          - probably best to repro the issue with packetdrill
          - it uses CONFIG_PREEMPT=y, maybe not commonly used?
          - Maybe linked to the kernel config
      - Could be nice to reproduce it on a different HW:
          - Mat & Paolo will try with c-repro (or fallback to syz repro)
          - Paolo sees a potential path and will try to repro with
packetdrill

  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]:
      - see the discussions from last week

  289  mptcp: audit comments for non inclusive language [enhancement]:
      - see the discussions from last week


    Bugs (opened, flagged as "bug" and assigned)

  288  [syzkaller] memory leak in __netlink_create [bug] @mjmartineau:
      - it was not reproduced this week

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug] @mjmartineau:
      - Should we assign it to Florian?


    Bugs (opened and flagged as "bug" and not assigned)

  291  [syzkaller] memory leak in inet6_create  [bug] [syzkaller]
  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]:
      - see above

  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]


    In Progress (opened, new feature and assigned)

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang:
       - see patches above

   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

None.

    Open questions (opened, questions and not assigned)

None.


    For later (opened and not assigned assigned)

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
   59  (MP)TFO support [enhancement]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since last week)

  285  PM: in-kernel: support for MPC prio exchange  [enhancement] @pabeni
  284  combine to WAN's via two Wiregate Connections [question] @matttbe



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.20/6.0):
https://github.com/multipath-tcp/mptcp_net-next/projects/15
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees:

/

    - Fixes for -net:

/

    - Fixes for net-next:

        - [c7572cca163f] bpf: Fix 'dubious one-bit signed bitfield'
warnings (Matthieu Baerts):
            - applied in BPF-next

    - Features for net-next:

        - [b2eab62902e7] mptcp: add mptcp_for_each_subflow_safe helper
(Matthieu Baerts):
            - Matth will send it → no, depending on a patch for -net

    - Features for net-next (next):

/

    - Features for other trees:

        - [3991e4842fdc] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [d0bf85f3278e] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [c68e303973d6] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [b1394688c8a4] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [c98a1ade558b] mptcp: add get_subflow wrappers (Geliang Tang)
        - [9c7112198413] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [c61f3f8c2610] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [076f161b2f62] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [50878b77aa4b] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [2afcd887e6d9] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [214842082e33] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [0fffa87c4d5e] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [9db83859adf0] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [41155b09314e] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - we prefer to wait



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - no new syz reports linked to MPTCP

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - happier with simult flows timeout

    - packetdrill (Davide):
        - TFO should still be alive: to be tested. Matth and Benjamin
will have a look.

    - Patchew (Davide):
        - the UI is sill not responding (or very slow)
        - but the importer is still alive, the most important

    - CI (Matth):
        - simult flows:
            - the fix was only for net-next
            - still happening 2 to 3 times a week without the debug
kernel config



MPTCP Maintainer scripts:
    -
https://github.com/multipath-tcp/mptcp_net-next/tree/scripts/utils#readme
    - Mat will check if he had to add anything
    - No need to use topgit directly



LPC:
    - Mat will send a ~v2~ v3 of the proposal
    - notification will be done mid of August but we would like to be
ready before
    - if the talk is rejected, it could still be presented another time
(Netdev?), not lost



Next meeting:
    - Next one on Thursday, not on the 21st of July (Belgium National
day \o/) but on the 28th of July.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220728



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
