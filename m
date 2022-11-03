Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09157488
	for <mptcp@lists.linux.dev>; Thu,  3 Nov 2022 15:59:10 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id l14so3469459wrw.2
        for <mptcp@lists.linux.dev>; Thu, 03 Nov 2022 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7tmyKM6ynKufhfqtxl5Ldchn9mimrez8WPwfhBQg98=;
        b=66XQYfgE6d8Rq9tCqWoYOmgKV/82499hyXPwFXT2FcnQs/7LugxoIIXerKLnpLhgND
         Z7266d0Tg82wJ8WuNNWw0w+S+63yxiluZ55A/vPJzQfk6NN2avswDF+PIQJx4tDrIj4h
         Aho+VgDRsdI6H6gth3i783BeEeBt4gj1HNR7VaGgdFJSAONzhz/K0PmU9yC905OF+9yR
         srqk/uTII9dqIxoWX83xgLlkQg9UAX5BtFcg10o1K1Jpc1hxt/XrZwL+fbtRVuKQxLPM
         VmRmZIpJjMU5SPUye1UKGORFWIKvqUdyPk7jEFMQ3GazlHpdb22JCHhHP8/sovBKkZAb
         APhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B7tmyKM6ynKufhfqtxl5Ldchn9mimrez8WPwfhBQg98=;
        b=ynVG1XOkqlICYZ9z8xYm0vUEuA2VbjGdnMG21+3H2p5UC9q59n+7zuIgR7svm8V1qV
         +/fyfVKx6Ik4MU4pPexoaZIyiQZIQ+UGI0bbZtih1xPbWkyrA/+DLC36qDjwWkSFg+41
         sWjcr93C0NWnR/T+Cj6ANrlJ1nt0gWcj5kJ5ZLcj7fdphDSfStvAH+A28K8k9gM12f+V
         JuEGNTBk0OI0a52MKVMSMFCA9xBqt+WvZgS5zekL07lhVAF9pvf8WQrkNu8sNN0SsKTg
         cZ+qnzcEhRnLj5F43GpeK8lrzFUFqmlqoZTduRqkMVjFkAu06vZQksXzNYZpwoNCCzoP
         wa0w==
X-Gm-Message-State: ACrzQf1TkEiuyb8E63enUiPdZQHNLQugU61eMIHulDmiqFpTqLALZdmn
	0Y/6Dr5iMwEPB86rkkQW+eRkxRgRuDwz19OE
X-Google-Smtp-Source: AMsMyM6JBs0HGQIkIIxawrdhUKdr15luGJ6UqrnzlYm1VGIBaCoK2NpL/tCsYXnMyj9TtXwuUuieAg==
X-Received: by 2002:a5d:4c52:0:b0:236:60e8:72e with SMTP id n18-20020a5d4c52000000b0023660e8072emr19549218wrt.573.1667491148438;
        Thu, 03 Nov 2022 08:59:08 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f4ce:89a5:47d5:7afb? ([2a02:578:8593:1200:f4ce:89a5:47d5:7afb])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c46cc00b003b4ac05a8a4sm282924wmo.27.2022.11.03.08.59.07
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 08:59:07 -0700 (PDT)
Message-ID: <47e04ae4-8add-1971-417d-c12436fc210a@tessares.net>
Date: Thu, 3 Nov 2022 16:59:06 +0100
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
Subject: [Weekly meetings] MoM - 20th of October 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 214th meeting with Mat, Ossama (Intel), Paolo
(Redhat) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:


Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Paolo Abeni):

13005127: [mptcp-net,v3] mptcp: fix abba deadlock on fastopen:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/7c61250080c052b9dfb42a023c85dc36d4450daf.1665584136.git.pabeni@redhat.com/

13010259: [mptcp-next,v9,1/4] Squash to "mptcp: add get_subflow wrappers"
13010260: [mptcp-next,v9,2/4] mptcp: use msk instead of mptcp_sk
13010261: [mptcp-next,v9,3/4] mptcp: change 'first' as a parameter:
      - Series: refactor push pending
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=686214&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Kuniyuki Iwashima, Paolo Abeni):

