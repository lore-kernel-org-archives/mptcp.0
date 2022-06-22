Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DA41843
	for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 16:24:03 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id ge10so3852145ejb.7
        for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 09:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=PMR4uJSBTnYGUGr1d8t+TE1Wr2k5ECJbNFhGmFe6lKo=;
        b=VFEmw4zLhycqwadO8sqYhu5o4w+6icZKCW3tzCmpsIPftLkvhXY5/f1iYMVEUAKRsL
         xb71myKYCERlAicNijMQNcnr/UUSmPju+LqmK+6raUDhf3QweGwPHCNcHKF5cmWGqI4w
         SPkOhBPZ53z3SgmWBuFH+NuXDgFCxxff+U0LZFmhjFnI/MqkJKzz4zwQPbHRoV9xwi/i
         M61xmd7Za4IHrkJPGCmVo5DhrDVC4KqRQvR3W9Acy4wKRHAEHPa7p/K/1iNljnsOAu8t
         mS3mnxHhRFYzZFQJTzYAHWtv8lnSIf80vFjQQN5EJndg0Zn+UFyq3ED1BXeTmziULFfg
         j+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=PMR4uJSBTnYGUGr1d8t+TE1Wr2k5ECJbNFhGmFe6lKo=;
        b=MYB7KGOjSk0BdEbiYZHlkasYqIUc5sHbfIy4JzqRon77s9gP2hPJfSo8oRAVTDLDsA
         Hci79DDqVkUA+XhiE/K3jjN01SR/26GBhPSqs3Rgf78fiq8AY8gvoJslZ8xWPiJTY3n+
         zvf6zlr/0LW61+ePZ3b+IpaOty7vOkL+Vpj9KxRbWunFwqaIZ2jATwW0jmoIA5vzgecC
         /tYzl7nNeER34sHL6NRO0jqE1C957wQG5+QUpssiapL3fx6QnIuRVfjnWn7MVJd00dpi
         zcmKkbA3bbjDFgV7fesKCJ/2utYVH60KyYiPvchOntR9hdXoNLBqXQfuDiBrqIMRLEmg
         XxZQ==
X-Gm-Message-State: AJIora9mbCPW6VpHQoa7tmqBNmF53eCp9rcGnn0zxvgkiShfC6vXj27o
	of/xQoYuXhNS65AmHS+kj8v+Ns2wE5RmIg==
X-Google-Smtp-Source: AGRyM1uVNejxIgE3X6iLGVO3C9XZCimgPPBNCwr9tZg7EdI/G4033KHnv6rt9tWwuA4VHtxtdz84ew==
X-Received: by 2002:a17:907:3e11:b0:722:b107:11d0 with SMTP id hp17-20020a1709073e1100b00722b10711d0mr3816732ejc.612.1655915038900;
        Wed, 22 Jun 2022 09:23:58 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:be6d:1e8:59dc:6fb6? ([2a02:578:8593:1200:be6d:1e8:59dc:6fb6])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d554000000b0042a2d9af0f8sm15209592edr.79.2022.06.22.09.23.57
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 09:23:58 -0700 (PDT)
Message-ID: <136b91b5-33ea-662f-26b6-efb19e39675c@tessares.net>
Date: Wed, 22 Jun 2022 18:23:57 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 9th of June 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 198th meeting with Mat, Ossama (Intel), Paolo,
Davide (Redhat), Geray (Parkyeri) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang):

12874730  [mptcp-next,v4,2/2] mptcp: trace MP_FAIL subflow in mptcp_sock
12874728  [mptcp-next,v4,1/2] mptcp: refactor MP_FAIL response timeout:
    - it looks like the worker might not be launched reliably (maybe
~2%) → reset timer got removed
    - reuse MPTCP socket timer to catch up when a worker has not been
launched
    - similar to what is done in TCP timer side
    - Squash-to patch needed.
    - Paolo might be able to look at that next week if no one else had
to chance to do that before (patches in review)

12870186  [mptcp-next,3/3] Squash to "selftests/bpf: Add bpf_rr test"
12870185  [mptcp-next,2/3] Squash to "selftests/bpf: Add bpf_bkup test"
12870184  [mptcp-next,1/3] Squash to "selftests/bpf: Add bpf_first test"

