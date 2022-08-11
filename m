Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CF52CA7
	for <mptcp@lists.linux.dev>; Thu, 11 Aug 2022 16:40:49 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id k17so2860534wmr.2
        for <mptcp@lists.linux.dev>; Thu, 11 Aug 2022 09:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=3nMoGmnS4wCKG51wknYcntfMeu/f0MEOBopSTG7kVbw=;
        b=43i3DFAx+NJxPRsb6SkmtvE80ka5C1qSySTIFOOPXaDhf4NmF695sWNmGsGHh0q73T
         ZCzNI4l7z10PcIdSh/UgZPAbsgl7dnPIMKYEJSDx3JLEZRlXRB2i7jEZpvbMmiONXsoc
         lJtlQ1IsPbTqshgDF0+CLfz58BizZDYSukZ/w9SfBAwpptlqaDbRL3eEbTtx1aHkVYyS
         L1UAwyf65p4buLwdkZJUc2drf7SVSE0v9/b/bTb6ANoc4cURlIMQWytrZIRZV5Vkjkte
         qWO+GtTk0r3CwrPMnV1WablEhGnf3a/flr3VxoGukvevcl5Ol1CzltQDUxrVhbPF+ySB
         Song==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=3nMoGmnS4wCKG51wknYcntfMeu/f0MEOBopSTG7kVbw=;
        b=VVLoZy7v4cBwmwgV3qXzjE9CoFFymwPXWWkM39Eo3dJewDyjiUzzOczw5F1v6kp8K2
         +TThuqEBDMOMSF3iCAidR4rV0YQaUiqZvGb8wyab/XsN7BOsuy0Kxu8qfybz15riiP3x
         +JOqSV2UTxvgXJk1tQu88DJkOR1Hy1OrnJJuxD3RjZJLMw4Vc/I55zrAtXH9H05o6hcE
         8GET6GB9jVS9nhrfQaSQWvmcThZ8AKV863z1dOysJjeILABujgaaPb8FfBrm3Y5lH3/E
         KUlBs/kCAAfyzRlvRUBFW5/5RBkNRseEBVfp/L9d41PVVFoAjirmy2GoAOnbj7HOf/0R
         BVZQ==
X-Gm-Message-State: ACgBeo0nn5YN2qfcZtbESSre97BYTVdX5+VjHhbQa9IoVpAlW0gD3ZY5
	rzspW0FmmtyjFqeFNy2lYiz1IzX3Xdzbpw==
X-Google-Smtp-Source: AA6agR7mzx569+b4FiZHTJcfFXlWI2GIonMhSWPzPVWVowR68eo2tCSx069H52tNmNkax194Pxi9OQ==
X-Received: by 2002:a05:600c:21d6:b0:3a5:c283:348a with SMTP id x22-20020a05600c21d600b003a5c283348amr1404557wmj.28.1660236047747;
        Thu, 11 Aug 2022 09:40:47 -0700 (PDT)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id bi19-20020a05600c3d9300b003a5537bb2besm6834815wmb.25.2022.08.11.09.40.45
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 09:40:45 -0700 (PDT)
Message-ID: <90def8fd-05cf-ef57-6ea9-19009fdfb06b@tessares.net>
Date: Thu, 11 Aug 2022 18:40:45 +0200
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
Subject: [Weekly meetings] MoM - 11th of August 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello everyone,

Last Thursday, we had our 205th meeting with Ossama (Intel), Dmytro
(SFR), and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Jiri Olsa, Mat Martineau):

12934903: [PATCHv2,bpf-next] mptcp: Add struct mptcp_sock definition
when CONFIG_MPTCP is disabled:
      - Submitter: Jiri Olsa
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220802163324.1873044-1-jolsa@kernel.org/

12936811: [net,1/3] mptcp: move subflow cleanup in mptcp_destroy_common()
12936812: [net,2/3] mptcp: do not queue data on closed subflows
12936813: [net,3/3] selftests: mptcp: make sendfile selftest work:
      - Series: mptcp: Fixes for mptcp cleanup/close and a selftest
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=665506&state=*&archive=both


    our repo (by: Geliang Tang, Thomas Haller):

