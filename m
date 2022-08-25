Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A222F1841
	for <mptcp@lists.linux.dev>; Thu, 25 Aug 2022 14:55:26 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id r4so26443827edi.8
        for <mptcp@lists.linux.dev>; Thu, 25 Aug 2022 07:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=7JjcvLslsmnhvStGSAGWxOupDyPETfYCuvsbVdKpd9s=;
        b=JVLVr1EVqyJ+WfCi2+N4NxBmE7uPK1cl9R0LR6OR8WkaPrgNcrIi0WB/banHnzzmBK
         otJ5pz5BTInNNS+gL7KKcM/8Z4FSmfWFl0kos85wiaLGxNAyGZ2SWqQUmsBhKrzN1bxc
         UOs9oY5oVYEbLj+KjyQ6jcCCa65/PG8qdUC1xDJXkTjJghnMJxkLMYIwjiJGqbrh1RSr
         rzOW/ou8hsrQVp/C2+VDeEZyFm444XpI/nVG/h2QmbJGyAPC5QQX3SV1pSDB1Cv24NTn
         lSJQ0RsqB7WMPZFP1erMFJ2QBCHO/FrN7NvaYybQiVgQcY3kDcgAHmpp6ty+9+TmXAXY
         k7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=7JjcvLslsmnhvStGSAGWxOupDyPETfYCuvsbVdKpd9s=;
        b=LP9ZNz51WFAGCzdqbWEp0+LVNuxjGKZZe6RItWT+7/gH0iFSwK/Ig5BybHMqr5mcLt
         1tBDtkkwt15SY2RWxQnNBuieXXXSSSOMHvKPWhWp4/kRUyqJh56izZ2/sTa6Cx1cloYc
         gWfNtiDL6auSyehRxWpxB0M9Nqcxv2WdDbv0z/xJCacV3zEOG2KIn/G7vzCwd6Ci3NtC
         VLFyiLwIPq/3o6aQVK18jVBiI2uf4Ecgpas3Hdkig1ge0yQswtfmU/Ml01QtlE/VnzGn
         1v9dW3N9PogxC4rdAZHZqF0V+71IP5ezZTHc6Tk8gpP0gi5+Js5Y/lxrn+uutF4r6qlI
         HfPQ==
X-Gm-Message-State: ACgBeo3HGtHPea4ST1mn/RojmGCVoQhmkX4DpmXQmvdd4NkFNH5DQQKH
	gISEjB5HksJvPanXyAL6ZUsVtZCobPgFFOi2
X-Google-Smtp-Source: AA6agR69TSqLU65NEnMc+c3OVNxuHup0PUCgDvkR9DSOPU6i6SrUpGtHou99sbgLVFMKDulyaLCv0Q==
X-Received: by 2002:a05:6402:1cab:b0:445:d67f:5323 with SMTP id cz11-20020a0564021cab00b00445d67f5323mr3604042edb.100.1661439324272;
        Thu, 25 Aug 2022 07:55:24 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c1b1:a3ef:2334:824f? ([2a02:578:8593:1200:c1b1:a3ef:2334:824f])
        by smtp.gmail.com with ESMTPSA id u3-20020a50eac3000000b0043e581c30eesm4999848edp.31.2022.08.25.07.55.23
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 07:55:23 -0700 (PDT)
Message-ID: <ab9064ce-2cab-0dc7-c8a4-a50d17c9b3ad@tessares.net>
Date: Thu, 25 Aug 2022 16:55:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 18th of August 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 205th meeting with Ossama (Intel), Florian
(Redhat), Giray (Parkyeri), Dmytro (SFR), and myself (Tessares).


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
      - State: RFC

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
      - Same as last week

12922458: mptcp: Fix comment typo:
      - State: Changes requested
      - Series: mptcp: Fix comment typo
      - Submitter: Jason Wang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=661054&state=*&archive=both
      - Same as last week