13011546: [net-next,1/2] net: introduce and use custom sockopt socket flag
13011547: [net-next,2/2] udp: track the forward memory release threshold
in an hot cacheline:
      - Series: udp: avoid false sharing on receive
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=686633&state=*&archive=both
      - Not specific to MPTCP but Reviewed

13012428: [v2,net-next,1/5] inet6: Remove inet6_destroy_sock() in
sk->sk_prot->destroy().:
    - Not specific to MPTCP but Reviewed

    our repo (by: Benjamin Hesmans, Geliang Tang, Jason Wang, Jiapeng
Chong, Matthieu Baerts, Menglong Dong, Paolo Abeni):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
12321111: mptcp: Remove redundant assignment to remaining:
12922458: mptcp: Fix comment typo:
12970164: [RFC,mptcp-next,05/10] mptcp: delay mptcp data_ack calculation
12970163: [RFC,mptcp-next,06/10] mptcp: allow delayed data_ack calculation
12970165: [RFC,mptcp-next,07/10] mptcp: TFO receive: bypass mapping check
12970166: [RFC,mptcp-next,08/10] mptcp: allow data that can not be
DATA_ACKed
12970167: [RFC,mptcp-next,09/10] mptcp: force data_ready
12970168: [RFC,mptcp-next,10/10] mptcp: test TFO:
    - Status: same as last week

13000936: [mptcp-next,v5,1/3] mptcp: introduce 'sk' to replace
'sock->sk' in mptcp_listen()
13000937: [mptcp-next,v5,2/3] mptcp: add statistics for mptcp socket in use
13000938: [mptcp-next,v5,3/3] selftest: mptcp: add test for mptcp socket
in use:
      - State: Changes requested
      - Series: mptcp: add statistics for mptcp socket in use
      - Submitter: Menglong Dong
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=683673&state=*&archive=both:
    - Status: same as last week

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
scheduler":
      - State: Changes requested
      - Series: register default scheduler
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=684672&state=*&archive=both
      - Superseded by the "BPF redundant scheduler"

13007315: [RFC] selftests: mptcp: set test-case parameters consistently:
      - State: Changes requested
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/2abed554f2050c7626dede74c92a181506a92682.1665779933.git.pabeni@redhat.com/
      - Was needed because the goal was to add new parameter in a more
nicer way
      - But became quite big
      - Can be parked for the moment
      - Focus on the patch to fix the selftests instabilities (adding
parameters in a ugly way)
      - Linked to ticket #309

13011772: [mptcp-next,v14,1/7] mptcp: refactor push_pending logic:
    - the locking optimisation has been fixed compared to the previous
version
13011773: [mptcp-next,v14,2/7] mptcp: use get_send wrapper
13011774: [mptcp-next,v14,3/7] mptcp: use get_retrans wrapper
13011775: [mptcp-next,v14,4/7] mptcp: delay updating first_pending
13011776: [mptcp-next,v14,5/7] mptcp: delay updating already_sent
13011777: [mptcp-next,v14,6/7] selftests/bpf: Add bpf_red scheduler
13011778: [mptcp-next,v14,7/7] selftests/bpf: Add bpf_red test:
      - State: Under review
      - Series: BPF redundant scheduler
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=686705&state=*&archive=both
      - refactoring the push pending logic gets almost ready

13012120: [mptcp-net,1/4] selftests: mptcp: run mptcp_sockopt from a new
netns
13012121: [mptcp-next,2/4] selftests: mptcp: run mptcp_inq from a clean
netns
13012122: [mptcp-next,3/4] selftests: mptcp: removed defined but unused vars
13012123: [mptcp-next,4/4] selftests: mptcp: uniform 'rndh' variable:
      - State: New
      - Series: mptcp: run mptcp_sockopt from a new netns + cleanup
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=686816&state=*&archive=both
      - Small fixes in the selftests


Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 312):

