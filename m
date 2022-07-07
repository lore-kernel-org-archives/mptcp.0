Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012B7C
	for <mptcp@lists.linux.dev>; Thu,  7 Jul 2022 14:57:05 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id h23so32835391ejj.12
        for <mptcp@lists.linux.dev>; Thu, 07 Jul 2022 07:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=NaabpgjyAM/+BkG4E9TtEj/KF5n1jwQZ3zTPeXVk1O0=;
        b=SOpxZjdcV1aiF2GurwXHO/g6MQbEPiMwSEGWWnxi8YrpBRXB/hqVouaMe1ANxTe/Fg
         UcHbiHl0uLVz3qwvS/+9b88Ng6PWPPq8okdTFHT9cUM46J5N+4RZzIdofifmY2SKJcTT
         UWTPgmg9YR8y0jxIBg3eB6/pq9adoTTGTE5iFOVZRe+0solQnNxu+VUTCRoKmqDvY5Y7
         FwM05u+KDsJCx1gTlBBJ8sGdQ322yhokByLoAIModdMjLUkINdtIhjY/LUWIBdBCPhJC
         HDSFPaqQy9GiFgBEu1tZD2Epl+WuePPtnxC97rc87WmQc5B8rsTyYFDVtBcspfxCv5aG
         mbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=NaabpgjyAM/+BkG4E9TtEj/KF5n1jwQZ3zTPeXVk1O0=;
        b=l4rauCKv7x7Qu2FX+1Qz1NbZh8y6REVwEKc9uyG35B5u+CNpUoUZAk4bp1e6RdC+Es
         p4U8pVdsmcyi9X0+N8MAI+fA3E31Bpfokqo2RzQNOiZMwH2zLfxDMcXVbq8oVHqCgovg
         9i0gTGPYN9y+MbZWIgUA/EnVxCKo555b4d/912VRUzZrI9t6zd8zAu69GwOD0iSL11ar
         P/MGJpOH0dOEWhYtO+oj+KIdLxGkqVB4Y6gHMKqsNyckn6hmeHS2304wI5ikRw061XXE
         aAKSl76AvucUV3dW9dZJneDwQZlaSfa5m4h+5Bg8W3fZYN3xEX6XaUMzwGlIH2s37RyB
         LWYQ==
X-Gm-Message-State: AJIora+/NaogBY7ALkdCIkQqCe1ZnxHauDRbitYssTaeFgYC05tymH5L
	fSl8YT9OYecR+LX+V+cq/jQzU/9NVQk6Jw==
X-Google-Smtp-Source: AGRyM1sXfMBN+RU9mJ6Uin6rgZQ3V8dv/BD47VOMFX99GucuIhn7Kk6B3asUvylU6dnl15Ikz/YNlQ==
X-Received: by 2002:a17:906:4f:b0:712:af2:29d9 with SMTP id 15-20020a170906004f00b007120af229d9mr46179540ejg.751.1657205823842;
        Thu, 07 Jul 2022 07:57:03 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906671200b00718e4e64b7bsm19027526ejp.79.2022.07.07.07.57.03
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 07:57:03 -0700 (PDT)
Message-ID: <4cbf0e85-e9c9-79fd-9d4d-a5e2a01ad57b@tessares.net>
Date: Thu, 7 Jul 2022 16:57:03 +0200
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
Subject: [Weekly meetings] MoM - 30th of June 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 200th meeting with Mat, Ossama (Intel), Paolo
and Davide (Redhat), Giray (Parkyeri) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau, Menglong Dong):

12896557: [net-next] net: mptcp: fix some spelling mistake in mptcp:
      - Submitter: Menglong Dong
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220627121626.1595732-1-imagedong@tencent.com/

12897433: [net,1/9] mptcp: fix error mibs accounting
12897434: [net,2/9] mptcp: introduce MAPPING_BAD_CSUM
12897437: [net,3/9] mptcp: invoke MP_FAIL response when needed
12897435: [net,4/9] mptcp: fix shutdown vs fallback race
12897436: [net,5/9] mptcp: consistent map handling on failure
12897438: [net,6/9] mptcp: fix race on unaccepted mptcp sockets
12897439: [net,7/9] selftests: mptcp: more stable diag tests
12897440: [net,8/9] mptcp: fix conflict with <netinet/in.h>
12897441: [net,9/9] selftests: mptcp: Initialize variables to quiet gcc
12 warnings:
      - Series: mptcp: Fixes for 5.19
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=654372&state=*&archive=both


    our repo (by: Paolo Abeni):

