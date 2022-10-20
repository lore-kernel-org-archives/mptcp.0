Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521383C20
	for <mptcp@lists.linux.dev>; Thu, 20 Oct 2022 13:49:50 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so2384156wma.3
        for <mptcp@lists.linux.dev>; Thu, 20 Oct 2022 06:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlRQvsTsbJikRaCttIvNokxOXQsTCLBzcbDV+498vLY=;
        b=kiio0qgcDn3mJUzZatXAIdjUtkCsFJH3Zqfo3ZVE/Lq2x6Oug+QDvrVyhCOukzefJj
         eGr2ixh6UHQrJw2gH/N9ig++KJDbXOnOxImaT56wngk6XDU78+LiYpPs0n5of4PGpLj3
         ZmCVeva1nB45/Z767PJ5xBHVRMQtgHzAgrlFEs7Vp4cRBxHFfz5aSlcW5sVRXwZ4BCQC
         hOAEhz1PNm2+I4K7eTf1tl57Q6ZYfW+LGI8VmtypiisdD+dtR+ZayU+I73q4otGFREt3
         G+KpAOxvvJOB21d+hV+s7pS06Sv1z2Pj9Y5NmxKmri7qCTFiDc2+9Vg+otoFCeCfnmlx
         Ig1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zlRQvsTsbJikRaCttIvNokxOXQsTCLBzcbDV+498vLY=;
        b=0lWMTrQKefRG8YMZp3WkqcDe1x8h1nWc5uEQd6fDNZEPmuX/pO0CU21WctwoUzGKa3
         aL63WVRQ7gPFrkAhtUKIAmHP7ArzhX4fYjbVpsJkhV7g5I3NlBJ8tkeMiY9Apw4l2Poe
         8GipKH45f/qzS1u9PEGPBCwTM1EIBcvL+6/XFbGjr7H8vNyFjIreB7N0tG7KS0R+3dYO
         D7fTun1g7ciO18dp85x+OQbDuw3v37FEuFfchow1msLGLFU3kS2jacNJZzJoBVxoQq2X
         7+cWAKdO81SGLUu83Ywe1jIkKEzGhJpjja4Hh6+a+UJkiD2uViyCUdfZzlc2h6a1VJYq
         NQcw==
X-Gm-Message-State: ACrzQf0Az7xZysmz80DBbvt90ACwuw4piDWI+9SX39w/CGNg1GAj0qgW
	EWbbJEI/EQYfUQOphnD+1a/WAFu/KJ4NOXTt
X-Google-Smtp-Source: AMsMyM5GkWbF1kWWVxw0a/8wLTBCY5AgnSdyXQBrg30LtrOKKwrWCTOyGqy0PBo55uRmnlbm7vh/2Q==
X-Received: by 2002:a7b:c01a:0:b0:3b4:a61c:52d1 with SMTP id c26-20020a7bc01a000000b003b4a61c52d1mr9599710wmb.146.1666273788350;
        Thu, 20 Oct 2022 06:49:48 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:d3a7:8451:3ef5:2fdf? ([2a02:578:8593:1200:d3a7:8451:3ef5:2fdf])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0ac700b003c6fb525b4csm2991719wmr.38.2022.10.20.06.49.47
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:49:47 -0700 (PDT)
Message-ID: <cfe46cb3-20d6-1cc2-8453-a0bd09178069@tessares.net>
Date: Thu, 20 Oct 2022 15:49:47 +0200
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
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 13th of October 2022
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 213th meeting with Mat, Ossama (Intel), Paolo
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


    our repo (by: Matthieu Baerts, Paolo Abeni):

12991930: [mptcp-next] mptcp: sockopt: use new helper for TCP_DEFER_ACCEPT:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220928091852.1933333-1-matthieu.baerts@tessares.net/

12998672: [mptcp-next,v2] mptcp: factor out mptcp_connect():
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/c74935435f59a6120f62c56bd5e1519c30d269bf.1664915909.git.pabeni@redhat.com/

13002896: [mptcp-net] mptcp: set msk local address earlier:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/f5e8bfe9878d3948df9328870fc35daec6388e2b.1665431162.git.pabeni@redhat.com/
      - The accepted msk could be without the correct local address and
would confuse the PM



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
12970164: [RFC,mptcp-next,05/10] mptcp: delay mptcp data_ack calculation
12970163: [RFC,mptcp-next,06/10] mptcp: allow delayed data_ack calculation
12970165: [RFC,mptcp-next,07/10] mptcp: TFO receive: bypass mapping check
12970166: [RFC,mptcp-next,08/10] mptcp: allow data that can not be
DATA_ACKed
12970167: [RFC,mptcp-next,09/10] mptcp: force data_ready
12970168: [RFC,mptcp-next,10/10] mptcp: test TFO:
    - same status as last week