None


    Bugs (opened, flagged as "bug" and assigned)

  312  packetdrill: `add_addr` test is regularly failing: packets
arriving before the expected time [bug] [packetdrill] @matttbe:
      - PR available: https://github.com/multipath-tcp/packetdrill/pull/98


    Bugs (opened and flagged as "bug" and not assigned)

  310  selftests: `simult_flows`: transfer slower than expected! [bug]
[selftests]:
      - division by 1000 instead of 1024? → to be checked
      - but also the heuristic part should be checked (estimate the
overhead: 10%)
      - but the overhead can vary depending on the conditions,
especially on slow/busy servers

  309  selftests: `mptcp_join`: test 33: `remove addresses` failing
occasionally  [bug] [selftests]:
      - waiting for an event?
      - we need new parameters

  299  several kernel warnings about mptcp [bug]:
      - waiting for feedback
      - can be closed if we don't get any

  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]


    In Progress (opened, new feature and assigned)

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe

  294  Clear way for userspace to know if the connection fell back to
TCP [enhancement] @matttbe:
      - Edit TCP code to support SOL_MPTCP in case of fallback?
      - Accept the fact EOPNOTSUPP == fall back to TCP → no longer an
MPTCP socket → looks OK
      - TODO: close ticket → done
      - Maybe a netlink event is needed?:
          - do we receive a CLOSE event if we fallback during the
connection? yes

TODO: Mat: create new issues
      -  netlink event on listening socket
      - Done


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

  311  [Question] on using MPTCP for proxy [question] @matttbe
  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.2):
https://github.com/multipath-tcp/mptcp_net-next/projects/17
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [1807be715b08] mptcp: set msk local address earlier (Paolo Abeni)
        - [bb7e37b06805] mptcp: factor out mptcp_connect() (Paolo Abeni)
        - [ce6065875535] mptcp: fix abba deadlock on fastopen (Paolo Abeni):
            - can be sent: done

    - Fixes for net-next: /

    - Features for net-next:

        - [c3e67d42c7e2] mptcp: sockopt: make 'tcp_fastopen_connect'
generic (Matthieu Baerts)
        - [55d17f688afa] mptcp: add TCP_FASTOPEN_NO_COOKIE support
(Matthieu Baerts)
        - [069ec2a992ae] mptcp: sockopt: use new helper for
TCP_DEFER_ACCEPT (Matthieu Baerts):
            - can be sent: done

        - [e31ea5bdc15f] mptcp: use msk instead of mptcp_sk (Geliang Tang)
        - [9e290048b56d] mptcp: change 'first' as a parameter (Geliang
Tang):
            - just applied, can wait a bit

    - Features for net-next (next): /

    - Features for other trees:

        - [90a410863e56] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [1bbfc004ec1a] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [674e040d3e2e] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [d6528ef49395] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [5b4845b839bb] mptcp: add get_subflow wrappers (Geliang Tang)
        - [f01f21e1c373] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [2b3eef89feab] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [e017ba23f963] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [216cab51cccb] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [964ad0c6d8ad] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [e0a305511da0] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [6a7fc2087a1f] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [03d01e8c245e] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [1dc6078eca88] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - Can wait: same status as last week



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - syzbot is seeing a lot of WARN but not in MPTCP (cpumask)
        - These are supposed to be fixed on -net and net-next

    - news about interop with mptcp.org/other stacks? (Christoph):
        - some fixes for mptcp.org from Christoph have been shared

    - news about Intel's kbuild? (Mat):
        - passing everything

    - packetdrill (Davide):
        - one new PR opens

    - Patchew (Davide):
        - /

    - CI (Matth):
        - Debug now taking longer than expected...
        - compilation is long for the moment because ccache is not updated
        - idea: force ccache upload, increase timeout



Next meeting:
    - No meeting on the
    - Next one on Thursday, the 3rd of November.
    - /!\ daylight saving time in Europe: we switch to 16:00 UTC
    - /!\ It means in the US, it will be one hour later than usual
    - 16:00 UTC (9am PDT, 5pm CET, 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20221103



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