12896474: [mptcp-net] mptcp: fix locking in mptcp_nl_cmd_sf_destroy():
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/886e059dc9096dcc9e1daa1eb1a07ec34d72aa74.1656323519.git.pabeni@redhat.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12874585: [net-next,2/2] mptcp: move MPTCPOPT_HMAC_LEN to net/mptcp.h:
      - Series: mptcp: Header fixups
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=648618&state=*&archive=both


    our repo (by: Dmytro SHYTYI, Geliang Tang, Jiapeng Chong, Kishen
Maloor, Mat Martineau, Matthieu Baerts, Paolo Abeni):

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

12858306: [RFC,mptcp-next,v3] mptcp: Fast Open Mechanism:
      - State: Changes requested
      - Submitter: Dmytro SHYTYI
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220522183921.103526-1-dmytro@shytyi.net/

12894869: [RFC,1/4] mptcp: fix local endpoint acconting.
12894867: [RFC,2/4] mptcp: introduce and use mptcp_pm_send_ack()
12894866: [RFC,3/4] mptcp: allow the in kernel PM to set MPC subflow
priority
12894868: [RFC,4/4] mptcp: more accurate MPC endpoint tracking:
      - State: RFC
      - Series: mptcp: let the in kernel PM control the MPC
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=653658&state=*&archive=both
      - Need to be rebased on top of Mat's series + selftests

12897143: [mptcp-next] Squash-to: "selftests: mptcp: tweak simult_flows
for debug kernels":
      - State: Changes requested
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20220627214438.17887-1-mathew.j.martineau@linux.intel.com/
      - seems the additional time added in the original patch is not enough
      - we would need +550 ms at least
      - maybe best to skip?
      - When?:
          grep -q ' kmemleak_init$\| lockdep_init$\| kasan_init$\|
prove_locking$' /proc/kallsyms
      - it might be good to continue execute it but accept more delay (1
sec) or any delay
      - Mat will send a v2 with:
          - a new check to detect more kdebug options
          - +500ms
          - + a comment why :)
          - → Done

12899137: [mptcp-net,v4,1/2] mptcp: netlink: issue MP_PRIO signals from
userspace PMs
12899138: [mptcp-net,v4,2/2] selftests: mptcp: userspace PM support for
MP_PRIO signals:
      - State: Queued
      - Series: mptcp: support MP_PRIO signals with userspace PMs
      - Submitter: Kishen Maloor
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=654814&state=*&archive=both

12900760: [mptcp-net,v3,1/2] mptcp: Avoid acquiring PM lock for subflow
priority changes
12900761: [mptcp-net,v3,2/2] mptcp: Acquire the subflow socket lock
before modifying MP_PRIO flags:
      - State: New
      - Series: Locking fixes for subflow flag changes
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=655189&state=*&archive=both
      - Probably one function that can be made static and no longer
exported:
          - but the situation is different on the export and export-net
branches → it could be static but just for export-net
          - probably some cleaning can be done on net-next only
        - So the patches can be applied as they are with Paolo's ACK →
@TODO Matth, done

12901431: [mptcp-next,v10,1/5] Squash to "mptcp: add get_subflow wrappers"
12901432: [mptcp-next,v10,2/5] mptcp: redundant subflows push pending
12901433: [mptcp-next,v10,3/5] mptcp: redundant subflows retrans support
12901434: [mptcp-next,v10,4/5] selftests/bpf: Add bpf_red scheduler
12901435: [mptcp-next,v10,5/5] selftests/bpf: Add bpf_red test:
      - State: New
      - Series: BPF redundant scheduler
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=655328&state=*&archive=both
      - CI has still issues with this series:
          - linked to msk->recovery in __mptcp_clean_una()
          - Geliang cannot reproduce this issue on his side
          - the CI can with or without debug mode:
              - https://cirrus-ci.com/task/5934869556494336
              -
https://api.cirrus-ci.com/v1/artifact/task/5934869556494336/summary/summary.txt

12901688: [mptcp-next] Squash to "bpf: Add bpf_mptcp_sched_ops":
      - State: Queued
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/9ab93a02e7bf2ea1b2cfd40ce9e2001970d2e890.1656586148.git.geliang.tang@suse.com/
      - can be applied



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 287)

/


    Bugs (opened, flagged as "bug" and assigned)

  286  Make MPTCP_PM_CMD_SET_FLAGS usable with the userspace PM [bug]
@kmaloor:
      - linked to patches above

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug] @mjmartineau


    Bugs (opened and flagged as "bug" and not assigned)

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

  284  combine to WAN's via two Wiregate Connections [question] @matttbe


    Open questions (opened, questions and not assigned)

  285  Excluding the initial connecting interface? [question]:
      - 286: same but for userspace PM
      - 285: for in-kernel PM:
          - patches for the in-kernel PM have been already shared by Paolo
      - TODO: Matth: convert to "new feature" + change description /
title → patches are now merged


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

  287  selftests: `mptcp_join.sh`: `userspace pm add & remove address`:
WARNING `sock_owned_by_me()` in `mptcp_sched_get_send()` [bug]
[selftests] @pabeni
  280  support of ndiffport [question]
  279  [syzkaller] Warning in icsk_get_port [bug] [syzkaller] @mjmartineau



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.20/6.0):
https://github.com/multipath-tcp/mptcp_net-next/projects/15
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees: /


    - Fixes for -net:

        - [3724ee5c6959] mptcp: fix locking in mptcp_nl_cmd_sf_destroy()
(Paolo Abeni):
            - can wait 4 others patches that are in review (it is linked)

    - Fixes for net-next: /


    - Features for net-next:

        - [9d5e3ef3333a] mptcp: move MPTCPOPT_HMAC_LEN to net/mptcp.h
(Geliang Tang):
            - can be sent

        - [bb1781de99b7] selftests: mptcp: tweak simult_flows for debug
kernels (Paolo Abeni):
            - a Squash to patch is in review

        - [322dadaef4a2] mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy
(Geliang Tang):
            - should be sent to -net

        - [f925b5c4e251] selftests: mptcp: userspace pm address tests
(Geliang Tang)
        - [329a37a07c73] selftests: mptcp: userspace pm subflow tests
(Geliang Tang)
        - [4426b9510075] selftests: mptcp: avoid Terminated messages in
userspace_pm (Geliang Tang)
        - [7d41a3d5d862] selftests: mptcp: update pm_nl_ctl usage header
(Geliang Tang):
            - depend on MIB_RMSUBFLOW patch, above that will be sent to -net

        - [e39801b483d9] mptcp: never fetch fwd memory from the subflow
(Paolo Abeni)
        - [5b0d367ff6f5] mptcp: drop SK_RECLAIM_* macros (Paolo Abeni)
        - [1f072d520c01] mptcp: refine memory scheduling (Paolo Abeni)
        - [ffdc3e830c0d] net: remove SK_RECLAIM_THRESHOLD and
SK_RECLAIM_CHUNK (Paolo Abeni):
            - patches from Eric are OK but they required other
modifications in cgroup mm part
            - (regression in sctp but also observable with TCP so Eric
will make sure the regression will be addressed)
            - so it is OK to send this series now


    - Features for net-next (next): /


    - Features for other trees:

        - [4f7bb97a1bed] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [0734088014f1] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [abdc794bb77a] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [38a7d8db07b6] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [5f37e33930ba] mptcp: add get_subflow wrappers (Geliang Tang)
        - [d574e5c23e78] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [a96845d459fa] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [b541ac7771ab] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [c30881717ac5] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [1d7ff4887cec] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [5ea7997dc2c3] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [745db70aff85] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [810d6db52294] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [498a72e9298b] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - patches linked to that in review
            - best to wait then



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - anything related to MPTCP
        - there is a leak in netlink create, not fully clear it is
linked to MPTCP
        - *@Mat* will share the report on the ML (or a ticket because it
is quite big)

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - Issues with simult_flows.sh, patches addressing that is in review

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - web backend is down (thanks mjm for reporting).
        - Will follow-up with the core team ASAP
        - the importer is still working, sending tags so that's good, we
have results from the CI

    - CI (Matth):
        - some issues with mptcp_joins but not visible on other CI:
            - to be monitored
        - some updates in scripts not to depend on pwclient but git-pw


mptcpd-0.10 for Fedora (rawhide and maybe f36):
    - build issue addressed by Mat in ML
(https://lore.kernel.org/mptcp/20220608191919.327705-1-mathew.j.martineau@linux.intel.com/)
    - backported to rawhide with a quick workaround for kernel-headers
causing FTBFS
(https://src.fedoraproject.org/rpms/mptcpd/pull-request/9#request_diff)
    - the configure checks which kernel headers to use but internal
files need to be updated
    - ell: there are some selftests in dev mode that are failing due to
OpenSSL v3 → known issue:
        - can be an issue for packaging
        - Mat sent a patch one month ago, merged 2 days ago, not in a
new version yet:
            -
https://git.kernel.org/pub/scm/libs/ell/ell.git/commit/?id=4bd98af1f295b62227a6bc7f94649eb663c0b9c1
    - Matth will look at updating the debian packages and ask to apply
it to stable versions as well


Linux Plumbers draft proposal:
    -
https://lore.kernel.org/mptcp/78ff1ebd-f440-9dd0-256-abf3345e6d3@linux.intel.com/T/#u
    - Talking about the new extension → what's new in MPTCP
    - might be good to get a more "questionary like" proposal:
        - there are still some open questions related to BPF
        - in-kernel API stability and evolution for BPF → MPTCP would be
here like a use-case
        - Mat will check at updating the proposal on this aspect
    - TODO: Matth: check what we can do with mptcp.dev name → done



Next meeting:
    - Next one on Thursday, the 7th of July.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220707



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