13000936: [mptcp-next,v5,1/3] mptcp: introduce 'sk' to replace
'sock->sk' in mptcp_listen()
13000937: [mptcp-next,v5,2/3] mptcp: add statistics for mptcp socket in use
13000938: [mptcp-next,v5,3/3] selftest: mptcp: add test for mptcp socket
in use:
      - State: Changes requested
      - Series: mptcp: add statistics for mptcp socket in use
      - Submitter: Menglong Dong
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=683673&state=*&archive=both
      - v6 needed to fix issues reported by the CI with the new test

13003283: [RFC,mptcp-next,v14,1/5] mptcp: introduce MSG_FASTOPEN flag.
13003282: [RFC,mptcp-next,v14,2/5] mptcp: implement delayed seq
generation for passive fastopen
13003285: [RFC,mptcp-next,v14,3/5] mptcp: add subflow_v(4,6)_send_synack()
13003284: [RFC,mptcp-next,v14,4/5] mptcp: add TCP_FASTOPEN sock option
13003298: [RFC,mptcp-next,v14,5/5] selftests: mptcp: mptfo
Initiator/Listener:
      - State: Changes requested
      - Series: mptcp: Fast Open Mechanism
      - Submitter: Dmytro Shytyi
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=684331&state=*&archive=both
      - Dmytro has some modifications on going, addressing comments.
      - packetdrill tests for the receivers will come after

13004643: [mptcp-next,v7,01/12] Squash to "mptcp: add get_subflow wrappers"
13004644: [mptcp-next,v7,02/12] mptcp: change 'first' as a parameter
13004645: [mptcp-next,v7,03/12] mptcp: refactor push_pending logic
13004646: [mptcp-next,v7,04/12] mptcp: drop last_snd of struct mptcp_sock
13004647: [mptcp-next,v7,05/12] mptcp: simplify push_pending
13004648: [mptcp-next,v7,06/12] mptcp: multi subflows push_pending
13004649: [mptcp-next,v7,07/12] mptcp: use msk instead of mptcp_sk
13004650: [mptcp-next,v7,08/12] mptcp: refactor subflow_push_pending logic
13004651: [mptcp-next,v7,09/12] mptcp: simplify subflow_push_pending
13004652: [mptcp-next,v7,10/12] mptcp: multi subflows subflow_push_pending
13004653: [mptcp-next,v7,11/12] mptcp: multi subflows retrans support
13004654: [mptcp-next,v7,12/12] Squash to "selftests/bpf: Add bpf_rr
scheduler":
    - From Geliang
    - Focused on bisection problem to focus on that part
    - v6 was almost good, just an issue with the subflow push pending
when scheduling the same data on multiple subflows because it is running
on the context of a specific subflow (BH), we cannot send the same data
across multiple subflows (mainly useful for the redundant scheduler)
    - Maybe we need to limit the scope
    - redundant scheduler: either complex or not efficient
    - idea would be to avoid re-introducing the worker: complex, load, etc.
    - maybe it could be possible to store data in the packet scheduler
data and... (I got interrupted, I didn't catch the beginning...):
        - amount of data to be sent + sequence number
        - then at the next run, go through that
        - looks complex...

13004656: [mptcp-next,v2,01/16] Squash to "mptcp: add struct
mptcp_sched_ops"
13004657: [mptcp-next,v2,02/16] Squash to "mptcp: add get_subflow
wrappers" II
13004658: [mptcp-next,v2,03/16] Squash to "mptcp: simplify push_pending"
13004662: [mptcp-next,v2,04/16] Squash to "mptcp: multi subflows
push_pending"
13004663: [mptcp-next,v2,05/16] Squash to "mptcp: simplify
subflow_push_pending"
13004664: [mptcp-next,v2,06/16] Squash to "mptcp: multi subflows
subflow_push_pending"
13004665: [mptcp-next,v2,07/16] Squash to "mptcp: multi subflows retrans
support"
13004666: [mptcp-next,v2,08/16] mptcp: use snd_burst of data instead of msk
13004667: [mptcp-next,v2,09/16] mptcp: define default scheduler
13004668: [mptcp-next,v2,10/16] mptcp: register default scheduler
13004669: [mptcp-next,v2,11/16] mptcp: add mptcp_sched_data_set_contexts
helper
13004670: [mptcp-next,v2,12/16] Squash to "bpf: Add bpf_mptcp_sched_ops"
13004671: [mptcp-next,v2,13/16] Squash to "bpf: Add
bpf_mptcp_sched_kfunc_set"
13004672: [mptcp-next,v2,14/16] Squash to "selftests/bpf: Add bpf_first
scheduler"
13004673: [mptcp-next,v2,15/16] Squash to "selftests/bpf: Add bpf_bkup
scheduler"
13004674: [mptcp-next,v2,16/16] Squash to "selftests/bpf: Add bpf_rr
scheduler"
13005070: [mptcp-next] Squash to "mptcp: add get_subflow wrappers" III:
      - State: Under review
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/d25122dbd282e7efb55a6c515a298d263bf2f6f9.1665582114.git.geliang.tang@suse.com/
      - Maybe best to focus on the other series
      - This series update the BPF code.

13005127: [mptcp-net,v3] mptcp: fix abba deadlock on fastopen:
      - State: New
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/7c61250080c052b9dfb42a023c85dc36d4450daf.1665584136.git.pabeni@redhat.com/
      - Mat reported an issue with the new packetdrill




Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 307):

  312  packetdrill: `add_addr` test is regularly failing: packets
