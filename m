Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F291F3217
	for <mptcp@lists.linux.dev>; Thu,  8 Dec 2022 17:35:13 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id y16so2485207wrm.2
        for <mptcp@lists.linux.dev>; Thu, 08 Dec 2022 09:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQ3H0leEht8N17d76Llmj4SfQQHApyz9BBDuytr1+Ww=;
        b=OqqnKuR7Xa4wUREYql67OnCNX0wHB3TGAVFZhhwbaFF5SSZiWqDmlBBsgBGI97XTWg
         M4QvlWoBkOzOPCxj2gvDBq/d2oGVChBQOsAbb64oGV5mJ4mZeUS2P7aak204l6ZgjLlB
         rTAToAtJKPeRtBlqxuE8c043FVRM9SWgHf7mHQy8ZqvMXm5b0n96qg126I1KjxTLTPfV
         7Bt2vPy06xC9CpCOjT1MYbt+Emfb4NMI+n4ffaH8aNMmG/h0r7oIRvnYQNdvQFvYTnwv
         TDfTkAJ+/PceREzyHvWVgjkoHNW80v8Wqejjx80+6rxbklwTpISaTZ+XekgV1TUGy8IF
         LQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WQ3H0leEht8N17d76Llmj4SfQQHApyz9BBDuytr1+Ww=;
        b=qnI0HMYpqMjEFoAwR8JCdNPreDC6eLuckJImVcEZzOJSySQlRsza4KlJN2HN8WKq3C
         i25XvvpQm+7qX8LipJL7nns1hBJTiSbmfImnKUmlo+KJJ6RtALrBX5IESIMDnLxrrbZw
         /RxeLaD1Ng4ES4aInjkDsv8XQqWFfPNMebT231TK1VO1oYivCwCCYMpAK0Aq5UlGxxxN
         fbWpxz/g/bMMPAmwjHXNwe/ZCVsPQ5Jd8goN1uGNI7XRKfirnRdfjTr2xFupljkHwB78
         j/Uhn1jy24dHJ/GRjtTa6dfGVuqNrRpZc2MpwdV6EGm3XySdniXAmZjVvo/hk5tECizv
         DgJw==
X-Gm-Message-State: ANoB5pkfQLMfKf/IBM+pHgHkEe6wPWnwBAiNrshlrVPp2Neg7G/5UKem
	riodabadtP6aWdQMlVY1uyAgCFqZoWkbSlSn
X-Google-Smtp-Source: AA0mqf71dZy2VlROqIPLWMTlXMe7d3UpiFHsLdOqO+cn2G2y3u6pue1QXB4GGy96o1ihfYJ0q8CLeA==
X-Received: by 2002:adf:dd03:0:b0:241:f4dc:a728 with SMTP id a3-20020adfdd03000000b00241f4dca728mr2205355wrm.18.1670520911416;
        Thu, 08 Dec 2022 09:35:11 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:a52e:7e0:5ffc:6cea? ([2a02:578:8593:1200:a52e:7e0:5ffc:6cea])
        by smtp.gmail.com with ESMTPSA id n5-20020adff085000000b00236c1f2cecesm27639456wro.81.2022.12.08.09.35.10
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 09:35:11 -0800 (PST)
Message-ID: <4f5cbf37-f2c7-9d48-4a21-1c8af0720409@tessares.net>
Date: Thu, 8 Dec 2022 18:35:10 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 8th of December 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last week, we had our 220th meeting with Mat (Intel), Benjamin and
myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13059923: [net-next,01/11] selftests: mptcp: run mptcp_inq from a clean
netns
13059924: [net-next,02/11] selftests: mptcp: removed defined but unused vars
13059926: [net-next,03/11] selftests: mptcp: uniform 'rndh' variable
13059925: [net-next,04/11] selftests: mptcp: clearly declare global ns vars
13059927: [net-next,05/11] selftests: mptcp: declare var as local
13059928: [net-next,06/11] mptcp: add pm listener events
13059929: [net-next,07/11] selftests: mptcp: enhance userspace pm tests
13059930: [net-next,08/11] selftests: mptcp: make evts global in
userspace_pm
13059931: [net-next,09/11] selftests: mptcp: listener test for userspace PM
13059932: [net-next,10/11] selftests: mptcp: make evts global in mptcp_join
13059933: [net-next,11/11] selftests: mptcp: listener test for in-kernel PM

    our repo (by: Geliang Tang, Matthieu Baerts, Paolo Abeni):

13059640: [mptcp-net,v2,1/3] mptcp: remove MPTCP 'ifdef' in TCP SYN cookies
13059641: [mptcp-net,v2,2/3] mptcp: dedicated request sock for subflow in v6
13059642: [mptcp-net,v2,3/3] mptcp: use proper req destructor for IPv6:
      - Series: mptcp: fix request sock for subflow in v6
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=700384&state=*&archive=both

