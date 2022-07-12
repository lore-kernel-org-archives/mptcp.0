Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE41440D
	for <mptcp@lists.linux.dev>; Tue, 12 Jul 2022 14:03:58 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id l23so14497214ejr.5
        for <mptcp@lists.linux.dev>; Tue, 12 Jul 2022 07:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=message-id:date:mime-version:user-agent:content-language:from:to
         :subject:content-transfer-encoding;
        bh=JtuhxzXwri34pKrjmBRtrXYUHL6m3sl5c3B1lWKDqHA=;
        b=GIGoorh6oGUpFjMGDxSn7Q5M2oPfSO0+4Oxsc1AFfrwCwX9hn5VIl3vCYkB3Ksbadb
         Y7gPM3FK3p9uO9jpRNE8mGZ8iuJMvp7IrgW9DmgDTflcx990iu4fNjRPJa2U1IBuO0jE
         PtAnHmfRRx8mLp5FHH4xHUXAVANbXtw0HhGCnPwrvnZjVi3GdK285h6lkHPjsSUDZH1D
         LDlkN9ewEv2M+Gl5jqUqxBm0cwsUbxEv+wITo9F3AQZInUnTpBS4gDMDo7OwwEDgJu2P
         2y9GDtOVmhk9SG6+Zt2Bw8oc/rDfZchzsjnAEoNwuKmVMTkiVzdXQnTXVHwjE+cnKZOY
         2PLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:subject:content-transfer-encoding;
        bh=JtuhxzXwri34pKrjmBRtrXYUHL6m3sl5c3B1lWKDqHA=;
        b=AT96jRlhLGgMqHk5ABCEJn7EkMUh55DVOiJ6umBSN2qgcH3B8I09tv7tsoU16MzQ6B
         JAOjSEvJ/aDZqLuqn7zpZ/IMPQQmTKwxKitQH9yRaslkMDDmJa198STZs9nGgK8nYNvv
         dKHYEt8dpW2P5K9DHx1k4fcpy7qsd2H98yN8Wb6c1uD2h+9TjwpB5piveUvcqySyjEA6
         vG92kEXDiYBU3rDrSBhewLQc8ccLEfnGUdA7GRcJQBLGlq+n9ulVDs8ZPan9EJCO1v69
         jbEmN45ADlMqZ/UTgUyH2KCNZ8NKGGcX4dD0yjZu8ZFegoXxiJI7CyZfo1mZBTq5eP0k
         Zwzw==
X-Gm-Message-State: AJIora/bY7KbiQ+/BcRVTdviJpFltP+SJ3jaHooQIDId8/JPpmCKPh3L
	6jBwRluuDJziFZmrWcOpW13ajFtOYVhhMcyS
X-Google-Smtp-Source: AGRyM1tE6vpJc+XQKcwS2hKAz+MFsDCJ2soMS+Amy7dTufyPreZUgr4eGS2hYCXUEJ7kojcTBxU/mg==
X-Received: by 2002:a17:906:8a69:b0:72b:40d3:7b6c with SMTP id hy9-20020a1709068a6900b0072b40d37b6cmr15939660ejc.624.1657634636005;
        Tue, 12 Jul 2022 07:03:56 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ef5d:b12d:ae7c:8d1? ([2a02:578:8593:1200:ef5d:b12d:ae7c:8d1])
        by smtp.gmail.com with ESMTPSA id z41-20020a509e2c000000b0043a95981050sm6082628ede.79.2022.07.12.07.03.55
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 07:03:55 -0700 (PDT)
Message-ID: <3000ad7f-e39d-6f64-03bb-28a6d236cdea@tessares.net>
Date: Tue, 12 Jul 2022 16:03:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 7th of July 2022
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 201st meeting with Mat, Ossama (Intel), Paolo
(Redhat) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12902325: [net-next,1/4] mptcp: never fetch fwd memory from the subflow
12902326: [net-next,2/4] mptcp: drop SK_RECLAIM_* macros
12902328: [net-next,3/4] mptcp: refine memory scheduling
12902327: [net-next,4/4] net: remove SK_RECLAIM_THRESHOLD and
SK_RECLAIM_CHUNK:
      - Series: mptcp: Updates for mem scheduling and SK_RECLAIM
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=655566&state=*&archive=both

