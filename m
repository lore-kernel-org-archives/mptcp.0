Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEEE468F
	for <mptcp@lists.linux.dev>; Fri,  7 Oct 2022 15:14:09 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id n12so7730016wrp.10
        for <mptcp@lists.linux.dev>; Fri, 07 Oct 2022 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQlely7nhO5OX9LPo+1SzConVy+LPaZVNMGknXRdf70=;
        b=UPS67Ve6AguPEFsWdDZINJFj9VTUAf/dYluCcknAyKD05DSWYna2c0lVzr9B1ADTuE
         WfAZy8luPHFJoQDBKi3QuvB9cY2AbNFPOuTQ3Xi4VWiD073vhSeUGIsJGtQmHHBgTLMD
         XtH98FhRbFhXwW9wTd943taahDLw/xOwU9CISlLQVvdQcoJwaF1wkKhyNXf9d842zkyh
         JmNrYA8fxHlT53HPI6T3/oMsCKg6OqtJY8aigtySomMLWWMgLxb8MV+6AUO7iuE8aH0E
         vxdi1kTbNUC96GzXyJY8wffEQg8E9wML1ZHa6FbK33F5S+TnE/4VNzz2ehhUZRK3kKPO
         Mvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DQlely7nhO5OX9LPo+1SzConVy+LPaZVNMGknXRdf70=;
        b=N/LZBeoC8wFMEdXpLF62jTEo9S47UFGslagFdo3c820azGfkWeFCke3oGZ4h7u9GrF
         suaeGE9hWkRvAvLtNkup7BGVvourkOHsgAJiRlQuoqvmVTZefhPKVqkNOGRXdRAfc3+T
         CChm04JgTZ0ARC36UGdStFIpVM1gjbau6Gt6/KF+MGszxzEtcEWEz8SVHjVnirA81L+w
         +nhs5I2BhnRXohh2lTA2BMsGKt3Ov1sJmw7qZveFiLja0A37MevsvROQf2v1vw4dEtNP
         QVf2uNd0Fa96ryjLg7Qqv4iNErexXJO4W2AREi8wOBc4/mW0K6xyve34HYsf7PEN2yjP
         PL+g==
X-Gm-Message-State: ACrzQf3x2GbvrgtBNLjhjwnFIi46nta7lVGzQy3ThuIgbMfRBiTLLk0T
	XYUE9VLw2Rdvm6gbMCXfh6fIhzMDptVHCg==
X-Google-Smtp-Source: AMsMyM5DGKHFRHOv92Pdx96wKLJu4ztcKLAuDEbgzHMH/ULh8uOHd4Gp5K8CY10ghAzmX/okB3fo1w==
X-Received: by 2002:adf:fd0d:0:b0:22e:299c:3656 with SMTP id e13-20020adffd0d000000b0022e299c3656mr3571638wrr.233.1665155647141;
        Fri, 07 Oct 2022 08:14:07 -0700 (PDT)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c350400b003c1a7ea3736sm3232387wmq.11.2022.10.07.08.14.06
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 08:14:06 -0700 (PDT)
Message-ID: <e5b7fb2c-c1dc-af4c-bf55-4363f0599751@tessares.net>
Date: Fri, 7 Oct 2022 17:14:06 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 6th of October 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 212nd meeting with Mat, Ossama (Intel), Paolo
(Redhat), Dmytro (SFR), Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12995725: [net-next,1/4] mptcp: propagate fastclose error
12995726: [net-next,2/4] mptcp: use fastclose on more edge scenarios
12995728: [net-next,3/4] selftests: mptcp: update and extend fastclose
test-cases
12995727: [net-next,4/4] mptcp: update misleading comments.:
      - Series: mptcp: Fastclose edge cases and error handling
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=682336&state=*&archive=both


    our repo (by: Matthieu Baerts):

12991930: [mptcp-next] mptcp: sockopt: use new helper for TCP_DEFER_ACCEPT:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220928091852.1933333-1-matthieu.baerts@tessares.net/



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
    - status is the same as last week

