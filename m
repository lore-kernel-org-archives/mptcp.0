Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C1D70
	for <mptcp@lists.linux.dev>; Thu, 13 May 2021 16:29:32 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id v5so20565203edc.8
        for <mptcp@lists.linux.dev>; Thu, 13 May 2021 09:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=qxnQ4eDCENXUdLz8WpjdTd7wrdEFBcp0Tl/h3JUvPxM=;
        b=Xfa8h3xVBYa48pb9x2VjHgcIqpAqmAHuG5pAcWRheI5a71iwQyQvccmQBoXvU/Ubhv
         EhVHPbkEmGoGbLol2H1/iZa0XJVW6hxL7tA+MYZNxgtI1rGJAk/l/9EquecqhhovLQjR
         0Nwnpa84FQVMNCiUFnh0xjRuiEPAiDHaXZpkuBorjG2i5I8/HfJ6gXw7hWY+GCHEDZXn
         I79fQ6Qm+ZQwpObmv3eW5WNIpBGQmDGpWGAITZaG7w1bDezzq4Db5XQcx/MAOTGAa5ZB
         KZEK/YqkwElmm4cmwmKfBDzQ0Cmu8m42MHcJy0TQ+dMd7tKfozBRRVUV+JV5LmW1o3p4
         AfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=qxnQ4eDCENXUdLz8WpjdTd7wrdEFBcp0Tl/h3JUvPxM=;
        b=euh9OG/Ly8y58XzdEhIIccEToahLF1TIAi9MpdHd0npMsGMzJvGHgi6LpT+ZqqPeb9
         v82lhR9cnrmFHoe2sTUWzqsT50CfKY0nLLfsqtWzc1R2kHvO34Rjwpx4TMu4uOSaIcB0
         sQpbnqiDvLpoT35N5EYN0yoRUsm0GNMP8Rp2y8V44dkL1Ca4r47RaHSFwUfE11aJ9MCL
         gpbIWeTg6XJYBAxBe+xHPOh+RtvhH3qwxJJx33KvAWJd6YdnlkXFy4w13P2tUNSqSgUB
         PrIZpIjV7ZrtPeV2qvElU/2MsB+RSdSOchzx1EpcY8SYkazgn+jWOfZW9uN3d7GIgPCE
         7MkA==
X-Gm-Message-State: AOAM5306wJZq4akcSTMPMML9N5ws0GeW7EO3LTpV8wwCBfMK8Hq0NvuA
	QXVscm2vAK84Il6ezIicFyP53XinH6pDxxfK
X-Google-Smtp-Source: ABdhPJy84U6puvBWORZTAlp3BgogA4iGWJXwXo54cFhU+84AvXVeWfXr7n1iy+eYIj/RdB+AO8FkzA==
X-Received: by 2002:a05:6402:14c2:: with SMTP id f2mr510224edx.69.1620923370749;
        Thu, 13 May 2021 09:29:30 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:5b0c:2489:4b69:d7e2])
        by smtp.gmail.com with ESMTPSA id x9sm2711271edv.22.2021.05.13.09.29.30
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 09:29:30 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 13th of May 2021
Message-ID: <84426992-d161-ce7a-28c2-c578f521a96a@tessares.net>
Date: Thu, 13 May 2021 18:29:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hello everyone,

Today, we just had our 148th meeting with Mat (Intel), Christoph
(Apple), Paolo and Davide (RedHat), Jianguo and Yonglong (China Telecom)
and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Jianguo / Yonglong:
    - Welcome!
    - From China Telecom
    - Interested by MPTCP for CDN nodes
    - Thank you for contributing and participating at this meeting which
is also very late for you!



Reminder: workflow:
    - people can send patches to our ML (mptcp@lists.linux.dev)
    - patches are applied by Matth in our tree: "export" branch on Github
    - Status is updated on patchwork (ozlab: mptcp)
    - then validated by CI + tested by others
    - usually Mat sends them to netdev (if open)



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.ozlabs.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (Mat Martineau, Paolo Abeni):

1477252  [v2,net] mptcp: fix data stream corruption
1475271  [net] mptcp: fix splat when closing unaccepted socket


    our repo (by: Geliang Tang, Jianguo Wu, Paolo Abeni):