12907079: [net,1/7] mptcp: fix locking in mptcp_nl_cmd_sf_destroy()
12907080: [net,2/7] mptcp: Avoid acquiring PM lock for subflow priority
changes
12907081: [net,3/7] mptcp: Acquire the subflow socket lock before
modifying MP_PRIO flags
12907082: [net,4/7] mptcp: netlink: issue MP_PRIO signals from userspace PMs
12907083: [net,5/7] selftests: mptcp: userspace PM support for MP_PRIO
signals
12907084: [net,6/7] mptcp: fix local endpoint accounting
12907078: [net,7/7] mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy:
      - Series: mptcp: Path manager fixes for 5.19
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=656814&state=*&archive=both



    our repo (by: Geliang Tang, Kishen Maloor, Mat Martineau, Matthieu
Baerts, Paolo Abeni):

12899137: [mptcp-net,v4,1/2] mptcp: netlink: issue MP_PRIO signals from
userspace PMs
12899138: [mptcp-net,v4,2/2] selftests: mptcp: userspace PM support for
MP_PRIO signals:
      - Series: mptcp: support MP_PRIO signals with userspace PMs
      - Submitter: Kishen Maloor
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=654814&state=*&archive=both

12900760: [mptcp-net,v3,1/2] mptcp: Avoid acquiring PM lock for subflow
priority changes
12900761: [mptcp-net,v3,2/2] mptcp: Acquire the subflow socket lock
before modifying MP_PRIO flags:
      - Series: Locking fixes for subflow flag changes
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=655189&state=*&archive=both

12901688: [mptcp-next] Squash to "bpf: Add bpf_mptcp_sched_ops":
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/9ab93a02e7bf2ea1b2cfd40ce9e2001970d2e890.1656586148.git.geliang.tang@suse.com/

12903096: [mptcp-next,1/6] mptcp: fix local endpoint acconting.
12904881: [v2,mptcp-next,1/5] mptcp: introduce and use mptcp_pm_send_ack()
12904885: [v2,mptcp-next,2/5] mptcp: address lookup improvements
12904883: [v2,mptcp-next,3/5] mptcp: allow the in kernel PM to set MPC
subflow priority
12904882: [v2,mptcp-next,4/5] mptcp: more accurate MPC endpoint tracking
12904884: [v2,mptcp-next,5/5] selftests: mptcp: add MPC backup tests:
      - Series: mptcp: support for MPC prio exchange
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=656255&state=*&archive=both

12907210: [mptcp-next,v2] Squash-to: "selftests: mptcp: tweak
simult_flows for debug kernels":
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220705235144.221591-1-mathew.j.martineau@linux.intel.com/

12907733: [mptcp-next] selftests: mptcp: validate userspace PM tests by
default:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220706091706.2679400-1-matthieu.baerts@tessares.net/

12908001: [mptcp-net] mptcp: fix subflow traveral at disconnect time:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/2c5147569717a1c879b291230d460e8e85992878.1657106043.git.pabeni@redhat.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12874585: [net-next,2/2] mptcp: move MPTCPOPT_HMAC_LEN to net/mptcp.h:
      - Series: mptcp: Header fixups
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=648618&state=*&archive=both


    our repo (by: Dmytro SHYTYI, Geliang Tang, Jiapeng Chong, Matthieu
Baerts):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
12321111: mptcp: Remove redundant assignment to remaining

12858306: [RFC,mptcp-next,v3] mptcp: Fast Open Mechanism:
      - State: Changes requested
      - Submitter: Dmytro SHYTYI
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220522183921.103526-1-dmytro@shytyi.net/
      - Benjamin from Tessares is going to look at that:
          - We had a meeting with Dmytro to talk about the next steps
          - for the moment, the MPTCP data seq is wrong and not validated
          - idea is to start supporting TFO for the client side, without
cookies

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



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 287)

  288  [syzkaller] memory leak in __netlink_create [bug]:
      - probably not linked to MPTCP, mainly there to share logs
      - still happening with latest export branch apparently


    Bugs (opened, flagged as "bug" and assigned)

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug] @mjmartineau:
      - Florian is interested to help looking at that
      - No issue for Mat if Florian grabs it


    Bugs (opened and flagged as "bug" and not assigned)

  288  [syzkaller] memory leak in __netlink_create [bug]:
      - see above

  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]


    In Progress (opened, new feature and assigned)

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang:
       - See patches above

   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

  284  combine to WAN's via two Wiregate Connections [question] @matttbe:
      - need to wait another week before closing it


    Open questions (opened, questions and not assigned)

/

    For later (opened and not assigned assigned)

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

  286  Make MPTCP_PM_CMD_SET_FLAGS usable with the userspace PM [bug]
@kmaloor
  285  PM: in-kernel: support for MPC prio exchange  [enhancement] @pabeni



New issue:
    - connect after a disconnect for a passive socket:
        - it fails because the socket created after an accept() on an
MPTCP has the "struct socket" missing for the first subflow.
        - idea: allocating a new "struct socket" at the disconnect:
            - but then you can have error like ENOMEM at the disconnect
