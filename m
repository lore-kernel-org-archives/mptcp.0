Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9636D2CA7
	for <mptcp@lists.linux.dev>; Wed, 10 Aug 2022 16:09:15 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id m4so28568698ejr.3
        for <mptcp@lists.linux.dev>; Wed, 10 Aug 2022 09:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=L5/NXmCo4fQrFULRPwC/u5dJ5rS0N3hecJvgys1aS4M=;
        b=aVYjSyuXY+T7LRL5xge2UZ+vmUyi7Y8MK5nkL6tfH4ox6xzEPIYXykgZYf+M4k7/tG
         aZHhvl5azZ9h7pKRc/5OEW0hx6I4Vo/GP2oowgceKzk4m9+4zSZuorPbX5BccbCvrkjE
         QtJSzyLif7PEkxB9MeF6Y+gy1mcAH+NTvU4/JJsdM+flUZXB1hXfD8pYyyw0yqgMCZwc
         +FmRPWDsyNk/mWIJRQLt4KxShxOviLDBqbS4EGNsd68SxTIfdTzqEKEaUQeNuUXx5Kuj
         lDE8SpSaYh/UMp7IVXwvcYDkghQw4escIwHTbjvyqoIOiVZ1xcPwOQ9OVA6Y4z0ouSfH
         OdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=L5/NXmCo4fQrFULRPwC/u5dJ5rS0N3hecJvgys1aS4M=;
        b=pxoDjaelm68B1ARNMYgL70r20OVjlMrNiJvG+WfNXRPtlZMkM+D7Z+jOW+ba4dCoIR
         bKd8btwyJWRJzN54gEaWNUH9Y6bYpcRxernOJ2AAeo2WVln3poqhSGDc9d+s4Db78k9r
         mcGTfUQQcqQBwoEc+f5jb396h+0kA2wnS5mJ6ctsR8hqfNl2JKo8qo5ccA6o9a7c5pR9
         2QqGM+mYejBq4zZ0WC5UEQTl/AqtNe2PGDkugdv06eCrWqVwrL0mvy3PnuWV3OzWTIdG
         kJrI3u2vp/UDwBBJnCzpNxRZMkSIiUxsbSSwAhzQT4MdemblAVhLu/8uA/dwVYE+GvgQ
         90/A==
X-Gm-Message-State: ACgBeo0BHiG5G0JSus7WXGr+MFoAjtkBRfdb4VXVyA/T40bU9Cv0TTAw
	p3x5WT0gYovJEVsNnia+OmGV38T03XjFxQ==
X-Google-Smtp-Source: AA6agR6Wapvjnw2+q9ZMKhQsjZ74aWo9ta/4aYx8hJMKJXGHrHiSgW/8FNJ5QAvwhT4ZDgXSGXDrkw==
X-Received: by 2002:a17:906:6086:b0:731:3970:48d0 with SMTP id t6-20020a170906608600b00731397048d0mr13191672ejj.16.1660147752919;
        Wed, 10 Aug 2022 09:09:12 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:dc4d:32c5:b574:c349? ([2a02:578:8593:1200:dc4d:32c5:b574:c349])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709066c8400b0072b7d76211dsm2435503ejr.107.2022.08.10.09.09.12
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 09:09:12 -0700 (PDT)
Message-ID: <769d6e22-9a9f-cb20-0599-6f808fd49e8b@tessares.net>
Date: Wed, 10 Aug 2022 18:09:11 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 4th of August 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 204th meeting with Mat, Ossama (Intel),
Giray (Parkyeri), Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12928418: [net] mptcp: Do not return EINPROGRESS when subflow creation
succeeds:
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220725205231.87529-1-mathew.j.martineau@linux.intel.com/


    our repo (by: Florian Westphal, Jiri Olsa, Mat Martineau, Paolo Abeni):

12913752: [bpf-next] mptcp: Add struct mptcp_sock definition when
CONFIG_MPTCP is disabled:
      - Submitter: Jiri Olsa
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220711130731.3231188-1-jolsa@kernel.org/

12919013: [mptcp-net] mptcp: move subflow cleanup in mptcp_destroy_common():
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/bcfa7cfc41ada0c8811794cb3c45cdeb1b34f303.1657883173.git.pabeni@redhat.com/

12919561: [mptcp-net] mptcp: Do not return EINPROGRESS when subflow
creation succeeds:
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220715181207.522021-1-mathew.j.martineau@linux.intel.com/

12928285: [mptcp-net] mptcp: do not queue data on closed subflows:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/937464128633daa18ebc093215ac04487f001b3f.1658769042.git.pabeni@redhat.com/

12932270: [v2] selftests: mptcp: make sendfile selftest work:
      - Submitter: Florian Westphal
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220729095550.3040-1-fw@strlen.de/

12932890: [v3,mptcp-next,1/4] mptcp: move RCVPRUNE event later
12932891: [v3,mptcp-next,2/4] mptcp: more accurate receive buffer updates
12932893: [v3,mptcp-next,3/4] mptcp: move msk input path under full msk
socket lock
12932892: [v3,mptcp-next,4/4] mptcp: use common helper for rmem memory
accounting:
      - Series: mptcp: just another receive path refactor
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=664210&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Jiri Olsa):