12867508  [mptcp-next,v7,13/13] selftests/bpf: Add bpf_rr test
12867507  [mptcp-next,v7,12/13] selftests/bpf: Add bpf_rr scheduler
12867506  [mptcp-next,v7,11/13] selftests/bpf: Add bpf_bkup test
12867505  [mptcp-next,v7,10/13] selftests/bpf: Add bpf_bkup scheduler
12867504  [mptcp-next,v7,09/13] Squash to "selftests/bpf: add bpf_first
test"
12867503  [mptcp-next,v7,08/13] Squash to "selftests/bpf: add bpf_first
schedul...
12867502  [mptcp-next,v7,07/13] selftests/bpf: Add mptcp sched structs
12867501  [mptcp-next,v7,06/13] bpf: Add bpf_mptcp_sched_kfunc_set
12867500  [mptcp-next,v7,05/13] Squash to "mptcp: add bpf_mptcp_sched_ops"
12867499  [mptcp-next,v7,04/13] Squash to "mptcp: add get_subflow wrappers"
12867498  [mptcp-next,v7,03/13] mptcp: add scheduled in
mptcp_subflow_context
12867497  [mptcp-next,v7,02/13] Squash to "mptcp: add sched in mptcp_sock"
12867496  [mptcp-next,v7,01/13] Squash to "mptcp: add struct
mptcp_sched_ops":
    - Paolo would like to have a look at this series:
        - it looks like we might traverse all subflows linked to a
connections a few times even if it is not needed
        - for the "default" case, we should avoid these traversals
        - (BPF code should not impact the "default" behaviour)
        - another optimisation has been removed, might be good to remove
it only for BPF
        - may be good to rework how the scheduler architecture before
going further
    - (on the bright side, it is good the patches are there and we can
change stuff while easily checking everything is still working as expected)



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12874585  [net-next,2/2] mptcp: move MPTCPOPT_HMAC_LEN to net/mptcp.h
12874584  [net-next,1/2] mptcp: fix conflict with <netinet/in.h>


    our repo (by: Dmytro SHYTYI, Geliang Tang, Jiapeng Chong, Matthieu
Baerts):

12282219: RFC: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to
tcp.h/mptcp.h
12282221: RFC: [RESEND,RFC,4/4] tcp: parse tcp options contained in
reset packets
12282223: RFC: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support
12282225: RFC: [RESEND,1/5] tcp: make two mptcp helpers available to tcp
stack
12282227: RFC: [RESEND,5/5] mptcp: send fastclose if userspace closes
socket with unread data
12321111: RFC: mptcp: Remove redundant assignment to remaining:
    - RFC

12858306: Changes Requested: [RFC,mptcp-next,v3] mptcp: Fast Open Mechanism:
    - Some discussions with the timestamps but also the mapping
    - Not really functional from the MPTCP point of view
    - Some special code needed on the MSK side to deal with these data
in the SYN

12870447: Changes Requested: [mptcp-next,v5,1/7] Squash to "mptcp: add
get_subflow wrappers"
12870448: Changes Requested: [mptcp-next,v5,2/7] mptcp: redundant
subflows push pending
12870449: Changes Requested: [mptcp-next,v5,3/7] mptcp: placeholder for
subflow_push_pending
12870450: Changes Requested: [mptcp-next,v5,4/7] mptcp: add
sched_get_retrans wrapper
12870451: Changes Requested: [mptcp-next,v5,5/7] mptcp: redundant
subflows retrans support
12870452: Changes Requested: [mptcp-next,v5,6/7] selftests/bpf: Add
bpf_red scheduler
12870453: Changes Requested: [mptcp-next,v5,7/7] selftests/bpf: Add
bpf_red test:
12871207: Changes Requested: [mptcp-next] Squash to "mptcp: redundant
subflows retrans support" v5
    - v5 of "BPF redundant scheduler"

12874836: New: [mptcp-next] Squash to "selftests/bpf: Add bpf_first test":
    - some clean-up



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 279)

  282  selftests: `simult_flows`: failing with debug kernel: transfer
slower than expected [bug] [selftests]:
      - 450ms:
          - it is linked to mptcp_connect does a few sleep
          - to allow additional subflows to be created
          - + a few more ms
          - it should not be needed to wait more because we wait for the
2nd subflow to be connected
      - or not run this test with a debug kconfig? it already support
slow transfers but here we are super slow
      - it could be interesting to measure the usual time we get to see
the distribution and increase the time just for debug kconfig

  280  support of ndiffport [question]:
      - either announcing the same IP with a different port
      - or netlink PM to create multiple subflows to the same IP but
different ports but we also need to open listen sockets
      - could be nice to have an mptcpd ndiffport plugin :)


    Bugs (opened, flagged as "bug" and assigned)

  264  selftests: diag: failing on the public CI with the new