13062203: [mptcp-next] mptcp: use nlmsg_free instead of kfree_skb:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221202053736.2980-1-geliang.tang@suse.com/

13064358: [mptcp-next] mptcp: return 0 instead of 'err' var:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221205101002.2620762-1-matthieu.baerts@tessares.net/

13065066: [v2,mptcp-net] mptcp: fix deadlock in fastopen error path.:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/f594fa95592f25434e24f0d16033cda1af9ce2cc.1670272505.git.pabeni@redhat.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Jiapeng Chong, Matthieu Baerts, Menglong
Dong, Paolo Abeni):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
12321111: mptcp: Remove redundant assignment to remaining:
      - State: RFC
      - Series: mptcp: Remove redundant assignment to remaining
      - Submitter: Jiapeng Chong
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=500495&state=*&archive=both
      - Status: same as last week

13065794: [mptcp-next,v23,1/5] mptcp: add scheduler wrappers
13065795: [mptcp-next,v23,2/5] mptcp: use get_send wrapper
13065796: [mptcp-next,v23,3/5] mptcp: use get_retrans wrapper
13065797: [mptcp-next,v23,4/5] selftests/bpf: Add bpf_red scheduler
13065798: [mptcp-next,v23,5/5] selftests/bpf: Add bpf_red test:
      - State: New
      - Series: BPF redundant scheduler, part 2
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=702195&state=*&archive=both
13066994: [mptcp-next,v3,1/2] mptcp: update mptcp_push_release
13066995: [mptcp-next,v3,2/2] mptcp: retrans for redundant sends:
      - State: New
      - Series: BPF redundant scheduler, part 3
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=702554&state=*&archive=both
      - Can be "squash" with the other series (part 2)
      - reminder about the complexity: 2 paths to transmit things:
          - when the msk is locked and subflow is picked
          - when the msk locked is not held: optimisation to continue
sending on the same subflow:
              - that's the complex part here if we want to allow
re-injecting the same data on a different subflow

13067480: [mptcp-net] mptcp: fix LSM labeling for passive msk:
      - State: Under review
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/ffee337de5d6e447185b87ade65cc27f0b3576db.1670434580.git.pabeni@redhat.com/
      - Paolo had a discussion on the ML with SELinux maintainers
      - Seems good but because it is about security stuff, we need
SELinux reviewers approval
      - Once reviewed by them, we can handle it and send it to netdev
(with a note in the cover letter because we are changing code outside
mptcp subsytem)

13067481: [mptcp-net] mptcp: fix lockdep false positive:
      - State: Changes requested (but maybe not needed to change it)
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/0818f7332284bd7781956959fbebb90188e140cb.1670435550.git.pabeni@redhat.com/
      - Is there a way to make sure this code is modified if the locking
graph is changing on other sides?

13067832: [mptcp-next,v8,1/4] mptcp: introduce 'sk' to replace
'sock->sk' in mptcp_listen()
13067833: [mptcp-next,v8,2/4] mptcp: add statistics for mptcp socket in use
13067834: [mptcp-next,v8,3/4] selftest: mptcp: exit from
copyfd_io_poll() when receive SIGUSR1
13067835: [mptcp-next,v8,4/4] selftest: mptcp: add test for mptcp socket
in use:
      - State: Changes requested
      - Series: mptcp: add statistics for mptcp socket in use
      - Submitter: Menglong Dong
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=702785&state=*&archive=both
      - Some modifications needed in the token code not to break the
unit tests



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/
    Recently opened (latest from last week: 319):

  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]:
      - not regularly failing

  324  selftests: `mptcp_join`: test 98 `fastclose test` is sometimes
failing [bug] [selftests]:
      - not regularly failing

  323  selftests: `mptcp_join`: test 111 `delete and re-add` is often
failing [bug] [selftests]:
      - Paolo sent a suggestion: right direction but there are some issues

  322  TFO: possible circular locking dependency detected [bug] @pabeni:
      - Linked to "mptcp: fix lockdep false positive" patch

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni:
      - Linked to "mptcp: fix LSM labeling for passive msk" patch


    Bugs (opened, flagged as "bug" and assigned)

  322  TFO: possible circular locking dependency detected [bug] @pabeni:
      - See above ↑

  320  Broken SELinux/LSM labeling with MPTCP and accept(2) [bug] @pabeni:
      - See above ↑


    Bugs (opened and flagged as "bug" and not assigned)

  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]:
      - See above ↑

  324  selftests: `mptcp_join`: test 98 `fastclose test` is sometimes
failing [bug] [selftests]:
      - See above ↑

  323  selftests: `mptcp_join`: test 111 `delete and re-add` is often
failing [bug] [selftests]:
      - See above ↑

  319  kmemleak: 6 new suspected memory leaks in -net [bug]:
      - not reproduced this week
      - we can wait another week and close it later

  318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