1477397  [mptcp-next] Squash to "mptcp: receive checksum for MP_CAPABLE
with d...
1475402  mptcp: generate subflow hmac after mptcp_finish_join()
1475350  [mptcp-next] Squash to "mptcp: generate the data checksum"
1475306  [mptcp-next] Squash to "mptcp: receive checksum for MP_CAPABLE
with d...
1475295  [mptcp-next] Squash to "mptcp: add csum_reqd in
mptcp_options_receive...
1475294  [mptcp-next] Squash to "mptcp: add sk parameter for
mptcp_parse_optio...
1475176  [mptcp-net] mptcp: avoid OOB access in setsockopt()



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.ozlabs.org/project/mptcp/list/?state=*

    netdev (if mptcp ML is in cc) (by: /):

/

    our repo (by: Davide Caratti, Florian Westphal, Geliang Tang):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets:
    - WIP

1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support
    - WIP

1395128: RFC: [1/5] tcp: make two mptcp helpers available to tcp stack
1395133: RFC: [5/5] mptcp: send fastclose if userspace closes socket
with unread data:
    - WIP

1474821: Changes Requested: [mptcp-next,1/3] mptcp: MP_FAIL suboption
sending
1474822: Changes Requested: [mptcp-next,2/3] mptcp: MP_FAIL suboption
receiving
1474823: Changes Requested: [mptcp-next,3/3] mptcp: send out MP_FAIL
when data checksum fail:
    - Reviewed by Mat
    - v2 is expected

1475381: Rejected: [mptcp-next] mptcp: don't fallback when data_fin enabled:
    - rejected because We don't want to send a reset in this case

1475835: Changes Requested: [v5,mptcp-next,1/5] mptcp: add sysctl
allow_join_initial_addr_port
1475836: Changes Requested: [v5,mptcp-next,2/5] mptcp: add
allow_join_id0 in mptcp_out_options
1475837: Changes Requested: [v5,mptcp-next,3/5] mptcp: add add_list in
mptcp_pm_data
1475838: Changes Requested: [v5,mptcp-next,4/5] mptcp: add deny_join_id0
in mptcp_options_received
1475839: Changes Requested: [v5,mptcp-next,5/5] selftests: mptcp: add
deny_join_id0 testcases:
    - series: "add MP_CAPABLE 'C' flag"
    - almost there, just one last small change to do related to the data
structure

1477138: Changes Requested: [v2,mptcp-next,1/8] mptcp: enable busypoll
from mptcp receive path
1477139: Changes Requested: [v2,mptcp-next,2/8] sock: expose
so_timestamp options for mptcp
1477140: Changes Requested: [v2,mptcp-next,3/8] sock: expose
so_timestamping options for mptcp
1477141: Changes Requested: [v2,mptcp-next,4/8] mptcp: sockopt:
propagate timestamp request to subflows
1477142: Changes Requested: [v2,mptcp-next,5/8] mptcp: setsockopt:
handle SOL_SOCKET in one place only
1477143: Changes Requested: [v2,mptcp-next,6/8] tcp: export timestamp
helpers for mptcp
1477144: Changes Requested: [v2,mptcp-next,7/8] mptcp: receive path cmsg
support
1477145: Changes Requested: [v2,mptcp-next,8/8] selftests:
mptcp_connect: add SO_TIMESTAMPNS cmsg support:
    - series: "add cmsg support to receive path"
    - the first patch needs to be modified but first finish the
discussions on this first patch
    - reviewed by Paolo

1477260: Under Review: [net] mptcp: validate 'id' when stopping the
ADD_ADDR retransmit timer:
    - reviewed by Mat
    - Davide will send a v2 to address Mat's comment



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 190)

  191  Could you please let me know how to use "ip mptcp end points
backup"?:
      - Question
      - Do we cover this case in selftests or packetdrill?
      - TODO: Matth: to reply


    Bugs (opened, flagged as "bug" and assigned)

  176  BPF selftest got "fallback to TCP" error [bug] @geliangtang:
      - everything OK there
      - just a "debug message" and we fallback for a good reason
      - close the ticket or send a patch to add comments to avoid