12970164: [RFC,mptcp-next,05/10] mptcp: delay mptcp data_ack calculation
12970163: [RFC,mptcp-next,06/10] mptcp: allow delayed data_ack calculation
12970165: [RFC,mptcp-next,07/10] mptcp: TFO receive: bypass mapping check
12970166: [RFC,mptcp-next,08/10] mptcp: allow data that can not be
DATA_ACKed
12970167: [RFC,mptcp-next,09/10] mptcp: force data_ready
12970168: [RFC,mptcp-next,10/10] mptcp: test TFO
    - status is the same as last week

12991456: [RFC,mptcp-next,v12,1/7] mptcp: introduce MSG_FASTOPEN flag.
12991455: [RFC,mptcp-next,v12,2/7] mptcp: fix retrans., add mptfo vars
to msk
12991461: [RFC,mptcp-next,v12,3/7] mptcp: add subflow_v(4,6)_send_synack()
12991459: [RFC,mptcp-next,v12,6/7] mptcp: add TCP_FASTOPEN option
12991458: [RFC,mptcp-next,v12,7/7] selftests: mptfo initiator/listener:
      - State: Changes requested
      - Series: mptcp: Fast Open Mechanism
      - Submitter: Dmytro Shytyi
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=681241&state=*&archive=both
      - Dmytro will rebase on top of Paolo's patch (↓): mptcp: factor
out mptcp_connect()
      - Dmytro also worked on the selftests to modify mptcp_connect.{sh,c}
      - Will be part of v14
      - Dmytro also saw warnings reported by the CI: he will fix that → IPv6
      - Dmytro also used the new helper for sockopt (first subflow only)

12998672: [mptcp-next,v2] mptcp: factor out mptcp_connect():
      - State: Queued → applied
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/c74935435f59a6120f62c56bd5e1519c30d269bf.1664915909.git.pabeni@redhat.com/
      - also reduce the duplicated code from inet_stream_connect() part.

12999998: [mptcp-next,v4,1/3] mptcp: introduce 'sk' to replace
'sock->sk' in mptcp_listen()
12999999: [mptcp-next,v4,2/3] mptcp: add statistics for mptcp socket in use
13000000: [mptcp-next,v4,3/3] selftest: mptcp: add test for mptcp socket
in use:
      - State: New
      - Series: mptcp: add statistics for mptcp socket in use
      - Submitter: Menglong Dong
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=683401&state=*&archive=both
      - is the new flag MPTCP_DESTROYED really needed?:
          - used to know if mptcp_destroy_common() was called on the msk?
          - maybe possible to avoid it?
          - Paolo will try to look at that

13000223: [mptcp-next,v5,01/11] Squash to "mptcp: add get_subflow wrappers"
13000224: [mptcp-next,v5,02/11] mptcp: 'first' argument for
subflow_push_pending
13000225: [mptcp-next,v5,03/11] mptcp: refactor push_pending logic
13000226: [mptcp-next,v5,04/11] mptcp: drop last_snd for burst scheduler
13000227: [mptcp-next,v5,05/11] mptcp: simplify push_pending
13000228: [mptcp-next,v5,06/11] mptcp: multi subflows push_pending
13000229: [mptcp-next,v5,07/11] mptcp: use msk instead of mptcp_sk
13000230: [mptcp-next,v5,08/11] mptcp: refactor subflow_push_pending logic
13000231: [mptcp-next,v5,09/11] mptcp: simplify subflow_push_pending
13000232: [mptcp-next,v5,10/11] mptcp: multi subflows subflow_push_pending
13000233: [mptcp-next,v5,11/11] mptcp: multi subflows retrans support:
      - State: New
      - Series: refactor push pending
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=683468&state=*&archive=both
      - Part of the "redundant packet scheduler" series:
          - goal is to be able to send the same data over multiple subflows
          - v4 had some issues where patches were not "bisectable"
          - HOL blocking and packet scheduler algorithm still preserved?
          - Perf regressions tests will be needed for this series
          - Try increasing simult_flows.sh file sizes by x10



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 305):

  307  TCP performance better than MPTCP [question] @matttbe:
      - still not clear what's the net env, what is blocking, etc.
      - still need to validate that with a recent kernel
      - it is a corner case:
          - 1Gbps on the Ethernet
          - a few Kbps on the WiFi side
          - (not sure about the latency)
          - maybe the packet scheduler tries to use the bad link but has