time, quite unexpected
        - TODO: Matth: create a new issue → Done #290



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.20/6.0):
https://github.com/multipath-tcp/mptcp_net-next/projects/15
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - Fixes for other trees: /


    - Fixes for -net:

        - [42508b96a48a] mptcp: fix subflow traversal at disconnect time
(Paolo Abeni)
        - [044267b6fa0d] selftests: mptcp: validate userspace PM tests
by default (Matthieu Baerts):
            - can be sent when we want, they look ready

    - Fixes for net-next: /


    - Features for net-next:

        - [03c51e782a06] mptcp: move MPTCPOPT_HMAC_LEN to net/mptcp.h
(Geliang Tang)

        - [5be7e6897613] selftests: mptcp: tweak simult_flows for debug
kernels (Paolo Abeni)

        - [e7550dbe1f1f] selftests: mptcp: userspace pm address tests
(Geliang Tang)
        - [31e0a2665303] selftests: mptcp: userspace pm subflow tests
(Geliang Tang)
        - [5e49440cf0f7] selftests: mptcp: avoid Terminated messages in
userspace_pm (Geliang Tang)
        - [6194033c6e06] selftests: mptcp: update pm_nl_ctl usage header
(Geliang Tang)

        - [e789ddd7149a] mptcp: introduce and use mptcp_pm_send_ack()
(Paolo Abeni)
        - [60ab7f841e5e] mptcp: address lookup improvements (Paolo Abeni)
        - [109d191a7d3b] mptcp: allow the in kernel PM to set MPC
subflow priority (Paolo Abeni)
        - [bc86e874b1de] mptcp: more accurate MPC endpoint tracking
(Paolo Abeni)
        - [aa75b3a86f48] selftests: mptcp: add MPC backup tests (Paolo
Abeni):
            - this can be sent after net / net-next sync

    - Features for net-next (next): /


    - Features for other trees:

        - [2c3c53bffda5] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [65e050e8cc03] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [f59eed3f6f6f] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [b8fb7d71c728] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [f39b0566adcd] mptcp: add get_subflow wrappers (Geliang Tang)
        - [7aa574da24d1] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [3b4bbeafee20] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [fd9edcf1c282] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [1170bfd3cfdc] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [3d71bfa2d5b5] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [dc5e8afc56bf] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [b177d0924b7f] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [3efcf9c7f137] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [a75c85c1d282] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - can wait


Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - Issue 288 still happening
        - Nothing else

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - getting better, mainly issues with simult_flows but a patch
has been recently applied to address that

    - packetdrill (Davide):
        - Paolo added a new test

    - Patchew (Davide):
        - /

    - CI (Matth):
        - We have now less frequently some issues with simult_flows
tests, only with the non debug kernel:
            # unbalanced bwidth with opposed, unbalanced delay - reverse
directiontransfer slower than expected! runtime 4022 ms, expected 4005
ms max 4005        [ fail ]
        - Idea is to check how frequently we have such issues because
doing more analysis and maybe increasing thresholds



Backup plans for extended maintainer leave:
    - Plans for patch review, upstreaming, CI, and meetings if Mat or
Matt are away or unavailable
    - Could be good to have another person having rights to push stuff
    - TODO: Matth: document how to apply patches → using scripts from
"scripts" branch
        -> done:
https://github.com/multipath-tcp/mptcp_net-next/tree/scripts/utils#readme=
    - probably best to send an email to -net maintainers to warn them
about who is going to send patches



Git tag when applying patch:
    - for the moment, the SoB of the sender is moved to the end, e.g.:
        - Alice is sending a patch, we have:
            Fixes: abc123 ("init commit")
            Signed-of-by: Alice <alice@foo>
        - Mat reviews it after, once applied, we have:
            Fixes: abc123 ("init commit")
            Reviewed-by: Mat <mat@bar>
            Signed-of-by: Alice <alice@foo>
    - should we keep the chronological order?:
            Fixes: abc123 ("init commit")
            Signed-of-by: Alice <alice@foo>
            Reviewed-by: Mat <mat@bar>
        → OK and make sense to have the chronological way
    - For the moment, Mat removes his RvB tag and adds his SoB:
        - It is important to have the SoB at the end.
        → Having the RvB + SoB should not be a problem



Applying patches:
    - Add "Link" to MPTCP discussion/review/CI results?:
        - no: should not be needed, we can use lore and search using the
title, it works well



Git pages:
    - we can start using mptcp.dev
    - we can then have a dedicated page for that
    - we need a branch in a repo



Next meeting:
    - Next one on Thursday, the 14th of July.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220714



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