confusions?
      - TODO: Matth: check this


    Bugs (opened and flagged as "bug" and not assigned)

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]

  172  WARNING in sk_stream_kill_queues [bug]:
      - Assigned to Paolo
      - There is a patch, under test
      - Matth: send the error with the patch → Done

  137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable
[bug]
  120  [interop] netnext is dropping packets, causing MPTCP-level
retransmissions on mptcp.org [bug]
  107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]
   65  clearing properly the status in listen() [bug]
   56  msk connection state set without msk lock [bug]


    In Progress (opened and assigned)

  189  Wireshark / TCPDump doesn't understand option subtype 8
(MP_TCPRST) [enhancement] @dcaratti:
      - wireshark is done
      - tcpdump needs review / merge

  188  Netlink events for MP_TCPRST [enhancement] @dcaratti
  187  add recvmsg support for ancillary data [enhancement] @fw-strlen
  186  Add netlink command support [enhancement] @mjmartineau

  183  MP_CAPABLE 'C' flag is ignored [enhancement] @geliangtang:
       - Patches have been sent, new version expected

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti

  143  Packetdrill: ADD_ADDR for v6 only socket should only contain v6
addresses [enhancement] [packetdrill] @dcaratti:
      - can be closed soon

   96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe

   52  MP_FAIL support [enhancement] @geliangtang:
      - Patches have been sent, v2 expected


    Recently closed (since last week)

  182  [syzkaller] KASAN: slab-out-of-bounds Write in
tcp_init_congestion_control [bug] [syzkaller] @pabeni
  178  Server hang when proxying over multiple subflows [bug] [v5.11]
[v5.12] @pabeni
  134  Checksum support [enhancement] @pabeni
   53  MP_TCPRST support [enhancement] @fw-strlen



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.14):
https://github.com/multipath-tcp/mptcp_net-next/projects/9
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - net:
        - patches in our tree in the "fixes for net" section are either
already there or will be sent to net-next instead

    - net-next:
        - net-next is still closed
        - Mat will sent fixes first when net-next will re-open



Extra tests:
    - news about Syzkaller? (Christoph):
        - no new issues
        - Mat is running a new Syzkaller instance for when Christoph is
not available
        - some syscalls are ignored:
            - "disable_syscalls": ["perf_event_open", "syz_mount_image",
"syz_read_part_table", "openat$ttyprintk", "mount", "mkdir",
"openat$ptmx", "mq_open", "fsetxattr", "rt_tgsigqueueinfo",
"ioctl$VT_RESIZE", "ioctl$TIOCVHANGUP", "get_robust_list",
"openat$nullb", "ioctl$SCSI_IOCTL_SEND_COMMAND", "lremovexattr",
"mknod$loop", "write$binfmt_script", "syz_open_dev$sg", "write$nbd",
"prlimit64", "write$P9_RRENAMEAT", "fcntl$addseals", "finit_module",
"ioctl$KDSETMODE", "write$FUSE_NOTIFY_STORE", "ioctl$TIOC
                - *@Christoph* will send the rest on the ML
            - not all debug options needs to be turned on otherwise it
is too slow → share ideal .config?
            - Could be good to have a dedicated Wiki page about that

    - news about interop with mptcp.org? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - no failure but stop triggering recently
        - will check to re-start them

    - packetdrill (Davide):
        - might be good at some points to rewrite mptcp.c to fix some
core issues and make the code "upstreamable"
        - new repo or new branch → then later we can have "nice commits"
on top of the upstream branch

    - CI (Matth):
        - improve the README file of
https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
        - easier for people to use it
        - e.g. to have a ready to use environment to launch MPTCP
selftests or packetdrill
        - TODO: Matth: write in the Wiki page how to use the CI:
            - new branch on Github → start build
            - using cirrus-ci
            - later with patchew


Patchwork:
    - switching to kernel.org instance (see prev meeting)
    - who modified status in the ozlab instance?:
        - Paolo, sometimes
        - Mat is updating status
        - Matth but not everyday: status might not be marked as "changed
requested" directly.
        - → we need admin rights for Paolo, Mat, Matth
        - Applied patches are marked as so automatically with scripts
        - After each meeting, "old" patches are archived



Next meeting:
    - On Thursday, the 20th of May.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210520



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