to re-inject a lot → blocked by buffers (& CPU?)
          - the packet scheduler might need to be adapted to support
this case but we need to be careful about not to have a too complex
packet scheduler
          - probably good when we will have BPF to do packet scheduler
and do more experiments

     - idea to get better perf:
         - TCP_BIG would be difficult because of the DSS limitation (max
64KB)
         - ZERO_COPY could be implemented (at least the transmit side)
         - hardware GRO: not implemented so far, should not be problematic:
             - could work even if the NICs doesn't understand MPTCP but
compare TCP options and if the sender sends big chunks of data with TSO
     - use MPTCP for the perf when you are limited by the link speed,
not by CPU/RAM/NIC/...


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
      - See above

   74  BPF: path manager [enhancement] @geliangtang

   59  (MP)TFO support [enhancement] @dmytroshytyi:
      - See above


    Assigned Questions (opened, questions and assigned)

  307  TCP performance better than MPTCP [question] @matttbe:
      - See above


    Open questions (opened, questions and not assigned)



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

  306  pm_type in upstream implementation of mptcp [question] @matttbe
  300  Scheduler, pathmanager, congestion control [question]



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.2):
https://github.com/multipath-tcp/mptcp_net-next/projects/17
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4

    - New project
    - ChangeLog has been updated:
        - https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net: /

    - Fixes for net-next: /

    - Features for net-next: (closed)

        - [b886766292a6] mptcp: sockopt: make 'tcp_fastopen_connect'
generic (Matthieu Baerts)
        - [2fb9192a92e0] mptcp: add TCP_FASTOPEN_NO_COOKIE support
(Matthieu Baerts)
        - [858eb76ab115] mptcp: sockopt: use new helper for
TCP_DEFER_ACCEPT (Matthieu Baerts)

    - Features for net-next (next):


    - Features for other trees:

        - [222598e59662] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [9be02b76345a] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [9272aa124f67] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [6d808a7d97c8] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [ebd4cabafdc5] mptcp: add get_subflow wrappers (Geliang Tang)
        - [bacb818b1ac0] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [b939f5930d9c] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [908d0b885247] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [e39ef9a441ed] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [25515ff71421] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [8f3f18e741ce] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [acb6fb9b5a6e] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [68de8ed903ae] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [78ad4062b776] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - same as last week



Net-next closure:
    - Jakub asked for feedback about the closure
    - the closure doesn't bother us:
        - good to have this time just in case we need to send big RFC
patches
        - we don't close MPTCP anyway
    - even good to have a break in the patches we send to netdev



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - nothing new related to MPTCP

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - running well, didn't see any selftest failure

    - packetdrill (Davide):
        - 2 PR:
            - One from Paolo linked to the patch above:
                - Matth did a review, a few changes requested
            - Another one from Matth to sync with the upstream Google repo:
                - new option to stabilise tests
                - @Davide: may you review it

        - Fastopen:
            - there are example for MSG_FASTOPEN
            - another by google for the server part

        - to modify packetdrill script when using virtme, check the
README file:
            - https://github.com/multipath-tcp/mptcp-upstream-virtme-docker

    - Patchew (Davide):
        - was stopped but now back
        - re-tag: Matth will follow-up with Davide about that → new
options have been enabled, to be monitored

    - CI (Matth):
        - Tessares CI: looks OK except simult flow
        - Public CI: mptcp_join.sh seems to fail regularly (test 32):
            - Matth: monitor that and open tickets



mptcp.h in glibc:
    - could be useful for MPTCP socket options?
    - for the moment, it would be mainly useful for MPTCP_INFO option
    - maybe best to ask GLibC dev: conflicts between netinet and kernel
files?



Next meeting:
    - Next one on Thursday, the 13th of October.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20221013



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