cookies [bug] [selftests]:
      - Also got the issue with IPv4, not IPv6 specific bug

  315  Issues with backup flow [bug]:
      - TODO: Matth: ask if there is anything new → Done

  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]


    In Progress (opened, new feature and assigned)

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang:
       - see patches above

   74  BPF: path manager [enhancement] @geliangtang

   59  (MP)TFO support [enhancement] @dmytroshytyi:
       - can be closed now
       - some issues with lockdeps but handled by another issue


    Assigned Questions (opened, questions and assigned)

  307  TCP performance better than MPTCP [question] @matttbe:
      - TODO: ask if there is anything new → somehow linked to #315


    Open questions (opened, questions and not assigned)

/

    For later (opened and not assigned assigned)

  298  CG Memory accounting for passive MPTCP socket [enhancement]
  289  mptcp: audit comments for non inclusive language [enhancement]
  273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement] [packetdrill]

  269  Allow having a mix of v4/v6 subflows for the same socket
[enhancement]:
      - Matth is looking at this, trying to reproduce the situation with
the userspace PM

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

  321  [syzkaller] task hung in lock_sock_nested
  317  TFO: IPv6: the generated cookie is not the expected one [bug]
@matttbe



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.2):
https://github.com/multipath-tcp/mptcp_net-next/projects/17
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [8f68d50ac279] mptcp: netlink: fix some error return code (Wei
Yongjun)
        - [f9f38712b1eb] mptcp: remove MPTCP 'ifdef' in TCP SYN cookies
(Matthieu Baerts)
        - [31e85911931b] mptcp: dedicated request sock for subflow in v6
(Matthieu Baerts)
        - [758918812de8] mptcp: use proper req destructor for IPv6
(Matthieu Baerts):
            - Can be sent but we are just before a new release, might be
better to send the features first
            - But can be sent after, not that urgent, will go in stable
at some points anyway

        - [46874bcecfcc] mptcp: fix deadlock in fastopen error path
(Paolo Abeni):
            - can wait a bit

    - Fixes for net-next: /

    - Features for net-next:

        - [b7477390c08a] mptcp: use nlmsg_free instead of kfree_skb
(Geliang Tang)
        - [c2c686a857ec] mptcp: return 0 instead of 'err' var (Matthieu
Baerts):
            - can be sent to be in 6.2, small cleanup

    - Features for net-next (next): /

    - Features for other trees:

        - [86df102d2272] mptcp: refactor push_pending logic (Geliang Tang)
        - [b7d79873686f] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [446c07ef2262] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [8c379b7afbec] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [c722dec9c58d] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [ef454a1b48bb] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [036449ccab66] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [5c7f8388f3cf] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [4469f01b675c] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [ab217c1f8e7e] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [35e7a949680c] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [63b6978e2d54] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [7dc4a3873fd1] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [5ca91c54036d] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [4fe04f54529f] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [41d8d7710934] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - status: same as last week: we can wait for the patches
being developed



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - nothing new related to MPTCP
        - Paolo fixed the locking issue \o/

    - news about interop with mptcp.org/other stacks? (Christoph):
        - old issue we had with the interop with mptcp.org is probably
fixed by a recent patch from Christoph
        - https://github.com/multipath-tcp/mptcp/issues/427

    - news about Intel's kbuild? (Mat):
        - one issue recently in userspace_pm with the tests recently
added by Geliang
        - to be monitored

    - packetdrill (Davide):
        - https://github.com/multipath-tcp/packetdrill/pull/110 → can
probably be merged → done
        - plenty of new tests for MPTCPv0 and the mptcp.org kernel
thanks to Apple \o/:
            - https://github.com/multipath-tcp/packetdrill_mptcp/pull/1

    - Patchew (Davide):
        - /

    - CI (Matth):
        - some issues have been opened with the tests that have failed
recently
        - split of mptcp_join selftests is working fine: no more global
timeout issues (and faster)
        - Linaro is executing some tests, looks good on v6.0 except for
the userspace pm:
            -
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.0.y/build/v6.0.11-126-gb2f103096329/testrun/13473649/suite/kselftest-net-mptcp/tests/
            - because busybox is used


Go:
    - MPTCP support proposition in net library is going to be "likely
accepted":
        - https://github.com/golang/go/issues/56539#issuecomment-1341583878
        - "likely accepted" means: A week after a proposal moves to
Likely Accept, absent a change in consensus, the proposal review group
moves the proposal to the Accepted column
        - not sure what will happen after: who is going to do the
implementation?



Meetings:
    - eventually change the day of the week / time if people prefer?
    - Tuesday might be OK but we were only 3 today
    - Or one hour later?
    - Or at a different time but not with everybody to have people from
different parts of the world participating
    - TODO: Matth: send a message on the ML about that



Next meeting:
    - Next one on Thursday, the 15th of December.
    - 16:00 UTC (8am PST, 5pm CET, 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20221215



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