12938428: [mptcp-next] selftests: mptcp: move prefix tests of
addr_nr_ns2 together:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/a13144785eab9f2568fdf9eb7da6714d4a911756.1659923077.git.geliang.tang@suse.com/

12940293: [mptcp-next,v2,1/2] mptcp: allow priviledged operations from
user namespaces
12940294: [mptcp-next,v2,2/2] mptcp: account memory allocation in
mptcp_nl_cmd_add_addr() to user:
      - Series: [mptcp-next,v2,1/2] mptcp: allow priviledged operations
from user namespaces
      - Submitter: Thomas Haller
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=666508&state=*&archive=both



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


12922458: mptcp: Fix comment typo:
      - State: Changes requested
      - Series: mptcp: Fix comment typo
      - Submitter: Jason Wang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=661054&state=*&archive=both


12933347: [RFC,mptcp-next,v4] mptcp: Fast Open Mechanism:
      - State: RFC
      - Submitter: Dmytro SHYTYI
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220801024656.397714-1-dmytro@shytyi.net/
      - Dmytro is looking at adding a specific TFO flag in the SKB space
for MPTCP:
          - sounds like a good direction to take
          - but complex
      - Testing: Dmytro will share what he is using, kind of selftests
sending a small sequence, always the same, easier to track down stuff.
      - Benjamin: can you share the modification to support TFO
setsockopt please?
      - Example of usage with setsockopt TCP_FASTOPEN_CONNET:

https://github.com/curl/curl/blob/6ba3047378f40ae82d2296f970acd9eae36c2e06/lib/connect.c#L1315
      - Or a fallback to sendto():

https://github.com/curl/curl/blob/6fa89fa893cb8d10b0e4c6c77f88f9bf5d9d4411/lib/sendf.c#L362



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 292)

None.


    Bugs (opened, flagged as "bug" and assigned)

None.


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

  288  [syzkaller] memory leak in __netlink_create [bug] @mjmartineau



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.1):
https://github.com/multipath-tcp/mptcp_net-next/projects/16
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4

    - ChangeLog has been updated:
      https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog

    - New project for 6.1



Patches to send to netdev:

    - Fixes for other trees:

        - [b520fb09d9c3] module: kunit: Load .kunit_test_suites section
when CONFIG_KUNIT=m (David Gow):
            - Already in KUnit/Selftests tree, needed for our kunit tests

    - Fixes for -net: /

    - Fixes for net-next: /


    - Features for net-next:

        - [55bc1a6ae780] mptcp: add mptcp_for_each_subflow_safe helper
(Matthieu Baerts)
        - [a9e3ebb411fb] mptcp: move RCVPRUNE event later (Paolo Abeni)
        - [a5fa7ddbcf36] mptcp: more accurate receive buffer updates
(Paolo Abeni)
        - [c718aa7fdf2a] mptcp: move msk input path under full msk
socket lock (Paolo Abeni)
        - [f08b619c2b56] mptcp: use common helper for rmem memory
accounting (Paolo Abeni)
        - [5f51661fcb70] selftests: mptcp: move prefix tests of
addr_nr_ns2 together (Geliang Tang)
        - [52bc38c14e5f] mptcp: allow privileged operations from user
namespaces (Thomas Haller)
        - [a720a2d178a8] mptcp: account memory allocation in
mptcp_nl_cmd_add_addr() to user (Thomas Haller):

            - Net-next is closed for the moment


    - Features for net-next (next): /


    - Features for other trees:

        - [ec927afcc327] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [d10d47ea759d] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [94b10f3f56f2] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [c8b0bd6ad769] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [d7f9b58be08d] mptcp: add get_subflow wrappers (Geliang Tang)
        - [b49a6fc9a096] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [37c65ec29c03] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [ac0dafba9cf5] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [347a3f95f224] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [6b1cfaeddfc2] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [228a6584ef0b] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [66df1eca3bfb] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [10bf28d08688] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [c261253595d6] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - Still pending patches in reviews



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
        - WebUI is still slow but importer still OK

    - CI (Matth):
        - /


Netlink: limitations and difficulties (for LPC or others):
    - sync with kernel and userspace due to delay
    - messages lost due to buffer full or slow reader
    - if you have anything in mind that makes Netlink difficult to use
or limited, don't hesitate to share!



Next meeting:
    - Next one on Thursday, the 18th of August.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220818



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