arriving after the expected time [bug] [packetdrill]:
      - event is happening sooner than expected because we inject packet
that reset the timeout
      - To be checked what we can do

  311  [Question] on using MPTCP for proxy [question] @matttbe:
      - no "official" MPTCP proxy available (but there are some projects
on Github)
      - Some issues with nginx? To be checked

  310  selftests: `simult_flows`: transfer slower than expected! [bug]
[selftests]:
      - Maybe there is something else to take into account?
      - we take the file size into account, we can predict the packet
overhead but it is possible packet are not sent with the full size using
the full MTU → we estimate it to 10%
      - in the previous analysis, it looks like 10% was OK
      - also, we divide by 1024 at some points but it should be 1000. To
be confirmed, not urgent but something to look at.

  309  selftests: `mptcp_join`: test 33: `remove addresses` failing
occasionally  [bug] [selftests]:
      - first idea: test completed before the remove was done → seems
not after some tests
      - maybe the remove is started before the expected data were fully
transferred
      - new idea: waiting more before removing subflow
      - but we need to wait for an event, not just increase a sleep time

  308  selftests: `mptcp_join`: test 35: `flush subflows and signal`
(+71: `with port`) failing regularly [bug] [selftests]:
      - already fixed by Paolo: mptcp: set msk local address earlier


    Bugs (opened, flagged as "bug" and assigned)

None.


    Bugs (opened and flagged as "bug" and not assigned)

  312  packetdrill: `add_addr` test is regularly failing: packets
arriving after the expected time [bug] [packetdrill]:
      - see above

  310  selftests: `simult_flows`: transfer slower than expected! [bug]
[selftests]:
      - see above

  309  selftests: `mptcp_join`: test 33: `remove addresses` failing
occasionally  [bug] [selftests]:
      - see above

  299  several kernel warnings about mptcp [bug]:
      - no news: close?

  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]

  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]:
      - replaced by #312?


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

  311  [Question] on using MPTCP for proxy [question] @matttbe:
      - can be closed?

  307  TCP performance better than MPTCP [question] @matttbe:
      - waiting for feedback


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

  308  selftests: `mptcp_join`: test 35: `flush subflows and signal`
(+71: `with port`) failing regularly [bug] [selftests]
  306  pm_type in upstream implementation of mptcp [question] @matttbe
  300  Scheduler, pathmanager, congestion control [question]



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.2):
https://github.com/multipath-tcp/mptcp_net-next/projects/17
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees:


    - Fixes for -net:

        - [b686e9abd4f9] mptcp: set msk local address earlier (Paolo Abeni):
            - can be sent

    - Fixes for net-next:


    - Features for net-next:

        - [20cf9bd050da] mptcp: sockopt: make 'tcp_fastopen_connect'
generic (Matthieu Baerts)
        - [fc571a4238dd] mptcp: add TCP_FASTOPEN_NO_COOKIE support
(Matthieu Baerts)
        - [46fcdf21eaea] mptcp: sockopt: use new helper for
TCP_DEFER_ACCEPT (Matthieu Baerts)
        - [a330b450c75d] mptcp: factor out mptcp_connect() (Paolo Abeni):
            - net-next is closed

    - Features for net-next (next):


    - Features for other trees:

        - [928ead611d32] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [60bcfcf794bc] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [0354c4a1d8c2] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [7d61d2117aab] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [517ab13fd55a] mptcp: add get_subflow wrappers (Geliang Tang)
        - [1b354fb06f36] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [1d9b699c6cf5] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [f52d6477bf3b] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [a927d432b2cf] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [1ec0d79183fb] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [d12ba5f6e5a8] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [739e334c2170] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [3d96fa549361] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [94deb01e5c73] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - same as last week, patches in review



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - no MPTCP issues

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - tests are passing

    - packetdrill (Davide):
        - recent sync with upstream
        - more unblocking connect tests
        - time-wait: reply with a higher delay

    - Patchew (Davide):
        - Still issues when RvB tags, etc. are sent: tags are being
overridden

    - CI (Matth):
        - Getting better!
        - Still many issues with ADD_ADDR retry



Other topics:
    - https://github.com/mptcp-apps/man-pages:
        - Feel free to contribute!

    - https://github.com/obonaventure/nstat-doc/blob/main/mptcp.rst:
        - Not specific to MPTCP but feel free to contribute!



Next meeting:
    - Next one on Thursday, the 20th of October.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20221020



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
