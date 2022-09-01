Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393996AA9
	for <mptcp@lists.linux.dev>; Thu,  1 Sep 2022 16:13:40 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id p16so32611361ejb.9
        for <mptcp@lists.linux.dev>; Thu, 01 Sep 2022 09:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=1QcMJL6pbvqcCOXe8on2d+WF1J/vxHBnCHKwTdgScsY=;
        b=utx+5dV+1Sppouibrr3bdvbFwj2IYhSVG+ZcaE/c18hRs1uzPEQxiPP4XApdDndMOs
         hCk5OGxftuLlHjqh6uvaRuKrDciL7zmjPp2hoXcXEbmK21AsZBAbN38GvLnhffxilE/5
         j0RiHAoS2wVsLd6Qw2nElo+5M0PvBbBeGAOCWml2ca/nGUjo4Ue79HlxQKsgJcCKrxRL
         CPdeIaByEl124sn3+g1eNfUz4rsUTOVLgwt+6Uuodix/5J928QbVpA0Q3AMPnvTIcjad
         qPrwxHzt6xvxks03BPr/Ma/iLsbHK/iL9qFkhCmk7HGEZ3qeuzR2N+vzDwRu4Ul6wDXk
         eyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=1QcMJL6pbvqcCOXe8on2d+WF1J/vxHBnCHKwTdgScsY=;
        b=IBiUJxOvsGMiYJXkTx/eQ3pJEH1mAO778fU6SBrsgn+mRrj6J3g2QHHucxtQGFA9ZB
         tPQBaIlsQCNuEUQ/XaFHFI77/Ih2pT0wnGYMYB0OfoY2GS7n/lxALkR1GhmeQjrlpYco
         OH10y8WoLB0ruOWKDg6LZA2nxBRYXsOG1qXWlwo9W2BcPmPnjDzE4Wr8ER5XSqmIuawX
         QclF8AtrP8xRCnR4r3iOHYwW3VcQ+qPbKpXOv/FZvVgeTNy6ZR3kyDtmR/p4oC+nyjs5
         Q6Ufjv7odAcWlujseYue4D7Lu1BzQbBdhMn+/jIgBi/lRT44bqKCdZCTLl5jLddxArZM
         /VKQ==
X-Gm-Message-State: ACgBeo20DR3XYh59Z1IrF19wLzmBmyTh2KMr/Y+vDLc+iWKLLi7rXm5h
	uGsqbjQaObxWG/4gGJeFJCRl9FDOf2isBQ==
X-Google-Smtp-Source: AA6agR5cNiYrPOu+RgcaBOIwJ+f5JXDqwPNJ01+6fur6i6DbVRaputnr0p8nTI6k1mOBpzsL1WCMbA==
X-Received: by 2002:a17:907:7242:b0:741:770b:dfc6 with SMTP id ds2-20020a170907724200b00741770bdfc6mr15332314ejc.203.1662048818622;
        Thu, 01 Sep 2022 09:13:38 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6af0:84ce:9f4e:2025? ([2a02:578:8593:1200:6af0:84ce:9f4e:2025])
        by smtp.gmail.com with ESMTPSA id 3-20020a170906300300b0073100dfa7b0sm8657320ejz.8.2022.09.01.09.13.37
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:13:37 -0700 (PDT)
Message-ID: <9ae505ef-6cab-e375-8215-6712a67a7591@tessares.net>
Date: Thu, 1 Sep 2022 18:13:36 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 25th of August 2022
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Today, we just had our 207th meeting with Ossama (Intel), Paolo
(Redhat), Dmytro (SFR), Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Jakub Kicinski):

12954112: [net-next] genetlink: start to validate reserved header bytes:
      - Submitter: Jakub Kicinski
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220825001830.1911524-1-kuba@kernel.org/


    our repo (by: Geliang Tang, Paolo Abeni):

12952040: [mptcp-next] mptcp: add do_check_data_fin to replace copied:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/95f0f96d90264cc6411b024753fe8430f6998e4f.1661258990.git.geliang.tang@suse.com/

12954562: [mptcp-net] mptcp: fix fwd memory accounting on coalesce:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/e07e982885b904607d42e1e45840c4eb3c124d4b.1661426770.git.pabeni@redhat.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Dmytro SHYTYI, Florian Westphal, Geliang Tang, Jason
Wang, Jiapeng Chong, Matthieu Baerts, Paolo Abeni):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
12321111: mptcp: Remove redundant assignment to remaining:
      - State: RFC
12922458: mptcp: Fix comment typo:
      - State: Changes requested
12901431: [mptcp-next,v10,1/5] Squash to "mptcp: add get_subflow wrappers"
12901432: [mptcp-next,v10,2/5] mptcp: redundant subflows push pending
12901433: [mptcp-next,v10,3/5] mptcp: redundant subflows retrans support
12901434: [mptcp-next,v10,4/5] selftests/bpf: Add bpf_red scheduler
12901435: [mptcp-next,v10,5/5] selftests/bpf: Add bpf_red test:
      - State: Changes requested

      → Status: same as last week