debug.config [bug] [selftests] @matttbe:
      - TODO: try to reproduce it → not OK locally

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug] @mjmartineau:
      - the priority got reduced but if needed, can be discussed


    Bugs (opened and flagged as "bug" and not assigned)

  282  selftests: `simult_flows`: failing with debug kernel: transfer
slower than expected [bug] [selftests]

  279  [syzkaller] Warning in icsk_get_port [bug] [syzkaller]:
      - it looks like there is something to do on MPTCP code
      - after having applied the v1 patch, the warning has been seen
only once
      - on the upstream side, there are still some bugs there around the
locking side, more work needed and quite hard to reproduce
      - maybe causing the single warning Mat saw
      - probably best to wait

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


    For later (opened and not assigned assigned)

  280  support of ndiffport [question]
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

  281  selftests: join: `Infinite map` (95) is failing with a debug
kernel: userspace error [bug] [selftests] @geliangtang
  276  <linux/mptcp.h> conflict with <netinet/in.h> in C library [bug]



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.20/6.0):
https://github.com/multipath-tcp/mptcp_net-next/projects/15
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - Fixes for other trees: /

    - Fixes for -net:

        - [1c60f24cb2a5] mptcp: invoke MP_FAIL response when needed
(Geliang Tang):
            - Recently applied
            - There will be a Squash-to patch for fix an issue, see above

    - Fixes for net-next:

        - [a95484faf5da] mptcp: fix conflict with <netinet/in.h> (Ossama
Othman):
            - sent, in review upstream

    - Features for net-next:

        - [4af562ddbbb1] mptcp: move MPTCPOPT_HMAC_LEN to net/mptcp.h
(Geliang Tang):
            - sent, in review upstream

    - Features for net-next (next): /

    - Features for other trees:

        - [4daf3d747cc0] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [eaa6a27fa969] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [728c1107887f] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [d6e834993498] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [8907ce414e3c] mptcp: add get_subflow wrappers (Geliang Tang)
        - [94260f8ab147] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [71e1ac1b8e6e] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [abbcd58e8175] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [49153fb815cb] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [9880ce6ad1dd] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [cbcc76ae580a] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [97a6d924f9cb] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [eb49a09a9182] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [eab5d98e92ee] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - can wait, still some open discussions upstream


Patches from upstream:
    - One series from Eric:
        -
https://patchwork.kernel.org/project/netdevbpf/list/?series=648713&state=*&archive=both
        - net: reduce tcp_memory_allocated inflation
        - It will probably be applied soon
        - there are still some stuff to do on the MPTCP side:
            - see patch 6/7:
                - Removal of SK_RECLAIM_CHUNK and SK_RECLAIM_THRESHOLD
is left to MPTCP maintainers as a follow up.
                -
https://patchwork.kernel.org/project/netdevbpf/patch/20220609063412.2205738-7-eric.dumazet@gmail.com/
        - best to wait for it to be applied before proposing other stuff
        - Mat will create an issue for that


Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - Focusing on the WARN, see above, ticket 279

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - Find same intermittent failure as what has been reported by
the public CI

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - Still alive
        - WebUI: Can be a bit slow but we have to deal with that :)

    - CI (Matth):
        - /



TopGit Tree:
    - currently net is sync with upstream only when net-next has been
sync with net upstream
    - we did that to reduce conflicts in code we don't maintain
    - but maybe not a source of issue
    - TODO: Matth: we can try to turn this one and abort if we see it
takes us time → Done



Cross platforms:
    - use CONFIG_TUN_VNET_CROSS_LE?
         -> This option allows TUN/TAP and MACVTAP device drivers in a
little-endian kernel to parse vnet headers that come from a big-endian
legacy virtio device.
         -> Userspace programs can control the feature using the
TUNSETVNETBE and TUNGETVNETBE ioctls.
     - not a lot of doc about it
     - could it help to setup VM to detect LE/BE issues?



Netdev:
    -
https://netdevconf.info/0x16/news.html?netdev-0x16-call-for-submissions
    - Important dates:
        Closing of CFS: Wed, Sept. 7, 2022
        Notification by: Thu, Sept. 15, 2022
        Conference dates: Oct 24th - 28th, 2022
    - For plumbers:
        eBPF & Networking Proposals (Open)
        Submissions close: August 10, 2022 - Speakers notified: from
August 12, 2022



Next meeting:
    - Next one on Thursday, the 23rd of June.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220623



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