12934903: [PATCHv2,bpf-next] mptcp: Add struct mptcp_sock definition
when CONFIG_MPTCP is disabled:
      - Submitter: Jiri Olsa
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220802163324.1873044-1-jolsa@kernel.org/


    our repo (by: Dmytro SHYTYI, Geliang Tang, Jason Wang, Jiapeng
Chong, Matthieu Baerts):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
12321111: mptcp: Remove redundant assignment to remaining:
      - RFC

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

12922458: mptcp: Fix comment typo:
      - State: Changes requested
      - Series: mptcp: Fix comment typo
      - Submitter: Jason Wang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=661054&state=*&archive=both
      - Mat can send a v2

12933347: [RFC,mptcp-next,v4] mptcp: Fast Open Mechanism:
      - State: RFC
      - Submitter: Dmytro SHYTYI
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220801024656.397714-1-dmytro@shytyi.net/
      - Benjamin looked at them and spend some times understanding them
      - Note that there are two ways to use TFO from userspace:
          - either with an explicit 'sendto()'
          - or by using a setsockopt() + connect() → that's what 'curl'
(with mptcpize) is using:
              - this was not working with the v4
              - Benjamin did some changes to have that working: WIP
              - Benjamin is also using the sysctl not to negotiate the
cookie negotiation → just to reduce the complexity at the beginning
       - Still experimental, lot of copy-paste without comments to know
from where that comes (so hard to understand → always good to say:
inspired/copied from with or without a TODO) but we can a direction to take
       - Dmytro didn't share the modification of the selftests (or the
way he is using to test it):
           - @Dmytro, can you share them please?

12932928: [net-next] mptcp: Fix spelling mistakes and cleanup code:
      - Submitter: None
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220730090617.3101386-1-studentxswpy@163.com/
      - It is rejected in fact



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 290)

/


    Bugs (opened, flagged as "bug" and assigned)

  288  [syzkaller] memory leak in __netlink_create [bug] @mjmartineau:
      - Mat will check if it happens again
      - If yes, the idea is to:
          - attach the kernel config → done
          - send a message to netdev ML (+ netlink maintainers?)
          - close the ticket?


    Bugs (opened and flagged as "bug" and not assigned)

  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]
  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]


    In Progress (opened, new feature and assigned)

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
    - Current/Coming merge window (5.20/6.0):
https://github.com/multipath-tcp/mptcp_net-next/projects/15
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4
    - TODO: Matth: new project + changelog → Done



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [c18b0b987d63] mptcp: move subflow cleanup in
mptcp_destroy_common() (Paolo Abeni)
        - [d563b2df7e3a] mptcp: do not queue data on closed subflows
(Paolo Abeni)
        - [413e23686abd] selftests: mptcp: make sendfile selftest work
(Florian Westphal):
            - They can be sent now that net-next is closed (and -net has
been sync with net-next) → Done

    - Fixes for net-next: /


    - Features for net-next: net-next is closed

        - [886bcf255f8c] mptcp: add mptcp_for_each_subflow_safe helper
(Matthieu Baerts):
            - depends on one fix for -net

        - [fa5549adffe7] mptcp: move RCVPRUNE event later (Paolo Abeni)
        - [7d3af4b8e5b4] mptcp: more accurate receive buffer updates
(Paolo Abeni)
        - [34918e18f5bc] mptcp: move msk input path under full msk
socket lock (Paolo Abeni)
        - [1fda9f73ddae] mptcp: use common helper for rmem memory
accounting (Paolo Abeni):
            - can wait (and net-next is closed)

    - Features for net-next (next): /


    - Features for other trees:

        - [632bb25bf1b5] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [de4b322db3f3] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [c1fcd2c7ff95] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [a52d1595d701] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [4a991191dd57] mptcp: add get_subflow wrappers (Geliang Tang)
        - [c0862daaf3e6] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [9b60483a208e] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [d6edc666dcf8] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [8d476b8da0eb] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [f2b4d13e9236] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [052ffdef57e6] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [8e47a72bf0d6] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [24f544f30602] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [6a6e4df8a9e8] selftests/bpf: Add bpf_rr test (Geliang Tang):
            -  we prefer to wait: there are pending patches

        - [7faa417a6fe2] mptcp: Add struct mptcp_sock definition when
CONFIG_MPTCP is disabled (Jiri Olsa):
            - Already sent to bpf-next (and now applied)



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - Nothing new related to MPTCP

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - there were some known issue but working again now
        - some failures have been reported, same as in our CI:
simult_flows.sh
        - this simult_flows.sh is also failing often in "normal" mode
with the public CI:
            - we don't want to hide an issue
            - but if this test is always failing due to the host, maybe
better to increase the tolerance
        - mptcp_join.sh tests seem to also fail more with Paolo's last
patches but to be monitored

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - kunit test is failing because of:
            cat: /sys/kernel/debug/kunit/mptcp-crypto/results: No such
file or directory → Done
        - the docker dev/ci image is now on top of Ubuntu 22.04:
            - safer to clean the .virtme dir because we switch to new
versions of some tools, e.g. gcc



mptcpd:
    - v0.10 now in Debian Unstable and Ubuntu Devel
    - soon in Debian testing → Done
    - 2 issues on the unit tests have been reported:
        - one with interfaces with a patch
        - + another one that Ossama might have seen, he will check



Next meeting:
    - Next one on Thursday, the 11th of August.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220811



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