12933347: [RFC,mptcp-next,v4] mptcp: Fast Open Mechanism:
      - State: RFC
      - Submitter: Dmytro SHYTYI
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220801024656.397714-1-dmytro@shytyi.net/
      - Dmytro is continuing investigating the issues from last time
(currently, some issues with the end of the connection and when the skb
is in the retransmit queue):
          - sending the cookie is OK
          - it looks like we need to adapt some code from MPTCP (syn
received side)
          - no problem to extend it for MPTCP specific feature (TFO
here) as long as it is well isolated
          - it might be easier to isolate all TFO specific functions in
a new file (e.g. net/mptcp/fastopen.c ; headers can go in protocol.h):
              - remove 'mptcp_' from the name
              - move .h to protocol.h
              - update needed for the MPTCP DSN suboption
              - including the selftests will help for the review (and to
avoid regressions)

      - In //, Benjamin is looking at making the patch "upstreamable":
          - New code inspired by the ones from Dmytro but focused on the
sending of the data (not the cookies, etc.)
          - Benjamin needed to understand and "code"  to make sure he
understands the architecture (not re-writting stuff for the pleasure ;-) )
          - Benjamin will clean-up patches and hope to send them to the
list very soon
          - the approach is slightly different so we will need to pick
one or the other



12947468: [RFC] net: tcp: prevent transition to FIN_WAIT2 when mptcp has
unacked data_fin:
      - State: Changes requested
      - Submitter: Florian Westphal
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220818162123.30198-1-fw@strlen.de/
      - Paolo will check that


12960648: [mptcp-next,v2,1/2] mptcp: propagate fastclose error.
12960649: [mptcp-next,v2,2/2] mptcp: use fastclose on more edge scenarios.:
      - State: New
      - Series: [mptcp-next,v2,1/2] mptcp: propagate fastclose error.
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=672786&state=*&archive=both
      - there are some open questions in the 2/2:
          - should we split the selftests in the different patch?
          - selftests needs to be adapted to support the modification
("fix"/"feature") otherwise they are issues (but there are probably
issues if we only apply patch 1/2)
          - it seems OK to do the selftests modifications in a new
dedicated patch, we did that a few times before (change .c code then
adapt selftests): seems clearer and each patch will be shorter



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 295)

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe:
      - discussed last week


    Bugs (opened, flagged as "bug" and assigned)

  295  mptcpize, rsyncd & connection tear down (hangs)? [bug] @pabeni:
      - see patches above

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug] @fw-strlen
      - see patches above


    Bugs (opened and flagged as "bug" and not assigned)

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

  293  fail to create a subflow when a listen socket is closed [question]:
    - suggestions have been shared
    - let's wait a bit for feedback and close it later if we don't get any


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

  297  Meaning of newly added sysctl fields in upstream kernel
[question] @matttbe



New issues:
    - it looks like we don't do memory accounting for passive MPTCP socket.
    - Paolo will give more details from what he saw when looking at the
other issue
    - TODO: Matth: open a ticket and Paolo will fill it in → done: #298



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.1):
https://github.com/multipath-tcp/mptcp_net-next/projects/16
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [ee056f61817a] mptcp: fix fwd memory accounting on coalesce
(Paolo Abeni):
            - can be sent: TODO Matth

    - Fixes for net-next: /

    - Features for net-next:

        - [0ba9ead845e7] mptcp: add mptcp_for_each_subflow_safe helper
(Matthieu Baerts)
        - [fa01be2a6339] selftests: mptcp: move prefix tests of
addr_nr_ns2 together (Geliang Tang)
        - [03edca0ac31f] mptcp: allow privileged operations from user
namespaces (Thomas Haller)
        - [3488d02e57e0] mptcp: account memory allocation in
mptcp_nl_cmd_add_addr() to user (Thomas Haller)
        - [5d52409ddf0b] mptcp: add do_check_data_fin to replace copied
(Geliang Tang):
            - Should be sent

    - Features for net-next (next): /

    - Features for other trees:

        - [184ac85950ce] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [284a80597677] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [6dddba5ef4b1] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [9e0b0c411a7f] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [d552b73d658b] mptcp: add get_subflow wrappers (Geliang Tang)
        - [f43726d89dad] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [791e21885481] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [0e7a45c01590] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [31a5dc92d2a8] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [34e42d692c2a] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [edb8be176154] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [c59b5df90d66] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [3be317514771] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [c2c9cb7041b0] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - still patches pending in review



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
        - Alternative:
https://github.com/kuba-moo/nipa/blob/master/pw_poller.py
        - but it needs to be slightly adapted to our case + support
'export' and 'export-net' branches

    - CI (Matth):
        - TODO: Matth: check closer which tests are often failing and
open new GH issues



Next meeting:
    - Next one on Thursday, the 8th of September.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220908



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