12933347: [RFC,mptcp-next,v4] mptcp: Fast Open Mechanism:
      - State: RFC
      - Submitter: Dmytro SHYTYI
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220801024656.397714-1-dmytro@shytyi.net/
      - Dmytro is working on a v5 with a minimal set of changes to have
the proper seq num
      - hopefully data transfer will be working in v5



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 292)

  294  Clear way for userspace to know if the connection fell back to
TCP [enhancement] @matttbe:
      - we could use MPTCP_INFO and other SOL_MPTCP ones but if we did a
fallback, we will get a "not supported" error, same as if the kernel
doesn't support these SO
      - idea is to add a new one: MPTCP_STATUS for example
      - Matt can send a patch

  293  fail to create a subflow when a listen socket is closed [question]:
      - mptcpd master should already work if it is configured to send an
ADD_ADDR
      - TODO: Matth: send ↑ → done


    Bugs (opened, flagged as "bug" and assigned)

None.


    Bugs (opened and flagged as "bug" and not assigned)

  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]
  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]:
      - test case with Packetdrill:
          - without the patch, the test hang and is not retransmitted
      - tw_sock mini-state doesn't know anything about MPTCP:
          - either ignore mini sock
          - or making that compatible with MPTCP:
              - looks like there are not so many things to modify for MPTCP
      - Florian is looking at that and will send an email/RFC about that
      - assigned to Florian


    In Progress (opened, new feature and assigned)

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

  293  fail to create a subflow when a listen socket is closed [question]


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
    - Current/Coming merge window (6.1):
https://github.com/multipath-tcp/mptcp_net-next/projects/16
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees:

        - [fcd332e5eed9] module: kunit: Load .kunit_test_suites section
when CONFIG_KUNIT=m (David Gow):
            - already in another tree

    - Fixes for -net: /


    - Fixes for net-next: /


    - Features for net-next:

        - [3f3af4ac164b] mptcp: add mptcp_for_each_subflow_safe helper
(Matthieu Baerts):
            - can be sent

        - [33214a27eeb9] mptcp: move RCVPRUNE event later (Paolo Abeni)
        - [5342c4eae18e] mptcp: more accurate receive buffer updates
(Paolo Abeni)
        - [95c9ea825a50] mptcp: move msk input path under full msk
socket lock (Paolo Abeni)
        - [58083e1fa7e2] mptcp: use common helper for rmem memory
accounting (Paolo Abeni):
            - introducing some instabilities, can wait

        - [46913dab4787] selftests: mptcp: move prefix tests of
addr_nr_ns2 together (Geliang Tang)
        - [c913a30d4da7] mptcp: allow privileged operations from user
namespaces (Thomas Haller)
        - [1f0770adf130] mptcp: account memory allocation in
mptcp_nl_cmd_add_addr() to user (Thomas Haller):
            - can be sent

    - Features for net-next (next):


    - Features for other trees:

        - [ac675770609f] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [3cf19f3a5c9e] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [e66c25cb09f1] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [cf4f03a248cb] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [35d5ca4c9814] mptcp: add get_subflow wrappers (Geliang Tang)
        - [778058966f4c] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [d1d193a9f234] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [bf4dbe6eb0f2] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [a5657a5698c7] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [8e49d95e2eb7] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [66ed45606bde] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [e5b5caf42159] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [b8f5348b0b03] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [c8107ef525ab] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - some patches are pending, we can wait


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
        - /

    - CI (Matth):
        - Build: using Ubuntu 22.04 (instead of 20.04) with new GCC version:
            - everything is still OK
        - Sparse:
            - it was reporting false-alarms when using the last stable
version
            - Now using the dev version to avoid issues
        - Perf: it now needs python3's Setuptools
        - Some issues with mptcp_join (linked to Paolo's patch-set,
expected)
        - and packetdrill (linked to what Davide is working on probably)



LPC:
    - Talk has been accepted \o/
    - https://lpc.events/event/16/contributions/1354/



Next meeting:
    - Next one on Thursday, the 25th of August.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220825



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
